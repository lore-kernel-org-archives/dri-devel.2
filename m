Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58905CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA00E10E251;
	Thu, 25 Jun 2026 19:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gC9PAyCO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYs1qmu+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE1710E24C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PIQkDp1196810
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7V7Err/Z+6B
 Igi6OReMeeTwMA3vE41djVqJiMjm/22I=; b=gC9PAyCOZ5Bl5QHzHhezRGKj3sq
 tUw9NpPq9E5rpuZ0GVmFyDTb3DaB5kHRPf9bWFqhvsin/ejgfKcrrPzhcvpY/yCj
 1i1tr5ju8PES7NbSmcWvCxZkxD4vqDIiupI1szSPHvljElaYnfzlQnK4HzVpdQfc
 04q1G38bC4ktyNO1OhLrKQ4ixWOQjRvqihhMQMg917QUZFMygYzHtFzyZ0lmzXd9
 3j6LGnvR038ehGflw7CE4Xb5Yss//Re+YrhpvVSA2zaZpXBzLhpdSBrEhB+wNVE+
 8RvFZbiyqefhDeakuwZbGChxw08/gosWo2uvIVNvxtpPlgKpBYq7TYIB9GQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3r61s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:15:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8454912a507so108409b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782414946; x=1783019746;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V7Err/Z+6BIgi6OReMeeTwMA3vE41djVqJiMjm/22I=;
 b=BYs1qmu+bfU3O8WbcF/N0/7zTbLBLXpLqCAvaUGo6I/h4vjh0PcxIkgXTGkSXNH8AK
 ICvRPfnUq8R3n/srdXi+MeZRew7JAcBiJFUvBit47O4a9jLFMMUGssqROXQk8zlIDuZR
 gXLLMGk3006pNYo/Cjb/WoBOXJsaGOmwCMOZy3pOCpBrnoVHUdztMDVTv/jFwCyDJcRR
 nojEyHIANXhPVG4gyxmrA7Y5u99ll25Vl5nIN00UPxSHHVTSuk5D8k5A8UFabq+b7RIQ
 2Yuc1jqpl6oW5ISJKgRjGBLHqVJzTQm1/0pqwyaRVslnhshaRlHuv+YxyUp27XCVkIVR
 3+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414946; x=1783019746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V7Err/Z+6BIgi6OReMeeTwMA3vE41djVqJiMjm/22I=;
 b=OtqC2WV5AkiAlT8W7kHYEKM2PveV5jCfF5Vo8H3MUCBuSP0cpQ/pvsoeRKgMlMO4gE
 boORYGudNLNaM+kINZEvPGWezx/Vis21OMcLC5GnjkY0VrGrrWTE1Zbrm2Zcd6Ng5J6D
 rzaQzXsqG01oBzFyNgNCh5sD9ux0Iy1gEvy6U02352DLy2+7U/DKNIOg4pmJkH4wRf7H
 gmAuQTBz8PzKngQSdmun/i6Okk6WQPw0x022X4rii0PXaehEbT6a//I8g+plrbYsA3nl
 +OiR8OjmVCMBhioz5WPrcayOkP9zj/LcbyZec0AD3SObRxldikusdcUVMVWX53GqUPHY
 fryA==
X-Gm-Message-State: AOJu0Yw0wksFqZaYkD+ouvPotHkhE6IvfQ+CoG/A888uYtkIfTbZjokc
 9456bQaQHxkLrbvZbsbenc0fwNWZsJkAPZ0zHUhk6dMussEhWXyCcK71j0wTCwvFjjdFqiJpefU
 /0Qr4IghEHVge/YopZfionHe6gQ3OHlTga7krPP5hVfieO/8qt787RhJZmjf4joz1TlFxZSz10f
 /FPUU=
X-Gm-Gg: AfdE7cmZUPUNWhH3a62FaBc3Zsmz4WOsklc76dyc0KPFWJoaYw/H98q9L5eZaPKiuni
 6ZFpjxAlmtBT3/891JEz9ixclI1nQ+vsAnnAHB5xX3M6QbwdRWXremqHsZolhXDOtqThHdxIkzM
 kXVgxWpnU/7mHPoY5Nbfaha42++vpSBVkd9ZmK7buIjecRVVSrVI26VXcAWCoec7Ww/gKmg1waY
 sXVNRnT8R8ALWtitd0B9oQl5qnFR7fe7LSwjOjQ9NXgxNx6bNEPtSwVOxyE79Hki3iyxqSD8zZG
 uUBzqoVhMf8DYwEYg0QijJV/j8G+ewBRPAWDqCWTUnXLjv9fdbBBWehcQgxQlHGUYFG7aiAYwKc
 Dix4f4ZyuBIF7vrilqlEh6yIaCmcs7AKCPPnektll7kdbb7RAlTtSNRDndQ==
X-Received: by 2002:a05:6a00:10c5:b0:82f:425b:4c27 with SMTP id
 d2e1a72fcca58-845b3abb83amr4599820b3a.14.1782414946113; 
 Thu, 25 Jun 2026 12:15:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c5:b0:82f:425b:4c27 with SMTP id
 d2e1a72fcca58-845b3abb83amr4599797b3a.14.1782414945593; 
 Thu, 25 Jun 2026 12:15:45 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a40d2459sm5133513b3a.32.2026.06.25.12.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:15:44 -0700 (PDT)
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
Subject: [PATCH v2 2/3] drm/msm: Validate lazy VM is created in GEM_SUBMIT
Date: Thu, 25 Jun 2026 12:15:34 -0700
Message-ID: <20260625191537.47965-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
References: <20260625191537.47965-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX5PQcZB6WorE1
 QJ4O3MrgNfL2DaxjcGnpTkcN9yciWnRtiTNHfWap9zW3ZuQblpAE35ApKsM2xZH9+xxvWqgozW6
 7hvlgVofvMUgZ8lB2UceguFDNKspO9k=
X-Proofpoint-GUID: HvNmu0YyalKgW-1GEEJQSGbUAYgkdG_5
X-Proofpoint-ORIG-GUID: HvNmu0YyalKgW-1GEEJQSGbUAYgkdG_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE2NSBTYWx0ZWRfX5EB4ri8G6BUD
 dRqWZAE7LDD1UigZmXr3BpW4/e6+CjR7T+U6DYnjnZmeskZJSI3WUeOfVvsrTz+4UGrRKQDjOpn
 qJV2gXEbWMkz6v3rhTGaDsPYcLl6s6ZTrr3Y4yG8LEUICUYo9TyKOZk76mHU7VEevj4abvEHUwE
 i04U8dFj/7vU7rmToyaDkIKmEt1CgDfE2qGKqm0ejGCF8Zqaqu40e2mlBWq9dlfs8KU9v2RIWlv
 B3w1KwcCOjgsyuJU+1IRHzF4eXc4cdFwOs+fl1yTJpEOHOTCeIYuad47bHfJlE22NgdlbbWYZzt
 Nr5BUdBy9Bn3n84DDU/6VD1yRT9356VBeR26OlJ6sv0QOA/rPh5TvSg3FHAU4GfeKOULy61V5+V
 tFU4k6auswZ0rmLMrk2yEeFKuGjqzh4X+C5heS52eq9aGomS6WZrP5dC+yzwEUA4OowR8gGZF4f
 XUB2LRkU0Zk/bjAhqUA==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3d7e62 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZH_LIYEqPuu6AAuj7cUA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250165
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

Otherwise a GEM_SUBMIT ioctl before any BOs are mapped could cause a
NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 6a4d287a1ae6 ("drm/msm: Mark VM as unusable on GPU hangs")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c6bc90c3d48..56929e821200 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -30,7 +30,7 @@
  */
 
 static struct msm_gem_submit *submit_create(struct drm_device *dev,
-		struct msm_gpu *gpu,
+		struct msm_gpu *gpu, struct drm_gpuvm *vm,
 		struct msm_gpu_submitqueue *queue, uint32_t nr_bos,
 		uint32_t nr_cmds, u64 drm_client_id)
 {
@@ -66,7 +66,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 
 	kref_init(&submit->ref);
 	submit->dev = dev;
-	submit->vm = msm_context_vm(dev, queue->ctx);
+	submit->vm = vm;
 	submit->gpu = gpu;
 	submit->cmd = (void *)&submit->bos[nr_bos];
 	submit->queue = queue;
@@ -554,6 +554,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
@@ -572,7 +573,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (to_msm_vm(ctx->vm)->unusable)
+	if (vm && to_msm_vm(vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/* for now, we just have 3d pipe.. eventually this would need to
@@ -609,7 +610,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds,
+	submit = submit_create(dev, gpu, vm, queue, args->nr_bos, args->nr_cmds,
 			       file->client_id);
 	if (IS_ERR(submit)) {
 		ret = PTR_ERR(submit);
-- 
2.54.0

