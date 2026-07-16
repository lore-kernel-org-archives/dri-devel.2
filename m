Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CFDC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C27D10F3D7;
	Thu, 16 Jul 2026 20:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWEy2sK7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eos+Fa7H";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E76010F3D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoY6i3753467
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LujJ1KSO930
 tqHv74HoyQH95wcpHqgeGc+KYfb6IauA=; b=SWEy2sK7bVkSPkLctO2/qGLzYqn
 T3OoftgwKAXQTnMvEnnY/rpg8I/tJZaJfiOlbwI6fi/VPN+gKFOs2gU42xXZbr+6
 ltTP8Zqvcd6sDblciL+IRUhkjLZOw9AuroDajEZ4MRuqleFTc67JZ0drxq1SahgU
 9Z9lPKoj+s1d9Y6sSGubfP7NeioonJ+S0R1rIiIqkKqKXnfe2qnbTpvJGuxkGN8O
 8oLLPya0iJrCyQ5d0hwpxD0ae4ljpAV169AYXYR9fJZv2WMkG0lt9fS8cU/bDRw6
 M35Kb95HWQsuyeoYh3M+CGP9bqJlZWzM1lmqxhi6DdbaUG/yM9RD097Kptg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex35ns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cce02cb769so46832285ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232958; x=1784837758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LujJ1KSO930tqHv74HoyQH95wcpHqgeGc+KYfb6IauA=;
 b=Eos+Fa7H21fsQ+Xwjji42yieOcLw9A3NoqWkdxK+Hj5X4TUZM8OB00HXAsioHtAZlb
 NQFPq/y4+2phx/t0UGWOiJ1QFxcmKi/ezZvFduY4B1exkZ4qSU5yNmH2arf3blrnfzZ/
 /uTN9ZtpW/5ouEaSXj82mo90+5VkBXfQn65VoM9LJ0SyPvcO6NGjIjRHORFUM/gbu2fA
 LT0pOYKmbbv+xY+hlea4DkW1USXTrylvt+NyGLSOlB473Y9XTS7IR15MdDi52fIm9Py7
 /Qy+zt8AwotXRcNNUKp7mo79Vzu3S/cCQ2bfpCIm7RiOaQUrl3hCdjCzSOKsQAjrEee/
 375g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232958; x=1784837758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LujJ1KSO930tqHv74HoyQH95wcpHqgeGc+KYfb6IauA=;
 b=MNM+ZQV3onRL3g2AETXKx4EVQO1TqLFmi4rdBwS1WjnfWDYsk28d9ZMpYgsk+7yr+T
 hKouEO1vQl0Q+2JXVAcXDDA/eT9mVNuhe2CKA2zEuOKq3ZViXDdSvj+rDxI1a2T+uhbh
 8MhXLSitAK6nRruxLs9F6I4F3wnpGoQSgCzBPst4wNWJu5fi6OtNrQn7blF7xsp0VsMf
 fan2vp+HIkyMu1XI5b5hzgQJkCfssd2+ilP3ppnE1FQWooTgGqLY+Qd0kSWQSCL/c61F
 PEiL2llA1Nrmd9em2c9QiEXYy442YTxpA5AREJeENVPnPjmUXrbMFi9cOEYMKz6DgnqI
 nBMw==
X-Gm-Message-State: AOJu0YxNm+5BMv1dPFHyDR2okoo7NZSb/9E0OlZT3L3hlKwPlM29WDoX
 p55ime4U+7V6ulgSldteONXLic1rSxMtQN/ZhLJAixfJjgwjfT5E6Vekn0mp/z5pajQRB+t55Rm
 KmT1l+fSGel5sev1t+mB34wqWftLv8nr6X9V9tTyFwgJKUGxnI/06YaRA360rwUwWwSffBghEWU
 gddA4=
X-Gm-Gg: AfdE7cn1xfEzLZTUJdp1EpBjJLIRbHPXwoPLfj3g9SNg0AaEReUSnjB4uVIzVmhoDUS
 roOyvU0fJtpopuCky38jSBDKYWZ6CC6PQv7cuC46CIlBBAD2SWbU5AvkYrECRIlqIzN2/DcRb34
 N3TzuwXI/m70quRWe3nBTkaYMiqZvUzfR33efsSQ7uLF0eykf6TgxzRJdnuCtmTbos2F3BxOcA7
 qf2R1SSqw+uzR5fcVhIFRky4qhwfP3eomtfNHEOLLNHF3qN0/eMtp/ffZXuosNzbmb+hu21N4fS
 c0QhTDTjQawBq+JK0ZSZdGv0n/95Y6HAwu0H4DpFp5vbGgZfBdDJVL+SjsfeMjrYsSqEVQI8dF6
 UnvYsSMwlY2qvuFvQv7ZbnAfuxQN/KeYXT2scB9fEQmwWIgo=
X-Received: by 2002:a17:902:e884:b0:2ca:106c:7122 with SMTP id
 d9443c01a7336-2cf2ea5094bmr10160845ad.9.1784232957695; 
 Thu, 16 Jul 2026 13:15:57 -0700 (PDT)
X-Received: by 2002:a17:902:e884:b0:2ca:106c:7122 with SMTP id
 d9443c01a7336-2cf2ea5094bmr10160475ad.9.1784232957120; 
 Thu, 16 Jul 2026 13:15:57 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf1073a3c2sm24865685ad.83.2026.07.16.13.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:56 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 06/10] drm/msm: Allow lazy VM creation to fail
Date: Thu, 16 Jul 2026 13:15:29 -0700
Message-ID: <20260716201538.365824-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a593bfe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=RFCq6YHzeVPHqihPuhoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: RFQKnEGWdBS5p-QzM3ROKDKNCZfxIBXZ
X-Proofpoint-GUID: RFQKnEGWdBS5p-QzM3ROKDKNCZfxIBXZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX1FsTW+2vOA4Z
 YI5VSEeWuKWqzPDS9ymWoH/pFg6w+pnJ6Lf5lYXeqxByc5QaeD/1V239vY2qSObLcTZnA0j/pG4
 LQhRWmCQDrFJH223tAFV29WnBPHe1WQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX2A4bB1cN0hRw
 YDoBh5vRPJlq07ghZPFxFZDMOAhBHwkbZA6Qafok8KQ2dFEdUWDGTUPxuQb60jdrLIqsuw1XsgY
 BQn7qHVUAMVxKpnq3Zn82vC0lZh3x2HyECNmL9TV5RmjZ1ljwbpj9CGzMBCyolz0PCMIuv+tleW
 SmgyhEDhDnfzz6LRlV8PenzTxDhS373MzkuUneYaT+m7QBvZ8JASqghp39qv/DilLLPepizqkac
 8GTszOwCDRfceVADwHis6YimblYjMRIwdDUhqtKu94Y66pG3CKDVl+gh3qJAHsBX3Mb7TooVioD
 hAkfM+lNxGJNDRyDywOZL8FgmOOrGPbupwVZssVBQj9SE0BFgpsfTlFr47V1dobErHmqbWeVaEl
 bBfYFveRKMEGwgI21MHiqSpZ1/1BzDcfjZvCTF40jK68unLSbFRVUjN45ns3EvtIy56r6VWvQkG
 5s3tIk3VZli5pZ/EMQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160206
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

In the next commit, we'll stop falling back to shared VM if private VM
creation fails.

This isn't expected to happen in practice, it would either require small
memory allocations to fail, or missing support in arm-smmu-qcom for
setting up per-process pgtable support (ie. missing patch during
bringup).

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c           |  9 ++++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    | 12 ++++++++----
 drivers/gpu/drm/msm/msm_gem_vma.c       | 12 ++++++++----
 drivers/gpu/drm/msm/msm_submitqueue.c   |  8 +++++++-
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5738eac9aebd..84101e534ebe 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -359,7 +359,7 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 static bool
 valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
 {
-	return (vm != gpu->vm);
+	return vm && (vm != gpu->vm);
 }
 
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 2fd1b717d8e6..52ff72d8e17a 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -422,10 +422,14 @@ static int msm_ioctl_gem_info_iova(struct drm_device *dev,
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 
 	if (!priv->gpu)
 		return -EINVAL;
 
+	if (!vm)
+		return UERR(ENOMEM, dev, "no VM");
+
 	if (msm_context_is_vmbind(ctx))
 		return UERR(EINVAL, dev, "VM_BIND is enabled");
 
@@ -436,7 +440,7 @@ static int msm_ioctl_gem_info_iova(struct drm_device *dev,
 	 * Don't pin the memory here - just get an address so that userspace can
 	 * be productive
 	 */
-	return msm_gem_get_iova(obj, msm_context_vm(dev, ctx), iova);
+	return msm_gem_get_iova(obj, vm, iova);
 }
 
 static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
@@ -450,6 +454,9 @@ static int msm_ioctl_gem_info_set_iova(struct drm_device *dev,
 	if (!priv->gpu)
 		return -EINVAL;
 
+	if (!vm)
+		return UERR(ENOMEM, dev, "no VM");
+
 	if (msm_context_is_vmbind(ctx))
 		return UERR(EINVAL, dev, "VM_BIND is enabled");
 
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c6bc90c3d48..ab33d499a0e8 100644
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
@@ -569,10 +570,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (!gpu)
 		return -ENXIO;
 
+	if (!vm)
+		return UERR(ENOMEM, dev, "no VM");
+
 	if (args->pad)
 		return -EINVAL;
 
-	if (to_msm_vm(ctx->vm)->unusable)
+	if (to_msm_vm(vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/* for now, we just have 3d pipe.. eventually this would need to
@@ -609,7 +613,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		}
 	}
 
-	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds,
+	submit = submit_create(dev, gpu, vm, queue, args->nr_bos, args->nr_cmds,
 			       file->client_id);
 	if (IS_ERR(submit)) {
 		ret = PTR_ERR(submit);
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3ed05ab0eeef..1fd4789f2be3 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -954,7 +954,7 @@ msm_gem_vm_close(struct drm_gpuvm *gpuvm)
 
 
 static struct msm_vm_bind_job *
-vm_bind_job_create(struct drm_device *dev, struct drm_file *file,
+vm_bind_job_create(struct drm_device *dev, struct drm_file *file, struct drm_gpuvm *vm,
 		   struct msm_gpu_submitqueue *queue, uint32_t nr_ops)
 {
 	struct msm_vm_bind_job *job;
@@ -971,7 +971,7 @@ vm_bind_job_create(struct drm_device *dev, struct drm_file *file,
 		return ERR_PTR(ret);
 	}
 
-	job->vm = msm_context_vm(dev, queue->ctx);
+	job->vm = vm;
 	job->queue = queue;
 	INIT_LIST_HEAD(&job->vm_ops);
 
@@ -1430,6 +1430,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_vm_bind *args = data;
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 	struct msm_vm_bind_job *job = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
@@ -1444,11 +1445,14 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	if (!gpu)
 		return -ENXIO;
 
+	if (!vm)
+		return UERR(ENOMEM, dev, "no VM");
+
 	/*
 	 * Maybe we could allow just UNMAP ops?  OTOH userspace should just
 	 * immediately close the device file and all will be torn down.
 	 */
-	if (to_msm_vm(msm_context_vm(dev, ctx))->unusable)
+	if (to_msm_vm(vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/*
@@ -1479,7 +1483,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 		}
 	}
 
-	job = vm_bind_job_create(dev, file, queue, args->nr_ops);
+	job = vm_bind_job_create(dev, file, vm, queue, args->nr_ops);
 	if (IS_ERR(job)) {
 		ret = PTR_ERR(job);
 		goto out_post_unlock;
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 8b5980d5a6a7..9a4c4e6425bf 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -172,6 +172,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu_submitqueue *queue;
 	enum drm_sched_priority sched_prio;
+	struct drm_gpuvm *vm = NULL;
 	unsigned ring_nr;
 	int ret;
 
@@ -184,6 +185,11 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	if (flags & MSM_SUBMITQUEUE_VM_BIND) {
 		unsigned sz;
 
+		vm = msm_context_vm(drm, ctx);
+
+		if (!vm)
+			return UERR(ENOMEM, drm, "no VM");
+
 		/* Not allowed for kernel managed VMs (ie. kernel allocs VA) */
 		if (!msm_context_is_vmbind(ctx))
 			return -EINVAL;
@@ -215,7 +221,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	queue->flags = flags;
 
 	if (flags & MSM_SUBMITQUEUE_VM_BIND) {
-		struct drm_gpu_scheduler *sched = &to_msm_vm(msm_context_vm(drm, ctx))->sched;
+		struct drm_gpu_scheduler *sched = &to_msm_vm(vm)->sched;
 
 		queue->entity = &queue->_vm_bind_entity[0];
 
-- 
2.55.0

