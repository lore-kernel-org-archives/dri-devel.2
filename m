Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A83CCD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F8410E592;
	Tue,  9 Jun 2026 17:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lv5ri84F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DDD10E592
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:32:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2149C4006C;
 Tue,  9 Jun 2026 17:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFC61F00893;
 Tue,  9 Jun 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781026366;
 bh=KHfEZlSR9fKKOkrCX3/gB7FGOAV3vPfh0KzIZa6G/b8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lv5ri84FxZpSgrgnOcc8NZsJxAqx2LGocQE6Rne81QHhRjVb1okJP9lRhWd7K+hPL
 saPDDoUU2qXczEXtOiEMgpV/3tIpJZQzi96IobV8eGQ+mt/rhw7GhZpJiUbs9ppeSa
 UkstxX/w4E3sPyB0Kewov6Yd7ntBEYDuPuve3mhOZlK5v/sAldCX9Ej+2qTGg1Bgdt
 RiISBgUgzSMvgC0o/efmn/bDvaLH8vklypkiD2sb7lsTrCd7cg+7D8soT1lNzPVlXl
 IkYhIkapW5sNLoW3Y1gw1taaAtKqSlqSp6ImWelDw+wSv2NDoQq3XDBfO36v+gjV1Z
 0yW6N5EFLL+hA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] drm/i915/colorop: Update to new pipeline API
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609171941.169104-4-John.Harrison@Igalia.com>
References: <20260609171941.169104-4-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 17:32:45 +0000
Message-Id: <20260609173245.DCFC61F00893@smtp.kernel.org>
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
- [Critical] Missing `drm_mode_object_unregister()` in colorop cleanup leav=
es dangling pointers in the DRM device IDR.
- [High] If colorop initialization fails early, the cleanup path will uncon=
ditionally dereference uninitialized pointers, causing a kernel panic.
- [High] Missing error handling for `kasprintf` leads to a NULL pointer der=
eference when creating the pipeline property.
--

commit 430890cda6ad288f9a83188f2b716cf9737d8c83
Author: John Harrison <John.Harrison@Igalia.com>

drm/i915/colorop: Update to new pipeline API

Switch to using the new method for building colorop pipelines.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 6cf8080ee8000..49dac9627553a 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c

[ ... ]

> @@ -100,8 +100,10 @@ struct intel_colorop *intel_color_pipeline_plane_add=
_colorop(struct drm_plane *p
>  	if (ret)
>  		goto cleanup;
> =20
> -	if (prev)
> -		drm_colorop_set_next_property(&prev->base, &colorop->base);
> +	if (!*pipeline)
> +		*pipeline =3D &colorop->base;
> +
> +	drm_colorop_add_to_pipeline(*pipeline, &colorop->base);
> =20
>  	return colorop;

[Severity: High]
This isn't a bug introduced by this patch, but if the colorop initialization
fails before this point, the code jumps to the cleanup label:

	cleanup:
		intel_colorop_destroy(&colorop->base);
		return ERR_PTR(ret);

Could this unconditionally dereference an uninitialized pointer?

The colorop was just allocated, so colorop->dev is NULL.
Calling intel_colorop_destroy() invokes drm_colorop_cleanup(), which
attempts to dereference colorop->dev and call list_del(&colorop->head),
resulting in a NULL pointer dereference.

[Severity: Critical]
This is another pre-existing issue in the teardown path.

If a colorop is later destroyed (either here in the error path, or during
general teardown), drm_colorop_cleanup() is called:

	void drm_colorop_cleanup(struct drm_colorop *colorop)
	{
		...
		list_del(&colorop->head);
		config->num_colorop--;

		if (colorop->state)
			drm_colorop_atomic_destroy_state(colorop,
							 colorop->state);
	}

Is this missing a call to drm_mode_object_unregister()?

The object is registered with the DRM device IDR via drm_mode_object_add()
during initialization. Omitting drm_mode_object_unregister() leaves a
dangling pointer in dev->mode_config.object_idr, which could lead to a
use-after-free or a system crash during device teardown.

[ ... ]

> @@ -132,14 +134,12 @@ int _intel_color_pipeline_plane_init(struct drm_pla=
ne *plane, struct drm_prop_en
>  	}
> =20
>  	for (i =3D 0; i < pipeline_len; i++) {
> -		colorop[i] =3D intel_color_pipeline_plane_add_colorop(plane, prev,
> +		colorop[i] =3D intel_color_pipeline_plane_add_colorop(plane, &pipeline=
_root,
>  								    pipeline[i]);
>  		if (IS_ERR(colorop[i])) {
>  			ret =3D PTR_ERR(colorop[i]);
>  			goto cleanup;
>  		}
> -
> -		prev =3D colorop[i];
>  	}
> =20
>  	list->type =3D colorop[0]->base.base.id;

[Severity: High]
This is a pre-existing issue, but right after this line in
_intel_color_pipeline_plane_init(), there is an unchecked kasprintf():

	list->type =3D colorop[0]->base.base.id;
	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ...);

	return 0;

If this allocation fails under memory pressure, list->name is set to NULL
and the function unconditionally returns 0 (success).

Could this cause a NULL pointer dereference later when
drm_plane_create_color_pipeline_property() passes this name to
drm_property_create_enum() and drm_property_add_enum(), which performs a
strlen(name)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609171941.1691=
04-1-John.Harrison@Igalia.com?part=3D3
