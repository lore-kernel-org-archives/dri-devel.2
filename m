Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34596606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EAzfE6D3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gQGSxJJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E553A1121FF;
	Wed, 21 Oct 2026 20:53:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF0711220E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeOAv1360654
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+oVnjuYPbq3
 UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=; b=EAzfE6D3TvUrYnj9Y2k7DekNbzb
 5jW1oBwFZJ9sQDZMeAn45dNYvU2YqR03YoNbP/xMyvS905N8CsXx/0je/A32Ee/G
 KRsaKPbkSvoM4+5BJpmqyKxuChIayIGhTtAB8IbimFovRguom62Q/bsWfStNnIdZ
 KyZmJutjzq0vCWw28c8x3LwDmBhZY0ZAKhpFjGS61T8VWSm6/cxgyJ3vzHTbnm5Z
 IX7xhs03xfIecnmIbmXjTHNTtC39Halrbg1e5VAMWOFp55ruw81jieSqlvJDLWuG
 sEnXu6Peydzjy0bvBHxrlrx3YAzy/THjRYKVT0lfL26AyNnBkFk9KBFJDJg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vstwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad91787a1aso631432a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615968; x=1793220768;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+oVnjuYPbq3UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=;
 b=gQGSxJJ5BEibaE3v6bUwKMTJK/oQP0Tp2cRzjKTeGwIhdy5VMgXH/ioM95IG4a6FcJ
 e7LfBYUILr8Vqe2IsP9Nazm0zK9Dm3BDXxlvSoGlca1BAU/U0DGOy7cIDEZtQQsMloXq
 ATqYfaa5oAQi1nULqPqJQpoA6YoCV/G8N5imF4AlgpaokQxZQknV5raJ3AVtkANmAxDS
 4+CetNR/gEnxNpkAa/nu6U0H95+gb/rTU8coMc1Ag/fVGwg2UO0EF5qP7R5EMB5e+kG5
 WuFuKBh0/ymyKSBjZG6otGhZh6tMOzAgeMJ1dlfuTtKJyhmkDeyWKZteb6EhosAhy+Ce
 8V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615968; x=1793220768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+oVnjuYPbq3UHfk2AZIHMfqxpfWs5ivQGbBLfCTwFxQ=;
 b=mq/IRYv13meD3naeDhlfvN48AjgkEm+oZTagx38Hy6z3+05l66DwFpU8LsBu7qY8GC
 JL5ZaeZBEkU56gZ0Lhtqg5AbGUvmy0SDeOZAgy+naatt6MyDtzGI+wIJesmMpq5ew8Cg
 ibRDuIJLyulQbgfPZ1s3nnwCXkkpn+j1EYqkptvMMzX0FXx6KotMbo7s+c6Wku3iBrF3
 361OOb4i0zDIwjdNldAKCu+dMs7a1NpY/XiMxpccezbYmOnmRahEYMOl4zeAHG83PDJF
 Mwv8H3YHhCdNzMGMu06XIGA7txaJSpcgNrm8681d/YSH9Gg6RboDZH1LbkK/aC59sc5d
 L4Pw==
X-Gm-Message-State: AFq9FYJr+FQkA7X/901GkmqfbWEln1ndqZRVYlSJbzU6W4xSn52QkH3R
 A5T2OSmWH0B+BkfiRbrCIMdJe7d3PApDVfWq3KeomNrbHcXZ6uFuWgG0F6uG4swHY8jnb8tA5Yf
 z/PfMXByyv0/3wLGO6OI7qRd7LVetsc+q0QB5ayPO2HwOtAjNNmxeGaG3yIAJtXj/mRXYv07bIA
 Tno3o=
X-Gm-Gg: AYBFou3Xextmd1nbo/d1hlTewUPolNYHRPinhSH6qG7Pr2DargN84CRJIIAfNdwVBy3
 6eH3yNDigQlpJx0nvin1rzY7Zl0I0IW4Vz4InaH+tBzYhAiIkMPx5j0hHQyVNATxQswPrSl+Xk7
 M638hDcgjMkXpxIsgmednGUmENK7ZZe7ror/xwH7Q6e+SpXp/2CxMv8yLXrQG8+dP4N77TPruKv
 ZY5qjPBo4BZk8eA3kpo+fLN5VHaf4rrJXx5KlhaEebN6/jxHoInHc5ffW7p4Y58eZRSZnLVzmYG
 ftnx/rsVd5ew7JnZ0X+SzzfR+Q5ULjgOaD6e2z7GK7/P5XCNZ6WJEvqaS3Kx86QelJ1FxC9pddk
 xMJKTj5xsg6INC9VkrDUCTNcwoMw4TTnOi3xQpAejQfDtWkfv
X-Received: by 2002:a17:90a:dfcb:b0:3ac:9925:72ae with SMTP id
 98e67ed59e1d1-3ad86d1bc63mr2195128a91.31.1792615968163; 
 Wed, 21 Oct 2026 13:52:48 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcb:b0:3ac:9925:72ae with SMTP id
 98e67ed59e1d1-3ad86d1bc63mr2195105a91.31.1792615967513; 
 Wed, 21 Oct 2026 13:52:47 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad83466e46sm3157774a91.1.2026.10.21.13.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:46 -0700 (PDT)
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
Subject: [PATCH v2 07/14] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Wed, 21 Oct 2026 13:41:32 -0700
Message-ID: <20261021204244.67160-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WZa4FNOgaBJxijYPxEpZ0kCkwfqlS4xc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX7GPsXTWEmvdK
 K5/SX4C0cdcafrKQQROWwVxAkgVaK1iSGB0TzK7IciDO/WEsgnIRifIO+7sZX76IU0oQ3kTuSOG
 q9bDnNvlMMpiev86hX0wztY/+sWbChc=
X-Proofpoint-GUID: WZa4FNOgaBJxijYPxEpZ0kCkwfqlS4xc
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad92621 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=b4MSL0WmfgirtTH71F4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX5dcoIaoNbIfX
 6JmpJZjejz+3jm4GcMzKcn7FPwJmbcHmLExebeh23uMRDlF8KzQtUvRKZjwZuC//gDsO2kKzcQ6
 gNNxi2nCRmObTzyuybFZmXzthB6gPYyTCXFQjN+h+C2kEhkQKkB8BkBO/0jaP7nMJnCeYuV1IIN
 ksH7JN8YHMifzHxhcXsPl/9HfiFkN7vISSIl1zBgW5LItTXklkF2DSuTKiCoPj4p3BxArV6wJZB
 K5SrAW0hiQxUEo0MdYyD3QHtWkzIImYPasKLGDGj/X1NrHDfRcQqTzeSuZkabTanPusYlXCvM0C
 67i9Djq5d6qTiQwcEORzqeqipCWmXYu8LXcRqIl0gf1CEz+B7cCbIN6HFtgmYUBaXhStxDY+d4g
 od3+TUVbO5D/dKScl72H9mRguRm33u38D9+jEeMW/2Ya1A23DIY/vRTH70YGq4QOKMty0NrW2u5
 uLOKcdf7tIiemWsz23g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210083
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
index 795c16d88f45..a6146372cf7e 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -367,7 +367,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -387,9 +387,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -635,7 +632,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -716,7 +712,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -835,8 +831,8 @@ static int hw_init(struct msm_gpu *gpu)
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

