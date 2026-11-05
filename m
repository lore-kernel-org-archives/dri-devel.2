Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7F606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n+o/eohJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyLFpHpL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E8B10FD92;
	Thu,  5 Nov 2026 20:40:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C73810FD92
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeCon1474559
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TdGMxBvX9I6
 tC8AE9/vKCHVlLgBTvfhgz9mh806xJUc=; b=n+o/eohJGHAnJJv3gjCciox2RrX
 Y5HGuXhCZoBpv8/0bWbxU4ayg5VhzaIIlVjmQI8zTr/xo21ey1yftOOuif6nQ+Bi
 pMI305hQoPGJ8ld4MicoNsNyDZZLgPYOi4ZV23SFiRM48x13qdWvcxBgalFBX7X7
 kWxGAKqOZMpPKkliC6XtR3j0LdDNQruFODcJadS5cQ2Qi7Pd2GnJILbSEzP5/8jD
 fzzlyCemJkDarwvrtLF9dudko+hs2TmpVvZnaUIaFPUbUT9bdYaQLNTEWiZSkZFH
 oIpWGTOcOCEjPYmanoedgy3ljiouvkNjH3okboEvKkC51kfbmKItLQicvMQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbq54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ada6ccd402so2101438a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911228; x=1794516028;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TdGMxBvX9I6tC8AE9/vKCHVlLgBTvfhgz9mh806xJUc=;
 b=MyLFpHpLPcXneNSuIj8Xnu3DZt3lyMhuf3EN7vAY+ouc1XtEBf0bcrARrjaC/pKfoS
 Vz6FDFBzZLGNsUURiLo7Q/H5Z18/oZBBFF8jmMSMcgCaYb3uCjw/RqNwXSzXx/LqsTPt
 99oihHBMyJZNvC0X4FPX2HwON4kYf3Nz0sgQvzOzaMymEbwEEk9X/fhwbx1j2E/PS/WH
 NnKIDWHooVHVEz+U2v2OsH91dzMFnn1ABMTgq8bwnuGMdjDtDMlLg/lcGr15O0+I6Twk
 0Oqj2Uw2bNm1NvdS+DLczz9yufFiYM/qQeBMUcOi70VsIVGu2ZwijvEw7uOoALc0512o
 yGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911228; x=1794516028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TdGMxBvX9I6tC8AE9/vKCHVlLgBTvfhgz9mh806xJUc=;
 b=XXhBnZgnnqvdjyBfFkZe5VpFDnH3dSBN3wQofhGmfdgXJIDMDZQpynjDMG3VVgxdBw
 hLAr4Pbc7P2/hmLk99LackW2260PaMAXF54tEHqGkLbFmbkkBe1PnSTKVdxHkl3Nh7N0
 taVVwzxH13XQ3JRU+qNufehtqxhL/BBzvXQ7yxhb5jXJYCCZK69kKBCCBKEPSXFHPfrc
 JgB3dcGZV87E/IIYfEvvsrMUwRsJsmAvHng2g3dubt4eC7FaiCErgsHzjIdnXXtbivom
 ixRE4fPF0GVUKX1fVWD4aMJwI7Gqga3G3GpEqEiZeFvNhKhPXsY4EAuWBQSaAL34HA2N
 11AA==
X-Gm-Message-State: APuU4Z8sLt4x7PRwqQCmyOZm2t3HPzPbzJDr5S4kcWZF4VplTlfARc/c
 xK2qoBCFfAszgKZN2zL6U+ws4QX0PSrUP3zOHyY3ZpKniqhkWxsbptVj5ksUKKAbyM8cIOVZhl3
 0ze4CxZ6R00ZN22pYLYCk78n9oDffd+gj3A10Dxi4rsn/WHY7UUFnXIXUfW7mKf6r6gBaZGITN+
 NgV/UTig==
X-Gm-Gg: AYBFou3VR6e5A7dWxtyFDWa9wUDTmVzDuipFUEeri6MTRO0aEOOLKsIjzBBpwvRf8q3
 o67g1JYPsKbOEdbC8NY8cvfMdB4wYuD9IQ5LrdsXeVMXQYeSHHKVevYXjSZEQtdL+Of8Srfe4ZD
 K8A20z2e1kMDrKw4F7JM7eoVZfmovZUvkkTZklTYfzKg9A0W3QtrV5l5MxZvZsEG82vLa8eRIoA
 MXeHuWKjRC1OxiUGIEFEbZdJKP6/Bpc49GawWyxAaqIhVh2+snx0YsQQSeQo2j8VYrkg/VSsSI0
 TULOFJFuqu8VbBhoyGe1UMJYVkUHRBPP2xDNGVxT6rWMU3RyEi1MdOmc3BAdlCWcG4qBvVYxdqZ
 YumCTjtcosMx2ujepT0ocJ0PGBjNL8S+viRpz2insKHlHWL2vmvcFLBbe2uZ83MI1VEt+QlwZdl
 8nadvKFUfq1pABVsOEJS9L3x42uC0AdBJ9I72sYmxpvMhm6QG+yh2EOkhByrDx0A==
X-Received: by 2002:a17:90b:46:b0:3ad:9ecf:2b88 with SMTP id
 98e67ed59e1d1-3b0db6eef82mr149893a91.19.1793911228371; 
 Thu, 05 Nov 2026 12:40:28 -0800 (PST)
X-Received: by 2002:a17:90b:46:b0:3ad:9ecf:2b88 with SMTP id
 98e67ed59e1d1-3b0db6eef82mr149867a91.19.1793911227888; 
 Thu, 05 Nov 2026 12:40:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b313c0dcsm5140693a91.1.2026.11.05.12.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:26 -0800 (PST)
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
Subject: [PATCH v6 04/15] drm/msm/a8xx: Export slice helper
Date: Thu,  5 Nov 2026 12:29:30 -0800
Message-ID: <20261105203057.66520-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aece9bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=eauOX4bcPKZCCnkqRxoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PMr7fWXgRrPwOeM6BF4gRNQyp5S6pI1u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX2mDCD9pUfZyD
 71UNupXPR9BSH6Sxra7nrvKLl45SN2IQxQGiqxyUOF75NntIJ9BpAt32sbskqisDOb8ZAdoExJP
 ZmBczQriY/E9vAUCrx6sgzFq7dJ8E30=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX+ZCQ2FOVIjWo
 JUbauuH2WIRaVey8uQbEkunj3YQhWQUezTQv6ovdKiSh4lSYWfwbyndKA2xvXWNPxEgo4AdNfFL
 z2uWP5Yw06xGLwTZev89ycZhp/UvBqPX+S9IzLklf06Nt2Z9i8k+3jx5y09TxI54yaR3G6dyiFe
 /pVw8iFeEfvSgqXFNiTqvKedNnBsRq61NqL/0FcuYzBP7S4q5aJ0E3idG9YBepkE41kcBFCyhOR
 trMEEyLlDq731L9+E9rlfWYeu9WZLd5QrfhtQyqYDoIGz/Nd+mhap0pFhNRGRJjQGKSEDqTDnO6
 EPKzxUSe4rJiWeOezbbaaq9RLNGRCQOnFiEZrluugd4OCE5Xl1PeFj4Sv56wA3O/IXGLJyj/So0
 jq8naSS1e+qqFxDnX6o97jxZAHJQ569H4x3nbjHdaxgS7Jo87dYQjH4MEL43Y9xhwoGGQ36QxfL
 czxXaBxJLdHy3eolg8Q==
X-Proofpoint-ORIG-GUID: PMr7fWXgRrPwOeM6BF4gRNQyp5S6pI1u
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

Something we'll need from the gpu snapshot code.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index e6ec85b20fb7..4a3898e58aee 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -357,6 +357,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index be81f141300f..a29f8149493c 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -130,7 +130,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

