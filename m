Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8A606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCUOI9Zn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aUqpFJWR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A3310E2AA;
	Tue, 20 Oct 2026 20:48:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C410E5C6
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtlbF2278770
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tTj9FU2l6Dk
 Q6RJx5hLFoO5Te3fK+1vgHq98PZkcDoM=; b=BCUOI9ZnP5ckR1npZRB3XXA7bpY
 5Kkn7cRr9dheeVMmDXZ4E4N4f7u/Ok2EcjFrRaLQwpM7SEvcMRuWEU30C3opqECI
 UNBcFRnY4D1y8wwJ08X+TOtHi2Ta3CvQBsYnMdcuw9AjuEoy4osasfm4i5kYFzGX
 IPzjVv5ulQHrx2iKdWOcVLYPgGVNIfyAfUVYcNjBMBmV/0pXhlKmzAf34w72tgzq
 Yhm3KVGMgl3NO8CMBOGTMtnf4qRzlKECSGSHyZzxsxry2Is2crzvUVEovFCBtDla
 Lcvej1P3CUv88jddrGop1j3v2dxGIL+FzQzhTkDwCzuQkzjU4JP356Q2HDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2a3t1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3acd21ba24eso56072a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529271; x=1793134071;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTj9FU2l6DkQ6RJx5hLFoO5Te3fK+1vgHq98PZkcDoM=;
 b=aUqpFJWRlrv38unL+qxPI0ZVBIk+3cIXcyyF0Z42lbsxhajYWW++XJ2jI29gr1Cmyl
 rphg28AYcK3YCyh6i+/1Kl1bdPb/u34FUi++EZwxQImfvwMtIDb/lOK5ovj2nV5vPakv
 0QjorGQFmW3tLTKZfkazwBy69CFAIGWSRiPEvdmn7byL1wJqhW+lenT4D4PZQeHDoMTI
 0VAbDlZJCiW5v8bYf70dnXKReIxc4kgr3JT8eMA6F5uAiRN6q2Oxierboc2qL2PdkoGt
 CCPcG7I2wCSJWIZNRdXySaMj7eaH6YUl4BhA+09Ff4aVNBko8Q04IIygtbXpXNwtya57
 dTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529271; x=1793134071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tTj9FU2l6DkQ6RJx5hLFoO5Te3fK+1vgHq98PZkcDoM=;
 b=0+YVaQyyiGIGZ+CqfnhYwH5nbXJ6C17lkMHic+0HFJFnmmVmSaA5IHZqZjUBxPBtdd
 VUuiecmvCFnbpEcLDzoDweWmCKvFH8aeecFzl96SBsCpeAwMOwKJxyBYGMY/UL53gSXo
 mskYfJpIWzLcvkvJ6n7YVG3L+daXiePym2BHCXzFuzXYioaySq/IbARmENV3d0g8qe8G
 fxpgOdTiNoeTuR7vC5qN2lAs6MAXOlmPILcWayqPHgHvAb1Pnzb4V8f7XdbdTCZPX2+D
 HcsUoTPvOogPZ4u/Yy5/iDNn9rf21UmySf/9oPBsQ0WxbOewyJN64n9OsmMLAoGZdZZI
 EMeQ==
X-Gm-Message-State: AFq9FYL7uPOblctUH1roPuqZCtx4q/6B7rdhfi3lYkIlqhbsUdwWgqOn
 Zoam0krdAcwAoqxnWanausN6Lb0ypMJwS1c+4wT1lPqGIvDZzkPnhX6jXrC2mc0WgQYy7k8zDru
 Zfl1IkNUxVq2ifXbnAr1R4ptb/nSTvry31Pi3XEt4LsL+2y4ORcnUK5QoPl5SRMFMQV9XY/bXQm
 vHImo=
X-Gm-Gg: AYBFou23X70WSGdkqWmPVtBYa7M55TJnYBNkoUcaq4rwFLgEtN3pUtIZZEXaxSBDmSv
 Lt3spVLf6+hFefgLhxlIEAElmORU8gU8Cbsdk8xmTVwbN+c8Vl/ICcxAbE2rdSkB1wnI957KJWD
 IS6+5ydTXqEK2NdF6vifVbGaFta7boitZh5PAl/4kySb/9ofnVBWpdvAjzBLdOnJOQtAgj7hqMs
 bVqUAQdKVZR2f68OusmhLAksEti/gnt/Kwz+Fl9y/womeIDkBO/drjJKA0pdAgNpbGaW5ph1vtT
 en0xBQovz1SAdwb4h+JQMxGDxH3x1pWpjvRK2E88cDY96jEqHuTH2U68tIJotf+fpCdIwIwKrLN
 nlpyp6NsJzqMphdfw1/pV+D8EZV3akhNTxRK0TbRVYUn5//8HZw==
X-Received: by 2002:a17:90b:1d45:b0:3ab:b39f:41c8 with SMTP id
 98e67ed59e1d1-3ad86f01861mr74544a91.46.1792529270555; 
 Tue, 20 Oct 2026 13:47:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:3ab:b39f:41c8 with SMTP id
 98e67ed59e1d1-3ad86f01861mr74519a91.46.1792529270081; 
 Tue, 20 Oct 2026 13:47:50 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad80cbe295sm906521a91.5.2026.10.20.13.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:49 -0700 (PDT)
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
Subject: [PATCH 03/12] drm/msm/a8xx: Add a8xx_aperture_acquire_slice()
Date: Tue, 20 Oct 2026 13:46:17 -0700
Message-ID: <20261020204728.28844-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SEeLjrzMH9Fy5yt8Q02Ee6H7loipTFk0
X-Proofpoint-ORIG-GUID: SEeLjrzMH9Fy5yt8Q02Ee6H7loipTFk0
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7d377 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PjapJS5JrKSUkyaTbiQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX3TakjthDLO8v
 qcqxdI+gyjBYExmxYFUb8k+G2JyWae0dpgG63d+TXB3Ul6OQJSyvavnyhuRvlLYRpKawgGiLHYE
 ci7+QW63uwtbhwKkN9wF2c6yE8K/x20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX7zgtCuaTPYuZ
 hE5IEEL21R5mT/QkXnvdIywV7H+/coFCQFbWPmXfx/UWyC6h8cm6akDH8D8Jr7Zy6fc69DKUGf0
 nzXONPBy+CZAhvqTfbBbYUY5iiHJqCoC+hcB+s5ti+2FwIfZoUs/PKqY6I118YpmAFCrSKiqLF5
 IvAfJ2hQtUl5BKTlRndrA27xOaL87iG3NdABm75JY4Cb3bJinuDAzMBEimYXPYIjepK6zTcH2+f
 Q7A9apsc9cbKYn3H/oHIw1Sf6smWckd3p/4lD2mQvMU8CgFnrj9PZ4y1WCMrsOpk7RokAhAsxts
 iRzQekrv92wpuDWK/oPtjmHUK2v4IHQT+eVglvKM3DVo3YkegJm3uzGoI7/Mg6b/zm/R5nmHdnn
 78XxTOXoPCgiPTDA/n2g37rx6l5lNZ7zHlMsa8UnmXCBg0jfePtSXHOMnkDNh8jdQowsu9dqfrP
 HAECN3ETehJcJobYxiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200082
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

The gen8 snapshot code will need a bit more control.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index fb000b79fe2f..d60cbfaa0d8e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -348,6 +348,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_slice(struct msm_gpu *gpu, enum adreno_pipe pipe,
+				 u32 slice, bool use_slice,
+				 unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a14379e26fbe..72c84f73157a 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -16,7 +16,8 @@
 
 #define GPU_PAS_ID 13
 
-static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
+static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
+				    u32 slice, bool use_slice)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -24,6 +25,9 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 
 	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
 
+	if (use_slice)
+		val |= A8XX_CP_APERTURE_CNTL_HOST_USESLICEID;
+
 	if (a6xx_gpu->cached_aperture == val)
 		return;
 
@@ -32,14 +36,21 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire_slice(struct msm_gpu *gpu, enum adreno_pipe pipe,
+				 u32 slice, bool use_slice,
+				 unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
 	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
 
-	a8xx_aperture_slice_set(gpu, pipe, 0);
+	a8xx_aperture_slice_set(gpu, pipe, slice, use_slice);
+}
+
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+{
+	a8xx_aperture_acquire_slice(gpu, pipe, 0, false, flags);
 }
 
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
@@ -75,7 +86,7 @@ static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pipe, u32
 	u32 val;
 
 	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
-	a8xx_aperture_slice_set(gpu, pipe, slice);
+	a8xx_aperture_slice_set(gpu, pipe, slice, false);
 	val = gpu_read(gpu, offset);
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 
-- 
2.56.0

