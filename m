Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740C606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j8RRdlVR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ms87cErg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89D411220E;
	Wed, 21 Oct 2026 20:53:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17401121FE
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:44 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeT7t2161258
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0EyBq73M3y6
 JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=; b=j8RRdlVRjDiQF3pXkDomo3bZ/5m
 boEKOmUqNRzkpPAz2iq0gvRAF1+yng7ThA92inWWQgmJDhKLuetjY6bDNnYzDgoU
 g/ANetPkEQ2GLk6GL74a+rQHeRdPTbdjlBxrk2jtZ9xugkCTae4cC1GM1onxOBmW
 zuv8DvvU//6z5jT32AWP2M6EVTUTy0EsHDkWfsBqsNOtiKS3z4TzfK2VvzsTUlBZ
 VgSKPYQUJl/bvDOzrZBJnR3QXqkMtiNeTUZKLR1PMM05Hyuf3c9R392fRlXlzzVb
 RXxDikuuqk0oDQc3ZIKeHAvlCRRqYdWFnZXTgKGE7DxzcnX7lArtCiS3UOQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3gpnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so1118162a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615963; x=1793220763;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0EyBq73M3y6JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=;
 b=Ms87cErgokhEZqRg9ZYmS/xxdjTX9AzgVmQyaGbcCkwmXqr/ZRFfsUWalq2qAg07/6
 kO8346jYnlHzk7QBYAQ2QvPMpk6kCBNg9Etlpc4XEA84i7pMUINDjxi5eXSPHq6qyZ3l
 MLZ2IAdnuyRNIHykqKt2yn3NNzERRq8Qg+GhQwv4mSnZ04svGn/DQ7zrvZkA0GWVGXL7
 STIITBvt5dOYeHOnmIVk17Vd71W8zlW3mPU570O9AJp0IgfdjjkqWYwe6xgSf3Tsi+4E
 EyqEYT2WOhzoJDw35grcXP0//OzW7yORFbyKawLABpxpGAD7N7mGdrdg66L+POMMqx3F
 Lw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615963; x=1793220763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0EyBq73M3y6JMi1MhPVn67wbOnPe2w7nthY8a8enDx8=;
 b=JjWom4USopNux3P4b4oKDuuybdHR0pwZ3wTuTxfTJdJUG5wuez/txCatRuWtLzl4vj
 QZhqYlHbCkze1WbXYTpUEmgYeyqEsl34ZB/Sv/Av6C9PARBD9nkMcMb3RHi7Z6aPlovK
 xLamjSd3hDC5njkdEqK3bKjZRldGFpwNbNsIjAtXYpjwrSqOscNIsHZ5EN8KAi60DWmB
 mATJ7H6S+AxhqM3vVfwbDmqOJ0zoiJaCgSzoOgcxemd6dMfcmigIAnTXhYQQDtKfVTJB
 pOXP9+gzGAsONpAxXUOis5MdTKgN7zy1/xUY/RsspWbiOIAmOOgKk8kUNDyLhDc7IEQy
 H2bg==
X-Gm-Message-State: AFq9FYKkYYeQqQnHsWsLneIgfjuTWJa276zu3R4t8YBC1exP58SC3SG7
 y+p2613cM7G46oo7W6Jd6NqjvvUIWh65zq42MpyC917xOv0YliXukp4vWLXOh4jcEL1J54wLdcZ
 On1uCAo5PkTp+rbrzBj0OBt/k7klqpNTC8/EuB3Z2lLvoVnpFhxqC9zfZSI/Sr/PxUsUqx88Ju4
 UnU6Q=
X-Gm-Gg: AYBFou1hZqr26FEcWSQtbHdgO/m4j2Am4+2wdhnXEUwMr3v3TAZPwpKdDNZgC9lzuju
 F8eUaCQjVwIBBmlqbevPACrEhu287aSG0Rv1CAYzNoFHJFa/H3sjTj+PJGpso6qZX9vgKIOVUfD
 ZeYysbDvpsYM1FhmQQTFL+S5OdxP5AK3r86EYzbOpQ7MycsOcbASD9yZOCcZ9R/X8NDQKO+O4cp
 /tSICvwEZPeipaDTrPFXRZoSdK8/zPVhRPn4wk0NCtsOmSARC9iVh3i0XdPzRN9JVJWXTjdjKvh
 bqBizcl+rL8EJLzJvEs8qQQdB0TQ4DyJ+oBzfm6V3wuGPPjwndxHljG0nRU/bzwM5ZcUx3CgbJY
 vFJE3HCQ6RocmYJt/nsMXxjfqutK3A8bFIeffXgUfrEXMQjBZSw==
X-Received: by 2002:a17:90b:3148:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3ad86cef016mr2623546a91.21.1792615962615; 
 Wed, 21 Oct 2026 13:52:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3148:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3ad86cef016mr2623528a91.21.1792615962211; 
 Wed, 21 Oct 2026 13:52:42 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4887669sm996115a91.2.2026.10.21.13.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:41 -0700 (PDT)
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
Subject: [PATCH v2 04/14] drm/msm/a8xx: Export slice helper
Date: Wed, 21 Oct 2026 13:41:29 -0700
Message-ID: <20261021204244.67160-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad9261b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=HwyinNJ2ww52bJxqQkAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: MAUEyOnnBPp8x4SYSZg8ztoorC-UHE-U
X-Proofpoint-GUID: MAUEyOnnBPp8x4SYSZg8ztoorC-UHE-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX7hWzIlLc3TQW
 q2ocY7a+FcmBUqKK1E0j2VI9uiVKxolD2aH8P87gYp4Sl6mCoyAcH96W+I1NfnbIZhxjM85zqa6
 7/v6j69ynMht3STA4Wch1B7KEoT41gU7cAk61qPBhYvoNm/sGllxAcZVVqod859VhuTAKSfelRr
 uVqlvtevjvLQ13wZo223LNUhWsBh0npmodVnPuIUVXr9sEad8SzTxG5a0dgr0WMpW7vHefTTWJx
 mWspOCRxqYkNYHnJMAuvX/UUiis2g0TOycObEtA5AJHU+pvH309alYUQdA8yl0aQ1RFDzOwVhVI
 uq6FkMtd2bXp3zely+SQqs1F+AwZrY46/EqLakhfHDFgNLGJiV9lrYmGI8kO6Nkcvl0pFSVhB63
 +91nvNDUtScczYOsjfVxaz/FyewJ4qeS5TKYeL0P3WXrTnZebYgP6M80VGQKrdGyUjeOaoNKqzH
 uicS0HfyGucCLWVAmJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX5IHRrFYLxRhu
 VxpOifUGhpSJ5GcAD8h75cd00OZB2ypdJSGE1p2FtWaflNtUZ0OA7KfS3ngUbIOlYEvWOre5cQP
 QulhvoYLJ2U7UUpARlEuFc+4PXyfwcU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Something we'll need from the gpu snapshot code.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 2a2ddba6761f..6b23d301c144 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -359,6 +359,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a0983e2ee641..8e91edf16ec2 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -127,7 +127,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

