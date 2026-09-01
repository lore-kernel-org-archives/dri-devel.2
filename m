Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E5C624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CA610EEB2;
	Tue,  1 Sep 2026 19:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AemKn9Ni";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B8510EEB2
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:16:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2299D41904;
 Tue,  1 Sep 2026 19:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A31F000E9;
 Tue,  1 Sep 2026 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290182;
 bh=sK8MxF/Bh9pZ54G0aGZ0bMqmuQjXPIjpgAgb8VVtQVg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AemKn9Nip10IP09UHG7dPK04Mi4FSz1mMq5Q0/rfyg4542uSEZDa9HY0Gq+CjVIuP
 z8kmR8JqyNYCDRjLoLfPZ1GHRze4AkvV4q0cIqsMDjL11LoDhJUxxIl007tr26PfUe
 faqfAO0cit3n2D8E7NE/+9s8VSJEza7q4lO/GLssAOszJcv7nb/+2rZbetiAuZ/dkQ
 lm8S3j6K4ph9UJqPUKCr2rel/YPwmqAW9NyOQ69AOHNFnQvN0QBuCKdu7E/myy7C5n
 6FzRAaqHBsB+m6nALpIISFrxme7C1ueTBLSCNcTBi/2G6gphcGoRD0dvYUg1QY3D7w
 Z4P45sjMxs/OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 14/74] drm/bridge: Fix unlocked list access in
 drm_bridge_attach()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-14-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-14-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:16:21 +0000
Message-Id: <20260901191621.C59A31F000E9@smtp.kernel.org>
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
- [Low] Mixing goto-based error handling with scope-based cleanup helpers (=
`scoped_guard`) in the same function.
--

commit a312843839f1a20e85a81d94af26656e4dacb18f
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Fix unlocked list access in drm_bridge_attach()

This patch fixes an unlocked read of bridge->list in drm_bridge_attach()
by performing the check under bridge_lock. It uses the scoped_guard()
cleanup helper to manage the lock.

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index a8b6df5c13eaf..10dde3600c70a 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -606,8 +606,10 @@ int drm_bridge_attach(struct drm_encoder *encoder, s=
truct drm_bridge *bridge,
>  	if (!bridge->container)
>  		DRM_WARN("DRM bridge corrupted or not allocated by devm_drm_bridge_all=
oc()\n");
> =20
> -	if (list_empty(&bridge->list))
> -		DRM_WARN("Missing drm_bridge_add() before attach\n");
> +	scoped_guard(mutex, &bridge_lock) {
> +		if (list_empty(&bridge->list))
> +			DRM_WARN("Missing drm_bridge_add() before attach\n");
> +	}

[Severity: Low]
Does introducing scoped_guard() here conflict with the existing goto-based
error handling later in drm_bridge_attach()?

The kernel's cleanup.h guidelines forbid mixing goto-based cleanup and
scope-based cleanup helpers in the same function. drm_bridge_attach()
currently uses goto labels for resource unwinding:

    if (bridge->funcs->attach) {
        ret =3D bridge->funcs->attach(bridge, encoder, flags);
        if (ret < 0)
            goto err_reset_bridge;
    }

While this specific change doesn't cause a direct runtime leak since the
goto statements don't jump into or out of the scoped_guard block scope,
could this structural mixing cause issues later? Would it be safer to use
standard locking (mutex_lock and mutex_unlock) here to avoid mixing the
two paradigms?

> =20
>  	drm_bridge_get(bridge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D14
