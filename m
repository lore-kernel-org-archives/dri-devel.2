Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8463C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E29C10F6A8;
	Fri, 14 Aug 2026 16:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YHQrOA3B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F9310F6A8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:59:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3910560008;
 Fri, 14 Aug 2026 16:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76841F00A3A;
 Fri, 14 Aug 2026 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786726747;
 bh=3yZSO07OihRO6yiyq1bI0AcAZt3Xm7VCe8hQ+eesyCU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YHQrOA3B9gdDBt4gog07uOq4SFNOIOVrYVsOeMRPtjBHq2YyFs8YXPGmbnixtZz9k
 FHOUxTY2DRDXkJp2/a+ZQulMABuVy096iu2/BqiZCDyqV7YLqQIcBHGdx6T5XE2UAy
 4sHjsOCZOfPy2O8m/Fp1osAQCJbzUsJH6sQ/V4ir1qkAB7Lg5jUMG9sXLUoBx3wUqM
 fOW3LlhCin5UyiQw7s+QCLBs8QzvBXLeiaV77hR4PPs29Dhr50+HQBqK/AzXI0MTdM
 wZrj4pU+c3/KvLwCREMekDrdDS6p5KDF1k3Fnn8eBiijba4559Q0qeJSwcOfrQw/oP
 B1ZROun3vT3Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: Add support for AI200 virtual functions
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260814164125.3652876-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:59:07 +0000
Message-Id: <20260814165907.C76841F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing pci_disable_sriov() in the physical function driver remova=
l path causes SR-IOV VFs to leak.
- [High] Device state check in qaic_pci_sriov_configure incorrectly blocks =
SR-IOV VF teardown when the device is offline or booting.
- [High] The aic200vf_config structure is never added to the qaic_ids PCI d=
evice ID table, preventing the driver from matching and binding to VF devic=
es.

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in MSI initialization error paths a=
fter a successful pci_alloc_irq_vectors() call.
--

--- Patch [1]: [PATCH] accel/qaic: Add support for AI200 virtual functions =
---
commit c554793b8689d7226dadc15db51370aa624d506a
Author: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

accel/qaic: Add support for AI200 virtual functions

Register the qaic_pci_sriov_configure callback to allow VFs to be
created through AIC200's sysfs numvfs entry. Additionally, define
a new MHI family for the 5 channels supported by AIC200 VFs: NNC,
Telemetry, IPCR, Loopback, and SSR.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 0acf6cdd44f81..cde8eb8c7a71b 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -77,6 +77,13 @@ static const struct qaic_device_config aic200_config =
=3D {
>  	.dbc_bar_idx =3D 2,
>  };
> =20
> +static const struct qaic_device_config aic200vf_config =3D {
> +	.family =3D FAMILY_AIC200_VF,
> +	.bar_mask =3D BIT(0) | BIT(1) | BIT(2) | BIT(4),
> +	.mhi_bar_idx =3D 1,
> +	.dbc_bar_idx =3D 2,
> +};
> +

[Severity: High]
This structure is defined, but is it missing an entry in the qaic_ids
PCI device ID table?

If the VF's PCI ID is not registered in the table in
drivers/accel/qaic/qaic_drv.c, won't the driver fail to match and bind
to the newly created VFs, making this configuration unreachable?

[ ... ]

> @@ -761,6 +768,34 @@ static const struct dev_pm_ops qaic_pm_ops =3D {
>  	SYSTEM_SLEEP_PM_OPS(qaic_pm_suspend, qaic_pm_resume)
>  };
> =20
> +static int qaic_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct qaic_device *qdev =3D pci_get_drvdata(pdev);
> +	int ret;
> +
> +	/* Qaic device must be online to process VF bringup */
> +	if (qdev->dev_state =3D=3D QAIC_OFFLINE)
> +		return -ENODEV;
> +
> +	if (qdev->dev_state =3D=3D QAIC_BOOT)
> +		return -EBUSY;
> +
> +	if (num_vfs =3D=3D 0) {
> +		pci_disable_sriov(pdev);
> +		return 0;
> +	}

[Severity: High]
Does the dev_state check in qaic_pci_sriov_configure() correctly handle the
num_vfs =3D=3D 0 teardown path?

If the device encounters a hardware error and enters QAIC_OFFLINE, an admin
might write 0 to sriov_numvfs to tear down the VFs. Since the state checks
happen before checking for num_vfs =3D=3D 0, won't this incorrectly return
-ENODEV and permanently trap the VFs in an enabled state?

Could the num_vfs =3D=3D 0 check be moved before the dev_state validations?

> +
> +	ret =3D pci_enable_sriov(pdev, num_vfs);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable SR-IOV: %d (requested %d VFs, ma=
x %d)\n",
> +			ret, num_vfs, pci_sriov_get_totalvfs(pdev));
> +		return ret;
> +	}
> +
> +	dev_dbg(&pdev->dev, "Successfully enabled %d VFs\n", num_vfs);
> +	return num_vfs;
> +}
> +
>  static struct pci_driver qaic_pci_driver =3D {
>  	.name =3D QAIC_NAME,
>  	.id_table =3D qaic_ids,
> @@ -768,6 +803,7 @@ static struct pci_driver qaic_pci_driver =3D {
>  	.remove =3D qaic_pci_remove,
>  	.shutdown =3D qaic_pci_shutdown,
>  	.err_handler =3D &qaic_pci_err_handler,
> +	.sriov_configure =3D qaic_pci_sriov_configure,

[Severity: High]
Since this patch enables SR-IOV, does qaic_pci_remove() in=20
drivers/accel/qaic/qaic_drv.c need to call pci_disable_sriov() before=20
tearing down the device resources?

If an administrator unbinds the PF driver while VFs are still active,
won't leaving SR-IOV enabled while destroying the PF's MHI and DRM backing
state lead to a resource leak and potential use-after-free when the active
VFs attempt to access the hardware?

[Severity: High]
This is a pre-existing issue, but looking at init_msi() in=20
drivers/accel/qaic/qaic_drv.c:

drivers/accel/qaic/qaic_drv.c:init_msi() {
    ...
	mhi_irq =3D pci_irq_vector(pdev, 0);
	if (mhi_irq < 0)
		return mhi_irq;

	for (i =3D 0; i < qdev->num_dbc; ++i) {
		ret =3D devm_request_threaded_irq(&pdev->dev,
						pci_irq_vector(pdev, qdev->single_msi ? 0 : i + 1),
						dbc_irq_handler, dbc_irq_threaded_fn, IRQF_SHARED,
						"qaic_dbc", &qdev->dbc[i]);
		if (ret)
			return ret;
    ...
}

Are we leaking IRQ vectors here?

According to the PCI subsystem guidelines, failing to call
pci_free_irq_vectors() in error paths after a successful
pci_alloc_irq_vectors() leaks IRQ resources. If devm_request_threaded_irq()
fails, this path returns the error code directly without freeing the vector=
s.

>  	.driver =3D {
>  		.pm =3D pm_sleep_ptr(&qaic_pm_ops),
>  	},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164125.3652=
876-1-youssef.abdulrahman@oss.qualcomm.com?part=3D1
