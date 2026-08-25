Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1537C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E4F10EA1D;
	Tue, 25 Aug 2026 12:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VPu9yqAx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B0410EA1D
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:18:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F14B640E32;
 Tue, 25 Aug 2026 12:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90931F000E9;
 Tue, 25 Aug 2026 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660287;
 bh=wKgnEA4Obw27hNjnfdvUJdABr1CZJ2ibUNPpRdAeaQg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VPu9yqAxK1nHcWKwGytb8GvM3GAGDWiSo47VDxmhpTjIIzpJnUNAZL1FyAzafU4q3
 rE8MLiQDSxXiRIiOyGFPG3xO2RqDHowXbmnk/1eSvJPC+tMTHYpbuBT1FB86XhBpGL
 Z1Fxh3MaJ1GevLP3jhR48s3C3oFNm85CH5TslpHRWtUtlI9zvDqyJYWuPTa70pCFdE
 VyX6dRANPXmqwuLRhCyUwlN6W0M7H5A066JHnz/PTE53vcM6tsLHRJQfCQJQJEUGnF
 7pUPniAV2WS5nLaDsoor/ucxa+Q57z0fwx3H2dBeh/KzH9A2e2+QGUn1A+dT7R82ca
 joFk1+dOERQ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/cirrus-qemu: Validate BAR0 size during probe
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260825120729.493611-1-sst@poczta.fm>
References: <20260825120729.493611-1-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:18:07 +0000
Message-Id: <20260825121807.A90931F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The driver maps PCI BAR1 (MMIO) without verifying that its length =
is sufficient to cover the register offsets accessed by the driver (up to 0=
x15 for CRT_DATA). If a malicious or malformed PCI device provides a very s=
mall BAR1 (e.g., 16 bytes), accesses to higher offsets could cross page bou=
ndaries into unmapped memory, potentially causing a kernel panic.
--

--- Patch [1]: [PATCH v2] drm/cirrus-qemu: Validate BAR0 size during probe =
---
commit b04af41f1fca891d59ccb1049a9b053cf626fb58
Author: Slawomir Stepien <sst@poczta.fm>
drm/cirrus-qemu: Validate BAR0 size during probe

This commit adds a check during probe to validate that the PCI BAR0 size is=
 at
least CIRRUS_VRAM_SIZE. This prevents out-of-bounds memory accesses when
drm_fb_memcpy() copies framebuffers to VRAM mapped from a smaller BAR0.

Link: https://syzkaller.appspot.com/bug?extid=3D2442951a6abb004df963
Link: https://syzkaller.appspot.com/ai_job?id=3Dba262a3a-bccf-4ad8-a1b0-583=
c55d34fd6

> diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/ci=
rrus-qemu.c
> index 075221b431d37..3bf23fcf65749 100644
> --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
> +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
> @@ -582,6 +582,9 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	struct cirrus_device *cirrus;
>  	int ret;
> =20
> +	if (pci_resource_len(pdev, 0) < CIRRUS_VRAM_SIZE)
> +		return -ENODEV;
> +

[Severity: High]
This is a pre-existing issue, but since we are validating the length of BAR0
(VRAM) here to prevent out-of-bounds accesses, should we also validate the
length of BAR1 (MMIO)?

Later in cirrus_pci_probe(), BAR1 is mapped using its raw length:

    cirrus->mmio =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 1),
                                pci_resource_len(pdev, 1));

The driver subsequently accesses MMIO offsets up to 0x15:

drivers/gpu/drm/tiny/cirrus-qemu.c:wreg_crt() {
    ...
    iowrite8(reg, cirrus->mmio + CRT_INDEX);
    iowrite8(val, cirrus->mmio + CRT_DATA);
}

If a malformed PCI device presents a very small BAR1 (e.g., 16 bytes) and is
allocated such that its physical address is near the end of a page (e.g.,
ending at 0xFFF), devm_ioremap() will map only that single page.

Could accessing offset 0x15 cross the page boundary into unmapped virtual
memory and trigger a supervisor page fault?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825120729.4936=
11-1-sst@poczta.fm?part=3D1
