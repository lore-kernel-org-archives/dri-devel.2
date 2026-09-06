Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EAFC79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619BE10E28A;
	Sun,  6 Sep 2026 19:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nxtnz6aL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87B910E28A
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 19:55:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 038CD601DE;
 Sun,  6 Sep 2026 19:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6DE1F00A3A;
 Sun,  6 Sep 2026 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788724555;
 bh=VBEDqqN7Y9WjX8AeCVSMHJyKdPTX7pxJOXPP6EKJQBY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nxtnz6aLCnEkIIofzvAkGtL+JFk0VK/u+hq28CTCw33O+lwXBSkd1r9aF3yH44J8P
 rhRhu12zQYBzGND75EBOSHteFJV/TUGBUKN5qt+fFJnocD+Ag1uofa4brnk+8KkgMR
 bU9BjfvD/0uaVSseKHhu9kqjVFUSoOEb8Yi3osvmkgnhWkaT31h7f1wQe7YcJCdpbd
 Bzacjf7v+UcowN+/o0hWYKouVZgxmCLNmWb6pHNicdYGtq0MtpKLEcNp+XPNOoYNX0
 qDKgxkZMaKxVjIMl7JlSLoWRUGwDq3BItYiEu+139I/xBKSSDk9khNHtRMdSJUOopd
 JPgbm/EatxzAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/meson: fix device_node leak in
 meson_encoder_dsi_probe()
To: "Miles Krause" <mileskrause5200@gmail.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260906-meson-dsi-of-node-leak-v1-1-9d183560279d@gmail.com>
References: <20260906-meson-dsi-of-node-leak-v1-1-9d183560279d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 19:55:54 +0000
Message-Id: <20260906195555.6C6DE1F00A3A@smtp.kernel.org>
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
- [High] Missing drm_bridge_remove() on error paths after drm_bridge_add() =
leaves the bridge permanently leaked and attached to the global bridge_list.
--

commit 314776e79a61e3245fd41353a7a8e22de95afc63
Author: Miles Krause <mileskrause5200@gmail.com>

drm/meson: fix device_node leak in meson_encoder_dsi_probe()

This commit fixes a device_node leak in meson_encoder_dsi_probe() by
dropping the reference to the remote node after acquiring the bridge.

> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/=
meson/meson_encoder_dsi.c
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -120,6 +120,7 @@ int meson_encoder_dsi_probe(struct meson_drm *priv)
>  	}
> =20
>  	meson_encoder_dsi->bridge.next_bridge =3D of_drm_find_and_get_bridge(re=
mote);
> +	of_node_put(remote);
>  	if (!meson_encoder_dsi->bridge.next_bridge)
>  		return dev_err_probe(priv->dev, -EPROBE_DEFER,
>  				     "Failed to find DSI transceiver bridge\n");

[Severity: High]
This is a pre-existing issue, but since you are fixing leaks in this probe
function, could we also address a bridge leak further down in
meson_encoder_dsi_probe()?

When drm_bridge_add() is called, it adds the bridge to the global bridge_li=
st
and increments its refcount. If a subsequent initialization step fails, such
as drm_simple_encoder_init() returning an error:

    drm_bridge_add(&meson_encoder_dsi->bridge);

    meson_encoder_dsi->priv =3D priv;

    ret =3D drm_simple_encoder_init(priv->drm, &meson_encoder_dsi->encoder,
                                  DRM_MODE_ENCODER_DSI);
    if (ret)
        return dev_err_probe(priv->dev, ret,
                             "Failed to init DSI encoder\n");

Does this error path return directly without calling drm_bridge_remove()?

Because the devres cleanup for devm_drm_bridge_alloc only drops the refcount
by 1, the bridge remains attached to the list and memory is never freed. If
the module is unloaded, traversing the list later could oops because the
bridge function pointers will point to freed module text.

This same missing drm_bridge_remove() pattern also exists on the error paths
after drm_bridge_add() in meson_encoder_hdmi_probe() in meson_encoder_hdmi.c
and meson_encoder_cvbs_probe() in meson_encoder_cvbs.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-meson-dsi-=
of-node-leak-v1-1-9d183560279d@gmail.com?part=3D1
