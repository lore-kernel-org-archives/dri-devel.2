Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B25CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E84C10FE34;
	Fri,  9 Oct 2026 03:20:09 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1D410FE31;
 Fri,  9 Oct 2026 03:20:07 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515846teda7ddcf
X-QQ-Originating-IP: ll4UOsQI2GjH/rTZmdJovT7JYtS+9/6bQa8Au5skvjI=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7874777080659291572
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:58 +0800
Subject: [PATCH v2 06/20] drm/msm/dp: Keep runtime PM calls outside the
 connection lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-6-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; i=sophon@radxa.com;
 h=from:subject:message-id; bh=4U9Nmsy1uYb82VMp2QQ+dOjRfnyMbjdVCFQc3Q/Ljg8=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlboR7QsYLp/rCH9tMCZ358nr7acvqXxG5Nf0/+dq
 Tk3qvbnd5SyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjIDSGG/z4L2o+xeM+OuDOl
 wLV9dfJFJwe+33P3TCmf8HWhrZrMRCWGf9ZSonba3/dd7HRafVlE+rezWv/7DSo2n+TlWrdmz5K
 24AAA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhvpCzAv3WKAaVmCQCIdL057BxnVL9R0UsSfXk/LpU8UzpLdtufRj5sT
 eqX3j4ZOOg5NKmksEDj7L/9xhWSsecrkTVqBj1ksQ6fobpbyxVZ/3LAsAubN1pnGEIZG1aZ
 J/HX0efSZRmmdrPv3eHzxTivT2JTVcCbZ4Fo/HrQlU5ghgzkCszeA4yRTFeI8avJC4FrcY+
 14s1KpzWsS3OMvpMLBZR1d8ySAtVc2ayME6iwULg+qfeSS6Fn454YPAuu3Vafc7NDRlqYdu
 +NkpwOnOjNe4OIcDZLio31eHYcmNxPZ5ybwJy6g8oCGcvJhVzA9Wusi66vZ4Biy1gLs/vdP
 Pc+KhHRzOImzikp5Y6UX6t959KOfLL9GS5qFkZ9k56niMvBZxMtq6D5GM5oSCLRjNRmSm42
 fdc0YZf4cwpC5GJg10XXMkyrerh0gkahR4FtFSVn3fgVG6afPLKf3YCj+3fjxRkdflmfIoo
 Zd9XCSsubztuV7uUgDVwdBqNY0EDBRS+xn+1jMAGnnEP6Cdj3f/jCQtQaLoZlFBJpteFYTp
 +QS/ZvIaPV8QXJWnFzBppB6BwIL+YFW3t6jwBL91BkLWEoFJKefpYr3n+lzxl1XU0efTJdm
 SyL46yUB42IMnvF1lZYfVCi7bH6JP4uTO1Gffe2VY+krtysEwi9zBW2TmDiEdzxQpq8A1oD
 Ra6Rk08b52SkxKSlaLg0Yy1fPr1lAOEHohl67MnVh6FGlX4JKk1zPuXHV7q9wzRMuz7AXBB
 G5ZrKckO+cMx1YK6qh5DZxlSCZ5NqwkH+A2W/lcEhBFaQ3LnzaEupancpTvS0Y7v9cqb1YV
 PK/15+mod46mm/JXmedHEzedFflw7Yui1it3D3yz0O8JHXBlbHbXNFLDlPMBjbHRfFFHYYI
 zbQxr3wRX16S8JBUvuBpYrEFUNZr4lZJGMCNUeyUX04FKtdclLWvRHxe0WLoUb0RXCINjuJ
 nvfMRQcjg9TBa+ZbEX4R+0Zd91Do5D289p1l7hBCUQQtNqcGHFXaZuXpJ++L8rmxJmcs4ZT
 9pb1iTQpUy9x23rWmKAWZBo0J77I/rDPfrhTnN/VXZqIFitKkGhnR6H3k4jXKnRGLdliYgX
 A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

Runtime suspend disables the display IRQ synchronously. Calling it while
holding plugged_lock can wait for an HPD IRQ thread that needs the same
lock. Acquiring a runtime PM reference under that lock can also wait for
an in-progress suspend with the same dependency.

Acquire runtime PM references before taking plugged_lock in plug and
detect handling, and release them after unlocking in unplug and detect
handling. Keep connection state and PHY operations protected while the
runtime PM reference holds the controller active.

This prepares for serializing stream operations with HPD processing
without extending the connection lock over synchronous runtime PM calls.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3ca039ff57b8..32a2ac89d8ed 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -409,14 +409,14 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	guard(mutex)(&dp->plugged_lock);
-
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return ret;
 	}
 
+	mutex_lock(&dp->plugged_lock);
+
 	msm_dp_aux_enable_xfers(dp->aux, true);
 
 	msm_dp_display_host_phy_init(dp);
@@ -428,6 +428,7 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 			dp->link->sink_count);
 
 	dp->plugged = true;
+	mutex_unlock(&dp->plugged_lock);
 
 	return ret;
 };
@@ -450,7 +451,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 {
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
 
-	guard(mutex)(&dp->plugged_lock);
+	mutex_lock(&dp->plugged_lock);
 
 	dp->panel->video_test = false;
 
@@ -460,8 +461,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (!dp->plugged)
+	if (!dp->plugged) {
+		mutex_unlock(&dp->plugged_lock);
 		return 0;
+	}
 
 	/* Don't forget modes for eDP */
 	if (!dp->msm_dp_display.is_edp)
@@ -488,10 +491,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 			dp->msm_dp_display.connector_type,
 			dp->link->sink_count);
 
-	if (dp->plugged) {
-		pm_runtime_put_sync(&pdev->dev);
-		dp->plugged = false;
-	}
+	dp->plugged = false;
+	mutex_unlock(&dp->plugged_lock);
+
+	pm_runtime_put_sync(&pdev->dev);
 
 	return 0;
 }
@@ -899,19 +902,22 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 	struct drm_dp_desc desc;
 	bool phy_deinit;
+	bool put;
 	int ret;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	priv = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	guard(mutex)(&priv->plugged_lock);
 	ret = pm_runtime_resume_and_get(&dp->pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
 		return status;
 	}
 
+	mutex_lock(&priv->plugged_lock);
+	put = false;
+
 	phy_deinit = msm_dp_display_host_phy_init(priv);
 
 	msm_dp_aux_enable_xfers(priv->aux, true);
@@ -961,8 +967,12 @@ enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 			msm_dp_display_host_phy_exit(priv);
 		}
 
-		pm_runtime_put_sync(&dp->pdev->dev);
+		put = true;
 	}
+	mutex_unlock(&priv->plugged_lock);
+
+	if (put)
+		pm_runtime_put_sync(&dp->pdev->dev);
 
 	return status;
 }

-- 
2.56.0

