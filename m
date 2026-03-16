Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D10BF53D87
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D9310E25D;
	Mon, 16 Mar 2026 18:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WgNVbvl9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isQb1rnZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1793E10E30F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:44:49 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GCX9ju1621677
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0ttFQZOfTjABcr/CRg+BE/xbEpdFtWOpPO3
 5ThpdIfs=; b=WgNVbvl9R/3IIJBd77oCtMTQp/ywFS2m0nIkqHvpJ4tuJ/lDwun
 Vfl2RqWP6pkpyhgW7bX2AekxSUJ0rtmUBbdt7hYHmvP7x+5muph49RvgUvqbYHyi
 DKf87yM/M6cMfCWxiFgkNU9S46jdeyTOWc7YYx/0JCiR5I8BzHvKk70zLi12zZn9
 uNeJM7Qmul4zw7C5mmJsbEP0C8BMhehTSKB/f3XDYO1TbALh03ydke2ijqCYAUUc
 /WBYMtq2mALi9o9QTxqvC7QxoHi9oWcLTkkVKbaHvdb8v/nlEzBjzCEwudCTiegz
 tbtPu8F/yCMQFTSsj2ta/7kNkXvjdnwYdSA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyehcpv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:44:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c73783c96baso2398413a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773686687; x=1774291487;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0ttFQZOfTjABcr/CRg+BE/xbEpdFtWOpPO35ThpdIfs=;
 b=isQb1rnZeZI+eRvf1tRRcllU31iWzyquiCIGa+MNiShZdGTCRaAg5h8knNTRD61Ew6
 yVpZxRo/kJJmvSrVYgNygnDz5bftASlQLhrIiAlZ+pPoL69VAGeuPbFSYQeCZSv3sZ0x
 4GuGDkoNUina4vcr2lFTGZD5Oe3uOezygW7ViOzYFZW9uFwe6dMENAraZVgD04EpwDS1
 9ciRtAPCs36Uiu+dHvtYq1tWusn/ZObKxAGVl8nNmPf/ImPj9rOhktdhXVnsWd/h1MHd
 ogPi93yZ7eWrJgZksypUt5u++twCWWWrw/UYfGPE2Wz9X9QvlURN1GjXprMMWZvxumy6
 fnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773686687; x=1774291487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ttFQZOfTjABcr/CRg+BE/xbEpdFtWOpPO35ThpdIfs=;
 b=oswwrpXJq048ggnWe1zw9AySRTa2DcSbvVuDLsFLMuay/BCAfNyyTSp12l8MUX7Vm7
 N3C6XC3gQ7i9Bx5YY6XkighfXHiC/PLQTXCYiPgYqv9pjUu7lpn1N9Yxmnzes7IDafdQ
 my4fyPYlOsA7m5IQhxLosCIXQRmwofJYDiDOjY8fJuZtuDiRuTurNqLYrJxbiRZI7Tt6
 Ehr7e+MrCANUPET9xp1AYgYbpHKQR2g59nNGhWj4cJaG6FPzlFVrjnRF7xIxfYipvpsJ
 9/GzWaAQ6G1aRpMZI7FFoGw++/N4KzgNsFdx3CtX0UubuVwj8E6ti94PlVnmTZJ/yVoM
 gw/A==
X-Gm-Message-State: AOJu0Yz6/ryEwWS3PbiIxhXpsZIoL/2PALhFLf+9/I1CFmcNxfTOYsq1
 vcU84BKQrQcnhJXh+nawl2svsNyUrSeaY67qJzAx5Ej8878KLcjgf5FHwlnu17o4UamHeyZXN4t
 NZ0NrCnZLyCFwsHveb2JztDfLEAT1WZgSbXpU8tXsLI8K7sf6r7EZEdGN22k55dbTHzn6YHwLvX
 gXOQc=
X-Gm-Gg: ATEYQzzsWvEVamEHtWGFOKWvN/7ydK40hyYXdJlRVu4a5GFBom6iaO56FlzFwScetlA
 ooYlxQpUe/MAUabl0gDKWQcH4zyuk/9yUocSwVh0ZPOt2ialfX6kbFhzqRbJyslu2Be6epxiaE0
 DZEyJW+q8EHfFXv1j36jbw4ODQpAPh+uS2EcSTtYNApW9Jn+EX55q07fYAOevBqM6jpmUWKZXY4
 qlel7i8NZ7PP95Uj5+R91TbLlZ4wHtIUcUnrVrrGu/DY+XPqDtlA0ZQTISS1J6sx3AOKU9AX0eG
 /40WOhpp8nbJE2H5hiIiySEF9GVCo/bSdPgn2TRLmeK/s4dER34Xw8qEsY9zQkPXfVqfUi1koiU
 GgHipSeDC5NyKOQiyw+iNpDlm5p8m23w1
X-Received: by 2002:a05:6a21:2c11:b0:398:80dd:5705 with SMTP id
 adf61e73a8af0-398eccf385amr12697693637.46.1773686687021; 
 Mon, 16 Mar 2026 11:44:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:2c11:b0:398:80dd:5705 with SMTP id
 adf61e73a8af0-398eccf385amr12697675637.46.1773686686581; 
 Mon, 16 Mar 2026 11:44:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73fc935ad4sm5615135a12.2.2026.03.16.11.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:44:46 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/vma: Avoid lock in VM_BIND fence signaling path
Date: Mon, 16 Mar 2026 11:44:42 -0700
Message-ID: <20260316184442.673558-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wGBweMFhTtvPK3YAvMGo0MGntQ41W9zZ
X-Proofpoint-ORIG-GUID: wGBweMFhTtvPK3YAvMGo0MGntQ41W9zZ
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b84fa0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=BjPo030qj9DsFgYBbnAA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0OCBTYWx0ZWRfXyotQgXA3pLfL
 jn+Xc/OLyZkMBYXVc1t9Phy1iLm/WDyGtqkQDl94t8iuamkhXGbvBB0KJV3SwOitPJPxiuavvZH
 tRv2mPYsxqCMRm8tmiK3MwXHaeg9xZMs1GJEmlLSf3AIXaaUHjk8nUI1/y66RfcuARFcnhJSfEh
 Oxrx1ksAHcQM9wzg8NFGZf1Na2iTHM2hl2P+3gzOHap7r07CaeKDAtTiDLo65V4SaFRg9pIWQI1
 KiAnsojBRpuLBBTI5Zebs/hkCMzLDAkyCS1vbX755Y1z1RzF+2EDLjMukU/VH2oK1oxgiHpMGTc
 8FJS3WGQgXJxHHUYrNsar/pOU4Gv5EDbJ1MsI5XTv0/FVdk5jOnoISttc9RWNA24Z2pNupejG+P
 LISCZfEquGgnVUmgQNwS6rkaDM1JE6HL8OCxLX4UPeh9YX2dEeQrtXOGKiHbT+3TDdd0O8Fp70q
 Pgc28SvkiNJDASBHiCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160148
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

Use msm_gem_unpin_active(), similar to what is used in the GEM_SUBMIT
path.  This avoids needing to hold the obj lock, and the end result is
the same.  (As with GEM_SUBMIT, we know the fence isn't signaled yet.)

Reported-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c     | 3 +++
 drivers/gpu/drm/msm/msm_gem_vma.c | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index da74f1413f94..74636646d80e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -507,8 +507,11 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
  */
 void msm_gem_unpin_active(struct drm_gem_object *obj)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
+	GEM_WARN_ON(!mutex_is_locked(&priv->lru.lock));
+
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
 	update_lru_active(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3a6c435d5105..1c6b0920c0d8 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -696,6 +696,7 @@ static struct dma_fence *
 msm_vma_job_run(struct drm_sched_job *_job)
 {
 	struct msm_vm_bind_job *job = to_msm_vm_bind_job(_job);
+	struct msm_drm_private *priv = job->vm->drm->dev_private;
 	struct msm_gem_vm *vm = to_msm_vm(job->vm);
 	struct drm_gem_object *obj;
 	int ret = vm->unusable ? -EINVAL : 0;
@@ -738,12 +739,14 @@ msm_vma_job_run(struct drm_sched_job *_job)
 	if (ret)
 		msm_gem_vm_unusable(job->vm);
 
+	mutex_lock(&priv->lru.lock);
+
 	job_foreach_bo (obj, job) {
-		msm_gem_lock(obj);
-		msm_gem_unpin_locked(obj);
-		msm_gem_unlock(obj);
+		msm_gem_unpin_active(obj);
 	}
 
+	mutex_unlock(&priv->lru.lock);
+
 	/* VM_BIND ops are synchronous, so no fence to wait on: */
 	return NULL;
 }
-- 
2.53.0

