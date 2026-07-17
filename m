Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45573C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDAA10E47A;
	Fri, 17 Jul 2026 14:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cui97pRK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B945910E47A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:31:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F3A460A59;
 Fri, 17 Jul 2026 14:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1461F000E9;
 Fri, 17 Jul 2026 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784298692;
 bh=U8NpefZYQvR5+qGNffnGRppGKx0+pfM2H3KJR95qoiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cui97pRKV5RWzfBg6OW8SI43q6J7uQ78Xc9VS5tOjE1Ecc7yicSSZQfQet6+iD6NT
 yUlOLXMAmMYZK1h0T/VEKHG98xn+n0Gir870n47FYPGphmWVho8svG0/uCcWKqp14A
 /MqBwimNZjIvfhELTYFiaQGVWXcJH4Qfu29XW0WJSWUqbBiddx7F/+SBg3uJqZmPTK
 3k9VIGw+2ssOgPhzi3FJpQtWuDpJEj9xGl2um1wiAPFcf+ColFFC90xNARuJJ5QTVH
 zCnmv+p2Y/z/37pV3MwmRdbTNoW+2I2L7xTwl/qzoCjVZDH3CJP87RKu1B4DFY5Lw8
 nUYOlAsVY2xOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/panel: have drm_panel_add/remove manage a
 list reference
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com, Frank.Li@kernel.org,
 linux-sunxi@lists.linux.dev
In-Reply-To: <20260717-drm_refcount_wiring-v3-1-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
 <20260717-drm_refcount_wiring-v3-1-023900c32e01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:31:32 +0000
Message-Id: <20260717143132.8B1461F000E9@smtp.kernel.org>
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

New issues:
- [High] Modifying drm_panel_add() to take a reference replaces a list-iter=
ation crash with a memory leak and a devres Use-After-Free for drivers that=
 fail to call drm_panel_remove().

Pre-existing issues:
- [High] Lookup functions return raw pointers without acquiring references,=
 failing to protect the caller from concurrent panel removal.
- [High] Use-After-Free in the drm_panel_follower API when a panel is unbou=
nd.
--

--- Patch [1]: [PATCH v3 1/4] drm/panel: have drm_panel_add/remove manage a=
 list reference ---
commit 2e9c2d76403b7b7e3caee78c96bffbb1f61d8df7
Author: Albert Esteve <aesteve@redhat.com>

drm/panel: have drm_panel_add/remove manage a list reference

The commit adds a reference acquisition to drm_panel_add() and a release=20
to drm_panel_remove() to prevent the panel from being freed while still=20
linked in panel_list. The global registry now holds a counted reference=20
for as long as the panel is listed.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 2c5649e433dfb..545fe93dc28fe 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -81,6 +81,7 @@ static void drm_panel_init(struct drm_panel *panel, str=
uct device *dev,
>   */
>  void drm_panel_add(struct drm_panel *panel)
>  {
> +	drm_panel_get(panel);

[Severity: High]
Does taking a reference here replace a list-iteration crash with a memory
leak and a devres use-after-free for drivers that fail to call=20
drm_panel_remove()?

If a driver calls drm_panel_add() but fails to call drm_panel_remove() on=20
unbind, the new drm_panel_get() reference prevents the struct drm_panel fro=
m=20
being freed, leaving it in panel_list. However, the driver's devres teardow=
n=20
still executes, freeing all underlying hardware resources like clocks,=20
regulators, and GPIOs.=20

If another driver later discovers this 'zombie' panel via=20
of_drm_find_panel() and invokes its callbacks, will the panel driver access=
=20
freed devres resources, causing a use-after-free or hardware lockup?

>  	mutex_lock(&panel_lock);
>  	list_add_tail(&panel->list, &panel_list);
>  	mutex_unlock(&panel_lock);
>  }


This isn't a bug introduced by this patch, but lookup functions return raw
pointers without acquiring references, failing to protect the caller from
concurrent panel removal:

drivers/gpu/drm/drm_panel.c:of_drm_find_panel() {
    ...
	list_for_each_entry(panel, &panel_list, list) {
		if (panel->dev->of_node =3D=3D np) {
			mutex_unlock(&panel_lock);
			return panel;
		}
	}
    ...
}

[Severity: High]
While the commit message claims holding a reference in the registry ensures
the object outlives concurrent lookups, does this only protect the list=20
iteration? Once the mutex is unlocked, if a concurrent thread executes=20
drm_panel_remove() (e.g. due to driver unbind), could it drop the registry'=
s=20
reference and potentially free the panel memory while the caller is activel=
y=20
using the unprotected pointer?


This is also a pre-existing issue, but there appears to be a use-after-free
in the follower API when a panel is unbound:

drivers/gpu/drm/drm_panel.c:drm_panel_add_follower() {
    ...
	panel =3D find_panel_by_dev(follower_dev);
	if (IS_ERR(panel))
		return PTR_ERR(panel);

	get_device(panel->dev);
	follower->panel =3D panel;

	mutex_lock(&panel->follower_lock);
    ...
}

[Severity: High]
Does acquiring a reference to the panel's underlying device via=20
get_device(panel->dev) fail to keep the devres-allocated struct drm_panel=20
alive? Because the panel is allocated via devm_drm_panel_alloc(), its memor=
y=20
is tied to the driver's devres lifecycle, not the struct device refcount.

If the panel driver unbinds, devres frees the struct drm_panel memory=20
regardless of the device refcount, leaving the follower driver with a dangl=
ing=20
follower->panel pointer.

When the follower unbinds, it calls drm_panel_remove_follower():

drivers/gpu/drm/drm_panel.c:drm_panel_remove_follower() {
	struct drm_panel *panel =3D follower->panel;
	int ret;

	mutex_lock(&panel->follower_lock);
    ...
}

Won't attempting to lock the freed memory (mutex_lock(&panel->follower_lock=
))=20
cause a direct use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-drm_refcou=
nt_wiring-v3-0-023900c32e01@redhat.com?part=3D1
