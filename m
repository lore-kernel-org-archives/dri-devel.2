Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17581CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA8610E012;
	Tue, 26 May 2026 14:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtRwLKhT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URRwfPS9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB8910E6E6
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QD40Uc3693561
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ScHhidnB094
 qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=; b=gtRwLKhT2ZLfch1ZgVmlohpAHYX
 FRO6WIGAwS4ZvAvcwX7ATl523xxkF4JiGQ1N5giwvT9zOIK3goavJ+Nb1KL2g+h8
 +BHrMaS0SVeUots/M87SETJiC/wQ/avpqk3HGhpcT3HunVkUQYFynHF/MMwE1MaF
 nmTgTfjyMSmBPOpFZLAQLPHQi+nLcR5bFRmqSWO/lGnz5OHNNMpL/1/8Mj6Xxf49
 1rIW1HM23bJRMiThZ2AXhOY1psiPhMRDRk5+sp8Q7nNxTBt3aWbmpL1EaY/U4SfU
 bes92XpOUGB/46IY67IK0ikLS4+/aCkE4MbM6cyiMoacBKtFq0Dk2wRFehg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2ygk01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b7aba0af02so102019895ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807260; x=1780412060;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=URRwfPS9KLNy6l+p/tC5EDmiU7kPkd/t3zJcnhnsb0niFx3y57rFFXOqYjShxB0s2P
 o6493ogs/mwOTdr7dECRt3vGQ3jGAqsnZ9xK7goR5VIWaTYH7m+4QKFkSQorsaiMt0Sp
 2jtHgxLW5COvVH7+FADkbE9R43PpXiT9CXkFPtUAi+KqQAEmIR6VseksXB2QkKH59fC2
 hrtBzSvdBKq9UWwSYQ3NYqzADy7f7r8xdIFjBkg5qZhUsmdvmzAdeRAJlWZQt1obYKWd
 gnXE37AoQYZzVo5WvXpsWpvRcRxYrEM5tOQdHah/bh/7r3pBcDgXa9GuN3J89ktSWV5B
 XkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807260; x=1780412060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScHhidnB094qXmqcj2I9GQS4JCvqHfks8d61PZbHe84=;
 b=Ji9hWUq68GHUAWGTq+8E2KEjn39pPiki9gWyOXLxxSBEdh03yDMR1QLp5RuPei9FcS
 ZVj7LxjaUjxxCKUAnQuX80PeLCC5gd35McosD9JQqsGDWlbUqgWuioaSzrCh8z9ilCOj
 v3OxVh1aLq3C0xZG7vKDqtKNAmXglxrCapjwKBopn/a7QgIXDJY7F5yP8w/s1P2DhSo1
 vpyvyNZpMqOWoZ90WTFB/zTgHUZmihWnO/j9ygMPBhP+DYnwHSEHnnj6yY1uY/fU3UUg
 Vmgpip4rgQsumwsn32Gb259fQayq88l6QkLbaV0W71LqEJah+Bu1atrBPnstSaTj8bs5
 rRIA==
X-Gm-Message-State: AOJu0Yznq7pqp9DnrHYH4NKmL+RDTkmI8p8VC7tez2rRVEpvU3hJQVkj
 XWrZjW4Rdgev2r1/D46GIJM7ZvKr/U1ML8y84AVy6+GrqRHcMgcK74pJjdRBAlVLsfa09bcl9kL
 JIfgw7IxSt9HkNQokBcQL17TNaaCJ1wtTmcqia0tWLXi3uUSwZNHQVEV6uvh1VLVkzwosZpIkDH
 Z0aoU=
X-Gm-Gg: Acq92OFcV+v3W9XVKFYuLNnwIZoHw6jVdMHC8VoxQPFX8J+Zf/e0hOTfX4qbM7SZmLY
 GvndyiDJTSWgevwYWuXcnIOxH/H8XvaGOqlUPrMDybk275Zn3HZaCK7neY4Ck6RfWXRajomWT7c
 mxKzIZdzvNiv0RFwemZELsn08iDTrDxtbsir75kkvsEutTjeBI/SlP/QOijWuF0vEPQF73QOVCY
 NLlsMr+U6JqZj/cyNxCvwJ+KT25yVyrNR+8N3NisERVFNu/PPKHpMym03PprPMStFVsi4zB8qbo
 Ne2R5reiHz1EFcYfzHFPWdwVH7Qz2eJLDrgTqRd4rymGg3cfRppBcz0K1OCANTB5K7iMdNcUHKm
 1qjAMSPpM0OqsdDlZvW/3fWSgmwINvaqG
X-Received: by 2002:a17:903:3c28:b0:2bd:3c1a:473e with SMTP id
 d9443c01a7336-2beb038b83amr207706785ad.14.1779807260031; 
 Tue, 26 May 2026 07:54:20 -0700 (PDT)
X-Received: by 2002:a17:903:3c28:b0:2bd:3c1a:473e with SMTP id
 d9443c01a7336-2beb038b83amr207706305ad.14.1779807259554; 
 Tue, 26 May 2026 07:54:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b387dsm130855465ad.50.2026.05.26.07.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:19 -0700 (PDT)
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
Subject: [PATCH v10 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Tue, 26 May 2026 07:50:46 -0700
Message-ID: <20260526145137.160554-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B8dAS86Bq70l3gYPR0bWXzeHbR2jRmVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX6hSWKSVeveoB
 nKCr3ZZzw7/RSCKHtLFvg6tqeNHTDQx4fkrV6ausGrqF99JGP9XNxAyFObP5cysfC6F0GVEqowh
 o1FESgMt3B4mauGBDG8oDi+LeOMbR3qzzr0D78hy1j9/myRngLAFeJX2Os+GZS5V2hS0j+fw8/9
 n9giWoEQkcPlIo7Ug9/70K/D2gqEXlH5ViSzEvzmrsLAbsJAKld/dXAnBm9mDBIQHePdfSxWF3P
 2CkvzApu0wguvhaiW5OFJvKzlfAeUIpjromy10jPmSa08bMa8n6pJ0J0r5gmZNY7QroAONhc9zL
 ZOxHfsZ1Mk8RiDdSjuWk7Atjpn7p+0PKqtvVpRXNj0sffIUM4VWA1aI1Jt54SOEG9YSyjqgP0um
 /QZQOxbDSHkOi4xgZDachybLthFR19j39yLHO0ekaYAWlmG3ElOO/KBEnSNl6pyPmGQhs90ok40
 I4CvI/u6hcyGi53ozUw==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15b41c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-43u8CF5Pkpiqpb4b0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: B8dAS86Bq70l3gYPR0bWXzeHbR2jRmVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
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

With the slice architecture, we need to flush the slice and unslice
counters to perf RAM before reading counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 30df9bfa9ef8..a329d20033d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2921,6 +2921,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 		.perfcntr_configure = a6xx_perfcntr_configure,
+		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 99c3e55f5ca8..3491a24a9320 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -334,5 +334,6 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu);
 void a8xx_preempt_trigger(struct msm_gpu *gpu);
 void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a8xx_perfcntr_flush(struct msm_gpu *gpu);
 void a8xx_recover(struct msm_gpu *gpu);
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 124d315b2469..6c040f718176 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1345,3 +1345,23 @@ bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	return true;
 }
+
+void a8xx_perfcntr_flush(struct msm_gpu *gpu)
+{
+	u32 val;
+
+	/*
+	 * Flush delta counters (both perf counters and pipe stats) present in
+	 * RBBM_S and RBBM_US to perf RAM logic to get the latest data.
+	 */
+	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+	gpu_write(gpu, REG_A8XX_RBBM_SLICE_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+
+	/* Ensure all writes are posted before polling status register */
+	wmb();
+
+	if (gpu_poll_timeout(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_STATUS, val,
+			     val & BIT(0), 100, 100 * 1000)) {
+		dev_err(&gpu->pdev->dev, "Perfcounter flush timed out: status=0x%08x\n", val);
+	}
+}
-- 
2.54.0

