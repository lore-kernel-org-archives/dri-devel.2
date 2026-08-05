Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AEFC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7139710EEE6;
	Wed,  5 Aug 2026 15:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sq2oFFFj";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CF410EED6
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:21:33 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so775479f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943292; x=1786548092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1tHs/lOwiC51EDTGm3DKHRbCU7WZ3b5D/5yvhxX37k4=;
 b=sq2oFFFjYFUj+hXnVx2mlR1ckGgvalvMj4Ep+NPcxYBvrpL9glO5FNXFN0f2586Qqp
 ngJEmY52G56Fj2WpOoUFoblcsVcg2cQ3h8nIToIkRRdUmRUUJZnrBwuHj/6bPfDONvij
 HqCnff6MTJQq5MO1TTDdI0rwtlYjTecx6Ikag64zA86iYxiCI1BJ8tIwK57z1DRbMRvh
 EdVHWJq/r0kW7+wEB9+PM6jtih9UfnauhJd4UC3D51sstgSfBK2bm2/PcbVxpXmbNhdE
 YcCIcK+o6D8cm7BQ3s7j1m0/1bDc1pqhnrBBaMmPECiBXv4LFmkfHt7CeS3p5NQQiLkR
 C2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943292; x=1786548092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1tHs/lOwiC51EDTGm3DKHRbCU7WZ3b5D/5yvhxX37k4=;
 b=DgymFzR6TJtQcWtrBpvqObWeyGTdmJ41hsaxzgpaEMFnJoTbop3U7S8YBl10o7AZRZ
 tfYaKj/oXJswNxb54q2aMexD1aVKiylXVW6BgkgcexoI9zCHN5IwHaJ3Gq9tPuZkgLq5
 kOvr6XlYp3myu9KfdgK5rVyLLW/UxP5Y1bDoa+cM5eFBAunT8hno04ZzCpdzZx9ypVKJ
 7KlIE/6OVyIV8RAKUGLJMeUJGcf4r73cXm4a4zIyqXwnEMYj6SF0ERv2nWouYGvJNQiT
 +5kmG75y8KjnCuqW9ixb/9+TVQMz78JcPDXEmrRsxCL/Jd/z0C8VVmasK157Gisjx/fv
 6+OA==
X-Gm-Message-State: AOJu0Yx6+89XigAo/tLeBu9ZLUNH7ACVrV7dR79nOEfGf4MxgLwvBcL/
 IqSe18pu2cEozr0LZER2zhBHVhu2HsWEBxCRt3mgHfYVCPOYfnSDVz6v
X-Gm-Gg: AR+sD11q3TS4tTSp0MVvv9DjT8AOarS/ExsmglIslADXEkMMNfo8FY9oZ7GvMmqbI7q
 FCmD6j8QhX7quAEvGCRnKK0y4ZL2M4obrM5FUSs5djgmgqedoAHap1SylkZQky3yU4CnHy6L1Ab
 2G59gC1tQGqtKNQm7/1E3w8KXtdpcgC9/qUAR0URBNHF8zwgXXW6GVOVqGsY0Zq2NbmwHhYfwOs
 SHa80GP0lZna9uu85Enl1RhoQtrjc2+7XOZHoMriGSYq+wNWqFrzeFW0MjY3CxSOa7d2Y44hsK3
 3qVlY177XK/aR/54j+1MEBcIbI+LufPhxTcR6qfJ5DlIcnZWzD/PhEUzK0+G+TPt5UqpTwwHzwa
 RrtLVJflVfO86A+6Npx7+1u+vCsrZGCBfJdSFEzsVy6jt+GTsOP03Os+Ph7J46Kx4FGpmE9D7v9
 ONeNy8iV7J5b9dOrBrHgi0psCoy4ANGEwq64G+jXvnoLdX4OWIp27sMrI8MLDmz4MADvvD4ztNa
 b1WPOfJo+uZExrbuuFM
X-Received: by 2002:a05:6000:4305:b0:47f:93b9:d071 with SMTP id
 ffacd0b85a97d-47fec62b7b2mr12850186f8f.19.1785943291837; 
 Wed, 05 Aug 2026 08:21:31 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec24a23asm9884573f8f.37.2026.08.05.08.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:21:31 -0700 (PDT)
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
Subject: [PATCH] drm/omap: Report HDMI hotplug events to the ASoC HDMI codec
Date: Wed,  5 Aug 2026 18:20:57 +0300
Message-Id: <20260805152057.1291659-1-ivo.g.dimitrov.75@gmail.com>
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
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 12 ++++++++++-
 include/sound/omap-hdmi-audio.h     |  1 +
 sound/soc/ti/omap-hdmi.c            | 33 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..b466bbdae5cc 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -432,9 +432,19 @@ static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 				    enum drm_connector_status status)
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
+	struct device *dev = &hdmi->audio_pdev->dev;
+	struct omap_hdmi_audio_pdata *ha = dev_get_platdata(dev);
+
+	if (ha->audio_hpd)
+		ha->audio_hpd(dev, status == connector_status_connected);
+
+	if (status == connector_status_disconnected) {
+		if (hdmi_runtime_get(hdmi))
+			return;
 
-	if (status == connector_status_disconnected)
 		hdmi4_cec_set_phys_addr(&hdmi->core, CEC_PHYS_ADDR_INVALID);
+		hdmi_runtime_put(hdmi);
+	}
 }
 
 static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
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
index e60f5b483fc5..333aa308979e 100644
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
@@ -262,6 +265,18 @@ static void hdmi_dai_shutdown(struct snd_pcm_substream *substream,
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
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup	= hdmi_dai_startup,
 	.hw_params	= hdmi_dai_hw_params,
@@ -380,19 +395,37 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	atomic_set(&ad->jack_state, -1);
 	ad->card = card;
 	snd_soc_card_set_drvdata(card, ad);
 
 	dev_set_drvdata(dev, ad);
 
+	ret = snd_soc_card_jack_new(
+		      card, "HDMI", SND_JACK_AVOUT, &ad->jack);
+	if (ret < 0) {
+		dev_err(dev, "Cannot create HDMI jack: %i\n", ret);
+		return ret;
+	}
+
+	ha->audio_hpd = hdmi_audio_hpd;
+
 	return 0;
 }
 
+static void omap_hdmi_audio_remove(struct platform_device *pdev)
+{
+	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
+
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
2.39.5

