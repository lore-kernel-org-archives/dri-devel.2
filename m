Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D5606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyK0y69n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CCD10E0AC;
	Thu,  5 Nov 2026 22:27:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2800B10E0AC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 22:27:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59B3E601D5
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 22:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A681F0089F;
 Thu,  5 Nov 2026 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917639;
 bh=fiMUultwVgiYiqRzLSnHacUGudBplxhAIc4p4Ix3cDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OyK0y69nOWBARP/3K+fTcwMfpiEKjh5SEzOQmwlH/VNGO0unbZBJHHkR2yoi7cAwt
 4OECZkuKL7H5FjeKw1tNjdkJMWjaYWDu/0hUrRpfhdliQaQPClqej42wD+VnLf8BGQ
 OkLhuMtVuyjK3UUb9aaXCssDY53NotpX5mNvIFKikeuku2dQdFPTh/UkizDye6rBs2
 weVDAoPaGAqHwUozts7adcf4cj7p0mn7iq1uDOBB1jdTlE74JRCyGAWhjoTJbJ3zmM
 OYDYAPqIueTeLGRqsv5Mct/B/06WoopOXrjgs5tJ/7znrFjNyq9FZDp7Y8gglYZ196
 Qr674FrTWHHjA==
Message-ID: <sashiko-outbox-200305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 81/83] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-81-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-81-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:27:18 +0000
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
- [Medium] drm/vmwgfx: state creation error in display init triggers broken=
 fallback
--

commit 4961d66508852dc07ab5238728474ad461cb6c65
Author: Maxime Ripard <mripard@kernel.org>

drm/vmwgfx: Switch to drm_mode_config_create_initial_state

This commit replaces calls to drm_mode_config_reset() with
drm_mode_config_create_initial_state() during KMS display unit
initialization in vmwgfx_ldu.c, vmwgfx_scrn.c, and vmwgfx_stdu.c.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_scrn.c
> index 39d58fc392bf4..82fe7db266335 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -939,9 +939,7 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_=
priv)
> =20
>  	dev_priv->active_display_unit =3D vmw_du_screen_object;
> =20
> -	drm_mode_config_reset(dev);
> -
> -	return 0;
> +	return drm_mode_config_create_initial_state(dev);
>  }
> =20
>  static int do_bo_define_gmrfb(struct vmw_private *dev_priv,
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_stdu.c
> index b505f8ba3e834..80defd7358135 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -1708,7 +1708,5 @@ int vmw_kms_stdu_init_display(struct vmw_private *d=
ev_priv)
>  		}
>  	}
> =20
> -	drm_mode_config_reset(dev);
> -
> -	return 0;
> +	return drm_mode_config_create_initial_state(dev);
>  }

[Severity: Medium]
What happens in vmw_kms_init() if drm_mode_config_create_initial_state()
fails at the end of vmw_kms_stdu_init_display() or
vmw_kms_sou_init_display()?

Previously, drm_mode_config_reset() returned void, so neither function
returned an error after registering all VMWGFX_NUM_DISPLAY_UNITS (8)
display units on dev->mode_config (and vmw_kms_sou_init_display() only ever
returned -ENOSYS before initializing any display units).

In drivers/gpu/drm/vmwgfx/vmwgfx_kms.c, vmw_kms_init() treats any non-zero
return value as a fallback trigger:

	ret =3D vmw_kms_stdu_init_display(dev_priv);
	if (ret) {
		ret =3D vmw_kms_sou_init_display(dev_priv);
		if (ret) /* Fallback */
			ret =3D vmw_kms_ldu_init_display(dev_priv);
	}

If drm_mode_config_create_initial_state() fails after the display units are
initialized, those 8 CRTCs, planes, encoders, and connectors remain on
dev->mode_config while vmw_kms_init() proceeds to initialize the next
display backend on the same drm_device.

When the fallback backend registers another set of CRTCs,
dev->mode_config.num_crtc grows past VMWGFX_NUM_DISPLAY_UNITS (8). If
dev_priv->vkms_enabled is set, vmw_vkms_init() only allocated dev->vblank
for VMWGFX_NUM_DISPLAY_UNITS CRTCs via drm_vblank_init(), so the subsequent
drm_mode_config_create_initial_state() -> drm_mode_config_crtc_create_state=
()
-> drm_crtc_vblank_reset() call will index dev->vblank out of bounds. Even
when vkms is disabled, if the fallback succeeds, dev->mode_config is left
with duplicate mixed-backend KMS objects and more than
VMWGFX_NUM_DISPLAY_UNITS CRTCs (which can also overflow fixed-size stack
arrays such as units[VMWGFX_NUM_DISPLAY_UNITS] in vmw_kms_helper_dirty()).

Could drm_mode_config_create_initial_state(dev) be called once in
vmw_kms_init() after the display unit fallback chain succeeds instead of
inside each backend initializer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D81
