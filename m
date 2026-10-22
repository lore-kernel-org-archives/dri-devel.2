Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC91606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UZmV8jud;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Imux38wn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1721B112907;
	Thu, 22 Oct 2026 21:59:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C2B1128F5
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:59:19 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtT5L387597
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bCeckdKdRs/lhQimfyBgMy/Z9gSui80Hd8DZQ3MEnzI=; b=UZmV8jud7YWRPOtv
 hNcNO7klJAE7b/jwqCkSRr8PFzhUmm8gkePeokyGv/GLZsRDSfORZ0waMqEZuMeX
 VjkucJjAC5z5u58WdcMn+XvSGc5ElbA6ana78qAD2gWaN72RibitousIkPlmAagp
 q4CmD2NCD1ArZn7KM/0lAF9zkLrSYtXVVsi9LOSeNA4cs3+ZpqSn2f0bNCEmZp5a
 91ZYoGarLvTQp3iazLZeogr5p5eTggLQwcsQ1mnGxyu1jjzYDDlJLQ7SO4um2Jqj
 0bnVhsnkKyq+J9G+nxVHV1ATF9S7eafebnuOC3WhvvORFu+yoKSizeBO1eknRZNq
 pQbprA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rhq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:59:18 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so593373eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706357; x=1793311157;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bCeckdKdRs/lhQimfyBgMy/Z9gSui80Hd8DZQ3MEnzI=;
 b=Imux38wnMDRs7YNrnzRO9mpFAxCS9bI49L/09BSNiGnEaDF7J4CIeyxCBJsBNs1dII
 +Hi/EQ2b250YxhOi+My5f6gbGgS/ecKWMLdvEoVOkvnN1vGHCZ71VeiDZ0uwHVCp5xc0
 00Y13dobWM5hTZKM+Z3tAO7umQbQe46mDz2Rplysd/lDKt7BtUYt2wwbNIAIIfSRXpq6
 2S05gG8qqPyv92v+J8Wy6gpzvscxgzHfriNycgj9hH4IO3xEnPSt0NPUhuKD8RdSq1mc
 qE9cV8Z5JpwQP8M7XO3G07GknMG7DAheW/DYpQKDEA9gCWIOJiowTp7y9G681Hse4Q2t
 xDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706357; x=1793311157;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bCeckdKdRs/lhQimfyBgMy/Z9gSui80Hd8DZQ3MEnzI=;
 b=jKg6VYdgFI4qv8BpQtcOjXCQ/SfJ/YRmHTw3iHmVQhjAabjOToZIR2TAoWfz7n73Ku
 0Oea+DkBI0JAV0nOk9Ub53srAKMmViQuX11nyFTdRfZXu7IafrOhf2kqEVAKlOxvaP0K
 st4GobFjJnm9FDHx6+0qnPf7aj5jb6ro5w3oPXM523fOrfw02g2KJeBpFCguNMazTaF2
 dzFJmfB5sfHGjpWT1zxy3kZwfbQWIMxkCRx7CiZcl2HXztvao3Ws6K7Xuyxb/h065TLk
 teEFESnGnQYbMYYxKI3U5fEtNeexPGqCj8jFTHbIJTGDYPTP3tFscsash/Ng3NNHz/gw
 nL3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByK43ysYMjwmPUhRFJfM+oSkyFW9CyuxTUVyE4pXbh45qOkOT0WHw+cL+tL84chMRUsKZo30JU85X0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJA6J+FuHHf8mNl5CT+r7ZzfdReDs0jQRy9QuRRvJu6r1W3Le9Z
 YTrTYrcg08tCmVY5M3+9psy+ZFO9U9tYHAxNIE4GSll2ir3ZTD1kj+orwztiSeUnmkeHci9u4cT
 705ehdg+Wy61e7LlXBbuPkvo27QlrzqpgxNOl5Z3bSWuPHoaTrY2vsfElX3SyB/mD6Q8HVJU=
X-Gm-Gg: AYBFou2qkK2XA4iv4lpQn1qWY1seqPrHNDMAVsH5+yxsxYZ4IiFj2D9Bv92A7NsgJYj
 lYIHgJz6w5LTtwrU7Cj5aKla1q1KCVE2daIt3uqFXMzLJgqgiMVhlWpBiVBWCYvG+JlUh380+7y
 qxqfW/JXhX15+FBS+FIb6sgBjbRPv/TQ6T8NBnMqAGelb47OzOHjUzj7VMKIx/eu9uVbvlyUcc5
 L6GDh9ggTHWubtSSgc5o7wKcMKrGgG5mt38iI8pWNEHN6V8c6SZmNvDXb+QXI4YqhmDcAMLLcoF
 xFE0wvtiJ21mirBzQKAYonNVWPDCP1o/T13rkGz+GPHyE2VMgGUa08wjgNbYLTjQR1LY55ytrbn
 HtxVRtXOTyzGVgpYbycLXvzfS
X-Received: by 2002:a05:693c:20cf:20b0:369:1401:c5c2 with SMTP id
 5a478bee46e88-369d9866e98mr470787eec.26.1792706357152; 
 Thu, 22 Oct 2026 14:59:17 -0700 (PDT)
X-Received: by 2002:a05:693c:20cf:20b0:369:1401:c5c2 with SMTP id
 5a478bee46e88-369d9866e98mr470754eec.26.1792706356491; 
 Thu, 22 Oct 2026 14:59:16 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.228.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d89b14sm685365eec.14.2026.10.22.14.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:59:15 -0700 (PDT)
Message-ID: <bd3b073b-cae5-4ea8-8ed4-063db0aa5e64@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 03:29:08 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
To: fabricioakio@gmail.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jR58-RSmcJ1iVlL0Z-kITd3tIL5TT69d
X-Proofpoint-ORIG-GUID: jR58-RSmcJ1iVlL0Z-kITd3tIL5TT69d
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4lKZ7ONkohoW
 rw17jtbcak2lng8Hq7k1ewhQKuDOX/ny+qUX5fjEarFhE5cn+bL4TElEDD+ce0qqeHT5qqgcarC
 PV0aeDT33d1N2U20DWWR14UezPN3jBg=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada8736 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ipsIN8yD8anPosRfiFfp5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8 a=pGLkceISAAAA:8 a=aq2bxKA37D_GVACvEnsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5XsaIPnnIzvx
 wakgmctyAr7EFLU1fOu9qIEKbB9iF3Vg95TNO5L5sfaYPTd7UNbFHchDblgR5jm9RVN7pORTKuF
 71nEuND0hxPxC752Fs70cgE2LD5Xm+W0PKOyl0cjMTXmYAGlYoQPo+KbCp8IeE2eOba3Gik2WkR
 BBHcXISCl48za3Kn4Y/NSlx75N4qlo0hXPUOmrMWdLUgKHWG8ObNTQKfwyKnVJJoSfML4jFU3Pj
 NjR53wIgZr+tQiptW6E768mDyWO8rshucwNszulxef6uh2T65UtNzABnSy7mi3kHrJVBrEk+XfI
 JUQP0W0LdQKoBw/r9uaKzDAFNUzmWaihMAwmF7XiLsjgaT1S2lLeSz1AvMiMOXI1J9dbio+IeK4
 mprEhPlY9z5TTliWdmzG+wx+E+6wVKzzi0zrd25hTjKojEN0ALw1qycMd5Fl7gqhEl3x2oH0kJ0
 KRkXJFVqSMQNLHPRARw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/2026 7:35 AM, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
> SMMU, not to the GPU, so GX switches off only once the SMMU suspends as

This is incorrect. There is no Adreno GPU where SMMU is powered by GX. I looked
at the DT of SDM630 and I don't understand it. Seems like a creative workaround
to vote different power domains.

Please reword GX -> CX here. Adreno SMMU is powered by CX GDSC in every chipset.
In some chipsets, the core GPU blocks are also powered via CX GDSC. So it
makes sense to do a SW RESET in case CX didn't collapse due to a vote from the
SMMU driver or something.

> well. A GPU resumed with GX still on keeps its state, and the CP keeps
> its ringbuffer read pointer. a5xx_hw_init() then rewinds the ringbuffer
> and writes CP_ME_INIT at its start, while the CP goes on from its old
> position, executes stale ringbuffer contents and hangs:
> 
>   timeout waiting to drain ringbuffer 0 rptr/wptr = 23/C
> 
> Soft reset the GPU in a5xx_pm_resume() once it is powered, so that
> every resume starts from the reset state. The downstream driver resets
> only when it finds the GPU's power left on; resetting a GPU that was
> powered off changes nothing, and on A508 the reset takes about 2 us of
> a resume of about 1.5 ms, so do it every time.
> 
> The reset also clears the busy counter, which msm_gpu_pm_resume() has
> just sampled as devfreq's baseline. Take the baseline again after the
> reset, or the next devfreq poll subtracts the old count from the new
> one, wraps, and sets the GPU to its top frequency.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Changes in v2:
> - Take devfreq's busy-cycle baseline again after the reset, which
>   clears the busy counter (Sashiko)
> 
> Tested on A508 only; the reset runs on every A5xx.
> 
> A stall with the same signature, the CP's read pointer past the write
> pointer just after CP_ME_INIT, was reported on an A509:
> https://lore.kernel.org/linux-arm-msm/20260308-adreno-ringbuffer-drain-timeout-recovery-v1-1-985a33faf108@postmarketos.org/
> This may be the root cause of the A509 stall Paul Sajna reported there.
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 15 +++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h         |  1 +
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 17 +++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 16c7335c4b1f..0aff8252a00f 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1367,6 +1367,21 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * The GX power domain is not necessarily switched off while we are
> +	 * suspended: on SDM630, SDM660 and MSM8998 it follows the GPU's SMMU
> +	 * rather than the GPU. If it stayed on, the CP still holds its old
> +	 * ringbuffer read pointer and would execute stale ringbuffer contents
> +	 * once hw_init restarts it. Soft reset the GPU so that it always
> +	 * resumes from its reset state.
> +	 */
> +	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 1);
> +	gpu_read(gpu, REG_A5XX_RBBM_SW_RESET_CMD);
> +	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 0);
> +
> +	/* The reset cleared the busy counter devfreq has just sampled */
> +	msm_devfreq_resample_busy(gpu);

Instead of a new API, we can just move msm_devfreq_resume() here. That will align
with the A6xx sequence.

-Akhil.

> +
>  	/* Adreno 505, 506, 508, 509, 510, 512 needs manual RBBM sus/res control */
>  	if (!(adreno_is_a530(adreno_gpu) || adreno_is_a540(adreno_gpu))) {
>  		/* Halt the sp_input_clk at HM level */
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index d27d54bdb7a7..0e0768c15bcc 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -735,6 +735,7 @@ static inline struct msm_context *msm_context_get(
>  void msm_devfreq_init(struct msm_gpu *gpu);
>  void msm_devfreq_cleanup(struct msm_gpu *gpu);
>  void msm_devfreq_resume(struct msm_gpu *gpu);
> +void msm_devfreq_resample_busy(struct msm_gpu *gpu);
>  void msm_devfreq_suspend(struct msm_gpu *gpu);
>  void msm_devfreq_boost(struct msm_gpu *gpu, unsigned factor);
>  void msm_devfreq_active(struct msm_gpu *gpu);
> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> index 2e1d5c343272..2e963bff3f61 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -242,6 +242,23 @@ void msm_devfreq_resume(struct msm_gpu *gpu)
>  	devfreq_resume_device(df->devfreq);
>  }
>  
> +/*
> + * Take a new busy cycles baseline, for a GPU that resets its busy counter
> + * after msm_devfreq_resume() has sampled it.
> + */
> +void msm_devfreq_resample_busy(struct msm_gpu *gpu)
> +{
> +	struct msm_gpu_devfreq *df = &gpu->devfreq;
> +	unsigned long sample_rate;
> +
> +	if (!has_devfreq(gpu))
> +		return;
> +
> +	mutex_lock(&df->lock);
> +	df->busy_cycles = gpu->funcs->gpu_busy(gpu, &sample_rate);
> +	mutex_unlock(&df->lock);
> +}
> +
>  void msm_devfreq_suspend(struct msm_gpu *gpu)
>  {
>  	struct msm_gpu_devfreq *df = &gpu->devfreq;
> 

