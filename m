Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995C6C5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B54F10E3CC;
	Sat, 22 Aug 2026 08:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUmNnTSc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOzXtpaS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67E410E3CF
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xc7E687576
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bl2pM3He0T4p4J5i6ZEzUZ8aa7IUKceqVLVcY5mk0cY=; b=DUmNnTSczxx+WgfA
 799htvWxk27NrQZPVcjK9Dyiwo6j4HmzXC9o8SXcWBk3VmhArjXKkomCYgudHin4
 BqEbrSM+67I/BnTgZpibUhLWsxhOtVVJPLch1yP5btKglKNXvw1vL6F+5vKq1Sjh
 +xRyYLqdm2vcBuelLmTttOdfgcef8rqbVSBWg2zEc1hIP9TCBaCt5JNG9kUQaJjD
 pO7Im+S5aDSnpKWBn65t1qykO91wAS/RYi19PLYtVPUn0hZlvbWQT/2voiOKqkD3
 SwBGO7g/B2XeoRCy89xwx1bBdJtLOKrB826fhiiqAjxmoEBoOFxQG5qFakyKnbG2
 RwakZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744a0p0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso23647691cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787388550; x=1787993350;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bl2pM3He0T4p4J5i6ZEzUZ8aa7IUKceqVLVcY5mk0cY=;
 b=gOzXtpaSGgorEeLU4eR706rsAh6W9Ee91lY7UXKvRNzGqLHHYMu+huY+JTuHuiArzP
 JHKL6uFEP1rqiMC+6h9tnYfOkoY0NzGQ15aVnADEQxr5OKcV4k439V4hiw5ZD6jBtZSo
 QK3uQYj38QTwX+AE77xC5va0sDPEI3RSgOStF+PcJ0n3dNPzZt26CQ72vkX+i7X19916
 jdWpqZas5cvUIsd+ANrd028+0XuaIo3YGlhDT0bsCvl8Af54c3bo7OgLX1W/RftugLdl
 3rsUihx6w79pKnR0rRiO7FuS3Z42i35mPHkB2lrpf7War0Bqjrl1xkjUyoRno5MLtANo
 01cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388550; x=1787993350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bl2pM3He0T4p4J5i6ZEzUZ8aa7IUKceqVLVcY5mk0cY=;
 b=oeM++2SeHCqncCmHL6knQ34V06oBrAiivJWHRq15P3qb8SIAaBE/o/oTYpyb1NxLjQ
 M8gvcdphz71tGo+xuqwQQc0TryaU8qtyeRRFYiQaJG96qUO2G3dEMN5bEIkoWFlQsj9g
 c9Yj4LZL3gNgHav3GMovYz9XHrxT/FfKnaBPyf9vMKAhJ7qkQQl4Os/q37HcwuILl2Rl
 cp9ObCqKmpC7dBfiYPCcvZYFGXQvSiTGgVJ+ph2LZW3RIYZzn2GsrkSmu06qNp1lFm/r
 e5if9GmK3HfaljpX0tfk6Ag/8ftyZieKcqPvyRxbtjpx+/Ye0Oic3qZBYJA823wDVUv1
 7UgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO/6yeW2nwkteMe37YL4P8SgCTkBAE6d6/r0v65anfidI5iresvUQz7JV4oP6ef5Dt6tsEXnYwvGQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mwZbxD5IRxDyGt1qEcaDpFnmb3ZMZl+0XuGs7DlfVNir3ys0V/
 kpXNzob07efUPw2HQ4JUrr7sKDFavR2jX9mjRpHSGZZ11lcDC6SBWQy+ZKvieJaxPRvF2FgkyTo
 IFKFXIH4eCwydLk1w2ekFmzmMmWPBVmxawXdOVN/fGR3hxKQly2Nxp9re1Q3hbQRnxdX5KEEGRY
 2vLl8O9B+9
X-Gm-Gg: AR+sD1300Xay0kaQaVz/hqqJbIkKffhlNjDqCZA7uDAtc0yb9oYkPV1q7DFcCHZ03gN
 qnIaz6AybmlVnBaUdECjR0sno+XpeseEXhX9D4SIohdvCrkvispNXsc67FtI9yO8FKkNBtYGFTR
 MZPsZxPv1UkHVbhiNkdsj4OdSs1ouX2BJehTxy4UhYpRWGEh/M0pmDFst/IqU7w3XWabYLYyflB
 kOTgXUiqrkxkz+jBqWuvRHqbXHYozOZJM6a1QFV68FqsKFLj7j0arHywsM+qd/stEPRwdE9seaM
 CLMNAyKL18C6vMPcsg5snB5rd+KRUph/4bUfI28bXyVb7BimzHV3sLegPHKBHETNICiCKpl9y5V
 f/+XBA8nOWyhYLFhYdQmDIunCbBZFHISV6KG/OUCZ/Pn6/O2oqk1CkApRb2/OZ/QfCyMjJzQ4Rs
 ojb0e6/iqv+IIP
X-Received: by 2002:a05:622a:5c10:b0:52d:7b88:dbdd with SMTP id
 d75a77b69052e-52df5a4848fmr114610871cf.31.1787388549931; 
 Sat, 22 Aug 2026 01:49:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5c10:b0:52d:7b88:dbdd with SMTP id
 d75a77b69052e-52df5a4848fmr114610601cf.31.1787388549498; 
 Sat, 22 Aug 2026 01:49:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2fab887sm3066901fa.25.2026.08.22.01.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:49:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 22 Aug 2026 11:48:59 +0300
Subject: [PATCH 2/2] drm/msm: don't tear down shared VM mappings on handle
 close
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-msm-fix-export-v1-2-917b3cbedd43@oss.qualcomm.com>
References: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
In-Reply-To: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3799;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=P5Qno/Uulwf66qJEUC3nIVjx7J4uBGKo5YpYlIjLfLQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqiWJ8JMZbmM2NJeiW7gb9/N1oR04En269Var3H
 t0RJ4DGh7+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaolifAAKCRCLPIo+Aiko
 1TCVB/9wD+Q8pkJ9h09RroItxPTaapbAI3USEKG2KRiBQisUfmy5zEYDQekJ4BxfpFVEEk0hgO+
 6jMWwXatR8tx78QK8N7PlTafRiND37lSuvlNE4Fk7G9KSeDO3FZJOmSYzv7rcLrwQONwQPCsurt
 Gy/+JAYUi1C+oKwuvN4I+KdA8CUmBbg+RStcplBPbtsgVqxYXXmZkKwng44DbXBswDPg4KVcDd6
 O+Fn0jPzvMpA6q7r1TV/RU1PcxqrYGEZag1wK88Wpy6DE+jPBYMNQfDkyzW7NrvfaLkWtBCqrIc
 4ZauqSCtoQVIybVq+AvoQVxQV9uiHkHYebS34CGOCijIcbbl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfXwT+0WzUqeDEV
 BJcD189pImZjRareAgZKX2BO60etPX9xqGzIhasxCQAOxvVawHcsW+hf2edl1BzUDeSt5daUkWY
 3e9Aj3p+Qv4oZE/EqxsI9YiTqllXp0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX6QlsFMDkF5Hq
 rSLh9PK8A4PTT/qTQhDevX/cQVzIf4wvioW3klpGtyKR9/WA3wmK/7empGBAGEQSZpizYCsWfjJ
 s+tWdNVQDG+G9RSigLKPT/+U3qEyIi/GOP8Nr/t9ucYV9iSQqth5L+BKhSjH22piy3ZDrq3k9wD
 JNXIirOlMN6hPAHJq2p9P9zB+W452H4Bj4IF6nuT2XM2oTy1XWgXYHZqzbhF8SaXGDY3ZMPFmAI
 MJHGRILAiq8940duOlXpjlRIfhJ4/ncCugN+3LO2z4XN5zg0Wplvzr6gnyEx+SFSSUobPgim1Zr
 RrVETkntToXiiGwdPIXmiOzycp9UvloqIyrU/Ubg2LyHStDc91FlYBixGYsDtN3GeL5HgTEusVE
 3lakTeeH1WuSwTtWcHd/0zkuNjTmkBvQP26sBDOFVC+AmhIjUEVhap6L+wsa9mVZ+DbotinXHPa
 mfcXwiCphQ7UBuw90Qw==
X-Authority-Analysis: v=2.4 cv=JPILdcKb c=1 sm=1 tr=0 ts=6a896286 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=cz9NNj-IL8ditOTxCAAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: g5NtC_2ZbJlScqlUlridWGU5dXZCb_no
X-Proofpoint-ORIG-GUID: g5NtC_2ZbJlScqlUlridWGU5dXZCb_no
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220070
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

On targets (like A530 / MSM8996) without per-process pgtables
msm_gpu_create_private_vm() uses the global VM, so all DRM files share
one GPU address space.  msm_gem_close() unmaps the object from ctx->vm,
which on those targets pulls the buffer out from under every other file
that still has it open, and frees the iova for immediate reuse.

A dma-buf imported into a second file hits this as soon as the exporter
closes its handle: the importer's texture keeps sampling the old
address, which the next allocation has taken over.  On a530 this is
every ext_image_dma_buf_import sampling test, reading back all zeros.

The VMA teardown a shared VM needs is the one already used for kms->vm
-- defer it to the @vma_ref drop, when the last handle and dma_buf
reference are gone.  That restores the pre-drm_gpuvm lifetime without
reintroducing the reference loop, since a BO with a live vma_ref is held
by userspace anyway.

Fixes: 111fdd2198e6 ("drm/msm: drm_gpuvm conversion")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 13 ++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.c |  4 +++-
 drivers/gpu/drm/msm/msm_gpu.h |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index f90afffe3442..e73cf49c360e 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -63,6 +63,7 @@ static void put_iova_spaces(struct drm_gem_object *obj, struct drm_gpuvm *vm,
 
 static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 {
+	struct msm_drm_private *priv = obj->dev->dev_private;
 	struct msm_context *ctx = file->driver_priv;
 
 	update_ctx_mem(file, -obj->size);
@@ -84,6 +85,10 @@ static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 	if (msm_context_is_vmbind(ctx))
 		return;
 
+	/* A global VM's VMAs are torn down by the @vma_ref drop above */
+	if (priv->gpu && ctx->vm == priv->gpu->vm)
+		return;
+
 	/*
 	 * TODO we might need to kick this to a queue to avoid blocking
 	 * in CLOSE ioctl
@@ -95,7 +100,7 @@ static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
 }
 
 /*
- * Get/put for kms->vm VMA
+ * Get/put for VMAs in VMs shared between contexts: kms->vm, gpu->vm
  */
 
 void msm_gem_vma_get(struct drm_gem_object *obj)
@@ -110,6 +115,12 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
 	if (atomic_dec_return(&to_msm_bo(obj)->vma_ref))
 		return;
 
+	if (priv->gpu && priv->gpu->vm_shared) {
+		dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false,
+				      MAX_SCHEDULE_TIMEOUT);
+		put_iova_spaces(obj, priv->gpu->vm, true, "vma_put");
+	}
+
 	if (!priv->kms)
 		return;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636251..31d84e2b123a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -879,8 +879,10 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
 			to_msm_vm(vm)->pid = get_pid(task_pid(task));
 	}
 
-	if (IS_ERR_OR_NULL(vm) && kernel_managed)
+	if (IS_ERR_OR_NULL(vm) && kernel_managed) {
 		vm = drm_gpuvm_get(gpu->vm);
+		gpu->vm_shared = true;
+	}
 
 	return vm;
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..7722776e9129 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -223,6 +223,9 @@ struct msm_gpu {
 
 	struct drm_gpuvm *vm;
 
+	/** @vm_shared: Has @vm been handed out as a context VM? */
+	bool vm_shared;
+
 	/* Power Control: */
 	struct regulator *gpu_reg, *gpu_cx;
 	struct clk_bulk_data *grp_clks;

-- 
2.47.3

