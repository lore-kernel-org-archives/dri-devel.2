Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD229C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5138C10E342;
	Fri, 21 Aug 2026 20:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kpzVcT0F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCAC410E342
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:47:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5841600E2;
 Fri, 21 Aug 2026 18:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245721F000E9;
 Fri, 21 Aug 2026 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787336419;
 bh=XhglmsicncowxpGyf4AJUOasDLP/gJFPVMneATqNVJI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kpzVcT0FiUjGLBRmi6DnxioILgD6bpZfAjk/tJRiJuZAOJpLFgqkk2Qmlry757IkL
 ngNiuXrSlpK03B9dyVzUUkm/lFAQzN3wYWVxhkj2OvS7VLhrweub4a7zzBmuEa8pvW
 LdB2qiEMERYoqe9OeEILznAFkZzgQwDAldg3qG4el12/PwIL3WwotX3iZQi66ev1Jf
 LVMLOeTszuBvDE+NrKFyP5NlSc5YD8u1NKlzoy+E8HwLXCd/bmQoe029HW+2+uEWc4
 FU0fDBiwFrBQhhYA/eOlg2db+Sykcu0qP8wsO3smomPSuuVJGB2Z8ND2SMnu0nRyL2
 YxYRsCv5SiUsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260821181203.82722-1-lyude@redhat.com>
References: <20260821181203.82722-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 18:20:18 +0000
Message-Id: <20260821182019.245721F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing NULL validation for the ACPI companion of the parent devic=
e leads to a potential NULL pointer dereference in `acpi_remove_pm_notifier=
()`.
--

--- Patch [1]: [PATCH] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 a=
nd 16AHP9 Nvidia GPUs ---
commit c5f31e20fc4140461290146739333c87be79e5ce
Author: Lyude Paul <lyude@redhat.com>

pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and 16AHP9 Nvidia GPUs

This commit adds a PCI quirk for specific Lenovo Legion laptops. It disables
spurious GPE wakeup events on the parent PCIe port of the Nvidia GPU after
it enters D3Cold.

Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..4d1f1565b61d3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -6165,6 +6165,82 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA=
, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> =20
> +#ifdef CONFIG_ACPI
> +#ifdef CONFIG_DMI
[ ... ]
> +static void quirk_nvidia_dgpu_broken_gpe(struct pci_dev *pdev)
> +{
> +	struct acpi_device *parent_adev;
> +	struct device *parent_dev;
> +	int ret;
[ ... ]
> +	parent_dev =3D pci_physfn(pdev)->dev.parent;
> +	if (!parent_dev) {
> +		pci_err(pdev,
> +			"Can't find PCIe parent? Your Nvidia GPU will have broken runtime PM\=
n");
> +		return;
> +	}
> +	parent_adev =3D ACPI_COMPANION(parent_dev);
> +
> +	/* The spurious GPEs will be sent from the ACPI device for the PCIe por=
t this GPU is
> +	 * connected to, so remove our PM notifier to turn them into a no-op.
> +	 */
> +	ret =3D acpi_remove_pm_notifier(ACPI_COMPANION(parent_dev));

[Severity: High]
Can this cause a NULL pointer dereference if the parent PCIe bridge lacks an
ACPI companion?

ACPI_COMPANION() can return NULL if the system is booted with acpi=3Doff or=
 if
the node simply lacks an ACPI companion.

If that happens, this passes NULL to acpi_remove_pm_notifier(), which
dereferences its argument directly:

drivers/acpi/device_pm.c:acpi_remove_pm_notifier() {
    ...
    if (!adev->wakeup.flags.notifier_present)
    ...
}

Should parent_adev be checked for NULL before calling
acpi_remove_pm_notifier()?=20

Also, it looks like parent_adev is assigned but then
ACPI_COMPANION(parent_dev) is called again instead of using the local
variable.

> +	if (ACPI_FAILURE(ret))
> +		pci_err(pdev, "Removing PM notifier failed: %d\n", ret);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821181203.8272=
2-1-lyude@redhat.com?part=3D1
