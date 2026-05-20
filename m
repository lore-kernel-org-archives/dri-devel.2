Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B2CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5A310E034;
	Wed, 20 May 2026 08:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIN4JNsX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHswlQhn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3556A10E034
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:40:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K6kRsF2984427
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ksCuFyVopMwzaF+rhBhElIqrMrlV9U+fKPObu3sILeE=; b=BIN4JNsXc1As4p6H
 rgX40M9M/32FPCPa/TDm3Os5VKpmtghVak3XGCmv8w4HqFCFuuNmRocoMWz5/LVL
 +aAoR5AdZGKYzBP0W+lRcXKvTJpfLFt98jwDdhbj8EOf8g+e3/s6Zmw3dGVLgcLv
 kRjl737aQ77f6rpZMclPj+bMTeFD6dbIJqkdDL5QCOLk9D4TfAwHPgrUN9toGiex
 pE7TwHaRC80XfsQim2c4lnmCvulKcYL9xqFd0U8IZMS8siTBKvxDSFJhSnHiX0lY
 ezftB2e3ioOc+oHA97mpTxXEcPmgWsFq1ahpAXXmFaHXmafuE8nwGhzHYOByxfJe
 FPeLQQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t3wwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:40:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8292e18166so2316794a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779266403; x=1779871203;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ksCuFyVopMwzaF+rhBhElIqrMrlV9U+fKPObu3sILeE=;
 b=YHswlQhneSJWFBF1wsDJX3GqHESd680dkI5FHzbltVPhS/s1lQuqYL254b6DB/o6xF
 pXlYyVe410DC6jmAnPaam/TiJ4Auebt/xNlQJ08wVKlDbMPofqH7PcGQ/mabU3MvlLrz
 oGD7QxKuqisvHi5/yd16zYiPDOEyD7FBmzPbvFrjpjvm58PM0hz8EdtONSEObTzzWAKq
 JhPLCHkblN9bTC5sUQy3OsMnIYI23kFtOOR1/2pKeuX/WVEWIgZ3B4OmWBI1TcmGG+Vw
 CbvKf8RahGM0luaWA9jSvauBpeqKRpzKsoc85WVmgTAmurSyPY0ncDmMzdciVPrYGkq9
 K9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779266403; x=1779871203;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ksCuFyVopMwzaF+rhBhElIqrMrlV9U+fKPObu3sILeE=;
 b=X9aeOsH4JGX4aT7lYiYCCmFV5Xq+ZkgluMVbGLe91kSs2Ul0bUbjL02vTFoYsZFg2K
 4Wa/ZeAsSoMwZ6E8PC8zJECWupaqF8S7hB1HifTZuUF6JYCm/HIR5PTRmw+wzg5CyGcz
 gDVjMfdaZMvsGvnTqb/9/WK9dzAhigtgO4dUKHGWqe/0rF92dTFyU5ENGgBjoF9punOO
 oLz96t+CZGIQtqeiHp+iz3uaQUuq2rjeTCG0PScLYCCterfgwqQHWd+AUYgv3l/IXT2e
 P/atEuB+8/rbGuw9uEWplBJFRMUG24uGAoD/1JXoefDZ2SuioNTwESXwZ1mYjBBk+OX/
 Uh4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GCfac3VUptae3+8DdnNwJpbHbQmb+lGzeAdiPY/7WdAehFSW9XqdmNgk9Lr2UhSglOL/F6yh2hxE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeXOdgFae4nbFLn0b8BK+u3tFvBceHW6le+TGm309BAor9odfB
 fL0+fTsuG2XF5JxB59YMGaCqKmeXXOlRp/iuQi2ZM3+i2PmjxxT2sidzSQVRf+tjMLssRbriNSn
 KDumRxxlr/L6zbxFDT2wmlWnyDsX662U78xg0wVW8nOmCLAJrlXeUiO5TRdWa5pk5U/ipzJ4CaB
 t2nJQ=
X-Gm-Gg: Acq92OHTSomxY8wbh5xuTE0GKEMK4OiiZ5LUnzXYFrXAsSMG6Rnnk6cescdmg7lU8lv
 5tJFuZkIcgMl6/3IY+5Q0h2mhAuEAZWxDT1XD9t8RjUGkOH8zDmu90VOQ6Zi+wMAogQkTMLg1ON
 AIlnqYke8FW7mIHyRYdpTHF5wWr+1LQN8EF+gsCe0UPkX4E61dIUxQpt94m0xy6YpwxL2J6KZPk
 0X8XJXBztObj/cMIUUOA1OukV4auLCYdNgb51Gc5xnaD8iQZgCWatC5xKQ+auBV2L1Pdjdok38c
 04+5rIMgzqEVTrqld5GkGryJw7xon1QnhWWNeaZXPp/sXgqs5hWz80RADkhtO/XBSOd+/0igh5y
 RFfmxuyTmxdIGKRZyet4sAYG+cOdsATVPpFqpAWeGvg==
X-Received: by 2002:a05:6a21:6d9e:b0:39f:2b9e:e489 with SMTP id
 adf61e73a8af0-3b22e70d3a6mr25668444637.13.1779266402735; 
 Wed, 20 May 2026 01:40:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9e:b0:39f:2b9e:e489 with SMTP id
 adf61e73a8af0-3b22e70d3a6mr25668409637.13.1779266402224; 
 Wed, 20 May 2026 01:40:02 -0700 (PDT)
Received: from [172.20.10.3] ([27.60.134.77]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb08cde6sm18588546a12.13.2026.05.20.01.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 01:40:01 -0700 (PDT)
Message-ID: <83ff0d14-1cad-4ca5-a512-05773c36cd8d@oss.qualcomm.com>
Date: Wed, 20 May 2026 14:09:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup
 reglist
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, Sean Paul
 <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
 <20260518190735.16236-16-robin.clark@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518190735.16236-16-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0d7363 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Q/5yxSSCruZ1lXPW2Frkag==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=r2EW3oPWh8cgNxWArIsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: EyRnYwD4ys0HC0P2tbIRVkrdKFjZvkRv
X-Proofpoint-GUID: EyRnYwD4ys0HC0P2tbIRVkrdKFjZvkRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4MiBTYWx0ZWRfX4ItJvb+o6zOr
 5KfKHSLFR7gQoIrt9uToeDYiO5CyXBAw3YJR/et8iYK06ed1z8/mHM+2+4M66Jlw68rimGDmCOj
 8GWwkoMNm6gleAPDs8djT5vxQfIXOOgbKfIpKkUAlt+X7PJU7+T/YOzD0C4iSbZgfPUXejZoRPW
 +EMT9q+eW6iurbzlNhK4PCpn/Tb/p4B3Wgu+hrh+iZMD+uawhbw+yCoFx5cuGXm0z8JNvGX5oTI
 gS6UXOzjT9yHm9wiNL42GoCarZZGiCKN/up8UDeS++DvOqLlqDmkC8o0dOTKdbYFQGd42i7sSin
 l1/mki9GCOj6mA2gV9unHD7LrHkn3yIx497L+th1bqzxwmKb2t5ZMFCpdtIsoJOLplXYdUc8Wb5
 XYJYeQ1NjEOS3JUCnDD4A1zmMsVfZYVlhd/1tBzP7q1tOiPgun1YSC++xeQRvojQhSTtB16HhY4
 PRaapABncWGEIz2jZDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200082
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

On 5/19/2026 12:36 AM, Rob Clark wrote:
> This is needed so that SEL reg values are restored on exit from IFPC.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 82 +++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 11 +++-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  1 +
>  3 files changed, 87 insertions(+), 7 deletions(-)
> 

<< snip >>

>  static void
>  a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>  			const struct msm_perfcntr_stream *stream)
>  {
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>  	enum adreno_pipe pipe = PIPE_NONE;
> +	uint32_t *reglist = NULL;
> +	uint32_t *reglist_sel_start;
> +
> +	if (to_adreno_gpu(gpu)->info->family >= ADRENO_7XX_GEN1) {
> +		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);
> +
> +		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
> +		int off = (2 * lock->ifpc_list_len) +
> +			  (2 * lock->preemption_list_len) +
> +			  (3 * a6xx_gpu->dynamic_sel_reglist_offset);
> +
> +		reglist = (uint32_t *)&lock->regs[0];
> +		reglist += off;
> +		reglist_sel_start = reglist;
> +
> +		/* Clear any previously configured SEL reg entries: */
> +		lock->dynamic_list_len = a6xx_gpu->dynamic_sel_reglist_offset;
> +
> +		/*
> +		 * Ensure CP sees the dynamic_list_len update before we
> +		 * start modifying the SEL entries:
> +		 */
> +		wmb();

dma_wmb() is a lighter barrier and provides the same ordering for memory
writes visible to devices.

> +	}
>  
>  	for (unsigned i = 0; i < stream->nr_groups; i++) {
>  		unsigned group_idx = msm_perfcntr_group_idx(stream, i);
> @@ -2567,17 +2617,15 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>  
>  		const struct msm_perfcntr_counter *counter = &group->counters[base];
>  		unsigned nr = group_state->allocated_counters;
> -		OUT_PKT4(ring, counter->select_reg, nr);
> -		for (unsigned c = 0; c < nr; c++)
> -			OUT_RING(ring, group_state->countables[c]);
> +		perfcntr_select(ring, pipe, counter->select_reg,
> +				group_state->countables, nr, &reglist);
>  
>  		for (unsigned s = 0; s < ARRAY_SIZE(counter->slice_select_regs); s++) {
>  			if (!counter->slice_select_regs[s])
>  				break;
>  
> -			OUT_PKT4(ring, counter->slice_select_regs[s], nr);
> -			for (unsigned c = 0; c < nr; c++)
> -				OUT_RING(ring, group_state->countables[c]);
> +			perfcntr_select(ring, pipe, counter->slice_select_regs[s],
> +					group_state->countables, nr, &reglist);
>  		}
>  	}
>  
> @@ -2591,6 +2639,28 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>  	OUT_RING(ring, upper_32_bits(rbmemptr(ring, perfcntr_fence)));
>  	OUT_RING(ring, stream->sel_fence);
>  
> +	/*
> +	 * Update the pwrup reglist size before flushing.  Kgsl does a shared-
> +	 * memory spinlock dance with SQE to avoid racing with IFPC exit.  But
> +	 * we can skip that since the ringbuffer programming will be executed
> +	 * by SQE after dynamic reglist size is updated.  So even if we lose
> +	 * the race, the register programming in the rb will overwrite/correct
> +	 * the SEL regs restored by SQE on IFPC exit, before sampling begins.
> +	 */
> +	if (reglist) {
> +		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
> +		unsigned nr_regs = (reglist - reglist_sel_start) / 3;
> +
> +		/*
> +		 * Ensure CP sees updates to the pwrup_reglist before it
> +		 * sees the new (increased) length:
> +		 */
> +		wmb();

Same as above.

-Akhil


