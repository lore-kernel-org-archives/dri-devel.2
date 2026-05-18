Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84961CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC89110E9B9;
	Mon, 18 May 2026 19:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MATGCAfT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgXGLz+f";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3660C10E9B4
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:28 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IIvTEE2482391
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Rv3QXoFqyvR
 3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=; b=MATGCAfTHTjmD2SefqkP28NRyIS
 2jeDDNN6lFidk60hs8kkWyKDZsKE6GmUVyQcUHXmVvyZC8BwS+ttmyD4j6rZ1NMb
 2VcqgH4v3u2mC2+cNk0ThhD9jvOw74TvKUhrAYUeCFyBDgt2aTqeZE7x59EkOJAS
 8wDvsaWa0x52Zf90ABI0zMY5SFOrZUORbeat6pUSdi11d/CGvLU19lEUd2hM2EYv
 D4ZoZ8fNkkHhVMPUKYdukPbBvssqIm9aZz5W4fFhuGcUpxLH+wsj+qu0ScFGS00b
 Kw01RkRPFlPuwXMDM2VFcHQbL6TIR/sFr695G4CgWSImq36he+o3KtBNNDQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvhrwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba6fe41283so28038785ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131306; x=1779736106;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv3QXoFqyvR3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=;
 b=bgXGLz+f0/ZuvfcaEYBZf7rTDacMufejVWbQrrsg/AJj4JHHdOZMSzDAR8vtKA3tgW
 +1DsL1ubZ7JMY4+lUVMQCuJk2ZPkj+/G6cwVZJsbUZRJOT/Qig7dHpPkpb0tsaxowk2r
 ARRrR/bttV8xKeeSwI+55HSs0g7oO9pXB3EnUql9wA2D9HWouksWDpQEdHuHtMitrjDU
 Qtwzod8WS7akMJPlP/7KvV3LOvyyAont0QcL8kyL8G8XnMhPWd9J0zXnAwJMx8alKwod
 UU3TitprqUv37I2RpDI/+j082AiWeIuCcEiJMFn5EUl1sujRTUdP1KcM0Hps9+x/6dux
 cqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131306; x=1779736106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rv3QXoFqyvR3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=;
 b=HJbTz26mMIkmuI2QsarJeXTGe6eB37L+Qol6D04o7ZcH3lnMd1EOEC7G7yCrW+caMi
 8+8z3Sf07Wxc/EsgWIdLAfSa9aNoCEZaUxNB/B1H4Sz9kf4UBvrC8KMr2qzwsmn9BR+b
 TTRCOWnXbu/e8vgetW5j44GTZzhrq4X9MeVsyStF6eK7zjWFfiHl/fBnUNWxMsYMiDc9
 7aSU7uOGPmGFa2CRm4uK6bMOibxy4602piujGyfAAPZXUm1SylTMIxooW+u8h4sVkfKy
 lm7sflpL4++ozqaeTo994COxN8fd4FrmEIHwImJ6zYRLgDpGLFVwwywuhEvFY9tYBjKS
 lOsQ==
X-Gm-Message-State: AOJu0Yy/QaIB1nPKnW0R+QcMLLWqGklkpyIErRfproB8l1IwDTKrRrqD
 OW5m2HcjknABJkj8xrg46+/SVr6PDZeUt7OuA19OgOQC9zLV0GRfKT46/iydNR0xlX42yWZ+xuH
 Kyr8Yx/g9JQdwxl7F4Cn7ltxhyJDL+yZn961om8jvjaa1eOUCgPgXbjEDZ93MH49fXWBsQ3xkC9
 IKGbA=
X-Gm-Gg: Acq92OGk0PRAgCzi0nvVWiHzQbRaiH9n44vYFC7SvLZLoST/fx6C/NZlTvLjYz+/ZDU
 XxmkoyezMFMbZRhgcp5uFehhNciwpsed7qCvxhWymy4lvpNTjuqlX6KyOcfy9jSdUSHtWgCNMZd
 /L/f/iQQeqK+Mybq3MkUHWke2R5vSlTWX8zJ/kpeoo1tOz8bWHD4a1LAD9E202m9cjfweMYQMMU
 IFU0oSFqZz68t90zmJ4+C3YEfwyVoutt1obfLeEiyf8ndGM7ZN7Hsi/AiVQAUpyACJJ5TR6DG6b
 I+ZRvXhdxiI83opULGHYoUjiLkeqvaKXJcA1UqKnnadknymgyxdlk4TQtO/De1Jh7RUCE3K5uOR
 7jgMUSx3wzal3Jd+GyWC4Eou0k2ddEe4b
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2bd7e85fce5mr174141005ad.6.1779131306222; 
 Mon, 18 May 2026 12:08:26 -0700 (PDT)
X-Received: by 2002:a17:903:1a8f:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2bd7e85fce5mr174140625ad.6.1779131305705; 
 Mon, 18 May 2026 12:08:25 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5f2dcsm157769815ad.13.2026.05.18.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Mon, 18 May 2026 12:06:39 -0700
Message-ID: <20260518190735.16236-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfXwRVjIzZOFz4G
 6ZOMM0kCBgT/6WDS60YJ1+qbYT7KneSK9tJIBm2H1VNl3YTk0boksSyv/f5w4Mw0ZIdXBR6Pxsf
 InET0YudZvPt/J69FPt3DCUDyhPgFIHrMcdqQ8/Kl/o3mqtFLHK0ZaLpibbKdYbQA/FZxPEH3ej
 A91jQfzXmZpFHOQVReo7R1jMGPedrISB/R+RApVqMIIUBe8bKRTajCf2nKFXm3IMyMzeOkQ5WTF
 k5kMg6tTpo4VoHPigzJNxz9/pvvdwS6d0mRjHLC0eSItRHrKDzbS0KcBQjm8S6smyQP2g/HTI/v
 B+I4LUrsWKc1GTX4BE3pZETL/uyvA9d8SylZxu2Z0ooDID+oWOgFKO/TPHVnPJehS5esAq9Nhu4
 tbwezM7kjnkBi61htksFvKPmlotMRSpyKqfYMbNUOWC3cWSU/+Iha0Ric+OnE2Gez78XHGhCLj/
 jRK5uSJ+EShQTghJUFA==
X-Proofpoint-GUID: WSjrgAaSALNfCZ8a-GBdDXWrn8xJ_coF
X-Proofpoint-ORIG-GUID: WSjrgAaSALNfCZ8a-GBdDXWrn8xJ_coF
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b63ab cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-43u8CF5Pkpiqpb4b0A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180188
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

With the slice architecture, we need to flush the slice and unslice
counters to perf RAM before reading counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 30df9bfa9ef8..a329d20033d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2921,6 +2921,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 		.perfcntr_configure = a6xx_perfcntr_configure,
+		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 99c3e55f5ca8..3491a24a9320 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -334,5 +334,6 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu);
 void a8xx_preempt_trigger(struct msm_gpu *gpu);
 void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a8xx_perfcntr_flush(struct msm_gpu *gpu);
 void a8xx_recover(struct msm_gpu *gpu);
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 124d315b2469..6c040f718176 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1345,3 +1345,23 @@ bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	return true;
 }
+
+void a8xx_perfcntr_flush(struct msm_gpu *gpu)
+{
+	u32 val;
+
+	/*
+	 * Flush delta counters (both perf counters and pipe stats) present in
+	 * RBBM_S and RBBM_US to perf RAM logic to get the latest data.
+	 */
+	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+	gpu_write(gpu, REG_A8XX_RBBM_SLICE_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+
+	/* Ensure all writes are posted before polling status register */
+	wmb();
+
+	if (gpu_poll_timeout(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_STATUS, val,
+			     val & BIT(0), 100, 100 * 1000)) {
+		dev_err(&gpu->pdev->dev, "Perfcounter flush timed out: status=0x%08x\n", val);
+	}
+}
-- 
2.54.0

