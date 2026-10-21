Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54F606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oihXyvNM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HiWbSNx+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888B6112217;
	Wed, 21 Oct 2026 20:53:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CD6112217
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeDwY1501787
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tvTeQ+iV8iw
 dRN8asVlhAzKBe+gRmV+0d3JhJhcK+1A=; b=oihXyvNM888ItTYF1E0v6QG1yJR
 WxSknqDJQ1Tsux9O/v/mnr1pfn4fDfhktAKyJry1KC3Pu6wwhFIWeT5OXm0eUP+Z
 T7yq6jqwGkS/uh48jrNAPKZhncIq3fTiAbjVD6n8hphggIezT9PXSRX0tHf2Iiut
 XpFdFs8Ae0btGbpdZrcVYcYGNtAmUKTY0oZ/2AE2IPlwA3F3oyvPcBZImu+a+nFW
 QQ7yoiZwNYP6iG3y2fKPkGl5ZmxBA6GuPgeT4YcMQQu4TsKg8nK3dT+lE92/lw3k
 L+YnlcGyvseBq3Vc/2tYm0NWXPnR6eRWmqJEu8q0HHGAHGQEFJpAGHWGkjw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2h3sh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd65070d3feso131780a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615999; x=1793220799;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tvTeQ+iV8iwdRN8asVlhAzKBe+gRmV+0d3JhJhcK+1A=;
 b=HiWbSNx+8q/GMhb2kXXEr9Ip+U9WNL+veeF08HpuT04v9jlI4NEDvmjAaso0NWGj0v
 n/Tl19vqiP8KB9wuzRL713lTz2gAMq1PP4AJEW7r11jCEHtXXfjUFiRwMUersoS2eran
 3/SAWdQjLeV9oAi9OsdcXLD6b0gapdOWVpG22wteXASXodUttJVMj4OUAndegFfkTq8Y
 5+D312kp3Yda5aIVwqlKnTxzrhMFcyHhRP1vHgkfIWQSVF3c3y2MOfeK/iGTGqIjtxN+
 e8wDLKIP2tsztClMy0zXisbBbaZMrTyDAGptbXpObx6mIrNPliZ/XHtlDWppJUzKYmkG
 XfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615999; x=1793220799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tvTeQ+iV8iwdRN8asVlhAzKBe+gRmV+0d3JhJhcK+1A=;
 b=SdECVcH2C4IVmuBmXWHf8BRG2O7A9VngDJAGjTJ3YIJC1aLwiS9G0G9CUmu6EH1W2j
 wPUnsofzxUjcGrl20ETH2v9/I3i3p3+HlStrn2hs3vpbRIbMqMdh6XY8kzctBh/OU7M6
 mLCRtiWZatSDN1ONIa+uH6WWevwZxgLIv44/cIHjNs28fi2W9R4/WAneYsn9cOS4RJyq
 eCd4dOBj0kvpkVDItkvRPNR3NP61RSrAH6BV7nDsVrDoVSjhSf4SUC/o336xrVv5LQZS
 j6+B2L8Xbp7/CSM6rywYQj1s5ple9JSz/b1FXlt+hvNjs1UthwHADXUWjdrnte5QbEDC
 n+cw==
X-Gm-Message-State: AFq9FYKgCto6UlfUC8OFe1DOVmGgBRJbIalFIDMsKOwcjuEe/AYsPRdM
 gWK/KZlY9QaO+L8N+etSXN9Whbx5ucOchOy56lgGcK6Yl5jYBNGBrq/BrrViWCqJInk+qUCpoP8
 Zr03PDz6rs0DfYjnSGY/S3++pbRbnckkvxhnISIs3CsRsLwRvtgYHu4ScdrER8Rhsa0EeyoqXXb
 YXDmc=
X-Gm-Gg: AYBFou26eYNj7r/RTBPBhsdfCA9QPcigGWnZnJbqpHY+h7nset/34cmao+N4W5aT0RP
 aWADbG+OMGUN3xdd8+vOKuWK4ik7yXS8743Q39I8iBPxalg3BeY3Yh+Mkk31AAN7XBaW8sqLFqu
 fTAj49ER5WqEM2l9GLjvje7yXdaFPSaZeTyAn2FdYqUpemuqiODBbYp8eQZjO4fKWlA/hdUpcMa
 VC9pyX49NqJOQ3dicmJTl3J3V+GvGRiCx98VNftjNOTnyc7n0d80Dtf08UNnn9jcZilkM6KGXeS
 JLJ5Dp5OKIVgPku8t4LwIn6DE84Sbn41AWGjouw6hXqqBjMBkWIMEI1VVrAwqXEUtg5PASw2p2T
 IlphrAkpFYx5FdOJmQ5fBfIF1BiunkpR6TX51feUygYht5fpY
X-Received: by 2002:a05:6a21:4886:b0:3e2:4e6e:6cb0 with SMTP id
 adf61e73a8af0-3e2a0bbf897mr230939637.36.1792615998952; 
 Wed, 21 Oct 2026 13:53:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:4886:b0:3e2:4e6e:6cb0 with SMTP id
 adf61e73a8af0-3e2a0bbf897mr230914637.36.1792615998348; 
 Wed, 21 Oct 2026 13:53:18 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6b8482048sm428836a12.7.2026.10.21.13.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:53:17 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/14] drm/msm/a8xx: Switch to generated nonctx regs
Date: Wed, 21 Oct 2026 13:41:37 -0700
Message-ID: <20261021204244.67160-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX9kbyCAm1TNuJ
 lfmdqBIylUKA64mqv0SIVnOHA8uk7k8QVFTFHVV5MR+SBuVzDDDC6ETsGGnsqLgAKnScx7nwXwt
 7fXh16HzTgE9LaD30I/fEAqka91SGdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX5xDYhhlCzqsP
 +tq72djhDRvwZKcfmqpyiwJY4WsKg0NGZylrhE5rpBgn0q1M5pfOjeZ438ZSl7ey6gXa4Seels8
 WpX6J5LSyP7fSFw5yU6Z01WJT6IUBLmTvIxvdmdrr5QFor6dbk5teTT+qvwpoboexJg/d0BxRg6
 k+H6IPGVknhwWNppLUB3noYw+OMHiv6Px09i4jMf2dZcL+f+0wlZ9HQ4bKY/0xtbmi+xP+LJ5eV
 8wLI2hL3uruO6Lj0YpVmmoDcfySpxDRLMVH4fWiUZeR6e70bv5TUqnxn5SWWBiKMgWfEAmYbY45
 wTvoGnE69mRQJPGgc+CGOfwlZf0hhzy/FWZ2dMJt5xgibJ1fbbsd2TFiIeyMcG1z+BmTgyyAKb9
 sjzXX+30HNYfrElYwm+qHn/LISKcmhHtezwJdWNpjRKQDi6+e9Yb3IW5rMnnvrJuXVfnaKFtcUk
 l6OpFYvr/xGsLjodcLw==
X-Proofpoint-ORIG-GUID: hVpogRFotoMflYLbuOX4wdPRyTwdxu9F
X-Proofpoint-GUID: hVpogRFotoMflYLbuOX4wdPRyTwdxu9F
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad92640 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=HI8QlUTlAymuEnjGfIMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210083
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generated headers contain the current (at time of generation) hw
recommended values.  Using these directly makes it easier to stay up
to date.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 354 +---------------------
 1 file changed, 7 insertions(+), 347 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 4365328820a2..7a9080e7b11b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -18,71 +18,6 @@
 #include "catalog/adreno_milos.h"
 #include "catalog/adreno_pakala.h"
 
-static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00400000, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	/* Configure GBIF GX registers */
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	/* Enable full concurrent resolve and unresolves */
-	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
-	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
-	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
-	/* Configure number of outstanding transactions to 32 */
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	/* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitration */
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	/* Enable contribution of all shader stages to SP perfcounters */
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	/*
-	 * BIT(26): Limit the number of wave-slots for Eviction buffer to 1 per ALU GRP
-	 * BIT(30): Disable LPAC auto-promotion
-	 */
-	{ REG_A7XX_SP_CHICKEN_BITS_1, BIT(26) | BIT(30), BIT(PIPE_NONE) },
-	/*
-	 * BIT(22): Disable PS out of order retire
-	 * BIT(23): Enable half wave mode and MM instruction src&dst is half precision
-	 */
-	{ REG_A7XX_SP_CHICKEN_BITS_2, BIT(22) | BIT(23), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080,  BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
-	/* Enable cubemap small miplevel optimization settings */
-	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
-	/* Disable tag bank id hashing */
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x00080000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	/* Limit gmem number of ways for GMEM requests in each set */
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE)},
-	/* Disable write slow pointer in data phase queue */
-	{ REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
-	/* Configure UCHE to CCU switchthreshold timeout cycles */
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BR) | BIT(PIPE_BV) },
-	/* Disable redundant tile data optimization */
-	{ REG_A8XX_VSC_KMD_DBG_ECO_CNTL, BIT(11), BIT(PIPE_NONE)},
-	{ },
-};
-
 static const u32 a830_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -306,51 +241,6 @@ static const struct adreno_reglist_pipe a830_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(a830_dyn_pwrup_reglist);
 
-static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0x00200000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x15000000, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, 0x0fffffff, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00820800, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	/* Disable CS dead batch merge */
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_2, BIT(31), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
-	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00000020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ },
-};
-
 static const u32 x285_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -446,55 +336,6 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 };
 DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
 
-static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00f80800, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000023, BIT(PIPE_BV) }, /* Avoid partial waves at VFD */
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
-	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
-	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	/*
-	 * BIT(22): Disable PS out of order retire
-	 * BIT(23): Enable half wave mode and MM instruction src&dst is half precision
-	 */
-	{ REG_A7XX_SP_CHICKEN_BITS_2, BIT(22) | BIT(23), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x00020000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
-	/* Disable write slow pointer in data phase queue */
-	{ REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x00900000, BIT(PIPE_BR) },
-	{ },
-};
-
 static const u32 a810_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -785,69 +626,6 @@ struct a6xx_hfi_limits_tbl x285_limits_tbl[] = {
 };
 DECLARE_ADRENO_LIMITS_TABLE(x285_limits);
 
-static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0x00200000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	/* Disable Dead Draw Merge scheme on RB-HLSQ */
-	{ REG_A6XX_RB_RBP_CNTL, BIT(5), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
-	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
-	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_OVERRIDE, 0x70809060, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_BV_OVERRIDE, 0x30000000, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, 0x0fffffff, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	/* Disable mode_switch optimization in UMAS */
-	{ REG_A6XX_SP_CHICKEN_BITS, BIT(24) | BIT(26), BIT(PIPE_NONE) },
-	/* Disable LPAC large-LM mode */
-	{ REG_A8XX_SP_SS_CHICKEN_BITS_0, BIT(3), BIT(PIPE_NONE) },
-	/* Disable PS out of order retire */
-	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00c21800, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	/* Disable SP2TP info attribute */
-	{ REG_A8XX_SP_CHICKEN_BITS_4, 0x00000002, BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL, BIT(14), BIT(PIPE_NONE) },
-	/* Ignore HLSQ shared constant feedback from SP */
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1, BIT(17), BIT(PIPE_NONE) },
-	/* Disable CS dead batch merge */
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_2, BIT(24), BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3, BIT(7), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	/* BIT(26): Disable final clamp for bicubic filtering */
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00000020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ },
-};
-
 static const u32 a840_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -1178,124 +956,6 @@ struct a6xx_hfi_limits_tbl a840_limits_tbl[] = {
 };
 DECLARE_ADRENO_LIMITS_TABLE(a840_limits);
 
-static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_CP_MULTIDRAW_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x01000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0x00200000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000803, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00400000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_5, BIT(28) | BIT(30), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
-	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0C000000, BIT(PIPE_BR) },
-	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_PERFCTR_CNTL, BIT(0), BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_OVERRIDE, 0x70809060, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_BV_OVERRIDE, 0x30000000, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_CHICKEN_BITS, BIT(24), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00820800, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_CHICKEN_BITS_5, BIT(3), BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL, 0x04000000, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1, BIT(17), BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3, BIT(1), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_HW_DBG_CNTL, 0x01410000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00080020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VSC_VISIBILITY_FLUSH_CNTL, 0x00080004, BIT(PIPE_NONE) },
-	{ },
-};
-
-static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
-	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
-	{ REG_A8XX_CP_MULTIDRAW_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x01000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0x00200000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00400000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_PC_CHICKEN_BITS_5, BIT(28), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
-	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
-	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
-	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
-	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_SLICE_PERFCTR_CNTL, BIT(0), BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_OVERRIDE, 0x70809060, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_BV_OVERRIDE, 0x30000000, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
-	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_CHICKEN_BITS, BIT(24), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00820800, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_CHICKEN_BITS_5, BIT(3), BIT(PIPE_NONE) },
-	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL, 0x04000000, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1, BIT(17), BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3, BIT(1), BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
-	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
-	{ REG_A8XX_SP_L0_PERF_TUNE, 0x00000024, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
-	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x00000720, BIT(PIPE_NONE) },
-	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_DBG_ECO_CNTL_0, BIT(31), BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_HW_DBG_CNTL, 0x01410000, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
-	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
-	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00080020, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_VSC_VISIBILITY_FLUSH_CNTL, 0x00080004, BIT(PIPE_NONE) },
-	{ },
-};
-
 static const u32 a850_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -1563,7 +1223,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a830_protect,
-			.nonctxt_reglist = a830_nonctxt_regs,
+			.nonctxt_reglist = pakala_nonctxt_regs,
 			.pwrup_reglist = &a830_pwrup_reglist,
 			.dyn_pwrup_reglist = &a830_dyn_pwrup_reglist,
 			.ifpc_reglist = &a830_ifpc_reglist,
@@ -1608,7 +1268,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
-			.nonctxt_reglist = x285_nonctxt_regs,
+			.nonctxt_reglist = glymur_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
 			.ifpc_reglist = &a840_ifpc_reglist,
@@ -1653,7 +1313,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a840_protect,
-			.nonctxt_reglist = a840_nonctxt_regs,
+			.nonctxt_reglist = kaanapali_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
 			.ifpc_reglist = &a840_ifpc_reglist,
@@ -1699,7 +1359,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.zapfw = "gen80300_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a810_protect,
-			.nonctxt_reglist = a810_nonctxt_regs,
+			.nonctxt_reglist = milos_nonctxt_regs,
 			.pwrup_reglist = &a810_pwrup_reglist,
 			.dyn_pwrup_reglist = &a810_dyn_pwrup_reglist,
 			.ifpc_reglist = &a810_ifpc_reglist,
@@ -1742,7 +1402,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
-			.nonctxt_reglist = x285_nonctxt_regs,
+			.nonctxt_reglist = glymur_nonctxt_regs,
 			.pwrup_reglist = &a840_pwrup_reglist,
 			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
 			.ifpc_reglist = &a840_ifpc_reglist,
@@ -1785,7 +1445,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a850_protect,
-			.nonctxt_reglist = a845_nonctxt_regs,
+			.nonctxt_reglist = maili_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
 			.ifpc_reglist = &a850_ifpc_reglist,
@@ -1829,7 +1489,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a850_protect,
-			.nonctxt_reglist = a850_nonctxt_regs,
+			.nonctxt_reglist = hawi_nonctxt_regs,
 			.pwrup_reglist = &a850_pwrup_reglist,
 			.dyn_pwrup_reglist = &a850_dyn_pwrup_reglist,
 			.ifpc_reglist = &a850_ifpc_reglist,
-- 
2.56.0

