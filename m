Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489A606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=arzO3/aQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cbuBCFTy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D35610FD72;
	Thu,  5 Nov 2026 20:40:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A50810FD6E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeFvq1474738
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xNuC3YcpYbL
 /ohhfiu1MVmrTM22nlt5dJLHlvnKVZIQ=; b=arzO3/aQwiqxI9F289NpTGta5bv
 yf83BvPoxMTP5wHgz3evmRjxUXD3uaTCaD4qsVUh2ZseT6Hyg2xvqsb5lS3mg+et
 yNG0dy97Dr5LKVW8JDuVrff7ZcP+I1ZZzAJ7oMEhmzj9ddNYYBNAKSJyumJKekP4
 ugFJCd/5ly8VhJbvQP/p0zUmisxVyyuW+ctpltqQP1XEUftQLDyyxSBxWLRDLkBT
 niK2t+QHbfLvnT2rw4ik5xGXhMKobExSasBWNd22linsyTqDZCrdKa07wH1TWQ/x
 scVAQvEyc3Ep4kpOojB71lMQ281naDtJ72g+0CeTLAIlsCpIasIRojtXbGA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbq5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so3393990a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911236; x=1794516036;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xNuC3YcpYbL/ohhfiu1MVmrTM22nlt5dJLHlvnKVZIQ=;
 b=cbuBCFTy1Ck0eKqLxNaPhMFoXJZnWwAShZSd/0Xd3gVJddccxSGds5HjE3MUKvo2Ah
 ow2qpPpB3eJSJ3wCZj7KRBhu/mNGMEPxntEU+PZYcQbTILcpcsKI8g9zzZv6OBL7ajxs
 mguz/RDOYPxAq3fkv8TLKg9nZs+LTGEi9EdH+2+57RnMJNJ7m5NJZBummH2xxiabPpZ1
 ZZAUiz/aeHD96rfCgfT84xjLqlYKCdBrGKdjaWt1s326uKmSbIQbsfoWK2W9zXM7hg83
 6yEV9guuL5hxl6rmDfQEHdmy2lHkJxMFZRPducyTNt9W9m1VSBZKEiideHyoXfu9QpPy
 E0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911236; x=1794516036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xNuC3YcpYbL/ohhfiu1MVmrTM22nlt5dJLHlvnKVZIQ=;
 b=ilT0WFfQchTr8JjEDPYABdsWL887/6KvXbd41pX9tUgTYhZHCsH46vIRdvC1jedkMr
 whemYkjoYvmcjRMkKgMzZi0Owv4VB8CE08nvBYyWCuak7iA+m9nB6Ifp+qW2yCteh1I5
 2N8CtbnntJHwAH2WZiM3hVcMFAKAZYSTXCaZCGVw4GagNLwxOXUWk+gEH+MoKe6mYMC/
 bfgPZ9CJ1EyZerMgFzIhnoReti10qq+uyO+81n+KgC5RAd/zfBpFYc9o3YZQIwT2Rp80
 7rgWhtDT6tFPx2KMSKe/LMf2VCTdv8MND1HAUIm7kxLPdBmGmJSi0Op/whjC5x3gN9VW
 4mfg==
X-Gm-Message-State: APuU4Z8pMkgHjkQ35NH8euz6SIIe2sxrw4c1CfLhUVh5vYaNjZeLbiqF
 CqxxrEKwoATLKI66omy7/eFmfCommYsxtIstTXBA5fHGw7qvuu9mzozNNa1DvEGXvXpzC7Pwchz
 6B4F7YOeepf6gbjssyQsvrCHWEqAHTbXW8bq58863Y/u853jMbQ0sZbZby/Qv+y8W1HXKy9l0x9
 gX/n03Vw==
X-Gm-Gg: AYBFou3WwO4r0wnVjivql3cu8R+/upGCGbObc7QpuTwC4QS2Lh89ccGLy5D/mRoFUa2
 nKAbmWaGGtw8/fjg4otJt3gB/BfaDjlUMFpMdWxstuVX15bu8FRxsUL9DRxqkM+RCbCP5rkBJfI
 If9lny6bAshI60Kb6ieZgnBXpvB9X4I+mZAUZ3jEKvkc2DS+iwnv/K9dG9aTx5qFEcRCM+6ZH3g
 5/3/Q1JthhoRDDlLe8PHAWG6lzQ30hvbxBx9R6dfeaGDFWHXH46/Qlrp6sUJFv7dPVnnCYmyr/l
 cALr7Lmh/6zlUKcLov4EOAnJiHb8VgLKWqRe+6v+SPV8MPHvO9pBxbomons2pcLc9auTp1TwvTR
 VezkspacDJUDmbAE+3aZTtnZqKaspPhU0fP+yGZ+WMNopyf39BICM+Aj+H/OiMH1dOJHjmM3uD8
 Sd27ds0JmGarxeXQmF08mkq2A6QtDDeyXWnMN89BpXjvyaA8p3Z2SZwoaCIMK0
X-Received: by 2002:a17:90a:e7d1:b0:3a8:49f2:8ddb with SMTP id
 98e67ed59e1d1-3b0db705990mr179860a91.60.1793911236079; 
 Thu, 05 Nov 2026 12:40:36 -0800 (PST)
X-Received: by 2002:a17:90a:e7d1:b0:3a8:49f2:8ddb with SMTP id
 98e67ed59e1d1-3b0db705990mr179842a91.60.1793911235583; 
 Thu, 05 Nov 2026 12:40:35 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d78b0a8bsm656840a91.2.2026.11.05.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:33 -0800 (PST)
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
Subject: [PATCH v6 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Thu,  5 Nov 2026 12:29:33 -0800
Message-ID: <20261105203057.66520-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aece9c5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=QhgCzLM3CkghMFFZ4C8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: WzIfJB8oLMS6H9oh2xblOX2lBLOKwM1B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX6gPeSaczKPMk
 to3XGn+ZnxIY5uqhAXsCOAMdzDMYN1R6nCViPuPYB0GDgPvNOqtaKv+W1y1YTpNWS2Px1Sxv9Dx
 hNTpa47uQA2nvjojWLvN8HoW2lyv64M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfXw4/aNuZolC8a
 XrwZHCRpqYfAGYUZQs4hIeBHnVEspNUNFK8yplCpMHI78hXaSgobUQHTIQZ4O9AF2J7uN5Idcu1
 1tK3VxMJpeLodun/u+Hmvl80CnidhAf/NtS/EV3YMeco2kJ7H01FKSpqEyb3o6Gm+NyQnaM7gVe
 gV21/punporPO1yNmtVXHWU79vhDxliH6ezsUZw/6dz/TXuDdxFygQ1onYRdk/qW7NvutqKupSO
 S36dpNDwyft2VQTFF6/+3arjuHKmVez0JEhH78M4/DSTKHAADFpoF6iplWi8Zigobj1dZU9JNzV
 zqUWW2I/VElSgXX9Ayuri/ghtSzTzmWFcVh4e7FbE0xFADsoGHxZ7OzgsGr4CzCgObIs5V9T3zy
 XrpRGobVt77sBiYh0S2Iani/HCv9mCxQwsRsoUaD04rreHqC2WOnaIA6RLNtUU2JUy3GQyXZb6C
 uRMsDcfc46RX0MqPUAQ==
X-Proofpoint-ORIG-GUID: WzIfJB8oLMS6H9oh2xblOX2lBLOKwM1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050082
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

We can just simplify things and calculate the value, instead of manually
adding it to the nonctx list.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c |  6 ------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index dd1a5ca91812..6c5ee227243a 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -27,7 +27,6 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
 	/* Configure number of outstanding transactions to 32 */
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	/* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitration */
@@ -309,7 +308,6 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x15000000, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
@@ -483,7 +481,6 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
 	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x00900000, BIT(PIPE_BR) },
 	{ },
 };
 
@@ -709,7 +706,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
@@ -1102,7 +1098,6 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0C000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
@@ -1161,7 +1156,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 59898b49a201..f65bf82e5c21 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -370,7 +370,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -390,9 +390,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -638,7 +635,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -719,7 +715,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -838,8 +834,8 @@ static int hw_init(struct msm_gpu *gpu)
 	 * GMEM_PROTECT register should be programmed after GPU is transitioned to
 	 * non-secure mode
 	 */
-	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT, gmem_protect);
-	WARN_ON(!gmem_protect);
+	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT,
+		        (adreno_gpu->info->gmem / SZ_4K) << 16);
 	a8xx_aperture_clear(gpu);
 
 	if (!a6xx_gpu->pwrup_reglist_emitted) {
-- 
2.56.0

