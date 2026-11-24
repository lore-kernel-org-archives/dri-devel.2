Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79758606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DRnFBZr1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980BE10F55C;
	Tue, 24 Nov 2026 18:38:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D54410F094;
 Tue, 24 Nov 2026 18:38:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 419B4611C9;
 Tue, 24 Nov 2026 18:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC39E1F000C6;
 Tue, 24 Nov 2026 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545484;
 bh=CHrPBoglm8BiOaGj7Ukd7JhgPYGm0vZ+x/vV70IN0P0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DRnFBZr1CFKbS4zys8wl7vXcZUcggkRxflRkIOCK0CO0gY+Trgu/whmWCq04sa1pz
 2APps/w5auZzEi/TCbTtfNvMAWizY2KgzLA1DrqcP/a4Nx/6iBHCS3fMD5nKwHurgT
 ik5YDXGcNsaIfKusAJKOUoACzoJ1Y4eLDHtOxA2LO0OdFMSxU9RshOqzAV10bzXUO4
 pshD3xrTetqAx40ncaf30PaYE9MbIJQKl14GGKyQ30Q4ILQe28oJTQENJf3Msphpeh
 0bzsS+dOb8Y3JhihllEbr5jhtuG6qGczLWukUZiw37RMS3xcgQ7suAhK9jurqH9TrJ
 wh2xLJ81C+dbQ==
Message-ID: <sashiko-outbox-231835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/19] drm/amd/display: add support to post-blend
 1D-LUT colorop
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-20-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-20-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:38:04 +0000
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
- [Medium] drm/amd/display: leak of ops[i] on init failure in
  amdgpu_dm_initialize_crtc_default_pipeline()
- [Medium] drm/amd/display: unchecked kasprintf() in
  amdgpu_dm_initialize_crtc_default_pipeline()
--

commit a8178a6daf7c1cd1a2cd47ce46fa81a020bacd1b
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: add support to post-blend 1D-LUT colorop

This commit adds the Regamma 1D LUT colorop to the AMD CRTC post-blend
color pipeline and wires up its state handling in
__set_dm_crtc_colorop_regamma().

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index f5991f29973d5..8218a9cbad33b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -350,6 +350,24 @@ int amdgpu_dm_initialize_crtc_default_pipeline(struc=
t drm_crtc *crtc,
>  		drm_colorop_set_next_property(ops[i-1], ops[i]);
> =20
>  		i++;
> +
> +		/* 1D LUT - REGAMMA LUT */
> +		ops[i] =3D kzalloc_obj(*ops[0]);
> +		if (!ops[i]) {
> +			ret =3D -ENOMEM;
> +			goto cleanup;
> +		}
> +
> +		ret =3D drm_crtc_colorop_curve_1d_lut_init(dev, ops[i], crtc, &dm_colo=
rop_funcs,
> +							 MAX_COLOR_LUT_ENTRIES,
> +							 DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
> +							 DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +		if (ret)
> +			goto cleanup;

[Severity: Medium]
Can jumping to cleanup here leak ops[i] if
drm_crtc_colorop_curve_1d_lut_init() fails?

In drm_crtc_colorop_init() -> drm_common_colorop_init(), if
drm_mode_object_add() fails, the function returns before linking ops[i] into
config->colorop_list.  Because cleanup only calls
drm_colorop_pipeline_destroy(dev) to free colorops on config->colorop_list,
ops[i] is leaked.

> +
> +		drm_colorop_set_next_property(ops[i-1], ops[i]);
> +
> +		i++;
>  	}
> =20
>  	list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[0]->base.=
id);

[Severity: Medium]
Should list->name be checked for NULL here, as in
amdgpu_dm_build_default_pipeline()?

If kasprintf() fails, amdgpu_dm_initialize_crtc_default_pipeline() skips
cleanup and returns 0 with list->name set to NULL.  The caller
dm_crtc_init_colorops() then passes the NULL pipeline name to
drm_crtc_create_color_pipeline_property(), causing a NULL pointer
dereference in strlen(name) inside drm_property_add_enum().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D19
