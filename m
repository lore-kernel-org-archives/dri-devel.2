Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F40CD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5065910E796;
	Mon, 18 May 2026 10:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SEYHc1kI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7287610E77B;
 Mon, 18 May 2026 10:12:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FBF743215;
 Mon, 18 May 2026 10:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF92AC2BCB7;
 Mon, 18 May 2026 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779099129;
 bh=f/arUHoVXKfmviLjeY1oEv2xDMa9pOsUjvRxdFaqouA=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=SEYHc1kIT60KWlsqIT7KwCHeIEYzYoBj3+8hAbCRMa+PnvfmPELgqq37VcP9ezC/g
 WkOz3xrgiGbXrBJh7+5X8GHJNSVrbEkMz7EZ5KQs0+F3p++5CW0jllxmPn+O/e7baF
 hbSgD7ol4GsJvtm8659d4bXUxsW9BJj50WYlYLHdqRdKhYz9Cul4rTuVHItF3eDAEE
 LcMjArAK5jtQM+Uae6AAUxw1sdaEm5eYNe6Nj2XE6E5eHeB8xdLSzVfDB2kvZw8Srj
 16VmQK/LcU1JIaR71mts0fJMkXiCE6Lp8zxP9Y1TumztaIQGJ3qfM1iyiTpPPbXwUc
 /TEfLc7kjwD8w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 12:12:01 +0200
Message-Id: <DILQ0599UG5L.1PYZZRYNMNEH0@kernel.org>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Lyude
 Paul" <lyude@redhat.com>, "Marcus Folkesson" <marcus.folkesson@gmail.com>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
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
 <manikandan.m@microchip.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Xin Ji" <xji@analogixsemi.com>,
 "Loic Poulain" <loic.poulain@oss.qualcomm.com>, "Fei Shao"
 <fshao@chromium.org>, "Arnd Bergmann" <arnd@arndb.de>, "Kees Cook"
 <kees@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
References: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
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
> I was unsure if I should split the patch. I guess doing all of
> drivers/gpu/drm/bridge together is fine, please tell if I should split
> off drivers/gpu/drm/nouveau/ and/or drivers/gpu/drm/sitronix/.

Acked-by: Danilo Krummrich <dakr@kernel.org>
