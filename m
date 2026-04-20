Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC705F5A8C9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2864610E7AB;
	Mon, 20 Apr 2026 22:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LjbbeOY2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5yx7g7Q";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5955B10E7A2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KJZXNx3455879
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IFiZL1NwQ6D
 Due2SMJYnEumDyH19FQ9OaaUBkjM94uI=; b=LjbbeOY22ifHM127fqhgvoCT64J
 gN+RbGjIgH8iiud0O/Tq8uyZ8wg0z7iHG3M+6MyLLRmmYRuDKUXCklPvx+1p6tjL
 dTuQwLACelL4r7PnUIxEZEW5nOdcWUQXQs+e8FX+xT9BSC1Tndz8RWQfsiuDcZrN
 vipEW5qJM3hTs7p0CjWX40fi55CB/6nzb8SXEkkQpo0t2LyDvXiHI+hApN46gxaD
 soItEJ5dre8L1/6M1+ZHZkXTTpuRhRChHiEChc7VrPsH1KtLkBi7GX2Z2einL8cY
 2XsoN90zV9P2rO3+c/sEhOfiHnqHfFCgGQfT4+5icLbMJVzN6Kptkd0vLBg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjub6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so49564985ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724047; x=1777328847;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFiZL1NwQ6DDue2SMJYnEumDyH19FQ9OaaUBkjM94uI=;
 b=j5yx7g7Qlr3/D45OEa1HGxTLOkU/MTwGdp0rRiXTyUrXjuLE1YYEtn6JEGim7gXvOc
 dbAi20rvN41E+Dz3k160CN64pfiRCt/y7dFcU81q31FvdGncQjpdQwRiJgsgdcJrrxo0
 E+HyBkXHuvmxNy51iox+l1FelRC5rJ8ka9Qjj7yj9KZFLMk9DDSow6XCJGOfD9ccSgh3
 RMVgkg7lJ1zvsvk4HArbc+6/nuSH6OYmrfgOnNKpIfjQ04bDk61uyXJ0ShYTJADsDEOf
 niCBfPjQoHF/kYRBiooVMKHxG08HvaSdrZ4DSWZdpFVuvrZ6b2hS71KDxmt+HkjvDuiz
 Czwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724047; x=1777328847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFiZL1NwQ6DDue2SMJYnEumDyH19FQ9OaaUBkjM94uI=;
 b=oOiQ1YkINLLJ4PM0WgjSpTU2AFnx2xQQnBWLcNJp726+6cO2+d+Z3kQRQm2zdEZyuf
 7Q3JEtNNrlPEaHSiUMEwzoMZvPTDy75wbi2C5POMrmQP6u/PSerhI48idRraSsRrtOl0
 qAU4sIG7mIGpDLBJFX81Q0oFrSrqNLbxG/h/JzEiUttpkwITeMcQAVxD9pZJbjFK+nlj
 QhmXRnYcqRX/QjW6XqNZW3PfdqJ3FAEttkp8bPrc9bKjlUBqm2/gJ+OGQk55O/IYbUK6
 IUPyepvF/lC73gKjV/kiT+iwBTpQOn8Ozk2Yaaf/r/jfhwIUJBBTAz/L41bvi0bkGEdy
 bZjA==
X-Gm-Message-State: AOJu0YxS7fbg1CiNNUu0xeVjsmCCMNUj/gqRWTU8OUsvfIVCmVn9s6Lp
 Gefq+wsV7zt8nIfqF0r+04G3M7tbLvq4EfZb2eamUhs7V7iZcjX7wwM+EGg10Qc/bWPISMvcpME
 nCF+4fni1IpPnHVsmP77x/81GeHYsmTwOscx1sw2+HC36mHg3RLesY6tuRDrRYbrp60DQ75fl2s
 x9ZT4=
X-Gm-Gg: AeBDievyDgly2XttC9pEn0nAd+Rl/UFGrSz+PefTHLRtEjF8iIjUyAxs8uL9CTfqUav
 bX1bVsBBZdXAeNNoHCof80bDJYGrhxQnLEhbyjsp72zvQi1kjXDVl+rYFH0yeZM23dGnPYa3UfE
 WOmVQqX8g7rb5cad73c2UHJAF/e7l1xNSCw6fLXuO7cpEICX4qCEl/EsmAwvIA3hhefJZgjgZ8m
 nXvjTOiBQq9JZBSAtxH/eh3PB6MmYFKrw4y7/zgNWdUt8btck1woQmyYAYJ9TcPpYuBmLK/lJeV
 xCKA9TJ/2OGbdeZRXCD5wDBvbdVOZdz6490zQxzK32CaVMqK6nzWyojR7UgRc/WHj256CGUN+hm
 wpKS1tQ0RpW0W+k/DqG089wLX1TB8ufrr3T1f7EgS4W8=
X-Received: by 2002:a17:902:cec8:b0:2b0:5b4e:370c with SMTP id
 d9443c01a7336-2b5f9f8b3ccmr168361085ad.32.1776724047438; 
 Mon, 20 Apr 2026 15:27:27 -0700 (PDT)
X-Received: by 2002:a17:902:cec8:b0:2b0:5b4e:370c with SMTP id
 d9443c01a7336-2b5f9f8b3ccmr168360905ad.32.1776724047015; 
 Mon, 20 Apr 2026 15:27:27 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm115829825ad.54.2026.04.20.15.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:26 -0700 (PDT)
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
Subject: [PATCH 12/13] drm/msm/a8xx: Add perfcntr flush sequence
Date: Mon, 20 Apr 2026 15:25:34 -0700
Message-ID: <20260420222621.417276-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wWDh2LHEyj54I84pHK0QZTc4YaG9gPK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX99HOrCm2fKFK
 hW7jhi59seP9BKuoxknJxM5egcBJGBXmg19aSeiptSd2j2wRtmdIhPpM2kYunbKU19lLb/RN12a
 KOLrH7ootrXabJdt7e/4AT9qfy+T4DDAWl5LFL9U8LpkeFQIbANONtCDM5w/5seAh7b5fr1Ncxh
 aCEJEeKNEbK794AsALVzbFvCkqNo8nbhZAIGnVvdLtP4rBBnRV6EQAIZ52fnI6hxmsteHddbIaS
 VVX+2G/3wRxFHNncrs6iryyTXbr5Vlvt0FYlKPfeBnEEECBYhiyNNrd0BbgIDgrl9aNyao00PG1
 g+w922vw9WMo2zCMImgSXzOAfQkKYHK7lFeeortMs5cUL6sd1wBmp6RPFkrZuTuFPb6k1z+xTys
 mXiu2NDKTvYHYHseN+HGKsLNCq1yM8e49XxztQxSqK2OXKtfIqTRvXQH3qd953J4Q1nJltPhlV0
 bJtRy/I6emJ7FZq1wtQ==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e6a850 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=W-43u8CF5Pkpiqpb4b0A:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wWDh2LHEyj54I84pHK0QZTc4YaG9gPK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0149eba403e4..e25853909a5c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2918,6 +2918,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
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
2.53.0

