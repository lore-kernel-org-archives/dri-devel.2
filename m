Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EAACA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7E610E5EC;
	Sat,  3 Oct 2026 00:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S699ktkq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DBueSjKU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3949210E5EC
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:16 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne0c82104561
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sILekc2P/DM6m47lNcKQ5eIiQB1Fdkg00WdMRyn1yq8=; b=S699ktkqGAB0MCzT
 BkEgbIEmDUK7VV7q4905VtlLuJ4SCuYPY/Cm1LuLFjHuapGOAFZ3hoqiFQXpT+1n
 rDVdfIzFeDPgpsKHyq0mwi58T2YteZRI1E8qIDKVa4MHR++HlMiEV7xyAnFxXKSv
 2KtFTUEgpQcy++9qQmqbiXFUq0+g/hC5txfoL5ALjo1DRPKCaNf2MDB/KsGorBgJ
 5PCNP/rMBj5JmTv2wMojSMI46V+PoIZBhe8OVVAOYZGhi2ajuhIXdHaXKvuMeHOT
 dWYFI+52DTpk9i6OpKYHhWF6CTjNmrJmow4PJRaWSAIbnvIzeB9m/RarjEq3+QLc
 impxww==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdjaaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso21743585a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985795; x=1791590595;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sILekc2P/DM6m47lNcKQ5eIiQB1Fdkg00WdMRyn1yq8=;
 b=DBueSjKUqwuRzS0nabQaZtTOG7+Nz8+c0L8oAkPzpf68qsBOga0m1Xj3wkgf68NQYb
 rjszgxtPVbUyfwHsQyDTdJt+w8V4ps9Hor0a3wtUgh4b4HgwBsC/0x0YtCAUFr23NJS0
 K53XPQnppGUoV36OJu71lXxseb2Cb4L0DOj0yQSizc63DRehDWPmYL0GF+/DZhvMjvF6
 SyIFvcYvTj9fxrYr1wUUGBjwQDUDBRaBs+bBnubcpmtuw+Mzn8esm7ajkVZoIzE+ERC7
 mHxvilYJOB1Z83E0RK1Ww+TvErpoSAzmVeiGE6nuXk7PE/J5s8qOkCVZmLPc6I5lBlgA
 pvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985795; x=1791590595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sILekc2P/DM6m47lNcKQ5eIiQB1Fdkg00WdMRyn1yq8=;
 b=VQVWpD1Bz8yGTeld10+2BaKymkbLTFochPvy3gD7hUSDBxQykcXc/poLGs4t0boE8P
 LxQyySiACMUUo49eoqcWDye597tWCE90EAli9CM92u+O6azWkRFkAms7zrpwX1HBkcVB
 JVWN74MhLDWUbHB+nvDPzaV3mhX5TMFxGhZOxl2WwDzwkSSZWGUv5xI5Eixi4luz4cZI
 hYIAhxs+4aRpl1mELujQY3ci11sM0qp1G+ayRqzLIoknR6KlxbH0eAAI//uI4wU3aL10
 A0xNVzOwhtoxKClPJuebYZiTKKxcA2b6lStGAtOBbyEa9VhNcNDc5uo1mQC1Slw9ovWM
 AE1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxB514goVHVnwN+/WUsZqXyVcmg4MVHzWHP/JKegXKttCsLLJBdRZ0RUGtxB6pYxD+q6Q+IIGWmMUI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1Pc0/7WlE/p+l2hX+WQ6D0ZekRtLFKY0qGuK6AVw8G3Calx6T
 7456Skn1iAJWhY9Zh6m0bontY+VrtMyqum2vlhY9pm7dHDFBejp3uzLMykuKHd0JFtXr5sV6YKL
 GSPB+JVdAHp0ZkMVJE9X9jwvWQ2hmD3ScEnjEEhBbAj4d4BJlWHAj4P9xxBnKYnenbACUvnQ=
X-Gm-Gg: AYBFou2gz1xRcVjf6W4Vhv4s/Q5bnmF2hcwA1IgBHxfJUpaaP1LFG4bH7blHoyTBgCr
 QynevSgYXbyf0Mh/Ntyy+ZeQTFE/AXkhY/g2ak6Em45LSjfLtiI5eY+tajwRwoqZlQiHAWgn7mZ
 A/05arajAR5zKCW90/GNqjIhtKWz1Ix2ycn1ABHP/XYm9TFBBJn3+TY5ZaxkgKyuR+uwOVlGSYJ
 OO0S27SqGfY9oUfYBzDB5cvqyhG3UOUVd7S54anNIFsHONKRZUvFcBrh9Lpo32iEKwmlAtkDicN
 8HVVJvP7mxIxdFgCKv3Ml/dLGm58FryWQ0UgbHhyGG/GXoU2ejFMgsWetSxLbrEicBvQpoDDgEd
 GHJ4l0JluG1J6G4zOmm2BF0HMOy42yC/ujJA/w0XLKteVixl576fJZFS9vB6QUiEajXfz3zSHuT
 KckLr/DN//jEXv
X-Received: by 2002:a05:620a:2a0c:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93e50ffc937mr195528685a.28.1790985792760; 
 Fri, 02 Oct 2026 17:03:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0c:b0:93c:6450:9cf2 with SMTP id
 af79cd13be357-93e50ffc937mr195522685a.28.1790985792261; 
 Fri, 02 Oct 2026 17:03:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:03:03 +0300
Subject: [PATCH 5/5] drm/msm/dpu: enable quad-pipe for DSC and dual-DSI
 case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-5-6a6a00917b71@oss.qualcomm.com>
References: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
In-Reply-To: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10118;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=nrrCgDrgJ3C4199iiuNCZQkWqWXFAYcwqICxwBeXlkc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEY0A9vFa0uKxgWB1iy8vYpX73eJgB0BRQ1o7
 is9miNJTnCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGNAAKCRCLPIo+Aiko
 1XChB/0aT++k1Lc/ko176+LkQiPfP8WBsnSVnCMx3ceNTjxtUezt9SDxjQxQykcDsh9gPvkDOH+
 j7X7zRxmTwm2m33qOr7plv0wwMtgqRfeVOoiUls3LG1rGhrlWakZhLtrcOoUMJM7lH01c3FzpI0
 eUCZ2EFVNUleekStV0YJ9OgmB/uBguD31ePYn0aKcWuJC5qKDY3Ci+ClRoVjxpuX/SLxMfK1vao
 4DkHQXpnEyK5o7FVKhNtJNUVZWbnOm8jCv2Ok1XJPGZIlNJIMwOTxFNXzUwSTht2ficqyHmxQsG
 1/ohWkknP9J8sVvBrz7vrurqEb3SLt7IWFo1X9LkGUHsbPjd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX5+RrNNsTFgIx
 0qxbeH5hb/ynaqscoyFeUu9zoqmFibjpm2xITH5C79ocrv4lVdtX2aENspLaPEm5fpoHagPaHDF
 RNgGDaHA5OzIIVRpRznYRN7hOdYVxa8=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6ac04643 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=jxoRB77mndzDA2bPJ-wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l7cgyr0zqNbWHcIk_wsai3Eh_freJj-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX4vQHhBNnszox
 JnezZnI14KvYM1TuyyAh3vU5NYqW1olaQ8UqvIFSkwRvVyb9OtELGibRhdOaqnwE+Hkvj1rQPHa
 LnNjqHBhCjaxzW1Yd0gt/Rv0sHY6DHlNTNllWe5+f/DcM1hq5EQ5ma6nBIiGbrXudv3261FN6Xh
 VSlhUAWRuFQ9pTOsHB0y3Ab13xQoaPyTGFuw6AhDOUhdqJ6VGC8s7gNvZwOFlBhPPSlCEUF/Qtv
 VyFm0++aIJheupKpYFintk+qgehGbO8Q4e8vL98CzRdtX8sR1Aij3CzpGGLTjqrhfmM8HLvvwep
 XeJWeBf/ndU+5jVBDmfDcTJfP5CPCMAo3lHPMsbUAI7kt+O29067KLpsAU9VrykV1U9ENerS3UC
 f1q1yuUoPR1MGKyehIZtfaj2lOaBfBy5+muLugIdFOX7VVaZ5ns174oG74Wg51Vmr62ttTFPESM
 eWIvaECpiIVPyjT1C/g==
X-Proofpoint-GUID: l7cgyr0zqNbWHcIk_wsai3Eh_freJj-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020095
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

From: Jun Nie <jun.nie@linaro.org>

To support high-resolution cases that exceed the width constrain
or scenarios that surpass the maximum MDP clock rate, additional
pipes are necessary to enable parallel data processing within
the width constraints and MDP clock rate.

Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
high-resolution cases where dual interfaces are enabled for virtual
plane case. More use cases can be incorporated later if quad-pipe
capabilities are required.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
[DB: reworked the mixer and DSC selection in dpu_crtc_get_topology()]
[DB: dropped the DPU < 5 limitation]
[DB: compare the clock rate per interface]
[DB: limited the clone mode to two mixers]
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 51 ++++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 28 ++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h      |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
 7 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 57f50a3cd9cf..0e4f2fd0a8f3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
 		struct dpu_crtc_state *crtc_state)
 {
 	struct dpu_crtc_mixer *m;
-	u32 crcs[CRTC_DUAL_MIXERS];
+	u32 crcs[CRTC_QUAD_MIXERS];
 
 	int rc = 0;
 	int i;
@@ -1382,39 +1382,66 @@ static struct msm_display_topology dpu_crtc_get_topology(
 		struct drm_crtc_state *crtc_state)
 {
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
+	const struct dpu_caps *caps = dpu_kms->catalog->caps;
 	struct msm_display_topology topology = {0};
 	struct drm_encoder *drm_enc;
+	bool dsc = false;
+	u64 mode_rate;
 
 	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
 
-	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
 		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
 					    &crtc_state->adjusted_mode);
+		if (dpu_encoder_get_dsc_config(drm_enc))
+			dsc = true;
+	}
 
 	/*
 	 * Datapath topology selection
 	 *
 	 * Dual display
 	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
+	 * 4 LM, 2 INTF ( Split display using 2 interfaces and stream merge
+	 *		  to support high resolution interfaces if virtual
+	 *		  plane is enabled)
+	 * If DSC is enabled, use 2:2:2 for 2 LMs case, and 4:4:2 for 4 LMs
+	 * case.
 	 *
 	 * Single display
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
 	 *
-	 * If DSC is enabled, use 2 LMs for 2:2:1 topology
+	 * If DSC is enabled, use 2 LMs for 2:2:1 topology for single display
+	 * to support legacy devices that use this topology. Use 1:1:1 topology
+	 * if there is only one DSC engine in SoC.
 	 *
 	 * Add dspps to the reservation requirements if ctm or gamma_lut are requested
 	 */
 
-	if (topology.num_intf == 2)
-		topology.num_lm = 2;
-	else if (topology.num_dsc == 2)
-		topology.num_lm = 2;
-	else if (dpu_kms->catalog->caps->has_3d_merge &&
-		 topology.num_dsc == 0)
-		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
-	else
-		topology.num_lm = 1;
+	mode_rate = (u64)mode->hdisplay * mode->vtotal * drm_mode_vrefresh(mode);
+
+	if (topology.num_intf == 2) {
+		if (dpu_use_virtual_planes && caps->has_3d_merge &&
+		    !topology.cwb_enabled &&
+		    (mode->hdisplay > 2 * caps->max_mixer_width ||
+		     mode_rate > 2 * dpu_kms->perf.max_core_clk_rate))
+			topology.num_lm = 4;
+		else
+			topology.num_lm = 2;
+	} else {
+		if (dsc)
+			topology.num_lm = min(2, dpu_kms->catalog->dsc_count);
+		else if (caps->has_3d_merge &&
+			 (mode->hdisplay > MAX_HDISPLAY_SPLIT ||
+			  mode_rate > dpu_kms->perf.max_core_clk_rate))
+			topology.num_lm = 2;
+		else
+			topology.num_lm = 1;
+	}
+
+	if (dsc)
+		topology.num_dsc = topology.num_lm;
 
 	if (crtc_state->ctm || crtc_state->gamma_lut)
 		topology.num_dspp = topology.num_lm;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 6eaba5696e8e..455073c7025b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -210,7 +210,7 @@ struct dpu_crtc_state {
 
 	bool bw_control;
 	bool bw_split_vote;
-	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
+	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
 
 	uint64_t input_fence_timeout_ns;
 
@@ -218,10 +218,10 @@ struct dpu_crtc_state {
 
 	/* HW Resources reserved for the crtc */
 	u32 num_mixers;
-	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
+	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
 
 	u32 num_ctls;
-	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
+	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
 
 	enum dpu_crtc_crc_source crc_source;
 	int crc_frame_skip_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 65161efc4294..2c2b98ce1093 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -55,7 +55,7 @@
 #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
 	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
 
-#define MAX_CHANNELS_PER_ENC 2
+#define MAX_CHANNELS_PER_ENC 4
 #define MAX_CWB_PER_ENC 2
 
 #define IDLE_SHORT_TIMEOUT	1
@@ -659,37 +659,15 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 				 const struct drm_display_mode *adj_mode)
 {
 	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
-	struct msm_drm_private *priv = dpu_enc->base.dev->dev_private;
 	struct msm_display_info *disp_info = &dpu_enc->disp_info;
-	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 	struct drm_connector *connector;
 	struct drm_connector_state *conn_state;
 	struct drm_framebuffer *fb;
-	struct drm_dsc_config *dsc;
 
 	/* a cloned writeback taps the datapath of the real-time encoder */
 	if (!topology->cwb_enabled || disp_info->intf_type != INTF_WB)
 		topology->num_intf += dpu_enc->num_phys_encs;
 
-	dsc = dpu_encoder_get_dsc_config(drm_enc);
-
-	/* We only support 2 DSC mode (with 2 LM and 1 INTF) */
-	if (dsc) {
-		/*
-		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
-		 * when Display Stream Compression (DSC) is enabled,
-		 * and when enough DSC blocks are available.
-		 * This is power-optimal and can drive up to (including) 4k
-		 * screens.
-		 */
-		WARN(topology->num_intf > 2,
-		     "DSC topology cannot support more than 2 interfaces\n");
-		if (topology->num_intf >= 2 || dpu_kms->catalog->dsc_count >= 2)
-			topology->num_dsc = 2;
-		else
-			topology->num_dsc = 1;
-	}
-
 	connector = drm_atomic_get_new_connector_for_encoder(state, drm_enc);
 	if (!connector)
 		return;
@@ -2177,8 +2155,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 {
 	int i, num_lm;
 	struct dpu_global_state *global_state;
-	struct dpu_hw_blk *hw_lm[2];
-	struct dpu_hw_mixer *hw_mixer[2];
+	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
 
 	/* reset all mixers for this encoder */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4942097e7613..7dfaa3ed4dff 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -82,6 +82,8 @@ int dpu_encoder_get_crc(const struct drm_encoder *drm_enc, u32 *crcs, int pos);
 
 bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc);
 
+struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc);
+
 void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 				 struct msm_display_topology *topology,
 				 struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index d24e39597f2f..0bfbce317575 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -314,8 +314,6 @@ unsigned int dpu_encoder_helper_get_cwb_mask(struct dpu_encoder_phys *phys_enc);
 
 unsigned int dpu_encoder_helper_get_dsc(struct dpu_encoder_phys *phys_enc);
 
-struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc);
-
 u32 dpu_encoder_get_drm_fmt(struct dpu_encoder_phys *phys_enc);
 
 bool dpu_encoder_needs_periph_flush(struct dpu_encoder_phys *phys_enc);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f45faf87333e..ba1554095a33 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -24,7 +24,7 @@
 #define DPU_MAX_IMG_WIDTH 0x3fff
 #define DPU_MAX_IMG_HEIGHT 0x3fff
 
-#define CRTC_DUAL_MIXERS	2
+#define CRTC_QUAD_MIXERS	4
 
 #define MAX_XIN_COUNT 16
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 0e65bf5ddc4a..fd1f3e798206 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,7 +34,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
-#define STAGES_PER_PLANE		1
+#define STAGES_PER_PLANE		2
 #define PIPES_PER_STAGE			2
 #define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
 #ifndef DPU_MAX_DE_CURVES

-- 
2.47.3

