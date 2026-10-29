Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B7606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Br0V/KZx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ISPqbj8k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5568B112523;
	Thu, 29 Oct 2026 20:18:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD57A112519
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk51x775169
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bFtglml+hC8
 hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=; b=Br0V/KZxbEONAsZDMOiWmikSrXC
 yOqLDitz0U60eSP45JuAnmwzEBTGSYuyoDkF4WGnZyIoL+XNO0RMA/RSCQ2Y6Xuo
 zaAPFS1laavSZjLn8UJVpkEorNkPZ8L82oAaLNkW7sC9DP/IchhNUYpGGM1go+lv
 bEiuE0/2u+T1Wptp/Cd87vud3SL4JBcs7uiLf0Kq+nlyGM3aUs88FLDOxKzFMruf
 tt5WZZ3o1jviDGtOg8bRXo+TLjlp9JewOE/Aj32+WyVDmPnBu10cR43mdp7F90oW
 JcOnlo6F7NxSD0/88nYTae/nkhjbiINIKjjZiX6wpHPjXSbE7lanbdlOqUw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmchhr44m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a06750c74fso1805199b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305071; x=1793909871;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=ISPqbj8kQZktJ052QvuzaogedfeWWLAjwqcgt+D7wQ61Ese5xnaXvEPrZgkoeJGYko
 d3YF/l6jGjInL9C85+El6NS2xii64BOBio/OUaw0gNVs+RwA0FZ21mysCJK+bQPAQRAk
 xSSKg7VAVVVX7MBud354bEpdAyKgTd9NpnpMOAb98Gy3ldmUvmHSC77/K+9s20eU1VXR
 EYPNUkPdiYg0+xunUCywmGL5LBFREBG1R2QSsQcd2ztZXgjXMipKky6UGnO5Vd4fgjqA
 sX8Fu3OTGydglPk0lYL35qcug6gBHBejNVWoE4+oI9opKrRYcLFKNKNvJpUvniDreZkQ
 wNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305071; x=1793909871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bFtglml+hC8hn1WGCAIjH4C7EGvJhD/mYi/y0qfEDH0=;
 b=nKQwEo/jR2FE/Lt9Xpe3AtEh0k52PyjM7LMoDIMXKFINoXkAlmNfj4QTtHKQTIK1kq
 yws1QU+O3769YEaQ3Y5D7dRDeBWrRst/5YZnvvpU4Ax5rWSzlFyMw7u8blHf0LZH6cW0
 8aBJ01sILQdCXnDM5Nzj0aWDP+ujCI5xDMcpoS5fK+uFh+mw91hm9QrnHopb8VirANvq
 oDpjD/k8cxZ0EC546yZwjauuNTkB+9BU7Ia3aFemtF41eJDPpnDvWsjHvlwsjUVmh+z9
 0PVOjm9/1vtSHcpGrfk2QfaFC09baR6IihbhaZ7NoA6S8uNISwFP7BhTfGZ7WiW02esb
 mMlw==
X-Gm-Message-State: AFq9FYImvCqc0nbKkgqovXgkExe6Be+MbCukVml6Yo4fBDC0xUi+vBTQ
 lKNowoQ4xGahwTvts7b/ozBvHZXEa5anl4I6qHGfYNGpKAYKiOPcoM0pGGK2zdNYHhUO1ZiHHyM
 LH1DNuxjRHWlLEM7/Z/Jui3PPYgoSEYz3EyK4BW/TRPVutXM7MnFFubRts62+F9d9o+mLlwSvnS
 ZXMys=
X-Gm-Gg: AYBFou2hK6oRZSRUu+f9PPud+o1m1A+DHL2nT09NeiSboBli8cQicaWt3vAC+1NxYbh
 PF1gLcPrm0A7bsBSyikKE+ppPpfXA5fky8PG0pPqXeRK1vUlLJIbpY5pMWdg7lvSnyqYzjws+5a
 i7nP1fq3KUkWETcbm/4a4VUbO3rUrTeyiZVV2dhr7ZOMIfi2iASutSEgOPext2LqeyJndvjWUP/
 seOeyPAlBfihHHbf7T8p8B+aFVSub1kjyJNWGcYK+27I1MA0/iOfeSZBmxVAI9nWsuJTIv5OI61
 nLU0WMoa5nG8CWkualih04MMFQaQsvMyM5EMly7YV1Gy35CihSoqpDUxPZx3IsUDIq7OGhCunBt
 yuPklzXC2b9QxY3bGyxrusSgc8lbYjaDlp0J7vFytVV7SwiWh5MwQOoY5lseFg1ypGhZ31stocu
 5P2s/SAAs3M/AFlJapvA793aA=
X-Received: by 2002:a05:6a00:6c83:b0:888:4f06:903f with SMTP id
 d2e1a72fcca58-8a9bf524c81mr153630b3a.38.1793305071468; 
 Thu, 29 Oct 2026 13:17:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c83:b0:888:4f06:903f with SMTP id
 d2e1a72fcca58-8a9bf524c81mr153608b3a.38.1793305071001; 
 Thu, 29 Oct 2026 13:17:51 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a98893c464sm252559b3a.19.2026.10.29.13.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:50 -0700 (PDT)
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
Subject: [PATCH v3 02/16] drm/msm/a8xx: Export aperture helpers
Date: Thu, 29 Oct 2026 13:16:12 -0700
Message-ID: <20261029201730.151754-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX7NhXQ8t+RaJ6
 LYY7sWuPQYc6UZvjqtJcsvhAdXCjsoUCAQhDn9yOp+zKmssbd6VRQ7u7Pi7qDB1mXZVanP9oXoK
 W5E/vMeZxR+2/RRrDkcEL0XF2HpPyDo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX72iztHcOsupu
 DArqqgsGdKSQW9CJgAHArvJ9A+QJGbHuX/HzDZIJh3BTUpNcOttS+v7l9oRHjq3XOxCIWK67YAN
 S9WJceFU8YY8mtOKNSnQ0Wano2kwVHLaDo8chI5vpNOsocp/wWKr3iNEFUChZg7I0GKQsCnodnx
 8XAFUazZZ/WUFj2NChGW22v7z/MhYPwhlgfAOso+F3ATO2AJbPKZchs4tpHuXzNuBVxPlAwo8YW
 aigEKR/1+Kb3hjPKrKOHcHohMl47G0gBIADqLoY7xa39sxEKbn0nyohB6Q/V4QmH6MMqs84bx4p
 S4creTwWmoXAks7brJUIhanQ8L2EM6lwkIfnS3ThFpt0L7dwELLzozZwNfvtq8kSwENnrsXbAd8
 SUw/P4Gz0fAcDy4KpcebPfUAkfoUDFtEK7h9OoF+p+jhWWI1AcQ3bsOpwBxaGPLvJGxM+TJUMQT
 t+CEngkUkZSi6oyvQ0w==
X-Proofpoint-ORIG-GUID: j8cjWG8Vg8dMhj7qxJ2UZMfsX0b3szIY
X-Authority-Analysis: v=2.4 cv=ffc4WEQF c=1 sm=1 tr=0 ts=6ae3a9f0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: j8cjWG8Vg8dMhj7qxJ2UZMfsX0b3szIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290079
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

