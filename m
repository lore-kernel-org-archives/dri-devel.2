Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331D3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610B810F2A1;
	Wed,  8 Jul 2026 20:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="orG62lzs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2F610F2A1
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 20:32:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2CD34045C;
 Wed,  8 Jul 2026 20:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7F61F000E9;
 Wed,  8 Jul 2026 20:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783542747;
 bh=3g8iO87UsReVGV5ldYk9eEYjHqhXhPvqZ6oUAVtjxaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=orG62lzs0ZVukqF2N2oM4m1Gx4/IXZOpiQ3SpO/8fm/XnaAxg/FKBfGyLa/GOKgxG
 81pzmkLpKTvyo7aEJfTcsR5ZPLMQUX7RJ7MTpdvJmjE16cPq1ZkJdCm4OOlKCTZGEx
 yxYnjTE6yG8snmeXg6nWLzzFdUPeGWm2T2L8aVUdBjhwJd01PssUOGya+GB4U1Ry60
 8CTibk8vWSUKsHgrmXPjz6Fsb/1UajdGpQW2aZ1nxxLjbQYejs9YKDJwNCYj3gX7vo
 klg4rqSOZfVJNqKN73ArZH9EYqs3/JAMC2TYSSmS4lw59aAjQYc86iXJoustjhO7Ko
 0T/DXCxFN6D3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imx: Fix ipu_plane_duplicate_state() OOM handling
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260708202124.12560-1-osama.abdelkader@gmail.com>
References: <20260706140246.41506-1-osama.abdelkader@gmail.com>
 <20260708202124.12560-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:32:27 +0000
Message-Id: <20260708203227.8F7F61F000E9@smtp.kernel.org>
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
- [High] The PRE resource allocation in `ipu_planes_assign_pre()` does not =
track global state, allowing resource overcommit across multiple CRTCs and =
leading to silent hardware configuration failures.
--

--- Patch [1]: [PATCH v2] drm/imx: Fix ipu_plane_duplicate_state() OOM hand=
ling ---
commit e059dd54b800a823912e85c46d6931922398d1c7
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/imx: Fix ipu_plane_duplicate_state() OOM handling

This patch fixes a potential NULL pointer dereference in
ipu_plane_duplicate_state(). When kmalloc_obj() fails, the function now
returns NULL properly instead of unconditionally returning &state->base.

> diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/im=
x/ipuv3/ipuv3-plane.c
> index c7ec09e557c19..67f2da7f2b65e 100644
> --- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> +++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> @@ -323,9 +323,10 @@ ipu_plane_duplicate_state(struct drm_plane *plane)
>  		return NULL;
> =20
>  	state =3D kmalloc_obj(*state);
> -	if (state)
> -		__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
> +	if (!state)
> +		return NULL;
> =20
> +	__drm_atomic_helper_plane_duplicate_state(plane, &state->base);
>  	return &state->base;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a pre-existing issue with PRE resource allocation.

In ipu_planes_assign_pre(), the available_pres counter is reset to the syst=
em
maximum on every atomic commit:

drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c:ipu_planes_assign_pre() {
...
	int available_pres =3D ipu_prg_max_active_channels();
...
	for_each_new_plane_in_state(state, plane, plane_state, i) {
...
		ipu_state->use_pre =3D true;
		available_pres--;
...
}

Does this allow resource overcommit across multiple CRTCs if they are
configured independently via separate atomic commits, since it ignores glob=
ally
active PREs from other CRTCs?

Additionally, in ipu_plane_atomic_update(), the return value of
ipu_prg_channel_configure() is ignored:

drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c:ipu_plane_atomic_update() {
...
		axi_id =3D ipu_chan_assign_axi_id(ipu_plane->dma);
		ipu_prg_channel_configure(ipu_plane->ipu_ch, axi_id, width,
					  height, fb->pitches[0],
					  fb->format->format, fb->modifier,
					  &eba);
...
}

If a PRE acquisition fails, will this silently drop the error and program t=
he
hardware with invalid state? Could this cause the IPU to read raw, potentia=
lly
tiled memory directly if the expected SRAM buffer address is not mapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708202124.1256=
0-1-osama.abdelkader@gmail.com?part=3D1
