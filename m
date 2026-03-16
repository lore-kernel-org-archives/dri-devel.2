Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE1AFB5E83
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A7410E410;
	Mon, 16 Mar 2026 22:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WYeNt/Vz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4GqEei/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A0B10E527
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:07 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GKnsKQ1623660
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fsmwNOdowI2
 irHmpBpqjFmGIGle+yKJW1O1LMz6nMl8=; b=WYeNt/VzlVl2SyKYh/sQcC2mT+z
 HiX7soshfCMz1QYooUs7E3nnt45s4tcWmVZ3mjXPCfghCBoLxb5xn6dAlc5hiT79
 71W+wQ7jb3NDVoZ4k1kVkIAgdQ+WOkAFJXaChY8COo4+tZWW5DJnknMb9UlDXLQV
 74JfPNtjp09SNeH8vcpUMdkDuqmVBuKB7Ix5mDwfxBZ+swXhM+wlEh7nUF152hv6
 2nPlDzmbAgbnlQrHzGZEpdc76sgBFG4qxBhL9A/po9DjmUYJKh4QxzK8qhlH7v1O
 sdMSqQllrHVf6QNnusoOo7Y8x9FXiUjJErICbTQB3GNY3TwpGTUuWg4DSjw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxhyej0xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae4b96c259so2415475ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773700745; x=1774305545;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsmwNOdowI2irHmpBpqjFmGIGle+yKJW1O1LMz6nMl8=;
 b=L4GqEei/8/Vz0gNoKI/A/ZB0Oycuj5s2TWNM5E1sal3OfKbTGzhsvrPXobzjKJUCf0
 RVnknFLK9UH9MZZwM5AAH/8pco4C1zJsKBNl+6kQYJDz8AQ/G8tGzP2UkGpvigwnljBb
 NxbUxWAq5xVXf9LD0zfg6lddZK+yrEHYJcjNyaPQ/kbKgmSgYdRFNCykTbhEwkeqt/yE
 L02lEmQOEBoRZpRKtqHBF4vsqv8RLtVunx/6LfPp2NDFyX3Vc44bFDk9mowBZ7UUxuNS
 3ftjk4wYRr1cm4272vud6n57CVRhuQYwRMYVUF6VANVaHI9F8KV4tsf3sUcS/D6LkyMX
 Lj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773700745; x=1774305545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fsmwNOdowI2irHmpBpqjFmGIGle+yKJW1O1LMz6nMl8=;
 b=EVgUomTWvc0tAH7UQQ8CuMQ6IF9ebzc28d1eO0uwlQO5MR7vBPzd2/ozTsYZqb2a5D
 KMirPkeQU4rCkW+Pr+xik3toPmjUDih8diPZSCS0wEAGmo4uSI/0ThyJUz6aUG1iDfbo
 qwenikv5lKYlgwOBBZ5Nzbxnh071N3DhpsR5FX44pqFi2lNh8nIrDrpGykn0pylFG8y3
 VY4ZuQJs7SGttPyoureIVSgs6DimXCvenjXt4xSMiglwlIM6C0fLss2zKpd10klZgdwG
 zH30a9t282Tcuqm6P8oUFmOKnZFZpT6pIl7y9jn7T4NUjxp+mDtyFo04bSScJHAvskj9
 Z8Ug==
X-Gm-Message-State: AOJu0YyMWUjZcTBCen4b2VWv4zCrzjzemzMBaI5YheRREh7cl69BHNm7
 eHMY0Su6NM0p4rFnxX179Pg+zCFcDMPs+KGkazskxgifyR6mE8UV+g12Ix/UoUbXpZ++KnRGM4c
 tj/LbY2Br2T9FpJN84GiS9vUlHY6U03kARuzJRIAbQD5rOm3JwGL8/iCqcOKb1Qojxzv02ViPtp
 WiXm8=
X-Gm-Gg: ATEYQzzEF43+3EpVhrXLBuJbesYwrMAQmkdMeTX58LRDTO7IAiRyUH0haPMQjSZOlJD
 WDx82g0wPWd2/quKWES/1NL8iZlt2XvFhRFEhskls2lIhxsuIrel2EQf3lBrxlUlvWNkdsehJo2
 hJgRbSmGjkKxrZ7VyPTQlF5jqbGdlfsF40YvV0kdqR/lS+W6SMKOj1AVbjX+klRRmAMjMcJGJeD
 5wM6ZDquCcYtUgin5ipZVsBkjfC+p4jnnlD/QxuJHo58xIj2B11YSjlMtSLDf2n/NAm8wcJMoMo
 7M70vJtAmtmxJYOTQuZvqom6mSFE6NelkgROiqmpQ8MHHGgzE2pN3AvXgwZw3lym7wWakhtmzmE
 ia//F4x+CYHKiXpE7TwBmg5wZfcEyMYYE
X-Received: by 2002:a17:903:283:b0:2b0:4fb3:c771 with SMTP id
 d9443c01a7336-2b06357ea62mr10456745ad.6.1773700744825; 
 Mon, 16 Mar 2026 15:39:04 -0700 (PDT)
X-Received: by 2002:a17:903:283:b0:2b0:4fb3:c771 with SMTP id
 d9443c01a7336-2b06357ea62mr10456475ad.6.1773700744288; 
 Mon, 16 Mar 2026 15:39:04 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7edd1fsm152594935ad.47.2026.03.16.15.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 15:39:03 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [RFC 2/2] drm/msm: Add sysrq_kill handler
Date: Mon, 16 Mar 2026 15:38:50 -0700
Message-ID: <20260316223855.711574-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316223855.711574-1-robin.clark@oss.qualcomm.com>
References: <20260316223855.711574-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PwNnkU3-7iP5A7DQ5cjb9AycJojyEN6o
X-Proofpoint-ORIG-GUID: PwNnkU3-7iP5A7DQ5cjb9AycJojyEN6o
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69b8868a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=s7vrW_VSA_84OnxZi_AA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4NyBTYWx0ZWRfX56JIWHZ0R2n2
 2hCG8sTju+jn6UOHwOZbndC6v3y+v9J6UuNG0vEVUksdzB3qFvyrNWX84j7aCYOVEU8uurPhYjp
 5T4wdn846wxarCm1bE7i/TVuIdL8IwHp6gA9vJfalE2kvJp/gGh3IEzYlHeupxTXeOSESAqug3o
 oEs2bQScOGHhV3wVMae37F+B9D1nVU9Qzr2Jbg52cYBcxM0we/kUFydAf/dmuGCzeE0Wm6KtcOs
 G2tY7bd4sTmU6SOjwCezYzGh5m7LbX3CAY7hraW0jto5Eh6FKkF+nDImd0a4I1Xz7rd2zwrYqOv
 rsfiFQttNf/fnn0oEDoIszMeZqDu7yO52vn95EbanEMPTDd/nZgV3GpVslz5cRZF4YDq2dfkIOB
 DfkcrR/mb9lKHG2L/6brqTpTydYD5fJp4jNo+yMY36G8uSgrVr7imW/Fvkc3IKtKhdQOG7OAggZ
 FaPqbc/eC1SgSgKUCfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160187
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

This does the same thing as an immediately expiring hangcheck timer.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 12 ++++++++++++
 drivers/gpu/drm/msm/msm_gpu.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ed2a61c66ac9..ac04d83724b9 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -812,6 +812,16 @@ static void msm_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_show_memory_stats(p, file);
 }
 
+static void msm_sysrq_kill(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+
+	if (!priv->gpu)
+		return;
+
+	msm_gpu_sysrq_kill(priv->gpu);
+}
+
 static const struct file_operations fops = {
 	.owner = THIS_MODULE,
 	DRM_GEM_FOPS,
@@ -846,6 +856,7 @@ static const struct drm_driver msm_driver = {
 #endif
 	MSM_FBDEV_DRIVER_OPS,
 	.show_fdinfo        = msm_show_fdinfo,
+	.sysrq_kill         = msm_sysrq_kill,
 	.ioctls             = msm_ioctls,
 	.num_ioctls         = ARRAY_SIZE(msm_ioctls),
 	.fops               = &fops,
@@ -885,6 +896,7 @@ static const struct drm_driver msm_gpu_driver = {
 	.debugfs_init       = msm_debugfs_init,
 #endif
 	.show_fdinfo        = msm_show_fdinfo,
+	.sysrq_kill         = msm_sysrq_kill,
 	.ioctls             = msm_ioctls,
 	.num_ioctls         = ARRAY_SIZE(msm_ioctls),
 	.fops               = &fops,
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 995549d0bbbc..6b1c284ad631 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -673,6 +673,24 @@ static void hangcheck_handler(struct timer_list *t)
 	msm_gpu_retire(gpu);
 }
 
+void msm_gpu_sysrq_kill(struct msm_gpu *gpu)
+{
+	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
+	uint32_t fence = ring->memptrs->fence;
+	struct drm_device *dev = gpu->dev;
+
+	if (fence_before(fence, ring->fctx->last_fence)) {
+		DRM_DEV_ERROR(dev->dev, "%s: sysrq kill job, rb %d!\n",
+				gpu->name, ring->id);
+		DRM_DEV_ERROR(dev->dev, "%s:     completed fence: %u\n",
+				gpu->name, fence);
+		DRM_DEV_ERROR(dev->dev, "%s:     submitted fence: %u\n",
+				gpu->name, ring->fctx->last_fence);
+
+		kthread_queue_work(gpu->worker, &gpu->recover_work);
+	}
+}
+
 /*
  * Performance Counters:
  */
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 666cf499b7ec..07abbe33d992 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -696,6 +696,7 @@ int msm_gpu_perfcntr_sample(struct msm_gpu *gpu, uint32_t *activetime,
 
 void msm_gpu_retire(struct msm_gpu *gpu);
 void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
+void msm_gpu_sysrq_kill(struct msm_gpu *gpu);
 
 int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
-- 
2.53.0

