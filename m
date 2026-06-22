Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE0CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1478F10E4D7;
	Mon, 22 Jun 2026 07:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cAN1trb6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B4B10E4DF
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62703601EE;
 Mon, 22 Jun 2026 07:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A4C1F00A3A;
 Mon, 22 Jun 2026 07:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782112274;
 bh=nxPx5JrA5c4tH2FjQ4armtKIAHePyOu7Xj/y/kwrX4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cAN1trb6+BqvFcgrgAPhymk/WJseyv1cWh2PVBBoGerhJXmZLCp0Fozkt7+BXPUbr
 AydjZRD/GjL5nb6VjSenEddAR+UWfOTCkzX4bdd1xf7zm9p2vTl02BoNuIySJWO0il
 Ga3oKJ4/NShmUh3ZH9bEPVMVjPmci2kNsU7mSB/3vc/0OGHUpMYZ336eRFH8Wur1tB
 b0A8X4yFPPkBC5Lcctb9MtaSAynyBvrirngUeuwxKSivOGFOr3HZWhGOyA3Ha8fYm6
 LF4qQY6ndXCJow0rHBrqmjtuKMGRQgiX2zW0UPKX/KJULNuseXmGozJ382Q7eLrf+h
 sz+0LApoZlj+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] drm/tegra: vic: Add Tegra264 support
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260622-t264-host1x-v2-6-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-6-ff7364d9ff7b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:11:13 +0000
Message-Id: <20260622071113.D2A4C1F00A3A@smtp.kernel.org>
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
- [Critical] Error paths in vic_load_firmware leave a dangling pointer in v=
ic->falcon.firmware.virt, causing Use-After-Free and Double Free.
--

commit c58aa87e57c2ab3ec5383df99d29ec8f6a79e162
Author: Mikko Perttunen <mperttunen@nvidia.com>
Subject: drm/tegra: vic: Add Tegra264 support

Add support for VIC on Tegra264. The Tegra264 VIC uses a RISC-V based
Falcon microcontroller instead of the traditional Falcon previously,
and has the TRANSCFG register in a different place.

> diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
> index 332c9b563d3f4..46c7e00de3473 100644
> --- a/drivers/gpu/drm/tegra/vic.c
> +++ b/drivers/gpu/drm/tegra/vic.c

[ ... ]

> @@ -302,7 +330,6 @@ static int vic_load_firmware(struct vic *vic)
>  	return err;
>  }
> =20

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential use-after-free and
double-free in the error handling of vic_load_firmware().

When memory allocation succeeds, the pointers are assigned:

	vic->falcon.firmware.virt =3D virt;
	vic->falcon.firmware.iova =3D iova;

If a subsequent step fails (such as falcon_load_firmware() or
dma_map_single()), the code jumps to the cleanup label, frees the memory,
but does not clear the pointer:

cleanup:
	if (!client->group)
		dma_free_coherent(vic->dev, size, virt, iova);
	else
		tegra_drm_free(tegra, size, virt, iova);

	mutex_unlock(&lock);
	return err;

If vic_load_firmware() is called again (for example, during the next PM run=
time
resume), it sees the non-NULL pointer, assumes the firmware is loaded, and
returns 0.

Will this cause the driver to program the hardware to DMA from the freed me=
mory?

Furthermore, when the device is unbound, will the teardown path uncondition=
ally
free vic->falcon.firmware.virt again causing a double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-t264-host1=
x-v2-0-ff7364d9ff7b@nvidia.com?part=3D6
