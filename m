Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102E5C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741F110E130;
	Fri, 14 Aug 2026 13:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i+PWK5iz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BD110E130
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2C60404DC;
 Fri, 14 Aug 2026 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F541F000E9;
 Fri, 14 Aug 2026 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715426;
 bh=Js/druZfICbFHsJVphx5BgfqICMitfY59Y3yOdHvYRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i+PWK5izi3Rx1U4uVH1K7IW6cWLfu9t3b6kxCZ+7V1C2XI9f9SgPTWrDV5yOMSLeT
 Ah8p/l5irpUwMkO0Zd69ApbZZKCUoO5o03TSi3loyHIo7SW5MGeclhp1DN8cZPAYoi
 EmbsTTPuyTH844oiYl/Jj6loN5GSl3Uo22e9m6qxqQHlHpTkhDl9BfcNL15//SHAFX
 ihPgHjr2sU6uimjjd9H7lLGE4ucIc4A65J7Nodt0KomCi263UuhKVNMIs068lfdvLy
 aA27bQi67Gx3dMnyW2MjcnBeRHfhVVSqprkpQp0Lcv8acTqLZOHXN2IdMrOQ4+0BUn
 t3NUcLElEBXtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: tda998x: Handle short CEC register reads
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814133952.1386158-1-ruoyuw560@gmail.com>
References: <20260814133952.1386158-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 13:50:26 +0000
Message-Id: <20260814135026.B5F541F000E9@smtp.kernel.org>
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
- [High] Dead code in `cec_enamods()` error check allows overwriting the re=
gister configuration when `cec_read()` fails.
--

--- Patch [1]: [PATCH] drm/bridge: tda998x: Handle short CEC register reads=
 ---
commit 2bfd5ce7155e5841764b8ec506e16365cd7190b6
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/bridge: tda998x: Handle short CEC register reads

This commit updates the error handling in cec_read() to ensure both messages
of the I2C transfer complete successfully before using the returned byte. If
the transfer is short or fails, it preserves the 0 fallback value to avoid
returning uninitialized stack memory.

> diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridg=
e/tda998x_drv.c
> index 0b966c9844e70..fb414584962b7 100644
> --- a/drivers/gpu/drm/bridge/tda998x_drv.c
> +++ b/drivers/gpu/drm/bridge/tda998x_drv.c
> @@ -438,7 +438,7 @@ cec_read(struct tda998x_priv *priv, u8 addr)
>  	int ret;
> =20
>  	ret =3D i2c_transfer(priv->hdmi->adapter, msg, ARRAY_SIZE(msg));
> -	if (ret < 0) {
> +	if (ret !=3D ARRAY_SIZE(msg)) {
>  		dev_err(&priv->hdmi->dev, "Error %d reading from cec:0x%x\n",
>  			ret, addr);
>  		val =3D 0;
>  	}
> =20
>  	return val;

[Severity: High]
This is a pre-existing issue, but since cec_read() returns a u8, does the
error handling in callers like cec_enamods() work correctly?

For example, in drivers/gpu/drm/bridge/tda998x_drv.c:cec_enamods():

	int val =3D cec_read(priv, REG_CEC_ENAMODS);

	if (val < 0)
		return;

	if (enable)
		val |=3D mods;
	else
		val &=3D ~mods;

	cec_write(priv, REG_CEC_ENAMODS, val);

Because cec_read() returns an unsigned 8-bit integer, val will be
zero-extended and can never be negative. If a read fails due to an I2C erro=
r,
it returns 0, which bypasses the val < 0 check.

Could this result in writing back a modified 0 to REG_CEC_ENAMODS and
wiping out other enable bits, potentially causing the CEC module or clocks
to be disabled unexpectedly until a full reset occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814133952.1386=
158-1-ruoyuw560@gmail.com?part=3D1
