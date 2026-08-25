Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A77EC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2D110E90C;
	Tue, 25 Aug 2026 07:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lGCjHLS3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F44410E90C
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:44:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CDE8601E0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4511F00A3A;
 Tue, 25 Aug 2026 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787643872;
 bh=1v15wX3K1rpZQVjcJAbATDns+WOWdbJyJzab9bw32gk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lGCjHLS3mfKXhp5ITzNBdFYEXsFT1wSsIz6JAKmkSBpZPVqbih+FV7wdEirEguMGN
 iHvqN96NBCmubmnyFYWyYaj2Zqwo/xv3FgoIO4fQoV5ifaGx74rRLYRe2q66d1iQ+G
 XRyIhtKukOJ6lo/ZwVcQ+V5rEOWxspmR+ZNO/kLAA0QtQB+jHU3CH2oaDO291IlYw6
 3DHmvZEKLHIlAKYjt05X09nBcqB6gUR7HwowupOBijPJBR/Oz9Srlgumf2zwKDgydG
 GdCobiVNHFuhkIAUHSP8bBHx4ytLjkusfoKyJTSjG5j/pxom4wqKXDJBZDiAgSH4Rb
 LIhy8TGDj6byA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe
To: syzbot <syzbot@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <b11f8965-5896-4119-98b7-6bd0eb9fa139@mail.kernel.org>
References: <b11f8965-5896-4119-98b7-6bd0eb9fa139@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:44:31 +0000
Message-Id: <20260825074432.0B4511F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The exact equality check for BAR0 size (`!=3D CIRRUS_VRAM_SIZE`) i=
ncorrectly rejects valid QEMU configurations with larger VRAM.
- [High] The VRAM size validation check is placed after `aperture_remove_co=
nflicting_pci_devices()`, meaning the firmware framebuffer is permanently d=
estroyed even if the driver ultimately fails to bind.
--

--- Patch [1]: [PATCH] drm/cirrus-qemu: Validate BAR0 size during probe ---
commit 75467ead62a494b6afbc057c666ab59f7e4b8915
Author: Slawomir Stepien <sst@poczta.fm>

drm/cirrus-qemu: Validate BAR0 size during probe

This commit adds a check during PCI probe to verify that the BAR0 resource
length equals CIRRUS_VRAM_SIZE. This is intended to prevent supervisor write
page faults caused by writing past the end of the mapped I/O memory when
smaller BARs are presented.

Link: https://syzkaller.appspot.com/ai_job?id=3Dba262a3a-bccf-4ad8-a1b0-583=
c55d34fd6

> diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/ci=
rrus-qemu.c
> index 075221b431d37..70c995025f508 100644
> --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
> +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
> @@ -602,6 +602,9 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
> =20
>  	dev =3D &cirrus->dev;
> =20
> +	if (pci_resource_len(pdev, 0) !=3D CIRRUS_VRAM_SIZE)
> +		return -ENODEV;
> +

[Severity: High]
Does this strict equality check unintentionally break valid QEMU
configurations that have more than 4 MB of VRAM?

When a VM is booted with a configuration like -device cirrus-vga,vgamem_mb=
=3D8,
the BAR0 size will be 8 MB. The check in cirrus_pci_probe() evaluates
to true (since 8 MB is not equal to 4 MB) and rejects the device by
returning -ENODEV.

Would it be safer to check if pci_resource_len(pdev, 0) < CIRRUS_VRAM_SIZE
instead of requiring an exact match?

[Severity: High]
Is it safe to place this validation check after the call to
aperture_remove_conflicting_pci_devices() earlier in cirrus_pci_probe()?

If this new size check fails (either due to a malformed device or a larger
valid VRAM size), cirrus_pci_probe() aborts with -ENODEV. However, because
aperture_remove_conflicting_pci_devices() was already executed at the start
of the probe function, the firmware framebuffers (like efifb or simplefb)
have been permanently destroyed.

Could this leave the system with a dead display output? Would it make sense
to move this PCI configuration check to the very beginning of the probe
function, before any destructive actions occur?

>  	cirrus->vram =3D devm_ioremap(&pdev->dev, pci_resource_start(pdev, 0),
>  				    pci_resource_len(pdev, 0));
>  	if (cirrus->vram =3D=3D NULL)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b11f8965-5896-4119-=
98b7-6bd0eb9fa139@mail.kernel.org?part=3D1
