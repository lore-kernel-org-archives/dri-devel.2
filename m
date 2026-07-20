Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694E7C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C909310E691;
	Mon, 20 Jul 2026 06:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WndxS/QP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KXUjRd5f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C962810E691
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNthd0915020
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O3MczQC0wTWVeQ3mq3nzNIjw2qe0TzQXQZvphNTOvUY=; b=WndxS/QPPX3O3W7h
 apgN/FzlGp5My5diaKTMW+q8HE43PsOII0jCocYj9iD76BByg5qOZrFCHYm1Z+Wp
 QZBF4VTTYGuq28W8Xyqdji1efYiOB6Mb6enbeDJAWlp4cwbpJFoy3OhwJ783p1hC
 EoiMB6ncHVkWzj/GtNGabN+qX9LJPpiNLxiqsAFPzFKQLCxBzGOLQe9IcNfv+F6P
 S9G1F5wkZ+eIR0g8n4X5OJ/p4C6R8lMzvMAWZFvoM3o2MrcJNca9MwrXdPS2H7qJ
 KFAs6H4/9LGJENfFs0ddCKX4SP+JbASSeF+Em32EZiJyik7/RYxy6CzTS6vv5Wn5
 uDznFQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af4mf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-904ee4473a8so158192966d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527867; x=1785132667;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O3MczQC0wTWVeQ3mq3nzNIjw2qe0TzQXQZvphNTOvUY=;
 b=KXUjRd5fSmbl5GiXP8siPb8dy/WBirgLLmOYcSJJpsbsVLd5tUd5pITxPPPJ3zcNW3
 YGqS2ktJyzVIBIImQ2F5K2dcNANm5a4FWvF641HBnrBtrg74YFCHyLg7N3ecDyQqoK/e
 w2CFF6Uu9ZQCEdk73bDehV1m/EiozyoX6vA/lIT+97loZIAFQmDdjLv7RE+QgDBtD5JC
 ev+isKFlNA7hhZz7usQ//nTrsG0yifDvUw6LCNOdkkx5Eu+1VI3MTE2w26C0hS+kpP2l
 N6/BsyXW/rCsV5TGOmpeIoX3e9vHWUePv0LLKePwjuHCjnb+3DHAsFnuhGfmoeioNUQ2
 IkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527867; x=1785132667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O3MczQC0wTWVeQ3mq3nzNIjw2qe0TzQXQZvphNTOvUY=;
 b=pWPt9CN8dTrqDDv/3rLOioqTAtGcx+xlJC8xqoqYR9KL2qIkns5qXAS/hOMKKkdVV6
 90R3s93AEgipxc/2L9w+FS7+nUhnUhaC1yChF8iJvSCHK3Y2F3lz2Phn3gtjrWnV4Rme
 jvH4F9qqRu/abAz7CWzSTBSBY5zKF+wtllzLkvxqT7HnvFc9YcjZURyVvauXzyH6bnDL
 tP/IOQZAkTRTQO8CVM7Q7tQA1HfosXccGJOE000nqvtrG+QgtXCxJelFA9dRmlRCc+Hg
 6DyVsjXSpDwr0vWpG6g/cLccn4Rte/3RGgqhhxj43ZJyvYjZOIWis8f7heZ+GitI7Pbn
 ZQng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpxff/wtYvjj5402KtKjhRVcNapFolzWSYxtOGDQwKiDParb+rgBb286J8CuDTOW1cv9fBpCLFJOqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMJ+q11h/CfzKgQWTAfoQcx/NBSPTbkztuMn1T7UBfrafWuOPq
 ZgKUEzUj5YboZ5coMForKkHUwPxuXPCB/PqVaIhexWjhXX0V088zTimCzk/FPbnWWPRVsXrllvQ
 k4Ww0hZQgkoYDKvOTRk45qoMQI51NN1NA0eTFuBjEoEm80dnVFhQxQsSuYTCSRwizcHZoN/M=
X-Gm-Gg: AfdE7cnj4tQTIMinoD+SLGVYW0LvednM4qfnXwowS7ZbEekLlb+0+J74t+b2Scgzw8L
 FOrhBcFKRIZjddWelxxHse1TN5V3ECmipiOtGFDYAe74TOdRcCuyLdRR7H9UrKKvLaPBXq5gYMd
 92EWpxKKMLIVcTbfgHwweBWKn8JQ9Lu2AxEZX9wA5+t6QtaPpSBBPur+gLciwI3UFaKYZCR9tMF
 mghgArXVbI9uhS9weyvQ6T9gqx6TWoEbui+S3AO31tFeaWD+Bdv28jdA0vcXWLWGdPHq1t2fLNZ
 cvdrlGDQyouNXJ0ur0BwZeDmyBHY0/FrQpIoLNkXbQtpdt9dWqKCi0rh02JoTcxS8ekUeVGWAkc
 KueRCAKhGoJk/qbVRksv0IcH59KLxE+aNzxy8eJmI4j0FlxZR6UQ/1E/eRozFzCs=
X-Received: by 2002:a05:6214:2f8f:b0:904:2a2a:d3 with SMTP id
 6a1803df08f44-907783d1c8bmr154829146d6.47.1784527865245; 
 Sun, 19 Jul 2026 23:11:05 -0700 (PDT)
X-Received: by 2002:a05:6214:2f8f:b0:904:2a2a:d3 with SMTP id
 6a1803df08f44-907783d1c8bmr154828896d6.47.1784527864761; 
 Sun, 19 Jul 2026 23:11:04 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:04 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:11 +0800
Subject: [PATCH v8 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-4-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3888;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=SrK8XPLCsmlyTunIHhCIODHVtqwW8w2A+TJGN2u59pA=;
 b=+rSu5mCBvXZ9+4i/Vd/ZLhxxgCDl3t+6LMh2BqGQgJLSYpIalrMWK4zRJDcxpdiiRs+QGLRm7
 JEJxoB1+oB2DOxsDP9OB3TeSTfAAsuzi+84+GOPm1ubNGjgEt4XGX1a
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfXyCd1CzU0jxOf
 ZuVhOboWp4HVGHJHpmnAJOrcB/IPMEuOIZgf+R1cK5formV7TrZLFSstB+g52Ed0a7tFB82ks+J
 P+3DO2j4MjH49HPoQdGVSQ4oDr4V7HM=
X-Proofpoint-GUID: u38xO6DqGc5RoGtJw6Ts4WmYE4sAv4rn
X-Proofpoint-ORIG-GUID: u38xO6DqGc5RoGtJw6Ts4WmYE4sAv4rn
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5dbbfb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=N4WGanfLxQUAwF0MUGsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfXwvbUT5xc2bMQ
 U0RhJQToJ4H+i4n8Ft/Yfju8q4fBXl7KWnZp8tAh3MqDLTOjjNhjAhb/CK2SQn5zE2dJ48ca94h
 cSlKbaB28qnTOQNlse6zK/PeojXsV6cQLWd6RhbJ7CzMCWnN6c9L8GwUovfe1XAP1tWFdM1Sf6r
 MxY1jbY3bWrDbm79XRtTTsrPoxuAzBjqdNpOl0u+99S2gOOzVo2x8xeXDUZy3V1VEz/SE9HB4YL
 +N1Nw9x1BNamYdkDUhDODX33rtcL+t9N8qjH3wj4geUBD4vTTuG9ulu9xC3GJAKR32eB9htQyth
 8UY0a2ww9h90D2J0Wmt8QywW4RUL7ki21tZ+uZu9xXfGluKtqcjxq1UuMvohHUAm2PWFi2+OlLD
 9BgLhRw3HppOgCZpLAhmD999Tc++bMpqqX5X4+fd6I3Jaim91cP4hL4UfnegRC/IDXmJzeRF+Q7
 evEaQcR60M8F/ha6wLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200066
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

The DP_CONFIGURATION_CTRL register contains both link-level and
stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
all of them together. Separate the configuration into link parts and
stream parts to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 47 +++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..4c62b0e137c3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -388,26 +388,44 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	/*
+	 * RMW: Called from atomic_enable(). Serialized by the DRM atomic framework.
+	 */
+	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+
+	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
+		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
+
+	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
+					      msm_dp_panel->msm_dp_mode.bpp);
+
+	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
+
+	if (msm_dp_panel->psr_cap.version)
+		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
+
+	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
+
+	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
+}
+
+static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 config = 0;
 	const u8 *dpcd = ctrl->panel->dpcd;
 
 	/* Default-> LSCLK DIV: 1/4 LCLK  */
 	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
 
-	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
-
 	/* Scrambler reset enable */
 	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
 		config |= DP_CONFIGURATION_CTRL_ASSR;
 
-	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
-			ctrl->panel->msm_dp_mode.bpp);
-
-	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
-
 	/* Num of Lanes */
 	config |= ((ctrl->link->link_params.num_lanes - 1)
 			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
@@ -421,10 +439,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -450,7 +465,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1628,7 +1644,8 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;

-- 
2.43.0

