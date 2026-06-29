Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF4BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AD110E8BD;
	Mon, 29 Jun 2026 13:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXD4p3Ff";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ODSPcc8F";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F4A10E8C7
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASwbc2603483
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=; b=LXD4p3FfREkNRX/F
 UA6Pi7zP//asvGH4B8W805/udnuOB87lMDGMhFuhgzt9I3MTz3J1TbkwG9gFCR3K
 GzyL0nACnTHp9eoWkYx/kbgmCMCbsu0aNIYSNZsx7paXO6c5dlt7AAFcZXP/y9p6
 7G7GanivRCwD/spAYEMtVnz8D4+hC8/QGPzZM0FV4obIln7tzoNAuvilFZmboT4h
 g3oMhKnPIZKEr7G9iee38iC8TQVMgNhPSxE9thkekD8mYb7BrH8eglIgniyk1Yr1
 Rekioe9ETGPckIRjWWia3ZiSoJQtNdIYbDcunUSTL9gCFylc+uEeetEMCVmwzDgI
 OoleWQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88y34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso34838026d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739082; x=1783343882;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=;
 b=ODSPcc8FC/w6o76beCNDGSg8NDp8ju5oct5/s1OtgE9StrVsl03YJnjVKa3gcjCHJ1
 mPC0Nz24kRRDx27ZUdYdVwTBkEoFauLzShnby8RkEve4IVdQY702tWIX3eoKUsb77zCS
 fTfocMQkORQc1bOV6Gx9JXXnOHjRl7NsGMnDybMPWPlqaEwHr4TRg/YM73pm8oP83yic
 aLvYnbuV+boBWTLXDInWm2Vz/lUdrPdHf6XhwkUS/FXaPRGPSoPdbD2G0D7ZES7A69I6
 yg7O+neWTl0OwbhX6dygXic4D2IeQZQa1EzirPdJ7JyrNwV6rH4pZxmNYz5TGQYpezyU
 BH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739082; x=1783343882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hZJyjmKYjOSNQb7RA0taR2J0lFRDRngR4/4RIKL4IXo=;
 b=fAu60WBWgLIgIOJB+IK+F4ltwh1R/dAYQSkqyPsrIOF9oWEuNq5kL38YrpNqBYaDCO
 MO46Y/w8FGEitwzrLh1h1nPIiW1RTE2lRmJ6fXWc3T9yBnBCQVSaZuz3nXywM2Me9Zwd
 fdMpPfLf8jtzf/takiMe8L0LWuBX7E+ZQ18T7RZeEOq5AbcRmYGIX3RfdDVTd338u6kW
 9mJH3IzD2603olu4j85syiyzY5NKCdX3BSTBiVrMczjJIck6aZLwjXhEvE9KjiVYu0s/
 iwBqpux8OJOjcq/UoPOEoM4gsZDrRBq/aWGLm9iIJF6uql0YtB4K02/W1V3P9E8rFlgP
 EYqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoX3KE/AEUhcjGvwn/e/5SqA9SgdaDdYHpOm66A1/pmYGESFpYXzb5kcvycZskvOEVImB3zHSeZtYo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSWKmSERRRYebwm6WES/8NEctRlSNXKw1EZN+lNAGxwz1jlYzv
 659w5yoX9WO4aWzawK9CWw9aOh3tA/G9ctgzia9+bHLxpsXl548nxyu/5LqoVK+/+1/zZhsJqJ4
 NSGzLEJl5L6MqAxeOMKrYIN0GHs1WwMjN1oICyhEbyFfuRswuzf4EtPBjJUwTa1JNUBnzNuQ=
X-Gm-Gg: AfdE7ck9brBaOfoRtJZjxSZ1w59HPHWbJZexBslu2E5QySuSVrv9MlLfe/hSHk1Wc3R
 RHPsrgF7V3uhyQrsLWpQg7MJeZ+qCrpBfA+tLyIANKm/z5daTKw2JuSY2YaVZhVFR4azRJcaDoo
 aKtvQxfo8HydGBbAdbejm5roYbg7MfyvTdXZ8XXiRpOmTf7ew22RqpUp9+FbYxVlfpGG8PYRdnr
 r5lMBdiYWh/2WKhnFj2yBUi2ojNV4Zv7WmRyRtmru4C4NVarJi8XmB2DrPTG4mTx+L6HJQm2ezu
 xjiOMhwf2pKeSUP7bhHRJ7Hs7o9s8lyoj660V0mjcflZHTLcqngfS2DwQg3Qp4baMy9YdTmzoVy
 lid8HiWn4/LP9eVf3hScAvfRnrvvvBAL/psi9EcfQI9o0u3ENXXblASLvh+ViaRsc2b/B4nxXzw
 ==
X-Received: by 2002:a05:6214:e6e:b0:8ea:2d6b:3b76 with SMTP id
 6a1803df08f44-8ea2d89c091mr155405576d6.46.1782739081940; 
 Mon, 29 Jun 2026 06:18:01 -0700 (PDT)
X-Received: by 2002:a05:6214:e6e:b0:8ea:2d6b:3b76 with SMTP id
 6a1803df08f44-8ea2d89c091mr155404696d6.46.1782739081215; 
 Mon, 29 Jun 2026 06:18:01 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:00 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:36 +0800
Subject: [PATCH v5 18/25] drm/msm/dpu: initialize encoders per stream for
 DP MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-18-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=2431;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=M8HporrHR4TroPqsNLp1fnzaVZtixFKytOyYesj4iZk=;
 b=ix3HGmPgzOprW+IcRYXLdICj5VmiNH9m4cqwJK+Et2GLwflHQXvf5vLuZ1VCkjB7FPuNMMHc8
 HQcUh0OIwGVCKGy5w55oS7c2m/ocqUWwYAQap4v6/vT09BTfnAv1Q2m
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: buooMzRVS_1rWUBx03adh_FJEpnvjJXB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfXwzWvFM9N0W3x
 KGKDQ4NhZaTqKaqhMtcvq12/6CEdaheIl/xtVDwr6ESTTbP/6ABKE7x13r9gX2y1Gtt9d9dgc3W
 uuiMS+ofGIuA35suRcphG/Dt+E1D3YI=
X-Proofpoint-ORIG-GUID: buooMzRVS_1rWUBx03adh_FJEpnvjJXB
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a42708b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CHjaKMol-vWaWBnFkvwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExMCBTYWx0ZWRfX3ZLjmrcbOBM9
 5R0HWC2qODy1hnsNsvYOsW9BBGrY+kv95QjQjRKi0rt6U4U9BdqMud+davssd80AESdIIxm869Q
 t/9TB+KzqmUnlyVLS8JYdOLPOtQYy36WzfH+u1z5RYOMc20XT4ikpJjqvJBZmgIFEI2F0KW4qXS
 X5HfHwKjXrz032AE5SvlzXi9DXgMgnGzGh0FxGnx92FrjEOQZ/CX5klDdHgOk+KJak/hpZ0Zz0O
 ikuMYsAqFKhO+rBKoLOePoWPFMCzNY8cvoXVRtzDY0kiJKN7t9eiosmMNr43JEm+JdC6U9J+eH/
 GnCkMZTQ+3e+rRNsWotEtyj4uhykbfAWJkTXhPmq/fJBwD8iNtyzMssvW5hUbfnlUwiXDd4wVt0
 Isd3p4p3Ndf2CkMp18l9MAmpmLR9bfYoih6QJXZN/+aAIBxg5YRvX6hTmKZZqQJ9aaMd1T5+daS
 W4dOORoQHSdDVb7uMUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290110
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

