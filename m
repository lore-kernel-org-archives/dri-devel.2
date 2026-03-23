Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5746F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B1210E412;
	Mon, 23 Mar 2026 20:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Of4Rq/g0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gH+edQpd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06D210E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXDv3634280
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9gnUn4vlm4hYrJYBjxx32v/u7fbwTJqrSqNxW05+/Zk=; b=Of4Rq/g0bVYsAXN4
 7FyNacw+Ksh0aBGZFUtPhXJPVvFJa9IT7+MO0154eM+3SQxlZHO7TtpwUXAjEhZ1
 gC+7w9P1VGZTTMbnEHNagPc7rS4xSVSeVg7/MOorRE+17EM6BUnfUQhy7DIu8pir
 MCD3gB4HXOy49CvwSD4zugOLd8hPJVNlNdWHLj16qQdL5qfngvBAe9wNV1VLHQUO
 SegZETfwgnJVDg+98fb2/Lt+sxmZJZ+CxxJ2fEMoSzkPV3ME3q9LrQOxKfBUm1Fu
 5/i9U0oUivGqUfDV4B2FzgtqQmKMpJrjYfEnTFZau3E/FZuGHtfhGgKD8qP1E9wH
 1u1/mA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4hwhk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a1436347eso316134b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296787; x=1774901587;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9gnUn4vlm4hYrJYBjxx32v/u7fbwTJqrSqNxW05+/Zk=;
 b=gH+edQpdYx42e6pDR7TVqOQC0NgEllBDtCPJ6kzf3X/73zhpjmTGfv8zYRVh4r9mCH
 pX0lVGBhSxkkrWChSNA4ucPHuQ1SWLN3WOmEuskqnSir4h7RmK2IwNwGhmcfDnk06XLS
 FfyuhXMo/8bzjpjHBGT+mbXNhG8eC44WoXRJqDgTwM/eMhACmA8lODQCkD8lBrlTquxG
 mmk8ZSIGUGv5WHajvCml4hgkfFfxxNny/eZnVQaEv6yWavof1sOtG/1pyg+2mlrLJJnO
 GaMKsXiDFnrnFr2n28Yy2d7IfEBfSe3F2SitYJ82gMM2TOw/VdUGYsqeE6HWePiOk3+S
 OlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296787; x=1774901587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9gnUn4vlm4hYrJYBjxx32v/u7fbwTJqrSqNxW05+/Zk=;
 b=fHvtrL93D1ZSnz78zEr2yh++yA3AaUbcJrxtB9DeBypcLZ7GgX3wUsUKKoaXme6A4E
 9awuFKyWFIyGvALGv4UY4Gbprnx7x3nGDkUR49v3Ox4SwxFFlZTAdZULW92HG5l2d90l
 Wz5YSsjWCYVu0SbLAZ1H/XJYUgJp4N8RCvc8cJWMztviyx1pKRW4613ROn4gd+5JCpmm
 qIuF6k1BgsHIEZ3N2bY+ZWm4u6jplp7TY2ek01XMt4jL4m88gw22w8m+N+ypM2G35Hy3
 SnifkswZIdm4Xd4u7rS+5ARJWAGFdbQpQEthzNDEtpZRgL/ewHTB5yB1aarRgNvzh6Ss
 DPLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpBNmF/htf/946qGAdw/LfVB8aUEE6AQz8L3ouJgx247w4V7ajMzstZAkGNSQ8h0iAHbZOqbR71og=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+2hX7lzjhUnGk/y1FjlZqiGuuRkeBu6RYG70MHGVfW1YgpUHs
 zkbfppMZ8E7TEaeDBpMlnzNpixzgDdr2++eoyLzjgaukSzymTf9RjmgUqJQvohZfU9vcKgalBHM
 MbgYNSncFs1vMS8OCQsx9lh2iq+1cCYz+aEgjwgxoPtXrQvVjr6ysK0Zu3Y1mkzGPMD71pnqwrs
 8WoIo=
X-Gm-Gg: ATEYQzyGW8ebs81wnhHZSilQUCywwhQXTd7GxH/MTZRwm0uWixHIGhIsPovNFWGOjap
 aOB01BG6nXpbtRF7LNVo9ftAnepXvrAfVL4nIQ0S4z5AcbPdtPd+dXlA2ma9pvdNMTLeo9D7sbJ
 eztuGmwkPJbZPJKIzU+7mvMnFiNet/27jKsH913ZP8eNWWNONeYYBc7E/iEsSZM72QCWgJicqko
 qaLS7g56kktMcTy6JkF/OOSI9abNVI0T166CniQAZB5f+/0klc/bIvbGN7LZTaqgj3K2HGf5z0I
 iDwg4t15SQvhDAOidYNtrE9rmwVlRsjVe7fe6mRCWyITOUzXW4QlW1BKy9/xzgJQpIXHZh52+hV
 Fne5+NlMT+4sEZWuCEoehQGz6g0owVZMlcpsfRuQSXxNy2g==
X-Received: by 2002:a05:6a00:13a6:b0:81e:4476:f67c with SMTP id
 d2e1a72fcca58-82a8c22de4dmr11789574b3a.3.1774296787424; 
 Mon, 23 Mar 2026 13:13:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a6:b0:81e:4476:f67c with SMTP id
 d2e1a72fcca58-82a8c22de4dmr11789558b3a.3.1774296786933; 
 Mon, 23 Mar 2026 13:13:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:06 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:17 +0530
Subject: [PATCH 05/16] drm/msm/adreno: Coredump on GPU/GMU init failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-5-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=4487;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Y47hfhEP77VPPLQuO6M98YMW2oPSMLiiSh5WGqdD588=;
 b=uNx5nipFybpSsxCpeoPj8dQ+2Szp58MCMSQh230ApmII8VwqLiThw0TG2UiEPDhMGLF4u6Hsv
 Cnqrk16U9iaCYLw/aJmPZTNSksnZB5JVRYhyIW0xPFVKxUOlY62uvYC
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: UhxHaborlKYWFKuQKy-Dek7ptWQV_Oyu
X-Proofpoint-ORIG-GUID: UhxHaborlKYWFKuQKy-Dek7ptWQV_Oyu
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c19ed4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Uv9L2OBOgJoomgqfufwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX4gSS+phL5z0i
 edj5ZBZm2dVVFqC9l4qyzFv+sv9W18FOk6ZMaMXYgLULW/Te76Lws3U9VkXqa7aFkaZnoHvo2vx
 /GsQ/vztbj40gEmGH80RSFlP8rSiZRxVXT6TXR4r/sCrz7LRxzycASVr9i/6WCJrfjsk+zugK+L
 aZsA+qfqC3x3WqlAhjW8nOH+ehNaEJiySHkyrPKksD69NwKjmceeTJQxacwKvkVXN60vSdZ5QRq
 OaBjyvH6bJfEzyS3H/kGXAR2TYKQm6AhpWqMeRt0nvSoC/g3+FSvUdPX15X/GJ3QZOkUQn6Nlr/
 O7qqTPsXSXFJgph5/lry63opLnMPclTtNDvE3RNQPuhQ5KvijH2DgInXKRDVvMjIi6X930dXI2I
 OQi1KLP6BV4WAWRw/UJe6iV2eyEFzN0sh6msbwCIUeCsBfQzUtiNZF8XjCdqDEahNPiU63TKffW
 +qd/ugzlkUHbGyUQPyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

Capture coredump on GPU or GMU errors during initialization to help in
debugging the issues. To be consistent with the locks while calling
msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
msm_gpu->lock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
 drivers/gpu/drm/msm/adreno/adreno_device.c | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 2 ++
 drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
 drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 690d3e53e273..6d511dc54e43 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1240,6 +1240,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* On failure, shut down the GMU to leave it in a good state */
 	if (ret) {
 		disable_irq(gmu->gmu_irq);
+		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 		a6xx_rpmh_stop(gmu);
 		pm_runtime_put(gmu->gxpd);
 		pm_runtime_put(gmu->dev);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 4edfe80c5be7..85b3e1f0e4fa 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -105,6 +105,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
+	mutex_lock(&gpu->lock);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&pdev->dev);
@@ -112,15 +113,15 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 		goto err_disable_rpm;
 	}
 
-	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
-	mutex_unlock(&gpu->lock);
 	if (ret) {
+		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
 		goto err_put_rpm;
 	}
 
 	pm_runtime_put_autosuspend(&pdev->dev);
+	mutex_unlock(&gpu->lock);
 
 #ifdef CONFIG_DEBUG_FS
 	if (gpu->funcs->debugfs_init) {
@@ -136,6 +137,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 
+	mutex_unlock(&gpu->lock);
+
 	return NULL;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1bc0e570bd12..10d9e5f40640 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -391,9 +391,11 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	case MSM_PARAM_TIMESTAMP:
 		if (adreno_gpu->funcs->get_timestamp) {
+			mutex_lock(&gpu->lock);
 			pm_runtime_get_sync(&gpu->pdev->dev);
 			*value = (uint64_t) adreno_gpu->funcs->get_timestamp(gpu);
 			pm_runtime_put_autosuspend(&gpu->pdev->dev);
+			mutex_unlock(&gpu->lock);
 
 			return 0;
 		}
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 995549d0bbbc..472db2c916f9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -361,7 +361,7 @@ static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_v
 	mutex_unlock(&vm->mmu_lock);
 }
 
-static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
+void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		struct msm_gem_submit *submit, struct msm_gpu_fault_info *fault_info,
 		char *comm, char *cmd)
 {
@@ -886,7 +886,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
-	msm_gpu_hw_init(gpu);
+	if (msm_gpu_hw_init(gpu))
+		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 
 	submit->seqno = submit->hw_fence->seqno;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 666cf499b7ec..eb5b3a7b81f9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -747,6 +747,8 @@ static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 }
 
 void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info);
+void msm_gpu_crashstate_capture(struct msm_gpu *gpu, struct msm_gem_submit *submit,
+		struct msm_gpu_fault_info *fault_info, char *comm, char *cmd);
 
 /*
  * Simple macro to semi-cleanly add the MAP_PRIV flag for targets that can

-- 
2.51.0

