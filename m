Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F36606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GQTy9lFX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RBq5WyLy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842D410E94C;
	Tue, 20 Oct 2026 20:48:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4293F10EC35
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7N4g3460915
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EkKOk7oGiQq
 yMwGz5IkcO9uuHyQkVlpszxGw/CqPXwg=; b=GQTy9lFX6oVhwkkX1aWGq+wyn63
 5myIWkcOcHwY0H9q9NizzdNMzmHXTQWNF6Q5DBCAmkTGsdjo5+YPF0HAzQJw9CVT
 QlqisxZE1x7nIjJ3OZ/9U6OVZZ0+UrEOYRUC7j56lYg+6xx0y6hkNauQOXkdiSvA
 Jn97NeYceq3HBo6Q6b3sH+xRuKaXTvJ9MMXelX+8HF871dZm2+ptCPefG5Tu4k1m
 nQav7qLnOVA/eZGz1OG+M1BkZ3cGVvoCamtw3Exw9XBGKIr8upgZdgvRCZJXQpLs
 /n+F5eU6wR3s2NAOfuuwAlFlo5nfAef5WSFndyQl+nGCwnVcRvEWBniI1eg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4rhac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so121112a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529274; x=1793134074;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EkKOk7oGiQqyMwGz5IkcO9uuHyQkVlpszxGw/CqPXwg=;
 b=RBq5WyLytyULtQOYQPnImDGHlSyxp0dkrRxBgsjnKjuUsyz6L8JKOhdR96QdFYjBmD
 EWYu3wtw1KxNhYVQAU+oxyYQSVacU47QYAXefG9dksz0bULpH9R0X6AFIvSvhTzdgw+W
 FuqY6YmaUoDjOAOMsB3ZGczdMUhbNHga108BgI4CZK4DowVao1gsQBeucV0ar0lD6vyj
 y82SKmv9hI2/yAWvQz+23G3ZLsHkoB1Ok6eIJz9U5dghIilPtqNeEOTNq62jVgWRw7VS
 SxufJv4brpAltIneMmYZ6U3kUpOiwL0MbRnaHJeETg8uZGJYIZgVm22eGQvra0a1Q8k5
 kc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529274; x=1793134074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EkKOk7oGiQqyMwGz5IkcO9uuHyQkVlpszxGw/CqPXwg=;
 b=SKWFWBkeBa06N1RWvAQZUqsO+5PmT+tbbMet2Rj1PA9JnWlFYvfpev3zrhT05GSKXc
 9qzhBIzbDf7vjn66z/XoGxf/x5UGVS4jCvZbqyfjlWhw9+DTTf3xjraecBxsl2o+Oe6y
 yQEYbOGg2d1RfBpMYg77AYBnmybsKm0mfOK71wimX9GQAx5Wk+P4LUfw6At3o4/o9qAP
 U40/3HUU4HrAIpeZzhinXPE2VhBU6RKrRDU7juWqnO01u4I4/0SRPzEINCGMjRa0kRxL
 Oi6rlC8vHwyalzsp2z50xLD4ak44doR2DtZTZdhSgJPAD1hGvkMtXnghmfxcTuDqx5V6
 0FhQ==
X-Gm-Message-State: AFq9FYKM+vdnv1qZ/7acy8qPz0gy7+saN3eNtAVFARUNrs5hrdqCK2Kc
 uGO8xFJMxflWM4ozsKRT7Sgem31m8jJ8djcaM78iPqJOX9RnQ1ojmh2dkuT3HGptsFSu3uLOC1/
 oH3qEXGVEeX6NRR586nTUhnSdruSIOo1udoxsaz4SiwLDaETLD6xb3PCuMruzrj3o+HmIl9t/7k
 w3IIw=
X-Gm-Gg: AYBFou1njgrt9RpvLnhxCxAx6ieIujTLe+PPKXk54ZASaDjWIGmyREx5meRE1xDPcMc
 xHXCqKQSK7lEzdrXd0lymGk+9afTdOTuLiN0fOMX7dnUkb96HN30mRhmcPACXIy4MGow4DR2fRs
 b/sLGQBXrccaimwy2AcVK2/SpNXiZtJyp4GL4vmoUtqEYZMuACIg+WVE4S+Yt98pY8hcScrqT6V
 ZiKo6A8qDMnnmVHbd5d3Num7sRH1YTj25mBuhNoTdJGv8hFMN5FiBCsXkPwBsPZ4BarCDilouce
 imZZH3xOOgjtRzi3m+xY/qZLCKX2Yy70VyaX4lnwwxQiqQ0Wku2/fa03MjZhb9X8VmzrZW+ypPG
 hTHDmzLr4Usd7RUwzcxptIS4fTAlnI9ADKdo1yYXcR0ioVqr9uA==
X-Received: by 2002:a17:90b:4fc2:b0:3ad:183f:5e3a with SMTP id
 98e67ed59e1d1-3ad86e5b150mr93727a91.4.1792529274048; 
 Tue, 20 Oct 2026 13:47:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc2:b0:3ad:183f:5e3a with SMTP id
 98e67ed59e1d1-3ad86e5b150mr93710a91.4.1792529273640; 
 Tue, 20 Oct 2026 13:47:53 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8030226csm1079181a91.12.2026.10.20.13.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:53 -0700 (PDT)
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
Subject: [PATCH 05/12] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx list
Date: Tue, 20 Oct 2026 13:46:19 -0700
Message-ID: <20261020204728.28844-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OYx1DjFVNH6Dn2OcPzJKVuMJKoY4pfSR
X-Proofpoint-GUID: OYx1DjFVNH6Dn2OcPzJKVuMJKoY4pfSR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX11asadXU84/D
 HlRzQbe7PIUUJDyZBtglyvosqEAraI+mRpkD9yKxdrIntsZVJknJCYcIu47kZklqKtPZR6DcvLI
 nKatRkIk9aHfKA2Xqy46G7oxAEXsBZk=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7d37a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=b4MSL0WmfgirtTH71F4A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX3VrrwnjSwqDr
 GREW/N6g+9IpcLRfeadH31Ks1aBRAn9j4GIIYQsg69NbSpQeClH2AG01R+h2K5ag8eG8Mv+ZDon
 OCf2ybG4lY9Z5PdJjsCW+yb2MeM2vFJno8if+W+tu6EBd6VhLBFvyYLiNDU2Dr267aGBrwzmCZl
 5uEN6cM35UbZQUMmi+UCGjXBmO657dXoEyLPDETIWBjRnKCM3qucEV+o0EzxZg/mgs4tv9vuyFA
 tB1PtFekr98RXcYMEff1NuVv4nJImEohtyaZiUJ8FuRc5V2w+UWebirIe+DK64MWhYPU75mEYl6
 83pN+L6y7vSfpomvIUrmJP6DliPnVweWkejzop8tIm+ZX+Yh/aX2DBl9gXUOb1ZZbgqi2Oh+1ET
 phjdl3pyjTa7SFfDWD1HppUyTdPpI+EmRyaO0TJPdI73SppRO5Ssk2l3w2Gpdg1eYS6uFjVQyoO
 76Dhli9cH5MQRG81Ipw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200082
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 3e22ef788f2d..6d7982a117f7 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -373,7 +373,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -393,9 +393,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -641,7 +638,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -722,7 +718,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -841,8 +837,8 @@ static int hw_init(struct msm_gpu *gpu)
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

