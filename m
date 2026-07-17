Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A55C44525
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746F410F610;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CbMI0vBw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i58X298b";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3CC10F608
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:11 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtQHR2619456
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S9p22RaEXCQ
 i7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=; b=CbMI0vBwvX7bfkJb4TlgCDXZEcD
 J5xg4flYLXn+6Zb94EIsnSKDpxEsKRfbxtSEQBYNAZkp41KCZMRxWDHoVAQ6AiQi
 xjkZ/H3jXE30GEZKy83iGJd1PZR8f2HSJ3WYWWZ2gJqoALdTmiov+CVXx9FlI1n2
 r758aJEgjP5Zsm+JQ2YLSQ8+4JU9efbmH0qKMCns1HSLK23KVsRWmqKFn/Qrrctq
 ci0wPGrvO3EdQQqe66l78bb88noF+OfKy5ncnhQjN8ZBfPahvq/JfRpUr71wkc3m
 zOFxRReoAniGBNBuUrcVfn+TrK97t9fwRd057mdM0olSpTEXin82btHi7AQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffagb7gv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso3951024a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321350; x=1784926150;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9p22RaEXCQi7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=;
 b=i58X298bJwAhgmZ8cEDGufB89DJY9ODOwHYGsNUIYk6Ma2Ntyim4xn4Yv3C1WYh2wX
 7F4mdYBjK2Bk0LTpFL7INkBe07FcfxXeM8p9uZGI6cjdj5D0YHeZfeKMOiGYzREK5394
 CfbanDUGktS4Qd/Pf7rT53wSTdlDjPbiQFm4snLKutRInNZie3wbWUY7zx9z3ybgJvlX
 ybS6wFdPsNAQDWMYb2psu1ZV4ESQ6ksMdARDkVHkWKl5aJUHMNSnMrPwVcFiD67wZx4z
 RXJMUCsk7DvIFnZrXEPl/ANYiyEotBiXv+o8VxJONhHdHOZFVBdDRxru/GktfYi4b2yk
 fWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321350; x=1784926150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9p22RaEXCQi7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=;
 b=eh6z/sG+KWpwNXIRLKK5sAt0ALhKsBc+YmJxxlTFPpvhOPkDsHgEXx4Ap/pr6sEF7w
 /w9b+RpWJz7HRvU0kyU0qAxnbQVjKNLvssR9jK+4oNfE351iskmEXXfaSuieympIHVFo
 BqKwwClxncqRAwEuj7tK5RTehTbHL7xBJPdQK/gX77cdgc1FOtI5UQTqXxxfeiy0ze6S
 aQI9BZt8TjkklWGSBIu9UHgj0TErSvRjXUl11h72sV9bH52lLd3pMuYga1JW3XUyXxfg
 Bm0qLO0VSaD/WPYH4IznV097JTZ2bOJypv7ggVaSLxnQKUU2Mq0ZS2br8cP/qzc8bXjc
 DJEA==
X-Gm-Message-State: AOJu0Yxdaf2jsouaHrH0G6hix+9qks6xCUFEaCIi54aX4T9ki/ELEqIj
 ubADCLX3+O2yHd5Db/tLTLB+CeuG5ZyywEJHxA8bcfoT1dgsLammYuzmHis+P6VnFwZHGLgF34z
 5Wrt5CRlI+kPwhu7bEdZ5l4Q70UXjFpndBox7UiCYy7SsqCgQ+WRLuYfKhu+rDJT0piCIHx/t4u
 6M/4E=
X-Gm-Gg: AfdE7cme2JGmg5j0UzkF4GfQ2Z0H8oEy3o8J5cZaj4Pobw+YSqKsq3vAkQpsNuuwhwj
 wTuoMFb8SUe/2Gfk+tVmW+j4afJFQfAh6QuKxvlMf+EYK2t/MiXWxKJ231uK6/VDgCKZrM91qYM
 mHU9JFZGL7E4BZjg8AyP/YMZvmyHzAoNZTF3WJB4lWryngwPugOve1sdKkQEBaFhhFw0GossknO
 qL0fCwnugv8I6T25KFATyAwOG1ZPgGYi/r1vzm51o/OCt+hSA7zGg0eOTpRVfsju5BD9/vDrUfp
 nxkETX4hwwpy47A9WX9pdrimv3N5M7MziQ1SMJuXk0UONJbBmxuWmfGxvj9DtcWNVFmUcbFj6HK
 JN/GIXpcJAsEOg945OUy3lb07QKtc/YaXdBo8zIPtw9N1XDc=
X-Received: by 2002:a17:90b:4d01:b0:37f:f8c5:93c2 with SMTP id
 98e67ed59e1d1-38e4b56d65cmr4691813a91.21.1784321350051; 
 Fri, 17 Jul 2026 13:49:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4d01:b0:37f:f8c5:93c2 with SMTP id
 98e67ed59e1d1-38e4b56d65cmr4691773a91.21.1784321349578; 
 Fri, 17 Jul 2026 13:49:09 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e4aff1545sm1701047a91.5.2026.07.17.13.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:09 -0700 (PDT)
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
Subject: [PATCH v6 13/16] drm/msm: Allow lazy VM creation to fail
Date: Fri, 17 Jul 2026 13:48:29 -0700
Message-ID: <20260717204841.26120-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX9F0wF3HKUn9T
 iI9Pc1TWbgE9AyFkHufpzeJH229V88Xh04d5LAhFArq3zsJkw2u6ec5aqcc0rwXYenkl0JyQ5Wi
 GmbrBhKqKM3F73sue/o5CFcFP8Dfdqy1KJ5iPfnn3uniCtnpi6eDGNnT092pI/KHd1QlNEWA9eD
 3adXmgAu5zpA1CXh+q7gl5951XjNkdL7p7Aewhuqme8w4bXqjCbgRYGn1hzhHkiClK8FmWXDanc
 beODPVW6cSJqxhz0H/WJLa3unsl4uPWeDPMw7F+WS2AobGcd9WVzKA8TiC32Sp3KBoD+zSKTqar
 VXOKGdyZzBpKoOS2in822NJ4zNWtq4ELFPtQpWIMEQ8yvupRfTjgduQQpWmME3AK5laZUuis1iY
 KVKjQcrJUuT6hWXDRZ3pPpcVIpmbAqFE/JzTg1KWZzkBp9ouoQJLIPFXnnS15H0DKKeX56wJ82Z
 C36MyOL9eFeLdvMCmtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXyk2sMR0Y0v64
 NuPpKw+xH3+jxUv0Nl/YgWv/Mb7S2rM5UK6bRB1DZJ1ySwoI5lamDgl3PH6moLLnxgg0pA/iYbF
 1q7GC2nFUHsF6o3oONyLGwZkk0UfQgg=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a9546 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=RFCq6YHzeVPHqihPuhoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: GBIQ3g6bIfm6rZQd1owY5ZWYyA1STloi
X-Proofpoint-ORIG-GUID: GBIQ3g6bIfm6rZQd1owY5ZWYyA1STloi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
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
index 040354ee16d1..6b0bee6c39bc 100644
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
@@ -552,6 +552,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_msm_gem_submit *args = data;
 	struct msm_context *ctx = file->driver_priv;
+	struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 	struct msm_gem_submit *submit = NULL;
 	struct msm_gpu *gpu = priv->gpu;
 	struct msm_gpu_submitqueue *queue;
@@ -567,10 +568,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
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
@@ -607,7 +611,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
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
index 233c4f35ab12..d307cdd17d90 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -174,6 +174,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu_submitqueue *queue;
 	enum drm_sched_priority sched_prio;
+	struct drm_gpuvm *vm = NULL;
 	unsigned ring_nr;
 	int ret;
 
@@ -186,6 +187,11 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
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
@@ -217,7 +223,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	queue->flags = flags;
 
 	if (flags & MSM_SUBMITQUEUE_VM_BIND) {
-		struct drm_gpu_scheduler *sched = &to_msm_vm(msm_context_vm(drm, ctx))->sched;
+		struct drm_gpu_scheduler *sched = &to_msm_vm(vm)->sched;
 
 		queue->entity = &queue->_vm_bind_entity[0];
 
-- 
2.55.0

