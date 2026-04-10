Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E31E99063
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A6A610E905;
	Fri, 10 Apr 2026 09:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ve1ehh7s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVzTWhTO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E03310E905
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6qmqk2624720
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Wvi93YH8rC+uwqaG9mkLD1Brox52CZL5GVh+xSzehQ=; b=Ve1ehh7snL5D2w/w
 KpkdnHxNmyZWdy72RHeJyfuY123lVuZI6ROWoxF0fcGuVYtAGSI4kxO22UYM87Uq
 KSv7bpQ/DTayF51c2HVfJ3D+KB5/63Gf8WjpmT85FUCZYMAfNLFTBf3uoAIouCPY
 qmPv629wuG2cBxRefhBdMkVzViH0y1i+p9rB+6hPbdRIj6FQbZjn5+HMpIM734xm
 E1J2WZzSdyO1olbxU775mQk5/KTyLxka7mhwWGBosh7ouY2+0euE6QE3PDyszPED
 UK5lqNiiE0D0+0POAlJkswoiZ4G5/xygTHI6FDSuAgm/6H08HBabIhEbgoijooWP
 jtQsoA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decmu3m0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a14905811cso49031866d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813649; x=1776418449;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Wvi93YH8rC+uwqaG9mkLD1Brox52CZL5GVh+xSzehQ=;
 b=ZVzTWhTOogTGiICEom5NuevO+bVwsacJWfH98B68d4WmAaeFrcA5aOQXIlfZQu+pUD
 Bn4Ft9htkNxDpOMDVQfK0V1KjHlSsoqLsC6QyAEZVzbzIE2bfRtBIawHou1cCu3PJ3eh
 Cda1x2I4fZr6w2eQOtXvPJOA0s9IDJ7OZkSn9cGVCJltnlUSYXjA5RbCxJ+fbFEiYNO5
 jC+WWXa5aLBA38XfI7A7KAFZ7/WJdJkxcWjjAlSfWksJuC7sXlfeT6PYefbiLP0oNLJZ
 X/Vzhy1WYYcEzFNIUCilUH4UDRaKzttHw73MlycJWly6pzXLEMjqKignATZ55lh3Xj9u
 SVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813649; x=1776418449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Wvi93YH8rC+uwqaG9mkLD1Brox52CZL5GVh+xSzehQ=;
 b=OLHM4EXmswK2E5V7PA5ygoEIV1i+5OcrVZI8Q+NMlWRpetLhxPAfdhzXzxZWRmKELS
 WklgKNKR5wUVaqE14UT3bj9cdx2Kt/MZQCvoVl4RgmKpcoTabkVEplRZympsRLeY1AK4
 LHRSHb1AQCJE8mWX52GZtjIgUgKVzihNQtaznVhvWjXuIpr8N8vC9jwKMTRkVMdilM3H
 kel43hJXyZSQPFZQuEs/WaSiKyynmzH7LOwwsq9Co8Pe4ChLiZ+oS0z30XH4O8d7vt0V
 N744JmENrzxLDUeFNBrlturn06V/Rfx0DDjWc8W2V6xdMCyWpxPsDDuju70QFE5/Q0Nm
 jCXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwt3wZIqMmvro9LUrvbxa+0WTGfBpGmxxyCVsCBQ95h6LxgaLiXJJAIFAVuNs6ALLaS5iB2HuPP6Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2lK4iMj1dnAosmJk36n/roVsN/lPypnUAwRXs02Tcl66eTvWA
 TY2yej6GhNbHiirF43BhDVH1DYoE7nvxKqYfRScLjVnyeABmvWRWCrnk9Fp/BC9dBIz/4IMgCjp
 NXZIn9AR7+1OqCTvKLXiID0ZIUAYqSVdQy3kWNzO2PWylsDUzQQD7Xr/HhyBrRi3talW8o20=
X-Gm-Gg: AeBDieuLgZLtPsovaJw2HT76rvuHaA8DFIWlh4ZvE1wOQtDMWzxHVT8EMBUybqoDeRT
 WwumUcCG3Oh9v5I57DwApcAmeF9OGxHUQudxeP2Acumk4YYgrvrcxfnerCTb5Uhk20b8EuHCZx7
 lXKmLO4lzJaORR4/NYJEka6V9ckWsFwuTeHsQ0hMFdfoLmUmzPI+qjGdHe/aKtDBEKXMeKKMag6
 RqQOf22iYqT6F+ofxaP87aWTT5dtl4XiyGDYkibhbzuN7FiSM3IDsU6Ex8LCJA78WrhL52BBVkl
 PnASZLxpqSpT5jzWj0OpcXrHMfoAJe9qTt4nAea/8QvgJtACrPBhA+ba/SSAI8MhWAtWsIuWWib
 XqV2lUcI3Es2YAnjV6ZNAdiqoLZBTTvDVcOR3sAzE1jB6/w+4253nrAwVGFfa+5Uz08dmRcBjHB
 Y0wJGb/eg=
X-Received: by 2002:a05:622a:2598:b0:50b:5491:ddd8 with SMTP id
 d75a77b69052e-50dd5c4e2a8mr34933501cf.58.1775813648723; 
 Fri, 10 Apr 2026 02:34:08 -0700 (PDT)
X-Received: by 2002:a05:622a:2598:b0:50b:5491:ddd8 with SMTP id
 d75a77b69052e-50dd5c4e2a8mr34933151cf.58.1775813648186; 
 Fri, 10 Apr 2026 02:34:08 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:38 +0800
Subject: [PATCH v4 03/39] drm/msm/dp: break up dp_display_enable into two parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-3-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=10709;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=mq0PfOrhHz3xpO6ywATIWqxoYKKSd0YJ2zz014cgje0=;
 b=gT78WP+aBkH4HIeqKuCXpSamFEGoVGCCuR6C4hAEj1DVCBOuIURxJVAMGbRcSQF1zx8Qwguda
 F/GRlmRQwQCDY5s6GH34fXziiEAsxI+K93Zis3YFjdI/7sJ9eIGTSkF
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: tABtQui3i1RtsAUwGwTB9GdtpfON8sNk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX783PfWBQncdO
 XcDii2Gu1goleGSyYWQ70vJk9YdMeH+GnLNgfQxnvzhC+khUw5/ZFpA0WkEXa4FrNjq3q/qqgKe
 9eEklzAcFXdHm8qkv0xbaioencbJ2JPZPmfBdybQ4HyZJxGKRXfjqAtsr8EFUCNgxnrKZ1evl7f
 9U8jlDTKEgPaUAgatjW/U1OhZ2FBwzBYDkf3vJlVMcnJ4jCisjcFVsPk+JFiGu1bd1SjjLhQ/+E
 LQqLV68Q/r6OIWZOSNKUal4+F+lw9ulqbzLAv5a9xJ2Ov2DMmzzIvmCfAItuf/wWpwqHh/gfL12
 C0fMGEQtdSw3Y3csZ5luVLJu77g8z7DIKkYjl+1/npI69MWZ9i3dFSnhsexqZCtOL1U2PutXzGm
 kxRZ7rti+dqKUKhYk6IRNVWejG1zs1NcIjUsHFBEJwXT7O+53Vfc4osFJsKjTkRuckNEHj5lUuh
 //ksuk/aEOLJs5R/pUg==
X-Proofpoint-ORIG-GUID: tABtQui3i1RtsAUwGwTB9GdtpfON8sNk
X-Authority-Analysis: v=2.4 cv=DslmPm/+ c=1 sm=1 tr=0 ts=69d8c411 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=TEiEX4AJ1PTtM9jp4KoA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100088
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

dp_display_enable() currently re-trains the link if needed and then
enables the pixel clock, programs the controller to start sending the
pixel stream. Split these two parts into prepare/enable APIs, to support
MST bridges_enable insert the MST payloads funcs between enable
stream_clks and program register.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  54 ++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   3 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 105 +++++++++++++++++++++++-------------
 3 files changed, 106 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 3bb08c9a020e..0fd4a7b6d931 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2472,27 +2472,19 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
 {
 	int ret = 0;
-	bool mainlink_ready = false;
 	struct msm_dp_ctrl_private *ctrl;
-	unsigned long pixel_rate;
-	unsigned long pixel_rate_orig;
 
 	if (!msm_dp_ctrl)
 		return -EINVAL;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate = pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
-
-	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		pixel_rate >>= 1;
-
-	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%lu\n",
-		ctrl->link->link_params.rate,
-		ctrl->link->link_params.num_lanes, pixel_rate);
+	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d\n",
+		   ctrl->link->link_params.rate,
+		   ctrl->link->link_params.num_lanes);
 
 	drm_dbg_dp(ctrl->drm_dev,
 		"core_clk_on=%d link_clk_on=%d stream_clk_on=%d\n",
@@ -2502,10 +2494,40 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
 		if (ret) {
 			DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
-			goto end;
+			return ret;
 		}
 	}
 
+	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
+		msm_dp_ctrl_link_retrain(ctrl);
+
+	/* stop txing train pattern to end link training */
+	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
+
+	return ret;
+}
+
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	int ret = 0;
+	bool mainlink_ready = false;
+	struct msm_dp_ctrl_private *ctrl;
+	unsigned long pixel_rate;
+	unsigned long pixel_rate_orig;
+
+	if (!msm_dp_ctrl)
+		return -EINVAL;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate = pixel_rate_orig;
+
+	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+		pixel_rate >>= 1;
+
+	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
+
 	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
 	if (ret) {
 		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
@@ -2523,12 +2545,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		ctrl->stream_clks_on = true;
 	}
 
-	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
-		msm_dp_ctrl_link_retrain(ctrl);
-
-	/* stop txing train pattern to end link training */
-	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
-
 	/*
 	 * Set up transfer unit values and set controller state to send
 	 * video.
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index f68bee62713f..1497f1a8fc2f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -17,7 +17,8 @@ struct msm_dp_ctrl {
 struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e9f0b96c3ebd..5ecbc83c3838 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -622,7 +622,40 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_link_train)
+static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	int rc = 0;
+	bool force_link_train = false;
+
+	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
+
+	if (msm_dp_display->is_edp)
+		msm_dp_hpd_plug_handle(dp);
+
+	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
+	if (rc) {
+		DRM_ERROR("failed to pm_runtime_resume\n");
+		return rc;
+	}
+
+	if (dp->link->sink_count == 0)
+		return rc;
+
+	if (!msm_dp_display->power_on) {
+		msm_dp_display_host_phy_init(dp);
+		force_link_train = true;
+	}
+
+	rc = msm_dp_ctrl_on_link(dp->ctrl);
+	if (rc)
+		DRM_ERROR("Failed link training (rc=%d)\n", rc);
+	// TODO: schedule drm_connector_set_link_status_property()
+
+	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
+}
+
+static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -633,7 +666,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool force_l
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, force_link_train);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -663,13 +696,10 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 	return 0;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
-		return 0;
-
 	/* wait only if audio was enabled */
 	if (msm_dp_display->audio_enabled) {
 		/* signal the disconnect event */
@@ -680,6 +710,14 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	}
 
 	msm_dp_display->audio_enabled = false;
+}
+
+static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+
+	if (!msm_dp_display->power_on)
+		return 0;
 
 	if (dp->link->sink_count == 0) {
 		/*
@@ -1376,14 +1414,13 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_state *state)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	int rc = 0;
-	struct msm_dp_display_private *msm_dp_display;
-	bool force_link_train = false;
+	struct msm_dp_display_private *dp;
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	crtc = drm_atomic_get_new_crtc_for_encoder(state,
 						   drm_bridge->encoder);
@@ -1391,42 +1428,29 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	if (dp->is_edp)
-		msm_dp_hpd_plug_handle(msm_dp_display);
-
-	if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
-		DRM_ERROR("failed to pm_runtime_resume\n");
-		return;
-	}
-
-	if (msm_dp_display->link->sink_count == 0)
-		return;
-
-	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
+	rc = msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	if (!dp->power_on) {
-		msm_dp_display_host_phy_init(msm_dp_display);
-		force_link_train = true;
+	rc = msm_dp_display_prepare(dp);
+	if (rc) {
+		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+		return;
 	}
 
-	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
+	rc = msm_dp_display_enable(dp);
 	if (rc)
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-	// TODO: schedule drm_connector_set_link_status_property()
+		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	msm_dp_display_enable(msm_dp_display, force_link_train);
-
-	rc = msm_dp_display_post_enable(dp);
+	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(msm_dp_display);
+		msm_dp_display_disable(dp);
 	}
 
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -1441,6 +1465,15 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
 }
 
+static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+
+	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+}
+
 void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 				       struct drm_atomic_state *state)
 {
@@ -1453,11 +1486,11 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	if (dp->is_edp)
 		msm_dp_hpd_unplug_handle(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+	msm_dp_display_disable(msm_dp_display);
 
-	pm_runtime_put_sync(&dp->pdev->dev);
+	msm_dp_display_unprepare(msm_dp_display);
 }
 
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)

-- 
2.43.0

