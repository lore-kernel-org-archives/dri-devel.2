Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2ECD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABF210E9A1;
	Fri, 12 Jun 2026 08:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AwIzVwuK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EE710E9A1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 08:21:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2AC643AF7;
 Fri, 12 Jun 2026 08:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5531F00A3A;
 Fri, 12 Jun 2026 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781252467;
 bh=F5w5S8OKL17yyMFRpGTR20zSGOcC2E/ynRlOXp2I59E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AwIzVwuKbVgCwslFxLc0SV8SFT9psMzeouYujKZO+V8QstSj62KZFl966cU064LuW
 6Z4FRdIMaW+T3ykwyKPcKa+kUJIB0ujyyBbVGtDKYJmZqQaKv4n+bEla5PF1OtN6Sv
 EsmLkb/KyqmSdpFBWC2+0UygtRZJQMdAptU53LSTIKBzHkqw5UFqz/tGo+NbCiDt9I
 2eh7SciE7cyN9MT+ijToLEEdDG4wb+ixOCMn/L+wMZUsgYQHJr3yGhDRjmjwlhntCR
 khDKIWMjPc7CRmwYavPPUr/HTmTEvZ8rY/pSTb0c1XIWpd5G4OiAV7qDvY2NjcCBcQ
 Kiu1Ww53yiVGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:21:07 +0000
Message-Id: <20260612082107.8B5531F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Masking Surprise Link Down on the Upstream Switch Port violates PC=
Ie AER specifications.
- [High] Directly mutating AER registers without verifying OS native AER ow=
nership.
- [High] Permanent masking of PCI_ERR_UNC_SURPDN with no restoration mechan=
ism.
- [High] Blind PCIe hierarchy traversal modifies unrelated upstream bridges.
- [Medium] Data race due to unprotected read-modify-write on a shared AER m=
ask register.
--

commit 7a2dc1d13a9370ceb4dd62a9d15aa26d2212058a
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
drm/xe: Suppress Surprise Link Down on device

This commit attempts to prevent fatal AER events during a recovery-induced
cold reset. It masks the Surprise Link Down (SLD) bit in the upstream
port's AER Uncorrectable Error Mask register before triggering the reset.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 93a56a0269f1e..15c2fa0d323a6 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -209,8 +209,57 @@ static enum xe_ras_recovery_action handle_core_compu=
te_errors(struct xe_ras_erro
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
> =20
> +static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
> +{
> +	struct pci_dev *vsp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit =
(GPU endpoint)
> +	 */
> +	vsp =3D pci_upstream_bridge(pdev);
> +	if (!vsp)
> +		return NULL;
> +
> +	return pci_upstream_bridge(vsp);

[Severity: High]
Does this blind traversal safely handle diverse PCIe topologies? If the GPU
is connected to a standard motherboard switch, passed through a hypervisor,=
 or
connected directly to a Root Port, might this return an unrelated bridge
device owned by the host system? Should this verify the Vendor ID or Device
ID of the USP before proceeding?

> +}
> +
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

[Severity: Medium]
Since the Upstream Switch Port is a shared bridge managed by the pcieport
driver, could this lockless read-modify-write sequence race with the AER
driver handling other hotplug events, or with other endpoints on the same
switch experiencing concurrent errors?

> +	aer_uncorr_mask |=3D PCI_ERR_UNC_SURPDN;

[Severity: High]
Is there a mechanism to unmask this bit after the cold reset completes? If
the Surprise Link Down bit is set here but never cleared during driver
probe, resume, or a post-reset callback, will it permanently disable AER
reporting for genuine link failures on this port?

> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_ma=
sk);

[Severity: High]
According to the PCIe Base Specification, Surprise Down errors are exclusiv=
ely
detected and reported by Downstream Ports. On Upstream Ports, the Surprise
Down Error Status and Mask bits are reserved and hardwired to 0. Does maski=
ng
PCI_ERR_UNC_SURPDN on the Upstream Switch Port actually prevent the downstr=
eam
port (the VSP or Root Port) that detects the link drop from generating the
fatal AER event?

[Severity: High]
Is it safe to mutate the AER mask registers directly without verifying OS
native AER ownership? On platforms where firmware retains control of AER
(such as ACPI APEI Firmware First setups), could mutating these registers
directly from the OS conflict with platform management firmware? Is a check
like pcie_aer_is_native(usp) needed here?

> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
> +}
> +#endif /* CONFIG_PCIEAER */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612080722.2672=
6-8-mallesh.koujalagi@intel.com?part=3D5
