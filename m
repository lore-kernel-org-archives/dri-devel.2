Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3644606A691
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1592A10E2F7;
	Wed, 25 Nov 2026 15:40:39 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB7910E2F7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:40:12 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 25 Nov
 2026 18:40:11 +0300
Received: from localhost (10.0.253.153) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 25 Nov
 2026 18:40:10 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Sandy Huang
 <hjc@rock-chips.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Alexandre Marquet <tb@a-marquet.fr>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <linux-rockchip@lists.infradead.org>, 
 <linux-arm-kernel@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2 1/3] drm/bridge: analogix_dp: Check runtime resume before
 accessing hardware
Date: Wed, 25 Nov 2026 18:39:45 +0300
Message-ID: <20261125153958.1349811-2-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125153958.1349811-1-n.zhandarovich@fintech.ru>
References: <20261125153958.1349811-1-n.zhandarovich@fintech.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check runtime resume before continuing with the bridge's initialization
or accessing AUX registers. A failed resume may leave the controller
clock disabled.

Therefore, use pm_runtime_resume_and_get() so that an error return
does not retain a runtime-PM usage reference.

Fixes: 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to bridge directory")
Fixes: 8fb6c44fe846 ("drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX")
Fixes: c8f0b7cb01ea ("drm/bridge: analogix_dp: Add support for &drm_dp_aux.wait_hpd_asserted()")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v1 -> v2: no code changes since v1.

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df6963740d2..9d77c1d54a6d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/display/drm_dp_aux_bus.h>
@@ -994,7 +995,9 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 {
 	int ret;
 
-	pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_resume_and_get(dp->dev);
+	if (ret)
+		return ret;
 
 	ret = analogix_dp_init_analog_func(dp);
 	if (ret)
@@ -1360,7 +1363,9 @@ static ssize_t analogix_dpaux_transfer(struct drm_dp_aux *aux,
 	struct analogix_dp_device *dp = to_dp(aux);
 	int ret;
 
-	pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_resume_and_get(dp->dev);
+	if (ret)
+		return ret;
 
 	ret = analogix_dp_detect_hpd(dp);
 	if (ret)
@@ -1383,7 +1388,9 @@ static int analogix_dpaux_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned lon
 	if (dp->force_hpd)
 		return 0;
 
-	pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_resume_and_get(dp->dev);
+	if (ret)
+		return ret;
 
 	ret = readx_poll_timeout(analogix_dp_get_plug_in_status, dp, val, !val,
 				 wait_us / 100, wait_us);
-- 
2.43.0

