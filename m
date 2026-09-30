Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D11CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A61D10F403;
	Wed, 30 Sep 2026 13:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="peJ03wPR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DilBu8ps";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC4C10F40C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:56 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8MVG2898230
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=; b=peJ03wPRAJtbDZGm
 kt7yP0NhIl8GP6lT/NBxKbW4cypAeK9qqfurVszXhEOzw2vFIFS1JTDQpbe3v6Hb
 FGofqCVExAcLStLydz5/jCQ4oWMsY5db3Oxe+SqvIUZV9wWLEcJAiawWOg7ZnJnE
 HebIy/L4iquLbObTl9Ky3Gu8YsibeZVcCxip0Kqw2IAQoePGYu9w7wQySggVKgzA
 ioFCN+1j5P/FdfdqdkRYRUzFX/naZvJRhezc+fl8aZKRgn2BSMrjY9H5EtNsn6vD
 4/5hLqsHUDxpKcEBpKw3EHELSoNYWOebSWR9RcBzdRAtl5eyGCBkmO1c4Bl1mvD7
 qYOYpw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn2gdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:55 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-988d79b90e6so18554241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790775415; x=1791380215;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=;
 b=DilBu8psvk8RQuE9MawxJM7WwEJRzm6sSBIWnq3HlHTcykqRYYkaF6ZgS19UWcV1l8
 y/Ps8xXUCEgV8i1A4HQ8/b8hTGy7F1kpLh1iteoa0p77qiVD+eSA2PzAkrI0LdLsB6I2
 frek5t0NXPIzhHd06vK4pi/WWY+ncUepPP7i1QhJG+NkmInm8rXtNFAbrTNvVSo0DYos
 DT0fUUUcU0XCXb8KM2UDya/yWmoZjVO5mtTWDaJOSlolx5wq6vCiMjClmby4rlKbjl8Z
 tHM5p50nu1bowQ6OfZ+/1foUskfmYpnISiUazberfBeeURP44g/EskWGD2t9Uirn7Z8v
 bgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775415; x=1791380215;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VOZvv3gRAV4Yfr/2IAD8LT6d/JrOTz4oDcixnCJZyHI=;
 b=jLkQBoTl3FTorwTkNRzp6Z0gCae9wpOVbaKUM/WZGx7qt35K2jWHCx38tNQfv8VXCM
 shAylhEal5YhNrhTnO2lqecGGBFqKh4QsoMAgdndfsQZvFhKTbEt0+Szc+0bqfOvL8tu
 lzWUI8dN32kFrOMUsNW7LvZwXF9xeo0nJGNT0VjSNRIPUEc+E202Kc/8A+SMoXar8E/q
 DyhdNN+sXotpGmwfhUzqme2qgN9RwYWL4RqDAj3KbNORzv0gKjuGoeErg6m3yA4wHL0i
 zer9D9BO01B8SjBk8x8LDYD7j6gbzocmOSR2+VEYy8sAa7QfCvw3nWJOIxSBZOFl3iV9
 DsiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtXCn8BfQF/V6GLEbDyOzZHJaWxOiyN7WT+jqQ3oJyCtjMl80++aakbAV9+G2vciw5YgZNwZT0YdE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIi1X4PSZOPLTOOepfNcLkCGje2C6eiFOpO126tglnvP7pW8I+B
 nmyDePzMloTQGTjsAFZriHlX0ICV8DpRoP2GUfcStTAwg6+UNkP5129K09uGHsifD6nHstVzA02
 ZivGNiLgoeX4ZV///oeCHZ9kmG4Oi61WUUYKYbnuGyYMi0DvvzDIIEZpRTVxfLPmQvJDMbRc=
X-Gm-Gg: AYBFou2nQWJeqnVEWQhlK1GQd77dV8uvYnN/1qyz23kLYoHo7sSbTQf9D04XWcY9fyv
 o0LmRn3qRtjJK8iMy3HQD0+XudG+kEIbvuJSWSMaaAJViPnUg+AcH4/GFuT+vQvx2XSiRHwleNV
 eriUEY9LLlIF0U4WrHR2JekF+ogZB9GZSQ+FsMwvj69o6pJ2D4ICSGfcBgTTByhyUBLqUo7FGRo
 6d6D/Pb65bRdqlhNxUpdjqk/vjLQCAdXy+Tf5Md2Pg4jwU7yhTxRLE/utXOYwGTwioTwyHqJTeg
 woOeW5mNkHeJa0PD9/UqCrGBI6sPcgmJ+qnZ+IGZaZ70YutDo+Q8Kvzm8Uk3UmzJOmHl00zOw4e
 Q6u4RnF+xT/+8gTARH6La0Zr6qaIFs0kCKvB+JDmEEL6QHLI5joURtiuLviTFp7bSZ2tRJiV51x
 4hdaRFdM6WXGCs
X-Received: by 2002:a05:6102:8097:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7be72ab7b3emr293640137.11.1790775414822; 
 Wed, 30 Sep 2026 06:36:54 -0700 (PDT)
X-Received: by 2002:a05:6102:8097:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7be72ab7b3emr293615137.11.1790775414195; 
 Wed, 30 Sep 2026 06:36:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbfb582sm356731e87.57.2026.09.30.06.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:36:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 16:36:48 +0300
Subject: [PATCH v2 3/3] drm/msm/a5xx: Add hangcheck progress detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-adreno-progress-v2-3-3882f0fcd7b4@oss.qualcomm.com>
References: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
In-Reply-To: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3387;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5j7e0HkNKk1PCIDPhYgV70i6SghClNSTMPq1qNiKRnY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqvRBvIk0vfYBZyCPpYepLk5T7fPnp9O3i3128F
 XQ3bhvbqn+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCar0QbwAKCRCLPIo+Aiko
 1WhWB/9IfBV7lWmh/j4E45WV3DyfcZEOXfz0L88TOvyOABUeFhTm8gMTHo3FIwsMy9tNlo9Gh25
 jHOp4GyLRYkouATi1FpQ5Z2plLVxmukXIXntRsMlT9OmfJ49fB3u/RlpEAisih6SGq/9vod4Xy7
 faqcQDdg+9b06dMbUIXUP5skmpu9OmRLtkurVCpSDPkvnjHKdCjwK1lcEbHp3YXvJGSzLp5PZa1
 7iZtlPziQVJrRkudQv+aA4BVyV2H7fLsqm+EkJDBUSNAsC4C+nX/smW+5cuOeFRdRhE8Syi/o4O
 VEPooo9qzfFX0D8pLzClj0Q9m+3ELIsWm3pa86p8SM2Reepn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd1078 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=8wNfRxjPmpLGpMwT6toA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: ZSnb09wTWZ88oyuFbv6Fb7zmHk2yddud
X-Proofpoint-GUID: ZSnb09wTWZ88oyuFbv6Fb7zmHk2yddud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX1xym9qNtm+7c
 IT8EEgcO4kZMkIW6NfZT9t5zsHonCvi0zDjQFmftuR7YzjTBV7spLjpWsxy8aYbOLfZXB8nx0E5
 S3At2KUZDT4pUBxCqH8+d5eVYBzbD8JD14wEX2MJ4VGodtdM32ql+Z3CImQduob63n8w/1i1rJ1
 IOzBzUDaCEG887QKjl+3sSCLsweWGg9VnXSYWDRY2cWN14ZPSE7aX+INiwTuKTnA4PkOfI+YgDF
 FGrQLWEM0COtMZybQgDkRWi5Dm6DsYXUbGdwj18P927R8l0oq06OyLQJmYMqAOlBhJnLU4n/kGb
 NEldptw0ZeCt1rOMipmyO1sEnETitjdX2j0hCW2j7PH32o/F0RFQfy81/ubwGyDdgAoBBpE8d8J
 tXBdpfihHSXfdWHeWeLSJ96UhaY4AWe8W5pdkJi/x0k5af974rIpy09v1PnUjvjM+bcyzdNiM6H
 mVvnxAajgzS0Rk24F4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX0Gcp6H9Kt9ol
 MGgE14RmMYNrZ1btqw+7W0bVZ3IYqEjo6HrBdoWmYjZixtdYeDGTBOz7hNvtRZwnR7Wfjn1zaEX
 xRxKnmp28nuhRrVobYks28Qo29pzORk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300054
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

A5xx has no progress callback, so any submit still running when the
hangcheck timer expires is declared hung, and long compute dispatches
such as KHR-GLES31.core.compute_shader.simple-compute-shared_context are
reset on A530 while still making progress.

Comparing the CP IB1/IB2 state, as a3xx and a6xx do, is not enough: during
a long dispatch the CP has fetched the whole IB and waits in one packet.
Also count ALU working cycles on SP performance counter 0, which Mesa
leaves to the kernel (and the kernel hasn't been using up to now).

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 5d96b8f63156..9f4a97195cde 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -748,6 +748,9 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 	/* Select RBBM0 to countable 6 to get the busy status for devfreq */
 	gpu_write(gpu, REG_A5XX_RBBM_PERFCTR_RBBM_SEL_0, 6);
 
+	/* Select SP0 to count ALU cycles for hangcheck progress detection */
+	gpu_write(gpu, REG_A5XX_SP_PERFCTR_SP_SEL_0, PERF_SP_ALU_WORKING_CYCLES);
+
 	/* Increase VFD cache access so LRZ and other data gets evicted less */
 	gpu_write(gpu, REG_A5XX_UCHE_CACHE_WAYS, 0x02);
 
@@ -1687,6 +1690,29 @@ static uint32_t a5xx_get_rptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return ring->memptrs->rptr = gpu_read(gpu, REG_A5XX_CP_RB_RPTR);
 }
 
+static bool a5xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
+	struct msm_cp_state cp_state = {
+		.ib1_base = gpu_read64(gpu, REG_A5XX_CP_IB1_BASE),
+		.ib2_base = gpu_read64(gpu, REG_A5XX_CP_IB2_BASE),
+		.ib1_rem  = gpu_read(gpu, REG_A5XX_CP_IB1_BUFSZ),
+		.ib2_rem  = gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ),
+	};
+	u64 alu_cycles = gpu_read64(gpu, REG_A5XX_RBBM_PERFCTR_SP_0_LO);
+	bool progress;
+
+	/* The CP can stall on one packet while shaders keep running */
+	progress = !!memcmp(&cp_state, &ring->last_cp_state, sizeof(cp_state)) ||
+		   alu_cycles != a5xx_gpu->last_alu_cycles;
+
+	ring->last_cp_state = cp_state;
+	a5xx_gpu->last_alu_cycles = alu_cycles;
+
+	return progress;
+}
+
 static void check_speed_bin(struct device *dev)
 {
 	struct nvmem_cell *cell;
@@ -1800,6 +1826,7 @@ const struct adreno_gpu_funcs a5xx_gpu_funcs = {
 		.gpu_state_put = a5xx_gpu_state_put,
 		.create_vm = adreno_create_vm,
 		.get_rptr = a5xx_get_rptr,
+		.progress = a5xx_progress,
 	},
 	.init = a5xx_gpu_init,
 	.get_timestamp = a5xx_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index 407bb950d350..fb05f1ca3e81 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -36,6 +36,8 @@ struct a5xx_gpu {
 	uint64_t preempt_iova[MSM_GPU_MAX_RINGS];
 	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
 
+	uint64_t last_alu_cycles;
+
 	atomic_t preempt_state;
 	spinlock_t preempt_start_lock;
 	struct timer_list preempt_timer;

-- 
2.47.3

