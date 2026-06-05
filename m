Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01019CD6E77
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B96D112AF9;
	Fri,  5 Jun 2026 12:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mqsADFRo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83316112AF9
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:41:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6817C405D8;
 Fri,  5 Jun 2026 12:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316BF1F00893;
 Fri,  5 Jun 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780663281;
 bh=flypLn7sA88yOb83zUl0cnYUfSCYepk0dd4pRX7t7OY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mqsADFRoyx6H5c0KKKfFaYp3vC4HI2kCcPUd2PUmZ/Ci+Qn+BB0IVPctt62LXgcxV
 du3lfnJKsWE0SEXi8dIPU00qlaWRJEXUPxtuytb6OiV/SoS3j3QOfl1rqh0bOI+g0r
 HxXZm3NgvWnV5vXZ/AsY3Q/qoYYJzWwWgBNujcFOymPotMyyIBGZZBvVf9kyez/WKh
 7aXhzn4QgHs6/WDrpQ5Iv8Ub6SzFtMMNHNQ6BK9/IIeFwW85Zs6hOZ+uA5iF0OqgCe
 Q2KhThKSnNpi87nesuNrO88O0eNqg7mpd+lsf0q+9kaaJjFWT7MdWFljelf0zhIIm8
 3CRJuzMTHtXcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] drm/xe: Suppress Surprise Link Down on device
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605122544.1021695-13-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-13-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:41:20 +0000
Message-Id: <20260605124121.316BF1F00893@smtp.kernel.org>
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
- [High] The driver permanently masks the Surprise Link Down AER event (PCI=
_ERR_UNC_SURPDN) on the upstream switch port without ever restoring it.
- [High] Lockless read-modify-write of the shared Upstream Switch Port's AE=
R mask register creates a race condition.
- [High] Unchecked pci_read_config_dword return value may corrupt the AER m=
ask register.
- [High] Attempting to mask Surprise Link Down on an Upstream Port violates=
 the PCIe specification and fails to suppress the error.
--

commit b4b812ffca5eaea995b148e8a053e6c4fd45bfe9
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Suppress Surprise Link Down on device

This patch attempts to suppress spurious Surprise Link Down AER events duri=
ng
a recovery cold reset. It does so by masking the PCI_ERR_UNC_SURPDN bit in
the upstream switch port's AER Uncorrectable Error Mask register before
triggering the cold reset.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 9a90a7118e896..acdedf403649f 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c

[ ... ]

> +#ifdef CONFIG_PCIEAER
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u32 aer_uncorr_mask;
> +	u16 aer_cap;
> +
> +	aer_cap =3D usp->aer_cap;
> +	if (!aer_cap) {
> +		dev_dbg(&usp->dev,
> +			"AER capability not present\n");
> +		return;
> +	}
> +
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_ma=
sk);

[Severity: High]
Does this code risk corrupting the AER mask register if the read fails?

If pci_read_config_dword() fails, for example due to temporary bus
unavailability, it can leave aer_uncorr_mask uninitialized or set it to all
1s. Writing that value back could inadvertently mask all uncorrectable erro=
rs
or write garbage to the register.

> +	aer_uncorr_mask |=3D PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_ma=
sk);

[Severity: High]
Is it safe to perform a lockless read-modify-write on a shared parent
bridge's configuration space?

Since the upstream switch port is outside the xe driver's ownership, if the
AER core or another driver concurrently modifies this mask register without
holding pci_dev_lock() on the upstream port, could one of the updates be
silently lost?

[Severity: High]
Will this permanently mask the Surprise Link Down AER event on the upstream
switch port?

The configuration space of the port above the cold reset boundary isn't
reset by the slot power cycle, and there does not appear to be any
corresponding code to unmask this bit later. Could this permanently blind
the port to legitimate Surprise Link Down errors until the next system
reboot?

> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
> +}
> +#endif /* CONFIG_PCIEAER */
> +
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +#ifdef CONFIG_PCIEAER
> +	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> +	struct pci_dev *vsp, *usp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VS=
P) --> SGunit
> +	 *
> +	 * Cold reset power-cycles the slot, dropping the PCIe link. The
> +	 * slot triggers a spurious Surprise Link Down AER event on the USP.
> +	 */
> +	vsp =3D pci_upstream_bridge(pdev);
> +	usp =3D vsp ? pci_upstream_bridge(vsp) : NULL;
> +
> +	if (usp)
> +		pcie_suppress_surprise_link_down(usp);

[Severity: High]
Will masking the Surprise Link Down bit on the Upstream Switch Port actually
suppress the intended error?

According to the PCIe Base Specification, the Surprise Down Error Status bit
is mandatory for Downstream Ports and reserved for all other port types.

Since the Downstream Port (vsp) facing the slot is what actually detects the
link drop and triggers the AER event, does writing to a reserved bit in the
upstream port's config space fail to suppress the spurious AER event?

> +#endif
>  	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>  	xe_device_declare_wedged(xe);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605122544.1021=
695-8-mallesh.koujalagi@intel.com?part=3D5
