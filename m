Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B45C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A6510E418;
	Fri, 17 Jul 2026 14:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UO7rqgSz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31C310E418
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:14:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF6D860204;
 Fri, 17 Jul 2026 14:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2500C1F000E9;
 Fri, 17 Jul 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784297660;
 bh=QGEPxinQPATW4/n79/tOeVM9ZGeVG81OvW++RWAT+Xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UO7rqgSzBtNxk+2IoFOo0+3sUeooTZq5i8IC5ToW2Xft4u/E60NeX3DAKtXCQsebl
 aJuhLtZiobGg90rQaG+qnGOc6NbasfJA7xNvUzv30bXoeEQR7NnLUcH5jZx6dxt5bO
 Qr+6NyLc7mwppJaPTZzChgOB4zj6JSsUgPxKG57FFWw11707sqO62g4vFXCPXLlaD+
 kvDpYSf/8KXwso6+UxsGP1Vkk/zzLuad0p9IUbyhdXUTEfJEeHCV2gRQ6OSBClVP4P
 eC5YJlwWFjWlfGcNb3gNB7yjOHZE2sjbNul+ooUUbundHTz2wUYya7SZOjsK976ChM
 /d3yO4FHkYtHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/panel: find_panel_by_fwnode() return a
 counted reference
To: "Albert Esteve" <aesteve@redhat.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-sunxi@lists.linux.dev, wsa+renesas@sang-engineering.com
In-Reply-To: <20260717-drm_refcount_wiring-v3-4-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
 <20260717-drm_refcount_wiring-v3-4-023900c32e01@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:14:19 +0000
Message-Id: <20260717141420.2500C1F000E9@smtp.kernel.org>
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
- [High] TOCTOU race condition in `drm_panel_add_follower` leading to Use-A=
fter-Free of `panel->dev`.
--

--- Patch [4]: [PATCH v3 4/4] drm/panel: find_panel_by_fwnode() return a co=
unted reference ---
commit 2c073e53f181794d94244eff0882b1f1a661d995
Author: Albert Esteve <aesteve@redhat.com>

drm/panel: find_panel_by_fwnode() return a counted reference

This patch updates find_panel_by_fwnode() to return a reference-counted
drm_panel pointer, preventing the panel's container memory from being
released prematurely. It also updates drm_panel_remove_follower() to
balance the reference with drm_panel_put().

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 72cf86253c0cd..a00ae98ed0956 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
[ ... ]
> @@ -554,6 +560,7 @@ static struct drm_panel *find_panel_by_fwnode(const s=
truct fwnode_handle *fwnode
> =20
>  	list_for_each_entry(panel, &panel_list, list) {
>  		if (dev_fwnode(panel->dev) =3D=3D fwnode) {
> +			drm_panel_get(panel);
>  			mutex_unlock(&panel_lock);

[Severity: High]
This is a pre-existing issue, but does releasing the panel_lock here leave
a TOCTOU race window where panel->dev can be freed before it's used by the
caller?

If the panel's device is unregistered concurrently (e.g., via sysfs unbind
of its parent), the following sequence seems possible:

CPU1 in find_panel_by_fwnode():
    drm_panel_get(panel);
    mutex_unlock(&panel_lock);
    return panel;

CPU2 concurrently unregisters the device:
    drm_panel_remove() runs, removing the panel from panel_list.
    The device's reference count drops to zero and the struct device behind
    panel->dev is freed.

CPU1 in drm_panel_add_follower():
    get_device(panel->dev);

Since panel->dev now points to a freed device, could this cause a
use-after-free?

>  			return panel;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-drm_refcou=
nt_wiring-v3-0-023900c32e01@redhat.com?part=3D4
