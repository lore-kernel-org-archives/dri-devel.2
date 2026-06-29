Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F36C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC40010E932;
	Mon, 29 Jun 2026 14:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrtZ5hlf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUEsPx8B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CB010E932
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASqWs2601114
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=; b=GrtZ5hlfGt7Fo2jH
 KYdYhZagYISOsKafHAae+WA9W7lZts5Mw1ZKnG1jrRwowQ3eN7wNAhrk+GWMidfa
 87C5jj/fs/sfmMdN3GZGf2pqZUOAnB87raPfHblefpSs4kT3hfvv8iBEZUI2mZYq
 hcEToKorsc5BoYX1k4i0JU9Ll8Lf6XYkc0VPnR7BzsUiS7lKC7imXzhZFuACwzF7
 SGiZykKobnMqTJKZe4bndiV1Ga83K8J8qu7Cthrs0V+zQKfhJ9zZwCpVAqwPIlUt
 PZlLjyD/1XgBIvOqNR2x32YswgajN5Dof4qAFea0q8ZL7i1QOjGMHFMGqec7pgIF
 dU+Q5A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw97s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bf25c2c8bso33127881cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742599; x=1783347399;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=;
 b=UUEsPx8BViJbbEbM1EMspSSXnVnBCRd70fY8bK/xx6kp9T3EAVqEkMXGBpjndugq9/
 5GL8g7FFcaYVUaJ4ayBMxje6AtlJNz5F/xWeeMwl/HbLM8aPOwZUnxR4CHhy4AheeOU1
 ZXUtNtxB4nN+r08akns+Su+Ff5wYK+NknOwnpA4BKuW6yTAGhzeHUyRwlH0SnfuLY6nV
 s/acPI47KBL4LC8zHZgZcb6iigEiZKqi4FkBDWRo8Z/yegfhNO46pGANrdxLoVZitxZP
 Ag7AS3i1Pd1ziNR7g8ymkj3ET7OA/NQzjnX039SP2r6BiIsUiQ14ZcIEa7PpNdJFM+mS
 k1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742599; x=1783347399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=;
 b=H29L38vs+bEpecLNunibDaHpKNuMbCnr80LnH0ul+Evdq6zwir7w0vrJMRLyucIASF
 oR3cGe+z7c04SafPY047l+IsI+cZhOMy5ditV+W4r9rFUze/eFhQbIlEzUrOhVQUBYH/
 LbQE/WxOoq1wB93SfrrXuyIspAo/hMnYinMi+q9G7kJ2ObhjBsOdC3YmqlGcz8laMKmW
 0HxwGbV+2w4RKlc9tcTq4H0oxNinxV4cXwwXyaUpYHYTItegekitAPYR6mvo5Y+c8ynj
 OUedaAxHsY6lKD5zz8DbjTbeTQZ/r4hIpGBD1HMRAO2ovu1njwewL8F1/Jo9flSj3hb4
 +fbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CRKB3ya1bDWWhBTMTprmMgBaSWKhH7KD0FsMsAQ1D76YQ999LyvXropIANsJuo9Oztf3Gi09RI+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgBNT+rf7BR1lfkx8k5o3+/6EzyDwakafbCRM0SA+7frh8wriA
 c8198axNK23RazjrS4J4x0D0nQwtJtbvuyXuJAMlmrCv4vy8Hg5jeZZH8+vOaecFOUndmhXtHBX
 XpwOYn6DenA1HaJ8aDGjK0UPbqFAzRo506aup2KTDKl4NGxB1KOLRPqvEBmL/GBo4KfBjP/s=
X-Gm-Gg: AfdE7cmj4k+SUA6maR4cVEzr1qRHZx7jsVZ/iei/apX1A+ykBgyc7VDpQgSdhJzLRoY
 54ZDyUvWAPMfQ2NPZP4MEkX+O0eLcEuBO832QVUui2153aP1LubLoMX4iHW300lCiXQNiLkO5rr
 3la6Mn71QKeiYZiuT2IX7EOylSqGnAnQTEYpngXltZJkmuWxt/npXoQasC/OTXI108U3cj5NlM1
 gyI3solQ+Iv4S31tnZB3xR5NsGl8HASw1sQkiNNA6czNdhFjNYWbGP++pcnoEmJfyF52GhqcWnv
 Uj7SLD+ogzLutpQbHXlZVeaeDfYg/J6WfxSrLO5z6A33uWb+mUEYWfv/XzcslUTxK9hxPDnXKlm
 lxw3m8SxzYn4q/lt2PRBv8jIpt6bLUaUgWNmH9W95ScQtVrFFv0OXEgU9AusN9saPXLcp+w==
X-Received: by 2002:a05:620a:4409:b0:915:8502:f7fc with SMTP id
 af79cd13be357-9293a6b149dmr2490993985a.16.1782742598581; 
 Mon, 29 Jun 2026 07:16:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:915:8502:f7fc with SMTP id
 af79cd13be357-9293a6b149dmr2490988785a.16.1782742598029; 
 Mon, 29 Jun 2026 07:16:38 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 18/25] drm/msm/dpu: initialize encoders per stream
 for DP MST
Date: Mon, 29 Jun 2026 22:14:39 +0800
Message-ID: <20260629-msm-dp-mst-v5-18-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=2431;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=M8HporrHR4TroPqsNLp1fnzaVZtixFKytOyYesj4iZk=;
 b=lIVxLBznHHgdMi6x0uKdG+bKoS0Cn3KqoZrNI2q82E5yBFPEaiWOGengt+Qhfx+QPw9ePWBkW
 dm9FD0D9McxCYC3FlVyKh2eVWP7U7ptF2zGAsynxKpcfiJnCadTsdBn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX49LfYrd0pnQO
 dDd8m19A4wG/6Nr55bNGPRsuu4w2JlyRn0LIllGA54LdUfIfLLVODmuFE41LyoMCguLNHnbvtIC
 RTh9xfdXqip9RNKe5feDqcguo/GdNGs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX6jgRlcuUkAXu
 PWOWo6AGuqzMvEjuhvLvviqMgStlxPys0AzYVKPjyktYFVIy3VOhfcnhVTo0lljFJwA4P+YAMKF
 E3UdiTn+TrT5B4MqKNdGCnzbYPxMVprwvhGb+2xTBBfV8rOo5nc+0wSYl3eQSKQNVPar2jM9Ll3
 lN+ceHJmReBWvut25a8tZUXBjsNpHMKQaBlReDGMBCqit2b24lQuA827hC9zZ/BIuqDDsHT9oMI
 K+YvmMqvOgD8eMfPmr39wTjHYMbpmnit9udmSEQyPQbLWqznlmgRPwSo9jq1p8+r5fsU9tgBT5H
 h7jXPN2LpWV8tuXd8x4cAeG9y9aHYglZPlxLspS1bhzvkJfciukCGFpUVGlTXbCFX2ouefuYCqv
 zOjPl5bmVwHi1TQJZHf6XORVD8TsDCEiTQI9dgf+QeDRo4n2sfGRGYoyESicX14UioA61LE5KqK
 Ba3EF7qFvgUDScjdqeA==
X-Proofpoint-GUID: V0ipGhhfdw-FUytsr848rDQEPAr2S9Iz
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427e47 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CHjaKMol-vWaWBnFkvwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: V0ipGhhfdw-FUytsr848rDQEPAr2S9Iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

Simply initialize MST encoders for MST-capable DP controllers, and
introduce msm_dp_get_mst_max_stream to query MST streams.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h           |  7 ++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..7a00c4094d5c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -655,7 +655,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 	struct msm_display_info info;
 	bool yuv_supported;
 	int rc;
-	int i;
+	int i, stream_id, stream_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
 		if (!priv->kms->dp[i])
@@ -678,6 +678,18 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
 		}
+
+		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
+
+		if (stream_cnt > 1) {
+			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
+				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
+				if (IS_ERR(encoder)) {
+					DPU_ERROR("encoder init failed for dp mst display\n");
+					return PTR_ERR(encoder);
+				}
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index c3fb3205f683..5fee0b291059 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -355,7 +355,7 @@ bool msm_dp_is_yuv_420_enabled(const struct msm_dp *dp_display,
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
-
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -372,6 +372,11 @@ static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.43.0

