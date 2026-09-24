Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA66C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BBB10F717;
	Thu, 24 Sep 2026 18:42:44 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1230C10F717
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:42:43 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x9oP0-000000007SV-3yLQ;
 Thu, 24 Sep 2026 18:42:39 +0000
Date: Thu, 24 Sep 2026 19:42:35 +0100
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
Subject: [PATCH v7 14/14] drm/bridge: it6505: Don't reject audio hw_params
 without an encoder
Message-ID: <2a125d71fcbae7dd393a3ea21f452caa63c2cfda.1790275151.git.daniel@makrotopia.org>
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

it6505_audio_setup_hw_params() returns -ENODEV when no encoder is
attached. With it6505 registering an hdmi-audio-codec this runs for
every stream on the I2S DAI, and on mt8186-corsola, where the rt1019
speaker amplifier shares I2S3, the error tears down the whole DPCM
backend and breaks speaker playback whenever no display is attached.

The function only caches stream parameters, which needs no encoder.
Drop the check, and apply the audio defaults once at probe instead of
in it6505_variable_config(), which would clobber the cached
parameters again on every hotplug. Actual audio output remains gated
by it6505->powered.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: no changes

v6: no changes

v5: no changes

v4: apply audio defaults at probe time instead of in
    it6505_variable_config()

v3: no changes

v2: drop the encoder check entirely instead of returning 0 early
---
 drivers/gpu/drm/bridge/ite-it6505.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 00eaac183130..079129925f8a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1371,16 +1371,6 @@ static void it6505_variable_config(struct it6505 *it6505)
 	it6505->link_state = LINK_IDLE;
 	it6505->hdcp_desired = HDCP_DESIRED;
 	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-	it6505->audio.select = AUDIO_SELECT;
-	it6505->audio.sample_rate = AUDIO_SAMPLE_RATE;
-	it6505->audio.channel_count = AUDIO_CHANNEL_COUNT;
-	it6505->audio.type = AUDIO_TYPE;
-	it6505->audio.i2s_input_format = I2S_INPUT_FORMAT;
-	it6505->audio.i2s_justified = I2S_JUSTIFIED;
-	it6505->audio.i2s_data_delay = I2S_DATA_DELAY;
-	it6505->audio.i2s_ws_channel = I2S_WS_CHANNEL;
-	it6505->audio.i2s_data_sequence = I2S_DATA_SEQUENCE;
-	it6505->audio.word_length = AUDIO_WORD_LENGTH;
 	memset(it6505->sha1_input, 0, sizeof(it6505->sha1_input));
 	memset(it6505->bksvs, 0, sizeof(it6505->bksvs));
 }
@@ -3025,9 +3015,6 @@ static int it6505_audio_setup_hw_params(struct it6505 *it6505,
 			     params->sample_rate, params->sample_width,
 			     params->cea.channels);
 
-	if (!it6505->bridge.encoder)
-		return -ENODEV;
-
 	if (params->cea.channels <= 1 || params->cea.channels > 8) {
 		DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
 				     params->cea.channels);
@@ -3159,6 +3146,16 @@ static int it6505_register_audio_driver(struct device *dev)
 	};
 	struct platform_device *pdev;
 
+	it6505->audio.select = AUDIO_SELECT;
+	it6505->audio.sample_rate = AUDIO_SAMPLE_RATE;
+	it6505->audio.channel_count = AUDIO_CHANNEL_COUNT;
+	it6505->audio.type = AUDIO_TYPE;
+	it6505->audio.i2s_input_format = I2S_INPUT_FORMAT;
+	it6505->audio.i2s_justified = I2S_JUSTIFIED;
+	it6505->audio.i2s_data_delay = I2S_DATA_DELAY;
+	it6505->audio.i2s_ws_channel = I2S_WS_CHANNEL;
+	it6505->audio.i2s_data_sequence = I2S_DATA_SEQUENCE;
+	it6505->audio.word_length = AUDIO_WORD_LENGTH;
 	it6505->audio.mute = true;
 	INIT_DELAYED_WORK(&it6505->delayed_audio, it6505_delayed_audio);
 
-- 
2.55.0
