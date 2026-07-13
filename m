Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FCCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CCB10E59C;
	Mon, 13 Jul 2026 12:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J40BPP6v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC28110E59C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:06:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DBE9D6004E;
 Mon, 13 Jul 2026 12:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2261C1F000E9;
 Mon, 13 Jul 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783944365;
 bh=ncSUzhfaIWuTva3U59ghWnssJa86zskFapx+JwmVkqs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J40BPP6vB4giCMEjMvHGxjcjzZw7R3d1RAkU7Sj0OvbpSg5siDqwK+48ZWrPP6CP3
 PlutQa/NjbdPuXpYaRusw0AO5vFANZClLT8ysMojJqVuvKwHT5ywW9mb/qHgIdc/di
 9KlE6pqxl7++1pkq/3Sr1K3uUojv5tg1uH7dwId57JRxt5cSvOTwsTQloXJKogUqxH
 m+nBLsGE1MjU5Bs9hru/jUA5SglFyuEUM1tpTEIQwgabnrM5pvIkkuptGyHhU89to/
 Qyo+hM+3Cln0ZkZy58IIMG9o3d/WWt1wSVFg08o6yNUkFsEH8fCgiFsxe9CxGSHJHX
 d6vk87QyOgtrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/bridge/panel: hold a reference to the
 wrapped panel
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 imx@lists.linux.dev, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260713-drm_refcount_wiring-v2-2-d3bb61f4bd4d@redhat.com>
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-2-d3bb61f4bd4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:06:04 +0000
Message-Id: <20260713120605.2261C1F000E9@smtp.kernel.org>
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
- [High] Dereference of `panel_bridge` after it may have been freed inside =
`devm_drm_panel_bridge_release()`.

Pre-existing issues:
- [High] `drm_panel_bridge_remove()` accesses `panel->dev` for devres remov=
al, but the underlying `struct device` may have already been freed.
--

--- Patch [2]: [PATCH v2 2/5] drm/bridge/panel: hold a reference to the wra=
pped panel ---
commit 94f4ef45af3a89d595cd95811619b47c422771c3
Author: Albert Esteve <aesteve@redhat.com>

drm/bridge/panel: hold a reference to the wrapped panel

This patch acquires a reference to the wrapped drm_panel in
drm_panel_bridge_add_typed() using drm_panel_get() and releases it in
the teardown paths to prevent dereferencing dangling pointers.

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
This is a pre-existing issue, but can accessing panel->dev here lead to
a use-after-free of the struct device?

While this patch successfully keeps the drm_panel structure alive via
drm_panel_get(), it does not appear to take a get_device() reference to
the underlying struct device (panel->dev).=20

If the panel device was completely unregistered, could the struct device
memory be freed while the drm_panel object remains alive, causing
devm_drm_put_bridge() to operate on a dangling pointer?

> +	drm_panel_put(panel);
>  }
>  EXPORT_SYMBOL(drm_panel_bridge_remove);
> =20
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
Could this result in a use-after-free of the panel_bridge structure?

If the consumer device unbinds, devm_drm_panel_bridge_release() calls
drm_bridge_remove(bridge). If this drops the final reference to the
bridge, it triggers __drm_bridge_free() which frees the panel_bridge
structure.

The very next line calls drm_panel_put(panel_bridge->panel). Does this
dereference the potentially freed panel_bridge pointer?

Perhaps panel_bridge->panel should be cached in a local variable before
calling drm_bridge_remove()?

>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-drm_refcou=
nt_wiring-v2-0-d3bb61f4bd4d@redhat.com?part=3D2
