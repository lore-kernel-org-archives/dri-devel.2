Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035BDCD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D3B10F23B;
	Thu, 14 May 2026 13:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bB1NJuNy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GELDs8XC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9AE10F23A
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeWYw889456
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Rv3QXoFqyvR
 3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=; b=bB1NJuNyqhGZYoB2UByMtpH1iEq
 dvl2cWOj9TZpqH5wBD5+cVCo9lqPkWjpRmh3FFH2DO90NzLNyL0FTYoOPQOoTq1T
 vaZ/lYPdLe3fBvy6QIzf2eJgYuzitLmllS4c10+DwxOf+7r3yq2EMO5INynEHM0C
 gCgGYHh5eFwobxuPPoTFrrCiz1j1pvWwrFrgKzAnmoFSyjcFxk9FF7L9uqj0kC7q
 qgyHYPqX6RDsqO0nqCqu0vEqDjUCS6JfFk79yxhUA6x3D95E+Bk5EkdbMAsVwcV3
 US3CFuAtEOY/x5jayfrUehSiFmrQNGYAqm9WVI9O4VNfUErXFFd5ADGbJpA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjm3xr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83536dc3be5so8872534b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766878; x=1779371678;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv3QXoFqyvR3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=;
 b=GELDs8XCN1LQFQ7vogSsWu9kQ3cfWJMoUBjsb03HZaXPyKs7l2Sve35NRGequh1dXX
 pMI1UfDMOPhsatbw7Da6o0bf+Az9kXJt4UOo7RjTiypu9c5N2QkgJNAiOcHseKLV+NTs
 YuAutb70nnrKZHijlMSI5y2upLMwLk/lOszF2CIcCkdHiX1xqVSXLaZqKtV8qvP+ET0R
 E4ypn+Pz8IaqIX1jepICK2ZlVwuNrC+479YVnKumhw3lV7Kd0+1IKUI/CMUc+18R+Px0
 /Wr3u1AGBNKI62r8dvTrHMcDFN0yq72QWTsY5rXTUbm/GpoOn80t1rOYBX+7kDBFDgqS
 63OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766878; x=1779371678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rv3QXoFqyvR3pKOjjPZUAdbwE5pf1YjcLxou3Iv6008=;
 b=bEphUsf/sAgm415dyEoMUZaAWJoE0lAIYvZInXsa2SKmK1I1JlsWnxOgAUpiHHEvLd
 fixsQxVuYzY7VAIJDoIQXaqshRuCibnq3gDOVIlVXgK8unuSqp4zTCJxG0q05cIhCqKq
 U6l3mlb58mdisB5OiUpWRHwAly41CE2BKswT/AV4eMx2ouU7N0zvSyWJgYB37eslEcjc
 nXFYD/hxPybhIreuulOt9/fCsezqyC37SgTzh5H/exLNET2u7VRwJSHhyDRtOf3gohgx
 MQhbrWC3mwXcD4kvs/ghyaUJ/pal+3BVFm6LQBhz5c82bICBk3p8peyc8q6xGfZMF566
 g6Dg==
X-Gm-Message-State: AOJu0Ywo+QN3f466NBL3gURX8zkeKYYDl1mEy+sMJPswfJHiaA1TuLUt
 DlMp3VNrbXXSZ3JYuZxpjN7OfQnrE5aOZiMZE+gt//9E42OewpbYVi07fXKoDTfhweEt0p0SsDG
 gXv1cK347VlDdJbQYnQIMspm7TSjKhLLB8DckwBj185JsvBK+ECGlRIhTf8z4DzypLO6eKfHjnu
 MP3e4=
X-Gm-Gg: Acq92OGIymvDeveIjnWk9U0AyyAN1zaR9JsQG7OG6UjC5tuxeCnmRUTRySxynHbymH8
 oRysb1NOfejSrIzxoHBtNunnWIiwCBg73KAColKLo4Ndm3YOCLebtCXRBLFEiJ5qlwyhPU3I5fC
 ghhHWTNbh3ug7PwHiZPclsnLuJdNyMzGyX3eWXfi3MuFz1iewdYKbor7crON+lZMtQbd3lzq/sv
 2OQieRY02ksOZp+M1IOjPKbz5WW21CwM0savKRLNcItQs6cTHAQdsubW/65tBZrXKFTgfKCVRCZ
 nnYTcXsO1XBAsYT6ZCxsAn0NaKZPHp0RINSW67Rh9LL9YqH8vk8chq7hFLn5xaC26ETHS5K/oKt
 mbcHejAnl/KZX8Fq4tbB0HqtKsOP5JPcp
X-Received: by 2002:a05:6a00:44c6:b0:83a:7516:5be0 with SMTP id
 d2e1a72fcca58-83f05bfdfa7mr7252557b3a.50.1778766877708; 
 Thu, 14 May 2026 06:54:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:44c6:b0:83a:7516:5be0 with SMTP id
 d2e1a72fcca58-83f05bfdfa7mr7252531b3a.50.1778766877167; 
 Thu, 14 May 2026 06:54:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c020sm2828875b3a.30.2026.05.14.06.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:36 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Thu, 14 May 2026 06:40:00 -0700
Message-ID: <20260514134052.361771-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: szTrNR31s44lew4i-xaDB_MlSnO4tIWq
X-Proofpoint-ORIG-GUID: szTrNR31s44lew4i-xaDB_MlSnO4tIWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfXxaMZ+qZl8I1l
 0VMsG0rkkSEz7EsSvdsLdi9UQRVdkHYYvLnf+bvxYqfnm5HS8hctmoqbsJVjUncr8DsH2D5DsF0
 q28TBTog/SGaKMUf2QqROW+jCLoY17ZzRn4T++BltWR8sKOg+dvqgBPG4nvD8NrJW2N8q2pkgiB
 1AH1FpPwA39ai0oe/qYdvhpRNKjzhFaTGvPuCp14yvpe2Ie/hf8X7DHepkWLd+TVlGxNGwXhNQO
 IErWoZlVLSpu1rLyabHVpZUtQzpGhxywIS5UPLZ05WWJGLo6+5/I3ZR5qopxj7086ttT9wWQ9g9
 1PPJkTDLO/M9y4sRd66BPETncMrHuOQzFiBh7H6fOOKc3yqUY2fqqTEYL2WgsQQD6k9kQkNHZaI
 j5/dLmaorTLm1y7Y7E4Twp/R5iIbC+GGRz9c0koEsVzLsJmf9Hd/FbajERFpkVuzDlY+xp7rOCp
 DwAaZTQX/VwY58/yv8A==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a05d41f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-43u8CF5Pkpiqpb4b0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140140
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

