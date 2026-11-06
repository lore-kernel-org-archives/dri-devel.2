Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD2606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OM9a76wA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3B2112D74;
	Fri,  6 Nov 2026 13:33:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF0E112D74
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05DD4601BF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA7A1F0089F;
 Fri,  6 Nov 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972017;
 bh=Sfch7kTfbHkfOUoksCc47Io6nJ0ersU5Vhm4z9GC/YA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OM9a76wAE+ijEHjF4yZYjWjv04u2CVC+VNiQ6BqYMMQd+bcHjMQwdyFAPcBfRgGIO
 RZki+BYZqDubQ9IECFgCfQVCgyhivMvzl7vWOMKycm/r3/bKJ1bZjzEQjcZTtuI/lD
 5XSy05EjM+lsCTO/ICajdFjyE5Q2c2BZH7FY0we8Yc2O/l7UZNGqjjarm+6CKcEzG9
 jGT6J6brxIa3zXv3F5UIkWHxf+DehkQ7MMiNNu6gygJ4NTto6u3UVHz5weAP3D2zz9
 dOnhRDG6lF4+srI9sAlar91cYT9fkSgB2ajhiTTMSHbg4DvlvFcgPu60RLpQQ8aouV
 JtJtr3JO4NgNQ==
Message-ID: <sashiko-outbox-201476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 19/39] drm/mode-config: Read out hardware state in
 drm_mode_config_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-19-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-19-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:33:37 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/mode-config: NULL deref of mode_config.funcs in
  drm_mode_config_create_initial_state()
- [Low] drm/mode-config: commit message function name mismatch and
  unused header
--

commit de65a82f52b624078e630d3146fcef76dfc9518c
Author: Maxime Ripard <mripard@kernel.org>

> drm/mode-config: Read out hardware state in drm_mode_config_create_state
>
> drm_mode_config_create_state() creates the initial state for all
> KMS objects at driver registration time.
>
> Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
> so that the initial state is populated from the hardware rather than
> being left as a pristine default.
>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> drivers/gpu/drm/drm_mode_config.c | 70 ++++++++++++++++++++++++++++++----=
-----
>  1 file changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index c1e993a78702e..9f242e2654c82 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -24,6 +24,7 @@
>  #include <linux/uaccess.h>
> =20
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_state_readout.h>

[Severity: Low]
This isn't a bug, but the commit subject and message refer to
drm_mode_config_create_state(), whereas the patch renames the fallback
allocator to a static drm_mode_config_create_state() helper and calls
atomic_sro_readout_state under modeset locks in the exported
drm_mode_config_create_initial_state(). Also, nothing in this file uses
<drm/drm_atomic_state_readout.h>.

[ ... ]

> @@ -408,6 +396,58 @@ int drm_mode_config_create_initial_state(struct drm_=
device *dev)
> =20
>  	return 0;
>  }
> +

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
Can this cause a NULL pointer dereference on dev->mode_config.funcs?

Previously, drm_mode_config_create_initial_state() did not dereference
dev->mode_config.funcs, and some drivers call it before setting that
pointer:

drivers/gpu/drm/sun4i/sun4i_framebuffer.c:sun4i_framebuffer_init() {
	...
	drm_WARN(drm, drm_mode_config_create_initial_state(drm),
		 "Failed to create state\n");

	drm->mode_config.max_width =3D 8192;
	drm->mode_config.max_height =3D 8192;
	drm->mode_config.normalize_zpos =3D true;

	drm->mode_config.funcs =3D &sun4i_de_mode_config_funcs;
	...
}

When sun4i (or shmob_drm_modeset_init()) probes, dev->mode_config.funcs is
still NULL here, causing an immediate NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D19
