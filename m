Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A56AC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDC310EC75;
	Wed, 22 Jul 2026 06:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZWOmbVAD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEAWt1Wd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8EB10EC6E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:21 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53iTx4168892
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DofyXbQYtrjVU+qJqRCV8rPF5+c7acyIUz9ezHCKjkA=; b=ZWOmbVAD6mpQc/l+
 NJgXePlnHEBOL34rBICW8e6sxhvYajc+3gNJjVw3CERSzuPEK7ZAf0kwWBs/YQjD
 IkthNIilExQoPBVKsv6gkhhT/H9iHnYb5Z/UJFe3k7MVHwoiCCuZke2rhO639TYi
 7u4U/DsFCu1418XuXYVKwrVcs+650Vmw7oWj1VgQ37ntLb0BFNqq7B7zIpSHjwTQ
 tflK9EDkLvefnLlsa/HbhXQIk9ZDTrgtbuZhZr4PuiStMNqmaN6M9d162qpW7Sqt
 6KKkk+OvJGK9vWw0MN8bXQZinJBa8AgOaG1vvHo0lpAo1/v/XENXnaXNjZTgY2Dh
 dfL0lA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3mpkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so120688211cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702240; x=1785307040;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DofyXbQYtrjVU+qJqRCV8rPF5+c7acyIUz9ezHCKjkA=;
 b=BEAWt1Wd06yaLGjYjMHBvUqkaVnU97JlUThRxvqgDJKeVwCsJ0xwOT3cJzwKWx5nJN
 Ck9SvzAodh5SjsbzexAamP7k/MsnN5KIfBcVdw6I+fBw4WYrbdn5Dp4o5e0O3DmlcQqA
 EaNPH2nmMUVE+PV3O78gchCSKToCZASMS5jIFxEOfdenSmFSsOTIB2OX1tyXHw7gd8NL
 nyYLjuuulbaJQpbY9uHo6bzar5ER1a8EKeEzyoMcT+vaGtebclIpG8YV45ExfIXPvm+u
 0H+fu98fqyEz87B89jnbFAAVGf+ihKGXDounbdEkEx/a0g1lVRpNGDAbDi/FKIYKNqxY
 MJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702240; x=1785307040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DofyXbQYtrjVU+qJqRCV8rPF5+c7acyIUz9ezHCKjkA=;
 b=m7ZlecyjNdEaRy23WIlzSbbfgsrUgU4Np3KwnoDH6lnwXz46UKDptQT2fnCRdieMGA
 SJN/acAkzi7txXddqernQxmyNIwVz/vVJQaXp35FgUU/UdsqTu4pCcGcmye+dVY3U/NK
 eZ6w/GFzP1JdXB1vNoxU/tmu9wVfMAb5/g/JpuucX902+Ps/xi6iBJmDLqej31Pn8nXB
 VzOqIQWa1kL7gOQ9v0snMWMXUlDpsCv1Uv8Ki+P7/c+vulYSOj7+Mz7NlyotH03MrXK7
 aMz+n6JOprsL1M7sDls25CAKZ/bmCT664YSZ8vf1UPRX7t0mAYgw9oGpi7fHLP17qWXa
 GO9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMP6SSu/cGzz9zctZqx+TRYetPFtfRTXMOcHT2Ie9DtxyG7zCn82iaMz0gKXJcHQZbLCeCju/d6L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywm0pKssEaM5GA/1J1f1SyN8bHU0S1o22NN2k7CUs9wAnQJEHD3
 QD2BoUSJ0Sp5uJrHlFqeLFST/91mXOK/D8X+Vkp/5sYbOmTQtCpUQQmyY185l1UoC9V064Od31k
 v5W/CltcNrCpWs8P7XCtzTNRCMIH5q0rRKEppJgT8C6wZSZTZXPRElH8+Q3/AHaNtsRtWFYA=
X-Gm-Gg: AR+sD13+N9b6YBvuea3xx6Kg7RZh8r3c52I94jVCBH2oI1AmM5KJqaXB7gGEmiIOQU5
 2r+4EdhFMIAExZhTUr6ATkZcJis925vD9B0FzUnoLgxTGhn1BLyrRpXwzcUQ3QCmQhuNK/jFQmC
 ESg8GrEOQgfF3kGU1IIUeMwNhCNvhl2+CBacryUXCF7twzfuleb7noXUE8AKwSkcLIy8YmxGnOh
 tUvr8ScjaopcNHfQY2NJEUb6ro+nJhv58eOMlCMA53YNAPuKbrkAseCVvzJ08Tnzwql8ZWTA34C
 26uZ2VgipPL+f/QjXsqtwr6DoK8v4v7s84YLrK6mxCrj35UQic3eSZNZ3ksmkk8wA2tK1IejTrq
 UoiqNZul+JFBks3Omn8OC5gROo/yTFWswcY6qL0OmTBfZBVBXOBjAhYgcuvZkfQaFfORweHCCJQ
 ndXt35UyhF5vCZSg==
X-Received: by 2002:a05:622a:3cb:b0:51b:f217:539f with SMTP id
 d75a77b69052e-5213c10a2d6mr207439041cf.17.1784702240154; 
 Tue, 21 Jul 2026 23:37:20 -0700 (PDT)
X-Received: by 2002:a05:622a:3cb:b0:51b:f217:539f with SMTP id
 d75a77b69052e-5213c10a2d6mr207438631cf.17.1784702239653; 
 Tue, 21 Jul 2026 23:37:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:32 +0300
Subject: [PATCH 17/24] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_pre_enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-17-368c10fe62fd@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10356;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fIeYRc8ZE0MBCpxiJUV+tJkR7IAyEtybOanxyXalYmU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTo4IiPQWb132G5kSJWclcsaV+HaF+BJtTlD
 uN3m5UgxBGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6AAKCRCLPIo+Aiko
 1fweB/9Prxxx/sdsHxCoetb3J9MkBstmDkil9HuQJqbXkqRMAnWvyBErEsCH2TuKKMlrLlHVAFU
 7WOcrUv0WgIVlgxZkngEHpeTFSL1CSbJPI9aLbWssQdi6RIBKIQ8e56FUFHAIYbrwmCQpMgpwlV
 J8jRXIcukR/IHmUezTyYsD1qu3pgH/O6dtYrBnNSNhLbbcD9pzkFH/LL8QEdyiruBGryiBytAM4
 Qo705fgOhXav2w7JGt6h0W4l8roDyexjL1UmKzNn5vVCRogNcXnop/af4brWWcruv8QICozIpSx
 RKrgBMOIvuJYCy+JpzUvkJqldZHOUIk1X/OUZPt9aeIAOSzI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX+Yja54uUee43
 gIn/fSPghRf5D1/K4nXeiff9AvC3fOa9YzwC5QQDCszasVy3WTPPRWenPZKdVYBb3U6Ujm3LZ0z
 +fw3iOuNZJzqeGcPBXJ+rq+uenZb0hsv9Snm/301b1kAn6fwP0fla4gQ15QdNrKkHZjHdQkU4xy
 1f4j02gESVJNvrztL56brxxbl0HLX8Uae4T1C1luSOZudl6TTL2VJRFGLg+qWIpf8QilRdJ3/rd
 Cb30RRy2pDpybuHANDz2KoRjPu38sEXi3Ogf+9JiPa/F/bHRMfpYiOpkAQK/T0kDrFCX9+tv7bc
 lLlyKK+Y3Q36Qb4KzttyAxCKpsNwLdZSzJXxmBcFGWAOW3lpwhzx/QqQL8rBIz+63AQZAVUrjQN
 xsEZvMOIK832lRCgLLD2xgRUofEdGdV3JvQJgZ4NrZcWIcgWkBrQ/PH/d6UJrqIHmTA3JuH1P+c
 FQMzbuhn6AR7L3apESA==
X-Proofpoint-ORIG-GUID: vEc8ySzELuLMNJ3lFKACZVs03Rwfxl6w
X-Proofpoint-GUID: vEc8ySzELuLMNJ3lFKACZVs03Rwfxl6w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX6rbB1uPWcYIn
 hSo2AxJs1lHxJOoI+DxAKwhDCB0jEVAh3uSCnJ41kE92BkoeEKqihJ2mSQ1d+sGyXdsbiZb7Ud5
 +fvqsKtDszV0SFu+UtbvMcGsZXpsono=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a606521 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=HUDQmCXQRbm1X60NTYYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

The bridge .mode_set() callback is deprecated. Remove it and move the
mode setup logic to .atomic_pre_enable(), where the adjusted_mode is
available from the atomic CRTC state.

.atomic_pre_enable() is used rather than .atomic_enable() because the DPU
encoder's .atomic_enable() reads the output mode's YUV420 / wide bus
state through the msm_display callbacks, and it runs after all bridges'
.atomic_pre_enable() but before their .atomic_enable(). Programming the
mode from the DP bridge's .atomic_enable() would leave the encoder
reading the previously committed mode's state.

Drop msm_dp_mode from msm_dp_display_private and store the mode directly
in the panel, as it was only used as a temporary cache.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
[DB: moved to atomic_pre_enable]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 103 ++++++++++++++++--------------------
 drivers/gpu/drm/msm/dp/dp_drm.c     |   4 +-
 drivers/gpu/drm/msm/dp/dp_drm.h     |   5 +-
 3 files changed, 51 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cd4923d1a17e..7f55cace596f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -63,7 +63,6 @@ struct msm_dp_display_private {
 	struct msm_dp_panel   *panel;
 	struct msm_dp_ctrl    *ctrl;
 
-	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp msm_dp_display;
 
 	/* wait for audio signaling */
@@ -600,16 +599,33 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 }
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
-			       struct msm_dp_display_mode *mode)
+				   const struct drm_display_mode *adjusted_mode,
+				   struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *dp;
+	u32 bpp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
-	dp->panel->msm_dp_mode.bpp = mode->bpp;
-	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
-	msm_dp_panel_init_panel_info(dp->panel);
+	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
+	if (msm_dp_display_check_video_test(msm_dp_display))
+		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
+	else
+		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+
+	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
+	msm_dp_panel->msm_dp_mode.v_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
+	msm_dp_panel->msm_dp_mode.h_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
+	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
+		msm_dp_panel->vsc_sdp_supported;
+	msm_dp_panel_init_panel_info(msm_dp_panel);
+
+	/* populate wide_bus_support to different layers */
+	dp->ctrl->wide_bus_en =
+		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ? false : dp->wide_bus_supported;
 	return 0;
 }
 
@@ -1310,7 +1326,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
+	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
 		return false;
 
 	return dp->wide_bus_supported;
@@ -1414,6 +1430,30 @@ static const struct msm_display_funcs msm_dp_display_funcs = {
 	.needs_encoder = msm_dp_display_needs_encoder,
 };
 
+void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
+				     struct drm_atomic_commit *state)
+{
+	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
+	struct msm_dp_display_private *msm_dp_display;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+
+	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_bridge->encoder);
+	if (!crtc)
+		return;
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	/*
+	 * The DPU encoder's .atomic_enable() reads the mode's YUV420 / wide bus
+	 * state and runs before the bridge's .atomic_enable(), so the mode must
+	 * be programmed here, in .atomic_pre_enable().
+	 */
+	msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
+}
+
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state)
 {
@@ -1424,10 +1464,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	bool force_link_train = false;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
-		DRM_ERROR("invalid params\n");
-		return;
-	}
 
 	if (dp->is_edp)
 		msm_dp_hpd_plug_handle(msm_dp_display);
@@ -1440,12 +1476,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	if (msm_dp_display->link->sink_count == 0)
 		return;
 
-	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
-	if (rc) {
-		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
-		return;
-	}
-
 	if (!dp->power_on) {
 		msm_dp_display_host_phy_init(msm_dp_display);
 		force_link_train = true;
@@ -1500,45 +1530,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 	pm_runtime_put_sync(&dp->pdev->dev);
 }
 
-void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
-			const struct drm_display_mode *mode,
-			const struct drm_display_mode *adjusted_mode)
-{
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
-	struct msm_dp_display_private *msm_dp_display;
-	struct msm_dp_panel *msm_dp_panel;
-
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	msm_dp_panel = msm_dp_display->panel;
-
-	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
-
-	if (msm_dp_display_check_video_test(dp))
-		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
-	else /* Default num_components per pixel = 3 */
-		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
-
-	if (!msm_dp_display->msm_dp_mode.bpp)
-		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
-
-	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
-
-	msm_dp_display->msm_dp_mode.v_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
-
-	msm_dp_display->msm_dp_mode.h_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
-
-	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
-
-	/* populate wide_bus_support to different layers */
-	msm_dp_display->ctrl->wide_bus_en =
-		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
-}
-
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 4f615b45fff7..da005babe411 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -53,10 +53,10 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state           = drm_atomic_helper_bridge_create_state,
+	.atomic_pre_enable      = msm_dp_bridge_atomic_pre_enable,
 	.atomic_enable          = msm_dp_bridge_atomic_enable,
 	.atomic_disable         = msm_dp_bridge_atomic_disable,
 	.atomic_post_disable    = msm_dp_bridge_atomic_post_disable,
-	.mode_set     = msm_dp_bridge_mode_set,
 	.mode_valid   = msm_dp_bridge_mode_valid,
 	.get_modes    = msm_dp_bridge_get_modes,
 	.detect       = msm_dp_bridge_detect,
@@ -230,10 +230,10 @@ static void msm_edp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry
 }
 
 static const struct drm_bridge_funcs msm_edp_bridge_ops = {
+	.atomic_pre_enable = msm_dp_bridge_atomic_pre_enable,
 	.atomic_enable = msm_edp_bridge_atomic_enable,
 	.atomic_disable = msm_edp_bridge_atomic_disable,
 	.atomic_post_disable = msm_edp_bridge_atomic_post_disable,
-	.mode_set = msm_dp_bridge_mode_set,
 	.mode_valid = msm_edp_bridge_mode_valid,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 3b046822f05e..4c6b14dd52ac 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -26,6 +26,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 					       struct drm_connector *connector);
+void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
+				     struct drm_atomic_commit *state);
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state);
 void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -35,9 +37,6 @@ void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
 enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 					  const struct drm_display_info *info,
 					  const struct drm_display_mode *mode);
-void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
-			const struct drm_display_mode *mode,
-			const struct drm_display_mode *adjusted_mode);
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,

-- 
2.47.3

