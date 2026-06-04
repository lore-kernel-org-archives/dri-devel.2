Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CD2CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FC110E3C7;
	Thu,  4 Jun 2026 20:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EtvjZ67U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LxadiUN6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD5B10E3C7
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654G6t2u1957545
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DRR+DEsprtUEBKuBcsLnY2CFiQ0q3UugCfTWP5lB0eI=; b=EtvjZ67UmwfmuA+P
 l62GxnULxz8Pff/OAWdONMrbm8Qm868J57GU6ZUhKDVyaCkElO14hCfrDgalIQWa
 cW8dMGp/0L5piu1IJWYDXY3FYGe5fpgKzDWp+MfsZHYv0SQICX4OjMbU0ejriint
 tR6qFyX361w5cbw9ArX1WkKdocTcS70Ac/JSYF6Ro0n+DxzgTp02yBH9PAerh9po
 a2hQ/NvMqDbYjsw+rO3V7yq/KaWOyg3IDX6UpR/Cgr9a6sU0Z8LmHFV8yCz6q7oQ
 rdUVwsWiRNnAmM6WaF7FuMHO3daLJAFcpxNZ8YLIsMVUNCX4NOBZOtKSMPWqlCGp
 uF4YkA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckps5fr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36b808bedfaso1473244a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603832; x=1781208632;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRR+DEsprtUEBKuBcsLnY2CFiQ0q3UugCfTWP5lB0eI=;
 b=LxadiUN6TfZkYNUWkn5X/azkrALqX/KzXVdUA9jANDHeLQisujArvBC2OeWpmXeGv8
 mx6kd/4npx/2NqHpWy+NWnCNArUMX62gIy1bUGS8LKYVeRbjCRPkCLQX3t0EitYiO4mT
 y/O906uT8uxbQw/L7WcetCHEwGxfjyZLD74Lvorvsb9ZnZKbq3H5QrEbafzoAucApK9J
 AnE+N9xIY7hgs4xOKU6fTtZWJuGjcsaP/TqLSOB8OHPNmIwJniVvznDd0oPQeRp6LBwt
 htEahpcdzX4Jt1quDGs/D1Nxmci3zO/JxbRYv98w8azEqCjs2dOLoh0k4pHn2uzwi+NU
 58iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603832; x=1781208632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DRR+DEsprtUEBKuBcsLnY2CFiQ0q3UugCfTWP5lB0eI=;
 b=iucQI3NYx7GHXLbL2qb6QRclKFy8y+y1WBVq8BS636IfAmEBHit6Rn96QGMmHiGfWZ
 I+k9iZlZenafm5tQst1gSaxgv7a2YHZo2HesBRtsZYbHIdRpDX4Ot8zbs54Hghb4wzBE
 RjC2WMHqIjrROoL4d7J/j0up/+MQY16vM/HDxyiaMltE/1f/FVXB7FpTPbjdn6a23K2z
 ejTFaAsNmjWS1QeaZB3gXxdatUMejZ6G9dHvfb+1ICP+k70Kfq7BX2lDRhgiBZtSt/TN
 SWXGFWxrwjIFcW13Gxj39jTzJVA0MrJ22g7NnExiaQRjCs+qfMG9fdvL8JjRpmKYfOBW
 yJyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kRTtMchaZ6asOvsvVQxDALs898CP3Oi35TXMt5S1XUpRtWPedB3Sd1RZ2V2zRFGYwITVLaLJWjxs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysRHuZuxnWCes2xf//X/TQ9QMevj9MjZxO4HbYktDUkBS1az2g
 ny7xXnY7p7zO0YmVdVDOwbgqXD1K5Jwc1DkOxZRuKT0cCiumP45a7fD5rHa092l3MsSsPZTx6/B
 RzFFsqhrkLXTaZik6pZOSsr0VvTXG4jHbFgCKenWRUdDPoeob4e0hrr0qZ0c9pYqSQRRECVE=
X-Gm-Gg: Acq92OGBKxmj5FPPWZ0RUgmFxemCFidxaPkUX3Xl7Iijxr2ilVNs2qapvtVbNYPHydU
 XzxAY469bx0Sxwx38LOuXv+8rU9N1btFvU4AQUUOL5C4elwos+5j38OAWNNpEFmadR0a/IT4AZU
 L7b/n+M86LJ2gCpsm4XNPHBMzO4QkQL1Ron9HsVBKM9BjV8yETnFZnCzhNv7/v07FEj+UQvrTDh
 FHDIss131LGCU1+A86XWAGq40Pgrs1ReZgDgFGAAEpBkZkLui4A2TIXnboymlT6xNakXe6NNwYZ
 8GXAnMXzHEpXkqI3Od1+6kosUs2g+T2jnLCOtH6dPUo5FQL2f200PU1DViL2ITo8K2S44Jtku0Q
 nIW40/fkFHN5l5U3LCYaWPKHycJIkYv0cPVcCQQncGkxPRDCImq6Qd18X
X-Received: by 2002:a05:6a21:103:b0:3b4:b275:c5b1 with SMTP id
 adf61e73a8af0-3b4ccf5e49fmr579430637.26.1780603832565; 
 Thu, 04 Jun 2026 13:10:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:103:b0:3b4:b275:c5b1 with SMTP id
 adf61e73a8af0-3b4ccf5e49fmr579390637.26.1780603832039; 
 Thu, 04 Jun 2026 13:10:32 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:31 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:21 +0530
Subject: [PATCH 5/6] drm/msm/a6xx: Fix IRQ storm during msm_recovery test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-5-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=3392;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=GwZLyTIP4u6tN+9squk0q6Z3W6Z4ioTBobufFLsa2P8=;
 b=C3/9ME743B0Lm0FCKaGp0Gd5+Ja4JNQooQqlM5wA8ze9CDAbYXpQc+igMT6uAcMJrOFxQWaMv
 K16zIciLA+/DuGvDYLk25lzrxjPB/JJ47Z0G/e+r+9geen0PHobjunP
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: -pCFiyxZmUqZILuu3gW9NqNBSsW19sL7
X-Proofpoint-ORIG-GUID: -pCFiyxZmUqZILuu3gW9NqNBSsW19sL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfX23n8L3LkdIDQ
 b8MCPXOTc6CWrxcL4TwHDCuCRbFp7HHWkKfi3P0nUXoOqaqdZAh+GX11fYGYFVMB60hshmwL3uh
 Tp7jrEmUs4FDANBUsn9LAwPma71RoBRHZmkoeXEVApl2KaKgghMjnB28f3HFxKmAGApXjjsVlHi
 5s1DEl27G3Tc+Sy8pyiwOu90aJgvJNNQ6Ik6YBBq1nnqDMutKajhtAUhbh4OVY0Xb9e7XprcRGs
 IhchT8+KObMuM6bdCSHH9yDkZ4nUSAeAP3AB38Waj6n69aKfop4JM0sMYAmh6ZYfv/t0eTeKPei
 Or4yTR56fmxvJ3o20WctS52GuRRpn/cQhEZHIkNS3eIkogEC5wxk2NxTBnU65VmfACwoH2TRcAN
 J+LdXZTAb1rRqDE/DlopM03eqQzHGVyfkV+RD61aK+4s/H6lcwGMiwlq5UAepSZozlkKTL+KkT+
 VIBZg6kFVDnIJqwmWlA==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a21dbb9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Tlt2A13xodhnW1EGk4cA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Once a hang is triggered by the msm_recovery test, the gpu error irq
remains asserted and triggers an interrupt storm. In the worst case,
this IRQ storm lands on the CPU core where the hangcheck timer is
scheduled, blocking it from running. This eventually leads to CPU
watchdog timeouts.

To fix this, mask the gpu error irqs during msm_recovery test and
enable them back during the recovery.

Fixes: 5edf2750d998 ("drm/msm: Add debugfs to disable hw err handling")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 5 +++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 5 ++++-
 drivers/gpu/drm/msm/msm_gpu.c         | 2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 2c0bbac43c52..f1df2514c613 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1275,6 +1275,11 @@ static irqreturn_t a5xx_irq(struct msm_gpu *gpu)
 		status & ~A5XX_RBBM_INT_0_MASK_RBBM_AHB_ERROR);
 
 	if (priv->disable_err_irq) {
+		/* Turn off interrupts to avoid interrupt storm */
+		gpu_write(gpu, REG_A5XX_RBBM_INT_0_MASK,
+			       A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
+			       A5XX_RBBM_INT_0_MASK_CP_SW);
+
 		status &= A5XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS |
 			  A5XX_RBBM_INT_0_MASK_CP_SW;
 	}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..9a4f9d0e1780 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1911,8 +1911,11 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A6XX_RBBM_INT_CLEAR_CMD, status);
 
-	if (priv->disable_err_irq)
+	if (priv->disable_err_irq) {
+		/* Turn off interrupts to avoid interrupt storm */
+		gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
 		status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
+	}
 
 	if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
 		a6xx_fault_detect_irq(gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 9e44fd1ae634..0f6fd35bd587 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1211,8 +1211,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_RBBM_INT_CLEAR_CMD, status);
 
-	if (priv->disable_err_irq)
+	if (priv->disable_err_irq) {
+		/* Turn off interrupts to avoid interrupt storm */
+		gpu_write(gpu, REG_A8XX_RBBM_INT_0_MASK, A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS);
 		status &= A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS;
+	}
 
 	if (status & A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT)
 		a8xx_fault_detect_irq(gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 9ac7740a87f0..48ac51f4119b 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -552,6 +552,8 @@ static void recover_worker(struct kthread_work *work)
 		msm_update_fence(ring->fctx, fence);
 	}
 
+	priv->disable_err_irq = false;
+
 	gpu->funcs->recover(gpu);
 
 	/* retire completed submits, plus the one that hung: */

-- 
2.51.0

