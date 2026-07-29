Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BC5C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD86110ECBC;
	Wed, 29 Jul 2026 15:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNX0Y78S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NuNSc1qT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C31310ECC7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3HaI1700613
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S9p22RaEXCQ
 i7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=; b=oNX0Y78S3vpsRifE3ETY+5Dkfry
 ljCM0hvy6uOGhcGI7l1/+KW/AeGP4H0zKCPmYUu66efloo5/U2FHhjMIhLMcPvxO
 Gb2jKo+hzeUmqi2SWt+n0NyJqTYTg9yp4yq6QZzkFhXOEoxB0txUmQDyb610d+kq
 0P49SmtySp5z5I9w2AwJkXy42ur0886LcSieesbhbpM2YoZ+4jZ7+TB3ugMefXKu
 PqOKO1jUtnwSmnP52xBLXlvyLTlYGoKjBWkHlvZ3RTIhgB4Mdu3RvgmFOLUKTDm+
 qA96o44Ja+ltIH9ic515tmp1ECuUuLNyo/g2Cux/1GJoF3gsoprwgt36g0Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj19tb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfca8558d2so15170595ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340635; x=1785945435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9p22RaEXCQi7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=;
 b=NuNSc1qTI1di01OjaXsiD3rQWV+BLB0jOuVkI0Tp2WxBiTFhBvTlTDIWch1LgSF44S
 jhfTUgmxHuu2YJ4zA7KNmVbmxqbWx3wa+DbV2bVRSlH/cM2oGEA5Vy4XbAJsZFPOxD/r
 +XCmX2mGYYu4VrJRJQNIdOmzWLtUjXVD1+LbcAYb+e1hCarXl6sBe9I/SElE/nPOOSLO
 Za7CDwjTCUu3ya+AtRal9fU8UaTXQf8FPXj3i46Sabw+w5MLBwFtmqQ8zGxhBhzgBDGM
 3S4VMxBJAypP92LLt3cQ2VBhrfEL8ZJpTcWu1FW3AVjPCEDHUxMvwpAxPAW4mI8AmlK9
 oisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340635; x=1785945435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9p22RaEXCQi7TxgfihtQyZ/x+xxl4vghHU97Q3yNyc=;
 b=mtgRRM+DUV8LKRK4Sjk584GM6WcaQuZiCfd7nMfZPc+HVAIRo//jyRZuQblDXvbmVm
 QRiUOKQyHHCg9WU5rf+AmbBP/Xba0Sakr6c/CirzNM+E/s7fHYEj+IQYqqxVbP16r0+Y
 r5TI5JEM2zUoNeBVifNYAAFgekNi8xQOdMNQ5ZGQuNIEXTd4oRMU4ExB+ETsgT4lVU0y
 B4WPiySj96pKZNfyL49yWgrjFJC0yjtG6yfT3zJfmsu7Z4u/RUt3FtIt24J3kmL3bHLK
 7e9zeBca0X404FK4wnOAT42dk6PCYIUgFjo4w0vWvxvpVW5DYjHNiQhrY8r9hif5BvKh
 as/w==
X-Gm-Message-State: AOJu0Yxuo/Qp9H+iwjq5ipGbSbszUneK8KVU2zqPepfMLtOG2EDd8qHm
 l2gbXheMnzRxqwaBFKDI2H5g/CwQRNRhmtENIssftVsYGywHy+p3hzNEVLpbZo3MBmMuPOEMcpQ
 J+ACcgFsaVoBc6kRiZrnkIxsgfzRZrFMd2hCFTm3WHt7ZtqEmFYhWKCUltdTc1bzBBhE/lnbQC1
 +xBJ4=
X-Gm-Gg: AR+sD10hWHHML+WehAJkAmJ8uCOfLfto9BzqcIZytni7apxThIhtmxP9v94Z4IZew6a
 0DW2nWh634JOiL3DBp9NNGnOqX06rsEUWS7zPyX9Lbe29U3HuhwzlrrlBEabiq+TT0gt+Dv2olr
 UZYoKNdeGqnNSO0lcoXdRnfP2ofu7zeCxYero3Dutf3KFgPnce8WuXwkrhsdJv/vS6w+OG6S3Yq
 UXLB/fLnVWLk5zNr7ncFcYyEBzIxq14fq0lz0JNh+1PJWPCk8X1suWfYeR3JXacyXUh1fmSDuBa
 /Hc7eVcGjk7E8zfig+Sr159ETJ7y33U+PUcWNe0knlABGlR0ETLO32OocgvfrV+/A7zeMH7UN2H
 d7RVLqXbYAz82boyvCzCRDHeYE1ZTjGATAH4qcwGWpxYNJRU=
X-Received: by 2002:a17:903:948:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d015abe469mr84921345ad.7.1785340634748; 
 Wed, 29 Jul 2026 08:57:14 -0700 (PDT)
X-Received: by 2002:a17:903:948:b0:2cf:ca89:499d with SMTP id
 d9443c01a7336-2d015abe469mr84920965ad.7.1785340634272; 
 Wed, 29 Jul 2026 08:57:14 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf5fcfsm13568195ad.62.2026.07.29.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:13 -0700 (PDT)
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
Subject: [PATCH v7 14/17] drm/msm: Allow lazy VM creation to fail
Date: Wed, 29 Jul 2026 08:55:51 -0700
Message-ID: <20260729155609.20190-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a22db cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=RFCq6YHzeVPHqihPuhoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Klk5cWoO1WCXhdSMXaLUlqyGuoKq_5iL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX27Tl/Qox8QmO
 L7pi/D5GajztWL62KaTbS7ZyBWviBl5c4QIfqGTyVDEbAYrd37JKQeCdC4OQb71dzJNgVheKJ4U
 /ZZx4DD6wXjHkIaFE4aMIdp3bYdMJmQKlJ5c8s/KeN5dhfOI+QswKdLylTL2jE4gEotjGwhD9l0
 g83lZTIZrPNB89cc+tKzhNr5zoalZOJHw35DTerKnoHYYoJOTHGzFyF+98v9McHMYyAoxE1Waqg
 TftGJc9Wswf0wG3ixhrZxqvWZqznNLMTvi9ASS2nyMmmf1Ymw3mS5A0beam9TgDKe46lAKxgPTn
 LAXab+qnVrc1p0mGeDV0uU63pFZNYI50r8yhorBF8f4/woSdmXk9KK3nkJmLZ2j+xtI59w2HSac
 Yf6YrwDkW4npL5fLw2Yql9CgVbh/fWBU3JycPO6qiRPYi9Tm/wN6+vR82HP3o1RqtoU79EO5/dk
 MujyFHO9RgbMhVh54Qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX9oUoS6COVJvU
 ilUYxPWLty0TGGfZ50OLN3kDIp6mlg64nI68Qnf4OJiWCkFKjex5o0LzWb8J2wygCo/MRd+5pV4
 OZTDJojksbVY2FA1uFhzXvLXpD8X5Rw=
X-Proofpoint-GUID: Klk5cWoO1WCXhdSMXaLUlqyGuoKq_5iL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

