Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F60FED3DF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5341D10F60B;
	Fri, 24 Apr 2026 15:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z58PEK1x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a7UY4uPf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CC610E101
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O95h241533417
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GWYw+eRhUpl
 ftgFXTQLL3PdOcEwv5KNZZwwyE3cFoUk=; b=Z58PEK1xvg23g4xh7+k/b0Hqbfh
 lY04erevh8XD1vtoSvLsP1SHQuxtc7wBcdhN1H6kTS55RCzs6ZxkOHGUvusaM5BF
 MKxoljmZPnfd/4eLS+wRJMcqXNw9T6O4Vk7a3v3HbTUg6qtD//0RmRBv4b2tLu0/
 m9FwYGE3CHK9Gn62As/aX1MRcMHMTXDDS7w1fgOezub8G2EyvggK+07WqZ98AJAv
 dsnB5rfOcUsAZUySRBUo9OUoj5sa9lvX3MkZVCg4dgXUz5JthFNDoCqTsUhdZr+J
 cB2wjyC7qiX+7wrFhlNlH9Pq9keyjjDkNs7Fbv2n87B8ige5+NHpCv3rx2Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26mpg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f85179263so9570301b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043540; x=1777648340;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWYw+eRhUplftgFXTQLL3PdOcEwv5KNZZwwyE3cFoUk=;
 b=a7UY4uPfzSva+VE+GbzsdVhZ/79ZZX9bs93sPKg/mK2ZZiVQ+afZXhabUr931DzgkJ
 fsDHj16Nm8SWNdYOgpUxuiw/fpviIILzfaZODpZEnODyuDlCLR+HoaI+DvwawpRRPGUh
 +vc30Zj0++P8K6vU5tcMRfb6vXHUZPKXFB+WQtxZCHrFng0/cWIH3l2voBWbxTcoJ1mP
 sbIIQxMpsljS9B0Kczp6ZGSvBEctWn7ysFVIQI/FOW7c675CGg5NUPjSijqmGmEB81ek
 x6zaJdV9KRkRs74MvrHmD3JqukV2AZKSFlvezdspnw4j5e4fd7OPmLj0RF46ITK4xZxX
 KRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043540; x=1777648340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWYw+eRhUplftgFXTQLL3PdOcEwv5KNZZwwyE3cFoUk=;
 b=GyfflyQvi/5Dp4YyAZXyDHX0jO9vIQCYJ5WhXONcKBXR6/5a7vRHq5zPQNtlt7hX/A
 wtcwIEId8uSs0n6ZS0L+Fk5TZ31JS5Qv834+DzYmjR62dX2w2a+DDwrN72va9Jd7IboW
 YXTV1wl/jbeV0BB3QCfsVGUgSW+ApQ7unYi9Oh9aRFN+Nd4BhdHNg4zPezsZyVcRRhWW
 KMNrEloihVHcgJeqa1vLpuKYGc92IfgSBkad2J4uIe+Z9CiBonZpV8bHsesWPyU1tsKB
 hYEuZ0mqB3lPgxD2kh5BZI6XUlxXm8R0r2Lplh7VMdaBeArwgMgCeZuETPHH9n4seKFY
 9qyA==
X-Gm-Message-State: AOJu0YyDMv7lFMKw5IVc0Vy0K18jA6aF2XDPe8thWjcMulzHXJuIGdH/
 U/ltflWueMFE94uFfqZho28Ftv9KDxe8ar8oq4RVG82aZ8/WHpnrnR9DsF1vuxD0q1PlNO6b4wh
 t2/WW47yhUMKdBAb1jB/hfbXKGdaQ3Y+wj0ztnCvDoA4A7WFZZDCmMFXfElvN0dOZGJsZw1NP8D
 Om+eE=
X-Gm-Gg: AeBDiev47n579HS66ZC0CFi2Gdisi1Wdjd0vLN772TYjYQ0OUvrgaf8i3PniElPK4lo
 +2E95iBYslDhx3L5NMkJF6OgglOD6alX7YFL8SfK/1FLhJz9F/PtcsuNEpsSRf0eqP8SaREW/4v
 3ab+49aic5VoPGW9+EwKq5xorey3opHQ0vL5ibgz1VSZ6QIGk8SzYT2vS4rKwaGM7iK6PL3GRac
 T2T0cEr1HOibKinN12YHE3QCyvHroLtgBTIoO8WeC2IfFzZ/4IwDvMydAhpXf2NeZmYwYRHYy5+
 t7l2s7Ydw6vgf2fo6kQ114/8Q5Cq81Mp4/9o0X2xItYgt3lzRwA5BjyAJLL3PCBBfaYblZSneG7
 bI3DrSq+CRpdcqTjvo7GjbJsaNMWh0Nn8zbkKPNac5bo=
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-82f9d21d516mr22394118b3a.9.1777043539487; 
 Fri, 24 Apr 2026 08:12:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-82f9d21d516mr22394074b3a.9.1777043538897; 
 Fri, 24 Apr 2026 08:12:18 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe68ebsm26965701b3a.47.2026.04.24.08.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:18 -0700 (PDT)
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
Subject: [PATCH v2 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Fri, 24 Apr 2026 08:10:47 -0700
Message-ID: <20260424151140.104093-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qqt4eP7Nke_DYYsdezNqv6ao_Cp1MiIg
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69eb8854 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=W-43u8CF5Pkpiqpb4b0A:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: qqt4eP7Nke_DYYsdezNqv6ao_Cp1MiIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX5uPWYlkZwoSi
 kYrR3KorJ6+9wb9EiZ3kGLI6IzmbktX6C7jrdp82RzltZpoPl5L+b+PBBbJHXesFJgxc64x/hxK
 d6UKXfvQd03bsadioy1IxmHq1NHYza84oHuCjgD3uOZCPDsmqxymsO/ZZHZ4t56Ah6PYHVSzYBa
 +KH31TkO0pa3xcp3T9SvCsCibrnQ7a0okH5IpVLI7mz6CnngvdFyPpEJJOgbda8ey/yB9wVNIyC
 TeV0RSNNfGxFTX1qm7zkEhFV9Pcsg7PoQJMMbSL9U0iM7RKlCOIm5XmK2qB/KcW2gRgcgYevmUy
 bVyJYy0sQu0sIX3orQKotCtPglRy+FwaL6aRkO8oXRkF2fjVmrACHhiMfD6wGDd8bgW0FXlhgIn
 eEZjwmSUOmtkssfb5gBklt6/vqGG+iO0Pi3z7bEVx625fyGf5iecrk9C7PMlDaGyVKBhtGjQzyC
 ILOOMlDYuoXj00IEkbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240147
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
index 8b9dcca8e051..6d0f8dcbe9b4 100644
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
2.53.0

