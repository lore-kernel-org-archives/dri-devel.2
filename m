Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03642C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248B210E9A6;
	Mon, 20 Jul 2026 15:44:07 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17B610E9A6
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:44:05 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlq9v-000000004FQ-1J1Z; Mon, 20 Jul 2026 15:43:59 +0000
Date: Mon, 20 Jul 2026 16:43:56 +0100
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
 Hermes Wu <hermes.wu@ite.com.tw>,
 Allen Chen <allen.chen@ite.com.tw>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] drm/bridge: it6505: Add audio support
Message-ID: <47c469b0e62513997236b8c4f6779159c1998143.1784561622.git.daniel@makrotopia.org>
References: <cover.1784561622.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784561622.git.daniel@makrotopia.org>
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
is unmuted.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Link: https://lore.kernel.org/all/20230730180803.22570-4-jiaxin.yu@mediatek.com/
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
djg: respin of Jiaxin Yu's v3, rebased onto current mainline. Changes
from v3: hdmi_codec_ops lost .trigger, so drive enable/disable from
.mute_stream; drop the now-redundant __maybe_unused; use it6505->dev
instead of &client->dev, addressing AngeloGioacchino Del Regno's v3
review. Also fix issues in v3: initialise delayed_audio before
registering the codec device; keep and unregister the platform_device
and cancel delayed_audio on remove to avoid a leak and a
use-after-free; cancel the delayed work on audio shutdown; and
actually disable audio (not just cancel the pending enable) when the
stream is muted.

Note: it6505_enable_audio()/it6505_disable_audio() can still run
concurrently from the delayed work, the .mute_stream / .audio_shutdown
callbacks and the audio-FIFO-error IRQ; as in v3 these are left
unserialised -- input welcome on whether a lock is warranted.

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

 drivers/gpu/drm/bridge/ite-it6505.c | 101 +++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8ecb43611dba..d84441926e8e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -476,6 +476,7 @@ struct it6505 {
 	bool enable_enhanced_frame;
 	hdmi_codec_plugged_cb plugged_cb;
 	struct device *codec_dev;
+	struct platform_device *audio_pdev;
 	struct delayed_work delayed_audio;
 	struct it6505_audio_data audio;
 	struct dentry *debugfs;
@@ -2320,19 +2321,12 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 
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
@@ -2960,7 +2954,7 @@ static void it6505_remove_notifier_module(struct it6505 *it6505)
 	}
 }
 
-static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
+static void it6505_delayed_audio(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     delayed_audio.work);
@@ -2974,9 +2968,9 @@ static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
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
 	int i = 0;
@@ -3031,18 +3025,52 @@ static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
 	return 0;
 }
 
-static void __maybe_unused it6505_audio_shutdown(struct device *dev, void *data)
+static void it6505_audio_shutdown(struct device *dev, void *data)
 {
 	struct it6505 *it6505 = dev_get_drvdata(dev);
 
+	cancel_delayed_work_sync(&it6505->delayed_audio);
 	if (it6505->powered)
 		it6505_disable_audio(it6505);
 }
 
-static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
-						       void *data,
-						       hdmi_codec_plugged_cb fn,
-						       struct device *codec_dev)
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
+	 * Some DP-to-HDMI dongles get into a bad state if the InfoFrame is
+	 * sent without audio data, so only enable it6505's audio once the
+	 * stream is unmuted (i.e. actually playing).
+	 */
+	if (enable) {
+		cancel_delayed_work_sync(&it6505->delayed_audio);
+		if (it6505->powered)
+			it6505_disable_audio(it6505);
+	} else {
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
 
@@ -3053,6 +3081,39 @@ static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
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
@@ -3612,6 +3673,12 @@ static int it6505_i2c_probe(struct i2c_client *client)
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
@@ -3644,6 +3711,8 @@ static void it6505_i2c_remove(struct i2c_client *client)
 {
 	struct it6505 *it6505 = i2c_get_clientdata(client);
 
+	platform_device_unregister(it6505->audio_pdev);
+	cancel_delayed_work_sync(&it6505->delayed_audio);
 	drm_bridge_remove(&it6505->bridge);
 	drm_dp_aux_unregister(&it6505->aux);
 	it6505_debugfs_remove(it6505);
-- 
2.55.0
