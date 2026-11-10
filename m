Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A91606A934
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwvckUs0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA5010EEF2;
	Tue, 10 Nov 2026 09:52:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4645210EEF2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:52:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3649063819;
 Tue, 10 Nov 2026 09:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4391F0089F;
 Tue, 10 Nov 2026 09:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794304370;
 bh=Hfq/kOs5cw7B07R6GcfDw9v+ujkNam4XqUR61qSPAu4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZwvckUs0s86Ap8OnkM9izM6yH/l01+Ag7+Q7RqYaBxVDoQZ5Q4ulNT7s8Ir0jecxM
 8DsUmS0DUM/4BiEnKWZ/bWjj6tKr5mpCzqRnFEcnpIHSiAZ4iQC8zsRNH1n31UfOfI
 6DcwU5KUwfJcN7HgoDsifG/S0pncl2STV4zRaYh5tf3MdwW0xwBcndaOrMvRq131Uy
 cYyvaeaRIdeFknxWfxdWFYkyVEd1CospVC6P7QV0CsuIZG/5z8cbKJ9R2C9lO/bqOD
 mbAHca0vhLpiWN0JsHXjIFCTlP9KTZGf+Y6lI4ktJHtJR9RjzpMsjvbHuiWcGF1ywT
 c6O8UfdmmwH9A==
Message-ID: <sashiko-outbox-206810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] LoongArch/PCI: Refresh screen_info after
 resource assignment
To: wuqianhai@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
 tzimmermann@suse.de, deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261110090203.2631481-3-wuqianhai@loongson.cn>
References: <20261029033440.973077-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110090203.2631481-3-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:52:49 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] LoongArch/PCI: repeated fixup and UAF via
  screen_info_apply_fixups()
--

commit 1413644b1b0b80d135ecb2502366b5c2eb670d52
Author: wuqianhai <wuqianhai@loongson.cn>

LoongArch/PCI: Refresh screen_info after resource assignment

This commit calls screen_info_apply_fixups() in pci_acpi_scan_root() after
assigning root bus resources so that screen_info reflects any relocated
firmware framebuffer BAR before vga_arb_device_init() and sysfb_init() run.

> diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
> index ccbcea61fcd9c..cb313ff67f7e7 100644
> --- a/arch/loongarch/pci/acpi.c
> +++ b/arch/loongarch/pci/acpi.c
[ ... ]
> @@ -256,6 +257,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_ro=
ot *root)
>  		 */
>  		pci_assign_unassigned_root_bus_resources(bus);
> =20
> +		if (IS_ENABLED(CONFIG_SCREEN_INFO))
> +			screen_info_apply_fixups();

[Severity: Medium]
Is screen_info_apply_fixups() safe to call from pci_acpi_scan_root()?

screen_info_apply_fixups() was previously called only once from
sysfb_init().  When it updates the framebuffer address, it neither updates
screen_info_lfb_res_start nor clears screen_info_lfb_pdev:

drivers/video/screen_info_pci.c:screen_info_apply_fixups() {
	...
	if (screen_info_lfb_pdev) {
		struct resource *pr =3D &screen_info_lfb_pdev->resource[screen_info_lfb_b=
ar];

		if (pr->start !=3D screen_info_lfb_res_start) {
			if (__screen_info_relocation_is_valid(si, pr)) {
				__screen_info_set_lfb_base(si, pr->start + screen_info_lfb_offset);
				pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
					&screen_info_lfb_offset, pr);
	...
}

Because pr->start !=3D screen_info_lfb_res_start remains true after a
relocation, every subsequent root bridge scan on multi-root systems and the
later call in sysfb_init() will re-run the relocation branch and emit
duplicate messages.  If a built-in DRM driver probes before sysfb_init(),
calls sysfb_disable(), and resizes the BAR, sysfb_init() will also
re-evaluate the resized BAR before checking whether sysfb was disabled.

In addition, screen_info_lfb_pdev is an unreferenced pointer that is never
cleared on PCI device removal, while pci_acpi_scan_root() can be called
after boot via acpi_pci_root_add() hotplug.  Removing the boot display PCI
device and hot-adding an ACPI PCI root bridge would dereference the freed
screen_info_lfb_pdev in screen_info_apply_fixups().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D2
