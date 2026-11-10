Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC69606BF1C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awKkjim9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A9E10E1AB;
	Tue, 10 Nov 2026 09:50:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D3710E1AB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:49:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EB5E63805;
 Tue, 10 Nov 2026 09:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3661F0089F;
 Tue, 10 Nov 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794304197;
 bh=EkW17L+a59OE+CXhcmIv0XZlGY6UV7TlmqO6tXYqc5g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=awKkjim9o7JgaEKDKF5VKbjB/H3xMfo1h4DSJpG6bM5HSo4hr+p1sU2TvRcG1eC1R
 iqSYq7/nJVPOqUrAGEh2AhMTr3Yv8New1U0oVgcTMnv5uS/SzfHsm/CBt23RMktm+D
 19FnGFhAZXpuutv9YXITOnMY2Sk3HBnnjRPLT9wtS8Yanz5IDi4jdQL3bZtzEz9hNo
 xjj8dEgam/Gl7ocq2XEaeaElEpDifNYEt9dGg5GwMKcQvfGkY541Jcesq7kK7+/bdx
 gNdRCNGYLSkVlsAPUtY46OOUKvG/59nyIho9YrfbiCJ4qReXRXAZ2Dan/qs4u18YlH
 5CnuZkLYH/qRg==
Message-ID: <sashiko-outbox-206807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] PCI/VGA: Enable firmware default device
 detection on LoongArch
To: wuqianhai@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
 tzimmermann@suse.de, deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261110092426.2647976-1-wuqianhai@loongson.cn>
References: <20261110090203.2631481-1-wuqianhai@loongson.cn>
 <20261110092426.2647976-1-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:49:56 +0000
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
- [Medium] PCI/VGA: stale screen_info on DT/non-x86 paths in
  vga_is_firmware_default()
--

commit cc9285f73294dc9c72f6466431882028a26deb92
Author: wuqianhai <wuqianhai@loongson.cn>

PCI/VGA: Enable firmware default device detection on LoongArch

This commit selects SCREEN_INFO for VGA_ARB on LoongArch and switches
vga_is_firmware_default() from a CONFIG_X86 guard to CONFIG_SCREEN_INFO.

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3e58b2c05c854..4528ad0386102 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -566,7 +566,7 @@ EXPORT_SYMBOL(vga_put);
> =20
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#if defined CONFIG_X86
> +#ifdef CONFIG_SCREEN_INFO
>  	return pdev =3D=3D screen_info_pci_dev(&sysfb_primary_display.screen);
>  #else
>  	return false;

[Severity: Medium]
Does guarding this with CONFIG_SCREEN_INFO cause vga_is_firmware_default()
to read a stale sysfb_primary_display.screen.lfb_base on LoongArch
DeviceTree systems and other non-x86 EFI architectures (such as ARM64, ARM
and RISC-V with CONFIG_SYSFB=3Dy)?

Commit "LoongArch/PCI: Refresh screen_info after resource assignment" only
adds screen_info_apply_fixups() to LoongArch's ACPI pci_acpi_scan_root().
When PCI probing runs via pci_host_probe() (e.g. loongson_pci_probe()) or
generic pci_acpi_scan_root() in drivers/pci/pci-acpi.c,
vga_arb_device_init() runs at subsys_initcall_sync time before
sysfb_init() calls screen_info_apply_fixups() at device_initcall time.  If
the firmware framebuffer BAR was relocated during resource assignment or
sits behind a host bridge with a non-zero CPU-to-PCI offset,
screen_info_pci_dev() will not match pdev and fails to select the firmware
default VGA device.

Also, the second paragraph of the commit message says the previous patch
handled screen_info staleness so vga_arb_device_init() no longer needs to
refresh screen_info itself, which looks like leftover commentary from an
earlier version of the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110090203.2631=
481-1-wuqianhai@loongson.cn?part=3D6
