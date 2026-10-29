Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B3606A329
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TuQWYejq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07F610E196;
	Thu, 29 Oct 2026 03:58:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E60C10E196
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:58:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81A8243756;
 Thu, 29 Oct 2026 03:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7271F01828;
 Thu, 29 Oct 2026 03:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793246309;
 bh=aWBIHPyajz2PmP7M6aK7NOpqzSa1zCnMqTM3proafIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TuQWYejqJ/vq54V0sRrkPRFOD5LGkGLn0haZKe+NYWff6lZSnTI6kltkttLQ90iXd
 XoDF4Z+m/0jvouMmPhYKmtW+CoI+O4IP9wNbWhnX3tq8l9hvvEN0ZFybVn+oVU+uxG
 ojN6Lbb1+lFXKWTyVd0mFa4GvxlM9CNRxOg59g0Ky1b6O7lCDlvzz399Imta+0QkAG
 lapCR+NUoddJehLEsHXLFmIRX2YizgxrHbTg8A0UliIuOUQCw2/EUQGfUmYDL4UKj0
 tiUWDoY+MVUD3W0DkHsH1Ydpa+EPjPFsUDXnbSizvQctBquooPOwu0VvHzE+5fQquE
 OOQrXPK6MqIkQ==
Message-ID: <sashiko-outbox-188688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/VGA: Enable firmware default device detection on
 LoongArch
To: wuqianhai@loongson.cn
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261029033440.973077-1-wuqianhai@loongson.cn>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
 <20261029033440.973077-1-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:58:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI/VGA: pci_fixup_vgadev() overrides vga_is_firmware_default() on=
 LoongArch
- [Medium] PCI/VGA: duplicate non-idempotent screen_info_apply_fixups() cal=
l on LoongArch
- [Medium] PCI/VGA: vga_is_firmware_default() fails to match Loongson integ=
rated DC
--

commit 6de860408bce3c5a20f5a4c23b073eafdc942117
Author: wuqianhai <wuqianhai@loongson.cn>

PCI/VGA: Enable firmware default device detection on LoongArch

This commit enables vga_is_firmware_default() on LoongArch, selects
CONFIG_SYSFB from CONFIG_VGA_ARB for LoongArch, and calls
screen_info_apply_fixups() in vga_arb_device_init() so relocated firmware
framebuffer BARs can be matched when selecting the default boot VGA device.

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3e58b2c05c854..1b7e915629f97 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -566,7 +566,7 @@ EXPORT_SYMBOL(vga_put);
> =20
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#if defined CONFIG_X86
> +#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
>  	return pdev =3D=3D screen_info_pci_dev(&sysfb_primary_display.screen);

[Severity: High]
On LoongArch systems with a Loongson display controller (PCI device IDs
0x7a06, 0x7a36, or 0x7a46) and one or more discrete VGA devices, will
pci_fixup_vgadev() in arch/loongarch/pci/pci.c later overwrite the firmware
default VGA device selected here?

During ACPI boot on LoongArch, PCI enumeration runs in
subsys_initcall(acpi_init), and vga_arb_device_init() runs next at
subsys_initcall_sync:

vga_arb_device_init()
  vga_arbiter_add_pci_device()
    vga_is_boot_device()
      vga_is_firmware_default()
    vga_set_default_device(pdev)

After vga_arb_device_init() finishes, pci_apply_final_quirks() in
drivers/pci/quirks.c runs at fs_initcall_sync and invokes the
DECLARE_PCI_FIXUP_FINAL hooks in arch/loongarch/pci/pci.c:

static void pci_fixup_vgadev(struct pci_dev *pdev)
{
	struct pci_dev *devp =3D NULL;

	while ((devp =3D pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, devp))) {
		if (devp->vendor !=3D PCI_VENDOR_ID_LOONGSON) {
			vga_set_default_device(devp);
			dev_info(&pdev->dev,
				"Overriding boot device as %X:%X\n",
				devp->vendor, devp->device);
		}
	}
}
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC1,=
 pci_fixup_vgadev);
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC2,=
 pci_fixup_vgadev);
DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DC3,=
 pci_fixup_vgadev);

Because pci_fixup_vgadev() unconditionally calls vga_set_default_device(dev=
p)
for every non-Loongson VGA device without checking whether a firmware defau=
lt
device was already chosen, won't it clobber vga_default whenever firmware
selected a Loongson display device or the first of multiple non-Loongson
discrete GPUs as the primary display?

[Severity: Medium]
Also in vga_is_firmware_default() in drivers/pci/vgaarb.c, can this pointer
comparison ever match when the firmware framebuffer resides on Loongson
integrated graphics (such as on LS7A1000, LS7A2000, or LS2K2000)?

As shown in lsdc_get_dedicated_vram() in drivers/gpu/drm/loongson/lsdc_drv.=
c,
the integrated graphics subsystem is split across two PCI functions:

	/*
	 * The GPU has 00:06.0 as its BDF, while the DC has 00:06.1
	 * This is true for the LS7A1000, LS7A2000 and LS2K2000.
	 */
	pdev_gpu =3D pci_get_domain_bus_and_slot(pci_domain_nr(pdev_dc->bus),
					       pdev_dc->bus->number,
					       PCI_DEVFN(6, 0));
	...
	base =3D pci_resource_start(pdev_gpu, 2);
	size =3D pci_resource_len(pdev_gpu, 2);

When the firmware framebuffer is placed in integrated VRAM,
screen_info_pci_dev(&sysfb_primary_display.screen) matches BAR 2 of the
companion GPU device at 00:06.0 (PCI_DEVICE_ID_LOONGSON_GPU1/2/3).

However, vga_arb_device_init() and pci_notify() filter devices using
pci_is_vga(pdev), so only the VGA-class Display Controller function at
00:06.1 (PCI_DEVICE_ID_LOONGSON_DC1/2/3, whose BAR 0 only maps MMIO
registers) is passed to vga_is_firmware_default(pdev). Doesn't comparing
pdev (00:06.1) against screen_info_pci_dev() (00:06.0) always evaluate to
false for the integrated display controller?

>  #else
>  	return false;
> @@ -1527,6 +1527,16 @@ static int __init vga_arb_device_init(void)
>  	int rc;
>  	struct pci_dev *pdev;
> =20
> +#if defined(CONFIG_LOONGARCH)
> +	/*
> +	 * On LoongArch, PCI resource assignment completes during
> +	 * subsys_initcall (acpi_init), before the VGA arbiter runs.  Refresh
> +	 * screen_info so vga_is_firmware_default() can match the relocated
> +	 * BAR.
> +	 */
> +	screen_info_apply_fixups();
> +#endif

[Severity: Medium]
With CONFIG_VGA_ARB selecting CONFIG_SYSFB on LoongArch, calling
screen_info_apply_fixups() here in vga_arb_device_init() at
subsys_initcall_sync means screen_info_apply_fixups() will be called a seco=
nd
time when sysfb_init() in drivers/firmware/sysfb.c runs at device_initcall:

drivers/firmware/sysfb.c:sysfb_init() {
	...
	screen_info_apply_fixups();

	mutex_lock(&disable_lock);
	if (disabled)
		goto unlock_mutex;
	...
}

Looking at screen_info_apply_fixups() in drivers/video/screen_info_pci.c:

void screen_info_apply_fixups(void)
{
	struct screen_info *si =3D &sysfb_primary_display.screen;

	if (screen_info_lfb_pdev) {
		struct resource *pr =3D &screen_info_lfb_pdev->resource[screen_info_lfb_b=
ar];

		if (pr->start !=3D screen_info_lfb_res_start) {
			if (__screen_info_relocation_is_valid(si, pr)) {
				__screen_info_set_lfb_base(si, pr->start + screen_info_lfb_offset);
				pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
					&screen_info_lfb_offset, pr);
			} else {
				pr_warn("Invalid relocating, disabling firmware framebuffer\n");
			}
		}
	}
}

Because screen_info_apply_fixups() neither updates screen_info_lfb_res_start
nor clears screen_info_lfb_pdev after applying the fixup, won't the second
call in sysfb_init() re-run the relocation logic and print a duplicate
message whenever the framebuffer BAR was relocated, or emit a spurious
warning if a built-in GPU driver probed earlier in device_initcall and
resized the BAR after calling sysfb_disable()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029033440.9730=
77-1-wuqianhai@loongson.cn?part=3D1
