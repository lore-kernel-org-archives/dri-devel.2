Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0294F10AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6480010EC37;
	Fri, 27 Mar 2026 00:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S0UK5GHl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PWiX4Ln8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB0410EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QKYb0j519428
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JyJXWO4lhEbma/Pghwnm6vVrCQrIya2bkF7i5BoSU2o=; b=S0UK5GHl9NZxZySL
 ty2O6UilqLWQmuxjH9MFtXqQGpcawIWkHbW4pyvE0MAa8TUkkeoUWTkrfFe+6SSG
 v5mOy7K3I56qnIHIdUyWaNCK4JrKOJ5daD2gFDBrP3Y2CNxe5HkjKg+fvzrRjYh2
 S2JBShiy1SNFc9RLn1UiywQZzg6cTqqW+FFnI9AQHjs9nw3qvSTWUzG2ClW0aWsB
 /O1v44a8X7uSYh01qEckEj+JrZOoGRO4w7kkvIbnN4qSCr8r/mRKoct6lgUznNKP
 im4tXvZrluvtH+mL5kvg64vsPpAjzQQWX/LylmVuikAVjK9GPFVNp43GtQ4yH3By
 to6o+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv0h81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354bc535546so1716918a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570572; x=1775175372;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JyJXWO4lhEbma/Pghwnm6vVrCQrIya2bkF7i5BoSU2o=;
 b=PWiX4Ln8Vcz/0cZudkqfAErG1knpg+Xvbx+5kxrrvlLHcMX+77Srv/ZdmDHRPi+2gt
 R0T1NZ+qH13YVTdcGSJ4lzGCHM84vvXnhIEfydkq/AB2GOj+JbS9XTCnD7VjxNi8Ev6U
 gU1TieOYoB9/TF1zAq0b+TTYlbQtMWs9MBhLJJaK+2SiUQvqXvuZyZSj7JwDYflvlA5u
 0825BMQt/mNSl6OHqs0+Z617aUBs0G4Ejl+ejddFU9XKwQdHgqgmyuz/QZkWVPOzMpyD
 XmEstRTMV/JcqYQJ0B0moK7yCG3cphAO4IkFNukpTI3hKsr2LJubrkGJYDpAZS/vhQ3U
 OpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570572; x=1775175372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JyJXWO4lhEbma/Pghwnm6vVrCQrIya2bkF7i5BoSU2o=;
 b=hFq43URcQltfmf4J/w7WF+/PeHgGR3y9NGP9eHvKqcM14lZgsVl4T5n3xya1mbm1A+
 cDp5RjddgF6x6ot8X17hYji9fC5FYg5yGdZN7oMRnnFVlkFVbDlSr9zz/XwGG3cSIxZb
 u/nv4pnQoXTbduKwVFTw9o8A5+tPvLUutsz6N5P1OhEdYqNKKi301bo6jnIv9ryxLab8
 s4BW9Acis4npNAsBto9Djrd+75rs0YE4i+0CK08jAC27eZSlcHRmiGh/u2D2NlXgpPAQ
 /yThOHUN47EuoRNr/jkuCrjjBb+7kJL5YehysvNyGw6HeUo7daJe/jFAzjNe4lr3OQ3X
 Bidg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCQZ8+wdeeYnB2FzgDXhnDdYe5zgKEDTiLEVAFRq+hYveatShTpR6rnMexgE/XkiOmZQl9NWalh8U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxr2nEzp23xYOAazTxBe8DW88tU7uzacK7TPKspi01FGGMq9SfP
 mqhQPqoX8H9LZfFpWJc/OqeyicGFhGnxkDeDLENkXP+gn1u+9DTCfHOTqqya3GNHGpBYinFsTI3
 GWY2ef4yA12bdlT0SEVafCRkIOCA/vmo3o4Vo70blAE6gtaO6RRKLo3kiPGiljEWl8gXYjuU=
X-Gm-Gg: ATEYQzxtF00WEHVXaDLw7gdSW+wYpX2tInfjxqWZ13WFcKFSj4e0+fAAjc2PaCfFLcH
 m8sWm+PNcYytfbBEHAKfdzOjJ5x6lD5I0t6p3ZNq73vhVHSp8oYrGswbZWmUpOTlTRp7VJnEgOj
 a/05XpkomgN40lQQGCCb/RGsrQr0Yj5nXA681XJgxmizgbfWEM3PVxXw4mgWIlSYVdNz59AXMMN
 rITJbgM2ZEfY0vV8PV1WI1isakPJejLTurmw8RCTXgjVGT1bbUdcZEc+Q5H07lXl1hulEU/SMit
 GZavZz03K3vT/Ijowr1ysM3C1oYRef8CmmSX9qgDeily1U+OHw3TSR+yq9NuRp+YJZypqG69O3f
 HKBuc4ieNnqVwx+OAKBMRp9Flegta3kFeTBlQR5RxIQ19bQ==
X-Received: by 2002:a17:90b:518e:b0:359:ff8a:ee55 with SMTP id
 98e67ed59e1d1-35c30031e44mr436087a91.14.1774570572083; 
 Thu, 26 Mar 2026 17:16:12 -0700 (PDT)
X-Received: by 2002:a17:90b:518e:b0:359:ff8a:ee55 with SMTP id
 98e67ed59e1d1-35c30031e44mr436055a91.14.1774570571533; 
 Thu, 26 Mar 2026 17:16:11 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:16:11 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:44:06 +0530
Subject: [PATCH v2 17/17] drm/msm/adreno: Expose a PARAM to check AQE support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-17-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3635;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NUuL6+oGaUpA7JxKBFdWblIueRfnWDhrWCx2k8TSQ1M=;
 b=gL86vG67Eo3KyDePP+ZoaqPuM8GFv2ybDnVVj4+uARpKwCegOJplUrSt6DKebEt4N6vN7Y5xQ
 5r/xxz8yOCCAW+32Da5RfazHjIwUJ7p0gTdvRMuuo8rcKQzIXfecxaL
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c5cc4c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VDML5bnlI8VuwgTyKRQA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: r9rIpS4hVE26m5jDLNyU2YR3cjA_lRSp
X-Proofpoint-GUID: r9rIpS4hVE26m5jDLNyU2YR3cjA_lRSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXxUo2At8r/EYl
 TSpzuiZkNHRxuHMwz/1XMv3fa/Mh5RvWLrGZlDfLsQFGTGdlt4mtjTrwBKsjFeZJFuwEwEI4ak7
 GmZnQthXOkpOVwMn9Q6KFQSl/gGrCULrn1jOFO6BjVzhqRl9PjVjL269kL8dXU8geFpvfYC0Na2
 cTeS0GA/vZsSJcOiI8LgwqC21W0Hwm/6W506i9vDHqDomX1UVBoCMir9i8+YlFbD4FFPzlFq3n3
 mWupf+HTwNIFGxevELv7gjUVmvjTyRtMG5D4AuoQ7ksWf8hqEcIgp34ehWFj334fBJpQ79sdfAU
 TnUJCN4URy0lcwFh9hl4qtgxb0GHlm4kWfPIVhBvIITkO5oySAGQs80Gcpv2niooQ0qSLLowzbl
 YAh7+wp1flBj8zZIcTjkqeHgQS3OhHwBCgoKhhFq3EAa8dPa7R76sUORs0cR8qB9ScEctFAQ/cc
 zm0bIJ2yGFzH50NFhBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

AQE (Applicaton Qrisc Engine) is required to support VK ray-pipeline. Two
conditions should be met to use this HW:
  1. AQE firmware should be loaded and programmed
  2. Preemption support

Expose a new MSM_PARAM to allow userspace to query its support.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 13 +++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
 include/uapi/drm/msm_drm.h              |  1 +
 4 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 44ce02b412ca..4d2f6c4d86e3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2604,6 +2604,17 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
 	return 0;
 }
 
+static bool a6xx_aqe_is_enabled(struct adreno_gpu *adreno_gpu)
+{
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	/*
+	 * AQE uses preemption context record as scratch pad, so check if
+	 * preemption is enabled
+	 */
+	return (adreno_gpu->base.nr_rings > 1) && !!a6xx_gpu->aqe_bo;
+}
+
 static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -2802,6 +2813,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
 	.gx_is_on = a7xx_gmu_gx_is_on,
+	.aqe_is_enabled = a6xx_aqe_is_enabled,
 };
 
 const struct adreno_gpu_funcs a8xx_gpu_funcs = {
@@ -2830,4 +2842,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 	.bus_halt = a8xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a8xx_fault_handler,
 	.gx_is_on = a8xx_gmu_gx_is_on,
+	.aqe_is_enabled = a6xx_aqe_is_enabled,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f6c39aed50f2..78c348852b4b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -444,6 +444,10 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 	case MSM_PARAM_HAS_PRR:
 		*value = adreno_smmu_has_prr(gpu);
 		return 0;
+	case MSM_PARAM_AQE:
+		*value = !!(adreno_gpu->funcs->aqe_is_enabled &&
+			    adreno_gpu->funcs->aqe_is_enabled(adreno_gpu));
+		return 0;
 	default:
 		return UERR(EINVAL, drm, "%s: invalid param: %u", gpu->name, param);
 	}
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 044ed4d49aa7..c0ee544ce257 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -84,6 +84,7 @@ struct adreno_gpu_funcs {
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
 	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 	bool (*gx_is_on)(struct adreno_gpu *adreno_gpu);
+	bool (*aqe_is_enabled)(struct adreno_gpu *adreno_gpu);
 };
 
 struct adreno_reglist {
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 5c67294edc95..b99098792371 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -117,6 +117,7 @@ struct drm_msm_timespec {
  * ioctl will throw -EPIPE.
  */
 #define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
+#define MSM_PARAM_AQE	     0x17  /* RO */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #

-- 
2.51.0

