Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6053DC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E3410E171;
	Wed,  5 Aug 2026 15:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5c6o3VT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E5410E171
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:05:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C715C600AE;
 Wed,  5 Aug 2026 15:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543311F000E9;
 Wed,  5 Aug 2026 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785942329;
 bh=SVbvEhghnRj9nV9gvW/bS0WP20Q5kVbICEsFgO+Zd6w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5c6o3VTW+s+6G02+htqhqIBbV8R5X0o4OQjpqJKMtHxBPDt8AHLifxJ/GGM0+ndq
 e1P9L3A15S1kE/vaDCdnnWs1qjOJufcZIKBrrLZFyjD5nD4YfhOXhnq8G5kFKa9wdz
 kU7YI3lhRrvyXiBteYqYvoWwrmknGDfEPpUcTTvtwpLVTcfAK4Fv1t0NVA6PYd1WtZ
 sKYLowSrMiiPByx4Rro1xKnr8GmJXZyvwI/HVrzrZdutGaso6vqxHoRe8SewrYZtOK
 eVqPWbx9wy0JpOKo5zGNxAQJdeJEjPFUtaJQXWC+DYFRVmHdW09XmO074crNrlm2XQ
 ZhX8073+QKClw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi83: Cancel reset_work on
 remove to avoid use-after-free
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805141816.216900-1-fanwu01@zju.edu.cn>
References: <20260805115546.152786-1-fanwu01@zju.edu.cn>
 <20260805141816.216900-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:05:28 +0000
Message-Id: <20260805150529.543311F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `disable_irq()` in `sn65dsi83_detach()` causes unbalanced =
IRQ state and Use-After-Free of DRM pipeline objects.

Pre-existing issues:
- [Medium] `sn65dsi83_reset_pipe()` silently discards errors from `drm_brid=
ge_helper_reset_crtc()`.
--

--- Patch [1]: [PATCH v3] drm/bridge: ti-sn65dsi83: Cancel reset_work on re=
move to avoid use-after-free ---
commit 71f81476ddab3b26071a54fac540bd7518b097ca
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/bridge: ti-sn65dsi83: Cancel reset_work on remove to avoid use-after-fr=
ee

This commit addresses a use-after-free vulnerability by properly canceling
reset_work and monitor_work during device removal and probe failure paths.
It also ensures the IRQ is disabled before unplugging the bridge to
prevent handlers from executing after teardown.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index f9fdbf48c6b32..8f17fd319cf90 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -298,9 +298,14 @@ static int sn65dsi83_attach(struct drm_bridge *bridg=
e,
>  			    enum drm_bridge_attach_flags flags)
>  {
>  	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
> +	int ret;
> +
> +	ret =3D drm_bridge_attach(encoder, ctx->panel_bridge, &ctx->bridge,
> +				flags);
> +	if (!ret && ctx->irq)
> +		enable_irq(ctx->irq);
> =20
> -	return drm_bridge_attach(encoder, ctx->panel_bridge,
> -				 &ctx->bridge, flags);
> +	return ret;
>  }
> =20
>  static void sn65dsi83_detach(struct drm_bridge *bridge)
>  {
>  	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
> =20
>  	if (!ctx->dsi)
>  		return;
> =20
>  	ctx->dsi =3D NULL;
>  }

[Severity: High]
Does this require a symmetric disable_irq() in sn65dsi83_detach()?

If the master DRM driver unbinds, drm_bridge_detach() is called, removing
the bridge from the encoder chain. If we don't disable the IRQ here, the
hardware interrupt remains active.

If the master DRM driver binds again, sn65dsi83_attach() will call
enable_irq() on an already-enabled IRQ, which could trigger an unbalanced
enable warning.

More critically, if a hardware interrupt triggers while the bridge is
detached, sn65dsi83_irq() schedules reset_work. The work executes
drm_bridge_helper_reset_crtc(), which could dereference a freed encoder:

drm_bridge_helper_reset_crtc()
{
	struct drm_encoder *encoder =3D bridge->encoder;
	struct drm_device *dev =3D encoder->dev;
...

[ ... ]

[Severity: Medium]
This is a pre-existing issue, but sn65dsi83_reset_pipe() appears to silently
discard errors from drm_bridge_helper_reset_crtc():

sn65dsi83_reset_pipe() {
	err =3D drm_bridge_helper_reset_crtc(&sn65dsi83->bridge, &ctx);
	if (err =3D=3D -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	}

	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);

	return 0;
}

Since sn65dsi83_reset_work() assumes the pipe reset was successful and
calls enable_irq(), could this immediately re-trigger the hardware interrupt
if the reset actually failed, potentially causing an IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805141816.2169=
00-1-fanwu01@zju.edu.cn?part=3D1
