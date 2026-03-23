Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A746BF483F2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEF210E440;
	Mon, 23 Mar 2026 20:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dKowUVY5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePqCHnkM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D857E10E47A
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:12 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXkR1761799
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CGj71twJ5ZzNNZi9iu7gqpb92KAhwgkcEKsZ1QXTiMw=; b=dKowUVY5LJ5uf1JD
 bo/duJJ02zO4z658gX+PdzgFzXswOv/PBrSAS90rkrJlnpNSk9IJr+m6QcjQtXIJ
 3prq2NzzX4fb4SY7/Ofl1Zi8kI+uZLgJfcqNnMlkNW2E2mvTTSzYQUUnyeCTTrm8
 xE1vd9CtsuFZTlJP9Q0gZGK8nny9zkV4KIrf2BOzHs/bZpMuJrHXMvCmWLetvIr7
 AInRMj/AhTRLiU5wSmv6OEdsCOEabI8slm0OSjiddz0fAv6d9VT5eOOOz+KEzbOA
 4pkANv7qj4uFhhSHIYzvE2F/BGwds3anmSrWWCFbPD3lNsh4+mwgAABI73CIP4Km
 +Xy5Yw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d36f09dwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:11 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7381a9a932so1980373a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296851; x=1774901651;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CGj71twJ5ZzNNZi9iu7gqpb92KAhwgkcEKsZ1QXTiMw=;
 b=ePqCHnkMWDIbSwN0rOHRm6UOy18FTpIbnKCl9tA/8a4/6Z7kL3C67X3+FPAioBjlc5
 dyP97v2aUcrHsDYW/hcuv1rWnEtRtDnBnbN1HKy22BHi+cwbyck/o3zmj5J2C1W9ROL5
 7z/vdWjHQJs8JNzU2mJth57ReJBu+eXvn49CZ/0ZwnUTVIFzlaTfsbwlh2Au8D1NFQH/
 UOuek+lDo3g2eUpiZXAhL0TCxlwREaJuf+neTQTjp5oFTr/IQNIxdrxxOt9hwdAOx6aM
 ZZ46J2e4+rU5RforKiMhovWH/i8iDvJTZZiqO2WYXelQOqaywbnSs68fCzVgUyPVPDzg
 hXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296851; x=1774901651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CGj71twJ5ZzNNZi9iu7gqpb92KAhwgkcEKsZ1QXTiMw=;
 b=QIU0JYTJmqY0af5ZD+1TXbbxNRGD92pCpoCTQ7tTqdTYnAPQrR9ZKWs6JoBDxdOXBk
 4zkEmsQLK2RZC1B+YBQEB1l4VZuIMgxpTslzlrLFlgAZoRa3nRn5KOqCnuPrl1TcCFFq
 kNVaCTYr997XZgOs36jvL9eC/gRBx6xhnw4OnS6w0H4gKVn4Zyq7gUWaCrHFAEN4+zUD
 HzWIr/2wAusMgjkFcz+EjhbMGDHBoJDjBBHVJqskZBacTVY1LfnserMiq+mJMNKlJRBm
 4nB694G+08l/KxpTjfyQCTaaG20T01jWRzWp39J1nhN0ZPrIWOK4OIMe/uHMhDT4+ObL
 KnqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVufCBWW67gjJUinaYJ3pMldRg+7bwgHbBrJ8nxToe0AZ70iFgR5txIY1qyjnArYLHFji2CLYBOiOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6foij7ItXwoLbSiyO8LFbSovLEgVb53UXfU70ZgA2srhkSXgx
 urapBeDYNq19OAWDqdLcbCpzDzhoRsNVdzBSfMbJnWu6abpMem6/J2RkTDckR57r90/EurNdyIR
 2vmw/4ksYhAya9EyOTKZggua9xfvURwTveegq3/MtUJUhZgjm+AMxT+0KHmpUoSc+Qe2XD+o=
X-Gm-Gg: ATEYQzxtb9bwzjfFt+mf51CQsq0/jgpm4PWVlfieYlzJqLXNItPIsTfW48CGS40JcrC
 tIqp5AzSFYUJ1i+EVgodbM1KdW6hrmcJTs8IHuTAvYQn5/teyBj1J73w5r5o5resMYQNUIzZ191
 t+K/a04Bfg72Ch2fAwACAK5lTv+4g0U0VtbHNUmIAgx3dC4rMQ+vqPBD4rdL0iS2ILM0DOfL1G/
 QwLxCubMT/0XRC5uKb5nEsJEHpagAUmbF2d2+TQj0HUzIgRtOcCJhP/kihYVRQC/cxcfiIfNIJ6
 BCafrdhK5q1zXMkR91L+auwOJoZK7dlMcDdknmf83i0kNV2JSKI+YGF7rbXxiKzcbxL+IJCzUi6
 2UnrPFSZCKu7TdDJ1PqrmoWqPagqxcSIcOqbUPtqVsrAfOA==
X-Received: by 2002:a05:6a21:6d99:b0:395:7fb:9362 with SMTP id
 adf61e73a8af0-39bcea16744mr12834168637.19.1774296850984; 
 Mon, 23 Mar 2026 13:14:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d99:b0:395:7fb:9362 with SMTP id
 adf61e73a8af0-39bcea16744mr12834139637.19.1774296850493; 
 Mon, 23 Mar 2026 13:14:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:14:10 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:28 +0530
Subject: [PATCH 16/16] drm/msm/adreno: Expose a PARAM to check AQE support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-16-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=3641;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OALDtSgWAoUx/EoQ1+hF76+gqkywPVTt4BGA/lmsR7A=;
 b=0U/dxL1yL6aQatKBLmc7nPkUYTffkVUmMgtW1qBahyOb239m7K436lkQdHzJI2lNLj8kbRpdK
 t0Tp+PB1ZxYBf3Q8mB5wv+jUSHLjlETidORFunZfMQSFnyjxEHRepxA
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=b+q/I9Gx c=1 sm=1 tr=0 ts=69c19f13 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VDML5bnlI8VuwgTyKRQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: ZF6x50bUl8txx2rZijrgplP0atJgqfDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX6lbocX/f42NQ
 TTUt6Ov2cAx8KwKSDOUaQHMz6Im+8l3b7fEDEr1YZmLc2Grrv1SFUkMfvDlYTJB0mREewBh04Ug
 wo7lQgFacso2Y9ziq1dRPg8djyKIU8LRjbUi4L+dpgOYIWfzdG/LrLfZB+3eKiKgyJgi5RKQyUu
 kIdVAnZt0xYUgoI+jdtZq5B0bZfGkdKnX4cmMTjuGREhp79wm3zeCo20gzbuoEhrFfAq/QCWgGD
 q5a6j5GYa8mOQukOTFG50ddHbUbOHg1xLEMUqdIPiO2TRCw6Ccnf5xcWHAUegsUJ4uYyfxj7P5K
 w+KjYumWBNLJSEO2GQxQqpt30q2lliShoVrvOiYnDuoGLGrltUkTh8IYcib/Ki7Zq51Ry4s2tC5
 AHO6ZczH2El6iWgnIzZzrbSrgrLP2IWiI03CXpzfqWdcezYDJj2LghnBzF5BSk2XSFZnAnr7KVC
 hbOzoKrpyJcXPJ7niFQ==
X-Proofpoint-GUID: ZF6x50bUl8txx2rZijrgplP0atJgqfDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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
index df739fd744ab..224b2f7cc8d3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2610,6 +2610,17 @@ static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
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
@@ -2808,6 +2819,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
 	.gx_is_on = a6xx_gmu_gx_is_on,
+	.aqe_is_enabled = a6xx_aqe_is_enabled,
 };
 
 const struct adreno_gpu_funcs a8xx_gpu_funcs = {
@@ -2836,4 +2848,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 	.bus_halt = a8xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a8xx_fault_handler,
 	.gx_is_on = a8xx_gmu_gx_is_on,
+	.aqe_is_enabled = a6xx_aqe_is_enabled,
 };
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 826661cb7988..f7289a9ee0bb 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -443,6 +443,10 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 	case MSM_PARAM_HAS_PRR:
 		*value = adreno_smmu_has_prr(gpu);
 		return 0;
+	case MSM_PARAM_AQE:
+		*value =  (adreno_gpu->funcs->aqe_is_enabled &&
+			   adreno_gpu->funcs->aqe_is_enabled(adreno_gpu)) ? 1 : 0;
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

