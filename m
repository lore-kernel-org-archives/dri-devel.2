Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F0606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cg/JXG0d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cjZmAjCo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C6310E59F;
	Tue, 20 Oct 2026 20:48:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B53310E51A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI72vx1862616
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bFtglml+hC8
 hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=; b=Cg/JXG0d0wGJqusJYFtJJwctqc8
 VBbPhdK7OVglHXm2tbw/wNHLa9K2k1B/NtDJ8q6rSzK4H4+fMCaLTTyWU64kQ7QJ
 0h30pNGE1mSaCu21SasAQ8KGr47+6OGsf6d8QH+oTHc58BB+zTXvWeUJNLgQmXkw
 bFXcSbGcfFITPUVBTJwa6WohXlYiqIFpnmEAdXJuXeIhO8FtYDFB0SdOUE+TuWI1
 9uaPpM+MmVrtybimn0ZwR1xSL+BcMQUYt2efj0/vtJIjaF6S1gQR8gj89LORE1nG
 hfUqfVGcaASQzgN8z2LYrjjSgxe66ajvob3w1wXK06RnGzu03zzOgVv95ZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0ghge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so35111695ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529269; x=1793134069;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=cjZmAjCo67SaredS2jnWjxHDHArNQkqWaMFwFgtcp9uLV+f0oJwXqwEzu4A4nvDrC8
 b4RoCxrpTBWiJvP+gWnkdzhUxAoTPrrJsTie+bk80vlc1gEl5ISXpagL/IhNi5RO8YrL
 XQJCbcvoK5IXTbnJ9AzbqlXkkCQvSM//hbFRZeZD9tOsV1s3hwANlbWrO1vfSJsw6/M0
 haMiBZcrHDIpqPwls4eqWDdYfZ+HXqzYM4dsx6ttIT5cLwzeWM8e6FH9pgSnBEuqH3qL
 fk0klOUcNCSpJ8dmNh8pT4Nhe1KgjBxi0HXqMu0K1pnWUeQcdh5NPmJEzOfZ6Y0PlnWd
 scnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529269; x=1793134069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=YvyKRF9hudV85+tumCi6+MZordx866qTyy2Mg7YqqlYdMSCSruiL6XX1tfAovyd13r
 FPeEwW6X9l2aYz19c8GNsUARqrCNm4IuZCvLP1gaKdSJZ9ezoDfTMfocCf668kAVsg0h
 Lz3Z7zkmqet143QNOtX/BzE6kaxxOGkSpu9q6S4ktWmCmhQ2Dabx7ec3LwYb9i/L24nP
 d0J+CFy3cRO1M0EL9PBNKunomtr2EWWxnX1Pujyz3TRmHLBcqTeVL614MaFJcTt6sRx5
 Z+XDssXxr/VCKsQDlDqUGBcXsQsihNwSbDeg+LGqaWfH7eDQbpdwB1S6nlqhx0etHVWv
 4LlQ==
X-Gm-Message-State: AFq9FYLLXfoGxG/1YQlADkz4HLzOZ0Ru1KskXX688b9A048bzpLOoU0/
 iV8n/+uM9rEKf0CDhe4b7/urjGiHIodyIu2km1nM+n3FKR+DBmAQXfbkIgSu5MORuhhuh9t2wea
 s43yRnv3am8/Wa3JgbtL20P4gOy2Ilz2o8scXXzY6s+HA9/rFGUqZKXUsGor1fduvmnuaJk9mWr
 PX8wU=
X-Gm-Gg: AYBFou0m4UNYk7gv3ZK9w+eAJvnXD2Bct5hbu2uTvz2M3MO1d+fI3Qy1ASdXTSGzGbP
 ROLg1T0WjOTxm53AWONyI9Tl3I+t/vwDA14R3sqkzW/GZgasHhRuiTWBIIydmquJL2XcvxCN15c
 11XAoR9SJPak59sQt6U/SoQwUqGVX+vD6m+YLXCmsAhCUncWzrdXpEDGs0BGT0Q45cTO9+VxxdB
 coFpvKi5JgBsf9E/MclNOgouq5u7xpf88P/UgSya5HGY1yoCQewHd1uVwtHpA1Y9NWSG2zK7/s2
 wKNwzMt+BF9mBD686zVdZNztolGxFxRRnZ0KXyFMjK+s7n1FNCIOP7BBOmZD8uB+e5GLwUkaT1k
 yv2iaUTFrpRNT6IZo7JWgz7IjDhckazqhH5CnHg0Yo1Be7rkn7w==
X-Received: by 2002:a17:902:ce11:b0:2e2:e24e:a88a with SMTP id
 d9443c01a7336-2e9a68d91bfmr94432715ad.22.1792529269145; 
 Tue, 20 Oct 2026 13:47:49 -0700 (PDT)
X-Received: by 2002:a17:902:ce11:b0:2e2:e24e:a88a with SMTP id
 d9443c01a7336-2e9a68d91bfmr94432505ad.22.1792529268651; 
 Tue, 20 Oct 2026 13:47:48 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b434e67sm3125145ad.27.2026.10.20.13.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:48 -0700 (PDT)
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
Subject: [PATCH 02/12] drm/msm/a8xx: Export aperture helpers
Date: Tue, 20 Oct 2026 13:46:16 -0700
Message-ID: <20261020204728.28844-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX6jdhfBPZLQ5R
 Yb/NQu6j53I/HwJBe6KH8LeapQMSQ/s4r7DDyVHvkU45JhY8kQC080Qmv3q6gTrPZLeogEMV8i7
 rxkBgs1lJDfoYKi6aYY32iIZASsiTcAfwpgkaHP60nyghWFF0DMbNqern9In+s+FwATqlChj6mB
 +WswXSgpsg2xIlRoKhs0EMtsiUbChJH313Q7SfrIGcfbYHjKB/J7mgQPHBXkfkVBR0AHllOvlrL
 GDYGtKfZLLFiGswNI0CKbV141kxHvBTnqPHlqIJy4xeW2Yn33dBqljS/SB1xf1/amh/nJJF3VWE
 kHVG46h0mYrO+YTRK1/YS9UJnfAfr5AHq/0GbUo/l9goSD4HuFwq099c2gsz4zW4cvxFjc4vZEZ
 qF6zfkN+fU9d7EAcWip5D8Qc67YiFfdFuvO44GxKzNx0qPRZ+4oD8gmkgQYtypAW8aH3Yg0cZSm
 p+2/2Q1FQPsz5S6F29w==
X-Proofpoint-ORIG-GUID: dJaNbDEugW5_VsvRc6-mGHOaDJs7k053
X-Proofpoint-GUID: dJaNbDEugW5_VsvRc6-mGHOaDJs7k053
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX8W8EM1HGJ5zL
 883m5CgZxoB4C0qh//vmRmhSH8dv9PGnaVfpg72Ad1Qbxi7DVIYduhJ2AkSVf8/LeizmgZOQ2mg
 aK4ZhGry5K3ZMiKq8TgAJYmRmw/NT6Y=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad7d375 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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

We'll need these from gen8 gpu state snapshot code as well.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 81d21acccea1..fb000b79fe2f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -348,6 +348,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
+void a8xx_aperture_clear(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e7d04c865968..a14379e26fbe 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -32,7 +32,7 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -42,7 +42,7 @@ static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, un
 	a8xx_aperture_slice_set(gpu, pipe, 0);
 }
 
-static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -50,7 +50,7 @@ static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 }
 
-static void a8xx_aperture_clear(struct msm_gpu *gpu)
+void a8xx_aperture_clear(struct msm_gpu *gpu)
 {
 	unsigned long flags;
 
-- 
2.56.0

