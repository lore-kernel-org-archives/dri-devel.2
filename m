Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C50C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25B310F42F;
	Thu,  2 Jul 2026 15:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fTPA2vwK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83B6A10F42F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07CB5601C6;
 Thu,  2 Jul 2026 15:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF31F000E9;
 Thu,  2 Jul 2026 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004753;
 bh=QHiXYCdmlQ83R2sYKyAxp99kNFpcw+OHH32KRnL1Zec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fTPA2vwK42pvD8n268anDRxtG5WcYq1pHjmLFiCQd+06mpmq/48J4sjGhWayjF+vS
 +mAXPM4PaUXnMKW0DCQagFyGu61SFA2ySnS91KHSxyMrYtZe+/WLyjdGC0M7v0Pzto
 jbjU7BktJD2gMawKyJk/Xaf2oHySuSn3ggxd3C2qecdgeRfllYtPYQXLlqP4eNwioz
 C4r7ZsCvwiPHzdxPom2cgrGrZqDCm5ArKzcHckVyTMesJHqo0sh98hPuGSOwVVYAJp
 +61flPtkHP1QzWAFMW5C4vhwqZ0PbyOlU3LyKADWD3H73ngoRWCyCXBum/oH/gZSdB
 5mubCILaKkLfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/39] drm/bridge: Remove redundant error check in
 drm_bridge_helper_reset_crtc()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-12-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-12-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:05:53 +0000
Message-Id: <20260702150553.9BBF31F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Preexisting double unlock of connection_mutex and lockless access =
to connector state in drm_bridge_helper_reset_crtc().
--

commit 8efd841f2ea4070344d378811452cf54e3a77546
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()

This commit removes a no-op error check after
drm_atomic_helper_reset_crtc, as the goto target is the immediately
following label and the return value is already propagated correctly.

> diff --git a/drivers/gpu/drm/drm_bridge_helper.c b/drivers/gpu/drm/drm_br=
idge_helper.c
> index 420f29cf3e543..0a3c8fee66b32 100644
> --- a/drivers/gpu/drm/drm_bridge_helper.c
> +++ b/drivers/gpu/drm/drm_bridge_helper.c
> @@ -50,8 +50,6 @@ int drm_bridge_helper_reset_crtc(struct drm_bridge *bri=
dge,
> =20
>  	crtc =3D connector->state->crtc;
>  	ret =3D drm_atomic_helper_reset_crtc(crtc, ctx);
> -	if (ret)
> -		goto out;
> =20
>  out:
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);

[Severity: High]
This isn't a bug introduced by this patch, but does this function have a
pre-existing double unlock bug due to how
drm_atomic_get_connector_for_encoder behaves?

Looking at drm_bridge_helper_reset_crtc, it first acquires
connection_mutex via drm_modeset_lock.

It then calls drm_atomic_get_connector_for_encoder. Because the lock is
already held by ctx, the drm_modeset_lock call inside the helper returns 0
rather than an error. However, drm_atomic_get_connector_for_encoder
unconditionally calls drm_modeset_unlock on the connection_mutex before
returning.

Since ww_mutex does not track nesting depths, the lock is completely droppe=
d.

Does this lead to connector->state being accessed without the lock just
before this hunk, and then a subsequent double unlock when
drm_modeset_unlock is called again here at the out label?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D12
