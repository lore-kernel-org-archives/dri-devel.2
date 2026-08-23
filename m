Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F0BC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6077C10E524;
	Mon, 24 Aug 2026 07:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CcniPdY7";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941D810E064
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 17:37:48 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so4050941a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787506667; x=1788111467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WzxtLwRD92+TCzzKKRXbUxryNiIrjmzaSY4Z8wvm3PE=;
 b=CcniPdY7+bs/tmRQ+K9+Nm58IM5IC+7amXxP4GGhdfN8euJEL7Tq/8GD0DkRHj2B/e
 c9ezJM+C02qoYLVMWN3KHCfozsjZeQVqdRXgsq+UCu5cLvfNy3wZ9mYyRCgFgsGgc4uD
 SdFY7w0Wh2rVn8XEeatg0UsPeWnl3LAY5oSDVzTYe+FXpRi/BAtgGKWX970cyPnGLWuk
 oRGMCs+KuKJtv2mTlOeURtLtUZY064E8I5HbMCkJYGUR7fvRm8b7zo35en7WpO4iVqUf
 78X9YA0mZyJCwC6o2NZtQe3Vc6w1dFxi/JpA5V3IKAS5GqCLxOAk4BGFINlPXEEJ9yti
 SFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787506667; x=1788111467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WzxtLwRD92+TCzzKKRXbUxryNiIrjmzaSY4Z8wvm3PE=;
 b=M9tkKzT4xbq3XpeUftuEgw76CQ2R7JCCL0/kNRZrRgQccCNA8ajcbdl04O0I0uuMQ9
 5pJxUhJ7hhhsLWWYXGkayyrhlsp62pmAUW/XBeQVh7Gh/0nPMmv+fz8r0vpqZ2vBlama
 ZTgjQSLsK8NcD94yWKbPrkrkvFg7u/uOhn6hElTzvHbtXVkiPKnscNBZb2OHGBgA0X7n
 4tZR5eXKj1LdajsqCRGRU6neZv6RNdjWF+Sj7vdW3LIxyaNbt+ihFp1JUok0Wd/8HqTH
 sPGrR0heS8791dEfZ/8hzwpuMU6Aj8gNJHg/zNGoEUBTN4qYwGz12uSqVCZAru5nxNKV
 lqYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpV1JXRF3IgKS2y80XjAUsMV9ra6Y+sqE/DPC09r6SrS6WeVCD9tYs0EWn3tww8RhlSTUbi74WCm9A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nGj2lDa52D4VREbgD5n47aiSE9rd10pPcQXQBRssWBI6HYZVgx
 UtPiJ0lHqDyMinQx3RDIoJcUzuV5WL7VaszNK7S5H/VvTZriKO8r40KJ
X-Gm-Gg: AR+sD13XJ4FReGlVUn0+elqE3nxwwRP6WHTeciVHqL11mWSYL3Ia0z7rKTcv6uDVhMY
 sB8jgQw4JGGpeoqyLEqXwdqulNA4nQAyVwe12Xvm0d0yErfNu2yCqeFx6Uii+u6oxAgReI6w0i5
 u1Il/rFjRaICw0F5G/xA6um7qinis3/P+RaVXc5VUv9WYlpwITycIEoRKoqdopBEnzRSQaNbmld
 +mehyDdT9a1D2lWoz+A+a4hwSujxwyegMOAUPSghd3pf0veG5K/l9eXv9ETq5bcHsRHqzTYGUWv
 xLZoLOOkVDSU8ilL60bRRa0JIED1zHL55p3b4K55gjyBnZnrWT6u9W9WA4+pSZZ9wPFlai33JQC
 faTFl9T2KDXj54z7CN7+XZrmhrAhGj3e9KrsRKctpcGFRhdexxZVOUrsVvZbxpzaOJLElZSu/Cr
 AwOl4IYCKikuXQsYvXxhfN/x49r1JiKcKcaFFake626gY4S9QO1UQtd42wvshdPRp0HHrSarwPT
 QceRTe7+yyBYE0nxun/PYhbgYdj3dLhldClfpBpQd1pv/+c/nriR1mIEbUZOxyekzHVg89jyeCP
 5+TifJgBZfRwmffTSZn/jQ1ykjCDeGseFf0z23MqqbfYmXaROSFb6kp8RYPUA48SUQQwMvaM7Q=
 =
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id
 a640c23a62f3a-c246a62b495mr2653594366b.18.1787506666570; 
 Sun, 23 Aug 2026 10:37:46 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b027-cd01-554a-ffde-5279-f351.310.pool.telefonica.de.
 [2a02:3100:b027:cd01:554a:ffde:5279:f351])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm791239266b.56.2026.08.23.10.37.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Aug 2026 10:37:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Sun, 23 Aug 2026 19:37:40 +0200
Message-Id: <20260823173740.2983-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:42:29 +0000
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
with the DRM device when the aggregate device is torn down. The card is
registered with devm_snd_soc_register_card() on the HDMI platform device
from the component bind callback, so its devres node starts out in the
component's devres group and used to be released at component unbind,
while vc4_hdmi is still alive.

Whenever an ASoC component is registered, the core retries every card
waiting for components. For a devm-managed card, each retry destroys and
re-adds its devres node. Because snd_soc_bind_card() requeues the card and
converts -EPROBE_DEFER to success, even a retry that still defers can move
the node outside the now-closed component devres group. It is then only
released at platform driver detach, after vc4_hdmi has been freed:

  # modprobe vc4; rmmod vc4
  BUG: KASAN: slab-use-after-free in snd_soc_unregister_card
  Read of size 1 at addr ffff0000456a8450 by task rmmod/262
   devm_card_bind_release / devres_release_all / driver_detach
  Allocated by task 171: drmm_kmalloc / vc4_hdmi_bind
  Freed by task 262 (rmmod): drm_dev_put / component_del

Register the card without devm and unregister it from a component unbind
callback, where the HDMI device resources and the DRM-managed structure
are both still alive, regardless of where the card got bound.

Fixes: 42d99857d6f0 ("ASoC: core: Move all users to deferrable card binding")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
- Preserve the existing ASoC component-lifetime comment and document at
  the card registration site how deferrable binding can move the card's
  devres node outside the component devres group.
- Point Fixes at the deferrable card binding change.
- Add the ASoC maintainers and linux-sound recipients, add the stable
  trailer, and update Assisted-by to the current format.

Tested on a Raspberry Pi 400 (BCM2711), v7.2-11658-g26260251022f, with
KASAN: report gone, rmmod/insmod loop clean.

 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 +++++++++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..7e312932488a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2422,12 +2422,18 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	 * snd_soc_card_get_drvdata() if needed.
 	 */
 	snd_soc_card_set_drvdata(card, vc4_hdmi);
-	ret = devm_snd_soc_register_card(dev, card);
+
+	/*
+	 * Deferred card binding can move a devm registration outside the
+	 * component devres group, so unregister the card explicitly at unbind.
+	 */
+	ret = snd_soc_register_card(card);
 	if (ret)
-		dev_err_probe(dev, ret, "Could not register sound card\n");
+		return dev_err_probe(dev, ret, "Could not register sound card\n");
 
-	return ret;
+	vc4_hdmi->audio.card_registered = true;
 
+	return 0;
 }
 
 static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
@@ -3345,8 +3351,20 @@ err_put_runtime_pm:
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
