Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8546ACA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D759810FE3C;
	Fri,  9 Oct 2026 03:20:46 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE71F10FE3C;
 Fri,  9 Oct 2026 03:20:44 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515854tbee33f08
X-QQ-Originating-IP: mZmBNt09oCAyCIS5AV787bFxJ0kbiYhVbHb5G7CrF0Q=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2693331085856337013
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:00 +0800
Subject: [PATCH v2 08/20] drm/msm/dp: Track PHY power ownership
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-8-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3920; i=sophon@radxa.com;
 h=from:subject:message-id; bh=CNhp1n10ypP2UBsGrSZeyY/HNqkOHXcwJsO9tkT9xVU=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlbeqS/ZnDDnWF/U+29GT/7FLYzmbz/4Yf+yRf7K7
 8x0Ku02dpSwMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZhIXAjDdw++CSzK5t8Fc09y
 MBTHR7eYPBU+t3v+60ThgAXl000LGf5ZBObGrWxJP7z+9O+Wb3/3iiXMTXdp0mTSu6a59q9hw3p
 GAA==
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCnNLGxuhE2oslplLQtuVX3D5hJLhXmqLbCXeQo5g0wrYotzABPBQDs0
 xfswK8LO2rg4v9c00+q9tK7AXUIU55sREWW4C1PAT2euSWroXZrxEcRS9izqGTcgtk+iiSK
 sV9TetjaEbA+jfJKK/C1SpPHoIKhne88O8il8Ff5RWlzXu2mHqGol2SRlTNy4BK0Y6iw6uJ
 EwEJNMlAVUL0BHxXeHwQmmvhiREO5WYc3zu/80oxJOaYu97dw0W6jhSW78NHRJWtlB9LJwp
 hN2zPTAj/mxGs4JadAvcFBmA5ZJyAs7aw2cHAOH79sGgjvQ6qPV9AQ1b6XVFiEucgaOynOB
 Te2xtr2J1JfDCXcG2djDjmHDPOrN65L34f/+VVNUIl3mSg8hYi/IKMaB2+BzVXSMAtLOGpT
 VlbjpmoyH1FAes2AEEJWbjcKd+oqtjOa2mvC6G519jl6iHARMAqajKezsxY8fmvOH/D0+Y2
 wj0n4na7kzSXrc/WIdAgpKzKkSIAh388qFSSnVhONro4WJMuE0HaDok2Jyn0TbACRYRvdMz
 JJrQNIZlh+t6iSSEC9UXUyZX/oiqJESlkGv3j4mvlEqGCZhCR2vpMbcuO3OzgUrAW62V1Rk
 1IJEEqLpqg9LetzI4SkpFqveqxooqfxUAoVpDCWMe1AoDO/5W0S3YgXEcPl3H1iyAr3kyrL
 PExxizZhDk/mT/Dm2Ywr93mncK5zLzO4eMDuNazTGh3jpLN3SEMJx/0Dpb8Y2Bq0u5XfIlW
 HFwWRAk4wiZnT298YYB//Kt/E9xPqJS9/qZZ3Zw3EQdXd15NYQlSH7BViAyv5PM1PEN3PN2
 J52jNhQntzqmb2U+s2DFrDlR00al6mjt8v7e+CwNWnGBE46tozAWYSxly2mngcx5UaEdVrT
 BVUksoGskNhx+hEPLNuYw3pXQWc/dqYxBU7gHvKQ914cO62cIYCzAUxEQv1XMQjuQzYUk2T
 0y8FqWMxMfIxFK/3ABZTaE7SACbnFR3egdBdlFMR1aarsmzsX/oa2J0w4ZhZS6ykib7BSJz
 fL4jVUATIPDaHrPHYulEY8JZm7R6WaAUB1EUqeBmEWl0QnNyoX2DVW+16pBjSNjH+tqVd7k
 A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

The preceding stream serialization change protects these ownership
checks against HPD PHY tests and link maintenance. Error propagation is
left to the subsequent stream enable rollback change.

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
2.56.0

