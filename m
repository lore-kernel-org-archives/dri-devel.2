Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEE2C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1372710E85E;
	Tue, 28 Jul 2026 10:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZM4a7x2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I22jMkiJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D48510E55D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82kR52275981
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lmyNpWe0aDHYLGgCoE0NRQ96OEsYKOj7YwVmjluAaEo=; b=OZM4a7x28ZeKv3BG
 EywMHUM0lKu1+uUBmr8+i6uG1Hk00aLoks0h/bDq7GGIZT+NUGI+tSAE7m43uOjO
 nikQmtSNkhAIssma77ZBiWZdWJT0+ejF7Fz2MswcZLLHYj/enJdLjMIJvDuFgQqV
 QPGwxB5ytJGba0KXwl5p8qWk2zykkdxjSlqudVcq+DKykL4XViG7sd4WiVziRLya
 +z4urjU7mai+AxkGbC9cHzesE2j8qPjs5BNgKhDN7KV3+K7kIfDAZwOBt6bK3v0L
 WvHfrU6YUZP4y6A6Yca85NA00tRrebOCYwNGNYq0WklhePB2TsWBOX16ea8izrpo
 nl8HZQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrsupw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so57966606d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234120; x=1785838920;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmyNpWe0aDHYLGgCoE0NRQ96OEsYKOj7YwVmjluAaEo=;
 b=I22jMkiJ3JP+6osjaUm2hs1IGw1qhuUHWCnIpN1eesjI4Ci8PxtWAf8Eh2xMD4vnyo
 ZAp4LMfomoGYaqgvYAmJjGat+Ljw1yCAswPQVUJVDE43f64jcpzeGk/+mB5Ki7rRVRAN
 AckEvu3opz4s9NJODsOQ9CkP9zli27MuCwA5eIJCoVHtZcNLPAaKC17fTBXS1vwNXrWA
 mTA/uaIyKDyLWJlH7pK10qGq/iuzLMEIgZS4BP9jKeUOIiRN9/E/krnX7bn9UiHSi0Te
 e4zhw86X9jK17nqI4oIiKGunKkbLOxCtMOFsEWVODPcpFOPJlgHyORHU7azs3vL7kq7r
 TlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234120; x=1785838920;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lmyNpWe0aDHYLGgCoE0NRQ96OEsYKOj7YwVmjluAaEo=;
 b=aqFETxXyU47jPX81C0frY0m7PiDNHhR7b0IBAxqgvpjdovm9kkguaE1gNYAFBSXYtx
 Uqr3a/clFGCp5PX17Iii3Y6p2JxUOHrBfTJn1cGOnja3czESpfzs2msaJ/QgGQTUflyD
 WGYOA9vazVRdWfZ1KGBbvVz4wLkVOGdm6O4gZEv2KahwKtfF/7R4/QrYpwmx/OTDDTOD
 2pOn8ixrBBxO+dbU5vXi+D308/U+LgQsTtHZF0qyVNThrisHvTrrFjq1T2Ed/Yc2X+L7
 QuuqLpOyn+srGbCiHNhHcZ4r/To6HfbMmk7GHotoVZ5PMlW+AMhswIiQgtgd20LzvN5j
 kE0A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd9MVHcECxSLm6A3fy2RedULiVhoixUQ1uOeew5MOZ9yapyz9cwdGoK45yRQm127FbEEBAUgsOQg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMXzcmwFf+UNh9QAwEaXQrYHB1PWkYE707X0eAeMF3kLHNm45K
 1nKVph2U+2fD6wRgYOOnok1okf4xnVhDHknJ9R31Gs+kmkm/u+CVzf6vHfeVX05BqTfSGCAzFDy
 /MT+mNao0eYhlmpji1bMsyWGupHliivuakDStDjdLDjyJiZ8KC6/LoBZaqmIOwOjv7Nxh/Es=
X-Gm-Gg: AR+sD13B6T7ZOL0a4K2Bj/xJkHafO3XQ/iOfUo3wrYF7/SwDc7xaw8P9sga8qezNI4I
 cooh+Q40WKENbYpvZDZPlndq104RHXGvOiITOD/l5XHxs990OJcpTJVlaTQPh6BvgpV2Gss0yLd
 Y/tI72DmPiC950gn9CO2+f2Y+qz9fynpQfUi8IVY8IEEJn1sRLbbKbnF4MdcnkpKaxAh7TdV0vQ
 5DvOV4/ilCKR0n8LF+4f41SioG/Q21CetxOpj7mwF1Ayakg1e6vWePTjM2wIX5sQq29Rk+IuidA
 5ycBZOwuNJWVsO8dSgbb60uCnJQKv69BXFsBJUsOSRnNLI8Ry7oS2oFOJRFdyQmK2QcZdf74uAy
 W4qAsQ+AyIPW8wMc1ov8Bc5iGYXCCDhEP6Pgorzo1i/MNURJWKR6O78F3GbYJ2Ds=
X-Received: by 2002:a05:6214:1c85:b0:8eb:eb8f:a37b with SMTP id
 6a1803df08f44-90817088987mr17958346d6.24.1785234119756; 
 Tue, 28 Jul 2026 03:21:59 -0700 (PDT)
X-Received: by 2002:a05:6214:1c85:b0:8eb:eb8f:a37b with SMTP id
 6a1803df08f44-90817088987mr17957666d6.24.1785234119082; 
 Tue, 28 Jul 2026 03:21:59 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:21:58 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:33 +0800
Subject: [PATCH v9 04/14] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-4-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=5044;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=sTyzpXuvVepmyugQFjUs9JdBYN2AL6nR/pGbvI9gphE=;
 b=3aTqVCtRrMrxkJH93eBe2YkbxGhEKVKlZlzNZqJ2S9SPcqqMvz++o81c+3Gl76S1aT7rt42u8
 1RjiEMTxkrWDBbCLAwqjneYsZHVRTd06UwjGUHzYM+JYcIziDtYNC/F
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX181KHeQp4Jo9
 MT93QrSOAZ6e5CLTplWSIDz9ymajqH55QKtqR74XfOs/i2eJ0bx9/RQgndkHi5dP9G5Wf12raAt
 YgmbyTtTLYfn/q1JwqK9EnRnRinfzSYbTkG5Z1Ojzq12hQmWj/Meco6xUEymo/ivRrhwtXMwFV7
 yQRUOqbaJQ6YH9J0sh2bn6Pv7RcWn8jdubho2ueQNaeRCuR+fZnw4/NcKAdxv0NtalWcGqUwLsR
 ugn09jhllhtPkDj/i25Qc8HxXj6Ac1Q676PtEoJjQtgRMz/q4I7xbqr7plyQTdNLw/fe66uBiG/
 xVIKjeyzEf9rxbsmuVfzMYPbor1ciCMuMMdFiYJSExkBBetsIYlmKH8wHoDNGKF/s2MTIFrudjx
 ZbtXpJIETPKkML9JunbPCfYTBp0pjVQXviP0xxNJznlRwCh7bnDanDo4o3QgoV4HFHlr9ssYGM2
 eK6LFsoJEsk/u91No9w==
X-Proofpoint-ORIG-GUID: V1oWE0rzSDyuzeoJU76ufZUHYOFnqzFO
X-Proofpoint-GUID: V1oWE0rzSDyuzeoJU76ufZUHYOFnqzFO
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a6882c8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DFBjIeB4u1z8T3315IQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX7q8I9LXBS3eL
 u+dKW4aQs9xlLfLn9a2T40Kf4Sadb/0MQvKFIueReiPZ7iuJM6xfvwT8SCGi9wyAy6g7UdnwXQm
 uoOGI3XJ2IDVp+Q1Gv3faf+Z6RIDSGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280091
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
stream parts to support MST. Clear the stream-specific fields before
OR-ing new values in the stream path to avoid bit accumulation across
repeated calls.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 51 ++++++++++++++++++++++++++++------------
 drivers/gpu/drm/msm/dp/dp_reg.h  |  2 ++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..7c0649d5318f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -388,26 +388,48 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	/*
+	 * RMW: called from atomic_enable(), serialized by the DRM atomic framework.
+	 * Clear stream-specific fields before OR-ing to avoid bit accumulation.
+	 */
+	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+	config &= ~(DP_CONFIGURATION_CTRL_RGB_YUV_MASK |
+		    DP_CONFIGURATION_CTRL_BPC_MASK |
+		    DP_CONFIGURATION_CTRL_SEND_VSC);
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
@@ -421,10 +443,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -450,7 +469,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1628,7 +1648,8 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 3689642b7fc0..dda4b642c81b 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -149,8 +149,10 @@
 #define DP_CONFIGURATION_CTRL_ENHANCED_FRAMING	(0x00000040)
 #define DP_CONFIGURATION_CTRL_SEND_VSC		(0x00000080)
 #define DP_CONFIGURATION_CTRL_BPC		(0x00000100)
+#define DP_CONFIGURATION_CTRL_BPC_MASK		GENMASK(9, 8)
 #define DP_CONFIGURATION_CTRL_ASSR		(0x00000400)
 #define DP_CONFIGURATION_CTRL_RGB_YUV		(0x00000800)
+#define DP_CONFIGURATION_CTRL_RGB_YUV_MASK	GENMASK(12, 11)
 #define DP_CONFIGURATION_CTRL_LSCLK_DIV		(0x00002000)
 #define DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT	(0x04)
 #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)

-- 
2.43.0

