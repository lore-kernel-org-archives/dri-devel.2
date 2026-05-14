Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D2ACD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE6410F246;
	Thu, 14 May 2026 13:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="psN6SNR4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6ojQWx3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CC310F243
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeUWb3048540
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jWB8IsiT3LX
 TyyABiITmFtV+44Tckxt2wHe2PuWE1WE=; b=psN6SNR4Qwpg6h9puonGz/3AZ89
 BUs2yHNi2GiBaHU1VAuqgtvmZAseDQklEp9JImWZthUGmkl9O+Ox2mV1W9qDRdPH
 qRoZDNPPCl48adb3Ejw4aajmQG9NUssI8BqhLTUDF414AXoIWinCVG1KF3RIpMf8
 DRPoj3NHR3VBERAJvNAytw8wx7sgZWV2jlBt1y+o61Pjdn4XaWDakLmtqbgEUo2n
 lfnVL0UhJ7f5gWsLaY+AUaHUXuSOdySn5wrezne9eOpOZJ2NfzXcE4IHvyOwVvHW
 k87Yx3aTWGMT2Q+U4hgfWY9AdjtQYRFqt4U9FW1ChrK4VmENP5+V+W1Gs/A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5492tc8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-837d43e9ff3so5936964b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766890; x=1779371690;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWB8IsiT3LXTyyABiITmFtV+44Tckxt2wHe2PuWE1WE=;
 b=G6ojQWx3DsqajfoJwXfC2Ol0uszxCZxYya02IL6sLI4M3/mBBpgalC1nwCz6+LcI+1
 4c+buL56p0xps/6u7p+9roxF1MqQdYW0waNq8IAefQ9vSXYrgcmYEbx67WS6inh3HOQc
 5L/Vnn9UO3y4t+a12PwJWwjSBa9xT6tqARuIIdlFDH1E17UD9KWhp+vyoG0/1NbbsiXO
 X01xM/1+MFyntL97ycnTxtbZFtDG9Z5dzzogrOCkC2JxdTklLIjlvzJ/PdfVwJX4rYxA
 JwXH3/jThTVVgi5QzYHkALhhWRRV/YMCC5iB1u9ZHnPvsHpafE6qgfE18Leb4fV7JegG
 KofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766890; x=1779371690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWB8IsiT3LXTyyABiITmFtV+44Tckxt2wHe2PuWE1WE=;
 b=Yyax8IYuaoTHVhYwwtjkGPoa90e9MpA24tsibfDTYqfiuwUwUqPkV5jFDn52Q0cSiF
 ymgydu5KrvG3Qdmey/9TQs/Dg6C5XojzlqbLaPctdiMV92j6VTSW3/QJuvTBGTN9V82m
 jPaFz4t2rRhWI3Shvhr+FzgSHgCdCquGjArFwEfa0xP1yD8DFZmM4UxsY26Fsmbma1S5
 DdlaXmyYN0MJilgzXfhN6wMAEZ2kkdcSAqyUkMLpptg1pQH37TlKqgGdF3qeL3W8VCFM
 l/fRvF9/qwtiWNHPLcialEjv5esIM7aoqWtCY5GhjX8QTm4FYn1qlkQL+PUV8F1t6Qw7
 /A8Q==
X-Gm-Message-State: AOJu0Yxfjy2ZY8/YTle/IqhI9NmcLM3zswy9x5vDnGerrnYItd5y3eUw
 FxtbJjT/2fAgwMb5CN2bh0Q6IFTf/C6/Ml3JvYbIxWY8cX66cnDsn7nlnM7FH0IVG4KLFv/MgBk
 phNx5WMKAE/cvHaziQixTTPDYQ5AuzbhWqkTQ+6gO4EAh6XD2Ktmzs19uK/sRh/X307UkeR1rFu
 OZYho=
X-Gm-Gg: Acq92OGGcDuieZWIiGc2blry6fYE3H1gr6Y8Am0j8ySI3EIjzzgi+RbgRZRGkeqFcyd
 GkzpopWjXPa85HcXnDbgL3RjivUVMKhP61F70YgfwzUSLA2eoK2k2GpMftAXWbbODlsa9xnA3Yf
 nBu04ZB5eBY2/7Drgq8c1RKranaaRY463pEkkbOt9xBW7UYIS3rrnsm+OnqRkQPWKMmOQtsHUGE
 leU+nzFnJerGcEUdfl9QOJzAZytSopKpXONk9OAUqfoBZxgOb7X19I3Fpkx/c1Oib51re5wJYFc
 cCiSt0iXDvJxBYtwa87Jo8VoShRkwwKDem28WW4dVOa1A8LevBeBeHd2BjnCflaqEcEJbgZ/HXN
 AtVGQSG4b3PjFx+Q/tCF5LG10pWaCQPc9
X-Received: by 2002:a05:6a00:194e:b0:837:40f6:cb88 with SMTP id
 d2e1a72fcca58-83f0427d8b2mr8611812b3a.26.1778766889363; 
 Thu, 14 May 2026 06:54:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:194e:b0:837:40f6:cb88 with SMTP id
 d2e1a72fcca58-83f0427d8b2mr8611772b3a.26.1778766888800; 
 Thu, 14 May 2026 06:54:48 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19f79b60sm3162132b3a.52.2026.05.14.06.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:47 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Thu, 14 May 2026 06:40:04 -0700
Message-ID: <20260514134052.361771-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2HokXwXNMVLzQccVL5MiHbuj1RGyH6gx
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a05d42a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5obZvuzjGUYrwyXX1KsA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 2HokXwXNMVLzQccVL5MiHbuj1RGyH6gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX1KchfH6jv2jB
 FIQqeCq1ZYwIv3aS82HCW4V19Socykgg76KiQ6hQmPjPdi/uGWJW7Pog3m0cAhNn6B09JXL3uID
 IMOvIPYWErrPNBDLeXnVRAvgmK5js4TcrmbtAowN7ZiZZqX21dHuvHtQJkCCjEwY1rIASacCMuO
 Ao5pjpFiW+rTbPjFUfP8qY/hC04Ke53JjWUND+gMs32Y0ZFUS8yEpKD99Qkq7sfsH6bli+yYJen
 DSBPFmEwzRUquM2QrpXvML3Veka6NRpx1LkSJN9Zo+9mJjoOPWDx7f4/ZLK2y7ATJSQoMH+ZEBG
 k9VdSzIOwlopZsuw7AyO1Q/sacpC/wiG/X3NTOy5zHKeIFnZ1esE4V+o5BRsu1DVXulgh4CCvvl
 2Ax8g1j3GHgC2aV8tCidRfSfkCVGkg+FcJ23viQG7LSo5IMg4MHJFQN388Ea5VQFZVl0Kz1Qjlk
 6h1DUifnFJ3fhw4WaDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140140
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

Now that the dynamic pwrup reglist has SEL reg values to restore
appended, so that SEL regs are restored on IFPC exit, we can stop
completely disabling IFPC while global counter sampling is active.

To accomplish this, we re-use sysprof_setup() with a force_on param
to inhibit IFPC specifically while the counter regs are being read,
while leaving IFPC enabled the rest of the time.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h         | 10 ++--------
 drivers/gpu/drm/msm/msm_perfcntr.c    |  8 ++++++++
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index aba08fb76249..0a7d49a2c877 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2034,9 +2034,9 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu);
+	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index f3cc9478b079..eecc71843bed 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -280,7 +280,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu);
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index cb74b7606987..e3b5fab6f68f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -93,7 +93,7 @@ struct msm_gpu_funcs {
 	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
 	 */
 	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
-	void (*sysprof_setup)(struct msm_gpu *gpu);
+	void (*sysprof_setup)(struct msm_gpu *gpu, bool force_on);
 
 	/* Configure perfcntr SELect regs: */
 	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
@@ -378,13 +378,7 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 static inline bool
 msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
 {
-	/*
-	 * For now, this is the same condition as disabling perfcntr clears
-	 * on context switch.  But once kernel perfcntr IFPC support is in
-	 * place, we will only need to disable IFPC for legacy userspace
-	 * setting SYSPROF param.
-	 */
-	return msm_gpu_sysprof_no_perfcntr_zap(gpu);
+	return refcount_read(&gpu->sysprof_active) > 1;
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index d6716ce0657a..df8c2602b4bc 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -261,6 +261,10 @@ sample_worker(struct kthread_work *work)
 		return;
 	}
 
+	/* Inhibit IFPC while accessing registers: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, true);
+
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
 
@@ -295,6 +299,10 @@ sample_worker(struct kthread_work *work)
 		}
 	}
 
+	/* Re-enable IFPC: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, false);
+
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
 }
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index a58fe41602c6..1a5a77b28016 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -42,7 +42,7 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 
 	/* Some gpu families require additional setup for sysprof */
 	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu);
+		gpu->funcs->sysprof_setup(gpu, false);
 
 	ctx->sysprof = sysprof;
 
-- 
2.54.0

