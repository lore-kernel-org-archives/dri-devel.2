Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB803C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82E310FA6F;
	Fri, 25 Sep 2026 13:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.b="dqHMBXFV";
	dkim-atps=neutral
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8260310FA6F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:23:30 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D5CB4200153;
 Fri, 25 Sep 2026 15:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1790342608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdhcquS8zcAZN7c0wYgqa4lDKnhin/2F2Ap2WGiqtYc=;
 b=dqHMBXFV5h+TJgepHN/PFBLJBiVvxvl7NS/i3ddKATSLdmGNL13XcjL99bREmPa46/cc1a
 9kU/G7kJidP57WjfziejC0AfDKUv4FWROMJHO3B1QrvbuJdlGV8tm51vgK9pZE5V+zTczF
 lUczsydndzJeeMKCWeqLQBYYp30iTHLo4RC8sFgc8JGjDQNlrRJJUBnILLR2DEmHTQVz3z
 XPJQWkLfwQI2PScER3iVeIekLXyE6JamyYqmNBINXJGI++iHuL5H8Lzu8Z7s+6iHpmUkCE
 6cgAa36UJiD6jSD/z3ml4wAhyddNv2wdcVfbSBfYvOOiE6vcXK1KOqu16/YjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1790342608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdhcquS8zcAZN7c0wYgqa4lDKnhin/2F2Ap2WGiqtYc=;
 b=VscFHX5Nilk5f/x1aNvmluoMFXEVapp3TjgLvYMQ8hv4v3LMvZwwuEcvdg2clKw3noeHRG
 Y3F5x7SoYIddKuRH5978oCUiWl9DigVEF1+4LNOVtibWjJXNUj8yjd5JcTGtp6IdERvC8m
 F0B67Aea8vE8SoLYps+S6k6bMQiFPXyz296R1aMaerAyZlImg9w3ddVAvkqX1jIXVGtjus
 x93AjsoweTWdf0L+KnREK8xAMz/HDjIhIB9rS7PUTR8Co+lpc290MUaja4773U8tANqXwE
 /9PxkUaXjnqpbG2oqhgXzpIY/8IphCeLAtjPaMRvlb/t6ZpY1tkWXnRhJJq40Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790342608; a=rsa-sha256;
 cv=none;
 b=YynP0Q/W82yQ93X7hMinn+nyM7N9P7qCjnIDcEwq/q7icZB7ctcqlV7vPiY+53ry0nygaY
 i+JJ08IqFBb2tyTGRPDB6hRlDOuxKIXjdD/xFRhJ131lhrtwKziPlsqpHvH7ZicWSRoTk7
 9ltcmt4CJ+Pcfgp1CHIgQzTttVMPXgi0CaGq/WDsCmQG/qu0f6RyLIatDtoMvfy+iFDSpj
 NQ22FB7MJ/BCdhcf5hMvtj7YEDyorullLcaxknnxk09ZMGtkvuEeuHBXivxdq1pflET05L
 /GYJcateQOXdAWheGv+/GuhVQ3c4k6UJYMV+XgBUCoXkwnk+Mh7t40FHPc94Zw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
Subject: Re: [PATCH v9 2/2] drm/bridge: add support for lontium lt9211c bridge
From: Philipp Zabel <p.zabel@pengutronix.de>
To: vishnu.saini@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Marek
 Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>, Nilesh
 Laad	 <nilesh.laad@oss.qualcomm.com>, Gopi Botlagunta	
 <venkata.botlagunta@oss.qualcomm.com>, venkata.valluru@oss.qualcomm.com, 
 Jessica Zhang <jesszhan0024@gmail.com>
Date: Fri, 25 Sep 2026 15:23:28 +0200
In-Reply-To: <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
 <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Do, 2026-09-24 at 21:29 +0530, vishnu.saini@oss.qualcomm.com wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
>=20
> LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> bridge configuration by detecting and handling both LT9211 and LT9211C
> variants from a single driver.
>=20
> Chip detection in lt9211_read_chipid() is extended to identify the
> LT9211C by its distinct chip ID registers, and cross-checked against
> the chip type requested by the DT compatible string to catch a
> mismatched board/compatible combination.
>=20
> Add LT9211C-specific regmap support and use lt9211_chip_data with
> i2c_get_match_data() to provide per-chip configuration.
>=20
> Five new functions implement the LT9211C DSI-to-LVDS initialisation
> sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
> lt9211c_configure_timing(), lt9211c_configure_plls() and
> lt9211c_configure_tx().
>=20
> Defer the remaining LT9211C initialization to a work item scheduled
> from atomic_enable(), since RX auto-detection requires an active DSI
> stream.

This is still wrong, and I don't understand why you need it.

All scheduling initialization as a work item should allow is for
downstream bridges and/or panels to be atomic_enabled while
lt9211_work_func() is waiting for a vblank interrupt.
They expect the LVDS signal to be active at this point. If LVDS is
enabled at some unknown later point in time by the work item, any
startup timing requirements the panel might have can not be applied
correctly.

Also, deferring initialization as a work item shouldn't have any
influence on the upstream DSI signal. That should already be active
when lt9211c atomic_enable is called. Could it be that there is a bug
in your display controller or DSI bridge driver that causes the DSI
signal to still not be completely active at this point?

> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

I have not tested this version (yet).


regards
Philipp
