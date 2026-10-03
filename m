Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43742CA5FF6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F9F10EB0B;
	Sun,  4 Oct 2026 17:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="aU4SRVYt";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E4010E04A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zB
 p34BSzNZJG9C0k9dpuokC4arHuG3WIpAi9HRZC8pc=; b=aU4SRVYtu9Gy7KTu5U
 lOfAXmNYUPrf3T2CWfG1cJnaWKYpsNzpgRKHekBfGi645RuuIEreZagGubfP0Gub
 DWIcOURjMNmIxGsEgNpwS4WpYKttBjofPKYrRuo4F7kQIW8b7NmMUEk4wzdlsbHo
 cz7TJJhE788yS/cle+DtOW680=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3P1yfuMBqYnCaCQ--.60360S2; 
 Sat, 03 Oct 2026 16:11:12 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] drm/msm/hdmi: handle runtime resume failure during power on
Date: Sat,  3 Oct 2026 16:11:03 +0800
Message-Id: <20261003081109.432470-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P1yfuMBqYnCaCQ--.60360S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4Dtw4xWryrKw4rtF4rAFb_yoW5WF4xpr
 ZFg3s09r4kZF47G39rAr4kZFnIk3929ay5J34xKw1Fv3WIvFn0qFn5Ar10qF1rAFyDXF13
 tF18JF15Ga47AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi5CzXUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AAhW2rAuKBSngAA30
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:20:52 +0000
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

msm_hdmi_power_on() ignores runtime resume failures, and
atomic_pre_enable then records the bridge as powered and accesses HDMI
registers. The later disable path also drops a runtime PM reference
that was not acquired.

Return the resume error to atomic_pre_enable, unwind the PHY resources,
and stop the enable sequence without setting power_on. Also honor
errors from the preceding PHY resource enable operation so the unwind
is only used after successful acquisition.

Fixes: 81aa83419706 ("drm/msm/hdmi: switch to pm_runtime_resume_and_get()")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4..7d88657be047 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -13,14 +13,16 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int ret;
 
-	pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret < 0)
+		return ret;
 
 	if (hdmi->extp_clk) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -32,6 +34,8 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 		if (ret)
 			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
 	}
+
+	return 0;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -276,6 +280,7 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	struct drm_connector *connector;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
+	int ret;
 
 	DBG("power up");
 
@@ -289,8 +294,16 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	mutex_lock(&hdmi->state_mutex);
 	if (!hdmi->power_on) {
-		msm_hdmi_phy_resource_enable(phy);
-		msm_hdmi_power_on(bridge);
+		ret = msm_hdmi_phy_resource_enable(phy);
+		if (ret)
+			goto unlock;
+
+		ret = msm_hdmi_power_on(bridge);
+		if (ret) {
+			msm_hdmi_phy_resource_disable(phy);
+			goto unlock;
+		}
+
 		hdmi->power_on = true;
 	}
 	mutex_unlock(&hdmi->state_mutex);
@@ -306,6 +319,11 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	if (hdmi->hdcp_ctrl)
 		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
+
+	return;
+
+unlock:
+	mutex_unlock(&hdmi->state_mutex);
 }
 
 static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
-- 
2.34.1

