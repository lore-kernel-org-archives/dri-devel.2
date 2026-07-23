Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200AFC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7489C10F044;
	Thu, 23 Jul 2026 09:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="VVdg24eU";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC36410F044
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:43:33 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1784799810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6JxfaO/L3H+d6K+qQEbQ1OD1DRtey794ZPKDE9UrqK8=;
 b=VVdg24eU+PnYt0Ycjb39/BvQG+bBe6HubhkSIlTYYIkVqfBTMuaIl+wCn+VIz/pIRDItOw
 SMiBqRS+f0tnxpsZy3kI25f+8xlupXIRMGuLp1PjlMo+cWgr0C03TsgS/1X8nngLx2a4e6
 FMw9w7f3lRtXtsyL/Ud5pkNI4XJPtlc=
From: Henrik Grimler <henrik@grimler.se>
Date: Thu, 23 Jul 2026 11:41:56 +0200
Subject: [PATCH v5] drm/bridge: sii9234: use extcon cable detection logic
 to detect MHL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-exynos4-sii9234-driver-v5-1-44b31b5597bd@grimler.se>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OwW7CMAyA4VdBOZMpdtwm7LT3QBy6xgFL0KIER
 SDUdydFmrYJleNvyZ99V5mTcFafq7tKXCTLONRo1ivVH7phz1pCbYUGLSB4zdfbMGbSWWSDlnR
 IUjjp4MEF+m4AQqPq8jlxlOsT3u5qHyRfxnR73ikwT2eyMQ5hiSygjUYmx8FgbJ372ic5HTl9Z
 FazWfCvQ4sOVid2zEgUIZB5ceyv4984tjreeNqwg7azr//Qj9MaALvoUHVa9r3peqDo6Z8zTdM
 DRzf45JUBAAA=
X-Change-ID: 20231218-exynos4-sii9234-driver-d817d4b511d5
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6920; i=henrik@grimler.se;
 h=from:subject:message-id; bh=yV9viZUIq/erJyt5xIHf3MyM1JE8PA58gOxPHaDZWH4=;
 b=owEBiQF2/pANAwAIAbAHbkkLcWFrAcsmYgBqYeItEEHWEZlqv1qmejnB3WgAxUm6tZRP3vqTx
 WWc7ivsOoyJAU8EAAEIADkWIQQsfymul4kfZBmp4s2wB25JC3FhawUCamHiLRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwzLDIACgkQsAduSQtxYWs83AgAjrs+ZiCaXeM5j5Z5npW4K98zF24MNZJ
 44hi9dRwlP9WPev+0qmaxn2THgpeIIKcFIvlal4l8DN2QBhV3OOrzm/GTnSsVojm5GuHpLW0Iy1
 eO0hcTrmKQKV26zLR9m0Aakft6Vp/m7+ooFOLwkmStvCIYlbcUF6r6MvKKh1HkPfIQ4M5qNEXE5
 4u6qxojHQO0Q9PvFrK25XT6hFzIscS6R2p+LQiMHCy+q8cBanlnb+nhmCa/E1NlvCYyxRj4guLF
 ooIW/QEWrA2bwdt+n9sJZeYgYhTECzfcHS2Hf/zGse5O7FYC0AF/zhrX4ivndz5LwczuOs+MFsX
 M4UNkT/wWlQ==
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

To use MHL we currently need the MHL chip to be permanently on, which
consumes unnecessary power. Let's use extcon attached to MUIC to enable
the MHL chip only if it detects an MHL cable.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Hi,

Fix so HDMI through the sii9234 MHL chip works when cable is
hotplugged, by making the MHL chip use extcon cable detection
functions. The patch is heavily inspired by commit 688838442147
("drm/bridge/sii8620: use micro-USB cable detection logic to detect
MHL") by Maciej Purski.

Before these changes, HDMI only worked if cable was plugged in before
booting. If no cable was connected, then wlr-randr still showed HDMI
as connected, with 0x0 px, which confused at least some UIs (phosh)
and caused problems:
https://gitlab.gnome.org/World/Phosh/phosh/-/issues/828

Tested on exynos4412-i9305.
---
Changes in v5:
- Rebase and drop applied patches
- Fix review comments by Luca:
  - Remove unnecessary line breaks and braces
  - Change Kconfig extcon dependency
  - Use devm_extcon_register_notifier
- Link to v4: https://lore.kernel.org/r/20260113-exynos4-sii9234-driver-v4-0-6e8c0ac14f84@grimler.se

Changes in v4:
- Collect tags
- Link to v3: https://lore.kernel.org/r/20250824-exynos4-sii9234-driver-v3-0-80849e716a37@grimler.se

Changes in v3:
- Fix return of dev_err_probe in patch 2 and patch 3, spotted by
  Dmitry and Marek respectively.
- Change to depends on EXTCON || !EXTCON instead of select
- Collect tags for patch 1 (not 3 since there were (minor) changes)
- Link to v2: https://lore.kernel.org/r/20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se

Changes in v2:
- Add dependency on extcon in patch 3. Issue reported by kernel test robot <lkp@intel.com>
- Link to v1: https://lore.kernel.org/r/20250721-exynos4-sii9234-driver-v1-0-2e47ed02f677@grimler.se

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/Kconfig   |  1 +
 drivers/gpu/drm/bridge/sii9234.c | 78 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4a57d49b4c6d..84236e816080 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -333,6 +333,7 @@ config DRM_SII902X
 config DRM_SII9234
 	tristate "Silicon Image SII9234 HDMI/MHL bridge"
 	depends on OF
+	depends on EXTCON if EXTCON
 	help
 	  Say Y here if you want support for the MHL interface.
 	  It is an I2C driver, that detects connection of MHL bridge
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index be67642ab7d3..bf211906fefc 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -20,6 +20,7 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/extcon.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -27,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -173,6 +175,10 @@ struct sii9234 {
 	struct gpio_desc *gpio_reset;
 	int i2c_error;
 	struct regulator_bulk_data supplies[4];
+	struct extcon_dev *extcon;
+	struct notifier_block extcon_nb;
+	struct work_struct extcon_wq;
+	int cable_state;
 
 	struct mutex lock; /* Protects fields below and device registers */
 	enum sii9234_state state;
@@ -864,6 +870,63 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 	return 0;
 }
 
+static void sii9234_extcon_work(struct work_struct *work)
+{
+	struct sii9234 *ctx = container_of(work, struct sii9234, extcon_wq);
+	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
+
+	if (state == ctx->cable_state)
+		return;
+
+	ctx->cable_state = state;
+
+	if (state > 0)
+		sii9234_cable_in(ctx);
+	else
+		sii9234_cable_out(ctx);
+}
+
+static int sii9234_extcon_notifier(struct notifier_block *nb,
+			unsigned long event, void *ptr)
+{
+	struct sii9234 *ctx = container_of(nb, struct sii9234, extcon_nb);
+
+	schedule_work(&ctx->extcon_wq);
+
+	return NOTIFY_DONE;
+}
+
+static int sii9234_extcon_init(struct sii9234 *ctx)
+{
+	struct extcon_dev *edev;
+	struct device_node *musb, *muic;
+	int ret;
+
+	/* Get micro-USB connector node */
+	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
+	/* Then get micro-USB Interface Controller node */
+	muic = of_get_next_parent(musb);
+
+	if (!muic) {
+		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
+		return 0;
+	}
+
+	edev = extcon_find_edev_by_node(muic);
+	of_node_put(muic);
+	if (IS_ERR(edev))
+		return dev_err_probe(ctx->dev, PTR_ERR(edev), "invalid or missing extcon\n");
+
+	ctx->extcon = edev;
+	ctx->extcon_nb.notifier_call = sii9234_extcon_notifier;
+	INIT_WORK(&ctx->extcon_wq, sii9234_extcon_work);
+	ret = devm_extcon_register_notifier(ctx->dev, edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
+	if (ret)
+		dev_err_probe(ctx->dev, ret, "failed to register notifier for MHL\n");
+
+	return 0;
+}
+
 static enum drm_mode_status sii9234_mode_valid(struct drm_bridge *bridge,
 					 const struct drm_display_info *info,
 					 const struct drm_display_mode *mode)
@@ -919,12 +982,17 @@ static int sii9234_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = sii9234_extcon_init(ctx);
+	if (ret < 0)
+		return ret;
+
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
-	sii9234_cable_in(ctx);
+	if (!ctx->extcon)
+		sii9234_cable_in(ctx);
 
 	return 0;
 }
@@ -933,7 +1001,13 @@ static void sii9234_remove(struct i2c_client *client)
 {
 	struct sii9234 *ctx = i2c_get_clientdata(client);
 
-	sii9234_cable_out(ctx);
+	if (ctx->extcon) {
+		flush_work(&ctx->extcon_wq);
+		if (ctx->cable_state > 0)
+			sii9234_cable_out(ctx);
+	} else {
+		sii9234_cable_out(ctx);
+	}
 	drm_bridge_remove(&ctx->bridge);
 }
 

---
base-commit: c182a2ae13886463f7ae36e034449477306d182b
change-id: 20231218-exynos4-sii9234-driver-d817d4b511d5

Best regards,
--  
Henrik Grimler <henrik@grimler.se>

