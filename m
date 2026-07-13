Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAC7C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537A510E557;
	Mon, 13 Jul 2026 05:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="net0ku3T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3459710E557
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF60E4023D;
 Mon, 13 Jul 2026 05:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A991F000E9;
 Mon, 13 Jul 2026 05:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922383;
 bh=cJseJdTS6ZY5mrXhWloVH1y1WyNT/fwVTDryKebpJwA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=net0ku3TRUuel4/MB1has5GSxtgZD4NCR7HOr37LweIwTbQ1FloME3OUiZcypwMA8
 GZvMrOrN44nNjnMePeEb6r6kPt1MR1kGhufnT3uoRsB+YIcaNtaCMeKdwcJYywHiNg
 oRvEKkpo8/l2IMfvQKKf4bk+wk2wXmU3U8gAY4I6LXEow0PRY2kL8XKN5v7u0VhcOB
 Jur+4ZbzqW5t7Ad3To3O2pUoAHw+cvyGFJ9CSfu8Wx1TCSRxlbioSVPE51GKR4tWx3
 qop3+KITRloNlGDB0PW4+JglzofEylotSJcAbUJ8ekeuAPnbOasfpasWhyIQw/P50G
 XRI+qtZyk1G1A==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 14/14] drm/i915/color: Add color pipeline support for
 SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-15-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-15-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:59:43 +0000
Message-Id: <20260713055943.B1A991F000E9@smtp.kernel.org>
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
- [High] Missing NULL check for kasprintf() return value in _intel_color_pi=
peline_plane_init() leads to a deterministic NULL pointer dereference.
- [High] If a color operation initialization fails early, the cleanup path =
unconditionally calls drm_colorop_cleanup on a partially initialized object=
, triggering a NULL pointer dereference.
--

--- Patch [14]: [CI v4 14/14] drm/i915/color: Add color pipeline support fo=
r SDR planes ---
commit 6fb2b458fe3e54b8772eb125265bd378c4f8ec9e
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
drm/i915/color: Add color pipeline support for SDR planes

This commit exposes the SDR plane color pipeline to user-space by
removing the HDR plane restriction during initialization.

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
This is a pre-existing issue, but does _intel_color_pipeline_plane_init()=20
lack a check for kasprintf() allocation failures?

If memory allocation fails during plane initialization, kasprintf()=20
returns a NULL pointer:

_intel_color_pipeline_plane_init()
    list->name =3D kasprintf(GFP_KERNEL, ...);
    return 0;

The function then returns success (0) even though list->name is NULL.

This NULL pointer is propagated up through
drm_plane_create_color_pipeline_property(), and eventually passed to
drm_property_add_enum(), which does an unconditional strlen():

drm_property_add_enum()
    if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))

Would it be safer to check for a NULL return from kasprintf() and return
an error code like -ENOMEM?

[Severity: High]
This is also a pre-existing issue, but if a colorop fails to initialize
during the pipeline plane setup, can it cause a NULL pointer dereference=20
during cleanup?

If an error occurs early in intel_color_pipeline_plane_add_colorop()=20
(for example, if drm_mode_object_add() fails to allocate an ID), the=20
cleanup path unconditionally invokes intel_colorop_destroy():

intel_color_pipeline_plane_add_colorop()
    ...
    cleanup:
        intel_colorop_destroy(&colorop->base);

This calls into drm_colorop_cleanup() with a partially initialized object=20
where colorop->dev is still NULL, leading to a dereference:

drm_colorop_cleanup()
    struct drm_device *dev =3D colorop->dev;
    struct drm_mode_config *config =3D &dev->mode_config;=20
    ...
    list_del(&colorop->head);

Since colorop->dev is NULL, &dev->mode_config will trigger a dereference,=20
and list_del() will be called on a zeroed list_head. Could this error path=
=20
be reached if there is resource exhaustion during plane initialization?

>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D14
