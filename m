Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1982C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE6E896C7;
	Tue,  1 Sep 2026 08:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WcfndFjQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F46896C7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:46:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69E51415FD;
 Tue,  1 Sep 2026 08:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F41F000E9;
 Tue,  1 Sep 2026 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252369;
 bh=AlJPPyLs8UAluq5xkDkh1mf1aLBqsBreSLDg8Cgoqlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WcfndFjQfU1gLd+0SmGtNKctNYHDHjQwB7KUhcIh3UxsdIW9yR1qpoTMBl6X/2dlp
 8jk5UVlm3UitXxgS6jGPqRXJLDsqycYYmaIbqCTX/V/USm3a+rAbBk5uveSHLakpUo
 eQM7Wy9PEquX3wM6XPbuBiI9X88G8WPpAaQ0DPWy7juWFzJivxvcKnRqdZ4x482Xbc
 jEjXOgUQEU7OU+47wKIzQX5GZdFMQxfBIXViBpRYFIFPvJ95EZQ63VCNolZmjWHoKL
 ASPfLw0PRSVh4IrGJXJKTfNefumwRyFU8wPRONUo6k/xW5UatXaaAmt8adyAXRJGJJ
 rCPfyRUNfb8tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/vboxvideo: create blend mode property on planes
To: "Qinyun Tan" <qinyuntan@linux.alibaba.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901083234.1828755-5-qinyuntan@linux.alibaba.com>
References: <20260901083234.1828755-1-qinyuntan@linux.alibaba.com>
 <20260901083234.1828755-5-qinyuntan@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:46:08 +0000
Message-Id: <20260901084609.211F41F000E9@smtp.kernel.org>
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
- [High] The plane's pixel_blend_mode atomic state defaults to DRM_MODE_BLE=
ND_PREMULTI, but the driver only exposes DRM_MODE_BLEND_COVERAGE, resulting=
 in an invalid initial atomic state that causes atomic commits to fail.
--

commit e1e7e08f37513293cd7928eb76a6d3c06de1c985
Author: Qinyun Tan <qinyuntan@linux.alibaba.com>

drm/vboxvideo: create blend mode property on planes

This commit exposes a "pixel blend mode" property advertising only
DRM_MODE_BLEND_COVERAGE for vboxvideo primary and cursor planes to match
host compositing semantics and silence a DRM core warning.

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vbox=
video/vbox_mode.c
> index 8e4e5fc9d3c5a..3c41238a82685 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
[ ... ]
> @@ -540,6 +541,9 @@ static struct drm_plane *vbox_create_plane(struct vbo=
x_private *vbox,
> =20
>  	drm_plane_helper_add(plane, helper_funcs);
> =20
> +	drm_plane_create_blend_mode_property(plane,
> +					     BIT(DRM_MODE_BLEND_COVERAGE));
> +

[Severity: High]
Will this cause atomic commits to fail with -EINVAL due to an invalid
initial atomic state?

The blend mode property is restricted here to allow only
DRM_MODE_BLEND_COVERAGE. However, the primary plane uses
drm_atomic_helper_plane_reset() and the cursor plane uses
DRM_GEM_SHADOW_PLANE_FUNCS (which provides drm_gem_reset_shadow_plane()).

Both of these default reset hooks rely on
__drm_atomic_helper_plane_state_reset(), which unconditionally hardcodes
the initial state to PREMULTI:

__drm_atomic_helper_plane_state_reset() {
    ...
    state->pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
    ...
}

Since the driver does not provide a custom reset hook to override this
default and explicitly set plane_state->pixel_blend_mode to
DRM_MODE_BLEND_COVERAGE, does this leave the initial atomic state set to a
mode (PREMULTI) that isn't supported by the property?=20

If generic compositors read this initial state and pass it back during
commits, will the DRM core's validation reject it because the property
only exposes COVERAGE?

>  	return plane;
> =20
>  free_plane:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083234.1828=
755-1-qinyuntan@linux.alibaba.com?part=3D4
