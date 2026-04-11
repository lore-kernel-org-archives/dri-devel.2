Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A59F45A12
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA4310E148;
	Sat, 11 Apr 2026 02:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QQW8pBiI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NN21AvYF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B9010E148
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:22:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AIhrXY1322885
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jsPK59L1DEHDhwsLvGu/62voFLqLbdR2wUTVJKE17k8=; b=QQW8pBiI8qFZn7n8
 UVGjw6oKqIKXC7MqB9kSiym8WuRWcNEwfw8MZqMDKgv0dnumYoKqZjXUL9SBHgc8
 WdU2RUwoWZ45S4FaM729VQDpBfID14tqowKSBxDnhL82tZK7GLZyMBz2Zk4HPvgE
 LpViPigUowPCaUuioatfKTAePWeerB+JqH/jHRj5ZXQKg9RuXcQiFGCUAy3XROHL
 9SAjAzIn1vmqt6YZ3q4C0mkeBTNYm2rS4NjRCp4s2BE3WDpf/gURUQjGu/dCfBHt
 CMYqDoDqMdUtDeBPCc5yq62nhZOPvpukuV/9rRBPX44ta4MsIkco6V+p7r+Kapqs
 hNJvQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deyyhaajh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 02:22:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b24e45271cso28828045ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775874169; x=1776478969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsPK59L1DEHDhwsLvGu/62voFLqLbdR2wUTVJKE17k8=;
 b=NN21AvYF1GWjUzvgj53BDcZwprp6RHanQXjYq1a+wPkriK+Vijndv2u6u7Gf75SBfk
 24TQyIkIXlDwxI9xsZjOJlaDUHoIRCDF0OS2y1nnv2JPz1JUo4w5fTkMO6wpNjHF8fzO
 +cFp0qn1Wkh4vaNN9NNhjodZSilBbyJqrcrF9YnikyousKwuu9vpxHDToo/Hqwtkk3Vp
 4jGeeEZeDrr9vqltRXV0THEMoZLxtE7TrDB/gUnZLtye1x/M0nNT/6WXpY1KMVkSLE6O
 kviYAr1T9m8JXLg4L+UQJLk8v1UstiJ0zyyQ9uvwUWydEarkDax9zPzk/GicTzFSqn0/
 qafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775874169; x=1776478969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsPK59L1DEHDhwsLvGu/62voFLqLbdR2wUTVJKE17k8=;
 b=h3EHz+yuZHU5vhZYOndp9xLVrEL1hYSWOC2q9Yd8rJXp7yXtfy6ZU1SdGaEgFt8RtU
 tONec7JOOYe68RnfWATim4u1PA8P5hrvJLrJ7YvTG103hNjKkBgmRAnfrh3T0h4MSLGi
 Ufxqey6nA+dzuOI+e5p7p9jnGUpUHn02t7BW/YyBapPmfSICxuH2x9WUUUGGfBmCVGhx
 EeGEaBSnzqpUDx+lbXTT2mjKyyXP1zk3eczSlLbvqBMhB4PkhBtfi+KV4ulcEFDS5MYJ
 19Pi4DsQnRBSpVn2QisQhamLTMw5I9El/+0fhZWMLe+ENZhPvFMiRynmQLxB0buuQ/zk
 HJSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyWjMWV4dpugDc629pm+SnDsLCpEiUevJ92VROi8jiYvC+dyFNxjgzuc2NZfyJ0+IK/RSscbKt5kk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyJOmVXcrmbKV623MY6jj5D1QXIKFoYRhCApxUjWVOT9nbWKmq
 sHA7CI5H4RhFLiKTRTmdSZO+VstGZelxss3ThjMg+CIPVS3HRphhEr9TkIvfcM9CsOpPSeiG1uV
 b0wyyAAfjiro4ay+LKeWV28YNqDmS6z2OddgJAfHGSH0ZLL+XT/BMqFb6JFkrWRBz6BraESk=
X-Gm-Gg: AeBDietuYK9rsmX9fLi17znw83C98kN++g3PdyqFwPGD5kWMmFd1fodW2IrjeGvttjX
 8iA3xjMlWm5N+ntKpiiYcSte1tmNpHSKtcGMMcadoSTm/GTsfEP3venBj24YdhchS2KDui6ZuUM
 yysrN/kj9JxOpy2zBMWS4ajDPAtkVLK4LV9ilaO0zoGHVuvpNivB7AtKm2U3q1+1TaBNb8r1txR
 UFUYohKWP6ySOctIMMh0M5+BWzd99Gnb8wFrCd36Vk/P0uYXV00oEH9BA/3DraPsA3C7fBlB8J2
 22GTFBKc4BHLlnNH5mHnfpGPoPlVwjqdtSQ4K6aTcCYVQCYyFmr91BASy1h7XpXkEE9Q4xxqngK
 6KDTGLOSKecxkHNdUL3viZ069Ic72JMsrl3TPbCHHx4QTjija0BOXJH7Pl9mXBhnHqIzNd1fB0N
 gczLTiz86TbA==
X-Received: by 2002:a17:902:ffcb:b0:2ae:aa16:acfb with SMTP id
 d9443c01a7336-2b2d5a304b9mr60539175ad.22.1775874169324; 
 Fri, 10 Apr 2026 19:22:49 -0700 (PDT)
X-Received: by 2002:a17:902:ffcb:b0:2ae:aa16:acfb with SMTP id
 d9443c01a7336-2b2d5a304b9mr60538885ad.22.1775874168671; 
 Fri, 10 Apr 2026 19:22:48 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3afebsm42714125ad.72.2026.04.10.19.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 19:22:48 -0700 (PDT)
Message-ID: <07fcf759-b53c-4bc8-8e88-48b82713fecb@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 10:22:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] drm/msm/a8xx: Preemption support for A840
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-15-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-15-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX2CXXb/Sg+ilM
 7amFxKGRC/UtzBQ6D7TcB85Cyt616VXyjuvPfnKZ5Sg9CAP0hesb/wd31QmzPZav7jAl4b0wOfX
 c3mHZZloGQ6qQx/vxDU/5IONAROnDBnly6u5XbAtBC4j09FeLe/7yZFGkANZO/5ZhNeUEs2X3Zf
 NBSqs3U2/up0OExbitKfAgDR78gKPt2T/VrYn+3AeasavqIfZjcDzB4tA99tC5TYap9Ibu335lX
 aHpCZ4rE2Ha8KK2typ/VoSPkoUnjY4uuSbUMDWaR8AwdyhtK8O3fhGPJmWnbnhpqZTbLl1S+8H9
 oTP8T29dC9ShZg9RXT1EVRgjHl2K35XxSI18EVd8LF9Yd5oF7fzjSnR0Ei2fK4E7v+IKn+42KWW
 +QsG76RW/1LI85rNurd9dYCakQiMDTlcGiWLY8TLxR9PUGNiRHj9UVZ+N8ooMNVVd2J6RRJi9Mz
 tBqvik9+szkfCFD76tQ==
X-Proofpoint-GUID: OxWjfpe_z6KAedW0yxHX-RLlgS3bW-CO
X-Proofpoint-ORIG-GUID: OxWjfpe_z6KAedW0yxHX-RLlgS3bW-CO
X-Authority-Analysis: v=2.4 cv=Wv8b99fv c=1 sm=1 tr=0 ts=69d9b07a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=68z4iRH7ockWEGeBAzMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
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



On 3/27/2026 8:14 AM, Akhil P Oommen wrote:
> The programing sequence related to preemption is unchanged from A7x. But
> there is some code churn due to register shuffling in A8x. So, split out
> the common code into a header file for code sharing and add/update
> additional changes required to support preemption feature on A8x GPUs.
> 
> Finally, enable the preemption quirk in A840's catalog to enable this
> feature.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/Makefile              |   1 +
>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c |   1 +
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |   7 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   5 +
>   drivers/gpu/drm/msm/adreno/a6xx_preempt.c |  77 +--------
>   drivers/gpu/drm/msm/adreno/a6xx_preempt.h |  82 ++++++++++
>   drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  37 ++++-
>   drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 259 ++++++++++++++++++++++++++++++
>   8 files changed, 389 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 8b94c5f1cb68..ba45e99be05b 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -25,6 +25,7 @@ adreno-y := \
>   	adreno/a6xx_hfi.o \
>   	adreno/a6xx_preempt.o \
>   	adreno/a8xx_gpu.o \
> +	adreno/a8xx_preempt.o \
>   
>   adreno-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
>   
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 53548f6e891b..21f5a685196b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -2120,6 +2120,7 @@ static const struct adreno_info a8xx_gpus[] = {
>   		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
>   		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>   			  ADRENO_QUIRK_HAS_HW_APRIV |
> +			  ADRENO_QUIRK_PREEMPTION |
>   			  ADRENO_QUIRK_IFPC,
>   		.funcs = &a8xx_gpu_funcs,
>   		.a6xx = &(const struct a6xx_info) {
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index fb9662b946d0..44ce02b412ca 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -410,7 +410,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   	a6xx_flush(gpu, ring);
>   }
>   
> -static void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
> +void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
>   		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue)
>   {
>   	u64 preempt_postamble;
> @@ -620,7 +620,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>   	a6xx_flush(gpu, ring);
>   
>   	/* Check to see if we need to start preemption */
> -	a6xx_preempt_trigger(gpu);
> +	if (adreno_is_a8xx(adreno_gpu))
> +		a8xx_preempt_trigger(gpu);
> +	else
> +		a6xx_preempt_trigger(gpu);
>   }
>   
>   static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index a4434a6a56dd..eb431e5e00b1 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -278,6 +278,8 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
>   void a6xx_preempt_trigger(struct msm_gpu *gpu);
>   void a6xx_preempt_irq(struct msm_gpu *gpu);
>   void a6xx_preempt_fini(struct msm_gpu *gpu);
> +void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
> +		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue);
>   int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
>   		struct msm_gpu_submitqueue *queue);
>   void a6xx_preempt_submitqueue_close(struct msm_gpu *gpu,
> @@ -327,6 +329,9 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
>   int a8xx_hw_init(struct msm_gpu *gpu);
>   irqreturn_t a8xx_irq(struct msm_gpu *gpu);
>   void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
> +void a8xx_preempt_hw_init(struct msm_gpu *gpu);
> +void a8xx_preempt_trigger(struct msm_gpu *gpu);
> +void a8xx_preempt_irq(struct msm_gpu *gpu);
>   bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>   void a8xx_recover(struct msm_gpu *gpu);
>   #endif /* __A6XX_GPU_H__ */
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> index 747a22afad9f..df4cbf42e9a4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
> @@ -6,85 +6,10 @@
>   #include "msm_gem.h"
>   #include "a6xx_gpu.h"
>   #include "a6xx_gmu.xml.h"
> +#include "a6xx_preempt.h"
>   #include "msm_mmu.h"
>   #include "msm_gpu_trace.h"
>   
> -/*
> - * Try to transition the preemption state from old to new. Return
> - * true on success or false if the original state wasn't 'old'
> - */
> -static inline bool try_preempt_state(struct a6xx_gpu *a6xx_gpu,
> -		enum a6xx_preempt_state old, enum a6xx_preempt_state new)
> -{
> -	enum a6xx_preempt_state cur = atomic_cmpxchg(&a6xx_gpu->preempt_state,
> -		old, new);
> -
> -	return (cur == old);
> -}
> -
> -/*
> - * Force the preemption state to the specified state.  This is used in cases
> - * where the current state is known and won't change
> - */
> -static inline void set_preempt_state(struct a6xx_gpu *gpu,
> -		enum a6xx_preempt_state new)
> -{
> -	/*
> -	 * preempt_state may be read by other cores trying to trigger a
> -	 * preemption or in the interrupt handler so barriers are needed
> -	 * before...
> -	 */
> -	smp_mb__before_atomic();
> -	atomic_set(&gpu->preempt_state, new);
> -	/* ... and after*/
> -	smp_mb__after_atomic();
> -}
> -
> -/* Write the most recent wptr for the given ring into the hardware */
> -static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
> -{
> -	unsigned long flags;
> -	uint32_t wptr;
> -
> -	spin_lock_irqsave(&ring->preempt_lock, flags);
> -
> -	if (ring->restore_wptr) {
> -		wptr = get_wptr(ring);
> -
> -		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
> -
> -		ring->restore_wptr = false;
> -	}
> -
> -	spin_unlock_irqrestore(&ring->preempt_lock, flags);
> -}
> -
> -/* Return the highest priority ringbuffer with something in it */
> -static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
> -{
> -	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> -	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> -
> -	unsigned long flags;
> -	int i;
> -
> -	for (i = 0; i < gpu->nr_rings; i++) {
> -		bool empty;
> -		struct msm_ringbuffer *ring = gpu->rb[i];
> -
> -		spin_lock_irqsave(&ring->preempt_lock, flags);
> -		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
> -		if (!empty && ring == a6xx_gpu->cur_ring)
> -			empty = ring->memptrs->fence == a6xx_gpu->last_seqno[i];
> -		spin_unlock_irqrestore(&ring->preempt_lock, flags);
> -
> -		if (!empty)
> -			return ring;
> -	}
> -
> -	return NULL;
> -}
> -
>   static void a6xx_preempt_timer(struct timer_list *t)
>   {
>   	struct a6xx_gpu *a6xx_gpu = timer_container_of(a6xx_gpu, t,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.h b/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
> new file mode 100644
> index 000000000000..df36c945b836
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +/* Copyright (c) 2023 Collabora, Ltd. */
> +/* Copyright (c) 2024 Valve Corporation */
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +/*
> + * Try to transition the preemption state from old to new. Return
> + * true on success or false if the original state wasn't 'old'
> + */
> +static inline bool try_preempt_state(struct a6xx_gpu *a6xx_gpu,
> +		enum a6xx_preempt_state old, enum a6xx_preempt_state new)
> +{
> +	enum a6xx_preempt_state cur = atomic_cmpxchg(&a6xx_gpu->preempt_state,
> +		old, new);
> +
> +	return (cur == old);
> +}
> +
> +/*
> + * Force the preemption state to the specified state.  This is used in cases
> + * where the current state is known and won't change
> + */
> +static inline void set_preempt_state(struct a6xx_gpu *gpu,
> +		enum a6xx_preempt_state new)
> +{
> +	/*
> +	 * preempt_state may be read by other cores trying to trigger a
> +	 * preemption or in the interrupt handler so barriers are needed
> +	 * before...
> +	 */
> +	smp_mb__before_atomic();
> +	atomic_set(&gpu->preempt_state, new);
> +	/* ... and after */
> +	smp_mb__after_atomic();
> +}
> +
> +/* Write the most recent wptr for the given ring into the hardware */
> +static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
> +{
> +	unsigned long flags;
> +	uint32_t wptr;
> +
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
> +
> +	if (ring->restore_wptr) {
> +		wptr = get_wptr(ring);
> +
> +		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
> +
> +		ring->restore_wptr = false;
> +	}
> +
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
> +}
> +
> +/* Return the highest priority ringbuffer with something in it */
> +static inline struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	unsigned long flags;
> +	int i;
> +
> +	for (i = 0; i < gpu->nr_rings; i++) {
> +		bool empty;
> +		struct msm_ringbuffer *ring = gpu->rb[i];
> +
> +		spin_lock_irqsave(&ring->preempt_lock, flags);
> +		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
> +		if (!empty && ring == a6xx_gpu->cur_ring)
> +			empty = ring->memptrs->fence == a6xx_gpu->last_seqno[i];
> +		spin_unlock_irqrestore(&ring->preempt_lock, flags);
> +
> +		if (!empty)
> +			return ring;
> +	}
> +
> +	return NULL;
> +}
> +
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index e406681b8c80..9e6f2ed69247 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -463,6 +463,34 @@ static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
>   	a8xx_aperture_clear(gpu);
>   }
>   
> +static int a8xx_preempt_start(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct msm_ringbuffer *ring = gpu->rb[0];
> +
> +	if (gpu->nr_rings <= 1)
> +		return 0;
> +
> +	/* Turn CP protection off */
> +	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> +	OUT_RING(ring, 0);
> +
> +	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
> +
> +	/* Yield the floor on command completion */
> +	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
> +	OUT_RING(ring, 0x00);
> +	OUT_RING(ring, 0x00);
> +	OUT_RING(ring, 0x00);
> +	/* Generate interrupt on preemption completion */
> +	OUT_RING(ring, 0x00);
> +
> +	a6xx_flush(gpu, ring);
> +
> +	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
> +}
> +
>   static int a8xx_cp_init(struct msm_gpu *gpu)
>   {
>   	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> @@ -738,6 +766,8 @@ static int hw_init(struct msm_gpu *gpu)
>   	gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR, shadowptr(a6xx_gpu, gpu->rb[0]));
>   	gpu_write64(gpu, REG_A8XX_CP_RB_RPTR_ADDR_BV, rbmemptr(gpu->rb[0], bv_rptr));
>   
> +	a8xx_preempt_hw_init(gpu);
> +
>   	for (i = 0; i < gpu->nr_rings; i++)
>   		a6xx_gpu->shadow[i] = 0;
>   
> @@ -800,6 +830,9 @@ static int hw_init(struct msm_gpu *gpu)
>   	/* Enable hardware clockgating */
>   	a8xx_set_hwcg(gpu, true);
>   out:
> +	/* Last step - yield the ringbuffer */
> +	a8xx_preempt_start(gpu);
> +
>   	/*
>   	 * Tell the GMU that we are done touching the GPU and it can start power
>   	 * management
> @@ -1209,11 +1242,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
>   
>   	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS) {
>   		msm_gpu_retire(gpu);
> -		a6xx_preempt_trigger(gpu);
> +		a8xx_preempt_trigger(gpu);
>   	}
>   
>   	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
> -		a6xx_preempt_irq(gpu);
> +		a8xx_preempt_irq(gpu);
>   
>   	return IRQ_HANDLED;
>   }
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> new file mode 100644
> index 000000000000..3d8c33ba722e
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> +
> +#include "msm_gem.h"
> +#include "a6xx_gpu.h"
> +#include "a6xx_gmu.xml.h"
> +#include "a6xx_preempt.h"
> +#include "msm_mmu.h"
> +#include "msm_gpu_trace.h"
> +
> +static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
> +{
> +	u32 *postamble = a6xx_gpu->preempt_postamble_ptr;
> +	u32 count = 0;
> +
> +	postamble[count++] = PKT7(CP_REG_RMW, 3);
> +	postamble[count++] = REG_A8XX_RBBM_PERFCTR_SRAM_INIT_CMD;
> +	postamble[count++] = 0;
> +	postamble[count++] = 1;
> +
> +	postamble[count++] = PKT7(CP_WAIT_REG_MEM, 6);
> +	postamble[count++] = CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ);
> +	postamble[count++] = CP_WAIT_REG_MEM_POLL_ADDR_LO(
> +				REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS);
> +	postamble[count++] = CP_WAIT_REG_MEM_POLL_ADDR_HI(0);
> +	postamble[count++] = CP_WAIT_REG_MEM_3_REF(0x1);
> +	postamble[count++] = CP_WAIT_REG_MEM_4_MASK(0x1);
> +	postamble[count++] = CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
> +
> +	a6xx_gpu->preempt_postamble_len = count;
> +
> +	a6xx_gpu->postamble_enabled = true;
> +}
> +
> +static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
> +{
> +	u32 *postamble = a6xx_gpu->preempt_postamble_ptr;
> +
> +	/*
> +	 * Disable the postamble by replacing the first packet header with a NOP
> +	 * that covers the whole buffer.
> +	 */
> +	*postamble = PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_len - 1));
> +
> +	a6xx_gpu->postamble_enabled = false;
> +}
> +
> +/*
> + * Set preemption keepalive vote. Please note that this vote is different from the one used in
> + * a8xx_irq()
> + */
> +static void a8xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_PWR_COL_PREEMPT_KEEPALIVE, on);
> +}
> +
> +void a8xx_preempt_irq(struct msm_gpu *gpu)
> +{
> +	uint32_t status;
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	struct drm_device *dev = gpu->dev;
> +
> +	if (!try_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED, PREEMPT_PENDING))
> +		return;
> +
> +	/* Delete the preemption watchdog timer */
> +	timer_delete(&a6xx_gpu->preempt_timer);
> +
> +	/*
> +	 * The hardware should be setting the stop bit of CP_CONTEXT_SWITCH_CNTL
> +	 * to zero before firing the interrupt, but there is a non zero chance
> +	 * of a hardware condition or a software race that could set it again
> +	 * before we have a chance to finish. If that happens, log and go for
> +	 * recovery
> +	 */
> +	status = gpu_read(gpu, REG_A8XX_CP_CONTEXT_SWITCH_CNTL);
> +	if (unlikely(status & A8XX_CP_CONTEXT_SWITCH_CNTL_STOP)) {
> +		DRM_DEV_ERROR(&gpu->pdev->dev,
> +					  "!!!!!!!!!!!!!!!! preemption faulted !!!!!!!!!!!!!! irq\n");
> +		set_preempt_state(a6xx_gpu, PREEMPT_FAULTED);
> +		dev_err(dev->dev, "%s: Preemption failed to complete\n",
> +			gpu->name);
> +		kthread_queue_work(gpu->worker, &gpu->recover_work);
> +		return;
> +	}
> +
> +	a6xx_gpu->cur_ring = a6xx_gpu->next_ring;
> +	a6xx_gpu->next_ring = NULL;
> +
> +	set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
> +
> +	update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
> +
> +	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> +
> +	a8xx_preempt_keepalive_vote(gpu, false);
> +
> +	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
> +
> +	/*
> +	 * Retrigger preemption to avoid a deadlock that might occur when preemption
> +	 * is skipped due to it being already in flight when requested.
> +	 */
> +	a8xx_preempt_trigger(gpu);
> +}
> +
> +void a8xx_preempt_hw_init(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	int i;
> +
> +	/* No preemption if we only have one ring */
> +	if (gpu->nr_rings == 1)
> +		return;
> +
> +	for (i = 0; i < gpu->nr_rings; i++) {
> +		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
> +
> +		record_ptr->wptr = 0;
> +		record_ptr->rptr = 0;
> +		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
> +		record_ptr->info = 0;
> +		record_ptr->data = 0;
> +		record_ptr->rbase = gpu->rb[i]->iova;
> +	}
> +
> +	/* Write a 0 to signal that we aren't switching pagetables */
> +	gpu_write64(gpu, REG_A8XX_CP_CONTEXT_SWITCH_SMMU_INFO, 0);
> +
> +	/* Enable the GMEM save/restore feature for preemption */
> +	gpu_write(gpu, REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0x1);
> +
> +	/* Reset the preemption state */
> +	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> +
> +	spin_lock_init(&a6xx_gpu->eval_lock);
> +
> +	/* Always come up on rb 0 */
> +	a6xx_gpu->cur_ring = gpu->rb[0];
> +}
> +
> +void a8xx_preempt_trigger(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	unsigned long flags;
> +	struct msm_ringbuffer *ring;
> +	unsigned int cntl;
> +	bool sysprof;
> +
> +	if (gpu->nr_rings == 1)
> +		return;
> +
> +	/*
> +	 * Lock to make sure another thread attempting preemption doesn't skip it
> +	 * while we are still evaluating the next ring. This makes sure the other
> +	 * thread does start preemption if we abort it and avoids a soft lock.
> +	 */
> +	spin_lock_irqsave(&a6xx_gpu->eval_lock, flags);
> +
> +	/*
> +	 * Try to start preemption by moving from NONE to START. If
> +	 * unsuccessful, a preemption is already in flight
> +	 */
> +	if (!try_preempt_state(a6xx_gpu, PREEMPT_NONE, PREEMPT_START)) {
> +		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> +		return;
> +	}
> +
> +	cntl = A8XX_CP_CONTEXT_SWITCH_CNTL_LEVEL(a6xx_gpu->preempt_level);
> +
> +	if (a6xx_gpu->skip_save_restore)
> +		cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_SKIP_SAVE_RESTORE;
> +
> +	if (a6xx_gpu->uses_gmem)
> +		cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_USES_GMEM;
> +
> +	cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_STOP;
> +
> +	/* Get the next ring to preempt to */
> +	ring = get_next_ring(gpu);
> +
> +	/*
> +	 * If no ring is populated or the highest priority ring is the current
> +	 * one do nothing except to update the wptr to the latest and greatest
> +	 */
> +	if (!ring || (a6xx_gpu->cur_ring == ring)) {
> +		set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
> +		update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
> +		set_preempt_state(a6xx_gpu, PREEMPT_NONE);
> +		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> +		return;
> +	}
> +
> +	spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
> +
> +	spin_lock_irqsave(&ring->preempt_lock, flags);
> +
> +	struct a7xx_cp_smmu_info *smmu_info_ptr =
> +		a6xx_gpu->preempt_smmu[ring->id];
> +	struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[ring->id];
> +	u64 ttbr0 = ring->memptrs->ttbr0;
> +	u32 context_idr = ring->memptrs->context_idr;

Shall we declare these variables at the top of the function body?

Thanks,
Jie

> +
> +	smmu_info_ptr->ttbr0 = ttbr0;
> +	smmu_info_ptr->context_idr = context_idr;
> +	record_ptr->wptr = get_wptr(ring);
> +
> +	/*
> +	 * The GPU will write the wptr we set above when we preempt. Reset
> +	 * restore_wptr to make sure that we don't write WPTR to the same
> +	 * thing twice. It's still possible subsequent submissions will update
> +	 * wptr again, in which case they will set the flag to true. This has
> +	 * to be protected by the lock for setting the flag and updating wptr
> +	 * to be atomic.
> +	 */
> +	ring->restore_wptr = false;
> +
> +	trace_msm_gpu_preemption_trigger(a6xx_gpu->cur_ring->id, ring->id);
> +
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
> +
> +	/* Set the keepalive bit to keep the GPU ON until preemption is complete */
> +	a8xx_preempt_keepalive_vote(gpu, true);
> +
> +	a6xx_fenced_write(a6xx_gpu,
> +		REG_A8XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
> +		BIT(1), true);
> +
> +	a6xx_fenced_write(a6xx_gpu,
> +		REG_A8XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
> +		a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
> +
> +	a6xx_gpu->next_ring = ring;
> +
> +	/* Start a timer to catch a stuck preemption */
> +	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
> +
> +	/* Enable or disable postamble as needed */
> +	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
> +
> +	if (!sysprof && !a6xx_gpu->postamble_enabled)
> +		preempt_prepare_postamble(a6xx_gpu);
> +
> +	if (sysprof && a6xx_gpu->postamble_enabled)
> +		preempt_disable_postamble(a6xx_gpu);
> +
> +	/* Set the preemption state to triggered */
> +	set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
> +
> +	/* Trigger the preemption */
> +	a6xx_fenced_write(a6xx_gpu, REG_A8XX_CP_CONTEXT_SWITCH_CNTL, cntl, BIT(1), false);
> +}
> +
> 

