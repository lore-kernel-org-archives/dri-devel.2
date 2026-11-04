Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B312606B217
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mFqTjSC3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SM5/5qC8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24FC10FDC3;
	Wed,  4 Nov 2026 17:59:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029BA10FDC3
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:38 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj8wx2251434
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+i5Jiewm+Dk
 Vb+ElU+YnwS7BEOGG9HPyqCVLkTEmd1k=; b=mFqTjSC3EfzL0D+BBHsZ/xS3C3R
 MyBf+Gbm/lURutPDtpss513t51WgdkY6ShTmm8/KDhGbO3bGQdLok3Je7tpN/66z
 zO10kFCEVVLCutLV1+bafOGgAFTy9EBJY1OGCe8WkJAyLdyd94Gz9yR+asOw3kA3
 38aeyKcHqX4Tg8V40h0lNkpvyeh5mulPioME0Q7gAzU1/EgYztiI4H0pqLRvT/xM
 038BAkzyCY7/NJgOBQ+AaVElN5lFW37spnmnJxkDKJh/3dFVj5JAKsJSv4YDQo6b
 a/PcwDMmz6Am6JpkBTqlSs8gtaqUloVNThqHIC8d+UXFpe90jBBll0qngpA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn1gnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e954d87b48so13324305ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815177; x=1794419977;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+i5Jiewm+DkVb+ElU+YnwS7BEOGG9HPyqCVLkTEmd1k=;
 b=SM5/5qC8Yeskb8Lbzl49gTKx6SCuN8uK0sB6e01+Ctw3yfCKLh7Odxw4CyQcedwjYj
 LRgbUEATG+QOSGi6SJNVfMBXKM0aCgG59t5iW4NtQPyAa5U0J+EEDhzZu3anqfLJFW8V
 YNJGLWnd02xQMgYDyU3AcMLV7vVFbgwvdfVVa9sTz5JopKdByuT0hI4aYnzXn+A9GMcZ
 7vLvI0mn4Ev+l8Q4C70wPZoCjqm5q7aRfzY4VGOuXnR69vqDbAA59v0QmuX/BkKL+q1o
 v0SdAeYdzXpmlW/xJ/XBYfsLWFH4wy0sd/oMRSzWNEMUSL6GgdkuEVuQ/J1tICELEFNj
 n+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815177; x=1794419977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+i5Jiewm+DkVb+ElU+YnwS7BEOGG9HPyqCVLkTEmd1k=;
 b=yuYmPKMMaYF+eHUOVrB41rPiVEgOzb0Dc3n31OJbNF9a3JS5wLnOD3XT4B06bgtCxk
 SaFhAok1/WBJxT6F9XRXzq1Zy7ga6/WuFNvpwIdVr6KV4ArmyUd+nxI+Z4z/4O/pynAV
 JU/YAm+LeP2NoQXqW6p43rzGZKNnIYW97/tcs42FNzKsaDqAvI5ctM78WqYR4jN/ptP1
 8Gm0DP0awKBE8nNzwxWNrEp8irzVT97/5i1gt4wVhGRhaXik+gyPGRNAa2pmUdi/Fj64
 zDy9YqYTjvKX75pfqOnc9eWWAEgXvUn8bzkKl98c3pqG7kivO+VtpNCrMzOWx+jHwELm
 /5Tw==
X-Gm-Message-State: APuU4Z9XQZ/pfoFNI14CnImFhmjv6eKjU5wwaWNHd/EfUyCPBbWKjEV9
 iPuM/dXaHwlj5a/8Zc7EHZr2+1yBe448kKgH6I1nwxuD4Wbl0DvA7gOjAmlnglepCr4BJ7+/VnD
 iiA512tAFn2qnf0k7erNe2YKv6UftPHOh6nUVspc5soeEB7gSBwtsWEtTY4TykLyog4n8zqCwny
 Z0c1nDLQ==
X-Gm-Gg: AYBFou1pYDxOsWteAuREuaMNbKP48AkTpM8voriUS3lXec1MgOzFSh5z5163TNpRITK
 9qVLcfX50Pu74to17vKBBFGeK6kflKN0HqYPsP2NbcxpaPbhV9WkiAz1n+Rln3hvvD2yq++vrvW
 sYfqpxe1eyd/Uh49ynTD3HiVTnaenDXnCdHsZ3jBtywRx9rc6XEVptH4FM2nSIdXg7GxkwwlOHz
 lzMtX1eLARusy/xAlFdTuWuqbNIw0QKNRZZ4mz1/Pl9VMj5E4hJpOHljqb6ELrlxP8ga5XW11J4
 VxrdZdYAneeaukdtWZvazcOsngySFWZqekGXBwNRNNnCozKJ4QmZA+pKYhDFPsGw4w0owIu1tZk
 YSXRq3oonX7LM2917fXFvkWIEpkz4E5h5SJVsE9FlFUflVAN87maeXZwmZgqHSQXLFGQhDJt55R
 z6eMITMYeGdqgTSsAZ6SJII1/uq4nLEf7mgHaIzys9ZnEfMoqaTDKV8lIDN/U=
X-Received: by 2002:a05:6a20:7f82:b0:3e3:1013:466b with SMTP id
 adf61e73a8af0-3e928a79de8mr16140212637.64.1793815176656; 
 Wed, 04 Nov 2026 09:59:36 -0800 (PST)
X-Received: by 2002:a05:6a20:7f82:b0:3e3:1013:466b with SMTP id
 adf61e73a8af0-3e928a79de8mr16140190637.64.1793815176183; 
 Wed, 04 Nov 2026 09:59:36 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb46443e37sm1465823a12.1.2026.11.04.09.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:35 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/6] drm/msm: Hold runpm ref in set_sysprof()
Date: Wed,  4 Nov 2026 09:59:21 -0800
Message-ID: <20261104175931.28475-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX9UA00eTTJCe4
 Sa9xBg5HWX68duW4NfSLgrhMvlgTeX9yYCLpZk29aQadrTcAsnPh5u1opSmSAWBGwzN32wkXYbM
 JyTyy56JX7vynznerHDXqlQgGn8WHLOTJePLMhl5hp4KsrAAsNTwaRt890jYpCQNpw4LqPmwz0W
 YJHfLn3ALMVSQxyvQGreoE2rQ1xk8VsgDaxaKqdYipOhqFfkxMgIDDOuTV0W0Ek2UjH5bbiTgah
 gKjeZ0+3dWoUsPog3WFb2Re7ChOe2XExNZlaSkjBA+6cLIBdr/4yjp9lou2RsW+2q3r5knLOjyS
 fgMy+UL/7NHisbLL88UjTKAzXl3R8UDie3zPYTnIU+4Mu7etPCh107rUqLy/93EtAQG7j5TzV7K
 eMlEkXbvw3Z8vTpsO8Yzk7krA4nZpFKKe/RTZ7qdqtam0wmvAV65BajtZUtT7FJa+RTgmbxbEgc
 rHcI6pXYjPQmEbWSPqQ==
X-Proofpoint-GUID: D79BaQHkEIAAhl34ombSA7Z9dBxjir1P
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb7289 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=TtZx0lvJKI4lzRINSrcA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX+hdFtJtyyR7P
 uiBjMorOd7tOeeqtL4OU5FuEHYwpRoedUDVE8+s/wLHRrX4JbFkrsFupbuOg3T36NXwrFPXjjSD
 K+z3HcG9LLA9UZZctptNB2hbdWNTjjY=
X-Proofpoint-ORIG-GUID: D79BaQHkEIAAhl34ombSA7Z9dBxjir1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040071
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

We should be holding a runpm ref when we try to set/clear GMU OOB
requests.  Apparently we'd been getting autosuspend lucky before.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c         | 2 +-
 drivers/gpu/drm/msm/msm_submitqueue.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 4b2798efd9da..7fe273bf74d2 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -362,7 +362,7 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 	 * It is not possible to set sysprof param to non-zero if gpu
 	 * is not initialized:
 	 */
-	if (priv->gpu)
+	if (priv->gpu && ctx->sysprof)
 		msm_context_set_sysprof(ctx, priv->gpu, 0);
 
 	context_close(ctx);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index d307cdd17d90..e3e7c401fa5c 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -9,6 +9,7 @@
 
 int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sysprof)
 {
+	guard(pm_runtime_active)(&gpu->pdev->dev);
 	guard(rwsem_write)(&ctx->ctxlock);
 
 	/*
@@ -21,7 +22,7 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 	default:
 		return UERR(EINVAL, gpu->dev, "Invalid sysprof: %d", sysprof);
 	case 2:
-		pm_runtime_get_sync(&gpu->pdev->dev);
+		pm_runtime_get(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
 		refcount_inc(&gpu->sysprof_active);
-- 
2.56.0

