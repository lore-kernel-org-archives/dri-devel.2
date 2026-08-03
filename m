Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9426FC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F6010E095;
	Mon,  3 Aug 2026 22:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e3XA8O1Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241AE10E095
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 22:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEE4C42D64;
 Mon,  3 Aug 2026 22:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436A91F000E9;
 Mon,  3 Aug 2026 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785794740;
 bh=t4+bB7QQg6y/MQLtzf7G+0/TvCrngQciZKMMPoqShbY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e3XA8O1YsM7ds8iuZfQ8E9zb7IAr/ig0C+57TtZXFXkABEALaUrhVtEn0ZbbUmGpN
 CjE/sYD4T/tqFmVNMUTIDH2hPsjhLD8o6HkiFzcUn2Fh8kSQDGNROmstjiOHWC+YPi
 EG9O1e8yZ7Ij/L7cd44BIiYElatF6K7O/s5vfqVewQicKV/1jJNbuYcKJjGINEdg3R
 8x235sWBZOkQTVlJZURQZ8DLwuZlMVuyj/z1zpQrGA/MnZOnwa49d++U/IPzuYVzsg
 G4zqoYihnoBDgUuYaCrKRQWz+CbNpEZ6NLFPGl7gkGYNfjlp/HQj6ctdNzLk8HYZgM
 d2HcqSec867DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/iccsense: fix memory leak in
 nvkm_iccsense_oneinit
To: "Muhammad Bilal" <meatuni001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803215022.172201-1-meatuni001@gmail.com>
References: <20260803215022.172201-1-meatuni001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:05:39 +0000
Message-Id: <20260803220540.436A91F000E9@smtp.kernel.org>
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
- [High] Branching on uninitialized memory triggers undefined behavior and =
potential out-of-bounds heap read.
--

--- Patch [1]: [PATCH] drm/nouveau/iccsense: fix memory leak in nvkm_iccsen=
se_oneinit ---
commit db41910973f19f5f6b73007149784b3d74245e81
Author: Muhammad Bilal <meatuni001@gmail.com>

drm/nouveau/iccsense: fix memory leak in nvkm_iccsense_oneinit

This commit fixes a memory leak in nvkm_iccsense_oneinit() where the
stbl.rail array allocated by nvbios_iccsense_parse() was never freed.
The array is now correctly freed in a common exit path that handles both
success and error conditions.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> index 3ccdbbe2fad09..6bfe4913dcb66 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
> @@ -239,6 +239,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
>  		return 0;
> =20
>  	iccsense->data_valid =3D true;
> +	ret =3D 0;
>  	for (i =3D 0; i < stbl.nr_entry; ++i) {
>  		struct pwr_rail_t *pwr_rail =3D &stbl.rail[i];

[Severity: High]
This is a pre-existing issue, but could this read uninitialized memory?

In drivers/gpu/drm/nouveau/nvkm/subdev/bios/iccsense.c, the function
nvbios_iccsense_parse() allocates the rail array using kmalloc_objs(),
which does not zero memory:

    iccsense->rail =3D kmalloc_objs(struct pwr_rail_t, cnt);

Inside its parsing loop, if nvbios_extdev_parse() fails, it skips
initialization of the remaining fields:

    if (nvbios_extdev_parse(bios, rail->extdev_id, &extdev))
        continue;

This leaves rail->resistor_count and rail->resistors uninitialized.

Then, back here in nvkm_iccsense_oneinit(), we read
pwr_rail->resistor_count:

    if (pwr_rail->mode !=3D 1 || !pwr_rail->resistor_count)
        continue;

If the uninitialized resistor_count happens to be non-zero, this loop
could execute using that garbage value and access memory out of bounds:

    for (r =3D 0; r < pwr_rail->resistor_count; ++r) {
        ...
        struct pwr_rail_resistor_t *res =3D &pwr_rail->resistors[r];

Should nvbios_iccsense_parse() zero the allocated memory to prevent this?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803215022.1722=
01-1-meatuni001@gmail.com?part=3D1
