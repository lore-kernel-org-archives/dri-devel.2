Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04DDCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66C710EDAB;
	Tue,  2 Jun 2026 09:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EzxHiug/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cU8PlW2w";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306D510EDAD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tkx41855067
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TUh1BC9Oa2lMbBLcFslL+DmIKNezCTsWlDxQwL1V7Js=; b=EzxHiug/T2yqpblh
 T6Nik2VYn7E+V6F3Ea9nIb7z/K0HRPuf6J2A53ZgNESkuwh+LQ9DAcE6TqyIFlxR
 vmp5ySgaT+eAzo3Sw2u2fSlX4j3lwnPhYs4cWmYPw+6S7Tz8fu+j7HaD/SIfQrvp
 pzIxUJGkrL9a8U18fRV2qKW5FGjNoOngjNdq1Wi2NmG9mx2KmGqgP6JTYLgCMrgh
 /kFNuR8f9NL9N18LCoUwXBc30Q3l7UxTfJ+LVHWPjERDB/TXPNweFKDjmKQ5Hkc/
 Ng9z0YEY+S3C9d8LAlYmssp466uVxzn509T/CnzqAQeVaPzkLkhi1CTiH7VvbFDX
 0D/WIA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf78sv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5176d949c58so7974471cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391501; x=1780996301;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TUh1BC9Oa2lMbBLcFslL+DmIKNezCTsWlDxQwL1V7Js=;
 b=cU8PlW2wFo9cBDfZsPImQ3hS7gdvHXFQmcAzAaAfml9sm5uLm4wUuo6QJTvhPgmSkc
 Gd3h4gttbtcu9KDo6z1e34EIxo48Gx9VDFi0YDzUFe7ZvjP69dol373QQBWAyO4WIi/G
 CUJnuU+Ep7KikFXnYqSBVkQ4/i7gXKNEjM+/0c0rdQQvg/ZrTQMiAcKqA+lnLV7KjUYG
 o6X6IGnIaRHumY1aDH+6g2hmsXKDmQG5vOM19fYMQCE16eta7pzQuUIDqSasg5vJwX2a
 hl3mjO8tMtvO0Ggj3RV3ie25+4sE9HrRxM5XQZ5iDXSX+MiJ0faQz/4QTpdu6HjKQpQb
 zCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391501; x=1780996301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TUh1BC9Oa2lMbBLcFslL+DmIKNezCTsWlDxQwL1V7Js=;
 b=lVKYJ+QOnkwgDmfi1pk2nE92bs6eZSNGkil9ZjkoiGe6f/ytDrLmVGUCGPPsr0ySFb
 vumD/bDR8GOjd06KhX39uwVUQe661xYlg20oEyEyLSxLSZRUVzeFvQqP7MadNKGTqK6u
 arv/mLLKQ2WQY6WW4IediATC10o8ky0vyD/HNm2ij66KZs7cWhOnOi6V0MHFWocefzdY
 DkY/rpOx2Ki3GJT5RZeMuZpjyiIA+LU4t7yOcuShMi0Kq4PHZibOTfzEh3eXBg5T3hWA
 QGbUs+/qV2Jp11uBRBpK3uma2uuiut4N2iRlAHuWUJE63DGQmyZaGeCrsiJ3xQxE9xle
 p3Wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+dcom002lRluEStzysVORRAgJwdwlF6u5GlPcD8t82/SapnvW2VxhiWn/6B+XjIE23xyL1MpekiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKV60fsBJ2KHeynKKqf+DimEtB97QzlSE/JVtRfSQy4bzSq1FU
 lf7ROZucGWergaXMlyrZGyKqvzjVKYe8USy6ct1PzdzLcNow14tjNHzT9mUTprLeZk48+Gq9Oxg
 ioCcKdmn0QpAP640kQBoPgbMp5BbEUYv2A9+F1BDxnfp5qVXv4tAWBh+1JTMmgrDRZoW8U7Y=
X-Gm-Gg: Acq92OGkFVAeKjz10lq02oSOXfMZdgi50+ACg+8VYhBuzYjEm8msBlBP5MpXSRcRfqL
 RfLdbDXeyQLruZ0Wrb19pujKb478UPfHr+Uz3kLl/TbZhNF1ns/IBVuuFJ9EJxcjYXO1LtFNQS2
 MowMt9PLd+A6ucmM/EOG4L6obGy+cRyI7wj6GCGRVChdlOQ1y2uaxfy5c4yt3CDwqqRSZwYMy/V
 BHNuOHGaDZBYaPgBGkjvSVOuRsWRCRbny2gxovO5Zro4m+OgJyBr0IZCLegiheEB9/ldqxI5xat
 9CpRUm60JJaCfFH0ydeQDLW2854zzjf82M57/pG6q6FuoDcGXxVzM91h3E9zar0/duM9LsSBeeX
 o1gKsE1NDcYNXSZncNuM/9OFwc5aoOjmw5UTG7KslBFcvwUd2j0OtBhD58P2O7NanZTtOaTMUdH
 azs2eP28HITXNnFg0nzQ==
X-Received: by 2002:a05:622a:5c16:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5173a67b6d9mr228727251cf.14.1780391500520; 
 Tue, 02 Jun 2026 02:11:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5c16:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-5173a67b6d9mr228726891cf.14.1780391500074; 
 Tue, 02 Jun 2026 02:11:40 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:39 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:16 +0800
Subject: [PATCH v6 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-4-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3766;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=z27Brjfd33j73HBw/hhLe9oIAiCr/9OyTLQ9EZGX168=;
 b=uh/2vuvwZi4NPWvxpb0HLAMWnkDC3My/HP9tdgGNJh4egce6glFrjfSqF6g0pTqElE5gtP5J4
 iyXlaYzrJ2UAeVeEOMv+hP2Hf/EGB2wils/8eUs9M1JQyfosEXeYeqG
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1e9e4d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=N4WGanfLxQUAwF0MUGsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: t-aPt7h8Qi3ZWkvi-hMiDxxxJe30sM8Z
X-Proofpoint-ORIG-GUID: t-aPt7h8Qi3ZWkvi-hMiDxxxJe30sM8Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX8tnu6GRmFYQa
 nUYmgD444kjvtjL1AFREiHY2uYgmpWT8vNVy9cF2+pkuIGqFrZ0xbp4OxcbRDs1g6S1iDBz3DdA
 UMwyMmJ6hNU7qxs0DEGiAxeCazJAoMiqnBF4lsXCmVu2qjsn72OkNF1VEndmXq9iqUZFK5Z2UPU
 jIWBpU0NlZxi2CZZHteDQaXlhi7DrCZZX4rzi72eGGWQLDJEfr+Y94tQyREjwcneL4MufwiryTv
 JalGsMmLdcA4qB2fnLHZvlmPuqczXRJHtOejPU29afgXwUqQXKW8d7uPZIofoOBuYuZSUivHHuA
 K3omFCQhTa6OsuZuE2jOxbhx5w5WfozYoJ+13DacJr8u00lwyxw3zzP5B3G/eI1wnj0Mk/knccd
 qlCxWARiMGWa4y58BiMW0XHgA0LrEFaJTj3ozRpjGogwUSBwKVwJmU6dUBPqa3J14saHxmKV4g1
 TFrNvGtmVFcFQCrxctQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 46 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..ed2ba47881fd 100644
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
@@ -1628,7 +1644,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;

-- 
2.43.0

