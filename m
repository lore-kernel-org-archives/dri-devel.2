Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D731CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35A510EE55;
	Wed,  6 May 2026 17:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XLE1UR0U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dASrZK2J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED41810EE53
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646GPwRY1953203
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zVhhihIWGcW
 DVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=; b=XLE1UR0U1ox71RUTqMrXdR/MhJg
 MZKzPeWb2r+lC0pPE4ZqOq88oZnQLzqp6s9N3H/2P3tT20cyBeMNmpx/Zo3BoZi4
 1pDscUvTDAvXyvH1oGdFT6q4HgTVjYjJyqyU+RDWRcy3RFrB5yb5R/k3O2trb9mB
 4KKzMbOQonKFRZa2RF/rETtnG/hgFhjWfVsAOQ7nGOvTn2Z4zcZJGYD+TEKPUh9b
 I5UfYvfyJBA2lGYt86QDxdLa7bXpmE50w+bpEsikcWKG2cWmr633WrM7P3w5Y0mE
 Mj3PrxTqwii/pip22vyUOvl1HrJnym8QWgbc4r46vTi4Xp1XTwlzA4Jymdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc1mkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9a6d84522so106456035ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087530; x=1778692330;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=dASrZK2J/zWVbi7JU3x+hfgOaxBTJbhNt47Lm1FypJ844ndT2I13laAzllmRZJPIZ1
 ToKecPaudr7+o1evOmTN2lJtPOqmGDQE0VOJg6Ny0DwCVXOhnJdNiIXNH9+Fdc6nLG8L
 2yVs0b3+li7FWcujRUCtzj2n1nflE3w7BUnAV/HIF8X0h2kUOqgjOIayibSeEASv9Add
 Tb8YuDm+bfQ7rl9A7Ky7qtPV6hBZhUXbpFVYyTf6WlLc31QH2X8+dxTv0lOGoPAhN/qC
 PgNIn/a1eBLIgYcF0IO3Qr/oZvbhkHV/xcUb/eO33CTD42/TzdbyRoGtzuXzaCz0ykIY
 /qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087530; x=1778692330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=QRO7gyO64s2DnA5ibarkdir8/AfthFBq3S+kEImm+/Yaa4LnekJPYUl8ij+hEHSDE2
 VnSRTDFs0xNCpThFYQ82m38qFlz+ICHr4YZIQL5Rgay4rkw0Yu9ccAHqT+Kb/1YnWBxO
 xTXIiB7d7AlsXcbFgO4sQ6ntv6Z6PmXQrAJqYCm0ttk39OjIvY9zvktp1xNLkqJpyoO2
 jQO1hxnWb5Xcj4BUJB7tC+yofSJSiPfNA8q6m/bpEvozNPThHd3Hu+EX0itVlI32y5Dt
 7rDUHOtVm4h4zdCGlHc4KdMidwk1Bwr3ZGShtluwpq4kQHZK/p3jwZuXqlHvJwwfSXIm
 wN0Q==
X-Gm-Message-State: AOJu0YzCaK6qecf69ECSNDugOZN/78esiRMhH32OjoX4N9DikASZee1h
 pvUgMVhCvS005MEnt2aMdclsEvne+ZPHCtIcQpVFsxR8jsJtyTazdVzdnI5mHBCebKf5j5FcbgV
 WLk0zJx0RPD4Ib1x8+TP13rx0Fzyi3OhypL6ap2D2oojrO8sLM3b8zWVxX5w3fHb6rapd9JX2VK
 H6yKo=
X-Gm-Gg: AeBDieuWAPB43EK4XCvc/mbgF8jqS4z0PsRulFAs20nJxJ7WtACpmjA30noj+2Jf2z8
 SShb3MLd6O/sL8zfm0NwDuzlXhDDXdi3T8gHUDbr069lhs7nOHzXH828DapKjtT7IdghLRh8uD4
 NVJB4OfPUBvTWC7NmU1//JjkEgAwga9Krb3URQC2Nd8ibl0Ldipks3WjQHNtoGgZlR3kE6QjS1C
 C5Kc/IIgYWZ5OyFZgxbCX9lAlOpPln0O0YWJxwiDu0ZQp23p4Rp/5U71y+xg4zDpCkaqPj7cI/D
 39QAR+rah9b7d7rMTKSvBM1h71WzpEE0XuD1dBun2agh1Xg/PjYHkxgHnZa+DeBvOmO59Drw3gK
 B21ZThsZlGdkoxIwQMxAgZiv7ShYzbDeqBa8nSK62psc=
X-Received: by 2002:a17:903:4304:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2ba799d6c69mr27041955ad.39.1778087529571; 
 Wed, 06 May 2026 10:12:09 -0700 (PDT)
X-Received: by 2002:a17:903:4304:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2ba799d6c69mr27041615ad.39.1778087528813; 
 Wed, 06 May 2026 10:12:08 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca105desm32185495ad.55.2026.05.06.10.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:08 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Wed,  6 May 2026 10:10:36 -0700
Message-ID: <20260506171127.133572-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX2YdtC5XgDMls
 B8ejYdS74WcLXbxuDCOAbpzv3P7eugaBgCSpc4sQPOpSZL4NXIehT7pC0zOrgYsRqg+igZNsoxg
 lJ6JVzA9xKeGPhGpFQLr5Ex0tr4XDHRzeecypaWlo8YBMu6AegPCfVEVGZ3V6c+ippG6CgcAC5c
 DNU5xZWuSSkuLDzM8e8dOliAejqSQzPC9htapY83lB1JQXuIv7CnxynLTDco9o7zrLxSV2cXRfr
 NDHlJ8rIuQkhufNfWO64wCoFxz/61SjDMSFtm2e29flzBtJAKT1JgxJPMfwMXJUIFHYxS8rWGUQ
 CtyfEkHKUR/HPR+UQJ546oct9+Hwaac9MRi32bL5G2PB4u3yTR6sN0kATZqwrDudlQff2G20Tyg
 tnM3DWEjaZPayQajJo/gnmF3MHuiR3RKpa7WiN1vUXXR4VPrmbWcTWyrkhMzXcjE34k5W8Soo+J
 qLdCSZYgAPxM3yrLbFg==
X-Proofpoint-ORIG-GUID: YV7OUxPQwqxALLk9g11yLWkdAKVRyzBN
X-Proofpoint-GUID: YV7OUxPQwqxALLk9g11yLWkdAKVRyzBN
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb766a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=W-43u8CF5Pkpiqpb4b0A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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

