Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9504EE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55ED10E906;
	Fri, 10 Apr 2026 09:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Keux+fH4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gXChZCGs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EFFF10E906
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6pmgT2866295
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /fTImCpIdB5sj6LSnTqYn9v1qNcMBlh7l/VCueblcEU=; b=Keux+fH4ZwvYLhVQ
 F8CWdvnrjTRPNR3pkd9yCYjMZzCp6yg+eXW9aHoA80tbDTV0LVUEAh/azTTMuzxq
 h+XCbOD2lbGHqcusv50jRCBPMxV97Ps8zNKjaoCaE+ZYY1LFLN2Ce52QNPk/boi8
 IgoBNuFD/uJkCJDtZ7mJZCSFziNdZoXvogq0/56mIhY7ctYebk9PlYIAPmtqUzyI
 Ep6izqsfIChuLGKGI0zn1G8YhPROgFo2D2HjVO7kP/R6gpNNO/LR+/06ws+Y1bsP
 TjDZ57RC1jZsqRK0CNRfcq2cRFuBskRsryoR33tFuOPUVOAfMJ9seW0HCBh/qxCN
 RFxSWg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decayksy4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4076dc16so5044511cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813698; x=1776418498;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/fTImCpIdB5sj6LSnTqYn9v1qNcMBlh7l/VCueblcEU=;
 b=gXChZCGsWe34SO6GiS1ZFwpy3f/W4wGItIFFifQAr4rTwX7gdsYw6C+qz1A1qwbHfx
 YWISnIjHTXuGLRwHxM5fav1ob/xBSm7nw5vCj+W6IKFM9kccIwqtu4g11FBMy0o/y4u2
 bMCQYzceOIh1yTAgybo9lXV+THJ4dA7pGzvg+9uFO3e1lII+btGJuVj0iD97ofXo8DBU
 VLM24zIgNAZc8dp+GWOiwMPmXy3otZVLafGt+3eHTEqqaE/38S3vRiCbaxtlus6jT4jM
 F+wRGxngQXTBJsbq24jFlr/V6o9KWVX/yPkuTY55QA99ZXsvTQOfIEzrnwbhTBIBr4dD
 WQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813698; x=1776418498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/fTImCpIdB5sj6LSnTqYn9v1qNcMBlh7l/VCueblcEU=;
 b=nZPtmQoNRsIou17JO2LVSc2tmeAkjcbRyw6lqzI73SZoBzvmKk1YDPuiYr2BtJqAOB
 1z/2le+aqYX/efLICeKBuDNPZUGEe4wmU+7J+hCgS4xPbnv7cACn+HpGJvDt80rBhEqN
 xAdAJAhrAwQ3H6D+aoSzHBMtPFQC2bunjeXY+88hEyesrW+c1OuSqvt3n1XIGEb0nKU6
 NXKyjwnAWk/dlSkSv50UmRymdZJoSFFB9gxe0SnJWJKDfo4QF+FoV0gW6T4X0t3MDtEZ
 3Ed3NqnizCo0ffe1fdslWa5C37H4w1UfbQ3hU9jZ652GAGlN5qE6bTVe1MY6oBYGmqsA
 +yxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHl3rLpffjBoN8xPSNVFss59x7hUSpJ7B4VVbtOwMg6Yg2S2lBeCMtIhCMz2h6sc0+UTnyYyUosgc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSlcxDE5MIF39ER4rfQkhQRlL1NGsS7AUsucWKnfznji0cDjMZ
 30RlpU5QD6XkFMUsNGga1ih7ksvOsN0R5cLno6kP4vOnMMhvp7GJ1l4ApFpkEktgTGHt2gL6EYw
 wC33rXSjUl7JQTnWrSpsyOkuGQ75CUNf7MJexgEuJAIc5ZqBwlMeveSS/yhuwOWt7lATDG2k=
X-Gm-Gg: AeBDieulUHnGQWBWKyMN4KAyP0ixhjEA1EzFdgYss8laugolBaYW3Azr0R83JdTREDy
 t4bym61rcJxoBk9YA7WXk8tKGOcqGxXtBTcp/Hwda0g5Cp9sVgXUabq9sODjHV422F8U6o1MaVJ
 qfAMeP9iEyD+/uU2VHdgAelLqVLdG9P5C/yAAKbjXLYnDelhnCQ6GZxixWp3hwj3J8eFL7Mfiid
 VCEb8+NljK7RnAVNQYuI0JMfGVjnKRn0tDIoboJ/jB54xQjfdzXEj7lYZq3khBjevnNIz4W2qSi
 51aiWwCBhPg6oSnqmR+5bvktEKvTrPkuFtaaBVgSuYKVO7UodtV6RU3C9OQzk1gVc8bap7ko21f
 ut9p2JhYwK4CXYcoKauI9+zCnYBSg2V1lwWHRjH78TSIPxMVILAT1SfjGKX4W/E7+rHS7dOY2ZR
 sP1x6M/ww=
X-Received: by 2002:a05:622a:4d93:b0:50d:8408:c5e5 with SMTP id
 d75a77b69052e-50dd5d66bf2mr35837411cf.64.1775813698062; 
 Fri, 10 Apr 2026 02:34:58 -0700 (PDT)
X-Received: by 2002:a05:622a:4d93:b0:50d:8408:c5e5 with SMTP id
 d75a77b69052e-50dd5d66bf2mr35836931cf.64.1775813697525; 
 Fri, 10 Apr 2026 02:34:57 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:57 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:48 +0800
Subject: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=10441;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=0zZ5Z749us2wPfXjM1qRY1pgMrkJ7eOESMVd1J1iOOk=;
 b=mWQhlZFthxzZPoshK9EMaGep5PpowHqrQGvmpZYLR6lyrLndre+4uvwZ3P+tuhbK4HHAYmiMM
 I5X3n5eA3GkAO6wBqoYx3jeE+fCHWC57XYlvgLhh7o7tE+DiISwzzK7
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d8c443 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3p9S9wXb_X6dsqCEsbEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfXx6CGBEMsZaeh
 UjBGDeTBOHpcKKi0O3RngLKiJ7VzT3vHc8dBwXji4d/drVYYVWJq3tya4E7u9YRHT40/q3M5iTr
 qIJuLD1cD+klXvLO4Db9VkdL2DQfTjFNpRMbyXzig+YtsLkc8dAFumYAnFW9sM23skB9EUTVtE0
 TQ4ked2Qgqns/LZK7So6Fe5AKYbs9bBY1i64gv69HfLV/cwv2JKLhytM/9NPxjyA4gMjWTNhIpD
 44Yyrzhpas6SDigm7vAG8N++bEAb8xNhIOhns1FhztW8lN+EPO4ZD9hYU9FEUbusFOQN2nAP1Kq
 jB5aRhJqQGQdnDLroiFo6Wtq//n8ukl7XoAKtOYMPmEA0Fnc6T0ppIZkBdGRpaJBTPVzxduSjaL
 BOTuOsUhVgbGEj2RHvsT0GEXji8+3DNsPLpvqztmNJUNSC8ChHQ86FGAvrR/f7tO2TLp4Pev+i2
 4xF4pQPuIvDc+PazbAg==
X-Proofpoint-GUID: HRieiNa90SjSzr8bLyU82anTJ6Jve5SF
X-Proofpoint-ORIG-GUID: HRieiNa90SjSzr8bLyU82anTJ6Jve5SF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

With MST, each DP controller can handle multiple streams.
There shall be one dp_panel for each stream but the dp_display
object shall be shared among them. To represent this abstraction,
create a stream_id for each DP panel which shall be set by the
MST stream. For SST, default this to stream 0.

Use the stream ID to control the pixel clock of that respective
stream by extending the clock handles and state tracking of the
DP pixel clock to an array of max supported streams. The maximum
streams currently is 4.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
 5 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 120ec00884e5..fb6396727628 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
 	unsigned int num_link_clks;
 	struct clk_bulk_data *link_clks;
 
-	struct clk *pixel_clk;
+	struct clk *pixel_clk[DP_STREAM_MAX];
 
 	union phy_configure_opts phy_opts;
 
@@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
 
 	bool core_clks_on;
 	bool link_clks_on;
-	bool stream_clks_on;
+	bool stream_clks_on[DP_STREAM_MAX];
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -2176,39 +2176,40 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
-static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
+				    enum msm_dp_stream_id stream_id)
 {
 	int ret;
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
 	if (ret) {
 		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
 		return ret;
 	}
 
-	if (ctrl->stream_clks_on) {
+	if (ctrl->stream_clks_on[stream_id]) {
 		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
 	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
+		ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
 		if (ret) {
 			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
 			return ret;
 		}
-		ctrl->stream_clks_on = true;
+		ctrl->stream_clks_on[stream_id] = true;
 	}
 
 	return ret;
 }
 
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
+	if (ctrl->stream_clks_on[stream_id]) {
+		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
+		ctrl->stream_clks_on[stream_id] = false;
 	}
 }
 
@@ -2228,7 +2229,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
 	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
@@ -2238,7 +2239,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, ctrl->panel->stream_id);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2525,9 +2526,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 		   ctrl->link->link_params.rate,
 		   ctrl->link->link_params.num_lanes);
 
-	drm_dbg_dp(ctrl->drm_dev,
-		"core_clk_on=%d link_clk_on=%d stream_clk_on=%d\n",
-		ctrl->core_clks_on, ctrl->link_clks_on, ctrl->stream_clks_on);
+	drm_dbg_dp(ctrl->drm_dev, "core_clk_on=%d link_clk_on=%d\n",
+		   ctrl->core_clks_on, ctrl->link_clks_on);
 
 	if (!ctrl->link_clks_on) { /* link clk is off */
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
@@ -2567,7 +2567,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
 
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, msm_dp_panel->stream_id);
 	if (ret)
 		return ret;
 
@@ -2629,8 +2629,6 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
 	msm_dp_ctrl_mainlink_disable(ctrl);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
@@ -2702,6 +2700,13 @@ static const char *ctrl_clks[] = {
 	"ctrl_link_iface",
 };
 
+static const char * const pixel_clks[] = {
+	"stream_pixel",
+	"stream_1_pixel",
+	"stream_2_pixel",
+	"stream_3_pixel",
+};
+
 static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
@@ -2735,9 +2740,17 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	if (rc)
 		return rc;
 
-	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
-	if (IS_ERR(ctrl->pixel_clk))
-		return PTR_ERR(ctrl->pixel_clk);
+	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
+		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
+
+		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
+			return PTR_ERR(ctrl->pixel_clk[i]);
+
+		if (IS_ERR(ctrl->pixel_clk[i])) {
+			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
+			break;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index b83be2252a9b..b9f0705b03ba 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -20,7 +20,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 32ad00e326ba..736b621c0531 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -730,7 +730,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
 		msm_dp_ctrl_off_link(dp->ctrl);
 		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
@@ -739,7 +739,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
 		msm_dp_ctrl_off_link(dp->ctrl);
 		msm_dp_display_host_phy_exit(dp);
 	}
@@ -750,6 +750,24 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	return 0;
 }
 
+int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id)
+{
+	int rc = 0;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (!dp) {
+		DRM_ERROR("invalid input\n");
+		return -EINVAL;
+	}
+
+	panel->stream_id = stream_id;
+
+	return rc;
+}
+
 /**
  * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
  * @dp: Pointer to dp display structure
@@ -1451,6 +1469,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0);
+
 	rc = msm_dp_display_enable(dp);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 295da7ae0047..a5c6ed5b18e4 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -41,5 +41,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
+int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 53b7b4463551..21f7f30e6dfd 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -27,6 +27,15 @@ struct msm_dp_panel_psr {
 	u8 capabilities;
 };
 
+/* stream id */
+enum msm_dp_stream_id {
+	DP_STREAM_0,
+	DP_STREAM_1,
+	DP_STREAM_2,
+	DP_STREAM_3,
+	DP_STREAM_MAX,
+};
+
 struct msm_dp_panel {
 	/* dpcd raw data */
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
@@ -40,6 +49,8 @@ struct msm_dp_panel {
 	bool vsc_sdp_supported;
 	u32 hw_revision;
 
+	enum msm_dp_stream_id stream_id;
+
 	u32 max_bw_code;
 };
 

-- 
2.43.0

