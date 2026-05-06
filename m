Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F83CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7FC10EE5C;
	Wed,  6 May 2026 17:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwvoxX5K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W0DCQAQY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5002110EE5A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646CFYPK1514820
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ltx6YbZjqP0
 n0TLXyDmoE2icoLsRZfk+xmP0o/mye+A=; b=cwvoxX5KO7zWLFEHNViksRIsoMf
 0d1ZwErrxXaJyvgu7csZvX1XGcTS2GZoimbPPc9fMrJ+/3TF0dUauCy0yOXKqQoM
 z8PDRTZrt2/jtz7aTFwxqRUMb/Rw1YFFcoPnIkW68rG0MTOiwSpLtkHf3uRdFei+
 ha6/rD1bCyekL6mwUKnVB2oiVExvFjOuUuwZsfOjo5u5+AGNl0UiZMGPmblMz7Gq
 lIZtdFjXvBWfW3IfVhGJcDOWnFsaHGnJv2hsC+C6ayJg4AhEYzRlMqYVIhSCrZtu
 ylEWNbc+O2jmbDdx6uNEn+0ab6804bvzDSfSvVHjEk7jiakWdFpdv62i+RA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e00v1tfpu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82fa366fb79so6703101b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087537; x=1778692337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ltx6YbZjqP0n0TLXyDmoE2icoLsRZfk+xmP0o/mye+A=;
 b=W0DCQAQYc5a3acWUvZ1KJ3IQewD/mGO9/k80ffOB7HHLridmSDFfEp3ek1rNijo5OH
 GYak3Uo4q5q5RrSjm5tFg4Yjxt8ZZ7IN74QHxiaGasqh6iEGvOJrgO/BrCIsDW8DER8r
 gUn78j4/a9fR0f9lJUhpaL8pCLKeVvPbfH/THx9p3ODT8iMJnewXGMGwX5T+OUmHAgb5
 zwQ1qTwTNRtbI0rh33J1ywFVb1lw5vbEJl3B+Y4dNonfra1UsjDLvgdIzstX9VLr0rRy
 4XCYdiPmFFK2XrGzobU193e3lUTyVY0AQ0iDBj8AORi2IcnRRotsd2TFL5P4N8IJoH8/
 Do2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087537; x=1778692337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ltx6YbZjqP0n0TLXyDmoE2icoLsRZfk+xmP0o/mye+A=;
 b=fj0y8aqMZsGdrs1zuiECrOWcM3odcBrd6SJq9bUNwnOAnCH8V7azfiXxOSDOKW/qpP
 zlYAKPztIGwIXdUFRl6Ufaf7+XJ572LQdK5w514X0UPoBeazcAMy4sz5sypfb18rTA0x
 0X1lIIY2w2iaWBcqgkhyb6FowAtTYrN0z8XgDNr2/fehBYHifnuil1QUMucz2N7UG+Cl
 quS+BUMmqxuhp0EgAAHPXEVCzN2Xn4jzfDaofSA5hfwiuBiQrjUMwwRrSz7cBiOxIByD
 lEMYcOtEhMRevMsr1m47SNH86AXrSK9tEvRtj+ay/GDjcca09br574WK5z7VG4iafInP
 0sDQ==
X-Gm-Message-State: AOJu0Yzvh1/I458ZIy0yWkdI6gfciRPWvBDXby9SCIL5Yt7ERD19zNLR
 UcUnlXCAOnEtaSp9YlaN/+u544JDA0R9aPUJbzAbO8IlC+LIY626YxbyLA5hy0OBO4bHwWZHtUw
 rq+FJWw5I+CBY1BPzRQh9JRb+NTBYlqFc03EC9/y7SNFYLIB4SNQRbuB8EKOjGk/dDgKsBXLGs7
 tbSNc=
X-Gm-Gg: AeBDievRHnVLmbNkpmtwvSmMFN4yxPvfUD6G4gICGIrJWUO5ShPAOfSBxOXzj6e4IXp
 B34UkbkOXjLFPEg1Mg9YfBpzBFJxhLWbhNmHORD/mLN6k4uN/gEKnXlt4liz/LhpqjBiCWztlTz
 Qv3/JNM6GjtsWRZLxd143ynv9WBHxsFlXvUvEQIGCP+hflUzgGGvZmnVp9NoA/neLI4inlj8QmX
 qGXNkNDzcxYv8P9TUgtx9/WxTA6X/kRuJqIe1yqtyd313yFHgIlJc3EaNyYseq3tudTUseDkOLB
 MlsRLCCW6WOvyzVxklUIXDCk+DHs0Rq0ug2j0dPsDV0NeXAxe7q4DbJgpvaO/7N9X3Iu95bNYMt
 9OSUOVzj/3HZMuJWJZmgieapZZ0ATZfr+l+FA5PRFwyLqjTePvebinQ==
X-Received: by 2002:a05:6a00:2356:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-83a5dd5c7a8mr4219524b3a.25.1778087536494; 
 Wed, 06 May 2026 10:12:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2356:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-83a5dd5c7a8mr4219457b3a.25.1778087535860; 
 Wed, 06 May 2026 10:12:15 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682a4bffsm5597815b3a.56.2026.05.06.10.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:15 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Wed,  6 May 2026 10:10:40 -0700
Message-ID: <20260506171127.133572-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dIxHAEL1jenl7KkDGbIfR6FPow7bhS4D
X-Proofpoint-GUID: dIxHAEL1jenl7KkDGbIfR6FPow7bhS4D
X-Authority-Analysis: v=2.4 cv=cKXQdFeN c=1 sm=1 tr=0 ts=69fb7671 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=5obZvuzjGUYrwyXX1KsA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfXxpK7aLyQN2MP
 1n+cZTk4nN8WRiyF+sKOjcOo477agdqIJRAL+XCbbId6DsRppYYBw3aCsq0PlxqZrWksgQmY4DG
 ObNaS2YqaAATmTSMj3Ez15Dfp4omH5whznrP90PSHKki+UeHPuu8QZ45c0veKi1ETp/8sXYlXBt
 ToAx3KOoDc6ivInR7QT3PDtdEU75MN6yAp/4vsMdgQRifEQI75aOlCvYJroHrW1NViJIkYKKVHl
 j51UqMyS7Tr0rTQz+xkT4lNrXvqtauALjQOP4/agSENXlzx5T9zYEWAz7yqV46Dk4A6Pw9QPTET
 ALPLmxKBTX0g0Auki9OmBBzj6Uupo2ML+ZPVVSrjdHXVgVew0O3a3KhAN7NkQMDEtoRGnYw6QvN
 7uC5yA8BDl9KGTpDtMR+P1lnE2cuYyxsu4doboBs/loe4geyKw4zKkKcLXeS1YiwunZG57lAI6u
 Ee03q+FL0nqhHH4y2Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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
index b7a9e3967a82..09e58a9a20bf 100644
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

