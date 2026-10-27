Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE638606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=jRDNTGI8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AEDF10F52E;
	Tue, 27 Oct 2026 13:33:49 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2026 13:33:39 UTC
Received: from mail-m82205.xmail.ntesmail.com (mail-m82205.xmail.ntesmail.com
 [156.224.82.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE2D10F535
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:33:39 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 528777a42;
 Tue, 27 Oct 2026 21:28:33 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v5 15/18] drm/bridge: analogix_dp: Manage pm runtime and IRQ
 for native HPD pin detection
Date: Tue, 27 Oct 2026 21:28:07 +0800
Message-Id: <20261027132810.1746118-16-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027132810.1746118-1-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17d8c5caf03a8kunm87c266213d5730
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTx9PVh8eHU9DGk8dSR5CTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=jRDNTGI8fLUMXnd7atKt9kquMeHKoqudGsZtZXz8wz+RzAk0PcmqvKtG/Yv2CeOfRvMqxPJqHSAGKtVFnepKLDyrnQwsgnEXC3rr0fgNdZW7UHacr1azhxaJJAH1/aE8cbkYA1P+ez9VgzuUWVC8zA8IArVM5QCscbR/1K+vP+o=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=St4/4mnCdCjluMqmoUgrK/rtao/LPuMowCjAK3GrScU=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Rockchip platforms, the Analogix DP native HPD pin IRQ requires the
DP controller to remain powered and clocked to generate plug/unplug
interrupts. Without a runtime PM reference, the controller suspends
when the display pipeline is inactive, disabling HPD detection.

Acquire a runtime PM reference in analogix_dp_bind() and release it in
analogix_dp_unbind() for native HPD pin mode. This keeps the controller
alive throughout the device lifecycle for continuous hotplug detection.

Persistent power is only necessary for native HPD pin mode on the
RK3576 and RK3588 platforms, which are the only ones confirmed to
support the DP mode hotplug detection, as it relies on their HDPTX PHY.
It is not needed for the GPIO HPD mode, the force HPD mode or the fixed
panels, which need no such detection.  Add helper
analogix_dp_require_pm_for_hpd_irq() to identify those configurations.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Split IRQ enable/disable logic, handle native HPD pin and
  GPIO/force-HPD modes separately to avoid unbalanced enable_irq()
  calls. (Sashiko)

Changes in v3:
- Modify the commit msg according to the previous commit for moving IRQ
  enabling/disabling.

Changes in v4:
- Add Tested-by tag.

Changes in v5:
- Limit the runtime PM holding to the RK3576/RK3588 platforms, which
  are the only ones confirmed to support the DP mode hotplug
  detection, and exclude the boards with a fixed panel, so that the
  runtime suspend still works when the screen is blanked. (Sashiko)
- Add a new commit declaring DRM_BRIDGE_OP_HPD on the Analogix DP
  bridge and reporting the hotplug events via drm_bridge_hpd_notify().
  (Sashiko)
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 50177d1ccb5c..009567da5f17 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -42,6 +42,20 @@
 
 static const bool verify_fast_training;
 
+/*
+ * Only the RK3576 and RK3588 platforms are confirmed to support the
+ * DP mode hotplug detection for now, which relies on their HDPTX PHY
+ * and requires the controller to stay powered and clocked.  So the
+ * runtime PM reference is held only for them, and not for the GPIO
+ * HPD mode, the force HPD mode or the fixed panels, which need no
+ * such detection.
+ */
+static bool analogix_dp_require_pm_for_hpd_irq(struct analogix_dp_device *dp)
+{
+	return (dp->plat_data->dev_type == RK3576_EDP || dp->plat_data->dev_type == RK3588_EDP) &&
+	       !dp->hpd_gpiod && !dp->force_hpd && !dp->force_connected_mode;
+}
+
 static void analogix_dp_init_dp(struct analogix_dp_device *dp)
 {
 	analogix_dp_reset(dp);
@@ -1611,6 +1625,12 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		ret = pm_runtime_resume_and_get(dp->dev);
+		if (ret)
+			goto err_unregister_aux;
+	}
+
 	enable_irq(dp->irq);
 
 	return 0;
@@ -1625,6 +1645,10 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
 	disable_irq(dp->irq);
+
+	if (analogix_dp_require_pm_for_hpd_irq(dp))
+		pm_runtime_put_sync(dp->dev);
+
 	drm_dp_aux_unregister(&dp->aux);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.34.1

