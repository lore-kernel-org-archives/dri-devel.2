Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37DCC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB54010E56D;
	Wed, 16 Sep 2026 17:44:59 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA9E10E56D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:44:58 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACXATyS1apq+9duCA--.23293S2;
 Thu, 17 Sep 2026 01:44:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, jbrunet@baylibre.com,
 khilman@baylibre.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luca.ceresoli@bootlin.com, maarten.lankhorst@linux.intel.com,
 martin.blumenstingl@googlemail.com, mripard@kernel.org,
 neil.armstrong@linaro.org, simona@ffwll.ch, tzimmermann@suse.de,
 Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] drm/meson: Fix next_bridge reference leak in
 meson_encoder_cvbs_probe()
Date: Wed, 16 Sep 2026 17:44:22 +0000
Message-Id: <20260916174422.2088967-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACXATyS1apq+9duCA--.23293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1kZF17Gry8ury3AF4ruFg_yoW8ZFyrpr
 Z7tanxtry8Xw1rAw1DAF45AFsaywsrZF4fGw4qvw4fu34fCF1Utr93AF4Ykr1UCa90qF4r
 t3Z5Xr48WFW5CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
 WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF
 7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
 rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr
 0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2qqpO9ruAAAsb
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

The failure paths after drm_bridge_add() return without removing the
bridge, so the bridge stays in the global bridge list, the reference
dropped by drm_bridge_add() is never released and the bridge is never
freed, leaking the next_bridge reference as well. Remove the bridge on
the encoder init, bridge attach and bridge connector error paths.

Fixes: 47fa48b3faa7 ("drm/meson: encoder_cvbs: get/put the next bridge")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
index 41071d6e05e5..a4d280c5f8ed 100644
--- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
@@ -259,9 +259,11 @@ int meson_encoder_cvbs_probe(struct meson_drm *priv)
 	/* Encoder */
 	ret = drm_simple_encoder_init(priv->drm, &meson_encoder_cvbs->encoder,
 				      DRM_MODE_ENCODER_TVDAC);
-	if (ret)
+	if (ret) {
+		drm_bridge_remove(&meson_encoder_cvbs->bridge);
 		return dev_err_probe(priv->dev, ret,
 				     "Failed to init CVBS encoder\n");
+	}
 
 	meson_encoder_cvbs->encoder.possible_crtcs = BIT(0);
 
@@ -270,14 +272,17 @@ int meson_encoder_cvbs_probe(struct meson_drm *priv)
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err(priv->dev, "Failed to attach bridge: %d\n", ret);
+		drm_bridge_remove(&meson_encoder_cvbs->bridge);
 		return ret;
 	}
 
 	/* Initialize & attach Bridge Connector */
 	connector = drm_bridge_connector_init(priv->drm, &meson_encoder_cvbs->encoder);
-	if (IS_ERR(connector))
+	if (IS_ERR(connector)) {
+		drm_bridge_remove(&meson_encoder_cvbs->bridge);
 		return dev_err_probe(priv->dev, PTR_ERR(connector),
 				     "Unable to create CVBS bridge connector\n");
+	}
 
 	drm_connector_attach_encoder(connector, &meson_encoder_cvbs->encoder);
 
-- 
2.34.1

