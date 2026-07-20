Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C30EC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C4210E65B;
	Mon, 20 Jul 2026 05:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="khO1aUeN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD8810E65B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:39:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCA8E60A8B;
 Mon, 20 Jul 2026 05:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6EC1F00A3A;
 Mon, 20 Jul 2026 05:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525941;
 bh=QJWerBtgXAVOq1V3dxFKySibApRMngkMrWeKZrL3OAg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=khO1aUeN4B+6w8RYgjAgWtpXsTB472o2VVJqtyxBY/3Qlu+niBo1H5ukWWbPfVxa5
 Gvu3L3OG7cNgaUXT0ZCgXpsbjwRtDy08mH0qt1jmAmMhSdtlthbk21wPxvRxZ1o5Nh
 UxybX50PXenUsXjPIfhw5FVJ68eAlZ7L+ycdHVGVXVfMRIRZr/f5Q4Hd37Tunsa2VS
 icHCiKRGoZT4pv0A41yF2KTk4pHIogBl7CeAGVV9uKIkmBZqziUnv7MwRRjz3VsxRG
 nidJZ8BOSgSpMvRCz1gRY6z/na/7s2YUrIcMAzTNIy5/dsfbGHtOeZzX8CYxcIwxUV
 TikoxezCig4dw==
From: sashiko-bot@kernel.org
Subject: Re: [v5 14/14] drm/i915/color: Add color pipeline support for SDR
 planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-15-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-15-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:39:01 +0000
Message-Id: <20260720053901.7C6EC1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A missing NULL check for the `kasprintf()` allocation in `_intel_c=
olor_pipeline_plane_init()` causes a NULL pointer dereference in `drm_prope=
rty_add_enum()`.
- [High] Early initialization failures during colorop creation cause `drm_c=
olorop_cleanup()` to access uninitialized structure members, leading to a c=
rash.
- [High] Missing `drm_mode_object_unregister()` in `drm_colorop_cleanup()` =
leaves destroyed colorops in the DRM object IDR, leading to a Use-After-Fre=
e.
--

--- Patch [14]: [v5 14/14] drm/i915/color: Add color pipeline support for S=
DR planes ---
commit 898c62da94ca7a00530f154f1e3d4b18c45aaa47
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add color pipeline support for SDR planes

This commit exposes the SDR plane color pipeline to user-space by removing
the check that previously limited it to HDR planes.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 136b9378ca484..a99b6eb204488 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -188,17 +188,11 @@ int _intel_color_pipeline_plane_init(struct drm_pla=
ne *plane, struct drm_prop_en
> =20
>  int intel_color_pipeline_plane_init(struct drm_plane *plane, enum pipe p=
ipe)
>  {
> -	struct drm_device *dev =3D plane->dev;
> -	struct intel_display *display =3D to_intel_display(dev);
>  	struct drm_prop_enum_list pipelines[MAX_COLOR_PIPELINES] =3D {};
>  	int len =3D 0;
>  	int ret =3D 0;
>  	int i;
> =20
> -	/* Currently expose pipeline only for HDR planes */
> -	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
> -		return 0;
> -
>  	/* Add pipeline consisting of transfer functions */
>  	ret =3D _intel_color_pipeline_plane_init(plane, &pipelines[len], pipe);

[Severity: High]
This isn't a bug introduced by this patch, but opening this up to SDR planes
makes a pre-existing issue more reachable.

In _intel_color_pipeline_plane_init(), kasprintf() can fail and return NULL
under memory pressure:

	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d",=20
			       colorop[0]->base.base.id);

Because there is no check for failure, a NULL name gets passed down to
drm_plane_create_color_pipeline_property(), then to drm_property_create_enu=
m(),
and finally to drm_property_add_enum(), which dereferences it during=20
strlen(name) and crashes. Should we add a NULL check for kasprintf() in=20
_intel_color_pipeline_plane_init()?

[Severity: High]
This is also a pre-existing issue, but since we are expanding the usage of
this pipeline:

If an early initialization failure occurs in
intel_color_pipeline_plane_add_colorop() (such as drm_mode_object_add()
returning an error), the cleanup path calls intel_colorop_destroy() which
invokes drm_colorop_cleanup().

At this point, drm_colorop_cleanup() will dereference colorop->dev:

void drm_colorop_cleanup(struct drm_colorop *colorop)
{
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;
        ...

If drm_mode_object_add() failed, colorop->dev remains NULL, causing an
immediate crash. Additionally, list_del(&colorop->head) is called on a
zero-initialized list node. Can this cleanup path be made safe for objects
that failed early initialization?

[Severity: High]
This is another pre-existing issue exposed by the expanded plane support:

If a colorop initialization fails midway (for instance, if
drm_property_create_enum() fails after drm_mode_object_add() succeeds),
the error path calls drm_colorop_cleanup() to free the memory.

However, drm_colorop_cleanup() does not call drm_mode_object_unregister().
This leaves a freed object pointer in the DRM device's object IDR. Is there
a risk that a user could trigger a use-after-free by passing the leaked
object ID to an ioctl like DRM_IOCTL_MODE_OBJ_GETPROPERTIES?

>  	if (ret)
>  		goto out;
>  	len++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D14
