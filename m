Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBB606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kn/P3fSp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jdgsc/uO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380C410EAC9;
	Fri,  6 Nov 2026 23:23:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C46110EAC2
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo8Kw3696176
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UkojfpaA9Zy
 AFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=; b=kn/P3fSp3Iamg4K3HyuXzextN8o
 /dJGS5T8/tpgcme6ips0zNLLqDVK7dj2f0CE7r3FFN2o3yHgbGjpfFp+k8fcpQe+
 Idj+xlUbxpHKN+EqZk29eu9ApHbhYU/K4pNGiIG6mdGLG0AJ3TKLlpxeVeC6Li/s
 f30iap4dZ1VkccIGL/jX8tl3r2OfkDyklBZym1qLS89m0iCMczJMxLFKqqaDVTYe
 n4dJ++NLX0kotFiDonZYv87EdGTXcfROdya8wmzrctW9lRb8dBpudG88Dgu+JNyj
 BNp/7GiiHvZwGEBmlh02Nr9JSGM60NnNWCCdzAy34xI6+5VBnUGGs2zZ4Mg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqrr3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b07b06027eso1513949a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007359; x=1794612159;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UkojfpaA9ZyAFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=;
 b=jdgsc/uOPmyCYze3UBNfGVsUozfKLREzmsIHhE1oeZhoZbXCW5veMl1f1yt5E32qnd
 4CglVydemq/1UniOChjUbF6GXU7Alyh2eHJ5bBAWDI42xBZ+8LPCjmpZAva8lyvZvo1b
 FwAjgPD6f9+62TtckE1Pl97OE27b0t7BlOuKW/r7Cp9uRaTfBpl3XJ5U5wXiKZ++WoRT
 oJ+sgOQQw7cQXEPtsOrJwCxWLEdUrbo7uJOR0NSXiz1ppeHF/LLKWgp0vWoPetm/rg6I
 /5uOPOWxsPyLkJMMG0+uylfO/ZdDrwVzkpkzlyyuCQTPQmXB5FzrbFy0BftHSLClxa2h
 m4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007359; x=1794612159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UkojfpaA9ZyAFiSTVcPjf36KuXa9Qn7YPnWuS93EhrM=;
 b=QabXMRwVdyMAFag8+x4cQkgzJUjNIN+Isfc3SbL6XyZkZ0tkuiqbnvoSYYbTOqMV5F
 id3vPhuI4hme/yCOSg+4bJQpmf9ngnRoz6pt/40Q3ncaQlexpAcRdlelqPuHnmPAQ0Vq
 1LD8FAiDl9lGtSvRaCXi9KZa0nVpNuKz3w/2p8jeaPlM0wMsdQo/XHhzv3pHEzfsH1eA
 EmLMmGjcXUTI6TXw1EwNMFyJg2r3zcAEus2NW7IZl4RuGQfnKojmrApzHFUTiCn2JYOB
 YVHQF7NVG3F1SLDvwXv9F5ws9vW2MkGdijYh6a4RhiedXlKS0PWMDHzlfng7wJNFdmjm
 Xqxg==
X-Gm-Message-State: APuU4Z/0IbxYyWG4tvS/4luc2mcgwG75zb8QHf9unyfMloPMKP5vyfnz
 +OT+VSCREp07aqzHkVee3Vyjanr0fnzwGDocw7X6lWHBNjU5I04zO27YkhCnizlBbbVFToYol5O
 rLqw8Tzf6nKRR3kZtUbvlTGhzAj+Fv//CLhoLJoFyBCBSrOYT8UOWGaor7Rys+vLHHMWjoRfaWA
 BP9aD72A==
X-Gm-Gg: AYBFou3H+dFgltVHQ4x4j6d5N0tCt6a5tFMEbZljwJ9PSsx31Yz2WALi1u9cFsGJT4I
 lIwyqjRf7QrSELZono0njF+bq9f5nYHiWyCkqkJ4/ChKb1wtCdbd37pj/1f3CMbC8Nj/BooQLF9
 JQNfdgPNe8CJdaUINDoAeEK95oaiU7Gix6K3y7FnjTr7vWnfPWg0qLQOD7xqbOEbKYQA6aLVZkl
 krWSSIrT3ZgX+NNqqZtmLF/UQuaig/thTxtET6bd7jJGtm5M6dUz+4mY3s0PSiX1tge/YLiNkDD
 dE5D+ZQfkQzxrcGni3WY0msxD2pQj48xaNhNhu0dt2WLsgcccy7kQ4tOmHzBOg1I9yNX0RSfU+Y
 z3hvoRTXfnZDOyXsGSK+50e5+FAvsZxt8dzDCfa/83CV5V9g6p7kasFtEzheQHRw8hmKYoRrjw0
 aEZpKCO3lOnMPaLahawJDwpGcDrFFW5g1zHWLCzcAN1FCYSZpeHSzuprqSu6oS7w==
X-Received: by 2002:a17:90b:33d2:b0:3ab:884b:65a9 with SMTP id
 98e67ed59e1d1-3b0db6c0f4bmr4053113a91.25.1794007358798; 
 Fri, 06 Nov 2026 15:22:38 -0800 (PST)
X-Received: by 2002:a17:90b:33d2:b0:3ab:884b:65a9 with SMTP id
 98e67ed59e1d1-3b0db6c0f4bmr4053083a91.25.1794007358330; 
 Fri, 06 Nov 2026 15:22:38 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058a7e3dsm715121a91.11.2026.11.06.15.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:37 -0800 (PST)
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
Subject: [PATCH v7 02/15] drm/msm/a8xx: Export aperture helpers
Date: Fri,  6 Nov 2026 15:20:54 -0800
Message-ID: <20261106232220.47602-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R8nkqQAl6xwAUNt5R3fH04L2sr9EMFzI
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee613f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX2/7M58/0TGUe
 IU6WIPEdnhv8eXygVViM52ifhR1B22jGF00fUumMXAGSZXJO6M+ok/4UAaD53sczMTWpGrBYCvi
 dl1jV45ZpgnfPnTb4OLPE1wJD/+zeM0=
X-Proofpoint-GUID: R8nkqQAl6xwAUNt5R3fH04L2sr9EMFzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfXwlQJoXjTSZHM
 ecx0gMxLfoMBgA3WZwZSaet5aDc1OSFRAHCKZlKf3g0rpaxyJGfC3mphDKtZR2sORksoyxesJay
 TIG5aA2P3Rycoi5Yj92/Hul4e9qk7ozyTiXbesl2gVzHrgblbE3Ufw56OAgH/9pGURMUc03CFiT
 bnZ3d1DHbYa2BQArLZyvnXy4oOwSfEThzRPXMOIpUNtn7KPuUrOqn2kr67F21g+I3hqI0wY+wD/
 s6k4vAtv8F0upTy4ogkjM+N7YBCWyzbnrnzAsDO6mqt6FcrU7hdev3FbXK4lWcGC36IVT0ZgrBf
 RELrUvTiWgy7FYD0wALjEvj4QwSMCo+QNkA8eVFpCKJ5C8bOUykDEf2l1CZoElprAD4ymjS56P2
 htNYJs8esOOsrBopdj+uW7Hjofb0o0sEmGsKMGI/2EMuA2tQNvmB/Q1mKCSS0JCNZL7akvibcPq
 pL2hmCrhDXv2OpipYAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

