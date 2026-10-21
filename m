Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BE606A333
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hGz5YOPy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eKoP1oS4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD36889F08;
	Wed, 21 Oct 2026 20:52:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3BD10E3B4
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKfOU41671553
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bFtglml+hC8
 hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=; b=hGz5YOPy/udZJmTKSCE8pXcNhZj
 a9HiWPaY1U0PLtrD8THEtWGaMdT9vWSTvnJ5W062YUSCY7CFL+poiS1dp1hmipM4
 FeS9M1Xuzq+MnlZ2H81qsaLQJN2xvifl2MbCOt0p6nFGM2GdZZd3Xaa8J6+DCv7H
 NxbD+S2CieiD1eqp4ooJgBt4lkcsasdqMn2eEliNw41o44kYapFu7ka+dco9HzAe
 aLvUK/bXQ7IlfyayOCQclrKajfr97/EXlgX2X9zGiYnSafeIv1pMAkvdLV4ZN+uK
 aomgTC91HDQsRCFet0jfToCSdHZ0QduBMGO4LjPMuhMf5CBRcg+UwI7heug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf2cq0jb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e9501034c4so17331405ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615959; x=1793220759;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=eKoP1oS4m6M1zNL27I05LKJ8r54NMLo9JxfvtygnDecEW6nQuKB6A9gbr12k3pWs3s
 e6f7v+rxyiGEr45Bursfta9Hd/dlm+zpO9sxYtNbqQJtFLPC+mXGjoOw1ZVF4uarJzVy
 LGIMKKLs5Y9rLPpiL3aLzcBSmS7Fb0LPeNo1cX4jlA1jOecNn8qiZmEeG6CKSdTn3utb
 3pMiwGk4oTc0Jv8hfqgb+LOjc+f5C5JIqYOO8hXKx//c1nDpsXPxs37i0PybpJPMtF0Z
 h9arjYNuYxFGUo1ba1kBoslpLSWwQ98QPGqHvw6rqQQ6tMEFIA08SntR84V5WGvW7uET
 WgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615959; x=1793220759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=duXYkVjzx9J0fvW8avVsP+GSClAjtkdLlDp98QAGpTPLkWPV8m+n95SxEptofB6vyE
 h/UlXXomV/G0MTe5wYyJlgc3inD/rkbAqS/MIH1fvWTVahXgwgZ3N7xeZmrODoMSDYvM
 YK+jx2Kz9wy2iky7yfORUghW9w7Rci+ArwrG9kMzRB7kRCSkln29vUP8NTZ+u4G/EnBN
 nixWqoYS04VBwMG9tysqbc1UWgpmHhIzRz4RfB53xZBqrHBfNhUMLengzdtz/IROxsnk
 2xq8IJRQtl+eY1jnrBsF+lJIP4ic6Dx2x/tZZlwDxvjFDuWq0JZ+8OjG63a3VCm/xCYA
 Evfw==
X-Gm-Message-State: AFq9FYLtrLR/KeLDQGvU8JrPxe4z3imXTqbOgVtJzXI2l0EiF1ANKAdc
 o+sptzGlEodxRoEk1pPExz6GvjhnC6rdmT5C/5tiHoJyy4kei9KpkcDbU0eCvikmIXakJdSnUl/
 yWFzLquU++ADeTnJz+Iy5XwstK0jq3oVSO+tRIx3jEdf49yyQPDpFbErAHkOzhLe2btU6TNJwJ6
 t7D9I=
X-Gm-Gg: AYBFou0t1w2enC5OlQdCutHQeRexP481+CChXMq57fW4+F7EK+qDMG5+MWpVoVpVOKM
 v6EsgARh/DREP1SB7TwEV1dE/fr5tENOSZPeu2CfDMGgQZRRvO3VnksslqJxuH9wjOT/CDaTGz+
 es1k9S9fLCxVU7o2tAHbvSTgbn9lwhYdbSgtyd9FxvjC8qeVorHiTNfuSdRn780KElKsl2uCI5N
 OcfaZsqC0TH/fDUMOZKtWb6wlaZCECcJkdnA8Lz2bBkakd0OPYHrxsdNXy+i2OHADGP0UVwJ4kO
 CRFwgzpgdw7UCEwHLQ7vqCb93QI6r5RSUzZDBcq1WCVtwLy0HDDjklbUFKSSfheun4jw421baM1
 1VPdKSjzCX53ScVvc3vrjNDd/Ji6MLGspi8dvRK4Ai2qDwb7Smg==
X-Received: by 2002:a17:902:c948:b0:2e5:d33a:88da with SMTP id
 d9443c01a7336-2ea439fbce1mr26166905ad.16.1792615958846; 
 Wed, 21 Oct 2026 13:52:38 -0700 (PDT)
X-Received: by 2002:a17:902:c948:b0:2e5:d33a:88da with SMTP id
 d9443c01a7336-2ea439fbce1mr26166755ad.16.1792615958413; 
 Wed, 21 Oct 2026 13:52:38 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b3082basm15852275ad.3.2026.10.21.13.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:37 -0700 (PDT)
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
Subject: [PATCH v2 02/14] drm/msm/a8xx: Export aperture helpers
Date: Wed, 21 Oct 2026 13:41:27 -0700
Message-ID: <20261021204244.67160-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HLhWhYtv c=1 sm=1 tr=0 ts=6ad92617 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5gm8uiDlycvMt579jfK-pQ7oasu012RK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX4jFOfUAWhSYZ
 ypEVIiKyd8MrIHg/xGd5OksRUZ5fq27xtGiOH0eA2r8jTnJ00iCfNmzxAqGqwJx9J0hWeqpfb1W
 37GMFg++I94aiJ0kUcci0Y6vg6E3Qjw=
X-Proofpoint-ORIG-GUID: 5gm8uiDlycvMt579jfK-pQ7oasu012RK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfXytolYqoVCUM7
 tZv8ihU4aJy/9wFCb8LzQTv/gywZvaIkQqgQvF2GKa0B2Ars3SwCCXQ0BcvB3In4uTSfQvdErhQ
 C/b2XhphDc2nWAhwsetGbsAvns2HnJtalPuJjaZbx6u0fyM3HYW3LhHgbRdH8R6mFtvYZOlutmB
 gqZSCoDqHzmh57L2Yi4khzx8XT9ABO03XTgOTPOT3eqToW8XPuOft5E2q9EbhU0wtkheeF2ITrg
 rLiLtYSQMhYG4uHk2wJpZmW8mVAxJTqI9KLBdHRlsn6Wz+HaNMsM+fN34HNKND6JD+XcbEXLmnj
 I9YfJSTG5F7exsFzXChpKjYOErYhgxDWl3D/chGHICkQm2iXPWpsW+RphfSdojyYZTZmwDW2L7r
 1/qmf/VeN/Lf/P080nzxHL7CM6jOiTe4EvqyvOWEdoQ1TbfukHpiGTXsPT4ukEC3YNdDUjq1gA1
 4QsB9qoa7UUBb5cGPhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
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

