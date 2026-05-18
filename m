Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4772ACD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AB410E5E3;
	Mon, 18 May 2026 16:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="br9gs2ij";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198EF10E5E3;
 Mon, 18 May 2026 16:57:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A9ECE4E42CE4;
 Mon, 18 May 2026 16:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 624815FFA3;
 Mon, 18 May 2026 16:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E86511AF8B49; 
 Mon, 18 May 2026 18:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779123459; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+GUakJQgQQZFR4eLPRoEYE8uJGTNPLGY7yG6NqQt4F0=;
 b=br9gs2ijS56RroxBZhqIXRTDxRxrOt1E+VTi6oIGgEftGswlZl6ckZ8/bk1KhGsH6d5AIx
 WCl2r0QWQR1G8PyPsLIuMSEwum4loYYz2Yt7PgSKLea4v87HO8mb9a83Zvb+pDp3CgCp8Y
 rzRULoohRN7ioF9ATxpXUTDxbmwTO795rq7Pke2mXsCg4F2hRggnj2O6obtI2xtKh0SfgK
 SOO2QR36NKTPybZWsgL3YNn+S0dz1eRiyHi6U21UQkjrwAGh+m2k18tYi9extz+qrqglLU
 snTrBIIl3ZGHmuoF8QrK4DSR3nZCa0Wkeg0uakCMZFEIuBVtexvrt2Ftz17YxA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 18:57:26 +0200
Message-Id: <DILYMJY5CLJV.2FBCL0X62V418@bootlin.com>
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Liu Ying" <victor.liu@nxp.com>,
 "Adrien Grassein" <adrien.grassein@gmail.com>, "Peter Senna Tschudin"
 <peter.senna@gmail.com>, "Ian Ray" <ian.ray@ge.com>, "Martyn Welch"
 <martyn.welch@collabora.co.uk>, "Russell King" <linux@armlinux.org.uk>,
 "Douglas Anderson" <dianders@chromium.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Biju Das"
 <biju.das.jz@bp.renesas.com>, "Tommaso Merciai"
 <tommaso.merciai.xr@bp.renesas.com>, "Manikandan Muralidharan"
 <manikandan.m@microchip.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Xin
 Ji" <xji@analogixsemi.com>, "Loic Poulain" <loic.poulain@oss.qualcomm.com>,
 "Fei Shao" <fshao@chromium.org>, "Arnd Bergmann" <arnd@arndb.de>, "Kees
 Cook" <kees@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Lyude Paul" <lyude@redhat.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Marcus Folkesson"
 <marcus.folkesson@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon May 18, 2026 at 12:04 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hu=
b) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace in the list
> terminator and drop trailing commas there.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
