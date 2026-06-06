Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C60CD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D2A010E2B0;
	Sat,  6 Jun 2026 19:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FNQ1baTw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9803310E2B0
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:45:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0131D600AE;
 Sat,  6 Jun 2026 19:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E79B1F00893;
 Sat,  6 Jun 2026 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780775140;
 bh=wlvIXBD95a5bsnV3AjRiTCajF8FRsWmvzMJEZDsiyGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FNQ1baTwaX3mkqiuPapQr6tvGYiX8c+7c+gJGoFAbB0M7lC/VeGjxMz4ejkiLxE/a
 1ZCkRWoZpZNeJ0ZP3kxHgU9AfEFaFawaCTCbrrDBcZ/6gxJb0H09xzPXOaXnfZiKa9
 Vjl4FG/n6A2oACfY2DmSRjUSan+q7PQU5dwWdk0448IuWfQpQsIzLJi5oj3a5SiKH5
 Z83QkwvNVjVuCFKWXryqHaWp8DVG0mATjvqLqqaQq3k2X9gTsOn5TJr6dgwZU5YmLM
 cl4TaIqTgysvJeEt/2BtofuaGKYADjGJLeWCtKI2tgAgsbSvqjot8JETm7A2ibEBtO
 eYtJcmFxNH8VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/bridge: chrontel-ch7033: replace deprecated
 DRM_ERROR macro
To: "Piyush Patle" <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606193625.24465-4-piyushpatle228@gmail.com>
References: <20260606193625.24465-4-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 19:45:39 +0000
Message-Id: <20260606194540.7E79B1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup on error paths in `ch7033_bridge_attach()` causes =
a resource leak and use-after-free.
- [High] `ch7033_bridge_detach()` incorrectly cleans up uninitialized resou=
rces if the bridge was attached with `DRM_BRIDGE_ATTACH_NO_CONNECTOR`.
- [High] HPD is enabled before connector initialization is complete, causin=
g a NULL pointer dereference race condition.
--

commit 0d74a63f280c9b3d909b1d5c59227a795c81f570
Author: Piyush Patle <piyushpatle228@gmail.com>
drm/bridge: chrontel-ch7033: replace deprecated DRM_ERROR macro

Replace DRM_ERROR() with device-aware drm_err() using bridge->dev.

No functional changes.

> diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/b=
ridge/chrontel-ch7033.c
> index 54d49d4882c85..0e845f789f2e9 100644
> --- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
> +++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> @@ -302,7 +302,7 @@ static int ch7033_bridge_attach(struct drm_bridge *br=
idge,
>  					  priv->next_bridge->type,
>  					  priv->next_bridge->ddc);
>  	if (ret) {
> -		DRM_ERROR("Failed to initialize connector\n");
> +		drm_err(bridge->dev, "Failed to initialize connector\n");
>  		return ret;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this early return
leak resources?

If drm_connector_init_with_ddc() fails here in ch7033_bridge_attach(),
we return without calling drm_bridge_hpd_disable(). Does this leave a
dangling pointer in next_bridge for the HPD callback (ch7033_hpd_event)
and its data (priv)?

If an HPD event fires later after the device probing failed, could it
lead to a use-after-free?

Also, if the subsequent drm_connector_attach_encoder() call fails:

drivers/gpu/drm/bridge/chrontel-ch7033.c:ch7033_bridge_attach() {
    ...
    if (ret) {
        drm_err(bridge->dev, "Failed to initialize connector\n");
        return ret;
    }

    return drm_connector_attach_encoder(&priv->connector, encoder);
}

Does returning that error directly fail to roll back
drm_connector_init_with_ddc() and leave the HPD enabled, leaking the
connector structure and the registered callback?

[Severity: High]
This is also a pre-existing issue, but is there a race condition with when
HPD is enabled in this same function?

Looking at ch7033_bridge_attach() in drivers/gpu/drm/bridge/chrontel-ch7033=
.c:

drivers/gpu/drm/bridge/chrontel-ch7033.c:ch7033_bridge_attach() {
    ...
    if (priv->next_bridge->ops & DRM_BRIDGE_OP_HPD) {
        drm_bridge_hpd_enable(priv->next_bridge, ch7033_hpd_event, priv);
    }

    drm_connector_helper_add(connector, &ch7033_connector_helper_funcs);
    ret =3D drm_connector_init_with_ddc(...);
    ...
}

Since drm_bridge_hpd_enable() is called before drm_connector_init_with_ddc(=
),
if an HPD event fires immediately, ch7033_hpd_event() is invoked.
That callback checks if priv->bridge.dev is set (which is true here)
and then passes priv->connector.dev to drm_helper_hpd_irq_event().

Since priv->connector.dev is only populated later during
drm_connector_init_with_ddc(), will it still be NULL here, causing
drm_helper_hpd_irq_event() to dereference a NULL pointer?

[Severity: High]
Finally, this is another pre-existing issue, but does ch7033_bridge_detach()
clean up uninitialized resources?

If ch7033_bridge_attach() is called with DRM_BRIDGE_ATTACH_NO_CONNECTOR,
it returns early and skips drm_connector_init_with_ddc().
However, ch7033_bridge_detach() unconditionally calls:

drivers/gpu/drm/bridge/chrontel-ch7033.c:ch7033_bridge_detach() {
    ...
    drm_connector_cleanup(&priv->connector);
}

Since priv is allocated with devm_drm_bridge_alloc() (which zeroes memory),
priv->connector contains zero-initialized list heads.
Because drm_connector_cleanup() iterates over &connector->probed_modes
using list_for_each_entry_safe(), could this dereference NULL list
pointers and cause a kernel crash when the uninitialized connector is
cleaned up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606193625.2446=
5-1-piyushpatle228@gmail.com?part=3D3
