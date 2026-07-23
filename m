Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBAC44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 01:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FA510EF00;
	Thu, 23 Jul 2026 01:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DiRe+T/1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E54B10EF00
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 01:02:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D34F600AB;
 Thu, 23 Jul 2026 01:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4001F000E9;
 Thu, 23 Jul 2026 01:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784768541;
 bh=u/WLOPFig/fPJyWNW6TOxJ4qaGMt+FARVJO34trrPn0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DiRe+T/1z+kUxB9Mz/6d+W5hSl8WvEw+TmM9nmq6yLI6FALURv7ATPumFxwiuv61b
 i+tt8ZWglXpUXSU6sfBnkwIgHLNVLWYKp8mdyZaHdpFdjA2yY5v42xaMPf3zbtSulO
 Ojms0sZQW9zvcpbVVNC2xwWbpUdiDW/guFdwHrBnJIOEeBARXBmo+aYbvtM3igIEhX
 5XVJHAcYQPqXq1vW3X/qupQO2h8Kw8P3E0vv7NiNPFOQtRtX1Tsq85c+uqBLnzL4et
 bhbft2sKznUREeXNY/SfbGiN1TjsFT18oFIdD0fTvsRWeQ9T3ObqYG3JBMp4BcJerh
 NU/NyZCtjwcGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/8] drm/komeda: use drmm_writeback_connector_init()
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723003205.330362-5-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-5-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 01:02:21 +0000
Message-Id: <20260723010221.AC4001F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Manual call to `drm_mode_config_cleanup()` during driver teardown =
causes NULL pointer dereferences on drmm-managed encoder and connector.
--

--- Patch [4]: [PATCH v8 4/8] drm/komeda: use drmm_writeback_connector_init=
() ---
commit 252267d60505e182c9ac4aa8fed48741764eeb23
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

    drm/komeda: use drmm_writeback_connector_init()
   =20
    The driver uses drm_writeback_connector_init() instead of its drmm
    counterpart, but it doesn't perform the job queue cleanup (neither
    manually nor by calling drm_writeback_connector_cleanup()). On the
    contrary, the drmm_writeback_connector_init() function ensures the
    proper cleanup of the job queue.
   =20
    Use drmm_plain_encoder_alloc() to allocate simple encoder and
    drmm_writeback_connector_init() in order to initialize writeback
    connector instance.

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 41cc3e080dc9c..65f072cfe42f9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c

[ ... ]

> @@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector=
 *connector,
>  	return 0;
>  }
> =20
> -static void komeda_wb_connector_destroy(struct drm_connector *connector)
> -{
> -	drm_connector_cleanup(connector);
> -	kfree(to_kconn(to_wb_conn(connector)));
> -}
> -
>  static const struct drm_connector_funcs komeda_wb_connector_funcs =3D {
>  	.reset			=3D drm_atomic_helper_connector_reset,
>  	.detect			=3D komeda_wb_connector_detect,
>  	.fill_modes		=3D komeda_wb_connector_fill_modes,
> -	.destroy		=3D komeda_wb_connector_destroy,
>  	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
>  };

[ ... ]

> @@ -161,20 +157,29 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
>  					       kwb_conn->wb_layer->layer_type,
>  					       &n_formats);
>  	if (!formats) {
> -		kfree(kwb_conn);
> +		drmm_kfree(&kms->base, kwb_conn);
>  		return -ENOMEM;
>  	}
> =20
> -	err =3D drm_writeback_connector_init(&kms->base, wb_conn,
> -					   &komeda_wb_connector_funcs,
> -					   &komeda_wb_encoder_helper_funcs,
> -					   formats, n_formats,
> -					   BIT(drm_crtc_index(&kcrtc->base)));
> +	encoder =3D drmm_plain_encoder_alloc(&kms->base, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: High]
Will this crash during driver teardown or initialization failure?

The komeda driver still explicitly calls drm_mode_config_cleanup() during i=
ts
teardown in komeda_kms_detach() and in the error path of komeda_kms_attach(=
):

komeda_kms_attach() {
    ...
cleanup_mode_config:
	drm_mode_config_cleanup(drm);
    ...
}

Because drm_mode_config_cleanup() unconditionally invokes the .destroy hook
for all encoders and connectors, and drmm_plain_encoder_alloc() is called
here with a NULL funcs pointer, will the cleanup attempt to dereference a
NULL funcs pointer (encoder->funcs->destroy)?=20

Similarly, the .destroy hook has been removed from komeda_wb_connector_funcs
above, so will drm_mode_config_cleanup() also crash when attempting to call
connector->funcs->destroy()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723003205.3303=
62-1-John.Harrison@Igalia.com?part=3D4
