Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C79C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B7A10F1DF;
	Wed,  8 Jul 2026 17:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S6xaUCnT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXZ0FFk2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B1710E4B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLKMl3387179
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vOFiS3gWQCJ
 aLhFgxBelkuMdy2oPlvu9rT+AQ3nGeTg=; b=S6xaUCnTQnFBBaVo/g2/kFoTUia
 +Wdp8+ZznsOU9ZoACXIvPFMZlSbGyVVAmeeEzEL42RKkxSqR4cNE3MrqUGZvVUku
 B/TS1/UIQ51DIWbkwbTqzNe4VqoUUo3Xj/Ksj1DFDw3t+PMAGb2qN35T/2GOqCII
 UxTfZvDvQnWqKnpID33AmWJHqoWo9P106iqWFnfW4gAR89Pu65Z69SRxLDQjOQGq
 CWCQ28OF6bLaxBy2T+eRgo9SVJ4UOD2DuTl80i4WgqCae+d8CjEJ8SRsLFBPi+Nk
 Ys/62emyyIfvmT5/K94JC89aRAnv6u6YcNTfj42R0rcw5EFlqaZeTZ46FkA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswbswr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8423f1fe39eso1760765b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532074; x=1784136874;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vOFiS3gWQCJaLhFgxBelkuMdy2oPlvu9rT+AQ3nGeTg=;
 b=XXZ0FFk2MZcBGBDXMepp2TlktFYO0shSJi6nie8ZbRfKXRI+K1moSmJ3xuS3Pzlx5N
 DaF+1LalU6n3LUp8O4gQotkEuVd3MaO8Ow+RQUM/nF8RVRlEoXB35DU4bKuh8AaqycDE
 gj9oRoloFkR+jl8hFCYTyQnY90U4T8+ZL0AoR1DuU/nmcSWULS+QUSh8Dmk0eU2udPhF
 i3o/JSEuQHbOc2brNdYPg/lHMNC6aAVb5zLCi8uj9enU7bToYRSiFDzuVrZrcQL4+N1h
 RNLI8g+TuyAj+T2UP767EjDQOed/JFJ1YNJw1SV1VO076ARSHIREerz4Xe666fxS+XnX
 /GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532074; x=1784136874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vOFiS3gWQCJaLhFgxBelkuMdy2oPlvu9rT+AQ3nGeTg=;
 b=VpAMlmhWVdP30ND7Q9i9DF4uM/VrxB1F/CwRUZfXUPSj2mNBCDJvhNzWIBNFFJNyhV
 E147kS3Hj5ESeehHGIbZmYRBYLB1q6HGyRm3l+ancvReRYgbnxThLRkMxPPf/arS1bwF
 8y2nzpvLZLwGg2ZBCY8uayDR1xjKuUYGQBzW5KN2saOlLXleDF6QGPFtVVMaivpvP0zA
 M0Ikqem9Q/0e8CweGCiBZwjNQlkl20Cxbm1VP5sDlkTmWqgfj0/OhA+R5mEzdj2KtAG+
 KUdJ4zcP4LsX48G8CjGVXQOvSvHewK03nWr49yGyE8ZsUm/hvGSRzuTTv8M0BIO632R0
 ct0g==
X-Gm-Message-State: AOJu0YxIwQeyVYMcTLjigZuXQICS90Sfq2JVI1xGl/KCxYSOD4qEKLCF
 qcHL2hSWbl2zvQOdkTpr2XwPbykU8l1iZI5e3keAOyYAr4Yw1qVHqp1ZTim39O3okF90F2Hr8iV
 sU3SITQ65U0PhFzMJkdc2zR8dj8ATPljKYiMfsnXy5aQ/O4sY6V/rxPvahl4BkEjgtW8iaUReC1
 kWvQE=
X-Gm-Gg: AfdE7clQdfjMK+pu/rrMzNBVKMosMedZGGey7mW8petjjyjoS8eZr+c1d/JbPP0aVdr
 ca7jbm0MBrFc4en/fKTO08T5MHyHfcFhUcj/+DUvrtGY5w7rFLmMqLxVRT+st9HRK7tbHwpZURR
 +tbKuN+lbx9pjQCJeZ83pitW4bwTr/V7PYNW8lUv5tRvIFQL0J/1dq+KhQ/WteDs2qGdXFcFC5l
 5CGFCfBTdTHbKivMHfhjnVS7Ug0a3MkUnB7uJaIf5UhYAuBfTDgZFcE1W8fXsNxiyWCm7aE94dK
 sd2TuOyOqryTAzEAbjEqMjBxqFtVqpqiyLLH30S8PWx8Z5AbR5zj4vRU7ulbHK5m/99C0ZjCTh3
 fW70W26bRPf0XQhHDFbCIjC07q5123o9410lM9vG8fBPreQkCzrZQsmESzQ==
X-Received: by 2002:a05:6a00:17a0:b0:848:55d3:c890 with SMTP id
 d2e1a72fcca58-84855d3c8cfmr187833b3a.30.1783532074384; 
 Wed, 08 Jul 2026 10:34:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a0:b0:848:55d3:c890 with SMTP id
 d2e1a72fcca58-84855d3c8cfmr187797b3a.30.1783532073913; 
 Wed, 08 Jul 2026 10:34:33 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-848414a34f7sm1423977b3a.44.2026.07.08.10.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:33 -0700 (PDT)
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
Subject: [PATCH v4 2/6] drm/msm: Block VM_BIND for shared VMs
Date: Wed,  8 Jul 2026 10:33:50 -0700
Message-ID: <20260708173356.578713-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5Om05aesXW7CW5ZLoW4uaoKIwaB2U1co
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX5DR0nA+XpQ9j
 Qx4Ag5Bma5TGi1SrJMx12G0lgsO+d72r+ryHNvIrJ7kAzCPbikx1Q+VQYcC3loyA3Imr+8yFdXz
 qGD8gw6PV4M/R7xv9VxusrFfy/gJyRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX1X5zQbS59Lag
 T8cLx7+r1yIGWs3YBIjYBxGi/usLCJDMHnDq5h0EJQGeXA+ilTfgPurixww0+n5UuZKt9jhcSIW
 bn7mJigITtUBV6hYfNCSFelkxN4cjC6xABGAkdYQN0EJkUxPau8nCqUBE98/2VpFo5ykwhCs9do
 VnT8G8ukrOaIZR7AqwatNkr3Tzc2feUIRjdnWEt+/Nti3gXikzwchhwIdza29lXdhlCX6+HxEZy
 usPbjilmewumM31bkRhArmXkjKf3ITZkboqHoJVAU+aaoLaUCwWtXyhsfOJfRDVgA864qFtVkCC
 SW6BD3t7aw74P9Wpp6fw0HdemR/xxVfU+GBgo+yN4bmxDQh2UuBprRylkljQNjCC/sHyunTZCTJ
 yz+X873/DCK9huIG2KPt2XeD1Yko8LQD2+fIbjsu+bldaIY2Te9bZIwXPK0I07YGHZo+KkPUdrB
 eg+Mwqa+Mp9AWrtZFHA==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e8a2b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=GoQzj6LmqzT0DKjVJ_UA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 5Om05aesXW7CW5ZLoW4uaoKIwaB2U1co
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080172
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

We already block MSM_PARAM_EN_VM_BIND where per-process VMs are not
supported.  But in error paths when we actually try to create the VM
(allocation failures, etc) we could still end up with a shared-VM.

Since we need to create the VM lazily, for backwards compat, there
isn't really a better place to return an error.  But this isn't to
happen in practice.  Just block VM_BIND ioctls in this case so we
aren't giving userspace a way to manage the shared VM.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 3ed05ab0eeef..06a3f2aa3ef0 100644
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
@@ -1448,7 +1449,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	 * Maybe we could allow just UNMAP ops?  OTOH userspace should just
 	 * immediately close the device file and all will be torn down.
 	 */
-	if (to_msm_vm(msm_context_vm(dev, ctx))->unusable)
+	if (to_msm_vm(vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/*
@@ -1456,7 +1457,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	 * place, if you haven't opted in to VM_BIND context.  But it is
 	 * cleaner / less confusing, to check this case directly.
 	 */
-	if (!msm_context_is_vmbind(ctx))
+	if (to_msm_vm(vm)->managed)
 		return UERR(EINVAL, dev, "context does not support vmbind");
 
 	if (args->flags & ~MSM_VM_BIND_FLAGS)
@@ -1479,7 +1480,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 		}
 	}
 
-	job = vm_bind_job_create(dev, file, queue, args->nr_ops);
+	job = vm_bind_job_create(dev, file, vm, queue, args->nr_ops);
 	if (IS_ERR(job)) {
 		ret = PTR_ERR(job);
 		goto out_post_unlock;
-- 
2.55.0

