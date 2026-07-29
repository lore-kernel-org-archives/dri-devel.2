Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D05FC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E4710ECDD;
	Wed, 29 Jul 2026 15:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pW+bK2aH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBgPQagL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E2210ECAE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:18 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF2VWk2591758
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ILFLFLBAWhy
 u3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=; b=pW+bK2aHM6gpsPJChSxO444MgfD
 SrGRMgxj+HFL7BSwksdrxW1c+iyGakrRJGMJyxlU49/Xmh+qwbYnFnY/5Mhmm4YT
 wr0DEEAkPF0T0qb44u0bFkNr4SWpNpvDGNE+Q1xBiADV7eMJxMVzHClQVcwsJ4GN
 69e8lKWw9iMLnJg3IprKrjzVcHS+Z3Z6uFeQzAkahXPjDJPjS07gKpLfOHEKizAC
 R4QpRRqUGRt08hSQSigLE9awbEVH4rsSYByeQvE6ubcxFoNOJqmmFfIDyYVzCf/9
 QPiETycAn+RNl4aGukn+xUgBa9UjJycHpoge+KMLcQ3akD9cg2V5evoPTdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqke08h1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso20321215ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340637; x=1785945437;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ILFLFLBAWhyu3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=;
 b=PBgPQagLUzEYkkEBumohp8z1BuvCJAxcUKdRSK8JOK9yhEq7xRy2Iyzq7jrEgwk1jA
 E79EDfzqwgDs9BI6HwhxAWDa+0Q9TLkRos4ToYgS5a/TMEq3kiLk12dySaSBGASA2o3x
 Ii5xShOIZPwccMr0rczwr/Qlia63JTcqXDANu5sogxiS468PETCTyHb6OUtI0X4QFKh0
 FnPVi+pGodAO/UEr6tSDvbNcmN1/wixDHXSF662bfAIMtm8ncIznri8SresO5Wenr9g1
 HDZLb3cET5KihqGv58jNNleXjIjuGSdTZxtbXOIj47tEaPmieGI3iUGzyx0jqCaXrFVo
 7iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340637; x=1785945437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ILFLFLBAWhyu3kdv15Hw22354Io0JE1gAt8uUSQ6n/Q=;
 b=kz3wtFUjQz3cEE/Q84LJqH+34TdBjEcuL56jlRM0uQDYOQm9bpuj4BjxB/nu6GeQc5
 LUqDCuSJ3vUl+9ar79EYm1+1n/ZoncqtbsGOhKShjtXrXlZt/pDaILhxfBJqsZFjPVln
 uqHPMXavoilBeKTjBj8vYrYtL7HsyuPIu5HF3uvRyK9j5e1jMfZhBhfjgCwImoUSIRCt
 72MpWjMDwtTNlj21qHAhSUSNqXzo6Ea3J+vYKlFcRytcfRlE3jBsGO81fTJ35La0IDh0
 vEGISMe4fOjOwoQ3kseRGZiqJ70m4+rPdKZAokD8u5biSnUZknGjg9NojlzQJSoNOq+2
 dOjQ==
X-Gm-Message-State: AOJu0Yz1iZwo+3l9ZkoLG6FL5QeONK31FMO5kE9I3q+31IafdBV1Uzxh
 nmTMANO9hxmaUeQt2G3hwAl11egjbvkvRmVbvj03ZiwhMYdHfIZIaevQ0LnBp2S5kc0tVQuu9XL
 +KdVRCaIznzkJ4t/dNJgasMI91VDQ5F2s1LH533Wc2N+7UIIhp1fVhxqyzkMSISxXbCyQEVSb3u
 2+now=
X-Gm-Gg: AR+sD1077Lu0b2cSbgzGK0AmmNpXoPHAouY/PqF6s1EuRRYP2oNV52/lptPSmjBNUox
 rYWqDLn6aAwQC1ngdDWogmUSvcyd+C0q2ho7wB95TwvBYLQBFmPT+gFs8wqxLqm8noWjmWD8b2n
 57pxSu8ptJ7c7p8r7sxWbgjfI0TJizMkw8PnkqA84SZI7lTqRQzfE02zpm/gz9JJaxI9rng2h4h
 3UiUHaf4ck9+4+r8QlA7xy7OYCjgCGShrwWEbOBorlNSiVsbe+MBUezL7acnG1WNwNnw0A4ElD1
 oaD2DShHL4UHWL7uDGh8xmgWqRqv18/wRVSPrs/XhMZWCFWqAjHETsrQqfmYrYj4qqcM9o3DdhP
 UkoNEW2d56N/qrQNIvqzVKH6dY+yqWtZTEjh4w9wl5lG5mPk=
X-Received: by 2002:a17:902:c94b:b0:2cf:9cf2:3533 with SMTP id
 d9443c01a7336-2d015a83b7fmr82751165ad.18.1785340637589; 
 Wed, 29 Jul 2026 08:57:17 -0700 (PDT)
X-Received: by 2002:a17:902:c94b:b0:2cf:9cf2:3533 with SMTP id
 d9443c01a7336-2d015a83b7fmr82750725ad.18.1785340637166; 
 Wed, 29 Jul 2026 08:57:17 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a167b5sm13576585ad.7.2026.07.29.08.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:16 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 16/17] drm/msm: Fix per-process-pgtables check
Date: Wed, 29 Jul 2026 08:55:53 -0700
Message-ID: <20260729155609.20190-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX19SBh9B0oUep
 q8zWtPYivk6fE1uLdjR3MZ0kpPgs0ttbdkeH4UDeLONNXOgrLuPlFYzliNgXvONrZrlxklJtQ4S
 zmYTlPypJhMWfwGeERMrQTHHrnO4A93j0AF88P1PhSKcCIiW2FNW83HXjIeMS6+vWl8SG0S8bSt
 xe3tX8ZxHcpe+t/hTLlpUtRiIGphpA9U04zAGmHRothimLKVgtwrvYxZms9NK3Ay1RLkxN/wklA
 8mvm+NzJgdT11HJbfwjH6onYhHAqwr3lBBW6k2QN1+EO00ae37S72uKXYbCJmN7sL7VftuWkXi4
 o+YOW6WKgNdY14FmFl/Nt+9Iy4Q3gSmCMEsWY//z6NjHLYLOmYJprYoiAFIcbi+Q4O55YpoRNaP
 eo7S9xkokuFvN/0Vm+1xg+0U7qJxvlVrEPV88Mx6a+nDHXMkOQqejT+RbiFZiUSpffztDOl6i5+
 QyKz7YaSt9Akqu9UYmg==
X-Proofpoint-GUID: E99zRwW_JgN4UYK_sn8xP-RClxf9FGMD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX1bXGCiBJIzrS
 oteFVobDcrRynvymaV9QtXer/9nKzwsZCgkLN/ZusdogwYSGkprEnEcm6RIyr6lRGKrLlA7NK8C
 CtJ+pbDo1Z3cQt/sTyV/7VqoeZecxOs=
X-Authority-Analysis: v=2.4 cv=ONYXGyaB c=1 sm=1 tr=0 ts=6a6a22de cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_1v2yp3k2DT7xr2y9HAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: E99zRwW_JgN4UYK_sn8xP-RClxf9FGMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290127
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support.

Instead just check if create_private_vm() is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 84101e534ebe..3370cd44382f 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -513,7 +513,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		guard(rwsem_read)(&ctx->ctxlock);
 
 		/* We can only support VM_BIND with per-process pgtables: */
-		if (ctx->vm == gpu->vm)
+		if (!gpu->funcs->create_private_vm)
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 
 		/*
-- 
2.55.0

