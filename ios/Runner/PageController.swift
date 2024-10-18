import Foundation
import UIKit
import PDFKit

class PDFPageCurlViewController: UIPageViewController, UIPageViewControllerDataSource {
    var pdfDocument: PDFDocument?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        // Load PDF Document
        if let url = URL(string: "https://www.sathyabama.ac.in/sites/default/files/course-material/2020-10/unit1.pdf") {
            pdfDocument = PDFDocument(url: url)
        }

        if let firstPage = viewControllerAtIndex(index: 0) {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }

    func viewControllerAtIndex(index: Int) -> PDFPageViewController? {
        guard let pdfDocument = pdfDocument, index < pdfDocument.pageCount else { return nil }
        let pdfPage = pdfDocument.page(at: index)

        let pdfPageViewController = PDFPageViewController()
        pdfPageViewController.pdfPage = pdfPage
        pdfPageViewController.pageIndex = index

        return pdfPageViewController
    }

    // UIPageViewController DataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let pdfViewController = viewController as? PDFPageViewController {
            var index = pdfViewController.pageIndex
            index -= 1
            return viewControllerAtIndex(index: index)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let pdfViewController = viewController as? PDFPageViewController {
            var index = pdfViewController.pageIndex
            index += 1
            return viewControllerAtIndex(index: index)
        }
        return nil
    }
}

class PDFPageViewController: UIViewController {
    var pdfPage: PDFPage?
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup PDFView
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoScales = true

        if let pdfPage = pdfPage {
            let document = PDFDocument()
            document.insert(pdfPage, at: 0)
            pdfView.document = document
        }

        self.view.addSubview(pdfView)
    }
}

