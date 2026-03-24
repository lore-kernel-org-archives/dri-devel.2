Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E855DFEC11B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 21:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529A210E66D;
	Tue, 24 Mar 2026 21:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iL4rP82k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RgCeaI9N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B334410E5F2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCfKl989024
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VIBitPKQ5iS
 p48Wf7+RJ4YDtudeu6rRnT1VURwtasZw=; b=iL4rP82k1o3uqKVd1jzG0fbBm3P
 XnQKjcCYzOwFANYAZHhF8QJ9+R0/O/kGgCSMNjrti98JITh/2D+KOStCy2s1W+yC
 96LjMKuvwq7x8UgRBjldEwwL2jcmJayL6QdqtrzVfz1i4sFL+3FPmQbgWiI6sGsl
 eREcAOYIc6JerRtZlf3zTK81smQWJpFBQkTv6ULshDnDhqd1T+5NswbIyvO40gBQ
 2C/U9mCN9OMS5fm1LFidvoGfmH514W392sJIBhIUrnCYRAU95gOMLBPUcNnrGOg7
 yDRZlYhgdaeuHC6wdT/fmLGsOCHqk2pTsCT5kpJQNqKl3ZT+zcqKJewaoeQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m1yem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 21:40:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b068299665so56486325ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774388441; x=1774993241;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIBitPKQ5iSp48Wf7+RJ4YDtudeu6rRnT1VURwtasZw=;
 b=RgCeaI9NZJP5EfD8mdU4CCUUKE+pAwmt8CfOh7zD5zmL65CiF86pMqX52NbP1/GZrt
 YsqeNOuObavbvDkzOijn2rUWSAeWyHfLjLWUSM6amAPj4b/tF9sx4Pmyw1L02IPJVlaR
 vrPqwK8mZOe5KwbzLESlL3vIAxy5BlJDmWau5aQMqfMUufDgcwrD4M6dBslNvFFpS72L
 fmu2V8/gtMyPzwaJL4NXv0+nAfqqp5r62igNlcI59ZOrNji1uhCNFoXNURIGSDXLrqVy
 sYxXx9ULfEruKaMf3SPTR8IxFhHvj1Puwrs4AyilbKxyttz3KN55F+uHMOA8W7t9Zq0V
 WuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774388441; x=1774993241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VIBitPKQ5iSp48Wf7+RJ4YDtudeu6rRnT1VURwtasZw=;
 b=RSDQo7S+S8XdFxifk5DB5MUoFuuWCqu6I0qG+js8beJfiIZaACBsK19wFBzpKtZOrQ
 v7OGzSzm8XdMMCEKQqbMWYnNpbY9FR9jvyiiZVcPPaHhh06NWi0SaFZINiKm8IQVVXjK
 J0o2EWqwCVnN7zsAIl7fWHZb4e/U6dEiakxn04W+vSDPVUfSO5yOuPCsaUEnZYxGo+r8
 dZgF4R5Ni54nvxyOUZqZN4k2oxyZdQc4U950Zpp9pAOGo8zCoiXV5/Q90p1sNhUSOC+7
 e7JYrgrycZqpA3VtL1hV9v+dRLtzA4WzrALAHBzTj2mnVuCz5zgF9HTgPZD+mdNEvLtI
 h0YA==
X-Gm-Message-State: AOJu0Yzppil95jMw79nc2ktxNY2iV1T4tX+PaLjnNWueu5F3/Czb2+e+
 xhZ/jvb/k6HlCUycB2j/iR+8ZML7tS8DDMihD05gU8L8xoU9FaaPf1DWVMbDmtsMXQI3N0qhnKf
 /E65z7tynKSOZZClUUlk7zvOqTDqdUC0qGiiWRkoOtPR7bBZ/YSTuuTLDIUvEu81r+EO8UVcAIk
 pYSYI=
X-Gm-Gg: ATEYQzwmtUrwcGEPkv/o1y8oVjWuUyhei1eSdD1Ymp+t+onysYsGNSlT8+/yROKpPS6
 d6MPsMSH2YZSFKUNDjCOBYmjHi37KDfAzA9SaGw1mDsyIWqnkQg/mq+NA67yOyHDsSr5RtrfH3N
 D3K/UUJ16/xaPx3L0Q1hZ++ybOS4X+ZYoC6vj/MSJwJfn6O2VlaqT8eWTBQwB0WPjZdWsQOOxdm
 q+V0c21laNEZmODcqC8l0BLBsE+pJnlRIN9DCVXirSsy1A5ljIrv1P71+L3UvtcqejNeDBxLREw
 uIRcMomnrNTepecG+Hy1NLbZzmOqgFYHiPugmjntKdwqOYq7LECuk8i8KqWLhgGkoH8qCriXZvS
 Qd5eFGIRXHeY41GZEybWIi8d6jiZ43J7I
X-Received: by 2002:a17:903:b88:b0:2aa:d506:d189 with SMTP id
 d9443c01a7336-2b0b0a8d22amr11738575ad.34.1774388440744; 
 Tue, 24 Mar 2026 14:40:40 -0700 (PDT)
X-Received: by 2002:a17:903:b88:b0:2aa:d506:d189 with SMTP id
 d9443c01a7336-2b0b0a8d22amr11738375ad.34.1774388440320; 
 Tue, 24 Mar 2026 14:40:40 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083529e8asm162554315ad.20.2026.03.24.14.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 14:40:39 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Fix VM_BIND UNMAP locking
Date: Tue, 24 Mar 2026 14:40:32 -0700
Message-ID: <20260324214033.1219113-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324214033.1219113-1-robin.clark@oss.qualcomm.com>
References: <20260324214033.1219113-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c304da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=eWlSUfSnBrBg5eVjM6UA:9
 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: qWlixRJpEe4qzSFkdVVEZHkjpMxDmopI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2NyBTYWx0ZWRfX6UoaJ0tVEU5/
 6sqpBSGDXyq8kMWxKnrIOT9qGx6La3lAX6jgF+AWD+btRn2TCKhvv1aqusZ0dBT303UmyhREoRO
 wSs9B0j1CzLUnvJCBNwEsq7pTumiv4t9FGoz9q6jkOFjfmVqmmrGuw4S1gHaV6xmcJ4wRzVqcRR
 uC5AJW8oIi0MXzVfCXgkYXN3MQUejXehy5tb9cUAo0pnqiMfUx6ehIJ4OHlDjKOPyx48TkrmxnZ
 ihz3ijtMl4wemp5U8+A4Ny7Hfm6YsGW4ntomFZTNujkG9GPlVUwUps1hdq/9ONYR28d02JBh0p0
 LaGu6ZUYSYTeUYOM0JnJ/4euggtwg50y+mVGrL7BQxsKXP29wX8U6hf4yvgf8vlPKwt2gQjvJ5W
 t/S/9ULQHgYyevLcD1vyf0GoDGN/bZkvZXID+qSrA44JoaNXzhrlnATH7UzFm82L1JMo6amTb65
 H5DfMVMMnPuzkOrj80Q==
X-Proofpoint-GUID: qWlixRJpEe4qzSFkdVVEZHkjpMxDmopI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240167
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

Wrong argument meant that the objs involved in UNMAP ops were not always
getting locked.

Since _NO_SHARE objs share a common resv with the VM (which is always
locked) this would only show up with non-_NO_SHARE BOs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 68a8f8f592fb..40892e206dbd 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1251,7 +1251,7 @@ vm_bind_job_lock_objects(struct msm_vm_bind_job *job, struct drm_exec *exec)
 			case MSM_VM_BIND_OP_UNMAP:
 				ret = drm_gpuvm_sm_unmap_exec_lock(job->vm, exec,
 							      op->iova,
-							      op->obj_offset);
+							      op->range);
 				break;
 			case MSM_VM_BIND_OP_MAP:
 			case MSM_VM_BIND_OP_MAP_NULL: {
-- 
2.53.0

