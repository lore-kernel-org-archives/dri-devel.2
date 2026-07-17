Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386B5C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0D610E46D;
	Fri, 17 Jul 2026 14:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PAi9eNQh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA9910E46D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:15:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB8544036E;
 Fri, 17 Jul 2026 14:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4062F1F000E9;
 Fri, 17 Jul 2026 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784297754;
 bh=PWmynWdmJCbGEA4s7/7QkezQ2K2zoHYSwhB5f30EMsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PAi9eNQh9aH1Lw/SeI2hO2ZGtmNWMDDvAV2jiC2CrbcsK3VK6hLDFd27bfuAef+RU
 FO50LXPoxmv2IKSyBvkca/PQT4iqPqQLzrYOyqjnBe4oWlVP2qaFVIMGEZXhpe1EcY
 LWHXXjGH/wtBRG0/goiNOIdLyWYr6lg/TRCob7AF3Ir2xs8nT/I4TiRDC9yGU/RhXo
 nC7CXdPWtFidhif5q4ZJuJfgaZZ7/Uoefa94JQCqXN/7t8QeFfRggfuyuaKNn4werG
 TH2aeh0T2VCv/K8qIIJXMScB3aBW2GkzaXmOyoU6atuRJfU2OzZN2+N1hlKb5wPd8N
 zKefFIqBghhrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/bridge/panel: hold a reference to the
 wrapped panel
To: "Albert Esteve" <aesteve@redhat.com>
Cc: imx@lists.linux.dev, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260717-drm_refcount_wiring-v3-2-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
 <20260717-drm_refcount_wiring-v3-2-023900c32e01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:15:53 +0000
Message-Id: <20260717141554.4062F1F000E9@smtp.kernel.org>
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
- [High] Releasing the panel reference in the unregister paths instead of a=
 .destroy callback introduces a Use-After-Free.

Pre-existing issues:
- [High] Accessing `panel->dev` in `drm_panel_bridge_remove()` can cause a =
Use-After-Free of a `struct device` if the panel device has been unregister=
ed.
--

--- Patch [2]: [PATCH v3 2/4] drm/bridge/panel: hold a reference to the wra=
pped panel ---
commit ac2f873b583c71488e3debe5277a8e3347eee2cd
Author: Albert Esteve <aesteve@redhat.com>

drm/bridge/panel: hold a reference to the wrapped panel

This commit acquires a reference to the drm_panel in=20
drm_panel_bridge_add_typed() to prevent dangling pointers. It then=20
releases the reference in each teardown path.

> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 4978ec98a0828..3bfa18167dd26 100644
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
This is a pre-existing issue, but could accessing panel->dev here lead to a=
=20
use-after-free if the panel device has already been unregistered?

While drm_panel_get() keeps the drm_panel alive, it doesn't appear to acqui=
re
a reference to the underlying struct device. If the device is unbound and=20
freed, panel->dev becomes a dangling pointer.

Could devm_drm_put_bridge() then dereference it when traversing the devres=
=20
list?

> +	drm_panel_put(panel);

[Severity: High]
Does this drop the panel reference prematurely and cause a regression?

Since drm_bridge objects are refcounted, calling drm_bridge_remove() only=20
unregisters the bridge and drops the list reference. The bridge could remai=
n=20
alive if an active DRM pipeline holds a reference.

If the panel is freed here, could subsequent DRM operations on the bridge=20
dereference panel_bridge->panel and trigger a use-after-free?

Would it be safer to move the drm_panel_put() to a new .destroy callback in=
=20
panel_bridge_bridge_funcs, which is invoked by __drm_bridge_free() when the=
=20
bridge's refcount reaches zero?

>  }
>  EXPORT_SYMBOL(drm_panel_bridge_remove);
> =20
> @@ -357,11 +360,16 @@ EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
>  static void devm_drm_panel_bridge_release(struct device *dev, void *res)
>  {
>  	struct drm_bridge *bridge =3D *(struct drm_bridge **)res;
> +	struct panel_bridge *panel_bridge;
> +	struct drm_panel *panel;
> =20
>  	if (!bridge)
>  		return;
> =20
> +	panel_bridge =3D drm_bridge_to_panel_bridge(bridge);
> +	panel =3D panel_bridge->panel;
>  	drm_bridge_remove(bridge);
> +	drm_panel_put(panel);

[Severity: High]
Similarly, if the bridge is kept alive by a reference elsewhere, does dropp=
ing=20
the panel reference here risk a use-after-free regression in bridge callbac=
ks=20
later on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-drm_refcou=
nt_wiring-v3-0-023900c32e01@redhat.com?part=3D2
