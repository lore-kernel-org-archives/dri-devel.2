Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92ECCD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385B110E2D8;
	Tue,  9 Jun 2026 12:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XJwjR38o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4396C10E2C3
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:33:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCBA7601DC;
 Tue,  9 Jun 2026 12:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5B91F00893;
 Tue,  9 Jun 2026 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781008394;
 bh=RZaWT7CQ6+AcNlhrJzRi29j6OduPvon/HiNSbWdHKj8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XJwjR38oZ/ytf+r+xpKFlLQWuWlHCKVrqsCFHq1KlYEm+PoPKbhnjpPR1q/GVCUT/
 OlUxGO116n9/oUf/Jpi4xR+2IBwQI6RqLDG0zG3tRTvBZemjMmQUxfbmhGGYQfuYsY
 LHhT1qGOnyMnsBfRP2aZwbEoEYxJCpuL645eYQLvKfj+XEcaNrvt7A0V1YsU/n1Diw
 90D+VCC0FBleyQHAIFj5t8lj1ALJwf3iw0d55d2W7vPdEIG2oE9S5aJcS4V6GKn5q1
 wA5nhkck+L4odhLP4V8dJwuGXUiu4k0pK/pqmgsfjwRxYRZFLojwNvLtwhoDXOME7Y
 WYm6auIRn6LrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] drm/amd/display: truly bypass plane colorop 3x4
 matrix and hdr mult
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-5-mwen@igalia.com>
References: <20260609121230.1358786-5-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:33:13 +0000
Message-Id: <20260609123314.4C5B91F00893@smtp.kernel.org>
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
- [High] Dereference of `blob->length` when `blob` is NULL in `__set_dm_pla=
ne_colorop_3x4_matrix`.
--

commit e38d376afd75d8310bd23096e9f3d253c0d99c70
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: truly bypass plane colorop 3x4 matrix and hdr mult

This commit addresses a latent issue where the driver skips programming the
3x4 matrix and hdr multiplier blocks on bypass. It updates the driver to
explicitly reset these blocks to their default values if the bypass
property is set.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 86086d10c5435..13ad7ac1e35e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1579,7 +1579,13 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane=
_state *plane_state,
>  		}
>  	}
> =20
> -	if (colorop_state && !colorop_state->bypass && colorop->type =3D=3D DRM=
_COLOROP_CTM_3X4) {
> +	if (colorop_state && colorop->type =3D=3D DRM_COLOROP_CTM_3X4) {
> +		if (colorop_state->bypass) {
> +			dc_plane_state->gamut_remap_matrix.enable_remap =3D false;
> +			dc_plane_state->input_csc_color_matrix.enable_adjustment =3D false;
> +			return 0;
> +		}
> +
>  		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
>  		blob =3D colorop_state->data;
>  		if (blob->length =3D=3D sizeof(struct drm_color_ctm_3x4)) {

[Severity: High]
This isn't a bug introduced by this patch, but can blob be NULL here when
colorop_state->bypass is false?

Looking at __set_dm_plane_colorop_3x4_matrix(), the DRM API allows userspace
to unset the data property (for instance, by passing 0 for the blob ID).
This would result in colorop_state->data being NULL.=20

If userspace sets bypass to false while providing no data blob, would the
unconditional dereference of blob->length lead to a NULL pointer dereference
and a kernel crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D4
