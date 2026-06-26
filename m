Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B902CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C051010F5AE;
	Fri, 26 Jun 2026 12:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LAf5gb4H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6017C10F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:24:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A365D60098;
 Fri, 26 Jun 2026 12:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002C31F000E9;
 Fri, 26 Jun 2026 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782476663;
 bh=+f7Tl9yTLbF4wJOgKlG8Yes9EsM08NSO/C8EiTuiKXo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LAf5gb4HDVjQSdB09+Y/JiXuuHApdcRF/ZljmgnY3F0lSsUeqK16MUypUuJjfV0hU
 si5Hzh/T/cWaCboPFn8ilj9B2YkqNL30x+ooFR8ctsJNSUKLP8yoz8aUB0s7Rg385d
 2H/ld9x0lI3lpv+VpkPBd/cZ+78FSlKMJ0y/i7IveTBL2KUmOsRfE9Cy0rMnvGIPSb
 xMadENKcxIKtY1a9zSb0QsaRhrxUG/8DveWd1d8UFKBUSRAKQA283WZk9M2Qj6FpuI
 9WLSAo6M3TF2yNWXm1+j/dosFNJ0f+lXU6WyRpoDGBPS/2Ge2yR3b+0ZLV2pnQeGum
 WtgbB28f+9FgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/bridge/panel: hold a reference to the wrapped
 panel
To: "Albert Esteve" <aesteve@redhat.com>
Cc: wsa+renesas@sang-engineering.com, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
 Frank.Li@kernel.org
In-Reply-To: <20260626-drm_refcount_wiring-v1-2-cca1a7b3bdef@redhat.com>
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
 <20260626-drm_refcount_wiring-v1-2-cca1a7b3bdef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:24:22 +0000
Message-Id: <20260626122423.002C31F000E9@smtp.kernel.org>
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
- [High] Accessing `panel_bridge->panel` after calling `drm_bridge_remove()=
` causes a use-after-free if the panel device was removed first.

Pre-existing issues:
- [High] Passing `panel->dev` to `devm_drm_put_bridge()` can cause a use-af=
ter-free or a WARN_ON if the panel's struct device has already been freed.
--

commit 0ea9791b2d1689f026240930cee1476a24170351
Author: Albert Esteve <aesteve@redhat.com>

drm/bridge/panel: hold a reference to the wrapped panel

drm_panel_bridge_add_typed() stores a pointer to the drm_panel it
wraps, but never acquires a reference to it. If the panel device
goes away while a panel_bridge still exists, the dangling pointer can
be dereferenced through panel_bridge->panel.

Acquire a reference in drm_panel_bridge_add_typed() with drm_panel_get()
and release it in each teardown path.

> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 4978ec98a0828..6b98ad19508df 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c

[ ... ]

> @@ -316,6 +316,7 @@ EXPORT_SYMBOL(drm_panel_bridge_add_typed);
>  void drm_panel_bridge_remove(struct drm_bridge *bridge)
>  {
>  	struct panel_bridge *panel_bridge;
> +	struct drm_panel *panel;
> =20
>  	if (!bridge)
>  		return;
> @@ -326,10 +327,12 @@ void drm_panel_bridge_remove(struct drm_bridge *bri=
dge)
>  	}
> =20
>  	panel_bridge =3D drm_bridge_to_panel_bridge(bridge);
> +	panel =3D panel_bridge->panel;
> =20
>  	drm_bridge_remove(bridge);
>  	/* TODO remove this after reworking panel_bridge lifetime */
> -	devm_drm_put_bridge(panel_bridge->panel->dev, bridge);
> +	devm_drm_put_bridge(panel->dev, bridge);

[Severity: High]
This isn't a bug introduced by this patch, but could this pass a freed or
unbound device pointer to devm_drm_put_bridge()?

If the panel device is unbound and unregistered, its struct device might be
freed if no other references are held. Even though the struct drm_panel is
kept alive by drm_panel_get(), it does not inherently hold a reference to
panel->dev.

If the host device later removes the bridge via drm_panel_bridge_remove(),
passing panel->dev to devm_drm_put_bridge() would dereference a dangling
pointer, or trigger a WARN_ON if the device was kept alive but unbound.

> +	drm_panel_put(panel);
>  }
>  EXPORT_SYMBOL(drm_panel_bridge_remove);

[ ... ]

> @@ -357,11 +360,14 @@ EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
>  static void devm_drm_panel_bridge_release(struct device *dev, void *res)
>  {
>  	struct drm_bridge *bridge =3D *(struct drm_bridge **)res;
> +	struct panel_bridge *panel_bridge;
> =20
>  	if (!bridge)
>  		return;
> =20
> +	panel_bridge =3D drm_bridge_to_panel_bridge(bridge);
>  	drm_bridge_remove(bridge);
> +	drm_panel_put(panel_bridge->panel);

[Severity: High]
Does this cause a use-after-free of panel_bridge?

If the panel device is unbound before the host device, its devres actions
drop the bridge's initial reference. Later, when the host device unbinds,
devm_drm_panel_bridge_release() calls drm_bridge_remove().

Because that was the final reference, drm_bridge_remove() frees the
panel_bridge structure. The immediate next line dereferences
panel_bridge->panel.

Should we cache the panel pointer in a local variable before calling
drm_bridge_remove(), similar to what was done in drm_panel_bridge_remove()?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-drm_refcou=
nt_wiring-v1-0-cca1a7b3bdef@redhat.com?part=3D2
