Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778F9C44503
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B92910F1F0;
	Wed,  8 Jul 2026 17:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQascg2Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpiKrg+N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99CD10E657
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GL9RA3125817
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F2lLFVQBkCP
 nTnJ/UWIANHD/oq/CxWFvXtTUGL+m60Q=; b=MQascg2ZVBCkz2MZGg7FtMDgJ1B
 87BiOgr3V9ujZIsNHjPQsRyI4LMd+VdMBgTzr8YKwc8sw+SNY3bljU5pMzKKtbIv
 63JOTk7xaS+3XmregnEGcwOaoekNMPUE4hYVI4G/DTNUsTY4GQ3BCI+bywDvSDjR
 rLbMVsuo2XYZcKRHo/mSImoyZTWpSwChzHQ25q0wznPaMu7CHhydZOvENwqRBHop
 boYK1blOVuw4VtHkRtbNd5XarWswMf0hOXsVxpG/jdKAyzXY3tsMWFx2XMGG7GAh
 yP+izT2eiYnRvIf/DoZ5T8i/926wCgyVxv5evere+pu/J5VzT2mz1m/tvhw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s9a0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso11969465ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532076; x=1784136876;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F2lLFVQBkCPnTnJ/UWIANHD/oq/CxWFvXtTUGL+m60Q=;
 b=XpiKrg+Nweb0bGMnuyUnTbo+Kp/g05POxDcRfooQ3OLb6mPhcnahY6gS1cfeOwXHD9
 7YK4tKsWxVN86hQWZn7xxj/blZJ2cyKtSZaSdpUAFM9H0vN1Pc6HumXS7/h7R5lqxzhU
 n4/ZcaQ8b3hfZJkfDtqxl9rhgHNxzqIrgw4oMZNIPWCZx8524PzIdBnw130cxAT7QvWf
 kYOJtKwx/l9SR3LaqyAHKyxRkFOsOlqiDnXpeC9uwgW1pnAjFGAgXygK4bQC5Vtt5VAa
 cRkVhsH9cBZO3WBnlruVqCjcHucYJLFttU6EP7zuuhvdkhvk9j/L373VEscXDzNQ4Tb5
 uPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532076; x=1784136876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F2lLFVQBkCPnTnJ/UWIANHD/oq/CxWFvXtTUGL+m60Q=;
 b=BoJw51aNV/k+qWq5Q2aHFmLansK+I4v9BfWR6Et/LsVQKrn9dqgpdWajne3OpOE6mG
 C6Y8KR5p1eK2uC+jM0LHeguEpTaBHH29VvGoE04jIGM4y8tD4eqY+08tOlKOXVjmpedQ
 hlByNgZL0Ltd8NAtsK/XTBX/UAcNOn734FIVLNqNE9z/nJJ7fp9gGnyVUxN0gGPjztfH
 7yyMb7spbANyGmzxWUoJcVK27K0CcQMwaUfCehlR3dtduPBfCT+tc+a6enLnBAxBPq38
 1h4RIefQGq8MVEhQnhwx1Jf1ZRzA3lfbET5vjhdxget3E2gDTLQ4+dfITyP3oIXOFWpS
 62Tg==
X-Gm-Message-State: AOJu0Ywp+go32GAv3UIdDfVjn2uVd1IYLHnJax6pLpQWIGqdNTkKwlqS
 OYmdYsC+t6SJo06bdIHDEz/9llv8bpYFTEf3Or1MBhnKDCyts0leNZ8h4VZjOXyC50vLockTKB4
 uDFunv230nNNgJ+4Eo/5VyooJcA+dr5VN35udofgeoITMhw9QpxNm3lD5P2zbAc3UgtG7MTnjkd
 5UD4A=
X-Gm-Gg: AfdE7cnQEV0TxuqSapBz6UUJYI51XxogqN9T95mWiJOODAZLYnEAQKVGde6toT0iJLt
 hMIntoL5J62pbFul9Wmbi0o2o2xpByFB/xQ69KTHfpg7OR/P30XKiN0k5wkYC/hVtfEuLCa8VAP
 vT7I6K7bQ0im1ZUkVSi6RoUxjCXPjlDrMie/ka18bV+pHTJ4AZ6Nh9wDtUzq4PgN+h7xcZPOeTN
 ctY3BqIYRiH3POAHcyTzGl2HgtuWHb7qnFXc+dRTT65mJVX8IWKqHJVo1KrNCD0yDcV/dG6+Cw0
 mMcX09Cpalou80oO2F9SiCC/+YQisyLmneadPNgf5iSWwQfcbcT8M6K1ZvXbucStNueXn9X7GvR
 ev/Hsuc3mLhp7LxZNwVtSD3mDpYSEF5pddm8pMQfkUSK+LAkpfP25zoy+/g==
X-Received: by 2002:a17:902:f685:b0:2c9:e2c1:4fb5 with SMTP id
 d9443c01a7336-2ccea40b669mr33698095ad.22.1783532075702; 
 Wed, 08 Jul 2026 10:34:35 -0700 (PDT)
X-Received: by 2002:a17:902:f685:b0:2c9:e2c1:4fb5 with SMTP id
 d9443c01a7336-2ccea40b669mr33697755ad.22.1783532075114; 
 Wed, 08 Jul 2026 10:34:35 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bfb7aesm31438345ad.29.2026.07.08.10.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:34 -0700 (PDT)
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
Subject: [PATCH v4 3/6] drm/msm: Validate lazy VM is created in GEM_SUBMIT
Date: Wed,  8 Jul 2026 10:33:51 -0700
Message-ID: <20260708173356.578713-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX3G2n3p8vTXEz
 mo/tzV/2kLzPA1T/vxoizkpGero2L3pAbQUQZVsu3JfeeQSH8qCHUShdGfFKhcd9bLywERlTYfR
 6ININki2oYYdiF4H/AU4ovARkWjm8+qe75HWEMova1WcmWFQPd77ZB0I8tKZXCuRl9LW7SYqD7n
 FFJkaDoxR62edC6ZA9gBOozM4n8eVl+cN+o5Qv07+UTz19KdQ00fcNKBy+9LhXjNTJfMdYSlSUJ
 pfNeENTJuc4PzhHPOyGdguEbUcrNXW1hfOll+U9H1iiniMg16b8HeSnB3dWO3gY0GBxbHHj8Lox
 nib910bss65niwtMKxWyUbtG3CH1NymWQ3Jbn03bsC/7PujbaCfi200Is2DB68ZBJI2n0EQ7FLp
 evVckyZ5LGCBrJ7/P7dgalaZG+IBkoPkxX2wK81mRqcYjJQGxBcVxg4lwCWYfa9kbCbMpMnDHII
 LosIqk5Rj67EdwOWe9A==
X-Proofpoint-ORIG-GUID: -wyZv-byY_gQe_xJiC2wPIKv343Pu6gH
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e8a2c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZH_LIYEqPuu6AAuj7cUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX6z2ZNHNtvPe8
 KkMRAw6oRkl77hoLoRcAw7Dmyrayu3sZ3sET6B+Slj9beBORjW4Cgqe4vj3QD6+a1TmXTbSn/d2
 VowRo4kanaVvzZL1e3PkihN055zCIqE=
X-Proofpoint-GUID: -wyZv-byY_gQe_xJiC2wPIKv343Pu6gH
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
2.55.0

