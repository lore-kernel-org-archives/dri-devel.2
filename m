Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA1D6082BFB
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZjKrIxMh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MqI1Zzcm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E550710FD29;
	Thu,  5 Nov 2026 20:40:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC1F10FCF1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeD5Z1474580
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SInwIZPjnz2
 EQrGq1a3K4NBPEM71JGzMblrmJNAiG0w=; b=ZjKrIxMh8NmIgAVRrdPwBfpV7+T
 cljSi4TeukyrqlLkcN6TZM9fFizYIbBPvIiuezs9jIUNnsUksA3g4N9SD0KlGhAa
 xifIUscSFakMjlEPkFRBN9v+7x5FzQZ5lQaJkDxRQhgjNL8/BTsNmdsMXL2mPSgY
 ChWaJLSSNoErO+GuAuGjWsTP9MWYi2Ax+1iFgQpAAb7RRCWU1ZjJA1k547irPsPI
 Uk3wMcGlsHOJ7GDUUDsdT6qj51UKY6+/Wp/HoZSs+R4W4wn2zAu8ebMZ+rXM/RQK
 YRC7g0ShvdbHCkvkfp1ytmgr6NylrgQeKmZf6Z+VtTttOCvfTydpVd3CHdQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbq4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b0a519048eso1813055a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911224; x=1794516024;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SInwIZPjnz2EQrGq1a3K4NBPEM71JGzMblrmJNAiG0w=;
 b=MqI1ZzcmFyvOoBx/0FHxsCSNsXEzNXVjB2tRRlEHrN2ayE3Ywx3NELNuCKZfFen8jq
 ANM41dX0cnr4Bqtso1ZYBv+rNRMcBwVIlUNH/NPUckMbrHdZ8I3rgjg2AFOm4GqZ6pHt
 6jqyhuDY2jPhpckrdOeQdPCCt0L7qhBM+UY3WvehEEQNWjqQSikw1qOcCiAM+M2OgiYA
 7c/7QW1BkScLQ9mFyrtI8KbC7XXWbx/LGbnDjbJ+ZqU+gtTxpkSnqQZJSrtBjNwg3m2Z
 73tHAihxBJ6av+KxRAcWEffhRPdkuf0/SW5QGz6Nk8yc5JZgP6eaJcahqleWjUEBHdH/
 QbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911224; x=1794516024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SInwIZPjnz2EQrGq1a3K4NBPEM71JGzMblrmJNAiG0w=;
 b=L8XCvsPiTnWBPigCmTfG4ybnZrHYBBwLPtRKMw1wPc94G7NNFVr1DxZCDkJBZSCj35
 wRKx+UmBGtNTc71vRHYkafXJR3CGDzsxl2KhZE+S1HziqKC76Xgnj5vzOUgA8KUuVRim
 F+/RGrV2f76abFbJe9Z1LvqVRswfFsvI+F9KPTp4xf4nVf8ejyFa1rNbOvSjNfc94IHm
 WbDCDlW+2LjGWJ1OJv7zeiUN8XBhBIxWyFKV5Rndc9z86jqf/ZSTlUbFK08EIaydHEXj
 QvSQFdy2L1XvLTnGC4NphTLY00zs3Yfjj5kpcbec18XCChXU59/veMrc5dhN59qobjOi
 FkVA==
X-Gm-Message-State: APuU4Z8UJlVwvrl831LFKwhXckjLgFHVYXzoLAltX6jgm6yWkjeZy0i4
 IR928RHzQdKcNKWF7Vqkpybw2gAiLEi2+GlsrDjnia6nWuNMkdy+gHup+HmrXGCQRHNxatRGDVA
 njZm+LBM3SqPb86GiUsRoKNLrrEPFWTKNe8fNZ0BinRJdeQllJuS5B4h9HFoR+OgDgYJ3RcI773
 zBn909zw==
X-Gm-Gg: AYBFou0s5RQGFzZ1eGOSp15q7pFripG7jeKbRErtGtD77uXjSjmuNzmcKqANxPVIRzr
 A6XUEjqITtYY0rPlGca/WC+HdhBUP39Cx5ErorrVg9J9GKCa00w2xmFyck01Q9YXd9jyIPs+zha
 CX/D4fQAyz+enhOyGU/xFPdFAM5nqRkNh111V8a2PPObmuuHkLaYZ3fPQ2QDl2TGi+hGujPFdnq
 wR8nwxQCR/vitZnu4hTAFvHl3QdMyOrQffxXc09AS/DB62rqNpCDvwgcjeqbzC6Xt9oduMAo38p
 YjMoS2PU95ekL+SL866sA8P+RQ5d9KKu0KqKu05z6CeIk/+JDhyyCYrFKkkE5m8jwuszMEpbWqu
 PWGJAHTgJ2qufDzJOCrkWurCfJ9RdluFIOMqG5Cj1rzJqlpPkNutjEo9sn1iRRrlq0cXC6LyoYR
 BaxdewZfb7Fq4lVOxfttppHsEzBCcYiLCntKPC0z+EIKnCRy5u4VyScjV1M9Yb
X-Received: by 2002:a17:90b:4cd0:b0:3ac:b2e6:3181 with SMTP id
 98e67ed59e1d1-3b0db6cd200mr176245a91.37.1793911224058; 
 Thu, 05 Nov 2026 12:40:24 -0800 (PST)
X-Received: by 2002:a17:90b:4cd0:b0:3ac:b2e6:3181 with SMTP id
 98e67ed59e1d1-3b0db6cd200mr176224a91.37.1793911223576; 
 Thu, 05 Nov 2026 12:40:23 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c8ff96sm598625a91.13.2026.11.05.12.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:22 -0800 (PST)
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
Subject: [PATCH v6 02/15] drm/msm/a8xx: Export aperture helpers
Date: Thu,  5 Nov 2026 12:29:28 -0800
Message-ID: <20261105203057.66520-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aece9b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: l1Tb8osGyTLSd4MTWxOxqPPZSup2oxks
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfXzVWyhvnbgE48
 lkq+zqAaK/F4LGfQ8S/aia8OauOty+KIP+AfRDWpTBotAfHc93O619o9DrvVHXFGz4JL2A1Xuo7
 BiXY8/YY9L73rYf0pwADNQHZx/zMIGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX/wcghq2vcU9k
 4ngHvDrgxC/F5ae2YIRp+pg37ose5JxqVxraexcqZbAQkhfDJb6UOdEtxhwABOhzxG1A930vc6s
 O4Os+mA8Ws67Y5gV+CTHHnW3GXrTTuizZJzJmWb7HYkOoJ9+rne9+aYYLcpInM/X9VoqRQQ5jO/
 ri91kI1lATUskaH/uMkHUCsHEGrGAq3kackVVarZhcN4SnzkuuoHqZIRfOlOmvJBaAinayGWbeo
 jdXF1v2cQrvd4oHQLEdc8NCw9VJbmJfbCbxp0bcT4ely9dMuA2Gwce90FnlwJ+xkfdi6eGaMb+k
 JFHSjPR7Qe9E/0b0jk1oUw+C+ZH3KVSS28pE0nQA6jsRQXSPTkJCF2Kh8OUnIhYMgghVUZM2sgH
 dhBGXqhxoqmKOoVQNavLnX56LVRXrukD87SFKE2zrlWNMYYF7VaS5YHlMvVjQybimEMItYD8CGY
 PZ/FUs5PSeqDQB6FZBQ==
X-Proofpoint-ORIG-GUID: l1Tb8osGyTLSd4MTWxOxqPPZSup2oxks
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

We'll need these from gen8 gpu state snapshot code as well.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index ab4cb43e4a54..c58a2665e9ab 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -346,6 +346,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
+void a8xx_aperture_clear(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 25ee3ac16ed6..82cddaa7278f 100644
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

