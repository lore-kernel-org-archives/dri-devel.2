Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E536C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB52210E13F;
	Fri, 14 Aug 2026 14:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HM+LO37s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029C610E56C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:23:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C65CF42E39;
 Fri, 14 Aug 2026 14:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAE31F000E9;
 Fri, 14 Aug 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717394;
 bh=13TeJbDqTCHOpuY7aIZYP2lQRUZh5lQa/x46GTOeWaI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HM+LO37seIVJc2wND8nimXVHQT7BaGMGE26CpcJ4+EHo5tVI2CMvYIpzgp+sKxUao
 MAs2U+d+jkedyPUjsq49ik9EmfSt4owZ9kJygfh435djsRvCeps9ZRrSDTL1bXl+gh
 bqrtlQmasuF/z0Pr/Xu+1QqrCATt/BuzWXywGTwO8LlY4rPSBrXFBSHLYXaOUQMSyn
 bYSljk+GPoWtuPevmXrj4ytZDO9yRAz91yu9BTdBW0ckvIX7S2hHA+2MgJWQPgUXwb
 6APizfHlY8yXJRupYzjTL4D0pMXnzs8zxQkytLnj1LlRDv+XX1YMku+K+4h8XTgOPd
 g9z85rsGYDRTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] drm/bridge: samsung-dsim: don't create a
 panel_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-11-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-11-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:23:14 +0000
Message-Id: <20260814142314.7FAE31F000E9@smtp.kernel.org>
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
- [Critical] Manual gpiod_put() on a devres-managed GPIO and failure to cle=
ar the dsi->te_gpio pointer leads to UAF and double free.
--

--- Patch [11]: [PATCH 11/11] drm/bridge: samsung-dsim: don't create a pane=
l_bridge ---
commit 3269367ff66fe6dd842314973873ed18b84437ca
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: samsung-dsim: don't create a panel_bridge

Now a panel_bridge is automatically created for every drm_panel, so this
code would lead to creating a second panel_bridge for the same panel. This
commit simplifies the code by just getting a reference to the already-exist=
ing
bridge.

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e2fc69fc51b60..ca419edb1c1a6 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
[ ... ]
> @@ -1931,21 +1930,9 @@ static int samsung_dsim_host_attach(struct mipi_ds=
i_host *host,
>  	if (!remote)
>  		return -ENODEV;
> =20
> -	panel =3D of_drm_find_panel(remote);
> -	if (!IS_ERR(panel)) {
[ ... ]
> -	} else {
> -		next_bridge =3D of_drm_find_and_get_bridge(remote);
> -		if (!next_bridge)
> -			ret =3D -EINVAL;
> -	}
> +	next_bridge =3D of_drm_find_and_get_bridge(remote);
> +	if (!next_bridge)
> +		ret =3D -EINVAL;
> =20
>  	of_node_put(remote);
> =20

[Severity: Critical]
This isn't a bug introduced by this patch, but there is a pre-existing doub=
le
free and use-after-free issue in this driver related to the TE IRQ handling,
which is called from the error path of samsung_dsim_host_attach().

When a CMD mode device attaches, samsung_dsim_register_te_irq() allocates
dsi->te_gpio using devm_gpiod_get_optional(). If it fails later, or when
samsung_dsim_unregister_te_irq() is called on detach, the code manually cal=
ls
gpiod_put(dsi->te_gpio) without clearing the pointer.

Because the GPIO was allocated with devres, won't this manual gpiod_put()
cause a double free when the device unbinds and devres cleans up?

drivers/gpu/drm/bridge/samsung-dsim.c:samsung_dsim_unregister_te_irq() {
	if (dsi->te_gpio) {
		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
		gpiod_put(dsi->te_gpio);
	}
}

This manual cleanup is also present in the error path of
samsung_dsim_register_te_irq():

drivers/gpu/drm/bridge/samsung-dsim.c:samsung_dsim_register_te_irq() {
	...
	if (ret) {
		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
		gpiod_put(dsi->te_gpio);
		return ret;
	}
	...
}

Additionally, since samsung_dsim_unregister_te_irq() leaves a stale pointer
in dsi->te_gpio, could this lead to a use-after-free?

If a VIDEO mode device subsequently attaches, it skips registering the TE I=
RQ
and leaves the stale pointer in place. When it detaches,
samsung_dsim_host_detach() unconditionally calls
samsung_dsim_unregister_te_irq(), which would call gpiod_to_irq() on the
already freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D11
