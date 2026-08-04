Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996BEC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED61710E160;
	Tue,  4 Aug 2026 13:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QYWl5dlA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3301310E160
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:20:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3C2643C87;
 Tue,  4 Aug 2026 13:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B941F000E9;
 Tue,  4 Aug 2026 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785849621;
 bh=g76ZvUHuKVeTsJM2bCFmFYtkrtWBGB+VZWMCWB4lZ50=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QYWl5dlApVaqYeE6ye5gScptMt2US/V+EYEnhlqEAUTMvbaDd/sPhLifVsN/C4QAP
 GoAurg8Yf/whDSRHVbvrODJp5435V38DIAvfz7r4zanFHCHqr++b5N8aUMSwwxx5nS
 +ogCNxJtmzsueKDxWh+BNgwYOPxPYONDe5yDoPRxGOtFcVEWBITPOC9cCStM5oxVGX
 n4XNAJ6HG2P74aOV/QuyIFHz2ZYS9JTA81d9AuwUMtb9273d9D/I4sWwuZg52ls77x
 MtoPZ8daJuH3k7sdcR15yfqtZISVoYE3aEmRzxehwfDw1Jb2175VIT/OvElsITMfsj
 F1jUXjUU740Bg==
From: sashiko-bot@kernel.org
Subject: Re: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-7-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:20:21 +0000
Message-Id: <20260804132021.97B941F000E9@smtp.kernel.org>
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
- [High] Missing drm_mode_object_unregister() in colorop cleanup paths leav=
es dangling pointers in the DRM object IDR.
- [High] Missing NULL check for kasprintf leads to crash during color pipel=
ine property creation.
- [High] Error cleanup path in intel_color_pipeline_plane_add_colorop crash=
es when colorop initialization fails early.
--

--- Patch [6]: [v6 6/9] drm/i915/color: Add support for 1D LUT in SDR plane=
s ---
commit b0190470a3e343638c9aa8e156a26be16a13657a
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add support for 1D LUT in SDR planes
   =20
This commit extends the SDR plane color pipeline to include a post-CSC 1D
LUT block. It simplifies the YUV to RGB pipeline by dropping the pre-CSC
LUT.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index efd4375c43318..53e55ce0a5a35 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -45,6 +45,7 @@ static const enum intel_color_block hdr_plane_pipeline[=
] =3D {
> =20
>  static const enum intel_color_block sdr_plane_yuv_pipeline[] =3D {
>  	INTEL_PLANE_CB_CSC_FF,
> +	INTEL_PLANE_CB_POST_CSC_LUT,
>  };

[Severity: High]
This is a pre-existing issue, but I have a question about the cleanup path
when initializing these colorops. If colorop initialization fails halfway
(for example, if drm_property_create_enum fails in drm_plane_colorop_init
after drm_mode_object_add), the error path calls intel_colorop_destroy
which delegates to drm_colorop_cleanup:

void drm_colorop_cleanup(struct drm_colorop *colorop)
{
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
	config->num_colorop--;
...

Is a call to drm_mode_object_unregister() missing here before the caller
frees the memory? It seems this could leave dangling pointers in the DRM
object IDR, which might be exploitable via DRM_IOCTL_MODE_OBJ_GETPROPERTIES.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
intel_color_pipeline_plane_add_colorop handle early initialization failures
safely?

intel_color_pipeline_plane_add_colorop()
...
cleanup:
	intel_colorop_destroy(&colorop->base);
	return ERR_PTR(ret);

If an initialization function like drm_plane_colorop_curve_1d_lut_init
fails early inside drm_plane_colorop_init (such as when drm_mode_object_add
fails), colorop->dev is left as NULL and the head list node is uninitialize=
d.
When drm_colorop_cleanup accesses dev->mode_config.num_colorop, could this
cause a NULL pointer dereference and an invalid list_del?

[Severity: High]
This is another pre-existing issue in the color pipeline setup code. I
noticed a potential issue in _intel_color_pipeline_plane_init where
kasprintf is used without checking the return value:

_intel_color_pipeline_plane_init()
...
	list->type =3D colorop[0]->base.base.id;
	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", colorop[0]->base=
.base.id);

	return 0;

Can this lead to a crash if kasprintf fails? If list->name is NULL, the
function still returns success. This NULL name is then passed through to
drm_plane_create_color_pipeline_property and eventually drm_property_add_en=
um,
where WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN) could oops when attempti=
ng
to dereference the NULL pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123107.2256=
124-1-chaitanya.kumar.borah@intel.com?part=3D6
