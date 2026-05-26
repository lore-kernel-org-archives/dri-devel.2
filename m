Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F9CD6E40
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8763010E6DF;
	Tue, 26 May 2026 14:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KSWXJ4sn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0o0LrZV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B8510E6DF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:14 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsNXm2705396
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=haIOTU+oqzF
 6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=; b=KSWXJ4snS0k7eaYIpdVP6XB5phT
 q+3aGXOfv0IH4DtmD30TJ5nmcmXLsKp+DAzdIJgKQX7a89a27Pm9QvVyNCSEceo7
 mIpknnpjPYPat+mfvhhCrBGcIKDYeQ00Ho+M8kBMrGmC7VE7oxW0dEOSp1MLvJRk
 MbH9GNBQhH7qs9Llgu544ffOQXr9zyxQZ2ZSabYXCBAYVKWj/62sHU6CXG27MCQI
 8ZJT4T8xkjV7qabkDYHL0ajjsodLcv7FJHtxTyD5+NRfazSUn6pbpQWC0ukEEXH/
 09CZm3JqR7IDQ2bagyFa+CUCaJNy3dxVwKWPTBOSLt6fYVHnxn6nJsrniyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5vgje9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2be9e0905a9so69633035ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807253; x=1780412053;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=I0o0LrZV/kJxBrcwj8tn8zPIygR19P+F6YSd/2rzbDJYWYFmyBqKmB0qzieLCvnmZJ
 35YAaS4stbAJCSINGQpbNkNoBMqlDoJjHViMjhkhcEpgfE4x7Xx+zLsC70ARRWxDbKyV
 iHH9BO3PHV4+7aZwPhABGmRllZo46lLRJjNhEhegQx47bLFr6pcXVptYaoGI38p8hlbK
 FNeSWreRtqN3FjlBCDooa01MNswrIFBIJCAtyxB1b10+qadH9KavrPotyheTr60KA0sO
 D2fJ9cMw9fwKbyEhEypnnox/mKZoC/AXQUPHTMNJ5BDJft2dqzBOS6YoNmMdx6AbAeth
 igrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807253; x=1780412053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haIOTU+oqzF6UOOcaNNvH3Tb0Jkuoae2P6GBfreAHDE=;
 b=TY7ra3CZ4MfSmC6Zgo0POHQQSurGFNFiUE3DoXtaOg8DWDLCLqwuykuylOHc994sh0
 CoentKNKtmBwSyxeYpBWkNBP/S97vVVflYMgpzWybhveOxozhXU/tZidS4/OK9iEo1j7
 X+JqdubMyF0WnbFPYYcJoyOngKP9WlznH1k1Q2oDXbusQiKNeVJ6SUHaUPoTg/SBfz32
 yMY6krGMWcOJW2En7OQa+dM45s14MicjV/0l7DkojxK8XpCOOBgqD1ggxJdsYbIehKY4
 lv382UOl+ez9B9Pgur2datoBIhYFgQ/+pyDzQVdibyGIqoiaO9X4IXpn1yXTz24iWs/7
 FrUQ==
X-Gm-Message-State: AOJu0YxSV6zZQb0wBdbXNqH6DXuRp4V8QlywD/Ys1JuqZ+ePBdE/7URJ
 pAuD1+KngsH6vgYOTpHCv5c6gQDiLIE+3v8OYrNNUSJUO7WF2O+oIPzW205YzuWQju8sYHMMi/7
 Fu0Yi+8ud/I4HjAZ5IlMn9Pj7/kGwE9Ajj6l3NHQtVCh/YVH477nkku0d1frhoP+y1PLrVGtiVB
 do+sw=
X-Gm-Gg: Acq92OFFIrvrHl++ck7AAm6Lq0lSKrZ6/C9eTgelED+m0TwC15e6WbdGQS21HAZbcqn
 QseKi2Go256IWDkAPJ8/pU2RzH1MnVKLDXEsBBUI+oafKb8uBQIfRUJrhCwQdzn7At67R5sTXJ1
 RbjgPhsGujYnG9IVZMApIEN+1nDuu47WY17AXkPV7lZZHrNKw4RzVNAiMNbnB/8YknyBCJcHwCq
 iHiuWKxQJ/mKK8l807d/h9JwQEUVty1o7CuID8DY3WgWJceh5sCaVaun62WUh8FUcQrHoQTVmRn
 /uPS3t6nXn8Xic3cFk9xVJ0bFyOKUErAysYxua9hiNaYE/pKrInTVt+OsU0W69r8QjvI494tBQ+
 95TV4hiAS3hBdMcqxXjPQXR5aWwu4fj2N
X-Received: by 2002:a17:902:db07:b0:2b4:5b82:a8e3 with SMTP id
 d9443c01a7336-2beb0631a36mr211003505ad.24.1779807252885; 
 Tue, 26 May 2026 07:54:12 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2b4:5b82:a8e3 with SMTP id
 d9443c01a7336-2beb0631a36mr211003055ad.24.1779807252363; 
 Tue, 26 May 2026 07:54:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695c92sm129205235ad.7.2026.05.26.07.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:12 -0700 (PDT)
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
Subject: [PATCH v10 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Tue, 26 May 2026 07:50:42 -0700
Message-ID: <20260526145137.160554-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IrYutr/g c=1 sm=1 tr=0 ts=6a15b415 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=7a4_7rcHm0II5uOVc2AA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: _jY9N6yOpB8ZRjLgf6ly-OXWuHT9eUVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX9xKf5ZBpyI+F
 OXRqZB6qtd0d8payebcJZ2bwOH+UkoiLnM5gOr+z2KCJEFn4nLeneExy9U/RIDrTClKtMQ5XxxK
 RMiA/qYcKJ0LDHPCAbGTQZ4HNPdUn5Jx4RX+jTr+yuGSL59ip4lPuqAZxY5b5KDf3SeG6PWXYsF
 7ac8ZV+WH+Onf0sIYAVIuPgMXk/XEMEPP5ubXEl1N0nR7VcA3ku9HHZcKncVVW1uCxxb1al3coZ
 fObn0YsGDae5eQ71fEAt+uD+VrDO3WwmcgpiqN5d/onGRXB3N/TlpN1iXDf3W58wy7jQkDQHXiO
 vgW3p9Iyhl1bwu5gMecTM5Z3K6c7MFLBkwk/IRBlAzr0Km7Aa0tq4C0K+62w4Tx5/JdSXVv2Evv
 RmigtnRWFwZ5Pf1oRpnPpaSznDKuh7a0JljdCfOwGe/4FdzngZnIVcsUPgNJW4PQ5Dccd0lCsoO
 vu69kinmsFrsNwwp0RA==
X-Proofpoint-GUID: _jY9N6yOpB8ZRjLgf6ly-OXWuHT9eUVs
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

