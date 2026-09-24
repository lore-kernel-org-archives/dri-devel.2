Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611A8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A028710F713;
	Thu, 24 Sep 2026 18:42:22 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FD810F713
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:42:21 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x9oOf-000000007Qp-00dt;
 Thu, 24 Sep 2026 18:42:17 +0000
Date: Thu, 24 Sep 2026 19:42:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v7 12/14] drm/bridge: it6505: don't write an error code back
 to the reset register
Message-ID: <a3afdcde0adbe1d9278485c4dd3ebcfe87f8cb07.1790275151.git.daniel@makrotopia.org>
References: <cover.1790275151.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790275151.git.daniel@makrotopia.org>
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

it6505_audio_input() saves REG_RESET_CTRL, pulses AUDIO_RESET and
writes the saved value back. it6505_read() returns a negative errno on
i2c failure, which regmap truncates to eight bits on the way out:
-EIO turns into 0xfb, holding video, audio, AUX and HDCP in reset. A
failed REG_AUDIO_INPUT_FREQ read is just as wrong, as any negative
value passes the != 0xFF test and reports an audio clock that was
never sampled. Bail out before touching the register and only report
audio input for a usable readback.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: no changes

v6: new patch
---
 drivers/gpu/drm/bridge/ite-it6505.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index d6ba28d1c963..36bb4e905ef8 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1516,12 +1516,15 @@ static bool it6505_audio_input(struct it6505 *it6505)
 	int reg05, regbe;
 
 	reg05 = it6505_read(it6505, REG_RESET_CTRL);
+	if (reg05 < 0)
+		return false;
+
 	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
 	usleep_range(3000, 4000);
 	regbe = it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
 	it6505_write(it6505, REG_RESET_CTRL, reg05);
 
-	return regbe != 0xFF;
+	return regbe > 0 && regbe != 0xFF;
 }
 
 static void it6505_setup_audio_channel_status(struct it6505 *it6505)
-- 
2.55.0
