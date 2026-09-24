Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2EEC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BAC10F70F;
	Thu, 24 Sep 2026 18:42:36 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A429710F70F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:42:35 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1x9oOt-000000007Rr-1QdG;
 Thu, 24 Sep 2026 18:42:31 +0000
Date: Thu, 24 Sep 2026 19:42:28 +0100
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
Subject: [PATCH v7 13/14] drm/bridge: it6505: Add audio support
Message-ID: <9467f1fde989ec3914344c129a039fe7b7ed91e1.1790275151.git.daniel@makrotopia.org>
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

From: Jiaxin Yu <jiaxin.yu@mediatek.com>

Add audio support for it6505 by bridging to the hdmi-codec: register
an "hdmi-audio-codec" platform device from probe and wire up the
previously unused audio helpers via hdmi_codec_ops. This unblocks the
mt8186-mt6366 sound card which references it6505 as the I2S3 codec.

Audio starts out muted and is only enabled once the stream is
unmuted, since some DP-to-HDMI dongles get into a bad state if the
InfoFrame is sent without audio data. Enable/disable can race between
the FIFO-error IRQ, the delayed enable work, the hdmi-codec ops and
the HPD-low path, so the register sequences, the mute state and the
cached stream parameters are serialised with a new audio_lock mutex.
it6505_poweroff() clears it6505->powered under the same lock: the
codec ops and the delayed work check the flag before writing
registers, and the mute and shutdown ops run from ALSA, where a work
cancel cannot reach them. plugged_cb/codec_dev updates take
mode_lock, the lock it6505_detect() holds when calling back into the
codec.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v7: it6505_poweroff() clears the powered flag under audio_lock so the
    codec ops and the delayed enable work cannot write to a chip
    being powered off; fold the it6505_enable_audio() wrapper into
    it6505_delayed_audio()

v6: no changes

v5: update plugged_cb/codec_dev under mode_lock

v4:
 * start out muted
 * update mute state and cached parameters under audio_lock; the
   FIFO-error IRQ probes and enables audio in one locked section
 * unregister the codec device only after quiesce on remove

v3: serialise enable/disable with audio_lock; track mute state so
    the FIFO-error IRQ cannot undo a mute

v2 (respin of Jiaxin Yu's v3 on current -next):
 * drive enable/disable from .mute_stream (hdmi_codec_ops lost
   .trigger), use it6505->dev
 * keep and unregister the codec platform_device on remove, cancel
   delayed_audio on shutdown and remove, disable audio when muting

---
 drivers/gpu/drm/bridge/ite-it6505.c | 166 ++++++++++++++++++++++------
 1 file changed, 134 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 36bb4e905ef8..00eaac183130 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -407,6 +407,7 @@ struct it6505_audio_data {
 	u8 i2s_data_delay;
 	u8 i2s_ws_channel;
 	u8 i2s_data_sequence;
+	bool mute;
 };
 
 struct it6505_audio_sample_rate_map {
@@ -439,6 +440,7 @@ struct it6505 {
 	struct mutex extcon_lock;
 	struct mutex mode_lock; /* used to bridge_detect */
 	struct mutex aux_lock; /* used to aux data transfers */
+	struct mutex audio_lock; /* serializes audio enable/disable with poweroff */
 	struct regmap *regmap;
 	struct drm_display_mode source_output_mode;
 	struct drm_display_mode video_info;
@@ -477,6 +479,7 @@ struct it6505 {
 	bool enable_enhanced_frame;
 	hdmi_codec_plugged_cb plugged_cb;
 	struct device *codec_dev;
+	struct platform_device *audio_pdev;
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
@@ -1599,7 +1602,7 @@ static void it6505_enable_audio_infoframe(struct it6505 *it6505)
 			EN_AUD_CTRL_PKT);
 }
 
-static void it6505_disable_audio(struct it6505 *it6505)
+static void __it6505_disable_audio(struct it6505 *it6505)
 {
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, EN_AUD_MUTE);
 	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, M_AUDIO_I2S_EN, 0x00);
@@ -1607,13 +1610,21 @@ static void it6505_disable_audio(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_RESET_CTRL, AUDIO_RESET, AUDIO_RESET);
 }
 
-static void it6505_enable_audio(struct it6505 *it6505)
+static void it6505_disable_audio(struct it6505 *it6505)
+{
+	mutex_lock(&it6505->audio_lock);
+	__it6505_disable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
+}
+
+static void __it6505_enable_audio(struct it6505 *it6505)
 {
 	struct device *dev = it6505->dev;
 	int regbe;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "start");
-	it6505_disable_audio(it6505);
+
+	__it6505_disable_audio(it6505);
 
 	it6505_setup_audio_channel_status(it6505);
 	it6505_setup_audio_format(it6505);
@@ -2331,19 +2342,12 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 
 static void it6505_link_train_ok(struct it6505 *it6505)
 {
-	struct device *dev = it6505->dev;
-
 	it6505->link_state = LINK_OK;
 	/* disalbe mute enable avi info frame */
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, 0x00);
 	it6505_set_bits(it6505, REG_INFOFRAME_CTRL,
 			EN_VID_CTRL_PKT, EN_VID_CTRL_PKT);
 
-	if (it6505_audio_input(it6505)) {
-		DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
-		it6505_enable_audio(it6505);
-	}
-
 	if (it6505->hdcp_desired)
 		it6505_start_hdcp(it6505);
 }
@@ -2635,8 +2639,10 @@ static void it6505_irq_audio_fifo_error(struct it6505 *it6505)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "audio fifo error Interrupt");
 
-	if (it6505_audio_input(it6505))
-		it6505_enable_audio(it6505);
+	mutex_lock(&it6505->audio_lock);
+	if (!it6505->audio.mute && it6505_audio_input(it6505))
+		__it6505_enable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
 }
 
 static void it6505_irq_link_train_fail(struct it6505 *it6505)
@@ -2823,6 +2829,8 @@ static int it6505_poweroff(struct it6505 *it6505)
 	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
 	cancel_delayed_work_sync(&it6505->hdcp_work);
 
+	mutex_lock(&it6505->audio_lock);
+
 	if (pdata->gpiod_reset)
 		gpiod_set_value_cansleep(pdata->gpiod_reset, 1);
 
@@ -2842,6 +2850,7 @@ static int it6505_poweroff(struct it6505 *it6505)
 
 	it6505->powered = false;
 	it6505->sink_count = 0;
+	mutex_unlock(&it6505->audio_lock);
 
 	return 0;
 }
@@ -2988,25 +2997,28 @@ static void it6505_remove_notifier_module(struct it6505 *it6505)
 	flush_work(&it6505->extcon_wq);
 }
 
-static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
+static void it6505_delayed_audio(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     delayed_audio.work);
 
 	DRM_DEV_DEBUG_DRIVER(it6505->dev, "start");
 
-	if (!it6505->powered)
+	if (it6505->enable_drv_hold)
 		return;
 
-	if (!it6505->enable_drv_hold)
-		it6505_enable_audio(it6505);
+	mutex_lock(&it6505->audio_lock);
+	if (it6505->powered && !it6505->audio.mute)
+		__it6505_enable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
 }
 
-static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
-						       struct hdmi_codec_params
-						       *params)
+static int it6505_audio_setup_hw_params(struct it6505 *it6505,
+					struct hdmi_codec_params
+					*params)
 {
 	struct device *dev = it6505->dev;
+	u8 word_length;
 	int i = 0;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "%s %d Hz, %d bit, %d channels\n", __func__,
@@ -3022,8 +3034,6 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
 		return -EINVAL;
 	}
 
-	it6505->audio.channel_count = params->cea.channels;
-
 	while (i < ARRAY_SIZE(audio_sample_rate_map) &&
 	       params->sample_rate !=
 		       audio_sample_rate_map[i].sample_rate_value) {
@@ -3034,21 +3044,20 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
 				     params->sample_rate);
 		return -EINVAL;
 	}
-	it6505->audio.sample_rate = audio_sample_rate_map[i].rate;
 
 	switch (params->sample_width) {
 	case 16:
-		it6505->audio.word_length = WORD_LENGTH_16BIT;
+		word_length = WORD_LENGTH_16BIT;
 		break;
 	case 18:
-		it6505->audio.word_length = WORD_LENGTH_18BIT;
+		word_length = WORD_LENGTH_18BIT;
 		break;
 	case 20:
-		it6505->audio.word_length = WORD_LENGTH_20BIT;
+		word_length = WORD_LENGTH_20BIT;
 		break;
 	case 24:
 	case 32:
-		it6505->audio.word_length = WORD_LENGTH_24BIT;
+		word_length = WORD_LENGTH_24BIT;
 		break;
 	default:
 		DRM_DEV_DEBUG_DRIVER(dev, "wordlength: %d bit not support",
@@ -3056,27 +3065,111 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
 		return -EINVAL;
 	}
 
+	mutex_lock(&it6505->audio_lock);
+	it6505->audio.channel_count = params->cea.channels;
+	it6505->audio.sample_rate = audio_sample_rate_map[i].rate;
+	it6505->audio.word_length = word_length;
+	mutex_unlock(&it6505->audio_lock);
+
 	return 0;
 }
 
-static void __maybe_unused it6505_audio_shutdown(struct device *dev, void *data)
+static void it6505_audio_shutdown(struct device *dev, void *data)
 {
 	struct it6505 *it6505 = dev_get_drvdata(dev);
 
+	mutex_lock(&it6505->audio_lock);
+	it6505->audio.mute = true;
 	if (it6505->powered)
-		it6505_disable_audio(it6505);
+		__it6505_disable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
+	cancel_delayed_work_sync(&it6505->delayed_audio);
+}
+
+static int it6505_audio_hw_params(struct device *dev, void *data,
+				  struct hdmi_codec_daifmt *daifmt,
+				  struct hdmi_codec_params *params)
+{
+	struct it6505 *it6505 = dev_get_drvdata(dev);
+
+	return it6505_audio_setup_hw_params(it6505, params);
+}
+
+static int it6505_audio_mute(struct device *dev, void *data,
+			     bool enable, int direction)
+{
+	struct it6505 *it6505 = dev_get_drvdata(dev);
+
+	DRM_DEV_DEBUG_DRIVER(dev, "mute: %d", enable);
+
+	/*
+	 * Delay enabling audio until the stream is unmuted; InfoFrames
+	 * without audio data upset some DP-to-HDMI dongles.
+	 */
+	if (enable) {
+		mutex_lock(&it6505->audio_lock);
+		it6505->audio.mute = true;
+		if (it6505->powered)
+			__it6505_disable_audio(it6505);
+		mutex_unlock(&it6505->audio_lock);
+		cancel_delayed_work_sync(&it6505->delayed_audio);
+	} else {
+		mutex_lock(&it6505->audio_lock);
+		it6505->audio.mute = false;
+		mutex_unlock(&it6505->audio_lock);
+		queue_delayed_work(system_wq, &it6505->delayed_audio,
+				   msecs_to_jiffies(180));
+	}
+
+	return 0;
 }
 
-static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
-						       void *data,
-						       hdmi_codec_plugged_cb fn,
-						       struct device *codec_dev)
+static int it6505_audio_hook_plugged_cb(struct device *dev,
+					void *data,
+					hdmi_codec_plugged_cb fn,
+					struct device *codec_dev)
 {
 	struct it6505 *it6505 = data;
 
+	mutex_lock(&it6505->mode_lock);
 	it6505->plugged_cb = fn;
 	it6505->codec_dev = codec_dev;
 	it6505_plugged_status_to_codec(it6505);
+	mutex_unlock(&it6505->mode_lock);
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops it6505_audio_codec_ops = {
+	.hw_params = it6505_audio_hw_params,
+	.mute_stream = it6505_audio_mute,
+	.audio_shutdown = it6505_audio_shutdown,
+	.hook_plugged_cb = it6505_audio_hook_plugged_cb,
+};
+
+static int it6505_register_audio_driver(struct device *dev)
+{
+	struct it6505 *it6505 = dev_get_drvdata(dev);
+	struct hdmi_codec_pdata codec_data = {
+		.ops = &it6505_audio_codec_ops,
+		.max_i2s_channels = 8,
+		.i2s = 1,
+		.no_capture_mute = 1,
+		.data = it6505,
+	};
+	struct platform_device *pdev;
+
+	it6505->audio.mute = true;
+	INIT_DELAYED_WORK(&it6505->delayed_audio, it6505_delayed_audio);
+
+	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
+					     PLATFORM_DEVID_AUTO, &codec_data,
+					     sizeof(codec_data));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	it6505->audio_pdev = pdev;
+	DRM_DEV_DEBUG_DRIVER(dev, "bound to %s", HDMI_CODEC_DRV_NAME);
 
 	return 0;
 }
@@ -3592,6 +3685,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
+	mutex_init(&it6505->audio_lock);
 
 	it6505->bridge.of_node = client->dev.of_node;
 	it6505->connector_status = connector_status_disconnected;
@@ -3640,6 +3734,12 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	err = it6505_register_audio_driver(dev);
+	if (err < 0) {
+		dev_err(dev, "Failed to register audio driver: %d", err);
+		return err;
+	}
+
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
 	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
@@ -3681,6 +3781,8 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
 	cancel_delayed_work_sync(&it6505->hdcp_work);
 	cancel_work_sync(&it6505->extcon_wq);
+	platform_device_unregister(it6505->audio_pdev);
+	cancel_delayed_work_sync(&it6505->delayed_audio);
 	if (it6505->extcon_state)
 		pm_runtime_put_sync(&client->dev);
 	pm_runtime_disable(&client->dev);
-- 
2.55.0
