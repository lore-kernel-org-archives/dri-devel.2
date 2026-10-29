Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455B606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TL7vWpdB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kpSB8YOA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28F5112533;
	Thu, 29 Oct 2026 20:18:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288B6112504
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjYvs2138527
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KmJhK2itx3o
 q5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=; b=TL7vWpdB2TWnYmwes9aee7MBOeS
 XHISkyAon+eugc9Kq/+ZEHvu72csguQwJHCRI6PJdxFSc5pz9GynFjV2vdPHW1c/
 C2CRd1FrJli6JfBNCa/wR/C/RKa7GE8IJ6gbO5IcwIzXehkpxnpe87dE7XwVdN2z
 tG9NkcFYXhCsjpX4m9ornha1cn41EGKeo1qySI8uvy5j4lUoxCw7VgZvLY5S3efr
 lTQ4rUuXLqJupcz4jgORAm4NPuq+lyZxbRjSLryvqEbZcQ/vh9AQ1kqjJ0c5AxHA
 scbQifhaVfhmmi2qHhU4JyTuNyqfDBVbU0wFF9l1BUrQN7p2hSsOwrVdmNA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a22kxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:18:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae73921fd1so1973a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305080; x=1793909880;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmJhK2itx3oq5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=;
 b=kpSB8YOATHgFkTdn9spjcW3GSxPzfUBs/SXA/axAHaGloQ9C8Yr7T3QqJQgnZzW9xe
 NQ+kHgVuZLp1wUpGULeoEy08ZnHIM8qnHyRBl3lMwJ3B2WC18DR2fLEt8gdtNFayKi28
 cCQUHwI/CdXpQHYzIXaQx+oMko11uEHA8skWf818+H1Yo9LLNe339MVylvv4FgbPXjgb
 bQ3XR5SRxgpf6hCAiz3GUL1GIhQQ7jhoURbg7BnJgt8NdI9gbFSmHqy3hAxBOdKh947y
 sNnA5tiyRKSq27SiLC81d+4v0Mq6q4FPG0J1wztxIiK3kEAVqOykvnoeD162jD0FQmqZ
 JSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305080; x=1793909880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmJhK2itx3oq5CFXOLUBAEnzm33IyEvfIC8LefReZ0o=;
 b=Ttl5uNbSRKdOEHeYtxFoTKwuCUcIDPvEcJwqPXpFDGIAh8mTHJmu5x9KspVjI2qOIT
 aAAA5JQUIykUr5sNk+f4V/JZ1nfoO1zKvwlsMgIcu7gF4O60yiVZczznKnU0HClKLt43
 RbG4vevfhyvv0poFL8clHz6AnyZjFHs2bIMl0deGhTiI63brxCdnH7nrrmeUm5MIN5E3
 UlrWa72efk0p5mrSj2O2HF0nsVmFXMj6tVpzaRCSatID9pb2xylLod5qTCu9Y5ObAD3a
 yngFpdL5hxKcIpQP08rc2TMZ4nZvaOBICJoquQiX1lRgFXVrC5k0b0n9aaj/QkUZikQB
 R8pw==
X-Gm-Message-State: AFq9FYKz9UwwYdrvT0yTMwZX9FKngogpUPfXeC3WnMZNYTi8eWnUohU4
 QTaLlE0+/Ohyd54ABDWjdeFl4ArLtNrN3+ryl3Q1Yn8/RTHoVVWkg35oIjwXJvCoHFI2cg3GoB5
 yeSrghgC/61pI8HubkMhv5pW1gIrT/MTpQP13RwjvPyF4Z1t5MdETvIZFLQFCG/5u/JVDWVnw/9
 jwp44=
X-Gm-Gg: AYBFou327u65I9jkF4KlHxoAhfk0nHLTQKPXCLDyPlosQGYqIuMjcqxNQsgNM9lINVB
 cTvqjIfOKVIl5hNDbD9X/S3l4C5VfeabbkyAMonnZE7Gfi/kJdEB/L95a3NVFAGJ4l3ffPdtrdj
 8rCqpSHuBGnBi+EH/lubKn2HNH6h5KyWZTq6hcNuRJc0tPxEH+uiEdJGAe/LwfGS1WrsIxS9cih
 6vr+UyaVFMA+kI7gsdaL1esDG+StHVimGHdmeg7kHwiLxFxCq/vkpEdMB4f2kmdv6Tz+Cq7G3iK
 ke9yecAxELI+Cf6SbwA7NQhOgbrxTex7ak1SlDKsh0OrPUTBaTvGKSurjJp1yNHrpgmaYW2MIBd
 RtQGHUehht8vBtGdaB5cyEnpDWn7cdUaQA6N+pQ7miMLxDzHj0y6RtC5DaDvqJITv9r+jReCClo
 8arqjl2bx53j49gvB6XHhSQjg=
X-Received: by 2002:a17:90b:2247:b0:3ac:7c4d:8be6 with SMTP id
 98e67ed59e1d1-3ae89836523mr60533a91.40.1793305079815; 
 Thu, 29 Oct 2026 13:17:59 -0700 (PDT)
X-Received: by 2002:a17:90b:2247:b0:3ac:7c4d:8be6 with SMTP id
 98e67ed59e1d1-3ae89836523mr60516a91.40.1793305079365; 
 Thu, 29 Oct 2026 13:17:59 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8805ebc8sm104727a91.3.2026.10.29.13.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:58 -0700 (PDT)
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
Subject: [PATCH v3 08/16] drm/msm/adreno: Fix PROTECT span length
Date: Thu, 29 Oct 2026 13:16:18 -0700
Message-ID: <20261029201730.151754-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX4ttvUReZ0STh
 iGIbcshvoJecZ41D+Y27KjtZSGHbjhrJmWC9MxNeEG384HDshuMDZAa2HaF2bouNyF+l2pHrZsw
 YFobdMaxIvwUkxaJJB7PKKIwD8JyYrsY5sYBxShAcaRhLd1+foc/u3xrzNBgGZv7xdLfPhEyOEp
 LdXN8orZ8Vamknn0kN3pWHuxb5HSzLZJTXQAPCADjBtUtiy8iAKoJCcHshWIQsNOKSuCizCV8Aj
 jnQ8Mj9x2WOOx4Ud0qV5ILi7bbKScwXFoYrvfu15419dfvQ/fAkAZm5TFlK7aS+nUGmD2zi3ccs
 AY8zdLFU4zWdx+/YblocYCv21Or1U4gDCoq2Qle8U+Zt/DPwoL/AybIRzwmoqc13TEb+oep+Nnu
 ZbpDI/bUOcOL4czh2Dv0s/7VOWSnsEV5QSNd3GhUmVI1bXIL6dwUwhF2NhjgBdaxNEAqOjW6bJK
 ahZc2qdJGc95OfJF8sw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae3a9f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfXyOjsXakfp+yz
 uwlBXrIVAxNEX367lVDgV+cVqzUMLcCnclV1O5fdPLQzBsf5/IdVYOkKH+5cO7ov6jrIXyZAHwQ
 ItGSCx6bjFmofooJKlsUYplvhNOeo84=
X-Proofpoint-ORIG-GUID: P2JrwcFv6Kd-POJi5fxMNUsmmgNnSKSN
X-Proofpoint-GUID: P2JrwcFv6Kd-POJi5fxMNUsmmgNnSKSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
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

Don't let the length bleed into b31.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6b23d301c144..c49301be504b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

