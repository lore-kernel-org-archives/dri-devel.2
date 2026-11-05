Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A6606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkh0Rnb7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0670110E0F9;
	Thu,  5 Nov 2026 20:24:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D274510E0F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:24:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A55A43C15
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367141F008A1;
 Thu,  5 Nov 2026 20:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793910243;
 bh=wp64vaLNDEgG8dXH4zM/OcazZmMrZn4HhgFLRtCPELo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lkh0Rnb7+ArYInqyMrdjnIzH85ZOPg7JoNxPbDWRoh9HvtVqW5VMYR4+gpLC6z1Xy
 O7xjJhfIHepy5BJHZpQeIAcN5dwhERVyzqPGidYTDM49UDum08b6m/R/Atl9BXyBuk
 XaFK7/R29Y99fjDYAb0EEotyvwMixxqDQ54BKZMJYRRpdeAhZXyx4/THdBfw7AzGeY
 ICz1nzpBux/xaX2dRalhewZSuzSVgtaY8SOk++ebZg+mTYXZpI+7AMNkn2enSc+iDI
 yWdeMjsxC38WWPgBBXbJT6EIFwYY4glp8brNft9jKq3laR1lJVgbw5PWPUXzZO8Mv0
 +exZQ9PcXaIXA==
Message-ID: <sashiko-outbox-200092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 47/83] drm/sun4i: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20261105-drm-no-more-config-reset-v1-47-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-47-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:24:02 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/sun4i: sun4i_framebuffer_init() ignores state creation failure
--

commit 9bfddf90d8dccabe2d26ebb9b512f7adbc95c198
Author: Maxime Ripard <mripard@kernel.org>

drm/sun4i: Switch to drm_mode_config_create_initial_state

This commit replaces the probe-time drm_mode_config_reset() call in
sun4i_framebuffer_init() with drm_mode_config_create_initial_state() to
create the initial KMS state.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/=
sun4i/sun4i_framebuffer.c
> index fc822bc2c62b5..0ce3691dedade 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> @@ -10,6 +10,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_blend.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_print.h>
> =20
>  #include "sun4i_drv.h"
>  #include "sun4i_framebuffer.h"
> @@ -26,7 +27,8 @@ static const struct drm_mode_config_helper_funcs sun4i_=
de_mode_config_helpers =3D
> =20
>  void sun4i_framebuffer_init(struct drm_device *drm)
>  {
> -	drm_mode_config_reset(drm);
> +	drm_WARN(drm, drm_mode_config_create_initial_state(drm),
> +		 "Failed to create state\n");

[Severity: High]
Should sun4i_framebuffer_init() return an int and propagate errors from
drm_mode_config_create_initial_state(drm) back to sun4i_drv_bind()?

When drm_mode_config_create_initial_state(drm) fails to allocate state for a
private object, colorop, plane, CRTC, or connector, it returns early with a
negative errno, leaving that object and all subsequent KMS objects with a
NULL state pointer.

Because sun4i_framebuffer_init() only warns and returns void, its caller
sun4i_drv_bind() in drivers/gpu/drm/sun4i/sun4i_drv.c continues execution:

	sun4i_framebuffer_init(drm);

	/* Enable connectors polling */
	drm_kms_helper_poll_init(drm);

	ret =3D drm_dev_register(drm, 0);
	if (ret)
		goto finish_poll;

	drm_client_setup(drm, NULL);

When drm_client_setup(), a userspace atomic commit, or
drm_atomic_helper_shutdown() duplicates plane state via
sun4i_backend_layer_duplicate_state() in drivers/gpu/drm/sun4i/sun4i_layer.=
c,
plane->state is dereferenced without a NULL check:

	struct sun4i_layer_state *orig =3D state_to_sun4i_layer_state(plane->state=
);
	struct sun4i_layer_state *copy;

	copy =3D kzalloc_obj(*copy);
	if (!copy)
		return NULL;

	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
	copy->uses_frontend =3D orig->uses_frontend;

Could this cause a NULL pointer dereference in
__drm_atomic_helper_plane_duplicate_state(), orig->uses_frontend, or during
userspace property queries via drm_atomic_get_property() if
sun4i_drv_bind() does not abort and jump to unbind_all on state creation
failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D47
