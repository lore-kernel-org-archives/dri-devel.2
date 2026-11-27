Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8A606A32F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyXuzQWH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A45111298A;
	Fri, 27 Nov 2026 10:09:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB26711298E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:09:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62A114516E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237201F00923;
 Fri, 27 Nov 2026 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774169;
 bh=xkDrSBFK0rSXEkLQ5YeiScAoykZIlw8bedLBqfB+N2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kyXuzQWHWk8bVG34WCQCZhS7uirM8WXf94ZyOMireeJfsY6EZnxYcvtDbVp1llnQV
 BTvKq3+2wqZfJkojuuVu4o2uAdW5I2wgYdDeefAQ+Hwt5XvLnN83d0FSSdHqFEveAB
 RhMxgQIEBiASf0QC1GA9DZ1gjU6r0jWnyWvoYAcsKDrNSEuTn/B0ONc8QglPshnqO6
 v9uTEFhAutJGUf/IVAXoWS9oVaw9rnAAnLwxa/yN8/xLRRi49nfDrU8QJG4VWtNIot
 3s1R9RjZ230h8TxIO+7TxnfQ2OSUgsHSGsvfW4X/lKa6LaaeK/z3qT60ZTWI0UWGwE
 B5Jx2SW46XEoQ==
Message-ID: <sashiko-outbox-237056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/36] drm/mode-config: Read out hardware state in
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-11-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-11-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:09:28 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/mode-config: NULL deref in
  drm_mode_config_create_initial_state()
--

commit 3c650b069a3fde459caa29f241b53349c01d0fce
Author: Maxime Ripard <mripard@kernel.org>

drm/mode-config: Read out hardware state in drm_mode_config_create_initial_=
state

This commit updates drm_mode_config_create_initial_state() to try reading
out the initial hardware state via atomic_sro_readout_state before falling
back to allocating pristine states under modeset locks.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index c1e993a78702e..d6f92e1a54d24 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c

[ ... ]

> @@ -408,6 +395,58 @@ int drm_mode_config_create_initial_state(struct drm_=
device *dev)
> =20
>  	return 0;
>  }
> +
> +/**
> + * drm_mode_config_create_initial_state - Allocates the initial state

[ ... ]

> +int drm_mode_config_create_initial_state(struct drm_device *dev)
> +{
> +	struct drm_modeset_acquire_ctx ctx;
> +	int ret;
> +
> +	/*
> +	 * The initial state is usually created while the device is
> +	 * being initialized and nothing can access it concurrently,
> +	 * but holding all the modeset locks puts the readout, the
> +	 * installation of its result and the creation of the pristine
> +	 * states under the same locking contract as the regular
> +	 * atomic paths.
> +	 */
> +	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> +
> +	if (dev->mode_config.funcs->atomic_sro_readout_state) {
> +		ret =3D dev->mode_config.funcs->atomic_sro_readout_state(dev);
> +		if (!ret)
> +			goto out;
> +	}

[Severity: High]
Can dev->mode_config.funcs be NULL when
drm_mode_config_create_initial_state() is called?

In shmob_drm_modeset_init(), drm_mode_config_create_initial_state() runs
before sdev->ddev.mode_config.funcs is assigned:

drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c:shmob_drm_modeset_init() {
    ...
	ret =3D drm_mode_config_create_initial_state(dev);
	if (ret)
		return ret;

	drm_kms_helper_poll_init(dev);

	sdev->ddev.mode_config.min_width =3D 0;
	sdev->ddev.mode_config.min_height =3D 0;
	sdev->ddev.mode_config.max_width =3D 4095;
	sdev->ddev.mode_config.max_height =3D 4095;
	sdev->ddev.mode_config.funcs =3D &shmob_drm_mode_config_funcs;
    ...
}

Dereferencing dev->mode_config.funcs without a NULL check causes a NULL
pointer dereference during probe on shmob-drm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D11
