Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4929DC5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BF810E395;
	Sun, 23 Aug 2026 09:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G86sRTaq";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E33C10E0D0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 14:32:28 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so226030166b.0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787409146; x=1788013946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5m/bovsJ2cKRYH/evjqdCUTYp41mLIq3pohE3pwpIfM=;
 b=G86sRTaqG4ZUDPrSJAylvh6uYkp9v4lIv/8ge7beZ2TvbvbVDegKMZ6AO9N/gRlhHf
 IPiksqo3fu8Gb+kRgo7kksuODS7q+c0wH7XXOvlnfOG2RJe7VtCntjPfg1zp+13iXoED
 xRUn+h4lZJBjnyJNrAbukjsEfLBFJnjv0RDU1nIFPGCe4I6aTurTwhY927XF92N7kGyJ
 zR6y7MLHPmXTbMMtdtWQexWm6u+4zrn6AcqA3+qp2iK6ns8IPrP5eNuZ0lGt9RvXC0i3
 PTqbYlNP6WxMuFde/a7OgTK7AEhC+Zgp90Lo6CT+nScHLi40kj6chUO5H17roT8TGqFo
 q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787409146; x=1788013946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5m/bovsJ2cKRYH/evjqdCUTYp41mLIq3pohE3pwpIfM=;
 b=AC+D32+HsExwDtwR0n6s55pLbD/jusNQPPGxXDWKos1TzC+pptXkUMyMGWEJ+7OKeW
 mI/2uIu0GyojFt3LFEw8PFlUVxXHbQhrNGnh0hdFjPLuxj3jI4W18jdfu4H94+21eU4N
 G0U/8Y0bzmY08Zq/Hp7OqqUTmkNkrhPPWzjr3sYIBcD80M15JwFJzkn7TBoX6R5mtjVH
 hSNtFL9XplOx+Fxt+SAghcAG73Np5zebbPozQEXEWRTGnSVgdGuvbfBzB20j+33U37or
 PA3ErPh+1MSFIenKAWUWLR0dAF7XMFH0RpoxMuixXzLVvJRBRKyZPXfZ+MHnWjL1ePEJ
 n+UQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIQFacVQfmoVZNSPo5YaQRmhplzXkk+aCZw0Ts0ZR3d1+VSv9MNOKp0oFfGkY7pzwWSWwTpJXPRmE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m176khnBFKVtDsUXxerEWlUiYUPUt8v0Yu9O4WeOjkbcqMgcCe
 UZWVAwoedvML0T4Hm6u1d2lOhv3e97jw6KKsY0ujaLfZT/+HG8oEzJTf
X-Gm-Gg: AR+sD11vNMZZ+bMsATM53OiJKiMflpnDWYrRlzM9+y3KfWxLGteDdiUva0S7YZyzG6f
 2wI778qx1Q8CCMORsLko7BBot0bVgayJ30DRyc6sonqbO/ycjvc2ZqAHVnjtSgmRSPzVprdjsJR
 FmNfra+fn+GxUOPp/bvWSZ6j1EtlA4GUO5uXBQe/cHi8b9FfnOhSusBEyWvXV08MQIpeRBErgde
 /TVK9QMSk5KtwUUeAF+odoD761c3+h/dw+SjS4Ix5i2dOeZzB6UwFjsJuAI8A/qguAkqxghullt
 gZ31WwL5Pq/bQpghbFdI/1vnLoNXphK51dpS5h3nlTvOlthpXMbuqYpEytga+f+DdcjogI8doFT
 kgrBON8jQSjk2Pnsb3IJt42QPnnqLCGSY/isnMNONynmTb6SKdInYp709oLyruJNkwk74qnlLz5
 wqWWJP7QV7aUL7D85BEiENDUMYPRytWv7AMWzgEKf8a/3rWeT60aiBle1i2ltJ/rNBXmZxp7e5o
 KwN6SeHKshpO/YRldGDTzytiwb333PyFlz+PYU68mdS7px14oQ3+FoOmXMyJDuXF3f/S3Z8a739
 EzPY9QqzXBY5EIuUWj2DJoSgtx+ZgkDROh1OliO0OBUrPlPa7qojzqjnYMjLUXARMJNhEbkweYA
 RmtBA
X-Received: by 2002:a17:907:d12:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c246a6b0994mr1614247666b.24.1787409146368; 
 Sat, 22 Aug 2026 07:32:26 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de.
 [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm317362066b.56.2026.08.22.07.32.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 22 Aug 2026 07:32:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Sat, 22 Aug 2026 16:32:18 +0200
Message-Id: <20260822143218.68764-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

vc4_hdmi, including the embedded ASoC card, is DRM-managed and freed
together with the DRM device when the aggregate device is torn down.
The card however is registered device-managed on the HDMI platform
device, whose release runs later, so snd_soc_unregister_card() operates
on freed memory:

  # modprobe vc4; rmmod vc4
  BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
  Read of size 1 at addr ffff0000456a8450 by task rmmod/262
  Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
  Freed by task 262 (rmmod): drm_managed_release / drm_dev_put

Register the card without devm and unregister it from a component
unbind callback, where the HDMI device resources and the DRM-managed
structure are both still alive.

Fixes: b4f2c70c1a7a ("drm/vc4: hdmi: Switch to drmm_kzalloc")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on a Raspberry Pi 400 (BCM2711), v7.2-11658-g26260251022f, with
KASAN: report gone, rmmod/insmod loop clean.

 drivers/gpu/drm/vc4/vc4_hdmi.c | 46 ++++++++++++++++------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
 2 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..ce28075f77b6 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2349,28 +2349,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	vc4_hdmi->audio.dma_data.maxburst = 2;
 
 	/*
-	 * NOTE: Strictly speaking, we should probably use a DRM-managed
-	 * registration there to avoid removing all the audio components
-	 * by the time the driver doesn't have any user anymore.
-	 *
-	 * However, the ASoC core uses a number of devm_kzalloc calls
-	 * when registering, even when using non-device-managed
-	 * functions (such as in snd_soc_register_component()).
-	 *
-	 * If we call snd_soc_unregister_component() in a DRM-managed
-	 * action, the device-managed actions have already been executed
-	 * and thus we would access memory that has been freed.
-	 *
-	 * Using device-managed hooks here probably leaves us open to a
-	 * bunch of issues if userspace still has a handle on the ALSA
-	 * device when the device is removed. However, this is mitigated
-	 * by the use of drm_dev_enter()/drm_dev_exit() in the audio
-	 * path to prevent the access to the device resources if it
-	 * isn't there anymore.
-	 *
-	 * Then, the vc4_hdmi structure is DRM-managed and thus only
-	 * freed whenever the last user has closed the DRM device file.
-	 * It should thus outlive ALSA in most situations.
+	 * The card is unregistered from the component unbind callback:
+	 * a DRM-managed action can run after the device-managed ASoC
+	 * resources are gone, and the device-managed release runs after
+	 * the DRM-managed vc4_hdmi structure holding the card has been
+	 * freed. Only at unbind time are both still alive.
 	 */
 	ret = devm_snd_dmaengine_pcm_register(dev, &pcm_conf, 0);
 	if (ret) {
@@ -2422,12 +2405,13 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	 * snd_soc_card_get_drvdata() if needed.
 	 */
 	snd_soc_card_set_drvdata(card, vc4_hdmi);
-	ret = devm_snd_soc_register_card(dev, card);
+	ret = snd_soc_register_card(card);
 	if (ret)
-		dev_err_probe(dev, ret, "Could not register sound card\n");
+		return dev_err_probe(dev, ret, "Could not register sound card\n");
 
-	return ret;
+	vc4_hdmi->audio.card_registered = true;
 
+	return 0;
 }
 
 static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
@@ -3345,8 +3329,20 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	return ret;
 }
 
+static void vc4_hdmi_unbind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+
+	if (vc4_hdmi->audio.card_registered) {
+		snd_soc_unregister_card(&vc4_hdmi->audio.card);
+		vc4_hdmi->audio.card_registered = false;
+	}
+}
+
 static const struct component_ops vc4_hdmi_ops = {
 	.bind   = vc4_hdmi_bind,
+	.unbind = vc4_hdmi_unbind,
 };
 
 static int vc4_hdmi_dev_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 29d461d4ee49..444c73513d86 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -106,6 +106,7 @@ struct vc4_hdmi_audio {
 	struct snd_soc_dai_link_component platform;
 	struct snd_dmaengine_dai_dma_data dma_data;
 	bool streaming;
+	bool card_registered;
 };
 
 /* General HDMI hardware state. */
-- 
2.39.5 (Apple Git-154)

