Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C13CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268E810EA57;
	Sun,  7 Jun 2026 14:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICccRE2a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bzDeVuBN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A47710EA4F
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:02:06 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657B22rO378006
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 14:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p0pKjfrSRwq
 eE20la+/GnMQ/TJmUHYzFGb/Fleo0bCo=; b=ICccRE2afsq13iYk7SpzXgkxyab
 Wc7O+zlgXAPnECXY/CeCpKhXB4GQGsz6ng3Apaw1uGLu0j97u+ydsIrHnsJz8GJb
 zJFGl3Z6BBr6icV8Y8MBuWvWw9sXE71vlUYJhe0Q9KV9dd/HXzM0jq6smDZPdK79
 8FsWiImePGYiGK25ttSXdMpLxaJMXYkDwnCkvnAcG7EYh1aeRIAIz3nULtPJ6XEr
 SR13/xwdTSuqv0o6HAal4UuSE7PDq7Ttir7lcfiCUmxWsLw+jGjWvfhId/0UOVc4
 G17CiCFikTWW5rCrmMtot7D3Ejpv7ya2dRHBm58PCX3JBsEnsFTsP6daDOg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6bwak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:02:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36ba98cc003so2315325a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780840925; x=1781445725;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0pKjfrSRwqeE20la+/GnMQ/TJmUHYzFGb/Fleo0bCo=;
 b=bzDeVuBNJOO/RZsoxDbTinwhw4gSJhQt1fiuKliyBiVq48T1H1cIQ9XSEc0OKxke37
 Zfo8ZwOCAwu8BQDKg0emB0dmQeaX+Zzhmzj2389QGxrP8PLt7MB2bG5Y94+5YSGPd4zf
 PksIB99upfcGH7wK/Zv8x38iJs7LeSW54+Lmsqkzyvw3vxuJSorwl3OM2AXi2Is/yRf0
 46R1mqRz0e67Z50QtiJd4N3ECzt7b7HDLJXr/xjPYlL8LYWq2MMxZmQKxHTfqfbgEP4m
 VJW/ShGqNxIiaZ7dNxnec2N10N6Uy42u0XBW+Vq4I36/Ec/yQlXKgnx40jYhAKTa3EIT
 NCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780840925; x=1781445725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0pKjfrSRwqeE20la+/GnMQ/TJmUHYzFGb/Fleo0bCo=;
 b=ZGvvfvFHIbXNsAHEF49YXKjut/UZxUspW4WjTPpq8bQL2TK0aMTGcUedSKEzOPEdh8
 3Pho3MD8mZupu+ot6APoa1YZCcjYJgDnn0Rhg2uJ6zvZCGaSXt9kYsQjwcYNHTY6ahX8
 msmUXjpER0c7jLBCR0IssKXzxy6hg0su8Cu6nfxqMd9Riau6ThC7V7uM5dzJlFarLlL+
 REmNXzW+Sqatruh4YB0b/OpsXatf1NukvvJZ0rkao2coq7OZN0zQPwBEw9faKmBCjHa6
 8ZdyYy433cqv4VHPaMqX2OAyJ8Y7uU9OwFnA5Fh5nNvjjs/0n1XlYNdn0rJMvWK3vTC3
 ewyA==
X-Gm-Message-State: AOJu0Yy8YxSJwnagHbv3DudxRuCGJFNp6jmuaPJ6XIdDVe2X5zpDQ1es
 U2iW8Z39H9ISZP62Ms7V4vRXLjRJXV6o4V3y7hSaMboaq1M3bTwUZ6RKNUyBZfNEBZt81wuM2KQ
 i4tvT0bHhjkvfVh4TY4vz/ZTZS+vTsN84vJHiogBlAyg5JH+RVe9FX3WzuAagc01+HrUvkK66D2
 hOf1o=
X-Gm-Gg: Acq92OH5EYIq/rg5AN18EzJPFlDAjdXNjWbu70RdxEeJsbEoKy4XM/EvSSshEhQa5Ek
 /YbOoHi91AuS71qkRpGoTHw0r9wLOehEd49+i0H9L0eR/KU7Y/GciS1jWfjNp/RujWjHUgikQb7
 riyTpOx2865HOiWgOtSvcaD571l/Ac4aqiUa4mao1KImutbqE9lREaisaH3bCkpxe7Ei8icIz0s
 Pt54LZjpis/f0BqKAzLqURpr1wTTpoADGAKc37ytGoHsu28PDhLo7L5dGjMJ38QLdelL6lFBMyy
 YXZCrLGv/8ZWO6wc3Vlck2dK4IBV0GQWEeZ6wclZl7/jEhRi23MASHYvnpgIxylT/Sap+ciaHFs
 xkOwNPh6icI0EZ4s3/RI2G7+mQtKuWueGuPtv1UaZcQA=
X-Received: by 2002:a17:90a:dfcd:b0:36d:b12f:6143 with SMTP id
 98e67ed59e1d1-370f1b09906mr15074521a91.25.1780840924822; 
 Sun, 07 Jun 2026 07:02:04 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcd:b0:36d:b12f:6143 with SMTP id
 98e67ed59e1d1-370f1b09906mr15074474a91.25.1780840924385; 
 Sun, 07 Jun 2026 07:02:04 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6dba8064sm12794126a91.12.2026.06.07.07.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 07:02:03 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Validate lazy VM in GEM_NEW
Date: Sun,  7 Jun 2026 07:01:58 -0700
Message-ID: <20260607140159.137068-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140159.137068-1-robin.clark@oss.qualcomm.com>
References: <20260607140159.137068-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a2579dd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VGCgC6sU4evaG-_1UnEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzOSBTYWx0ZWRfX/+B2uTSZva9/
 6RqaiLaKNrAVXw6XhaeiispMVQm6hTG36S9tdio+Th7Vd2K58OxlITQOLJOTAyvKRtCozuNmZZI
 xvhTWtGb4s70gPjXp7c/WSEQg+J+DzRw/R+jJHmQRNncyQ2ngHagi1ql8dghkmHt0TyGI6G4Qot
 GOF0AnJHpZ84LtGHUv904iVtDhI2Qdo2dPqjflm/WA1wxpxqPoTxHSP39cTcqhRbtEpi0kSPuVm
 xOjIpoITKmPuGb4Z4ByrktGsnoXK1V4svZLckQo48mz/hLLOAW3t7d09kSVuQyFjvYt3jh7Z0AU
 sIUuLBy2AG5YiBiCBGGRWAYP7FAgQ5sz2/talixHAkgO82/wdKhZeGHT6TJHdEeTJeYF3jSdT/4
 CbHoeTPTQxi5gr4rHZY9a+w/pj5qX3dCPylLordSWMvJMOsnBFodJ4kq6Rs9H/1fJPeNE6gbxID
 tVdQt0QWfb31aUSVRqQ==
X-Proofpoint-GUID: ZNBwiM3v50rOx6EYFVlSYmyRvBIPS_7d
X-Proofpoint-ORIG-GUID: ZNBwiM3v50rOx6EYFVlSYmyRvBIPS_7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070139
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2cb3ab04f125..ef14ee66c6c3 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1148,7 +1148,8 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 
 	if (flags & MSM_BO_NO_SHARE) {
 		struct msm_context *ctx = file->driver_priv;
-		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(ctx->vm);
+		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
+		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(vm);
 
 		drm_gem_object_get(r_obj);
 
-- 
2.54.0

