Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C2C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A358510EC52;
	Wed, 22 Jul 2026 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P0dK7G7r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ebpnbH8c";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF3710EC50
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:32 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53n6L3663129
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VeNdAJLI50rwT6a6MA64hU5opQaYoTEBW1fpBic2B3U=; b=P0dK7G7rYPmB6TLy
 NDh9Xy0gn0SzcTa+Iqq+oMawFR0/rw7XccM29K39fo2zp0neGNI+DQPV6wlWZCEc
 1LUttBlICu0q5U87xKgjAhtLwRIIAw5BnySh26/3WHC5bdX1TWAy7+sTq6NypfNj
 bx3we3V5szCRyFjLQd92nNYJlZ/2S0u0cXtAwrq/sErJgz7oASyCDX1eQ9PCKKoN
 43KuE+/a//gWhVes/DZP6w76rce4kf1b6vGoQSmyYFaHFnX1LS//yWRyaTHEQX4+
 /uVNM7aVD3mylVoCIwC1eb/PI85ztJ7kWORKgghmyUXduFAuUt07cI+xyXOjA1no
 UshReg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2jht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso187488301cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702191; x=1785306991;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VeNdAJLI50rwT6a6MA64hU5opQaYoTEBW1fpBic2B3U=;
 b=ebpnbH8cXMOc50V3B6JnEqWrrd8rz+uZRspx604mETaVjOb/jTSMq2wnwhSxlyZz+w
 RQ5ALvazxjQBTZXLqK8GzYuF28ZDbaWrDhZDRO0B/4tA2qsQjheBa7BevIr3rUfq1PN7
 +XWCSQWz/hrGkyUgqv7XY6elnJJxG2ppwehOd+8IGNQW0HH8P4uv6PHt51RvEvfAs1bg
 JCP89JvnyQwgvbon4/lk2Sm6O7afYQH0AAYBGhPfto5M/Ki7/49jPf1HVwBj3X2fw6ri
 gTmzkerth9d2t/vKd3afhF/aCXOCi5JDwaw7fJXSUxO1GqRfjFHIBa0dZFnyUKGWUbiQ
 gp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702191; x=1785306991;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VeNdAJLI50rwT6a6MA64hU5opQaYoTEBW1fpBic2B3U=;
 b=gZwPZ5sFEzSylqRPls0xI5iyi1pZfH4Qt036Vw4lnwZrvfchhJLylZFP4coMvZ+7lB
 RHI2x570Iaas4Y4TCEN9qk6YaHygWeKGEykUZ2qD5tOIV7HHFrQeHQjwl9m85elmHzUx
 frca2M4Y28iWCZY48S74id1lRfqWoq6UkzyGlNK5S0fIVPEnRJHfF6tZ9v84gMbHYpn1
 /I4r1EtiC3fMLzxuqdDH1Og7Dvx3uf1fVK+c7FevaZOqS4YLomxl/9kbB3pFbC1+R4zE
 ZQRAwH1VfBN3hKW90hVsx2RsYR23pIBoIbWJbZ2X+cFWlUn4OwFZ+l8cNYQv9SyoITBc
 4suQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWB6TVHVWJ2C/B3TVs4rnPv7iCCFKS2vDmgeR1ms/MwrHfFALrDRvSp1qTUJDz5+yuBWxvvFqSJ9Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3sv5hZhYlp0206/JS6XeQKs+7AR1hHi9jYmzU6FWMFr/EbUXi
 W+Te+EJKwuTDTHcMMEBabOpMwrij/nIBBDuu08zstqUsizx4VqU7pELrUEojjdl3/etPNaMa+UU
 +L1aVrJYMPieUM/8uHEDTAnZgMCq2TLhXpirVvR/Skblc2bDghX7spKVkidrhqp1SPFUW/t8=
X-Gm-Gg: AR+sD12SgIn/alF6e19BflbYdOolzdeqFZORFqSIB+ZrxCaQ02BtYcUUoISQJjFv57W
 Ia5/QhpRiRYABFFzVtw+uOHYs18mcx3RJM4raTlupd/WWiIKXFrkDlTwjkX1uzShHS4eKLxOOSz
 avGx1NrLvGiW21Ki7DzHX4uRjS13PR53UhxshSYNHdFimYIrsN7DKLgT62l2FoSPStwYgSqi9a4
 CQEdGj6s0l1DCW/R3a1lGJAv+/BQ4/6Hm2SHlQmEIfiflyIChBa6JsplVwGKavISrCq6iizV7fp
 kBKkNSGguNI6WaJD20JouVXi81kw1t1uHowTXQA3Rts1aQGGI7uyTY72c/4h1sj9BvADlvP34Uv
 wfdkY4cCNV58SSLIHUCqZZSndmgvWLDBT/UBU+/eBoC9ooZ9gHCkMnmfP+IO6c6p4MIyvB0GxLD
 PGUtOAYPa+0gOfgQ==
X-Received: by 2002:a05:622a:1c09:b0:51c:7b12:5fe3 with SMTP id
 d75a77b69052e-5213f174546mr197315611cf.79.1784702191328; 
 Tue, 21 Jul 2026 23:36:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1c09:b0:51c:7b12:5fe3 with SMTP id
 d75a77b69052e-5213f174546mr197315491cf.79.1784702190862; 
 Tue, 21 Jul 2026 23:36:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:16 +0300
Subject: [PATCH 01/24] drm/msm/dp: reject YUV420-only modes without VSC SDP
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-1-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5325;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=xwiwed+YWzAlxad0yWcCPqbevU3q9KR+updrF6TdV7A=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1ZCyjPlhP1iD85plJTrXns08/XsY2v6mg54ifpFBKhMj
 OUXKg7vZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEShnY/8oekhVL0L25MOy8
 vGP+i/Q0/205sRxlVre/zRfoiA7btz9P/MO6mEc3f7LHGVa0513aacgnnlzH+sBvWvnv/WvFox1
 9QxoctwodkNlZ6/uy5tCjvjD/SYe4xO9ITq9lPPRHZI9dRlbtqhiB1wW9xeeLS6bkzTHSX2CYbG
 fzPKTilYzvuUsa0f/39U/2TVU9dTJ1ideNFlWNy6V3dN8eDbUrfKTlpxTXyejtvlTfQ8Woeff/Q
 IZ5lZMP+LW6ytyVfi67OnWnTM65nQrcB9Km/ONcKS6+Zd57ZcVA5ulV+7fECnNu3pP8p48n4sYP
 O/3krpNuStdNJ/1fKxjfzFywe0UAd8DqJws7xTL+2FUAAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: PsQ3rpbPvF8BaFVbLwL4giMLJD8MDYu7
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a6064f0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zXqIQI19J2VV67nQZaQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: PsQ3rpbPvF8BaFVbLwL4giMLJD8MDYu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1OSBTYWx0ZWRfX+oFASfzM48be
 /eb1rrobJvts1xiB4GiTtXInw7/rwsCa3n1AV2BcOkgnIlSA4X8zyjJUs40sDX+JdSicmkmnra8
 aEn48hI92SSzEUYT1AQQxg4IOmWGWw/dmwcU7vcOaW+bV8bgTsDFuT3q9/UvOpmhd17gDbzav9Y
 1+6TDTY3vYp85HgK4KsBhuCxV/XYXsZR8Bd0uvTRqWYKyREb19t+NrfK4f45z35YqoA7ofFG0Fg
 7u68Ll5hC1CH4GHUQzjk52xDPAf1KX3Fsh8MRtKU2SGiYBg8UOeh4t70i8LxohJGPAxOWZooWqW
 1TGVpuX30pyR8LvS4ioabhigghlnZ6t4DGbaIpqAFmZ6hPM2ed+wntVBApPUTTk/k+xnxs84Lr/
 bf3yksgMQsyxlAWft0IHgc2xErdltmGwdq0FIKSRIlAdDtrZEXc3Smo55pAqMhX79akEUQjQN2I
 EqWXIZ0h7wIKRslmvXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1OSBTYWx0ZWRfXxtjFUePtTmVK
 VxKcvM8rBx8ph6vRmf/8xWPqLqvd6tUrfaa/kS9uBpiU8EeNMYb6cGoLm4wADbwjqI9eYu1xRBG
 hsK6e7AwXYNL5Fgi3ZHJxqOeGHWlIlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220059
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

DP conveys YUV 420 colorimetry through a VSC SDP. A sink that advertises
a mode as YUV-420-only therefore cannot be driven at all unless the panel
supports VSC SDP, yet msm_dp_bridge_mode_valid() only used the VSC SDP
capability to decide whether to halve the pixel clock, otherwise letting
such modes through to be validated (and possibly accepted) at the full
RGB clock the sink cannot display.

Reject 420-only modes with MODE_NO_420 when the panel does not support
VSC SDP. With those modes filtered out, being a 420-only mode implies VSC
SDP support, so the YUV-420 test reduces to drm_mode_is_420_only(): drop
msm_dp_is_yuv_420_enabled() and call the DRM helper directly at its two
callers (the DPU encoder already has the connector from the atomic state).

Fixes: df9cf852ca30 ("drm/msm/dp: account for widebus and yuv420 during mode validation")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  3 +--
 drivers/gpu/drm/msm/dp/dp_display.c         | 28 ++++++++++++----------------
 drivers/gpu/drm/msm/msm_drv.h               |  8 --------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 778e231d4967..1f20695f81e3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -710,8 +710,7 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 		if (fb && MSM_FORMAT_IS_YUV(msm_framebuffer_format(fb)))
 			topology->num_cdm++;
 	} else if (disp_info->intf_type == INTF_DP) {
-		if (msm_dp_is_yuv_420_enabled(priv->kms->dp[disp_info->h_tile_instance[0]],
-					      adj_mode))
+		if (drm_mode_is_420_only(&connector->display_info, adj_mode))
 			topology->num_cdm++;
 	}
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dc6f33809ca5..e0c44eef3aba 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -698,6 +698,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	u32 mode_rate_khz = 0, supported_rate_khz = 0, mode_bpp = 0;
 	struct msm_dp *dp;
 	int mode_pclk_khz = mode->clock;
+	bool is_yuv_420;
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
@@ -709,9 +710,16 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 	link_info = &msm_dp_display->panel->link_info;
 
-	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
-	     msm_dp_display->panel->vsc_sdp_supported) ||
-	     msm_dp_wide_bus_available(dp))
+	is_yuv_420 = drm_mode_is_420_only(&dp->connector->display_info, mode);
+
+	/*
+	 * YUV 420 is carried over DP by signalling the colorimetry through a
+	 * VSC SDP, so a 420-only mode cannot be driven without VSC SDP support.
+	 */
+	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
+		return MODE_NO_420;
+
+	if (is_yuv_420 || msm_dp_wide_bus_available(dp))
 		mode_pclk_khz /= 2;
 
 	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
@@ -1277,22 +1285,10 @@ void __exit msm_dp_unregister(void)
 	platform_driver_unregister(&msm_dp_display_driver);
 }
 
-bool msm_dp_is_yuv_420_enabled(const struct msm_dp *msm_dp_display,
-			       const struct drm_display_mode *mode)
-{
-	struct msm_dp_display_private *dp;
-	const struct drm_display_info *info;
-
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-	info = &msm_dp_display->connector->display_info;
-
-	return dp->panel->vsc_sdp_supported && drm_mode_is_420_only(info, mode);
-}
-
 bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
 			       const struct drm_display_mode *mode)
 {
-	return msm_dp_is_yuv_420_enabled(msm_dp_display, mode);
+	return drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode);
 }
 
 bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 3787db8770ad..3d5679be488e 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -356,8 +356,6 @@ void __exit msm_dp_unregister(void);
 int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 			 struct drm_encoder *encoder, bool yuv_supported);
 void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
-bool msm_dp_is_yuv_420_enabled(const struct msm_dp *dp_display,
-			       const struct drm_display_mode *mode);
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
@@ -382,12 +380,6 @@ static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm
 {
 }
 
-static inline bool msm_dp_is_yuv_420_enabled(const struct msm_dp *dp_display,
-					     const struct drm_display_mode *mode)
-{
-	return false;
-}
-
 static inline bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 					     const struct drm_display_mode *mode)
 {

-- 
2.47.3

