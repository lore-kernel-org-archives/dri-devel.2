Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D51C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 23:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B950410E6F9;
	Sun, 27 Sep 2026 23:50:42 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE3E10E6F9
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 23:50:41 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xAydh-000000000qB-0nqN;
 Sun, 27 Sep 2026 23:50:37 +0000
Date: Mon, 28 Sep 2026 00:50:33 +0100
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
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v8 08/14] drm/bridge: it6505: avoid division by zero in audio
 FS debug print
Message-ID: <26ee2c94c42fb09c081201071cb5730c96c8c25b.1790552614.git.daniel@makrotopia.org>
References: <cover.1790552614.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790552614.git.daniel@makrotopia.org>
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

REG_AUDIO_INPUT_FREQ reads back 0 when no audio clock has been
latched, and it6505_read() returns a negative errno on i2c failure.
The debug print divides by the readback, and its arguments are
evaluated even with debug output disabled. Only print when the value
is usable as a divisor.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v8: no changes

v7: no changes

v6: no changes

v5: new patch
---
 drivers/gpu/drm/bridge/ite-it6505.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index cf2cd59625d57..0d21014324167 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1623,8 +1623,11 @@ static void it6505_enable_audio(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, AUDIO_FIFO_RESET, 0x00);
 	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, 0x00);
 	regbe = it6505_read(it6505, REG_AUDIO_INPUT_FREQ);
-	DRM_DEV_DEBUG_DRIVER(dev, "regbe:0x%02x audio input fs: %d.%d kHz",
-			     regbe, 6750 / regbe, (6750 % regbe) * 10 / regbe);
+	if (regbe > 0)
+		DRM_DEV_DEBUG_DRIVER(dev,
+				     "regbe:0x%02x audio input fs: %d.%d kHz",
+				     regbe, 6750 / regbe,
+				     (6750 % regbe) * 10 / regbe);
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
 }
 
-- 
2.55.0
