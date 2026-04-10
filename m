Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA7E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE62310E90E;
	Fri, 10 Apr 2026 09:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y237kTFn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLTx8wwS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5542D10E90B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8bGEN115435
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gGsWvVRgr+MK8OtdKIfzmiQoRUkubmuDR7D5+VwCXPg=; b=Y237kTFnCzUYzZRG
 qTMr1d0BOKZP7bDGK+/C50SiLl/MQQS7c3NUKQvjl9ngzCqV+aSx6+mmifjM+dw1
 gRZ01CJmk64vcTX1yV4aNlXmLie4wMDHA11ReUIMCEA+9qVjhWPbL6wJUTV71Vhz
 XCZEdgMMippYNx55ypKEFk0Twa1/QQdoPwa10gp1wanPcts5HcbOUREgx4a/RaDb
 ygaIMCv3Gfpj/W67ckW+kO9QczMenHnyOEd/0atPhP+5+U2kGZ6s+Kfr5tm7zfax
 6vljAq+hQvvoyuVmok3E0/Ir2ov8nkbc1DRotIV837Ui2hN3qHmdCyHM644z+yJs
 JvqE4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb8v5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89ce5eec0f0so54966556d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813678; x=1776418478;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gGsWvVRgr+MK8OtdKIfzmiQoRUkubmuDR7D5+VwCXPg=;
 b=bLTx8wwSI7DVEB0msopXXYM1luEiuJJI24/u4jr0wMOkU1RHulWVLHVN0gslgUE3ot
 1tKZc9+8wdvJWEW/ynDrpGLwNn+Pu38LaO5KdUMvCsuI9hbXLbLpFAjas6kR9sn7IGJz
 VCPeg2IS/syWvJQ8uPyVCc200j1dLtCJ0WJGZDArPP+CneQFxpl2AyKfJ64tMekc1/UJ
 WvGji/1qwxYut1rZL5NHrkBHDYvYTbKuc8bug8fA/NR+W+erZ1Wlk4tIebdOcCFkjdLw
 mG/qHhbdFiAEyx3YEp8Fg73NM97Tj08D5ONuumpDiZbBDQ14pjVLk0lcJFQRpNEhltkN
 0XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813678; x=1776418478;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gGsWvVRgr+MK8OtdKIfzmiQoRUkubmuDR7D5+VwCXPg=;
 b=ktG9hpsOIzEwUwTNG2D3LTbbLammNwwiwF3SeRtPvFe6y1clhxGbfmHlEKWBe6US9l
 YdMMWAc3YeH5FKHspfkz/4cRgVXbA0QMTjV2NK38puKQwRJdnGFDoYyULqJcm6wobSWo
 PNXZvmwAtFEDFMXkxYJ1gtHAyz+Vd7e3OaEfGKGu+SwGMGR33LDH5kDcDPsq4EihqeyH
 Df31wT+Zpv5xDGU6qpgo1xVR/J8yBhn7luwNKtkmSwVPPH5OAT8YOSGTRHesDKdNnxwr
 nNCtYkjzkF0Oh9v+VOzMY/PJIhngw61UNkPbzLZRoD1P2kY54psuTfFlNBc3ojjaJnOm
 bL1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB9oTPfFAC1e/1nq4kyvEIJFvqMn7gw7oMY+oziyn5EMdZHio+oqmy/vuW7W6xx/soSB7z+JScr2M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEoGVs1NBuvdYcyrmWTEiIBU5lXGkd1/J6nvaZspr4Tf4wxKjj
 ghAX3vxNVBeCeONyRMgBH+A3Fp16dW3hAKkOmQVOmec9aK3AkXr/y6lvs+e6v5lR/wrduyY3yDB
 8LKfP46/fXJc4aF0TYLR2xR9sgtsBuwn/M4j67liZS6TTAfxYb+A4/A+GTNpjVJeKBcC4824=
X-Gm-Gg: AeBDietlVy6JhhdD7nkYqSNM/q+9SorUesCaPEQPG5fFG8LKXI+Da0fvXJRUQNbpHt2
 XxgW1eLoEBHZbN2CXd3eGNYwD4M0GXLoDxjh2mFloPoqZQMG7nL9wmmIY+ypiKpMaHPFS2F4Hcc
 ahZWpPBI7AinBviz1kpldNxBLPT00BzPVsSFn3IdnG65CPLbGWMc+ar+csvdk7Z4gJGk0Ik/r/U
 kuCRBnpSi/8haX8PK5Trz4KM+bHMEjSmYSCGcDgo5bfbh8fZogc+bp+zYTTiBZdL18Vyyvg//D7
 deQxzq+wf+Q8L5kKF91XvjNh1tCXs0019vtqMUMcHq20QGtHGGD4XopDLCBn81pFjuEiy2v1KyT
 Ey/onpIdxioswQE0h/Eq3Gsv/or0PATVi0vEUSoQSc5s+U4p6SPNHVNlnHKi3X4gB+JO8t8Y2ZI
 RLxndmcnA=
X-Received: by 2002:a05:6214:4905:b0:89a:1364:1027 with SMTP id
 6a1803df08f44-8ac8617efafmr31642736d6.14.1775813677756; 
 Fri, 10 Apr 2026 02:34:37 -0700 (PDT)
X-Received: by 2002:a05:6214:4905:b0:89a:1364:1027 with SMTP id
 6a1803df08f44-8ac8617efafmr31642426d6.14.1775813677303; 
 Fri, 10 Apr 2026 02:34:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:44 +0800
Subject: [PATCH v4 09/39] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-9-b20518dea8de@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3984;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=+lkvt5m+Hb5xdmmgv2phzN6d2NFliDsKsZRJmDLnNmo=;
 b=uoz5NciDlgeR427IPXgZxqP5AFeCFPhwgdTXSj472MjZBjCWJ16V88FUuUZA9+rj8ZCpZRafr
 Mtra9kjJEHnBT5iRu82ZlNSeym8IAUxt+mg97N4I9HT3xj4DmyrdqMe
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfXzDjZybrgrycc
 MsEOgmogMjyhFJ+vmm6emOReR7wppVM64O2q5VFlZqTVoTH/WLA7NKGVwTBAEOk9mfJONJsm/8A
 p3v3IoOlAkuUfl/+GdLBFP+LVxYjle/B1XDLkdLM6fXmpu3p7B0lG5q/iwA0g5BxbgFPxfIeFnL
 kDzMqAPNG5sC+rBoQ5L+wSkmc4V0a9CaX9cR0H+6L76bq4Db2tIzpaLZlrfV88TtZp41nvJTNn4
 lCaKW4ZtRQPz6HQ1WhzhdTdgEzJdf/n+RURik7mUK7uKh0XtzQamievLvNln3rdmxFhB09epLhR
 9yULjBwoX1Cxtdh809SPQ0+wyI/nF/YnxeDILURiahhZSGghdRbLjRwFPBfgcIorLyfhfUmHwal
 CiyHfuIPr0V4cAcJHbquk0gGhQj8FQCWcoNZNjaICMwJPuuFk8cmqL9DNDHY5QbRmVwU48DfJ9B
 N7ZuzD7WqtZbJq4QLMw==
X-Proofpoint-GUID: i8GLZXSrgyc3tb0Yt5-6SLhdC_fu7frl
X-Proofpoint-ORIG-GUID: i8GLZXSrgyc3tb0Yt5-6SLhdC_fu7frl
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c42e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
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

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 79 +++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index d0eed8c7df45..fa62f8f91189 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2176,6 +2176,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+{
+	int ret;
+
+	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	if (ret) {
+		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+		return ret;
+	}
+
+	if (ctrl->stream_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
+	} else {
+		ret = clk_prepare_enable(ctrl->pixel_clk);
+		if (ret) {
+			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+			return ret;
+		}
+		ctrl->stream_clks_on = true;
+	}
+
+	return ret;
+}
+
+static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (ctrl->stream_clks_on) {
+		clk_disable_unprepare(ctrl->pixel_clk);
+		ctrl->stream_clks_on = false;
+	}
+}
+
 static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl)
 {
 	int ret;
@@ -2201,22 +2237,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		return ret;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			return ret;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2545,22 +2566,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		goto end;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			goto end;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
+		return ret;
 
 	/*
 	 * Set up transfer unit values and set controller state to send
@@ -2593,7 +2601,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2627,11 +2634,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
+	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 

-- 
2.43.0

