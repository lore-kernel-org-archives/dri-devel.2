Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7E606E0DC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=aPPqErKI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA69410F89F;
	Fri, 13 Nov 2026 08:24:08 +0000 (UTC)
Received: from mail-m2421.xmail.ntesmail.com (mail-m2421.xmail.ntesmail.com
 [45.195.24.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F3C610FC85
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:23:39 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54921be7d;
 Fri, 13 Nov 2026 16:23:36 +0800 (GMT+08:00)
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
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v6 15/18] drm/bridge: analogix_dp: Manage pm runtime and IRQ
 for native HPD pin detection
Date: Fri, 13 Nov 2026 16:23:02 +0800
Message-Id: <20261113082305.541652-16-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113082305.541652-1-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d401477303a8kunm073aab0481aec
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh9KVk0dQkoeTxgZS0JNQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=aPPqErKIV5RJOsN048uFAydEnZFPMQQb4eTa0zWxE6qaphHY1+QzBk7vamu+5+p2aBBWaQL5KmWyLKn0I+T4GnEXTDIMeDJfRqc2cAkSW+W0pZhr+mZMdLwJPQ4jI/XE0CTTJqs5SsYXnrySntmWidOijy7qqiFuaySfNyKx210=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=mw9lxkRBxKj9JE5m3ARV7nh2815fsUNpafnX9+FKPq0=;
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

This commit holds the runtime PM reference across the bind/unbind
lifecycle on the RK3576 and RK3588 platforms, which rely on the native
controller interrupt for hotplug detection. The hotplug IRQ is enabled
only for the platforms which support hotplug detection, i.e., the GPIO
HPD mode or the native HPD mode on RK3576 and RK3588, so that the IRQ
thread is not run on the platforms without hotplug support.

The force-connected and force-HPD modes are excluded from the hotplug
detection support, since the HPD events shall not be reported for the
fixed panels.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

Changes in v6:
- Enable the hotplug IRQ only for the platforms which support hotplug
  detection (the GPIO HPD mode, or the native HPD mode on RK3576 and
  RK3588). (Sashiko)
- Exclude the force-connected and force-HPD modes from the hotplug
  detection support check. (Sashiko)
- Simplify the commit msg.
- Add Tested-by tag.
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 7f6346d45a01..d72b66be6874 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -42,6 +42,36 @@
 
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
+/*
+ * The hotplug events are reported either through the optional GPIO HPD
+ * pin or through the native controller interrupt, which is confirmed
+ * to work only on the RK3576 and RK3588 platforms.
+ */
+static bool analogix_dp_supports_hpd(struct analogix_dp_device *dp)
+{
+	if (dp->force_connected_mode || dp->force_hpd)
+		return false;
+
+	if (dp->hpd_gpiod)
+		return true;
+
+	return dp->plat_data->dev_type == RK3576_EDP || dp->plat_data->dev_type == RK3588_EDP;
+}
+
 static void analogix_dp_init_dp(struct analogix_dp_device *dp)
 {
 	analogix_dp_reset(dp);
@@ -1616,7 +1646,14 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
 		goto err_unregister_aux;
 	}
 
-	enable_irq(dp->irq);
+	if (analogix_dp_require_pm_for_hpd_irq(dp)) {
+		ret = pm_runtime_resume_and_get(dp->dev);
+		if (ret)
+			goto err_unregister_aux;
+	}
+
+	if (analogix_dp_supports_hpd(dp))
+		enable_irq(dp->irq);
 
 	return 0;
 
@@ -1629,7 +1666,12 @@ EXPORT_SYMBOL_GPL(analogix_dp_bind);
 
 void analogix_dp_unbind(struct analogix_dp_device *dp)
 {
-	disable_irq(dp->irq);
+	if (analogix_dp_supports_hpd(dp))
+		disable_irq(dp->irq);
+
+	if (analogix_dp_require_pm_for_hpd_irq(dp))
+		pm_runtime_put_sync(dp->dev);
+
 	drm_dp_aux_unregister(&dp->aux);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_unbind);
-- 
2.34.1

