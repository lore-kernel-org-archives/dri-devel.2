Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C7CCA6011
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B7110FAB1;
	Thu,  8 Oct 2026 17:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXWk/WY+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDwMVdzL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB2E10E93D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 17:24:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVDfO3145543
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 17:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B2L1OI97K2a50M8qEh49FuuFkAs51MG8CxskzGoI4+k=; b=aXWk/WY+orLQAMEB
 r6moqOPS1g4l/k30jMUj/bfXWvKaXQb5FCuI7AiyoYeSGNPXCEl0pUv1bulnSORP
 5ZBJyswVBP/hrdY5BiEVQ9OImYy5O1qSj6Fv9wrVOxgXLh2QQjJ7z3e7HV6m83Gb
 2Yxemt0JQMuSjFE8fM6dCs2CiGpmra9Lxo5Y56XFlLnRAeW5LVvcCYdWLDBV5AsA
 5mSGaJwEAY30ld0HepHttmlWFOPLVGVxXaDK+jpCwuDZkqoNpmh1vay5PN4UD0d1
 FzF0sG6ne4eDAl/JOqIuw1UU8oEH2yJQyJ2Rv974vMfLm0xbZDCdDCqINtbaqw3D
 k0u7RQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj137n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:24:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so3701995a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791480272; x=1792085072;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B2L1OI97K2a50M8qEh49FuuFkAs51MG8CxskzGoI4+k=;
 b=ZDwMVdzLEA+EudSHp263JUfN86+/pIi/MfJMAe4wrdXM+FkBTKKILWvfHvJ1GYUumQ
 JWISU9g5QiI5+3DkLqB9l5jt8Nk8DLcqmpdeW0oghBTpqjoTjaew3ANNc12h7PXO3SQL
 0RaMaQ5wbXXClX0kEwGnObOMTZ2s24YWbsqmErd4BoZn0b7WHq3xP5l456ocALHicNit
 9/VDU5BjRs1Cy1Xm6vOdl7V2MzvCDEpYBb4u1DnwMc21iistgTf/rGC83kVSQqdc9WuA
 jnXIBa1a/WtXnMPTeEksKSyK0sT+EXibyDArH8Im1HIRryHKpryvrQIrx16LhTEeNUDF
 mRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791480272; x=1792085072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B2L1OI97K2a50M8qEh49FuuFkAs51MG8CxskzGoI4+k=;
 b=i3CAdLQSlYsdAc9sHT4ySNhyqZ84Pu6RumGD9YsqwgpjuQHhyyQe+8gHnywWv2KdSZ
 kBwLPQVQ3d3+DDqtZdmpGVxDbLVD2bUebz2nKzodb0WHXcdgbwp9NooEJhWqv6cb6jNx
 Kr/FRUwxRzKM2G2+yLBXBtgFs7K0wVCbRIKEN3CzbHijY/a0dKTJAZAcWvwX8raB2X6S
 9JRYLavmaijlgHv3hRBleL3qoG1sJogMczLDp1JHH/fV8ziya5tBzH7yxBjzTZjtJTvl
 OKZblIzKmOnvOMeGHLFFjo1YiDly/vFxtAbxEzo7UIh4fH7oG7InM16MtuQ4jSvl6Jk8
 E8WA==
X-Forwarded-Encrypted: i=1;
 AKwUvByzKZ2y4VumnlYoTpFFKXZIbB/fArOWiyDQYd3i2B+KYb5uK67Bhls9dIDgf+R3qO13YGYbAesRJ7Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIc1ESzc3FiVSy1iRWBn3gwPJhs9vmPgK4BS9B0aiiE67yoOg+W
 MSIKy5NhmchiYmhkgk6Y7iNJwnUvd1hL7gFskh0d7ru5Hb7rw2/ylXOfVRFGqTI0bh3psKRebQO
 0YePluPUu4GGMwhXK/zkRhpGFnwFKSnssyj8dLcdLHDy0RJ8WwZvcq0G2ZuwKzdNnP2kQkBk=
X-Gm-Gg: AYBFou0+QY8Lz7TD7eBjtS4j4YSe/LSojMF+4zMzu9qh95b7U41zZWdWM4RFRRMlcpX
 1C5/iuIU+p8DmY+NyKSlauhVbF1M1inUnPJCIVSDkO2L2ZD/WmvQTRtgMUJrLh7IrX//IoedCcK
 Ph6zwealGtwP323D4a0hrbHtDbCW0tdi4G5yHAxdWzyNsqi+BVZPQBUIO/pSrBIPrHPoUX3L24B
 8KwJM4+BMOr9wdWOigSebc4jOmlcoKOanX/5Xv77j1BctspN1EhSrewjTUafQMud184zrZtktam
 A1c6uPQM5I8gtUosx3s8XjMoREZK/7QlhkDcz2RHAbtwgm1GqMWvEIw8N2AHv1pjS5tETs3PswV
 J/3kuUUSusVX3SfJSaLUknM3SAA==
X-Received: by 2002:a17:90a:1049:b0:3aa:fc22:8aa7 with SMTP id
 98e67ed59e1d1-3aafc229281mr1506498a91.53.1791480271746; 
 Thu, 08 Oct 2026 10:24:31 -0700 (PDT)
X-Received: by 2002:a17:90a:1049:b0:3aa:fc22:8aa7 with SMTP id
 98e67ed59e1d1-3aafc229281mr1506485a91.53.1791480271249; 
 Thu, 08 Oct 2026 10:24:31 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3277c459sm47228a91.16.2026.10.08.10.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 10:24:30 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 22:53:49 +0530
Subject: [PATCH v4 3/6] drm/msm/dpu: check mode against PINGPONG or DSC max
 width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
In-Reply-To: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791480250; l=7600;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=SoUrZtDdfCIg7cHdHI3j74ftpTQKK2sn+ia5hDc04z4=;
 b=D3aN9Ht5vEdVwU+2oX5rmxK6vh9lQrH1Og3qvWSmriXAe3ZAKlUpBzYC9PEDA9nusrFm60cLs
 aapEMa52mdXDf3EHejlSRsQWiaM+pVniAvPlW4TMEYaQ+PAZtUzt47U
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfXxhrMLlzlVPXL
 1K/q/4nl0DR5xP1e1lAgbYyNBC8ZCngpJoOqCQAfF5ZUQs2rEkiSLJN+VNFPouTNIYa6BhcOGa7
 vDEPkYDYqT1ln4d08fL5fb1izO8f5ZJz9KwjQ6Xq6tdCvK7fcw87AtnmGBf2vXK/oFPwcGZBEK0
 wutQtzB5HGnm3ns/k1enatP32tTdYtLlZoSnpbiYt00dBM0iNvoMQ33bFBnvs24qcWBdlYwYGcL
 7Ykjw1vT6ZsKU0ls6++JM3lFMPUqRDr2etPwmoaJuET14j5hy7oROS+3ODY48FBkNwSOFJGgUvP
 AKLEge7+Iy794s/jngcycQaTIWXs3zuOFkQq/rsSs5nqh+7Rj8rwzaftOW90Ek/5zdqpzNvt7D6
 w2hAQRGp8/aup5voX2BvCTxKfpT0Ox27IJ0DhV9+lnocws6jtY4pz3u0SHJCK1z4J9g0St86BS0
 eultignxbEbARvxUAdw==
X-Proofpoint-GUID: xrcCudm13ZcbZLMT9fdVXf4CKPdNI7RP
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac7d1d0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8 a=9XmeLrvlUzp3IjDgX5sA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: xrcCudm13ZcbZLMT9fdVXf4CKPdNI7RP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OSBTYWx0ZWRfX0DCepoUpcJvu
 mAlQe92L3GbbmO+EkoUp5Vh75IO+8/zRayxPklIgMx7MuXKjX+HDD9gedkmt6QJjuEWxJz7Iiy5
 6JHl+7zNpCXbTkRkf7Cf/TFkEuWwmg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080069
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

From: Jessica Zhang <jesszhan0024@gmail.com>

LM block doesn't have a hardware buffer (unlike PINGPONG and DSC
encoders). As such, don't use ephemeral max_mixer_width and
MAX_HDISPLAY_SPLIT to validate requested modes. Instead use PP and DSC
buffer widths.

While on the DPU 8.x+ supports a max linewidth of 8960 for PINGPONG_0,
there is some additional logic that needs to be added to the resource
manager to specifically try and reserve PINGPONG_0 for modes that are
greater than 5k.

The layer-mixer count for a merge-capable, non-DSC mode is chosen by
dpu_crtc_num_lm_for_mode(); feed the PINGPONG/DSC derived width to it as
the split threshold in place of the removed MAX_HDISPLAY_SPLIT, so the
pixel-rate floor added earlier keeps high-refresh modes that now fit
within a single PINGPONG buffer split across two mixers.

Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
[DB: reworked to drop catalog changes, updated commit message]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
[MP: rebased on msm-next; fed PINGPONG/DSC width into
 dpu_crtc_num_lm_for_mode() instead of open-coding the width test]
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       | 54 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  7 ++++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 209b25dbeb6c..41f986ca2a68 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -758,6 +758,22 @@ void dpu_crtc_complete_commit(struct drm_crtc *crtc)
 	_dpu_crtc_complete_flip(crtc);
 }
 
+static int msm_display_get_max_pingpong_width(struct dpu_kms *dpu_kms)
+{
+	/*
+	 * Note: While, for DPU 8.x+, PINGPONG_0 can technically support up to
+	 * 8k resolutions, this requires reworking the RM to try to reserve
+	 * PINGPONG_0 for modes greater than 5k.
+	 *
+	 * Once this additional logic is implemented, we can probably drop this
+	 * helper and use the reserved PINGPONG's max_linewidth
+	 */
+	if (dpu_kms->catalog->mdss_ver->core_major_ver < 6)
+		return DPU_1_x_MAX_PINGPONG_WIDTH;
+	else
+		return DPU_6_x_MAX_PINGPONG_WIDTH;
+}
+
 static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
 		struct drm_crtc_state *state)
 {
@@ -765,13 +781,14 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
 	struct drm_display_mode *adj_mode = &state->adjusted_mode;
 	u32 crtc_split_width = adj_mode->hdisplay / cstate->num_mixers;
 	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
+	int max_pingpong_width = msm_display_get_max_pingpong_width(dpu_kms);
 	int i;
 
 	/* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
 	 * before even checking the width after the split
 	 */
 	if (!dpu_kms->catalog->caps->has_3d_merge &&
-	    adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
+	    adj_mode->hdisplay > max_pingpong_width)
 		return -E2BIG;
 
 	for (i = 0; i < cstate->num_mixers; i++) {
@@ -783,7 +800,7 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
 
 		trace_dpu_crtc_setup_lm_bounds(DRMID(crtc), i, r);
 
-		if (drm_rect_width(r) > dpu_kms->catalog->caps->max_mixer_width)
+		if (drm_rect_width(r) > max_pingpong_width)
 			return -E2BIG;
 	}
 
@@ -1374,17 +1391,17 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
 }
 
 #define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
-#define MAX_HDISPLAY_SPLIT 1080
 
 static u32 dpu_crtc_num_lm_for_mode(struct dpu_kms *dpu_kms,
-				    const struct drm_display_mode *mode)
+				    const struct drm_display_mode *mode,
+				    u32 max_hdisplay_split)
 {
 	u64 mode_clk;
 
 	if (!dpu_kms->catalog->caps->has_3d_merge)
 		return 1;
 
-	if (mode->hdisplay > MAX_HDISPLAY_SPLIT)
+	if (mode->hdisplay > max_hdisplay_split)
 		return 2;
 
 	mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
@@ -1403,6 +1420,7 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct msm_display_topology topology = {0};
 	struct drm_encoder *drm_enc;
+	u32 max_hdisplay_split;
 
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
 		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
@@ -1410,6 +1428,19 @@ static struct msm_display_topology dpu_crtc_get_topology(
 
 	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
 
+	max_hdisplay_split = msm_display_get_max_pingpong_width(dpu_kms);
+
+	if (topology.num_dsc > 0) {
+		u32 max_dsc_encoder_width;
+
+		if (dpu_kms->catalog->mdss_ver->core_major_ver < 6)
+			max_dsc_encoder_width = DPU_1_x_MAX_DSC_ENCODER_WIDTH;
+		else
+			max_dsc_encoder_width = DPU_8_x_MAX_DSC_ENCODER_WIDTH;
+
+		max_hdisplay_split = min(max_hdisplay_split, max_dsc_encoder_width);
+	}
+
 	/*
 	 * Datapath topology selection
 	 *
@@ -1438,7 +1469,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
 		topology.num_lm = 2;
 	else if (dpu_kms->catalog->caps->has_3d_merge &&
 		 topology.num_dsc == 0)
-		topology.num_lm = dpu_crtc_num_lm_for_mode(dpu_kms, mode);
+		topology.num_lm = dpu_crtc_num_lm_for_mode(dpu_kms, mode,
+							   max_hdisplay_split);
 	else
 		topology.num_lm = 1;
 
@@ -1619,19 +1651,21 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 						const struct drm_display_mode *mode)
 {
 	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
+	int max_pingpong_width = msm_display_get_max_pingpong_width(dpu_kms);
 	u64 adjusted_mode_clk;
 
 	/* if there is no 3d_mux block we cannot merge LMs so we cannot
 	 * split the large layer into 2 LMs, filter out such modes
 	 */
 	if (!dpu_kms->catalog->caps->has_3d_merge &&
-	    mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
+	    mode->hdisplay > max_pingpong_width)
 		return MODE_BAD_HVALUE;
 
 	adjusted_mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
 							    dpu_kms->perf.perf_cfg);
 
-	adjusted_mode_clk /= dpu_crtc_num_lm_for_mode(dpu_kms, mode);
+	adjusted_mode_clk /= dpu_crtc_num_lm_for_mode(dpu_kms, mode,
+						      max_pingpong_width);
 
 	/*
 	 * The given mode, adjusted for the perf clock factor, should not exceed
@@ -1641,10 +1675,10 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 		return MODE_CLOCK_HIGH;
 
 	/*
-	 * max crtc width is equal to the max mixer width * 2 and max height is 4K
+	 * max crtc width is equal to the max pingpong width * 2 and max height is 4K
 	 */
 	return drm_mode_validate_size(mode,
-				      2 * dpu_kms->catalog->caps->max_mixer_width,
+				      2 * max_pingpong_width,
 				      4096);
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f45faf87333e..71e1a404e25f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -24,6 +24,13 @@
 #define DPU_MAX_IMG_WIDTH 0x3fff
 #define DPU_MAX_IMG_HEIGHT 0x3fff
 
+#define DPU_1_x_MAX_PINGPONG_WIDTH	4096
+#define DPU_6_x_MAX_PINGPONG_WIDTH	5120
+#define DPU_8_x_MAX_PINGPONG_0_WIDTH	8960
+
+#define DPU_1_x_MAX_DSC_ENCODER_WIDTH	2048
+#define DPU_8_x_MAX_DSC_ENCODER_WIDTH	2560
+
 #define CRTC_DUAL_MIXERS	2
 
 #define MAX_XIN_COUNT 16

-- 
2.34.1

