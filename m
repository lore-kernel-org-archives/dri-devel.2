Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC10C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293F610E87D;
	Mon, 28 Sep 2026 10:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.b="fLN0afyl";
	dkim-atps=neutral
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216A010E87D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:13:44 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C1A0D201E1B;
 Mon, 28 Sep 2026 12:13:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1790590422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb4Yjp77spcxaZG05WUt+Kpo8YcP4gPOy4InyaCqEoI=;
 b=fLN0afyl965GjHtSUa5LvtibpPJmi4e3DbShK2yJHivuTGwCcnaLHZpLa7677wE7CDiNm8
 6QrDBzKS5CGThJCVY1aXUTg/tES59iZguMVybaXZVot0y90UI6LvA1+I2paqBA0wN//RQT
 IbXAd/VGkNSywAad02h3+9n48l4YJhTYWRm4wBsKV1jsZ1IBkOYV1cddXIi7biTGYh8iCw
 LkE4fVdyKmsMdsa8Y+ejs96QjWsXk7SXaEVju5y+CgQmi/GfzTKy7shW6u7RyeKC7fvIGf
 mOPZadsnrdmdYzVAqP09MvfKwknkzk9pAD8FHiw5+gMWdw+zMNakNrII59iDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1790590422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jb4Yjp77spcxaZG05WUt+Kpo8YcP4gPOy4InyaCqEoI=;
 b=bKPLf/TcFtT0sjO4Y4zOVA6k44EAPZt5jpZBprNIGQcsX3vRSyQiZ5s315qFr+wolEGGfE
 +CEoew5hiG80vK6lnrfwVW1cOPYZiQenbSlPj4SfXT9GPvvdUHmDvKrif5b6s4afvnaPzn
 6r9e/nPGgfL6qYcTkZEvyGs5srYXOOc8aeRtnqhEK4Kd78y9WK0V1u8WnN0BnpJbo2/nOu
 qQgsG43J1aZGRpiwMWV2LuBc0ehdlOAvoGF0PYeuKAaD2/5xozUFjbsTP2TZEuYuafsDQf
 NH5f9BslrIxjiGPiST/XEXVxAi1wHb9lPZ/lizQD2PpNKMm4i7uijbl7kvxIeA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790590422; a=rsa-sha256;
 cv=none;
 b=RZRS7nTJZI3pXBaimWS7dy23Gxapcoh7fEX+RqRppwGJD0V6oeXOBVqFeoXbsqZbRg8BXe
 XxYM1EmZqqTz4FMxO7s2kNwREHBDQ21PtIaa/9/+26RSLTzHBSReOZDSYAkrq7zz/2+2gu
 rv+vzFNTRd9q/gO8U9Cbb12NPdPzPlMABSidWfm6lBfsO9O13aIymMZ+wz3ewAyxxupg0C
 J0vhPN79gMiG6OmR2Jqdnk8fXcDwATJatmSN+HM+s8Rfw+ON1yqqpqJF8CTXaLnElo7Bif
 fqYBPfWu/iTi9sb+8Azu/hcAfAe9pW7PsrLpIMKBCvxSlzvGTnC7rP67036nsQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <d924369a2f907aa796d7eba692001593ef1e6d0d.camel@pengutronix.de>
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
Date: Mon, 28 Sep 2026 12:13:42 +0200
In-Reply-To: <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
References: <20260924-add-lt9211c-bridge-v9-0-d78b39677a61@oss.qualcomm.com>
 <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
 <61aa851b26f9aa85a3ec1dc4bc8f46d7f1fbd24e.camel@pengutronix.de>
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

On Fr, 2026-09-25 at 15:23 +0200, Philipp Zabel wrote:
> On Do, 2026-09-24 at 21:29 +0530, vishnu.saini@oss.qualcomm.com wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> >=20
> > LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> > bridge configuration by detecting and handling both LT9211 and LT9211C
> > variants from a single driver.
> >=20
> > Chip detection in lt9211_read_chipid() is extended to identify the
> > LT9211C by its distinct chip ID registers, and cross-checked against
> > the chip type requested by the DT compatible string to catch a
> > mismatched board/compatible combination.
> >=20
> > Add LT9211C-specific regmap support and use lt9211_chip_data with
> > i2c_get_match_data() to provide per-chip configuration.
> >=20
> > Five new functions implement the LT9211C DSI-to-LVDS initialisation
> > sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
> > lt9211c_configure_timing(), lt9211c_configure_plls() and
> > lt9211c_configure_tx().
> >=20
> > Defer the remaining LT9211C initialization to a work item scheduled
> > from atomic_enable(), since RX auto-detection requires an active DSI
> > stream.
>=20
> This is still wrong, and I don't understand why you need it.
>=20
> All scheduling initialization as a work item should allow is for
> downstream bridges and/or panels to be atomic_enabled while
> lt9211_work_func() is waiting for a vblank interrupt.
> They expect the LVDS signal to be active at this point. If LVDS is
> enabled at some unknown later point in time by the work item, any
> startup timing requirements the panel might have can not be applied
> correctly.
>=20
> Also, deferring initialization as a work item shouldn't have any
> influence on the upstream DSI signal. That should already be active
> when lt9211c atomic_enable is called. Could it be that there is a bug
> in your display controller or DSI bridge driver that causes the DSI
> signal to still not be completely active at this point?
>=20
> > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>=20
> I have not tested this version (yet).

I have now retested this on RK3576 - both as-is and with the
"drm/bridge: lt9211: drop delayed work" patch I just sent.

I still think we have to figure out why the DSI signal doesn't appear
to be streaming as it should when lt9211_atomic_enable is called in
your setup.

When enabling the lt9211c synchronously, is there any error?
Is just the Sot/RX: debug output incorrect?
Which display controller / DSI bridge drivers are used to send the DSI
signal?

regards
Philipp
