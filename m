Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D70C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155B10EBEF;
	Wed, 22 Jul 2026 01:00:37 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E3210EBED
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:00:35 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wmLK0-0000000010j-3bXW; Wed, 22 Jul 2026 01:00:28 +0000
Date: Wed, 22 Jul 2026 02:00:25 +0100
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v4 4/5] drm/bridge: it6505: Add audio support
Message-ID: <82871481f951bbba67febdf7a7445d01f0bd60f2.1784681487.git.daniel@makrotopia.org>
References: <cover.1784681487.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784681487.git.daniel@makrotopia.org>
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

Add audio support for it6505 by bridging to the hdmi-codec, registering
an "hdmi-audio-codec" platform device from probe. The it6505's audio
setup/shutdown helpers were merged earlier as unused code; wire them up
via hdmi_codec_ops so the DAI actually appears, which unblocks the
mt8186-mt6366 sound card that references it6505 as the I2S3 codec.

Some DP-to-HDMI dongles get into a bad state if InfoFrame is sent
without audio data, so it6505's audio is only enabled once the stream
is unmuted. The audio state starts out muted so the audio-FIFO-error
IRQ cannot enable audio before ALSA has configured and unmuted the
stream.

it6505_enable_audio()/it6505_disable_audio() can be called from
several contexts: the HPD-low path, the audio-FIFO-error IRQ, the
delayed audio-enable work and the .mute_stream/.audio_shutdown
hdmi_codec_ops added here. None of these are mutually exclusive, so
serialize the actual register sequences with a new audio_lock mutex.
The mute state and the stream parameters cached by .hw_params are
updated under the same lock, and the audio-FIFO-error IRQ handler (a
threaded IRQ, so it may sleep) probes the audio input and re-enables
audio in a single critical section, re-checking the mute state there
so it cannot undo a concurrent ALSA-requested mute.

On remove, unregister the audio codec platform device only once the
event sources and the other work items have been quiesced, so nothing
can call back into the freed codec device through plugged_cb, and
cancel the delayed audio work after that, when nothing is left that
could requeue it.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4:
 * start out muted (audio.mute = true) so the audio-FIFO-error IRQ
   cannot enable audio before ALSA has configured and unmuted the
   stream
 * update the mute state and the cached stream parameters under
   audio_lock, and split out __it6505_enable_audio() so the
   audio-FIFO-error IRQ handler can probe the audio input and enable
   audio in one critical section, re-checking the mute state under
   the lock; closes a race where a FIFO error racing with an ALSA
   mute could undo the mute
 * unregister the audio codec platform device only after event
   sources and work items are quiesced, closing a use-after-free of
   codec_dev; cancel delayed_audio after the codec is gone

   All of the above flagged by Sashiko AI review of v3.

v3:
 * serialise it6505_enable_audio()/it6505_disable_audio() with a new
   audio_lock mutex, resolving the "input welcome on whether a lock
   is warranted" note below
 * track requested mute state in it6505->audio.mute and have the
   audio-FIFO-error IRQ handler skip re-enabling audio while muted,
   both addressing automated review of v2

v2:
 * store the hdmi-codec platform_device and unregister it on i2c
   remove, fixing a resource leak and use-after-free on unbind
 * initialise the delayed audio work before registering the codec
   device instead of after
 * synchronously cancel the delayed audio work on audio shutdown and
   on driver remove (cancel_delayed_work_sync)
 * rework the mute path to cancel pending work synchronously and
   disable audio immediately when muting, removing a race with the
   delayed enable work

djg: respin of Jiaxin Yu's v3, rebased onto current mainline. Changes
from his v3: hdmi_codec_ops lost .trigger, so drive enable/disable from
.mute_stream; drop the now-redundant __maybe_unused; use it6505->dev
instead of &client->dev, addressing AngeloGioacchino Del Regno's v3
review. Also fix issues in v3: initialise delayed_audio before
registering the codec device; keep and unregister the platform_device
and cancel delayed_audio on remove to avoid a leak and a
use-after-free; cancel the delayed work on audio shutdown; and
actually disable audio (not just cancel the pending enable) when the
stream is muted.

 drivers/gpu/drm/bridge/ite-it6505.c | 162 +++++++++++++++++++++++-----
 1 file changed, 133 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 443ea5579744..6bb5db565cca 100644
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
+	struct mutex audio_lock; /* serializes audio enable/disable */
 	struct regmap *regmap;
 	struct drm_display_mode source_output_mode;
 	struct drm_display_mode video_info;
@@ -476,6 +478,7 @@ struct it6505 {
 	bool enable_enhanced_frame;
 	hdmi_codec_plugged_cb plugged_cb;
 	struct device *codec_dev;
+	struct platform_device *audio_pdev;
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
@@ -1594,7 +1597,7 @@ static void it6505_enable_audio_infoframe(struct it6505 *it6505)
 			EN_AUD_CTRL_PKT);
 }
 
-static void it6505_disable_audio(struct it6505 *it6505)
+static void __it6505_disable_audio(struct it6505 *it6505)
 {
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, EN_AUD_MUTE);
 	it6505_set_bits(it6505, REG_AUDIO_SRC_CTRL, M_AUDIO_I2S_EN, 0x00);
@@ -1602,13 +1605,21 @@ static void it6505_disable_audio(struct it6505 *it6505)
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
@@ -1629,6 +1640,14 @@ static void it6505_enable_audio(struct it6505 *it6505)
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_AUD_MUTE, 0x00);
 }
 
+static void it6505_enable_audio(struct it6505 *it6505)
+{
+	mutex_lock(&it6505->audio_lock);
+	if (!it6505->audio.mute)
+		__it6505_enable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
+}
+
 static bool it6505_use_step_train_check(struct it6505 *it6505)
 {
 	if (it6505->link.revision >= 0x12)
@@ -2323,19 +2342,12 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 
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
@@ -2627,8 +2639,10 @@ static void it6505_irq_audio_fifo_error(struct it6505 *it6505)
 
 	DRM_DEV_DEBUG_DRIVER(dev, "audio fifo error Interrupt");
 
-	if (it6505_audio_input(it6505))
-		it6505_enable_audio(it6505);
+	mutex_lock(&it6505->audio_lock);
+	if (!it6505->audio.mute && it6505_audio_input(it6505))
+		__it6505_enable_audio(it6505);
+	mutex_unlock(&it6505->audio_lock);
 }
 
 static void it6505_irq_link_train_fail(struct it6505 *it6505)
@@ -2964,7 +2978,7 @@ static void it6505_remove_notifier_module(struct it6505 *it6505)
 	flush_work(&it6505->extcon_wq);
 }
 
-static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
+static void it6505_delayed_audio(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     delayed_audio.work);
@@ -2978,11 +2992,12 @@ static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
 		it6505_enable_audio(it6505);
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
@@ -2998,8 +3013,6 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
 		return -EINVAL;
 	}
 
-	it6505->audio.channel_count = params->cea.channels;
-
 	while (i < ARRAY_SIZE(audio_sample_rate_map) &&
 	       params->sample_rate !=
 		       audio_sample_rate_map[i].sample_rate_value) {
@@ -3010,21 +3023,20 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
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
@@ -3032,21 +3044,70 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
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
 }
 
-static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
-						       void *data,
-						       hdmi_codec_plugged_cb fn,
-						       struct device *codec_dev)
+static int it6505_audio_mute(struct device *dev, void *data,
+			     bool enable, int direction)
+{
+	struct it6505 *it6505 = dev_get_drvdata(dev);
+
+	DRM_DEV_DEBUG_DRIVER(dev, "mute: %d", enable);
+
+	/*
+	 * Some DP-to-HDMI dongles get into a bad state if the InfoFrame is
+	 * sent without audio data, so only enable it6505's audio once the
+	 * stream is unmuted (i.e. actually playing).
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
+}
+
+static int it6505_audio_hook_plugged_cb(struct device *dev,
+					void *data,
+					hdmi_codec_plugged_cb fn,
+					struct device *codec_dev)
 {
 	struct it6505 *it6505 = data;
 
@@ -3057,6 +3118,40 @@ static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
 	return 0;
 }
 
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
+
+	return 0;
+}
+
 static inline struct it6505 *bridge_to_it6505(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct it6505, bridge);
@@ -3566,6 +3661,7 @@ static int it6505_i2c_probe(struct i2c_client *client)
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
+	mutex_init(&it6505->audio_lock);
 
 	it6505->bridge.of_node = client->dev.of_node;
 	it6505->connector_status = connector_status_disconnected;
@@ -3616,6 +3712,12 @@ static int it6505_i2c_probe(struct i2c_client *client)
 		return err;
 	}
 
+	err = it6505_register_audio_driver(dev);
+	if (err < 0) {
+		dev_err(dev, "Failed to register audio driver: %d", err);
+		return err;
+	}
+
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
 	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
@@ -3658,6 +3760,8 @@ static void it6505_i2c_remove(struct i2c_client *client)
 	cancel_work_sync(&it6505->hdcp_wait_ksv_list);
 	cancel_delayed_work_sync(&it6505->hdcp_work);
 	cancel_work_sync(&it6505->extcon_wq);
+	platform_device_unregister(it6505->audio_pdev);
+	cancel_delayed_work_sync(&it6505->delayed_audio);
 	pm_runtime_disable(&client->dev);
 	it6505_poweroff(it6505);
 	it6505_remove_edid(it6505);
-- 
2.55.0
