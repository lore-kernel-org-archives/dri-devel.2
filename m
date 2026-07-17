Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F90C44523
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6932010F60F;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CkuhYW2M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5ZmrvSX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8F610F60A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtYlF2780236
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rc/ljxoshAi
 Nv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=; b=CkuhYW2MFx6PieJDfPOg1vAxRMi
 lQuODqYGR6MgKww/4cqAPa2xFIYsjXOu839fbOctmFjK2ZxudHzue/81/jeT+wTn
 Ok9nU/YlgDQtFksVD+75JqrGn0bau1dUV8bMZv+IdsfkmQ5Us405JfWpWSsIoPjm
 ttYRpFT4hkXOw1ppDCawJjuIJj2KZP/0uOHdjhieY6FUwBQRv00MHu03ma5fEPhl
 KvR3ouJDXaNEXpIqemY1Gy5JRofm0vNdNIyBDjU4Nq62CGtVwC+TzVwf7Sj50pQ9
 nlEAP+maVneTbZtghXN0tpiCcrHnfC0VMn8e7AXxW4FGzM+uq1FRROtT3ng==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gua7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c354050c34so130020125ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321355; x=1784926155;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rc/ljxoshAiNv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=;
 b=L5ZmrvSXRyy3oT9Pa27l0Y1RpyyIif5JEyLo9lzIEmUwu2izpQ/84417qAK279PMG7
 Qv/D6l4zIc4ehSeV/AB3jUtApkfnQB9t7RXnHMVJcDVhjq/GBloNHjz9TG6hDv7BtPMX
 rr4PMjM/BWFPoOpu+Z+pHUqb37XObVy2h1JixjkM9bIyRTnWg/sY55vLtzcmG5thICuz
 zC6vBCissbniG1Ld6zxW1h38dnJFkZ6PgU1sPsSas4cN72Bs3I29BpX+KONSmEb9Em/o
 exlB1qUD1g9jhHUv5UkcRWglCe+RdLVmNdVn7a/csOGlsZb3Wnf94a3yaSw+Abb2xgqB
 VFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321355; x=1784926155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rc/ljxoshAiNv4QJKXYpPgimbLWzx8XhYbA7LeAuwfE=;
 b=FDqCgM8/yT4oYyAqcPir4TgeaEmR2AK1TcK9I3Zu9zNfKFKcJefZINHi/8892G0Vtl
 5bGYaS96vuT2an4F2jXnond5uotZ2xCOOKKOVQOcHc2/Wc4yuI1CBuBJ3d7uJ4DyBmae
 Z8oHyhfJRmn+M2T+gLnA4jdVNF1L+kbxwRQNzBCGO8o8z5DZkEMJzhXwJcjddfMZDlgj
 cFXXL8nTBrxE5Bs35FjJWC9RuVCZPCk4BFqaSHX9BxjwOZ3NgnOIe27zyIPtcnxj2/Fw
 nhOWcC7jaf0yXnWfp1jcZQ6MABuHsYx77ujJoI5QdFKmVr0g94j5ctFq8llTu4rWCUlV
 qJQg==
X-Gm-Message-State: AOJu0Yz+3QcCSlidlfNyllZp4BvOjig6QVHbK9qJ8ZG8lFwsVS9oqQ1H
 1fcH76p6Pgwp/iqvITBINOtv9CSRPii6zolSLk3yzo/kspvtzO+QwrdOk81iWSxo/8wcRLdz4h+
 J9fcLSiuLdLRJJTBUzGvMBDsFnzS+BuL5Ko7n5TEA5NiyAFirR2hLlK+OswgKxU/hjq6raGDhqm
 1ZIJ0=
X-Gm-Gg: AfdE7ckvMmAPBMxJ3vZLu4udT4ihTsMEafRyervrcDLiDYGFI7QGJz4ppR1pvaOiO7h
 IU1ngx7odFRIgHlM77CD7KV0voUqLqc+MBiqpjhtdfYQCrju0IVjDyXoGlO2qBfcUxbgXuUy4sZ
 cJKMXBNjUqJOFwCfm60y8Nc8pAhxCrme+kaXfMfxzwm0wA0TjVpc8C/H8bsCaqC9T1YNAO2wLBL
 ckj0lP8g5g4vp0eODQrg7UaFfbQuPg0M5KgNy08Gk9wymsEmq7hjOEvxqBVZsRXcYWFg0BOMTRb
 ooh3CJhply2WULOGMNTgt1GdqJCFjC2u3nyVN6JZWO8zc1OdTd9iZHSgiXin0XdaxKB4iALpR5a
 tQMU8q19gFWrcaet5Y7HuTA1yVGJ93XVZyoxl0OCXCyg+Nnk=
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id
 d9443c01a7336-2cf3481df5bmr48572655ad.9.1784321354897; 
 Fri, 17 Jul 2026 13:49:14 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2c6:a172:55a6 with SMTP id
 d9443c01a7336-2cf3481df5bmr48572335ad.9.1784321354470; 
 Fri, 17 Jul 2026 13:49:14 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf347165b1sm16750405ad.60.2026.07.17.13.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:13 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 16/16] drm/msm: Fixup invalid overflow check
Date: Fri, 17 Jul 2026 13:48:32 -0700
Message-ID: <20260717204841.26120-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX1szehdw/WG8K
 tX8MUTVUavJPsL91AA3s64xsitD2xLorRkZrMtO8Dy5GxCmONc1aN1CY9rSzeaK+RK/yu4N3C+2
 OKQtWjJ9ouxp7QbKI2yCjUBrr8aZtvM=
X-Proofpoint-ORIG-GUID: CC7dQbB7_zlFBnUkmLh5pA3-w1UST8wZ
X-Proofpoint-GUID: CC7dQbB7_zlFBnUkmLh5pA3-w1UST8wZ
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a954b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=uVkA5J_fsNn9jy38BCIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX8WScH1VU/aA7
 zBw+KNECb9U9vwhD1/Uk0fnPrTKaRitqv0F1ydv7pqP6evj/XlwgoZ+3UDMKgc8x9Z3UMcDRiWN
 D9lSOaFa+RjAcx6UMeP2c2r0rDG+n2gpDSFwCzORahaA7aFtC170kpGaRQxGlagHsglOwPfL9OZ
 2BWiEvacxXV0gGFHflNRYGWiNbc/+n+/q0X8ZXENit1pLF70OIZ4yfPf7+Oo2gtcyuPKlyiJmnU
 QP+UCbHy8Yg3h+5JVvZ8itJVpXrfTsqE5s5IKwbZGk5Zryjs3XpY9cKpeBwEAriR5fVpvtIztyR
 BTUh9PjfjwvfooLaush2s8rhrODnKEjCOfwh8DurgtnnbZidpOcTqttfWrQvSiZuqEqUz1GNBb0
 nWdmEN1oXRmlE1B8SQml417TnIKgHxdr78mYGwMzRpuVA9i7KAzGe/SQpgtTHJGGdVCopQGqXEN
 GUYk8INLsj5RxLdR/lA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

On overflow struct_size() would return SIZE_MAX.  But kzalloc() (and
friends) check this already, so we can just remove the check.

On the other hand, we should be using the overflow helpers to calculate
the cmd array size.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6b0bee6c39bc..5862db05297a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -36,14 +36,11 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 {
 	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_gem_submit *submit;
-	uint64_t sz;
+	size_t sz;
 	int ret;
 
-	sz = struct_size(submit, bos, nr_bos) +
-			((u64)nr_cmds * sizeof(submit->cmd[0]));
-
-	if (sz > SIZE_MAX)
-		return ERR_PTR(-ENOMEM);
+	sz = size_add(struct_size(submit, bos, nr_bos),
+		      array_size(sizeof(submit->cmd[0]), nr_cmds));
 
 	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
-- 
2.55.0

