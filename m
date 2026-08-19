Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1B0C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC8A10E803;
	Wed, 19 Aug 2026 15:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VGTzJd4j";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D386310E56C
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:28:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so7853395e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787153288; x=1787758088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4O6b3uVfHCg73+g5tRn+qNdLjjRqVvCx0BGFx/lfSs4=;
 b=VGTzJd4jDLMI/zOL+/Hx5anps50lTOMHILTe54ZWjiisAjmfSbYurSLLU/anEi0DJm
 jD9Xv4lLv9bnYBZP56h5VY+EVp8tknXv6fWZvJ5sKOrP7IBNwoWt844DtfMuYE7iWpJI
 ZwXgCVKy0vY1dbO0JIe4vaYF1seDlCljPXyLvwmFGpgiNlMzH4HnToGwe5heyT8SR/en
 qFONiDBpe8mpFbU1IlZzL82jGksRxmeuIsy0DG5YBVeKvFZkFOkxWSVFq7ev2O9e7DLJ
 zE2TSQRy38v8opX+ed2K+HapN2ZiVyegCYZG457RRmvsc0USUEDhXkHGBlyhZdPWca2c
 JZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787153288; x=1787758088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4O6b3uVfHCg73+g5tRn+qNdLjjRqVvCx0BGFx/lfSs4=;
 b=WmrM8KsgXosjSHPvoMM3aYgjSkjj3zvdJSZga4cUb4MKPV2ti5sDC8v1DVpq6mldUu
 qwjtMrw8TDTwm2hODCk9zd/7kZh2sE4ENwFz1p8Pllp/lt6f3znoQbX3GQUhxs22M/Kx
 uCV0Sq/XtoZawSAwjh/F3i35xSOZWY7aYTU4nw4ju0L2ZH1IwKg6nXX0ZZdFwjXFy7nR
 S+kwBOBigA5q6C+VHzVV7QcivwKYLVmJ2rbZHzLjfp8MfbV5t96Y08n5vHXLmeXUb8sF
 74m+hTk0nOHloeClb7IG3+UQDCXf3+rpZxznjt1IA0cf9l6er6Wi6t7C3kiotzsR6n+P
 lUQQ==
X-Gm-Message-State: AOJu0YyJw00yVlU9WczDaXb6WyLri0V6iXBPRlEA7s+DhJEER+6ANzqK
 4jbbwMWYdX++7ZRnfYci0ywkA/8MwqbPLXNkCKNaXZMiDC78TxvzeEGV
X-Gm-Gg: AR+sD11uK7nYmNuzgKdwxiJnSbaXZDpn9wSoeL/hSHSmm58mC/OW8qSxyDESC1F8/3r
 bht+0ceFHjxheHkl7rSJyxxa5TbxIkIOrK5UyAlckjT/+okwo0CUfHMop2pCRO8nrdWD9fre0Si
 bY3GFH4JUgDBMdKbKTmNj6tM2tdYigAXWgajfbS/OzK0lOTs8h27t4/+rvVzUKbF8IZ/AG6u+yS
 4ncNGTxtlJhTCGMgJDjhDd9sivBMSmdvIn7rgF4LKCSETuib96ucMqfi/gJ2NWWYlIg+U8lkGjq
 acw9e6xI0gJYSFtg8k9vDBeERZPz2J/oZfXn7bu1BJhR7aZvWtnTyUih+uqnf+M68OnH34xoOFM
 Qt08TCZkGrV3Uw/tdbYXBAM4yVYlxeIJkBYpsPekITvrQmSp776JnLM9mNBjPdMiy0PkiywsFQG
 jDbon8tz/2PSCfltZNkPz/Y3/8N8qazxoolKhVucRDV/bIdbbGnYnMtvzvJ2sxT6LztNCfR9tMK
 Zy1YizkIA==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id
 5b1f17b1804b1-499aa20c7b1mr95860655e9.15.1787153287944; 
 Wed, 19 Aug 2026 08:28:07 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dff4c1sm47667655e9.3.2026.08.19.08.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:28:07 -0700 (PDT)
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH v2] drm/omap: Report HDMI hotplug events to the ASoC HDMI codec
Date: Wed, 19 Aug 2026 18:27:55 +0300
Message-Id: <20260819152755.231754-1-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The OMAP HDMI audio driver currently has no way of reporting HDMI cable
hotplug events to ASoC. As a result, user space cannot detect HDMI audio
availability through the standard jack mechanism and audio policy managers
cannot automatically route audio to or from the HDMI output.

Add an optional HPD callback to `omap_hdmi_audio_pdata` and invoke it from
the DRM HDMI bridge whenever the connector status changes. The HDMI audio
driver registers an ASoC jack and reports `SND_JACK_AVOUT` state changes in
response to these notifications.

Also fix the disconnect path by taking a runtime PM reference before
updating the CEC physical address.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/gpu/drm/omapdrm/dss/hdmi.h        |  6 +++
 drivers/gpu/drm/omapdrm/dss/hdmi4.c       | 29 ++++++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi5.c       | 36 ++++++++++++---
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c | 14 ++++++
 include/sound/omap-hdmi-audio.h           |  1 +
 sound/soc/ti/omap-hdmi.c                  | 53 +++++++++++++++++++++--
 6 files changed, 124 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi.h b/drivers/gpu/drm/omapdrm/dss/hdmi.h
index c4a4e07f0b99..a79d4590611f 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi.h
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi.h
@@ -15,6 +15,7 @@
 #include <sound/omap-hdmi-audio.h>
 #include <media/cec.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 
 #include "omapdss.h"
 #include "dss.h"
@@ -368,6 +369,8 @@ struct omap_hdmi {
 	struct drm_bridge bridge;
 
 	struct platform_device *audio_pdev;
+	struct mutex audio_lock;
+
 	void (*audio_abort_cb)(struct device *dev);
 	int wp_idlemode;
 
@@ -380,6 +383,9 @@ struct omap_hdmi {
 	bool display_enabled;
 };
 
+void hdmi_audio_hpd_notify(struct omap_hdmi *hdmi,
+			   enum drm_connector_status status);
+
 #define drm_bridge_to_hdmi(b) container_of(b, struct omap_hdmi, bridge)
 
 #endif
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..e0e077397b77 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -433,8 +433,15 @@ static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
-	if (status == connector_status_disconnected)
+	hdmi_audio_hpd_notify(hdmi, status);
+
+	if (status == connector_status_disconnected) {
+		if (hdmi_runtime_get(hdmi))
+			return;
+
 		hdmi4_cec_set_phys_addr(&hdmi->core, CEC_PHYS_ADDR_INVALID);
+		hdmi_runtime_put(hdmi);
+	}
 }
 
 static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
@@ -626,12 +633,17 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
 		.ops = &hdmi_audio_ops,
 	};
 
+	guard(mutex)(&hdmi->audio_lock);
 	hdmi->audio_pdev = platform_device_register_data(
 		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
 		&pdata, sizeof(pdata));
 
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
+	if (IS_ERR(hdmi->audio_pdev)) {
+		int err = PTR_ERR(hdmi->audio_pdev);
+
+		hdmi->audio_pdev = NULL;
+		return err;
+	}
 
 	return 0;
 }
@@ -688,8 +700,14 @@ static void hdmi4_unbind(struct device *dev, struct device *master, void *data)
 
 	dss_debugfs_remove_file(hdmi->debugfs);
 
-	if (hdmi->audio_pdev)
-		platform_device_unregister(hdmi->audio_pdev);
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		if (hdmi->audio_pdev) {
+			struct platform_device *pdev = hdmi->audio_pdev;
+
+			hdmi->audio_pdev = NULL;
+			platform_device_unregister(pdev);
+		}
+	}
 
 	hdmi4_cec_uninit(&hdmi->core);
 	hdmi_pll_uninit(&hdmi->pll);
@@ -770,6 +788,7 @@ static int hdmi4_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hdmi);
 
 	mutex_init(&hdmi->lock);
+	mutex_init(&hdmi->audio_lock);
 	spin_lock_init(&hdmi->audio_playing_lock);
 
 	r = hdmi4_probe_of(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index ab2d4eb6787f..76aedc1c9ba1 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -425,6 +425,14 @@ static void hdmi5_bridge_disable(struct drm_bridge *bridge,
 	mutex_unlock(&hdmi->lock);
 }
 
+static void hdmi5_bridge_hpd_notify(struct drm_bridge *bridge,
+				    enum drm_connector_status status)
+{
+	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
+
+	hdmi_audio_hpd_notify(hdmi, status);
+}
+
 static const struct drm_edid *hdmi5_bridge_edid_read(struct drm_bridge *bridge,
 						     struct drm_connector *connector)
 {
@@ -475,6 +483,7 @@ static const struct drm_bridge_funcs hdmi5_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_enable = hdmi5_bridge_enable,
 	.atomic_disable = hdmi5_bridge_disable,
+	.hpd_notify = hdmi5_bridge_hpd_notify,
 	.edid_read = hdmi5_bridge_edid_read,
 };
 
@@ -601,12 +610,18 @@ static int hdmi_audio_register(struct omap_hdmi *hdmi)
 		.ops = &hdmi_audio_ops,
 	};
 
-	hdmi->audio_pdev = platform_device_register_data(
-		&hdmi->pdev->dev, "omap-hdmi-audio", PLATFORM_DEVID_AUTO,
-		&pdata, sizeof(pdata));
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		hdmi->audio_pdev = platform_device_register_data(
+			&hdmi->pdev->dev, "omap-hdmi-audio",
+			PLATFORM_DEVID_AUTO, &pdata, sizeof(pdata));
 
-	if (IS_ERR(hdmi->audio_pdev))
-		return PTR_ERR(hdmi->audio_pdev);
+		if (IS_ERR(hdmi->audio_pdev)) {
+			int err = PTR_ERR(hdmi->audio_pdev);
+
+			hdmi->audio_pdev = NULL;
+			return err;
+		}
+	}
 
 	hdmi_runtime_get(hdmi);
 	hdmi->wp_idlemode =
@@ -654,8 +669,14 @@ static void hdmi5_unbind(struct device *dev, struct device *master, void *data)
 
 	dss_debugfs_remove_file(hdmi->debugfs);
 
-	if (hdmi->audio_pdev)
-		platform_device_unregister(hdmi->audio_pdev);
+	scoped_guard(mutex, &hdmi->audio_lock) {
+		if (hdmi->audio_pdev) {
+			struct platform_device *pdev = hdmi->audio_pdev;
+
+			hdmi->audio_pdev = NULL;
+			platform_device_unregister(pdev);
+		}
+	}
 
 	hdmi_pll_uninit(&hdmi->pll);
 }
@@ -735,6 +756,7 @@ static int hdmi5_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hdmi);
 
 	mutex_init(&hdmi->lock);
+	mutex_init(&hdmi->audio_lock);
 	spin_lock_init(&hdmi->audio_playing_lock);
 
 	r = hdmi5_probe_of(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
index 3ecde23ac604..e9adc5775913 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
@@ -147,3 +147,17 @@ int hdmi_compute_acr(u32 pclk, u32 sample_freq, u32 *n, u32 *cts)
 
 	return 0;
 }
+
+void hdmi_audio_hpd_notify(struct omap_hdmi *hdmi,
+			   enum drm_connector_status status)
+{
+	guard(mutex)(&hdmi->audio_lock);
+
+	if (hdmi->audio_pdev) {
+		struct device *dev = &hdmi->audio_pdev->dev;
+		struct omap_hdmi_audio_pdata *ha = dev_get_platdata(dev);
+
+		if (ha->audio_hpd)
+			ha->audio_hpd(dev, status == connector_status_connected);
+	}
+}
diff --git a/include/sound/omap-hdmi-audio.h b/include/sound/omap-hdmi-audio.h
index e5f82044a404..8dca92360ee0 100644
--- a/include/sound/omap-hdmi-audio.h
+++ b/include/sound/omap-hdmi-audio.h
@@ -34,6 +34,7 @@ struct omap_hdmi_audio_pdata {
 	phys_addr_t audio_dma_addr;
 
 	const struct omap_hdmi_audio_ops *ops;
+	void (*audio_hpd)(struct device *dev, bool connected);
 };
 
 #endif /* __OMAP_HDMI_AUDIO_H__ */
diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index e60f5b483fc5..90ce12a81246 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -17,6 +17,7 @@
 #include <sound/dmaengine_pcm.h>
 #include <uapi/sound/asound.h>
 #include <sound/asoundef.h>
+#include <sound/jack.h>
 #include <sound/omap-hdmi-audio.h>
 
 #include "sdma-pcm.h"
@@ -35,6 +36,8 @@ struct hdmi_audio_data {
 
 	struct mutex current_stream_lock;
 	struct snd_pcm_substream *current_stream;
+	struct snd_soc_jack jack;
+	atomic_t jack_state;
 };
 
 static
@@ -262,6 +265,34 @@ static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
 		ad->current_stream = NULL;
 }
 
+static void hdmi_audio_hpd(struct device *dev, bool connected)
+{
+	struct hdmi_audio_data *ad = dev_get_drvdata(dev);
+
+	if (atomic_xchg(&ad->jack_state, connected) == connected)
+		return;
+
+	snd_soc_jack_report(&ad->jack,
+			    connected ? SND_JACK_AVOUT : 0, SND_JACK_AVOUT);
+	dev_dbg(dev, "HDMI %s\n", connected ? "CONNECTED" : "DISCONNECTED");
+}
+
+static int hdmi_audio_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct hdmi_audio_data *ad = snd_soc_card_get_drvdata(rtd->card);
+	int ret;
+
+	ret = snd_soc_card_jack_new(
+		      card, "HDMI", SND_JACK_AVOUT, &ad->jack);
+	if (ret < 0) {
+		dev_err(card->dev, "Cannot create HDMI jack: %i\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup	= hdmi_dai_startup,
 	.hw_params	= hdmi_dai_hw_params,
@@ -371,28 +402,44 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->dai_link->stream_name = card->name;
 	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
 	card->dai_link->platforms->name = dev_name(ad->dssdev);
+	card->dai_link->init = hdmi_audio_dai_init;
 	card->num_links = 1;
 	card->dev = dev;
 
+	atomic_set(&ad->jack_state, -1);
+	ad->card = card;
+
+	snd_soc_card_set_drvdata(card, ad);
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
 		dev_err(dev, "snd_soc_register_card failed (%d)\n", ret);
 		return ret;
 	}
 
-	ad->card = card;
-	snd_soc_card_set_drvdata(card, ad);
-
 	dev_set_drvdata(dev, ad);
 
+	ha->audio_hpd = hdmi_audio_hpd;
+
 	return 0;
 }
 
+static void omap_hdmi_audio_remove(struct platform_device *pdev)
+{
+	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
+
+	/*
+	 * hdmi4_unbind() holds audio lock across platform_device_unregister(),
+	 * so audio_hpd() cannot run concurrently with this callback.
+	 */
+	ha->audio_hpd = NULL;
+}
+
 static struct platform_driver hdmi_audio_driver = {
 	.driver = {
 		.name = DRV_NAME,
 	},
 	.probe = omap_hdmi_audio_probe,
+	.remove = omap_hdmi_audio_remove,
 };
 
 module_platform_driver(hdmi_audio_driver);
-- 
2.25.1

