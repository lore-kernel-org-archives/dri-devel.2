Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385FBCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816CC10E783;
	Mon, 11 May 2026 13:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kba+iOcb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/JMpjot";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B7010E780
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9CmGS017378
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pm60+sSzy2D
 4YjgbnRdHOk9v8JwHh3XA05bqfGtoLS4=; b=Kba+iOcbBg5luoBp8cdSa4Ey2Xe
 Fa12cRjV29NpXOGOVn2X9C+u65gBQJH9dJE06KaEuNTcHpJg0WPRiSR4B1CXi0VD
 mi98KnN4xlZyLINsTVuFqzsZ5wiMxe48aaIUTWOYm4Q/ciYE4q/5H3WoUaexYe7H
 LOKSGSdA7vifxaRWrtv95s54px3HjSNtboK/iOVn5M7nY514M/lMPZm19oScjNsJ
 ligQ+v5porG8Hzdfe29vrIvpBXzP/FYsPAPvw0MqPozWrdd3R/tMA51rwGOqo18k
 Foe0+sp7pfOC4PZIbjXf+EYMBtyRr9t7kK1HAvtu/0ealpdlbpsgTqPxWRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfssuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3662e7756f0so2988365a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504498; x=1779109298;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pm60+sSzy2D4YjgbnRdHOk9v8JwHh3XA05bqfGtoLS4=;
 b=Z/JMpjotvxULfeMAuJNccg3R0FJIeoa+XlH7vQ4Bu8KRKvASrQwRvBOas21Nj78Pvn
 nrgqqggMN8/KFE3Qv/7a9Rh1uZMkk82g6BUJguKcOI9neApB6lKA/wnUz9ELQef0Imgt
 BEmb8T0SLcP1Lvv82uzw70lrY73ArdyK7WOsdFLeHVSYgTurD7xbWqhnEeeJ9W337K9D
 lu329pbTwJtFVTkXc/C9oMBUE1f0LXkdFJ6XtueEUqXSVrIISoGn1NHSQ4h6Yen0d5sN
 q1S6MatREWcry9lmZIC9/8dUycTlLbWtNKYO0L4cCevcGTfRbMxi6J5ZgfK7QiQbfeEv
 m3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504498; x=1779109298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pm60+sSzy2D4YjgbnRdHOk9v8JwHh3XA05bqfGtoLS4=;
 b=D9Tf3L0hnwlcS2k65tIc8FbyQnmYT3W2ejYMTm/pacePaMuBJMYd4G/mwHHSDsAgGq
 O+A+8Ca+X3YrTjOY6h6gQlqJSq9xcHfe5sX6HWIZcy6nuAH1s5Geie2d6zl+M1gdytvh
 YruVhwBVfTe7BEve2qQUNoXcJzlZ6k33leJxP+OQ0/ETCWiCzzP70ntNTLr+grMybivM
 aUXIMuitUEGDcjod9714ApFjB7Pv3gXDUncjVgFwbnaFDr8TuTKCPmObD6LkugZcNN/Z
 OiubAw0mZOykEg/YFjWlTHoNC6HEd/6G2XTLohQE8qwronGyl0G81wE/zDueCLroJUjw
 KV6g==
X-Gm-Message-State: AOJu0YwORpJY3YMBeUfCBYJjwy+7z5eXHX7/yBc/TOaTuJn5DXIPNsYQ
 Cg/oV18kLgObem9P07dA8bS8VRPu4wZwLJF38UYrQH1XKksNECK5J4o5cZEzU95Cv1QLWlUg7gY
 d39iofVfEVRCn4Q4CXfoN6wo0x/NXC/QdSw9ZjfvNz3+iL8zLHnOqvXfER1jS5qRgykJ8IRhZ8Y
 DaJao=
X-Gm-Gg: Acq92OE65hEc3fzeKM674lwfq2TEZJGYSDknHoUL8cJif25axGD7AVLG+xQ8d7tMzVW
 x8Voutq/3a4TyWrp5rOCM+HHDZwuGfD0NIIzDb2Rxg41W2CBivmvC5W41fmA48CQpYiewDOettQ
 DvzPOUj6P/c0fL0RKbJk5pMSFW9sHy3Ak26JM23eJcBULU/m/blzwe2GLyFacTTLBsw8FoIq+lx
 52Ij3pYwH7dUwsMQLrMV3mJYAc0oxCBj3bfrD9/NAlR6lScTc7m00mV0aPR/JlANgUhlTF9G93D
 CFkhUTolPryyxl5MgOOJR77QOomOQQilucgyUlhsKaAxeCv0Dm6Xc1n/vHsbRZV0GFFuKd6BN0t
 onHUqgEbiInPm56dvQEt5pk+E7bEnnC/r
X-Received: by 2002:a17:90b:5788:b0:368:433:b697 with SMTP id
 98e67ed59e1d1-3680433ec4cmr7342486a91.19.1778504497588; 
 Mon, 11 May 2026 06:01:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5788:b0:368:433:b697 with SMTP id
 98e67ed59e1d1-3680433ec4cmr7342350a91.19.1778504496698; 
 Mon, 11 May 2026 06:01:36 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d63e03f6sm8293092a91.12.2026.05.11.06.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:36 -0700 (PDT)
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
Subject: [PATCH v5 16/16] drm/msm/a6xx: Allow IFPC with perfcntr stream
Date: Mon, 11 May 2026 05:59:29 -0700
Message-ID: <20260511130017.96867-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a01d332 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=5obZvuzjGUYrwyXX1KsA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: RdQ2GETRDVsFeu_nYi3mRNdboT67viP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX8bzUJoXLAWcB
 FOhkI06whx+PbZ7AE5MU9rlW1ED+hpIsvzX8zEWs00TvK78M3mNQ0+/QWt6n83cbzUc5grXaO9h
 dkTtT/QsyGzKrrN/XtEq2Lf5+HEPRw/FPfbCacPv/77heufIPBuZ1hxVzCKgt59yrec/L7IDCBR
 CWd495JOSr4qF09fSfPwpciD36W1A3EA6KRGtcktv/H+tTwpgJyfiLLRhcpeIBFVtYKlKPrtr9+
 0I8IRAhUP7IvYBvBvawzlN8JqwSElrsaHbhFvS4zTCcfY0+unMqIC0cXAkGngjOIZup5SjnogNZ
 llglYvAsrPYOL1F47MVY0UkJ4VpSQbP6Q6xgG0rRss7gUI4oPpnIWcMboAdghsv+e1WqKG/o3/8
 1bKM9HzSNDWxJypJdSas/SxZn/mTiJLC+F5iDQsO1FBPFavSL7FnXdz33cQBMfwS8Ln10B9UbQJ
 CaMz4jAlsx73vUIVwIw==
X-Proofpoint-ORIG-GUID: RdQ2GETRDVsFeu_nYi3mRNdboT67viP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110144
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
index 64f788e4c95e..f06a51d1d25a 100644
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

