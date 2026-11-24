Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A1606A331
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KVf5PDKD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5478D10F858;
	Tue, 24 Nov 2026 18:46:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529FF10F856;
 Tue, 24 Nov 2026 18:46:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED11645A90;
 Tue, 24 Nov 2026 18:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F4D1F000E0;
 Tue, 24 Nov 2026 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545976;
 bh=SdvtQ/ai3Toj6Hil3hMgLoYaomRBbKKf9m4kW3nPaHU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KVf5PDKDC7KB9RiLpT0KIAY4QnmwiT1bChDLv6MXMJ0NPHWRh1xyNpP2Zvbi4JZ+N
 89RUxAVfYn+yBz08zOSH2XqbyD8mU5c41oTL3RKuxryYX+OGnEQM/gTKLhUWy81Zc4
 qVpd1uLH77lBL8fGNCd1mROoLmwvYktpAmHHHsJ01xlbyivNgyMnn3NcjPHJVq3Asz
 mpRc6C07eOhA7ajzP6iv5VuclnGEs5JQQ5SNMJ/sgGZwHj1vQRtJgUPxd/ri4JB7oN
 fbbtckMdCOZ0tOq3atKgTTwxSWIUGjk+38VBYLiIKuzQsa//UVgVVoEvPdwS9KHE2C
 FZYMkh58W9Hfw==
Message-ID: <sashiko-outbox-231850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/19] drm/amd/display: enable post-blend CTM colorop
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-18-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-18-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:46:15 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amd/display: NULL deref on kasprintf() failure in CRTC
  pipeline init
- [Medium] drm/amd/display: missing error unwind in
  amdgpu_dm_crtc_init()
--

commit a6af21490f0a9bf347d95f27bc66b20a42758591
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: enable post-blend CTM colorop

This commit initializes the AMD post-blend color pipeline on DCN 3.0 and
newer with a 3x4 CTM colorop and programs it when a CRTC color pipeline is
active.

Link: https://dri.freedesktop.org/docs/drm/gpu/amdgpu/display/display-manag=
er.html#dc-color-capabilities-between-dcn-generations

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index c6bb9fec92175..dcd497b644c11 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -305,3 +305,41 @@ int amdgpu_dm_initialize_default_pipeline(struct drm=
_plane *plane, struct drm_pr
>  	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, list);
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
> +
> +int amdgpu_dm_initialize_crtc_default_pipeline(struct drm_crtc *crtc,
> +					       struct drm_prop_enum_list *list)
> +{
> +	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
> +	struct drm_device *dev =3D crtc->dev;
> +	int ret;
> +	int i =3D 0;
> +
> +	memset(ops, 0, sizeof(ops));
> +
> +	/* 3x4 matrix */
> +	ops[i] =3D kzalloc_obj(struct drm_colorop);
> +	if (!ops[i]) {
> +		ret =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret =3D drm_crtc_colorop_ctm_3x4_init(dev, ops[i], crtc, &dm_colorop_fu=
ncs,
> +					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type =3D ops[i]->base.id;
> +
> +	i++;
> +
> +	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.=
id);
> +
> +	return 0;

[Severity: Medium]
What happens if kasprintf() returns NULL here?  Unlike
amdgpu_dm_build_default_pipeline(), this returns 0 with list->name set to
NULL, so dm_crtc_init_colorops() passes pipelines[0].name to
drm_crtc_create_color_pipeline_property() -> drm_property_add_enum(),
causing a NULL pointer dereference in strlen(name) and skipping cleanup of
the initialized colorop.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 3e0128a29d775..af8be7f8784d3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

[ ... ]

> @@ -840,6 +878,10 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manage=
r *dm,
> =20
>  #ifdef AMD_PRIVATE_COLOR
>  	dm_crtc_additional_color_mgmt(&acrtc->base);
> +#else
> +	res =3D dm_crtc_init_colorops(&acrtc->base);
> +	if (res)
> +		return res;
>  #endif
>  	return 0;

[Severity: Medium]
Should a failure in dm_crtc_init_colorops() clear
dm->adev->mode_info.crtcs[crtc_index] and jump to error_ism_fini instead of
returning directly?  Returning early skips amdgpu_dm_ism_flush(),
drm_crtc_cleanup(), drm_plane_cleanup(), and freeing acrtc and
cursor_plane, leaving the partially initialized CRTC registered in
mode_config and stored in mode_info.crtcs[crtc_index].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D17
