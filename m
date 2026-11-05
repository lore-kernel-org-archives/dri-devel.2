Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4679606D808
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNpaqqJu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A7810E3F9;
	Thu,  5 Nov 2026 17:25:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086310E203
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:25:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 498BA6014C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD661F000C1;
 Thu,  5 Nov 2026 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793899505;
 bh=6vTJgGZXmwWsGKUGyBVVqCKxz4KFBrOu/bILMuT5yY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VNpaqqJuEzcfzdafIePyMhej08S2LciR3X6aMUYljE3id0Ju9cfnHKKDUAgDqkxD6
 HxaWXvIIDENBcBwc/LivXaaAqBxzk1o4iwcX+cixO+g+aN4+QKbWlsqOYZlkDPlmSf
 j9iKQ92LlM5KaowXLu4PZSBANbMnKTzb6YKYL7IbV1dY0FX9+lT7m0vhaw5OWT5hjZ
 /oSEEITyemy3GB+CAckl9X1En8BZsPgksd4Ze3KiyLPJVMY2Ct7w/P8E0bdRnWqF5K
 IyzPMsEc9tOZeG1+lne5QmquRf/WT/Ce0NLEcy7bLwpz8u/qnZz7MSQg654WQO9yA3
 ASEqb1jnNdI8g==
Message-ID: <sashiko-outbox-199610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 14/83] drm/hisilicon/hibmc: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-14-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-14-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:25:04 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/hisilicon/hibmc: WARN_ON in hibmc_unload() on hibmc_load() e=
rror
--

commit 289d0414bb2d6ac0dd51c3f3424d35a2428b1b8c
Author: Maxime Ripard <mripard@kernel.org>

drm/hisilicon/hibmc: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() in hibmc_load() to initialize
the KMS state at probe time.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 602930964e930..236840cb5b3ad 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -411,8 +411,10 @@ static int hibmc_load(struct drm_device *dev)
>  		goto err;
>  	}
> =20
> -	/* reset all the states of crtc/plane/encoder/connector */
> -	drm_mode_config_reset(dev);
> +	/* Create all the states of crtc/plane/encoder/connector */
> +	ret =3D drm_mode_config_create_initial_state(dev);
> +	if (ret)
> +		goto err;

[Severity: Medium]
If drm_mode_config_create_initial_state() fails while allocating the plane
or CRTC state in hibmc_load(), jumping to err calls hibmc_unload() while
priv->crtc.state is still NULL:

drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c:hibmc_load() {
	...
err:
	hibmc_unload(dev);
	drm_err(dev, "failed to initialize drm driver: %d\n", ret);
	return ret;
}

drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c:hibmc_unload() {
	drm_atomic_helper_shutdown(dev);
}

Since hibmc_kms_init() has already registered priv->crtc on
dev->mode_config.crtc_list, won't the call chain

  hibmc_unload()
  -> drm_atomic_helper_shutdown()
  -> drm_atomic_helper_disable_all()
  -> drm_atomic_get_crtc_state()
  -> drm_atomic_helper_crtc_duplicate_state()

trigger WARN_ON(!crtc->state) in drm_atomic_helper_crtc_duplicate_state()?

(The earlier error jumps in hibmc_load() for hibmc_kms_init(),
drm_vblank_init(), and hibmc_msi_init() also jump to err and call
hibmc_unload() before drm_mode_config_create_initial_state() has populated
crtc->state.)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D14
