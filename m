Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A446CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FE610F0FB;
	Wed, 20 May 2026 16:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQ4W+raY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OeSZOlNq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A5C10F0F6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KFMOhE4115217
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ScHhidnB094
 qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=; b=kQ4W+raYwanWTNXYUy+4w+R+/6G
 1JlIJcqlsLhQinFRAxnJofbf3KoXV8jTrhKDq57cZrOLRKJUDd32Mq2vQBw6nPlb
 luxbSBbUzgQgIDpoYhHg2ZhbJVD4EIHQ4fzzP/m5bUVHtwE+uMiCskHl1gflT2lz
 UpTrh1TpS1Z3JhgTV4/raPf+av5bmNbR+l5t0qIJSeWw3nLQhyT2cevGd4I5tSWM
 Zi1bMr8Ml70Ml0sDGQUeH6+rTO6nVtUqotxoHi1KeUWH4aq2NS24HfME0cAYmjqs
 44Km3s5CC3KNQvrQnCmwZsSqHlazyu6QjodWdkcYhq6Frf89RVRtbYNsdzw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0hrdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36603ad6709so4357196a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294340; x=1779899140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=OeSZOlNqzF6cT/VDgj/pk2/JZ3f1SGltWx766Zdn2579XZXkpkKFowVwF5pbsSgJ7w
 KLY9fIivoRy3zYXe9xGc91X+Sc/urr1BsWw5nNX9CLICDl2SV27foSPPJaFTEotwIxZ8
 jT+0DjTqyjaI2wr22qMwmfi7ezcWHf771QIm3K26dROvgg+cHXLSdKcVK2uJDK8VRAQ9
 r/+sOVmx6mDZDWCgNrOkyFG0OZRYPnUljgxcK14jfI1Js7IKWfllGYiiNYiuWg1vdCCz
 8kCPnIcZtQC1N/35jdTY17ITnDUXod+z0jPNv58CByl/5G4VLbXIVQd7yt/7fNFF6ifs
 zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294340; x=1779899140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=XhSssOCysGCTFzy9jMHmC1ZNOGSWKb7JR4g0Q8xuH0ILJnOCqknPCSrJitx/kk9r7c
 VuxoCkrcWy9KZK/uEob9MlbAs+a8Ko3+4Yf5QeUw/8ARAzuiFAJNXB62BcXgUZXB8hhf
 GRyKlfWjNFRvznAnLcv1igQKiUr3lm3Y/OzYDLEPRGwO6SmxApKimnCqa0lVAzqe9ZRB
 EsKfYL28xHWqD6RsoSMWrGcoKEECBTETOco/X9dJhwmmqLIpiviQkGosNYgAusNdISew
 M3MIWmzbRSDGbt/H7V5UhTrzlLqVSx9jOeBioK9ee3TzTaJrGN9oV0QSDpwLaGY5s7n+
 X9ow==
X-Gm-Message-State: AOJu0YxMO0l9bD+r4g0QCsSPkVPXmr4FHHcnkGIt2irlTS+V/bKUiRE6
 NZSvvd8RmWU6lCinHwEVr2BFo6eW2v+lFGcoEXm4MTJygrLZR50rK44tCxS4xNHTCxY8nLFfD6C
 QLOOsIlAiRIddjlfxPLykkLKgv0J+liNOJOeLAR/AMXk+406vGhZxG3kuZclpP9w8JVGDhmPVvk
 tTLzk=
X-Gm-Gg: Acq92OGlup812cht/h7y39rMf95zO9zXpEEagEm13IeWyDnbgBQnl+koexGGDvGpTfD
 r94GSmwV676UNZ8xfE7+0kif/pH62FTxuNh4xOFHYCQiMW9OMSEQTIz4OoKUEyTvsy+QtBo5pKc
 dDFbfpiMW7W3qZBoiSt/Cp/+AmMDcQJqPNtOPNJN2GGoHTq7PhjDZzzN89KRf8g57NAQNSW4AD/
 FlIMQTWAMn7jxYAyydJZHRhY1KRlFV3Jsk3MD729bkrfyUXxMK+fiDBrbJZYZ+L25JevTjEWmjo
 uIt3KTfUEBWxQ8huyHHL8paNzo8493RdjwN2CjdAbgZaCCLTjGzIddLK2+aPXw+sm2Sz5s04P6P
 1OWb3blyWU8K6D660v8c/zQHsXK2kuCav
X-Received: by 2002:a17:90b:258b:b0:369:e4d4:7460 with SMTP id
 98e67ed59e1d1-369e4d47b07mr11747231a91.21.1779294340079; 
 Wed, 20 May 2026 09:25:40 -0700 (PDT)
X-Received: by 2002:a17:90b:258b:b0:369:e4d4:7460 with SMTP id
 98e67ed59e1d1-369e4d47b07mr11747189a91.21.1779294339543; 
 Wed, 20 May 2026 09:25:39 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb3ba0dsm100763a91.1.2026.05.20.09.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:38 -0700 (PDT)
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
Subject: [PATCH v8 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Wed, 20 May 2026 09:23:59 -0700
Message-ID: <20260520162454.18391-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RDBeqLjCSPfxsBUhB6W1abPelqIK29CK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX5AirbfNX/adL
 Lfg0e45faG92sQG12XEXcRVpvaeHgg2Tm8eOi7nJWfEJE++kFtkuD4AhS1okF3nZPOY8XsNeA2P
 rI55lii334z27DhS/CjxoN8OgmNak/8Szgs6I9qt4Gbb3HUEKL4eZaO6bEItKZ9U2aZzu7kjsYY
 K1Nr/x+LLjt7T+uoxfqxmTYaAwzuttF2q8p/sK4rrS8IjRiv3sgpaGHIUBJv1jngIiA8LiMC+0R
 pvwvF5/zAvVUSSn/Sxgv+CItoaJf5Yj/n8mCXloV90yCEsZNVizFegVcH9eok3rYp+4P4fhtoe7
 et8QoRs+KmGIGV6djCs0OKqo9rUzbe0N6FNciLbhcIeUEYmQNb0FcaNLUbIgqfPEh4nnJZf+yro
 iFE9+QQ+0IYTbRHJw7xGzOd4SFAYKURh7gF2rfGeBUX1j4qJMbFR8nEDebPYZtW3Z3dJuRuHKSY
 1a/6oDQSJrhSXEZgj7A==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0de085 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-43u8CF5Pkpiqpb4b0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: RDBeqLjCSPfxsBUhB6W1abPelqIK29CK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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

