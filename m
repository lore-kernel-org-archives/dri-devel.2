Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C57C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176BD10F206;
	Fri, 31 Jul 2026 09:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U8uehyzE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 333B410F206
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:56:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCE9D43809;
 Fri, 31 Jul 2026 09:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831241F00A3D;
 Fri, 31 Jul 2026 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785491800;
 bh=Y8o35K4jEjq6BIKvBwUmQ2UHUAc2wzKdIZ8+i3Wns9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U8uehyzEYr8y620dgR/jQ6NLzBUAnGvb0ks+OnRS8BUOyvG0GeA1RN5v5MB8IkMyJ
 mbkZbtQbYMme/OW0HrAbWp/ns0r7nXK/f/12D/eTa85cYr2k28ERBjxzGLBtJ+W41I
 cGSv/EuLqAQPY+hm75YKYh/JDQmwAjRXo/cDfNIIJb6ritiyZjXYb/KUThaCEbkoQI
 Pxn7TP5+FkM+oq+3APEVnlx8shCNkRJ7Jr0jzavMZnF9AXNtphX5T3w7tm2mU3FbhE
 iw4yoVcY4SZZpaXAEPnmh9GhhKHAK1btIlwmP8cDXaFLBLDeRFv1gQ1WdcHyXUut74
 Uu4258i6XhYgw==
Date: Fri, 31 Jul 2026 11:56:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leander Kieweg <kieweg.leander@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
Message-ID: <20260731-manipulative-taipan-of-symmetry-e20afa@quoll>
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-3-kieweg.leander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730173643.256052-3-kieweg.leander@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2026 at 07:36:42PM +0200, Leander Kieweg wrote:
> +		if (ret) {
> +			drm_err(&gdev->drm, "Failed to request IRQ %d\n",
> +				gdev->irq);
> +			return ret;
> +		}
> +
> +		writel(INT_DONE, gdev->mmio_base + REG_IER);
> +		drm_info(&gdev->drm, "IRQ %d requested and enabled\n", gdev->irq);

Please drop

> +	} else {
> +		drm_warn(&gdev->drm, "No IRQ found, falling back to polling\n");
> +	}
> +
> +	ret = drm_dev_register(&gdev->drm, 0);
> +	if (ret)
> +		return ret;
> +
> +	drm_info(&gdev->drm, "GlandaGPU DRM Initialized (/dev/dri/cardX created)\n");

Please drop all such messages.

> +	return 0;
> +}
> +
> +/* Shared teardown, mirrors glanda_drm_init() */
> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +	drm_atomic_helper_shutdown(&gdev->drm);
> +
> +	/* Disable interrupts */
> +	writel(0, gdev->mmio_base + REG_IER);
> +
> +	drm_info(&gdev->drm, "GlandaGPU DRM Driver removed\n");

Ditto

> +}
> +
> +static int glandagpu_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct glanda_device *gdev;
> +	int irq;
> +
> +	dev_info(&pdev->dev, "GlandaGPU Probe started\n");

Ditto, Driver should be silent on success.

> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	platform_set_drvdata(pdev, gdev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	gdev->vram_phys = res->start;
> +	gdev->vram_base = devm_ioremap(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
> +	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
> +				       GLANDA_MMIO_SIZE);
> +	if (!gdev->vram_base || !gdev->mmio_base) {
> +		drm_err(&gdev->drm, "failed to ioremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq == -ENXIO)
> +		irq = -1;	/* no IRQ resource, fall back to polling */
> +	else if (irq < 0)
> +		return irq;
> +
> +	return glanda_drm_init(gdev, irq);
> +}
> +
> +static void glandagpu_remove(struct platform_device *pdev)
> +{
> +	glanda_drm_fini(platform_get_drvdata(pdev));
> +}
> +
> +/* Device Tree match table. */
> +static const struct of_device_id glanda_of_match[] = {
> +	{ .compatible = "glanda,gpu-1.0" },
> +	{ /* end of table */  }

Drop comment, obvious.

> +};
> +
> +MODULE_DEVICE_TABLE(of, glanda_of_match);
> +
> +static struct platform_driver glandagpu_driver = {
> +	.driver = {
> +		.name = "glandagpu",
> +	   .of_match_table = glanda_of_match,

Messed indent.

> +	},
> +	.probe = glandagpu_probe,
> +	.remove = glandagpu_remove,
> +};
> +
> +/* PCI probe path for the QEMU test device, real hardware uses platform_driver */
> +static int glandagpu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct glanda_device *gdev;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "GlandaGPU PCI Probe started\n");

Drop. Driver should be silent on success.

> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +	pci_set_master(pdev);
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(1), "glandagpu");
> +	if (ret)
> +		return ret;
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	pci_set_drvdata(pdev, gdev);
> +
> +	gdev->mmio_base = pcim_iomap_table(pdev)[0];
> +	gdev->vram_base = pcim_iomap_table(pdev)[1];
> +	gdev->vram_phys = pci_resource_start(pdev, 1);
> +
> +	return glanda_drm_init(gdev, pdev->irq);
> +}
> +
> +static void glandagpu_pci_remove(struct pci_dev *pdev)
> +{
> +	glanda_drm_fini(pci_get_drvdata(pdev));
> +}
> +
> +static const struct pci_device_id glanda_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
> +
> +static struct pci_driver glandagpu_pci_driver = {
> +	.name = "glandagpu-pci",
> +	.id_table = glanda_pci_ids,
> +	.probe = glandagpu_pci_probe,
> +	.remove = glandagpu_pci_remove,
> +};
> +
> +static int __init glandagpu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&glandagpu_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register platform driver\n");
> +		return ret;
> +	}
> +
> +	ret = pci_register_driver(&glandagpu_pci_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register PCI driver\n");
> +		platform_driver_unregister(&glandagpu_driver);
> +		return ret;
> +	}
> +
> +	pr_info("GlandaGPU: Module loaded successfully\n");

Drop. Kernel does not print such messages. It pollutes dmesg even
without actual hardware.


> +	return 0;
> +}
> +
> +static void __exit glandagpu_exit(void)
> +{
> +	pci_unregister_driver(&glandagpu_pci_driver);
> +	platform_driver_unregister(&glandagpu_driver);
> +	pr_info("GlandaGPU: Module unloaded\n");

Same here.

> +}
> +
> +module_init(glandagpu_init);
> +module_exit(glandagpu_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Leander Kieweg <kieweg.leander@gmail.com>");
> +MODULE_DESCRIPTION("DRM driver for GlandaGPU, an FPGA-based 2D GPU with VGA output");
> -- 
> 2.43.0
> 
