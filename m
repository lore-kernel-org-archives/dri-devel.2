Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B86CDB47C
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D778910ED06;
	Tue, 23 Jun 2026 22:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SlHzV11c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998EE10ED00
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:47:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F48F600AB;
 Tue, 23 Jun 2026 22:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB11F00A3A;
 Tue, 23 Jun 2026 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782254835;
 bh=651gCXCtFUWRRAclpQcqDe5lM8pQ7FBm6dEQuexrbVY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SlHzV11ckg2TLaKkZRPiTxzIgHBZIyA/XuH3ggePjynellS+I6G80b3EmOxwoxUhf
 cc4IQt2Aw/qtZnipqEcw8kOUQgBSnDVHFGfi2vDpCo67vWO8jajeyT/k0Q91qdFpEY
 T+7B7xTbm94KiY+1QgNym3zgjgM/1ErgFsK3VfCT1YNTfRjR4cMWlOWuVFAFFD6fO9
 p/FtQhf6RXduhJfnje6N2DDd0Fshl4cN2FaGDKXKnEBAx3oZwhUokRNsnfBhseegB0
 VWTs68agjYEZMYc+Ur3v/AG0lpKrLjrdw8Km9HEgGc6+IE3eF9JfTdmC8cg/TQccPp
 RZ3mKeMgqBK1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] drm/xe: Suppress Surprise Link Down on device
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622131458.144873-13-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
 <20260622131458.144873-13-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:47:14 +0000
Message-Id: <20260623224715.43DB11F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] VF driver modifies physical Upstream Switch Port (USP) AER configu=
ration, violating SR-IOV isolation.
- [High] Unconditional unmasking of Surprise Link Down overrides platform/f=
irmware AER configurations.
- [Medium] Logic asymmetry: Surprise Link Down is masked unconditionally bu=
t unmasked conditionally.
- [Medium] Unbalanced lifecycle operation: AER mask is modified before an a=
synchronous userspace recovery request.
- [Medium] Race condition / TOCTOU when modifying shared USP AER registers.

Pre-existing issues:
- [High] Hardware topology assumption in find_usp_dev() may modify system b=
ridges instead of GPU internal switches.
--

commit ddd656b7786f19f5a390609ee31b584f88c5c3be
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: drm/xe: Suppress Surprise Link Down on device

PUNIT errors can only be recovered using a power-cycle. Xe KMD sends a
uevent to notify userspace to trigger a power cycle. On platforms where link
drop caused by powering the device off and back on is reported by hardware
as a Surprise Link Down (SLD), which AER then escalates as an Uncorrectable
Fatal Error. That error fires before the device finishes coming back up and
defeats the very recovery we are attempting.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 1eb2bbaccd9bd..5a2fee5a13083 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -256,8 +256,37 @@ static struct pci_dev *find_usp_dev(struct pci_dev *=
pdev)
>  	return pci_upstream_bridge(vsp);
>  }

[Severity: High]
This is a pre-existing issue, but does find_usp_dev() make an unchecked
assumption about the hardware topology? If the GPU is not connected via an
internal PCIe switch, navigating two levels up could return a generic
motherboard root port or external switch port. Modifying the AER registers
of this shared system bridge might affect error handling for other connected
devices.

> =20
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u16 aer_cap;
> +
> +	/*
> +	 * Cold reset power-cycles the slot, dropping the PCIe link.
> +	 * This triggers a spurious Surprise Link Down AER event on the
> +	 * Upstream Switch Port (USP). Mask this error to avoid false
> +	 * error reporting during recovery.
> +	 */
> +	aer_cap =3D pci_find_ext_capability(usp, PCI_EXT_CAP_ID_ERR);
> +	if (!aer_cap) {
> +		dev_dbg(&usp->dev,
> +			"AER capability not present\n");
> +		return;
> +	}
> +
> +	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, 0, PC=
I_ERR_UNC_SURPDN);

[Severity: Medium]
Could this lead to a race condition or TOCTOU when modifying shared USP AER
registers? pci_clear_and_set_config_dword() performs a read, modifies the
value, and writes it back without holding a synchronization lock. If multip=
le
endpoints on the switch experience errors concurrently, their asynchronous
error handlers might race here.

> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
> +}
> +
>  static void punit_error_handler(struct xe_device *xe)
>  {
> +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> +	struct pci_dev *usp;
> +
> +	usp =3D find_usp_dev(pdev);
> +
> +	if (usp)
> +		pcie_suppress_surprise_link_down(usp);

[Severity: High]
Does modifying a shared physical resource (the USP) from a Virtual Function
(VF) break SR-IOV isolation? The VF driver attempts to mask the Surprise Li=
nk
Down error on the physical USP without an IS_SRIOV_VF() check. Following
subsystem guidelines, VF drivers must not access PF-only resources and must
guard such paths.

[Severity: Medium]
Also, could this cause a logic asymmetry where the Surprise Link Down is
masked unconditionally, but unmasked conditionally? If the kernel is
compiled without CONFIG_PCIEAER, the driver will mask SLD during an error
but never unmask it upon recovery, potentially disabling SLD reporting
permanently.

> +
>  	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>  	xe_device_declare_wedged(xe);

[Severity: Medium]
If userspace ignores the uevent, crashes, or the driver unbinds before the
reset completes, will the AER configuration remain permanently modified
without cleanup? This modifies the AER mask before an asynchronous userspace
recovery request, leaving no teardown mechanism to revert the mask on
failure.

>  }

[ ... ]

> @@ -604,20 +644,22 @@ static void aer_unmask_and_downgrade_internal_error=
(struct xe_device *xe)
>  	 * The Uncorrectable Error Severity Register has the 'Uncorrectable
>  	 * Internal Error Severity' set to fatal by default. Set this to
>  	 * non-fatal and unmask the error.
> +	 *
> +	 * Also restore the Surprise Link Down mask that was set in
> +	 * pcie_suppress_surprise_link_down() before the cold reset. The USP is
> +	 * never power-cycled, so the mask bit persists and must be cleared here
> +	 * to ensure link-down events are reported normally going forward.
>  	 */
> =20
>  	/* Initialize Uncorrectable Error Severity Register */
> -	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, &aer_uncorr_s=
ev);
> -	aer_uncorr_sev &=3D ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, aer_uncorr_s=
ev);
> +	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_SEVER, PCI_=
ERR_UNC_INTN, 0);
> =20
> -	/* Initialize Uncorrectable Error Mask Register */
> -	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_ma=
sk);
> -	aer_uncorr_mask &=3D ~PCI_ERR_UNC_INTN;
> -	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_ma=
sk);
> +	/* Unmask Uncorrectable Internal Error and restore Surprise Link Down t=
o unmasked */
> +	pci_clear_and_set_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK,
> +				       PCI_ERR_UNC_INTN | PCI_ERR_UNC_SURPDN, 0);

[Severity: High]
Does this unconditional unmasking of Surprise Link Down override the platfo=
rm
or firmware AER configurations? Forcibly unmasking PCI_ERR_UNC_SURPDN witho=
ut
restoring its original state can trigger spurious fatal AER events if the
platform firmware, BIOS, or hotplug driver intentionally masked the bit by
default to handle hardware errata.

> =20
>  	pci_save_state(usp);
> -	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmask=
ed\n");
> +	dev_dbg(&usp->dev, "AER: INTN downgraded to non-fatal, INTN and SLD unm=
asked\n");
>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622131458.1448=
73-8-mallesh.koujalagi@intel.com?part=3D5
