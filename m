Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC4CCD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8830110E6BB;
	Tue, 26 May 2026 14:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="huMLx3Dv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbFRkJmO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8E210E6CF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsNa02705401
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wsfd0typLWI
 CJGnKJ2SYwAC6QidCQBdD4Z53MfilGF8=; b=huMLx3Dv/JfyKtd1s0iBRg7B9El
 ThDXQBfy3CQpvyDsTb49KVDFBlA7psdYfBaFbTp1NYCgFzjd3K/DVHZVRwe7CgnR
 NObX6Lh6Y1uINoGZF0SjTXc11OzKzHqv+UJ2ONe1TRLBSstifAGxLkKQJCuJd3aW
 udReUFGxDRJFhja8D7wYS2Rni84kcOhKKuo8Otl5Yy4vtn/tZ6YAHwbuCTbHJqVo
 r6freYCvgbUUs+jbnXZbgniQRQASvyaayXCjayxJEibo4j1OejRYuPcQdzqPL5Kp
 wgDw4/403UsgV8PNlPiY3PRuO5vFWA3qjawjK9U2hTCNrRqaifyxoksaBOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5vgjeah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36629e48023so10232933a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807267; x=1780412067;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsfd0typLWICJGnKJ2SYwAC6QidCQBdD4Z53MfilGF8=;
 b=PbFRkJmOz/cBnW+OExaJcUXAtD5PE6AoSQY0g3RvIACjp1rX3iSpdvmkJ3IdhWscuQ
 mUp/Qc+jdIapygclIkiTZw92WmXoQ0s2XktNb76eAfTE/Utve0Khb2gxZjHN5igu9xxw
 QCk6UpaE7gA82jpa358uVDwsbX3C2qQLxqSucPwQ71ObOHXZPhbgQDR0dXET49z8q/mP
 7Hs1DRHxUPYuepnpdjdbbJLWmnE7JiQQM3p6jIqtfwn0otUWoUiedRQlfQIdeiU9FRkC
 t/dTzRyvmGOXXiFX+Znt7DJ5th285CyQLQm0bUuO3npyoIVw9U7U23O8IydR0d/QnavV
 Ut5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807267; x=1780412067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsfd0typLWICJGnKJ2SYwAC6QidCQBdD4Z53MfilGF8=;
 b=dCnbqG8EbgL0c4vZQx42Rb+fL17x/2KsSjClAq7F7zlIwAzw/R9TWd8+fxwQe4Z72m
 KXj0/m+/UR1lY0ac7wfi/gGvEoKHbm3Ztwpkvz3I8mfPkbuE7w4HP7V0waCHoblPCNZ0
 T7OlR7bZ8rfYQVJxmavvOA7LWmfrJa/uLcfxbOWgcyuF1BPGra+fLUK19/ZqygEuVz8J
 kEvMwGyCzxqnKTB+fSKxB3gS9dsVRHHRhB1zYFfbb+q2qfHjtSV+57MY3EoKrBlHEhRd
 OYxVB2P5T88QqNxf4NA0K5omunsDXjcabQ/ZviP+INt0onra2nM7roK70U229nKI3uuS
 dYTg==
X-Gm-Message-State: AOJu0YzXs/0APh5zxbgUeUSGk3S6EgRkGDUuqfbQDL6Q5otfwTUJnxAs
 u9DRjEXF78LFP/nUkJrBHKMm7ylXNgE8KLGSkaETGuqlfxY02Hi1IeOw81Q0XkBhhi97uMtRxWZ
 bO5PdrRN8bPf7oAUT9P4QiBQERaZKFEU3Dm6wSPlOeluHjGtHsMrYTG8XJu2E2e4YoDWc26yFFc
 O4g/U=
X-Gm-Gg: Acq92OHebbZLt8xpHICr9qoPQtSLCTxRbIhJoPCh88/I1NIQCIe4u9/CLa31NMEyq3P
 K7E+etqa+Fk6POB6cFyBnpldhW7F9NCLdJ2+JAFS94PY9hEIvR9GQpiM5GzN65h/0XQ+LNDxPTx
 F6V5iCT/Qsc3a+a/E8fMeOPL+EQ5gEFV7JB0+/75OJcTf7DdBehIjcKqC52vz6CELbxvJgyZASM
 B21EC2dETsZYadaTL4vVXksoawPTEc2bTYupvwmTNFdREjztW1Vorq3gbnsJk3GKU/KcLCTIbRn
 UBSA6kcmL+qM69v4Nk3Aoeoi6VANChvtt5+xFrnxP/AP1V4FB0dbHCpsyJd7mrFmEhGwv0ZCEXe
 66Pmgtx1t8my64DktHvpX46qkUBo1B9d7
X-Received: by 2002:a17:90b:5208:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-36a676287b9mr18465097a91.23.1779807267156; 
 Tue, 26 May 2026 07:54:27 -0700 (PDT)
X-Received: by 2002:a17:90b:5208:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-36a676287b9mr18465049a91.23.1779807266534; 
 Tue, 26 May 2026 07:54:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b09698b0asm969355a91.3.2026.05.26.07.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:26 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Tue, 26 May 2026 07:50:50 -0700
Message-ID: <20260526145137.160554-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IrYutr/g c=1 sm=1 tr=0 ts=6a15b424 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=5obZvuzjGUYrwyXX1KsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: _JlBKKIeoLuxgGHIl3jMjIVf7ws183-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfXwTWQgJCeMYOJ
 kND8ykrYocFR5q7zKJuEYIBJQyH9VUILAGrX5x3RuV147NWVPZ/xEz1ijI3oBuPcmY5EL20i9BN
 erqv44jUIJEYgdeRb8g/5hmv+jTzpMBBnS7c4+h0VCJ3+EDvJFEHCfv3LU1FxkCMeTRMGpuBUtd
 9i28bPKYVruB1Ez6uJjjfrVVhutWTnvamDGecz2LzpXqjso4wa02mSIN+vLmwDC5S8xWlvoTbvg
 Ws6JZCoewhRCQm480m6MygaX+lOx83MttNKx6SpdBvTe9F9IwpRjByo/CwrlwcUtdjFo+natwh/
 150CIQSiJycGIJURDEt9bQkdaSHDK+BI7HnFvyd0ValZIHRnlaVZa3bFVswHm2jBC61zarOaKd7
 Aaj4N88Gk44bbzWcN9B4I7kj+nqAj5x7hiK7wT9cWhR57jEVQKjcGKbaPW7IK1KxQnsswo7LEkr
 fKQR2eORI1A6YiJSwCg==
X-Proofpoint-GUID: _JlBKKIeoLuxgGHIl3jMjIVf7ws183-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
index b72fb58bf223..f60a0801a62d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -281,7 +281,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu);
+void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 22cbafe75a07..3d8f1ea5335b 100644
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
index 0a6f8039f610..ce65b1160955 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -258,6 +258,10 @@ sample_worker(struct kthread_work *work)
 		return;
 	}
 
+	/* Inhibit IFPC while accessing registers: */
+	if (gpu->funcs->sysprof_setup)
+		gpu->funcs->sysprof_setup(gpu, true);
+
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
 
@@ -292,6 +296,10 @@ sample_worker(struct kthread_work *work)
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

