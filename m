Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178D9CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCDD10F0ED;
	Wed, 20 May 2026 16:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uq5Updeg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHinh78P";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41BB10F024
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:33 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCe2Bk316416
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=haIOTU+oqzF
 6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=; b=Uq5UpdegcJAADhzOglpaWbi6Vxi
 iDsNJqvYO06wpxExMvMDPsa5aGx3O6uillApvrr46Qo7cJwhWFnHBxldYgFYNgKJ
 yj0m3tPmrqPPxJIJmnHwD86QUw1I70ow3OUxbZdCnc+08DqnX97W1I4BEi1B3Jqx
 E7rO1BfdTnoE5nWkWBrcIWwaZlTi6uJguSKRaD+Y6d8wpfJdwjly6q1mRw6ovzzA
 IoLWJxsMHat+HwzOWhFbgAy95yFe4OBW7XzhnzrCm8MuMXalKZb363wCLoN0Sau/
 5mFSoIWnreXcEdnQssEBo3W2DwAXp5YUNscBzIC933dyOkHscEd1iuMVrUQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qrxsx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8292a9605aso2482139a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294332; x=1779899132;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=VHinh78Pq8lTpbUpzZzGnAzM6lHY2wlZODT9N3mWVjJavY3xcZiXKDAtzjtNL4ZbVR
 wTHvc+N0EN7OBWzpaTBZAh3+pLGWlZlnFBBgkGj4ykA6gq28YkeTEOBG74RRs16/mV5U
 dSO2mLNFiHub96fCS5ALebQMCv5nXSB7JZex2LtBWyLslawoDE3FbyGa3aMeOoTYBvY/
 KlIDEZYBEKRIy569lj2dL+Q8rsdCAJ1Uy0PwnS3Lg7Ja1zeph4iYevdocsh8KN8Dd68+
 aLdGEKJqmqFJz6maNiJzsrYF73MFP62xzwyTInuwjend/xAki3lCDvllxZN5XSrUVRHn
 ESGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294332; x=1779899132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=DW6HropwTohA7aHFQ9Z8+X5h1udgfVLoDcoEp2Lu0g4mjmGCPsGdTpoUVnY7gfScre
 LK5Uf675o7iyQB1lIDIP6WDjVrZ26skwBLNmJBgqgO6XQjerNIg7rLdMgU4ieX2OtfI1
 NvHuXnBfIHBtBz67w8M1qsCafSPxERkcMTboDIKbWiQ1QGZi4/FgCPZjx3iCuS7LqUVh
 UAQcPBhQbKGmM8NyCFHkOcwlSZW2BBcHyr6C1QMewE2QGPltTf5NxmCYOKkeoVT9vY9K
 P8C41uL0E7532klDxr62GRiY6DQDRbx1B4elz5b89tFB9meDF3xOiXydm3DrImCCSURS
 WIiw==
X-Gm-Message-State: AOJu0Yzrw6Uq8LOfU9mJxEhDIvw13pNc+fw9hweGJuN48EhFoZsXExrq
 hc4zSJG1NdiG+5141fiHj0/uim7O4QxkGxjHK7iPJsrBKvD42VowO3Y8igGIqisfDt9vAPZc5z4
 3L7xB+b4puO5tci37go6NS7Dlav3n2RvvqGEQp6i0ObL2dio/3SUuct56cKwIAubvj/FhuZ/0y/
 Sw4Po=
X-Gm-Gg: Acq92OFs84+CrzgDHW3yOPt3Rm/Qd4DqiU1478MdR/UhPkmQJRyea9A5BByuxcVkWGu
 pDA4G7EQ8a3nH+FCsokRJXRvSKJflqG1ZZqkxhwiV4B4mhKT0Do0ThePStJ25zRSSW7jmxIxWgX
 ckbWuPq1zhxRU1er0CD+HGPrdenP5xZRLuovbvURV534uK8dB98yCMNGIrP9ykZPQOGdEWIlvE1
 9EmsIef5N1ZwFb2yiBBJcmLA4nneeXetZnztpXwJED5m3AiSpsO2cNjgR6IyOOPfJMaMM9N+1YX
 qdC5zhQoRbW0nV47VdWJQ4840W3EjKM+UhdoNaczgTajfHSA2/MBYlR2VisVzgShHUheFdCnjh3
 hWMtlnlccPVZnYwdjjNQwgnqlE5Wu8D8S
X-Received: by 2002:a05:6a20:6a03:b0:3a2:bd1d:d684 with SMTP id
 adf61e73a8af0-3b22ebd373cmr25978997637.33.1779294331792; 
 Wed, 20 May 2026 09:25:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a03:b0:3a2:bd1d:d684 with SMTP id
 adf61e73a8af0-3b22ebd373cmr25978928637.33.1779294331141; 
 Wed, 20 May 2026 09:25:31 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm19781102a12.3.2026.05.20.09.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:30 -0700 (PDT)
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
Subject: [PATCH v8 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Wed, 20 May 2026 09:23:55 -0700
Message-ID: <20260520162454.18391-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX08jfnX4S+LBe
 BL2wjUFxo/6F3OUeIfvcS8WtZcf316CTuI+0V1J6STVUqjMnq+UxrHKDUJV9yhk45jdqbFlvYcM
 nZ1P3WX8CkD82Xdb3rAMGn94/+c1WdPkT/pbryTDbNDtm0LZDLvLhfX9HAptqm5H/FZ7EKqei2V
 FZfAkadoc/iw8Mk1cP9ZyDJQu18uw0uHQcuHHyjgDa/tNhWOx2tMCW9W/xCmm+GxXSQBjjEAgAM
 vL+wTvyrAxwB8TFH2HL6ZUnDXFaiphdfxdw/lLAnp5LXUB+YNy2oMsvpInzOzfpOpqJANvBB5PT
 s7wSrpZ07hbL7r63y3YD/O8O7/OAms7582t6WL6ny0TP+3MrTJqocnfpHsvIRQlmLTvHvkpPeZ2
 NLR79zCHC7M94++cJ0UUTET9nDFenU1xL28NsEl8L5t6Rw9a4OflgH3PwmZaz51aIaw0QmxqHOQ
 5cks8GVQVYAQHHcErng==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0de07c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=7a4_7rcHm0II5uOVc2AA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: fL8s_May-cfwNSPerfCfQUoAzazgLZNY
X-Proofpoint-ORIG-GUID: fL8s_May-cfwNSPerfCfQUoAzazgLZNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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

