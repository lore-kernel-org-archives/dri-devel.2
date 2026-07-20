Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11F8C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F8910E574;
	Mon, 20 Jul 2026 11:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ofzioy2+";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1484710E183
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:26:03 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f73d9c177so957288f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784546762; x=1785151562;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0kZaE29KZfxfDEOFCh44C3Vpuraa0Raea1WRcoaoqWA=;
 b=ofzioy2+tClJXdJQVp6Tz9bNz757M3Q4gLH6H5hPN0kNYQ92GYxvZE2FzkectraBGQ
 9yytZkuo8ADeCwCD81Sciai5bI/+zkI1IsS+hGuY6YdtnDEMDkmY+KLf1ZPtYbO/5FWe
 5PgAxXv9Jy0h0l0h14NyatQ4WcBJpXkK/ltcttLXlc6xugSp2/Pf/PJHNp4atnuJedaH
 IOOSN4MgQfckPaSio32dKpzQuV9Cdln2UbZu9cOwjwkAzZlv8QoqyHpxeL/H5S3ycAmq
 n5/7EEILFC2m6Zw5zbxXyYJKnWz/hHSEF2GELwt1uFvJuTLPER8XELALFt3KqmQ97Xsx
 KnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546762; x=1785151562;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0kZaE29KZfxfDEOFCh44C3Vpuraa0Raea1WRcoaoqWA=;
 b=bQRx01G0MKwCVWqmUSRPj4tbYeBh3Isdl21O21tfHoNaHuNY3IQ3EuC/6A2lUdL0yU
 Bn/vHWvj5tLCyNBuOLbaNy/yRPt9FLEx31GETCNQN1UIpuvJuEoI9830dp/cYTn3uQbg
 OgNXi0arYNHJdVxk1L/qXfS2z+vvvjQmbZHDj7KZoXjpWGAQ1SyplFboY+NIciTJ1HJy
 TeC79TDNVJ9XWz7pO3DWZZhBiQBV5pSzLAPxOwjw5mVvPi6o4Mn++0a3SRE+/uFXyAQX
 i745Tj+elLwyytL8C7FN1Sen5JpghxQY0dQO+1S7dgsBzh57i8gJjxhuITfX1sSLovhm
 /IHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrbg3KWdLmK4p9CQON6lDTQuIRiamddovwKOqVJMxpIUoDg2rcp2xRaCNyhPCQUNj4iGjuDA1yBXxs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuHOin8TaOm8Y+jD3p+tFHxOTVZGppM/x8SvFeSH/3eHUSjU4K
 i67uwQMRvzIeG9p/Eg52+UOEFg8FQbfAXQ+6VzL8GyQZB3brkdYP9PXprcoOmEpGYbM=
X-Gm-Gg: AR+sD13Ystigu1k+lr4lgE/aes5j8JpdCcyzFj/wDZ4eudZErCiJo50BVqLEmsW7isp
 kTXqgVY78gV7hfAJf9WwBJmkhjmnxO2KliKkhWlncLilSMFpuT36E91DdtjqpCTurmWq+BSw/h4
 OpAJWNujCtfYY/wnurHwX8X0JKjBy59+mzsbTxSSAim4uBBp07pykIFZZzjIASPldbhGy/JUNSO
 sDvaDhtqB8aUVC20JsfwGT2WE7jc64yV1PqS1lYxRGXP6q7cPV7zFJl1XDABXTM+oAyabWAn6Kj
 TazbuRn1mp3yjoHGHRk1M9xNuNSDHWMFy/wW1vc3GJ8wtJOsiMOiCOiXy3Uvw0VH9jPyQ9ZoSN2
 dpqk1cUWZNsfRsLcAqzQqXD31xpZgZNPNE5ib/sjV3QnuBrqocI+KOYda30dS4JCaSk4pc9qwFY
 WUTBFxxbeZjfVUNrI8RY6RN0NfZfQUp7l630cyqYoEC5J0KYt4bWtUjjqKADGh9agQfA==
X-Received: by 2002:a05:6000:2084:b0:47e:4379:a4fd with SMTP id
 ffacd0b85a97d-47f6230e6e8mr16385810f8f.19.1784546761738; 
 Mon, 20 Jul 2026 04:26:01 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f6980582csm21915987f8f.13.2026.07.20.04.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:26:00 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jagan Teki <jagan@amarulasolutions.com>,
 Liu Ying <victor.liu@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Xin Ji <xji@analogixsemi.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Kees Cook <kees@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm: Use named initializers for arrays of
 i2c_device_data
Date: Mon, 20 Jul 2026 13:25:46 +0200
Message-ID: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3145;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=DXHsMDsmw7OPrQMasfuuVj90fwlpF7W2mtp2LHUpCd0=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXgW7gpMZ25NHhb69GDKSEdwCHXzn3kK+CL6GQ
 YEYOEYraPyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal4FuwAKCRCPgPtYfRL+
 TsRrB/9HH4ICrBdcptv8zk9/ja89r2p4MVgyQqpVESitnWboEdmXu76hkkMrDIezARlH0zh27bM
 KHi2NKla4E4G+m0Id7jCnnqCJpJ+IpM7B7Om8rRZOx+Ma7oL9qGFS7Y7nnNz4pJgnMreSiqtnTk
 201oXhn/mZSy8BELrZk3b0WQ9jjX5BBqxRp4VSo61PWOCNBX/+Qmhd0FQOclDr5fjGJ1tE1wBYo
 NBlvms2YI562rbIyXQR1AWJ6dLfEbAtm5djiVuaJxqCOrzuOyznOyQL/96kV0qkNOouaJpnF3r+
 cQKziezR+2biFbt1cn8e8BF52gllfIQzS8I70AumtH/2E53H
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
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

Hello,

the objective of this patch set is to prepare drm for a change to
i2c_device_id. See
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the details.

(Implicit) v1 is available at
https://lore.kernel.org/dri-devel/20260518100401.631351-2-u.kleine-koenig@baylibre.com

I was asked to split the patch, so that is what is done here.

The first submission received a few review tags (by Liu Ying, Danilo
Krummrich, Laurent Pinchart and Luca Ceresoli). I only added Luca
Ceresoli's tag here as he explicitly noted that I can when splitting.

The patches are pairwise independant and thus can be applied by whoever
feels responsible for it. They are only grouped here because they used
to be one patch and are about the same objective.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (3):
  drm/bridge: Use named initializers for arrays of i2c_device_data
  drm/sitronix/st7571-i2c: Drop unused assignment of i2c_device_id
    driver data
  drm/nouveau: Use named initializers for i2c_device_id arrays

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c           | 10 +++++-----
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c     |  2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c              |  4 ++--
 drivers/gpu/drm/bridge/chipone-icn6211.c               |  4 ++--
 drivers/gpu/drm/bridge/chrontel-ch7033.c               |  2 +-
 drivers/gpu/drm/bridge/ite-it6263.c                    |  2 +-
 drivers/gpu/drm/bridge/ite-it6505.c                    |  2 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c              |  2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c               |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9211.c                |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9611.c                |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c             |  2 +-
 .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  8 ++++----
 drivers/gpu/drm/bridge/nxp-ptn3460.c                   |  4 ++--
 drivers/gpu/drm/bridge/parade-ps8622.c                 |  8 ++++----
 drivers/gpu/drm/bridge/sii902x.c                       |  2 +-
 drivers/gpu/drm/bridge/sii9234.c                       |  2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c                   |  2 +-
 drivers/gpu/drm/bridge/tc358767.c                      |  2 +-
 drivers/gpu/drm/bridge/tc358768.c                      |  4 ++--
 drivers/gpu/drm/bridge/tc358775.c                      |  4 ++--
 drivers/gpu/drm/bridge/tda998x_drv.c                   |  2 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c                   |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                  |  6 +++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                  |  4 ++--
 drivers/gpu/drm/bridge/ti-tfp410.c                     |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c      |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c      |  2 +-
 drivers/gpu/drm/sitronix/st7571-i2c.c                  |  4 ++--
 29 files changed, 51 insertions(+), 51 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0.11.g153666a7d9bb

