Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE01C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86D910E646;
	Wed,  8 Jul 2026 17:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1UjfpTv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBUOMIvm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6000810E117
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GKxfZ3125578
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YHzHGsRPIUG
 VAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=; b=J1UjfpTvutthxNKGybDQMylMX0+
 bWW/hswSmLHfwZJIqwbYZ4iljIWp1jCoQ3Nuq8EKbMFGxLfO5NJu9LaVDILEzF6A
 68YDRp+wkPropf0aEmWV4o4gnrOlx2t1iVOXRAPwMezV6fpVLSr4oqXTDep09T7t
 oCdTuskuLeBGcc8tJMWiZ8Xd6nBJ8HzxkM0rE83WzyMeRpFtLx1vaaY1YVUSffBN
 q1Av5LM0CZv45GjzcGtnt46ksJq9VmPZVDLMalLfNfa/GJzHLXAWHL7+GzTuena5
 O8QFDz/cjPNgSGMuDkjSVEnN+dCiKKfjfY9C0BgqOfQt7phipMjUhjbnh5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s9a05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c354050c34so15892835ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532073; x=1784136873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YHzHGsRPIUGVAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=;
 b=HBUOMIvmLo+ESpKK1y44iwB7XjX2ahcs7RRbg5JhvjWfJDtI6zRy9C+wjW/byiEMPX
 t0JYNF/JXzktoUm+avQYpkXAm1g6neG0LoDjm8UP0MdLWzN1O4WXxYM9oUZq6f4X7EwH
 Lknlfx4HtZ3kjnFxXNUU6rfTqBUSApQz2/eTUUsbwnYeo8KTKMrX2Sl7fZogmBd//feD
 RiydaR5ZoQxIGdtEZf4yVhd3rL7gydsUuz86pZlVjxlBAmcCf1guGapcQSaBm8DZbUh5
 EBAkQMcPQ9OQHhqaigaqMvg07U1+fZWUFj98kdP4LIpCB6WhLyczN0FHKIlPLVuLhyNY
 E/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532073; x=1784136873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YHzHGsRPIUGVAMOUo6qKw+18SGmm5iq6ipy2Wi/zZYE=;
 b=mWDRrECvCiiFyICJ5k53ICffsQpVBdF2LtNnjKBToamjBOUzJ0zxeWQoBw2GbMtAzk
 QCDkmXAo/CN8TKU3Wjmd3t3TUBwtK46XWQ3qVDoyFHvyYGd0l6n1Jcf6I9mjMmzG1Xrk
 xUrGIY0dyTzJdugOWzBHTsujzjf9MsabuEU4Wi/S3H4OFCvzPIdwq7V9GXA0fzuSoJBi
 VVqmSBuC6CR0NZbXGpEVEnlSUe8IC2TH6RP2ASmmz59z9c2cHpauNpbNiCIa1ghtMNRb
 yAvCoDOqX67wZyk5I6pmlVAtk5i9I/KOeakkr7kJv0ItnCElIGCYluO54Bco7cRUjDU+
 X6lg==
X-Gm-Message-State: AOJu0YwY7lYzW8+766ZWyY4evFOLERoRMIcuo4Z/xwvRyy3+bqJ/WIF7
 RtCx2lcSiER7qaYSk1H6Gin+oD1DA2IqNITNXnrfcrfYZjwNR6WcwsSp3kHOBmyAJIIq7pGmr0/
 8n8gPpM7O/FHQzASrV0zZ8TbZ65WFrVH0HcuRG78+ku+xdHvh6rCIPx9MV116LtKSghlvJhGA2u
 omCls=
X-Gm-Gg: AfdE7cl9oOuNmUlr7kebYs4VfWx7ovsoikUerRjlhA8eBkIIsqZu7jvFhADG3pdxcPQ
 yJP1onLyPuSne2dwk8LtbD5VQ0p0YLuhkDb3hrjKxYKD0jeciBcDTDIjd6JV5UazdJt7uUqdUjT
 yi+2zSnKpjHZ+QM+3VhRa/h3hpj9+UWF60crY4j8kF19wnerIendzolYywlfe1l268ofVzEMcIt
 i+9Ec7mGyErQrmb5Muy2CTNdIb1ZcasLFs3gHg78i85/pn91kY/v/Xw3fJDRSeLXE7T2T9haZhG
 qoVycOrY+riJwVa/cXavhhKNggcO4gZPQYrly6SqXrdXGX7Ts3Dl4Bj6tedolWy4KQbyEsQSQOM
 yEkEglIEm08Te+O2iZPzsCZ0ieMDOChwTdMd2m30UCIxiiHrEPjIgKFjHag==
X-Received: by 2002:a17:903:1a2f:b0:2c9:d8c6:1dc3 with SMTP id
 d9443c01a7336-2ccea287d5amr32556535ad.0.1783532073226; 
 Wed, 08 Jul 2026 10:34:33 -0700 (PDT)
X-Received: by 2002:a17:903:1a2f:b0:2c9:d8c6:1dc3 with SMTP id
 d9443c01a7336-2ccea287d5amr32556245ad.0.1783532072654; 
 Wed, 08 Jul 2026 10:34:32 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb7e9sm32420615ad.10.2026.07.08.10.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:32 -0700 (PDT)
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
Subject: [PATCH v4 1/6] drm/msm: Fix barriers accessing ctx vm
Date: Wed,  8 Jul 2026 10:33:49 -0700
Message-ID: <20260708173356.578713-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX++TkVIauqx2l
 LY34ldAN5JNSGTFjCM7cro3Q3sgkjjMV5eZU/l2VFeBU2+56xYjOycNrLaPlEDToti1ROWor7tX
 PlRsX9Q0orhmp4S7ztZo3SRa9XNDu0ONeKnYsVXWLkU/3O0I+I+1WE9aisMQpYlqhQ4xBxrw+u/
 KIiRwlJOQ2jI8TqiDC0cwMZ4yWdUcYiMIbPNkfzxFdxr5y1ghkQlZ0N53eJn2nuTOcKVsNU99Iy
 cj/BVltV6o1o/2gqhP5GAqsdpLrdTF1tV3c7+ez/3aLsfREY6rkgyM45pKBkN/WEo4GpR8qjwdE
 bRs5XLeKIDGR2lt16mgNKJMIiGDrgl8zU9kUdPK5IkB1OMD+gm+/bSddqFDpOTgYW6i6EvkF2jg
 uKr0Q2gv5icpbhiwHA+6nQAlIdHTcIP5xb//rwTi4Tsjcr9JTbPzDdXc8j/ybydMJhCPMuq9ttQ
 b3ihfYrhU+7V/WQgn2g==
X-Proofpoint-ORIG-GUID: IxgSykRAXWdwkPmf4N_dz2AF-A9NtXo8
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e8a29 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=PXeb_Y4BrUyLDKu8J0IA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX+kJg7agVEH95
 pgnYcmlldMmXBbEQNX3ozJF8jEElH56VVy+TSpKGnylf8MPlawVbOcOGnK16vhtugYh7wszyMvN
 O6rC5SMXJMQRxWPdu7Igs8fIOzZznRA=
X-Proofpoint-GUID: IxgSykRAXWdwkPmf4N_dz2AF-A9NtXo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080172
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

Don't rely on store ordering to protect us from caller seeing a
partially initialized vm.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 32d5ebea2596..ec88155e0ed7 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 {
 	static DEFINE_MUTEX(init_lock);
 	struct msm_drm_private *priv = dev->dev_private;
+	struct drm_gpuvm *vm = smp_load_acquire(&ctx->vm);
 
 	/* Once ctx->vm is created it is valid for the lifetime of the context: */
-	if (ctx->vm)
-		return ctx->vm;
+	if (vm)
+		return vm;
+
+	guard(mutex)(&init_lock);
 
-	mutex_lock(&init_lock);
 	if (!ctx->vm) {
-		ctx->vm = msm_gpu_create_private_vm(
+		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-
+		smp_store_release(&ctx->vm, vm);
 	}
-	mutex_unlock(&init_lock);
 
 	return ctx->vm;
 }
-- 
2.55.0

