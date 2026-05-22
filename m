Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF503CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F4F10F6E1;
	Fri, 22 May 2026 17:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0WE89Y0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TI20BB3V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B635410F6DF
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MB3Acr777951
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=haIOTU+oqzF
 6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=; b=o0WE89Y0N4cXWwG9+egXbmEMtfz
 5cnR4nzOmy0nwcHrqQIz62kAV8JCIZGZq4kfoDVReFhzR5G8M+Px0H3zAcQK90ps
 OYOgaOfR39c9ZDf5rQZhiA5Hsc4+1gdyIH42ZXkVVVaz58DmjhqIzNqvTPP9maFT
 JN6VucUKtBjaf5MnsfhnPSPszW2/tmGhx8K3nnz3lW9eLyurX6L8+M6swG2hcTC2
 nD7lbXg9v5YPBUJ3xkbmKBBxzS/F4jR9sjrP6wQ3seSqgRFokEgQhOLVESUBXiAm
 /xpkAmtYQ0ZbgCslJAqOMPERJZPcWrKdMLZpsQbhRHNdDhMjzkJ/yOjLInw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h4nta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-367cb6de61aso13622494a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471291; x=1780076091;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=TI20BB3V/hZ4khR+t2IIBjB5zzFoqwY5yv2GzmwAYQGhOKy1ln+ypvEXCnCkiu5BAJ
 yaY14bEoxzAyl5TPomW3OCyGsYqEq0OqCGsu8TeR316SQuSunipEO8V6Ug3gGXJTiguO
 KkUsoQLfkyDDPcA7zd54RpYP0rOc+Q6vZPiURVoLlVpU5dRe/gpeG3w8cVXF073fXeJZ
 O9z2qvfnDWPxOeSsmAespzUfkv9T79TmJDct/5NC3ZaCmp98KATAjmzctE0GRUx/sRAR
 Cx929xANzMEYTVNbfVBmHy+NUJIDRDrM4KigGN+pKwW6wF2GgSUkMdR9d5RLvpTOeTV2
 HAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471291; x=1780076091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=PWLlqrKzFSr5EQxTREj8g/9NE0GGYHAn3msZ8zG8niGFw7y37aEZvI//1swGKT3w9O
 EUw/8/GkaTICUnI0Q86g0R/7k0cnCqjEf2yb3K+2DnCG9F0PMFPgqu+42WzUl9tFA2mP
 t6LAvkFuCxpIsPE/egMOlgcZYvD4wOL1lgrOJXROKw+RdERHmb7QhReIWo/ajc6un4TL
 h7EHAB0fvy/3qod2ugthZlnyf4goo95VVyeEabyTX6uYjsEQ25hI8wKNKfc/XSTqKrtw
 VDJksAG3QpFc+kIBxhFV7d9kjkRvz7VN0nyrKfFo+FCfX6vRO2W4sovvNWwy/ALRwgVs
 MDIg==
X-Gm-Message-State: AOJu0Yy01g7Rxhpgk5dKrOdExzfhKgKnVI7ymHUdGQCCSG3ZzytVR3aq
 Lsa00IwWlegDJG4Hpw2T1wqNlvrhfOE+NQAdHF+HMHqXWc8367Na4HzxB4I4zuH8hr3BX6a6n8n
 Ggp2lXl74LzWzy7D9gdWO9kJ2/srZ9JYFDu+tq/WIYZMqbJzk0g3mJtY1dyy/m/6AW1SFyNbXj9
 bDpwM=
X-Gm-Gg: Acq92OHH4yHqU7JHBVyTiqb689xhKmcXT6khH47h5MKoPJVkfyAr5vJla/m2IQuEood
 IWjB3C3Kq2EpfzGSpO+HG/mTxHYzktQt8J2BENRs0FXx/fSp3ZXAfbjeEQpEWcuD0YUiyv+Kj1l
 H+JRm5NYuDVE8g0byjBkm233lX2p15vJRVN1/brQD3A6E5y3SW7lt0Qesdcqy6z2S3uhZkSmisO
 sM7MsUC2Fi+DwhgEEExdVcR2AvfeRSgEi6E9T/f4EONnLEwVerOZ93R5aNrtP0HtUGcUYyXmYCv
 LzGSLbkcUODpzOPPoGE6o//LRWVERNgbn+DuMHcNdycXl7JtS2vsEEyndZQGEB0KybfnSuMIAll
 P42qhQDU5g2ICIBscPtjKbJ2/E9VYIByCZaPBThx9BIg=
X-Received: by 2002:a17:90b:1b07:b0:369:69f8:ad6b with SMTP id
 98e67ed59e1d1-36a674bb035mr4847407a91.0.1779471290754; 
 Fri, 22 May 2026 10:34:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1b07:b0:369:69f8:ad6b with SMTP id
 98e67ed59e1d1-36a674bb035mr4847370a91.0.1779471290306; 
 Fri, 22 May 2026 10:34:50 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7263179bsm2495948a91.1.2026.05.22.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Fri, 22 May 2026 10:32:54 -0700
Message-ID: <20260522173349.55491-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: H4rtyJelUqXuVYJTCBR66_eXlIc6QO3i
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a1093bb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=7a4_7rcHm0II5uOVc2AA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: H4rtyJelUqXuVYJTCBR66_eXlIc6QO3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfXxLwO2xm7V03H
 IS9E1EjhH/+hYqcghjlQja4OR58+QIN5wpbxoAeiJzxUoCAB5x2j9NScdQeGfi41yeEJC+Ork0t
 qttNF4bLZI9GkTB/pL38ptjs1Mr8vyLNWTfMqwFZAsaoG0W0LkDCZLrZexeW1mOn8RgaTfvsw0R
 Ul2eaPbOknCJW/Zn/VgkLSWMegIHQPwDWxWsMgKvmqMGNtey7AEj+cW+uacEGKd6mnPjvTVIqOo
 Y+dHowSsQSB09lRvg6yHCx+PaDHxAOBKv70/bSANX3c6osyJzfk0ijuyINSOz1GORny0ulzTk2F
 4GzyLqAQR0dVTl+RlEndy0zdHYtCmRADFH8P5jI/9crjVkDdeTDgnRM9mdwGuLRsRitWSUeFKvY
 Cku+qRU12N1VznvTPHKFLu/K2V5PRLaRjFNZGhb1wFblwda9ykoKtFDtOoo02R3no8YAwHgIZ6O
 sdvFLsq8cqCXUWM8XqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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

It's a common pattern, needing to insert a yield packet before flushing
the rb.  And we'll need this once again for configuring perfcntr SEL
regs.  So add a helper.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 +++++++++++++--------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 +----
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 71f54ab5425d..415902f6e5d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -189,6 +189,30 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 }
 
+void
+a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	/* If preemption is enabled */
+	if (gpu->nr_rings > 1) {
+		/* Yield the floor on command completion */
+		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
+
+		/*
+		 * If dword[2:1] are non zero, they specify an address for
+		 * the CP to write the value of dword[3] to on preemption
+		 * complete. Write 0 to skip the write
+		 */
+		OUT_RING(ring, 0x00);
+		OUT_RING(ring, 0x00);
+		/* Data value - not used if the address above is 0 */
+		OUT_RING(ring, 0x01);
+		/* generate interrupt on preemption completion */
+		OUT_RING(ring, 0x00);
+	}
+
+	a6xx_flush(gpu, ring);
+}
+
 static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 		u64 iova)
 {
@@ -597,28 +621,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_PKT7(ring, CP_SET_MARKER, 1);
 	OUT_RING(ring, 0x100); /* IFPC enable */
 
-	/* If preemption is enabled */
-	if (gpu->nr_rings > 1) {
-		/* Yield the floor on command completion */
-		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-
-		/*
-		 * If dword[2:1] are non zero, they specify an address for
-		 * the CP to write the value of dword[3] to on preemption
-		 * complete. Write 0 to skip the write
-		 */
-		OUT_RING(ring, 0x00);
-		OUT_RING(ring, 0x00);
-		/* Data value - not used if the address above is 0 */
-		OUT_RING(ring, 0x01);
-		/* generate interrupt on preemption completion */
-		OUT_RING(ring, 0x00);
-	}
-
-
 	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
 	if (adreno_is_a8xx(adreno_gpu))
@@ -958,15 +963,7 @@ static int a7xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eb431e5e00b1..99c3e55f5ca8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -317,6 +317,7 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
 void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
 int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
 void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e022c9a162a4..124d315b2469 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -488,15 +488,7 @@ static int a8xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
-- 
2.54.0

