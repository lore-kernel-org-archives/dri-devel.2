Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76157C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C3F10E667;
	Mon, 20 Jul 2026 05:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VLZ1dP6O";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7557610E667
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:28:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74E8360103;
 Mon, 20 Jul 2026 05:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3191F000E9;
 Mon, 20 Jul 2026 05:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525309;
 bh=CGk1fyNcabY+ttwl/iRAd6l0MKbcUyXP1C85AmEryqA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VLZ1dP6O7G51qpyQJt0njUq05MvViHKzAhL7zm8LLi93YKP69QnFsbOLnVPF965sn
 /eT7LXOugCJ9B+vcXSrY8s1L4Qi8ENcDurMrfqbtpyTVZ3uuX5kiJVaFbmyyAkIKGw
 lb3rHIwaHulsl6rX2PMDd3LWT3dL6zQsCVtfAWp+2/z5bDsIOnkLizkIkvTDXWmfEB
 93/l5ZLI/9d88F7YrgBpvfNyYyAB5bDDqWx0tpxIEOCBqc3QGJcD9nFDqs1bgWZOJN
 kS+ndiPx0mhHzRjE251BwR1kDewyjhSHlddaBdV4QRtyI3Se259gngXSXyYNbC8wwv
 mQ+7EriDGDjHw==
From: sashiko-bot@kernel.org
Subject: Re: [v5 09/14] drm/i915/color: Add support for 1D LUT in SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-10-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-10-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:28:28 +0000
Message-Id: <20260720052829.0B3191F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if colorop initi=
alization fails early, the cleanup path calls `intel_colorop_destroy()` on =
a partially initialized object, leading to a NULL pointer dereference and u=
ninitialized list head usage.
- [High] This problem wasn't introduced by this patch, but an unchecked ret=
urn value from `kasprintf()` leads to a NULL pointer dereference when creat=
ing the color pipeline property.
--

--- Patch [9]: [v5 09/14] drm/i915/color: Add support for 1D LUT in SDR pla=
nes ---
commit e6938001b7cb4179a20fa4b4c3bd94fef8282c50
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add support for 1D LUT in SDR planes

Extend the SDR plane color pipeline to include pre- and post-CSC 1D LUT blo=
cks.
SDR planes use a smaller LUT size than HDR planes and therefore initialize =
the
1D LUT colorops with the appropriate hardware capacity.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 7457fa51cb97a..136b9378ca484 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c

[ ... ]

> @@ -81,7 +86,9 @@ struct intel_colorop *intel_color_pipeline_plane_add_co=
lorop(struct drm_plane *p
>  		ret =3D drm_plane_colorop_curve_1d_lut_init(dev,
>  							  &colorop->base, plane,
>  							  &intel_colorop_funcs,
> -							  PLANE_DEGAMMA_SIZE,
> +							  is_hdr ?
> +							  PLANE_DEGAMMA_SIZE :
> +							  PLANE_DEGAMMA_SIZE_SDR,
>  							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
>  							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>  		break;

[Severity: High]
This isn't a bug introduced by this patch, but if colorop initialization fa=
ils
early, the cleanup path calls intel_colorop_destroy() on a partially
initialized object. Could this lead to a NULL pointer dereference and
uninitialized list head usage?

If drm_plane_colorop_init() fails early (e.g., drm_mode_object_add() returns
-ENOMEM), colorop->dev remains NULL and colorop->head is zero-filled. The e=
rror
path jumps to cleanup and invokes intel_colorop_destroy(), which delegates =
to
drm_colorop_cleanup():

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
    struct drm_mode_config *config =3D &dev->mode_config;

    list_del(&colorop->head);
    config->num_colorop--;
}

This unconditionally dereferences dev (which is NULL) and calls list_del() =
on a
zero-filled list head.

[Severity: High]
This is also a pre-existing issue in the same file, but an unchecked return
value from kasprintf() can lead to a NULL pointer dereference when creating=
 the
color pipeline property.

In _intel_color_pipeline_plane_init(), kasprintf() allocates memory for
list->name:

drivers/gpu/drm/i915/display/intel_color_pipeline.c:_intel_color_pipeline_p=
lane_init() {
    ...
    list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", colorop[0]->b=
ase.base.id);

    return 0;
}

If kasprintf() fails, it returns NULL, and the function unconditionally ret=
urns
success. This NULL name is later passed to drm_property_add_enum(), where a
strlen(name) call will crash the kernel:

drivers/gpu/drm/drm_property.c:drm_property_add_enum() {
    ...
    if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
        return 0;
    ...
}

Should the return value of kasprintf() be checked and handled as an error h=
ere?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D9
