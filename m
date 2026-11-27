Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MAWyzwCU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jF4nBfEt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A1E112D62;
	Fri, 27 Nov 2026 19:49:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CB3112D63
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:49:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAqtv3982209
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=g2dcKjVxVXVvc7zH7i/+/9NY
 X/sWj0TUS/ckSZHauwE=; b=MAWyzwCUrewdsxoJ8TW0zpWcLY4BGYn1dTb+283W
 SqCnSGYntirSpA/70oUIrY+JM+1WM43ZNXDi1JHKL6sZ/I62nciP1RxlYBMByEIh
 KZnoo76VP85xtAINSTc+1p5uuUWgsKudn0+5yiie1TUPlFir6G8fpAI+Sd8sF6tt
 ixaEPrT6/F1/WRtppeEV5hz6b/6Zyjqg6S9+FBLzfpSxW8nSyVwbca0r+AMccp6e
 0Mgn82x9Axq3g4Rk4hVo8hVQ6n85lqOjwEfm/7Q0lJlyGYbv4Fs7XMNHlABOvEEc
 nVZU0ROYWO9yXfY9AJhGlUteuenORnPIPZhDkx6vT45AhQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d863a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:49:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495dd0f07eso1433459985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808952; x=1796413752;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g2dcKjVxVXVvc7zH7i/+/9NYX/sWj0TUS/ckSZHauwE=;
 b=jF4nBfEtB4upY/zjv2LZXgRsXmOk5GEc12S/MaAezKLL7RmQ2x987wE5OMHDtAlE7k
 KVI9fMjwWy4yuXX0LmrOe3M1notcratqFQOXaGZ6PggK3ImQHtu6zpVRCTgi7nhm7weO
 I0Gomxz9G8tpuVsh4hXM3VBs+lfTJA7hjnYI/MbWUb3bBEXel2d06rZOt6fibwwUCW1j
 wSHAN2S1wBEuI90PFYClqmmNwwdwEYYk58Ht0SeREhqlMSLwFwSIzaQLMWoDIVgRqsON
 l/i9XDCHTeVXiVhwY99eiNHHQqmctbxeNCEZI1csCHzL3h12wTUB03IXBvvDPxx/YSZf
 XCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808952; x=1796413752;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g2dcKjVxVXVvc7zH7i/+/9NYX/sWj0TUS/ckSZHauwE=;
 b=nJS4PBRl3eyhVSl+QvnSo/pF+TaBz75xKl77V8V5mmzuCa6n83nxRnqSoMpQ9BxZgh
 YlAJWwSX1hRU5A6umf7poyVLI7lY/qL7vfhDC1tAW3PxN6MwGZPYlOjqsw+ZVrFs81qc
 4dBM1SNc1OfBv9Wtq/6xf7tT8aZl0ysrw5UVa4sCFbsmvYF8OVTwVhTPGQjyFj/r8iYM
 M+pRNCUSJ3XJQ1mOIGiYZAVDnJw47WccTNa8a7mMRVwor5LfKmwVPxV1bh/EdcmeP2Nf
 SmmHiuVyoh2L6QV3MYV6Lqn99z5UWnVXUolX+Qcz9ZnXQ4BDPYDBovroGpZX1thn9icW
 wnBA==
X-Forwarded-Encrypted: i=1;
 AL+hErE9Pu+XFmbBILhXa123FKBzZtRbCkxAzxWwyDrblwtbo6eQvePUj0D5qITU/4i4Hi8XoCIR6WHZGro=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/g3rpyVqBNrIL9+VkOSBAiYtbDJabeR/uFsN+3zCrS02HIejnP
 bMnEEl8DIAwo/2i5ooL8nOzmISFJLhNDES7cpPfrH8oGmcJFu0carjnLTK+jwsuuBv5nvq9czcj
 15Uy4YwZDNw0PAOG0phj37q2cJECHbHSEhsYaUBhj4nGmTHDgIpulAtnd13maSW56xaZCMt4=
X-Gm-Gg: AZFdTZeRNM+N/E9ApaTA02CduvC254uAOfs2ltJMZfxvGFI5vSIGOaAfhNnsCZFyqe0
 EmTY3EGkyV4CVA1htmTn7d5T5vmAiLJ4lnieHLImh5Al6rTL9at8UTZBTG+7g3gW3TxBBpxZZRO
 6jveHpKjpKiPg8H+5n4ajDyfrcxhYj+Ipc4K6RR8Gsmlqma8epSy3WKuI7/3CtPJG9jlvB7aB9j
 YS5OPK/15pEOZcjDd9F+c3FHzQzFKxLM7djfVOgg1cljvICd0b6lyPP2EWn/HO3Jyvlc6BT1Czi
 Hp6WXN9Fi0q6XoBRjk6l6ThyqdfQsnHX+R4mmhMdgBOTGxOGuqd2OaDbUQBTiOBokbSu4mQZNpY
 Kr4ilR0YUocTk/qqXjwghtnlDomH4F5NXT9Wbn9+cNW/XL6lJnCjoqcl8P4rJZjJV/PWD+P3j+x
 o6F4hTyJ+Yjegr/2zgvqGC+/xRp/YBp6eOO0gwNODVA8MENMEFcyJnkfdRTN8MjQ==
X-Received: by 2002:a05:620a:6293:b0:937:6c0a:9b65 with SMTP id
 af79cd13be357-949ba848403mr4309582285a.7.1795808951714; 
 Fri, 27 Nov 2026 11:49:11 -0800 (PST)
X-Received: by 2002:a05:620a:6293:b0:937:6c0a:9b65 with SMTP id
 af79cd13be357-949ba848403mr4309577185a.7.1795808951105; 
 Fri, 27 Nov 2026 11:49:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c33ed140c5sm391396e87.81.2026.11.27.11.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:49:10 -0800 (PST)
Date: Fri, 27 Nov 2026 21:49:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: Re: [PATCH v3] drm/msm: preemption aware hangcheck
Message-ID: <3f54aqzk64kpekzthwt7bkhrxyv4zczdtnbtix347bppse6got@vubfdnmms7in>
References: <20261106-preemption_aware_hangcheck-v3-1-852acf72102c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-preemption_aware_hangcheck-v3-1-852acf72102c@gmail.com>
X-Proofpoint-ORIG-GUID: aRCQVGnuPXYTqeFslbHsAuQCx5D5DvfK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXz0i0nq99/e6R
 wC5c8aTgsOB3GTwJop5wIiRRvjFU3ra6Qpsl7YvlgRGtWZNTmA6G+Axx2+rRsEZ55M2Xir3zI1J
 9y4DOB344jaEepYWot2wO/gKqKfhI80=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09deb8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=e5mUnYsNAAAA:8 a=te0fHMlqqURSnBpgbLIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: aRCQVGnuPXYTqeFslbHsAuQCx5D5DvfK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0kuSKZT22P+e
 XnIecK2+O8MZG+xCbwrGg+zKEH9PY0H8ewzP1PkfwIfdQN+vlERwQoRkyHP+TFcNtMxHeczDFvt
 32tbWF1Wmt/qUUWodwzLR5xIYtezmm3dBkKDUyQFuSVc1URi5GwvYQHIbbBbvvkoDfsQ4pumJXL
 uT9OkfrjakIYMS1DQltwo2z3s5CUN1lNN/04XpWbZS+WWpd2BWnACdus6UfT7uUN3eqXgYv11n0
 sUd5JauSwHAFpnk1spIeCzQ0Yw3D0ncPqdc/IEpkPJe1bwX2YHGR8BrunW/qNE3ykE9vHnRVRC5
 geezPSwO0g7q/uMveTxox+9l743LMx3hRe4bFhJStZtfujtDv3bt2u8uz5bY3ypMsnyL1xe6D49
 FcguON2zDNu2lqSYAXWD/8Fo73m/dgUehTjlb6/Rf/SN5CEq3UTyWd7ifgw0eUvEUePkwqa+jrB
 XAPbNXiudNT0zQxm7Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 05:46:28PM +0100, Anna Maniscalco wrote:
> Rework hangcheck code to work well toghether with preemption.
> 
> Track the time a job has spent in a ring by storing timestamps of the
> `CP_ALWAYS_ON_CONTEXT` register at the beginning of a job and when
> switching rings as well as reading it back if the ring is currently
> active.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
> Ever since we added support for preemption hangcheck has been somewhat
> broken as it is not aware of multiple rings.
> 
> In some cases it might not recognize that one ring is stuck if the gpu
> switches in and out of it.

This text should start the commit message, it's a description of the
problem. The text under three dashes will not land in the kernel and so
nobody would know why you were doing these changes.

> 
> depends on https://lore.kernel.org/linux-arm-msm/20261102190010.720443-1-robin.clark@oss.qualcomm.com
> ---
> Changes in v3:
> - Addressed sashiko's feedback
> - Rebased on reworked IFPC disable series
> - Link to v2: https://patch.msgid.link/20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com
> 
> Changes in v2:
> - Various fixes
> - Fix interaction with IFPC by using OOB vote
> - Link to v1: https://lore.kernel.org/r/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com
> 
> To: Rob Clark <robin.clark@oss.qualcomm.com>
> To: Sean Paul <sean@poorly.run>
> To: Konrad Dybcio <konradybcio@kernel.org>
> To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> To: Dmitry Baryshkov <lumag@kernel.org>
> To: Abhinav Kumar <abhinav.kumar@linux.dev>
> To: Jessica Zhang <jesszhan0024@gmail.com>
> To: Marijn Suijten <marijn.suijten@somainline.org>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  5 +--
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  6 +---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 54 +++++++++++++++++++++++------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 32 +++++++++++++-----
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++-----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c   |  3 +-
>  drivers/gpu/drm/msm/msm_gpu.c             | 56 ++++++++++++++++++++++++-------
>  drivers/gpu/drm/msm/msm_gpu.h             | 11 ++++++
>  drivers/gpu/drm/msm/msm_ringbuffer.h      | 10 ++++++
>  10 files changed, 140 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 16c7335c4b1f..8800352455df 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1251,10 +1251,7 @@ static void a5xx_fault_detect_irq(struct msm_gpu *gpu)
>  		gpu_read64(gpu, REG_A5XX_CP_IB2_BASE),
>  		gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ));
>  
> -	/* Turn off the hangcheck timer to keep it from bothering us */
> -	timer_delete(&gpu->hangcheck_timer);
> -
> -	kthread_queue_work(gpu->worker, &gpu->recover_work);
> +	msm_trigger_recovery(gpu);
>  }
>  
>  #define RBBM_ERROR_MASK \
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index bba5468db42e..bcbe1b949217 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -28,11 +28,7 @@ static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
>  	/* FIXME: add a banner here */
>  	gmu->hung = true;
>  
> -	/* Turn off the hangcheck timer while we are resetting */
> -	timer_delete(&gpu->hangcheck_timer);
> -
> -	/* Queue the GPU handler because we need to treat this as a recovery */
> -	kthread_queue_work(gpu->worker, &gpu->recover_work);
> +	msm_trigger_recovery(gpu);
>  }
>  
>  static irqreturn_t a6xx_gmu_irq(int irq, void *data)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 773c1727dd31..179e42119307 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -519,6 +519,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));
>  	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
>  
> +	get_stats_counter(ring, cp_always_on_context,
> +		rbmemptr(ring, last_job_start_ctx));
> +
>  	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
>  	OUT_RING(ring, CP_SET_THREAD_BOTH);
>  
> @@ -1474,8 +1477,11 @@ static int hw_init(struct msm_gpu *gpu)
>  	/* Always come up on rb 0 */
>  	a6xx_gpu->cur_ring = gpu->rb[0];
>  
> -	for (i = 0; i < gpu->nr_rings; i++)
> +	for (i = 0; i < gpu->nr_rings; i++) {
>  		gpu->rb[i]->cur_ctx_seqno = 0;
> +		gpu->rb[i]->memptrs->last_job_start_ctx = 0;
> +		gpu->rb[i]->memptrs->last_active_ctxcycles = 0;
> +	}
>  
>  	/* Enable the SQE_to start the CP engine */
>  	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
> @@ -1838,13 +1844,10 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
>  		gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
>  		gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE));
>  
> -	/* Turn off the hangcheck timer to keep it from bothering us */
> -	timer_delete(&gpu->hangcheck_timer);
> -
>  	/* Turn off interrupts to avoid triggering recovery again */
>  	gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, 0);
>  
> -	kthread_queue_work(gpu->worker, &gpu->recover_work);
> +	msm_trigger_recovery(gpu);
>  }
>  
>  static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
> @@ -1861,11 +1864,8 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
>  	 * to legacy blending.
>  	 */
>  	if (status & (A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
> -		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC)) {
> -		timer_delete(&gpu->hangcheck_timer);
> -
> -		kthread_queue_work(gpu->worker, &gpu->recover_work);
> -	}
> +		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC))
> +		msm_trigger_recovery(gpu);
>  }
>  
>  static void a6xx_gpu_keepalive_vote(struct msm_gpu *gpu, bool on)
> @@ -2293,6 +2293,39 @@ static u64 a6xx_get_timestamp(struct msm_gpu *gpu)
>  	return gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
>  }
>  
> +static int a6xx_get_ctx_timestamp(struct msm_ringbuffer *ring, uint64_t *value)
> +{
> +	struct msm_gpu *gpu = ring->gpu;
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	int ret = 0;
> +
> +	/* Inhibit IFPC while accessing registers: */
> +	guard(ifpc_disable)(gpu);
> +
> +	/*
> +	 * a6xx_gmu_set_oob cannot be called while holding a spinlock.
> +	 * Limit the scope.
> +	 */
> +	if (gpu->nr_rings == 1) {
> +		guard(spinlock_irqsave)(&a6xx_gpu->eval_lock);
> +
> +		/*
> +		 * Make sure the GMU keeps the GPU on while we read the register
> +		 *
> +		 * This should normally not be waking up the gpu since the
> +		 * hangcheck timer shouldn't fire when the gpu is idle.
> +		 */
> +		if (a6xx_in_preempt(a6xx_gpu) || ring != a6xx_gpu->cur_ring)
> +			return -EBUSY;
> +
> +		*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT);
> +	} else
> +		*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT);

Isn't this inverted? With the single ring, there is no other ring and no
preemtpion.

> +
> +	return ret;
> +}
> +
>  static struct msm_ringbuffer *a6xx_active_ring(struct msm_gpu *gpu)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);

> @@ -43,6 +47,17 @@ static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
>  	postamble[count++] = CP_WAIT_REG_MEM_4_MASK(0x1);
>  	postamble[count++] = CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
>  
> +	a6xx_gpu->preempt_postamble_cntreset_end = count;
> +
> +	if (last_active_ctxcycles) {
> +		postamble[count++] = PKT7(ring ? CP_REG_TO_MEM : CP_NOP, 3);

ring is always non-NULL here

> +		postamble[count++] = CP_REG_TO_MEM_0_REG(REG_A6XX_CP_ALWAYS_ON_CONTEXT) |
> +			CP_REG_TO_MEM_0_CNT(2) |
> +			CP_REG_TO_MEM_0_IS_64B;
> +		postamble[count++] = lower_32_bits(last_active_ctxcycles);
> +		postamble[count++] = upper_32_bits(last_active_ctxcycles);
> +	}
> +
>  	a6xx_gpu->preempt_postamble_len = count;
>  
>  	a6xx_gpu->postamble_enabled = true;

-- 
With best wishes
Dmitry
