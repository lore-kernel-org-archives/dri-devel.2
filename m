Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF450606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Syf280aM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bv7rcJCW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2431610EAC2;
	Fri,  6 Nov 2026 23:22:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B463810EAC9
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoOZJ766810
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mInqVCgb/Jp
 cHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=; b=Syf280aMoO/xUrS4R7GcM0BxjJr
 J9yQtRcUX9vwJpHzLQQZm4b33yAxZ6mV5qaJfq60hFLkV5JqOzjves698X4pm74x
 V0VKg7dPpmD3JGIR2GXA1AWJB+rlqGjPCLTJ67xvZSRa8Vb8RKgaTEMCITSyV1ze
 1FADgBuhHA8+LI1+gavkNgVIjQeGPja2h1GBtoOtWjDq6QAOSzps09EsGI7sQwFb
 p6ha0vgRcd1W3etGV7ehbd5l9yYSNE+xTWWuToAdw8nMTkYE3GtA6fS4Qa5CM3pr
 94S05QCBLoVZ0duR5rquttwuGq7knNryMLlhNB7pwo+p6BKu3OOlV7VWOjw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48s8r0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae6fda7a00so1191034a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007361; x=1794612161;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mInqVCgb/JpcHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=;
 b=Bv7rcJCW7QafdFGAmt/PJXHiwp6FEccHRyCuLbCEDuWmkaQBoI61oflUM+h5uNRv5o
 w4CV06PAXu8Ml/jVyHZRrpqAXencTBlQ3U5u1jwiEC8bhvHs1Kpwhj/+lcSByTCWCyjp
 zNYbkmkusmfkL+NfdB9OoWNWSQ9SGAI6zYdFi9oyUMeEJuZDlvKRyCJXJ4BLD3uw61yd
 WkrSkjCngxEsad85X1Q9zkx/YVeMzRieu+6gz/+wjqdFRsMJ+RjglE4t/TFYM4sZLQEa
 NCxwJbAFhTkmDpKt2ZmvStxdtaadG6sg33Hd839ZZL9uEoN39BMYgmdJS8olnEORNL0N
 bFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007361; x=1794612161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mInqVCgb/JpcHAFW5diV2Bd7SIXa0C+12G8PqaKwBHE=;
 b=h29FhvSHxS3dGT4tSkAVWXum8qSRak8I8Cwn0XZONfDnbzGruJl01x1BnaT6lX3bc7
 W5FKfn6tBxDy/WZ1JIyvfaST7G78K5xtnk/gLkgYlDcoQHtT25ox+M2Q6TtCNRv+x8+3
 npScsWhlwsY/vgUtT1vC0Tm68or4rYeaiQUzamXEEoHbW/b02O1S539JIwTLljlswP19
 cVo+YU6QDZKdP3NLrP6SXWPWwngVbeHL5cIVARQkh2OF3fZUZad4nXmBGjV15w2TaYgS
 /LRBCP2LUpiWKT6iJMAmX2l1j3YHJrNuTQJQ3/uyP/drA39zfqUgq5QHjTnWX+suYDUY
 CMfw==
X-Gm-Message-State: APuU4Z/xySQ4EVQpjssXw9tW1C/nE/HABcuKvnYnl3Ns3BezXKBHsDhd
 cSW5FQ3f/E+38+Rmd/CCGHKvhoKGfs65Ucp05WcawRSWb9od8Hzd8EAjuGRZbIwzoQz8IJ8AmwF
 8XBCS1d6DHD5LBXrIHoek5QiH8mCF6cQwzlezt+B5iuHpISLw5ZSSBDFl4MP8xdKSqxTvIRTdK6
 26PR44MQ==
X-Gm-Gg: AYBFou2HTGNUkqWFISml2imY2cKReiHWivxKQbaLFlRuoEVw0+L1XTvdCPiJdOqydLn
 nmLgwW0grea3fCd5Xki8/LhQzPlqC6IQOWHojrf4G9NPxXvzXsq5kq8hwxutf5XFcQ6NNomas8M
 W31C9hzTkhhI+o0QfZcH79lXZ2DlSLZNxLQaAYdYPIoi12mmAwmLw011j8WAwZNh9DL05pBpK0r
 iTkhg7H9EeZ2NvfYPtSFgivmpCqpXUW84mnp8ibsF0/bceK8v3UNAf8tRia5qFaUS0GKS41x0FG
 TtAYwcjuOvzyVhbXpAYLmbuyp37Ushq7yaNmr3Xh+GTUyHb830mkn19HWqHeJaglG8Qvuk5yUU2
 XBCaIISb6Lr6pkL4ggtx/+S2ZT+7EROMKTq97FRrG8B9yCOBhgnNkT1EI6rtuJ47+8g77oLSM58
 cf6oRQ9iCevnAzKE/ezNaqqbyc6LJfRSmORsh0soKqkrLcTZP0NcRp5S1OyyWepg==
X-Received: by 2002:a17:90b:268a:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3b0db7107cfmr3369800a91.43.1794007361461; 
 Fri, 06 Nov 2026 15:22:41 -0800 (PST)
X-Received: by 2002:a17:90b:268a:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3b0db7107cfmr3369767a91.43.1794007360977; 
 Fri, 06 Nov 2026 15:22:40 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b105831cf6sm653999a91.11.2026.11.06.15.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:40 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 03/15] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Fri,  6 Nov 2026 15:20:55 -0800
Message-ID: <20261106232220.47602-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX+9wYLPkkHtnz
 WFCqGI155En5yzqZGtUSv40xoitrRQTxZhCzlmCymturckun+hvXgBZM589g3WtbTi8Sdlk1lvS
 /Dck4Zm+geS/HwZk7e1Ic/KxcOJUI4atljg8riSR5q8I61K6KXkqtFH0CzeIq5+gp5WWYnTsaBf
 WA92kzqNPt+Oib2F49v5BdcJdBP6oxlEZtWnqsPd0Ahy5CU/jXiXwPfqPADr5GOiejMirLjNtW6
 BWAOVxuEl12jnu8vSgQt8EIrC7TA7004sQfM1ijSWFi5jy0dm4MyJ1Acj5BE1N6P7kd1qiz+3l2
 3LvAvRW2q8f9uuj7V3Gv7/zt253HfY/eyYm0QP+I0vmon03idvtUzy8p4mBMW9qMZMCL1JxVuoN
 YbWCj3iS1RFlSTx3mCWnmqW9KqfaiCMBJjqdA/Ixo4zqOjmmtjRNMTpfAAm2A6SjjZs6Ge1smsB
 iDONhVUL/9sjSdaAxcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX494wucVy5FPb
 kh+qgvrqvw1GPPJO+UOrIkFC55aiiq4bSRyiO0XLdE1v3KVK9uY+jmUUtsYZf2Uor1v2cl/h07a
 088+lXUC+E61sLDhSdZYsrHwGke3f28=
X-Proofpoint-ORIG-GUID: XvidwG7oVlbeyG4MadK-x49vVYLpPsDO
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee6142 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: XvidwG7oVlbeyG4MadK-x49vVYLpPsDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The snapshot code will need more control, setting additional bitfields.
Rather than add a list of additional args, add a helper to acquire the
aperture which directly takes a reg value.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index c58a2665e9ab..e6ec85b20fb7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -346,6 +346,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 82cddaa7278f..be81f141300f 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -16,13 +16,10 @@
 
 #define GPU_PAS_ID 13
 
-static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
+static void a8xx_aperture_slice_set(struct msm_gpu *gpu, u32 val)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	u32 val;
-
-	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
 
 	if (a6xx_gpu->cached_aperture == val)
 		return;
@@ -32,14 +29,20 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
 	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
 
-	a8xx_aperture_slice_set(gpu, pipe, 0);
+	a8xx_aperture_slice_set(gpu, val);
+
+}
+
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+{
+	a8xx_aperture_acquire_raw(gpu, A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe), flags);
 }
 
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
@@ -74,8 +77,10 @@ static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pipe, u32
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
-	a8xx_aperture_slice_set(gpu, pipe, slice);
+	a8xx_aperture_acquire_raw(gpu,
+		A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) |
+		A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice),
+		&flags);
 	val = gpu_read(gpu, offset);
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 
-- 
2.56.0

