Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A425CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985A910F385;
	Wed, 30 Sep 2026 12:45:08 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B194E10F39F;
 Wed, 30 Sep 2026 12:45:00 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772146t3028f515
X-QQ-Originating-IP: +t6WDbloPr6BLJsQObF6CdVYlFc0tmvmyuck/Q0CAfU=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4284689002146285677
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:47 +0800
Subject: [PATCH 03/13] drm/msm/dp: Track PHY power ownership
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-3-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3859; i=sophon@radxa.com;
 h=from:subject:message-id; bh=Wje5gSJMkJqxEQa1UMgFNz/fNFlHVhtDPwct6R5CQq0=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZeWSVh/SvCusY2TvPSp85ysuEbUBpc5Jxt3flBwm
 yG1USi6o5SFQYyLQVZMkUUhnmEue2XutadipXowc1iZQIYwcHEKwETupzD84WSwf3CswtMi7O8p
 H6nwFzvO/1X6z2Zb+cj2tbHVwqL4lwy/mFtX7p8/ZeX25OfVD9rzlztX3+fwOjjBPOXt6SVN0cf
 KGAE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NdMEHiuPJP+HtzULLHCmhAh1tvudqyUzk3dUteU8Jgw60KPsoMSBiSTe
 bvUruBqrjQm6Kny8Xl4IwCTT70vM9dW4/OB/1tkSYvA1h+SSaGG7Lxxk4M4oUqBvZnz268L
 bA1iqbvVyNXERMke0YA6U1mdVLkazjJtKD/rX9xcaOtleM9f30j99vampvIAwmDD3nQjhQ5
 OsjBnUqUAZKAkTGrJc1gdT4HeKgSNAPE7zH6NoNQk1lTKQtwdNZc+001mn9fJS7z6MKm6Il
 Fr14bw/WscyeEuoTZcdUY4T+/p6hA9qroVIcCMdLbAZgEMlsPlwtQwAHvG/esZdidreMkrA
 PEZ91ULaefhKHcDu6QWpzrGZjGCpPXIRQimZTnb0Ri0tIsjyB0qbaKWTsVLeBsAPyEIuYTN
 XXaZ4JCmn96T+LR+PnZbCC9Evj8HzJqLVfuL70FmmsmUYIM1E0M3lXONhTXbScQBIkldgO3
 Zkul5ZDLi0pQM7zVr1Nd9dZut/fuxzv4o1JPvFMQRgnZvmJovNPyPJKGyosrghEbE0KW2QX
 /ceHIBVQ6tgpZ9rDVgwhKJ3KTHMN/Srctu87WB2QfSIdo6A6B3CLmjSCDD7yiAFhMIg52Z9
 g+Mn4f7Ikgi9cNh0rHXy5ALFJgGylDDVGVYh8jlaVpBKTX6MwNhMzwxTHBHD4Spw36fM0sa
 X3ZcwVB7x0trAwl8J5ajEm9gsx93EXNBrXYLJ/6zp/XHh1Qwf+nIHh65QJQVZjqgyolfsCS
 PHZL+nZGfueNjUrEUiO9X8ycxzV2sAOW4B8lNxMPqYikQwaPG4h6P25rMRk4BMRAT0aKhr7
 oFkj4dHuugr0VugWK6In+bwpc5ptSoJG10QopYompQ9WAWAi0juE9QxRBmFx6CX0h73aL2l
 YXWWmkoNWAL4dvNXdHJjpnXWrtzHiIAZIPoj5qO+KiS8us78N3Ya4Mk7rJg7lMeKt2UoTR5
 L+osun0nO3Vaop7CkAWyzLg7TFnfBzw1jUHjXUcV7r6Pd0TbjN1OSS1BxYTzgoluE58COT0
 OMf1358CuHliDxb59/rzNlYqjxsOSO1ceqj5e6IKtDtro4jymNJcJ8/T3Z7NicXpWu5yotI
 ispbTheFyvo
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

Mainlink restart and PHY test paths can power down the PHY before a later
cleanup attempts to release it again. The PHY core counts each power-off
call, so cleanup without an owned reference can underflow that count and
prevent a subsequent enable from calling the hardware power-on operation.

Record successful PHY power acquisition in the controller and route all
power-off paths through an ownership check. Keep the reference recorded
when power-off fails and avoid acquiring a second reference while it is
still held. Also skip releasing link clocks that are already disabled.

This establishes resource ownership for repeated cleanup. Error
propagation is left to the subsequent stream enable rollback change.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 59070f399e2d..f005421630c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -136,6 +136,7 @@ struct msm_dp_ctrl_private {
 
 	u32 hw_revision;
 
+	bool phy_powered;
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on;
@@ -1813,6 +1814,9 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
+	if (!ctrl->link_clks_on)
+		return;
+
 	clk_bulk_disable_unprepare(ctrl->num_link_clks, ctrl->link_clks);
 
 	ctrl->link_clks_on = false;
@@ -1824,6 +1828,23 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
 		   str_on_off(ctrl->core_clks_on));
 }
 
+static int msm_dp_ctrl_phy_power_off(struct msm_dp_ctrl_private *ctrl)
+{
+	int ret;
+
+	if (!ctrl->phy_powered)
+		return 0;
+
+	ret = phy_power_off(ctrl->phy);
+	if (ret) {
+		DRM_ERROR("Failed to power off PHY: %d\n", ret);
+		return ret;
+	}
+
+	ctrl->phy_powered = false;
+	return 0;
+}
+
 static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
 					      struct msm_dp_panel *panel)
 {
@@ -1836,7 +1857,11 @@ static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
 	ctrl->phy_opts.dp.ssc = drm_dp_max_downspread(dpcd);
 
 	phy_configure(phy, &ctrl->phy_opts);
-	phy_power_on(phy);
+	if (!ctrl->phy_powered) {
+		ret = phy_power_on(phy);
+		if (!ret)
+			ctrl->phy_powered = true;
+	}
 
 	dev_pm_opp_set_rate(ctrl->dev, ctrl->link->link_params.rate * 1000);
 	ret = msm_dp_ctrl_link_clk_enable(&ctrl->msm_dp_ctrl);
@@ -1996,7 +2021,7 @@ static int msm_dp_ctrl_reinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
 	 */
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	phy_power_off(phy);
+	msm_dp_ctrl_phy_power_off(ctrl);
 	/* hw recommended delay before re-enabling clocks */
 	msleep(20);
 
@@ -2022,7 +2047,7 @@ static int msm_dp_ctrl_deinitialize_mainlink(struct msm_dp_ctrl_private *ctrl,
 
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	phy_power_off(phy);
+	msm_dp_ctrl_phy_power_off(ctrl);
 
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
@@ -2643,10 +2668,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
-	struct phy *phy;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
-	phy = ctrl->phy;
 
 	msm_dp_panel_disable_vsc_sdp(panel);
 
@@ -2656,7 +2679,7 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
-	phy_power_off(phy);
+	msm_dp_ctrl_phy_power_off(ctrl);
 }
 
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,

-- 
2.55.0

