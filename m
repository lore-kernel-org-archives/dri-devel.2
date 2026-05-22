Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006C9CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EFF10F6DB;
	Fri, 22 May 2026 17:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m4+/v4X/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XC+5qPQ5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72AD10F6F6
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHH3aB3947391
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ScHhidnB094
 qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=; b=m4+/v4X/o4BW7Ls1MeaOXECwwcV
 i6E2CAavaSQVwn6N8aS7PORfO/GELoeUzsLV6dI+MQgfeI1Yg/fI5P+NyaH0/T13
 IfUpkd/Od4Xe98YE2x0ZbW2ph8RBwiC5j+R6ddDnlAtUEUsFxMz83o8ougFi/Qpt
 FfO+VLNHiVSUj1Dy51oo3MKHqiOodvATeL9UtiDyL0epGW62pybCASUh+NIyVmvC
 9SXqwFa6ePyTKZJB/H46KDf2b7yJCYBMnReVH93RgoSo5ctGr0OmuHOYbOf6M3du
 CXvKfV1fCuQ7b1bPcaSuIMZLFN4OQWPVmrJR1WH6XsQRmfOvQDvuJnmXAkg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2nhs8s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c802545ae0eso4720568a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471299; x=1780076099;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=XC+5qPQ5yJsx6F7wK8+YrIqbk+FI3xfE3q3MdIi8gDvhZB2hbwLOvCnzovfc1eLnq4
 qbYLP1FM+lRDVZryDIFqVmAqJEEucBZ5GE8zS5NiAh4k9YhWBC2gnLW47Y5lyGqVIwzB
 KFtgq5KEd+sThkH4GQmiZYCZgzzPlmfOUbcq8IsBBV/27HbXoXArPGC4X3TrVvYmHtdX
 qzp7YaFugAaLSQff7lUGsIFjEjtoPWStkoJ6h5Nikdcs9FI7pioIn8OBhUEuEfUEumuu
 2hYVTn7HBTEqNAmicZ0sWCEi8fPXab8gMlaNHf+xSTrlIzv2YuMsI7fLHYMkI/dxYkOQ
 2N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471299; x=1780076099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=lE6+bGSUG3Sc0IGROoDbHoy629QOP4Zc2qvhIEp1qrrzkafuHi+zHRw+9cvEGOrozQ
 XOywLWyhCMEqC/xUEOdPr7RFwJTSBehK5bw2k3henSuhBGQm8J2nmV3vQy36iDCv1BWY
 SNKiulPaDmtV6iRM+EdZucoQo8n8OrT88CZF4HrypaH6gEVbLlpTMRTGdpB0Aw844l7R
 EkJ6KtOIt9DEdEEcsqNZZ6sQnYgiMEH2jvz/peQtJ5M1VCQfuk5AKRzTyV8ecnaeWfdR
 KTdcD/tDeMTW9/flNcCY9tLLLRwjKHmRcmRhhqOXnSw4WpieUpvT71Wb4N/EN2Wmx5V9
 1RsA==
X-Gm-Message-State: AOJu0YwdQY58TA6sgcGLF2RZS1Pz1ufdLPkYciL9r5GCfqX7JL7yImzA
 K4XDRcYMSnh0vxdQUL7634gUWC7g0L/8TQEpDiHbqxP2QIw/dkqOSOMC+kCYkxEkRSWIo6irks8
 mjo3sHEE3z4G9f2TwBwrIit7yiLmWdII4BUC/z6oRu2YNUVHypNxgcvQyGtgg+gQmIi+ZVNzzoW
 EMR/M=
X-Gm-Gg: Acq92OHpJht9vb5FCP9ZXMDyQ5lXSeZ42W/y+szKi865MpEtuZfFZNHcGzh5MIgoW0s
 6lZt5b3JZ7KHIv2YuFRkUnxz+HaaiRk+vvniUmxQSdN41ylaxkIwKYSrsCyUJFvjPPCeYuZQWlZ
 6MgML+9GZxSaMb1KTl8/PskHoHbo0cp6b9yUiEPw2taVPOUqs1aMviAEktli2k3dLFVcNzxRCNA
 u21M+GCjTt4nkWVuxmOPqoEJo4cinEhyDo8c2B4uK2U2CiC8We5QT4S5T2zueKfq8GQC3hJ4S2Q
 Z0ixA9/ObnC90MY7yGDO69dhloe9L/GQncuRl946xIbYBAJ2bk8Nv7BL0sw7lNWc94gT1gGAlGb
 rQlTlLW65iWn9HkSv3BBNDLwVMYUJ98cZ
X-Received: by 2002:a05:6a00:4b4f:b0:829:8cfb:df45 with SMTP id
 d2e1a72fcca58-8415f323ebdmr4617810b3a.15.1779471298529; 
 Fri, 22 May 2026 10:34:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b4f:b0:829:8cfb:df45 with SMTP id
 d2e1a72fcca58-8415f323ebdmr4617789b3a.15.1779471298050; 
 Fri, 22 May 2026 10:34:58 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ff3e00sm2981361b3a.54.2026.05.22.10.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:57 -0700 (PDT)
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
Subject: [PATCH v9 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Fri, 22 May 2026 10:32:58 -0700
Message-ID: <20260522173349.55491-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a1093c3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-43u8CF5Pkpiqpb4b0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: nPqLqqTeoPWNEr9gmT6_xH-hmjUzFZ2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfX/Af1xgYbLCos
 eVALtgDVFMjGxSZOIMQ9At0fk/Us7GawgTnrGbjhzZw/6IsMwn865mqxXMFEbubrCwFGr8XVkXm
 6rHVGlZh0mY2ZTasx62uyX8cFnvUGx5kdhnnor2b5kxu4v/q9DfeuWxPXSopmGAX43WavKjyKCd
 3H6bzx6rx2UZMWurYXiIV0swbxG4OfGIB9joTdQO+4qTSqSed6emEhF+jul8ZKxGzpZMdkfV8pL
 TZf7mF04aZPRAu7p4mwagVoRov4zITzCovLW7kQKGtXYICuENSC3UJ7h6Sw2N9INsqmw3X9yWAB
 Qx7K246ZHk7bxlFtXnfkZn9U0eXWv+V+Kx9dp6xPuBaVC5DLQFboWiQWJwtpRSPSEIkggD9L8Op
 5jwfNfxWPOVIK/bcEemcN4NXeiXGfm7v4cORY5Je/DcmOTssmr61EsKrOWZw0Rqi3ytJeFc1mrf
 Kir5xOCnStNxdXelgzg==
X-Proofpoint-ORIG-GUID: nPqLqqTeoPWNEr9gmT6_xH-hmjUzFZ2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

