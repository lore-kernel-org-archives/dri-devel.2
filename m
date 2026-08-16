Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890E7C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CED10E08E;
	Sun, 16 Aug 2026 14:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UE345Vg7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE03810E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 14:13:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3812600E2;
 Sun, 16 Aug 2026 14:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D71F000E9;
 Sun, 16 Aug 2026 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786889581;
 bh=l1QZPl/tceDt7rjvwQgpO08fJ1JcCsaQkuLZ65wWNZ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UE345Vg7pe7eMGO66riEFuXjYc8Ed779pF4QeydSiCQoirS6kh3tXQ0Xd7fXqim18
 cgSSxuhGd1IAUrQyeiHUx890R7Gl+zTYyE2+WWxkZG4niBaUBSj/GS60V2GFVmZeed
 MMdA6IopsDRoSc+tNqAPAnAFr74Sy56lsM9J360gFNPNZMhUp7Wsdy3kNRggM9dX/Z
 QxdFUFPn8oPNVL1glTcZ8nbpO2LMBHwV6XRXC9CSVexvI0FXKcla2wqw69pdDrtd+z
 kiPhh/gsr5MyOi2lYPVNn9abJdAn8AaLJD9/omtOIcNvQCofsIJMcCUWgVxUpLUa+x
 rmY+ezMfcx+Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260816-vc4-reset-control-v1-1-896444373716@igalia.com>
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-1-896444373716@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 14:13:00 +0000
Message-Id: <20260816141301.599D71F000E9@smtp.kernel.org>
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
- [Critical] Removing the 'brcm,vc4-v3d' compatible string breaks Device Tr=
ee ABI compatibility with older Raspberry Pi firmware.
--

--- Patch [1]: [PATCH 1/4] drm/vc4: Drop the undocumented brcm,vc4-v3d comp=
atible ---
commit 0d9402a3018a535c49f9c7ef653bfa693de83e10
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/vc4: Drop the undocumented brcm,vc4-v3d compatible

This commit removes the "brcm,vc4-v3d" compatible string from the VC4 drive=
r's
match tables. It notes that the string was never part of the upstream device
tree bindings and was only kept for older Raspberry Pi firmware.

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -279,7 +279,6 @@ static const struct of_device_id vc4_dma_range_matche=
s[] =3D {
>  	{ .compatible =3D "brcm,bcm2835-hvs" },
>  	{ .compatible =3D "brcm,bcm2835-v3d" },
>  	{ .compatible =3D "brcm,cygnus-v3d" },
> -	{ .compatible =3D "brcm,vc4-v3d" },

[Severity: Critical]
Does removing this compatible string break Device Tree ABI compatibility?

The commit message mentions that firmware device trees predating v4.6
(released in 2016) use this string. Since the Linux kernel generally
treats Device Tree as a stable ABI, will dropping this cause users
who upgrade their kernel but not their boot firmware to lose DMA
range matching and 3D hardware acceleration?

>  	{}
>  };
> =20
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -531,7 +531,6 @@ static void vc4_v3d_dev_remove(struct platform_device=
 *pdev)
>  const struct of_device_id vc4_v3d_dt_match[] =3D {
>  	{ .compatible =3D "brcm,bcm2835-v3d" },
>  	{ .compatible =3D "brcm,cygnus-v3d" },
> -	{ .compatible =3D "brcm,vc4-v3d" },

[Severity: Critical]
Similarly here in vc4_v3d_dt_match, does removing this prevent the VC4
V3D driver from successfully probing on those older firmware device trees?

>  	{}
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-vc4-reset-=
control-v1-0-896444373716@igalia.com?part=3D1
