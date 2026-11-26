Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RwDKNoTD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QtVHfrN6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8D610E3B1;
	Thu, 26 Nov 2026 19:13:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F3E10E425
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:13:45 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQFu4wh4049053
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h1UFGITbc31w1LxPCll7J1WmlLDmP1MiT08SYmYOrz0=; b=RwDKNoTDrd8OqzT1
 TgtOqdEwMzzyJD5/4rINp1dTkHD4ONkTvv7u2treSFn/SjouCOeegRJpyf/B5RmT
 U5Ld2Ap+Z3i0rOMxhBOUgIh3lb64kn00wvt5/w2pTnk90bCFCqlpTSNGox66vk5m
 +Jms5ZjChrPmZgrK9s0H9bxrtjIKXY7o/hbgBHBjg1kHxyWij2jM10CHSUzzY/Bs
 WXw/wtkOkNFg5nkFnYikRMcvMtnGi9U3niHDJ8/yHUjxXrJ5iSkx21bzJEV+LbG6
 zX1kchnlYWDDMJ0VUvnPzg6mFeIUQ4Naku4LHaERM4WS9TD6Ww4Muuy2Ovn0hG1F
 M+GwzQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rjn8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 19:13:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso11651963eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795720424; x=1796325224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h1UFGITbc31w1LxPCll7J1WmlLDmP1MiT08SYmYOrz0=;
 b=QtVHfrN6gspcfweHhdDR8jBiZCOBN9aqy5A1Aaj1c8Fu5RKrOokKXApwBq7egNB6av
 74/ROARNsQ7Z9g+Gpv+tYnEDrJcq5MxESZg6BmAn7KK/QWMdg7g3BOUMBiAJFwSdlLjs
 SSdKYzl8/duK7EXe9ngEPHZf6tht/emlSU9VrMMPRUDXIy2ZhPX1uIFXmpxukmdjcDuz
 /XzgOdlemn2g12L3UK0sBO9xtRQ4NxY8Zxui8GN7UVlWLKkqjzyI5DUd8FZImjREDec0
 ZXjeeQHxv//Oos39IIvcbPNjjn5Z6g945P8sO7ixZeIrBo9+gyL251Gids00DEoY8TVZ
 jSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795720424; x=1796325224;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1UFGITbc31w1LxPCll7J1WmlLDmP1MiT08SYmYOrz0=;
 b=JbqKn3Xd0Xx5wNfo2Fbi7kA1Ll27OIyUrxqM/WMEFvR23/zHSw1sXyR209qmg/w1VZ
 JHN0TQCtdM1XwDPv+qDCaenzL6kIn80MLQua2UnzDZKqsAQ5ek7Sqe4et6RzFBaEfOV5
 MbW3TbGleZAFg4cuUZium1uuKtzqLzWitVBeERbpOOVIGMWz7zt6LSi4j4MzkE+cd+Yg
 3n42+ekNe4QuCPDBRcfT6is5TvWscyPNHXFuJZ+ar3vLm3Lw1ECfR0tz2DBOcPgLMxJw
 iVHnGQHakBbCmHwoLGYtuIfecxn0fqxoFPEIkwyoW67rF/38oaYy6RwQA8fuimHScOZT
 6daw==
X-Forwarded-Encrypted: i=1;
 AL+hErF1eV9XjBVySRfh+9xU3u4DomNtT+LhHp97pMKmTnPwSalRwEeLQrSNkMi8J7oPvV/DZgaVUfJSeos=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9XTDedOvcl/b9pOewPQqzobR6TtGh1zW82taqM1R6mElkNEMgq
 Q83C6hdhWEp63KTO3+Ub4UrYrPL5RXVgPuTlxB9fC+IlmFNYfgQSekcFYPeKQO/W/zZwAy2B8D5
 iDhsxwxBcWtJWMvZ3aC4bh7JX1vTWPm7f9DoR0aBs4HEHgO1CYlCfb5CAnJ+itVFNstagRn4=
X-Gm-Gg: AZFdTZfzkz0djaB7mFE5dYyUO4j6Dlw+tm9Vr2gY/GflasNF+HgMfqTpkfzU4lucKBa
 zcQbDyT/Qo+HXk+MRIVSwUpivscaAZr8RaPpAEPcVDpbNIKIF1oMFUkrdUvRkD3Tptk7/Gg6CzK
 AKeJIvRbImtmMfhLt5jlCst0BO7B/3sFO4719fecfkynP7E7gFIjnVBKWMMRw0THBdQk1ovNRmH
 xfHQJQ74B0Ci+3j4xcgl3A/MRKDEQlYY2+5145KuItKbvI8lsVAspPdbg6RKmFJXx6Q0JLhW3Fe
 A95WW0wSpAuUZLU77/4mKpL4QEGt8G24d1qCD8yZTVQ+sLvigsByo0pw3BkBz9t9Xxhue4iHw2F
 4GWCU8WWicmot7t+x2l3cd0NKAgYM1LCKVzRlkVBL1ftKh7FMMa+pAtTR9DrL/xHIzfH7nnwDhQ
 ==
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id
 5a478bee46e88-3869b9cf99amr16692853eec.3.1795720424122; 
 Thu, 26 Nov 2026 11:13:44 -0800 (PST)
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id
 5a478bee46e88-3869b9cf99amr16692820eec.3.1795720423545; 
 Thu, 26 Nov 2026 11:13:43 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386b9bdafb5sm32792874eec.9.2026.11.26.11.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 11:13:43 -0800 (PST)
Message-ID: <ea19dcb2-9d9e-4d6c-86f5-72a677fca5b8@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:43:37 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/msm/a6xx: Expose GMU IFPC entry count in debugfs
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-3-6992841a9a32@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-3-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NSBTYWx0ZWRfXyBe1vTQV3WKK
 /b9XzkWIaA6uIvagiJmyvccFqVga+YWBQ/Epnc9L1PipPXnmrVG0Lucnb1SVRlQp30QwYSuGlE1
 4qnzoJRuBU4Kqw8eIO34I7rrMkIpoBZWPp8SN0CiSpQMusuC89EPx7JVuyZzrRZGru0x9m59cb4
 Dwbmx4ugTQNIc3H5sIaUk/iEKLqZvMxV8/S3YZg9x4rrZ2fuUQY0QtJsI72sejAltCzbI/QLSgR
 P+DWh+n82SbLT3uXdNY1DYee6Df6eNgywvIAF2WMokmTgCJwZCIlOyr/kIKG5+ZCbi6zvQ7brSL
 dKP/sqhGZLXHjDcBfKo3fiuJfJtw3WyJeGuPfszCcRSGi2noMeRKyO2nXcD90l5S37vmmE7WVpb
 tqvTTswozE1k0aKpdqaU35ESg/oVYFKdRnV7Z8yRL7DEWp7cVWney0t44RnQAtkxL+hhwc80GmT
 97UH3gWgXjLcxmHBOVQ==
X-Proofpoint-GUID: I9N0xMcSG5oJfhtr4cjRzFt947fCV3_J
X-Proofpoint-ORIG-GUID: I9N0xMcSG5oJfhtr4cjRzFt947fCV3_J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NSBTYWx0ZWRfX2t+jCoP6ethO
 7QhmWDY7ZZV25JxLPyzwS96kUIWCeC/8n17rkPa6GQiThRI5cAPJBcGJo3t8CLZviUfDyoRCu83
 ac/08dNw29kSlZ6LacZkFTJkgdnqDcs=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b0884e9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=4juFOUNQJm3OhpHwc1AA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260075
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/2026 3:33 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Add a read-only debugfs file, ifpc_count, that reports how many times
> the GMU has entered IFPC.
> 
> The count is accumulated from the GMU XOCLK_4 power counter. The
> counter is selected in hw_init, and the delta is folded into the total
> from the busy callback, so the value advances whenever devfreq samples
> the GPU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile              |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_debugfs.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 30 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h     | 10 ++++++++++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  9 +++++++++
>  5 files changed, 73 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 1e246616f83f..afd42e5bda00 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -30,6 +30,7 @@ adreno-y := \
>  	adreno/a8xx_preempt.o \
>  
>  adreno-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
> +	adreno/a6xx_debugfs.o \
>  
>  adreno-$(CONFIG_DRM_MSM_GPU_STATE)	+= adreno/a6xx_gpu_state.o
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c
> new file mode 100644
> index 000000000000..a3f622cb189f
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Qualcomm Copyright?

> +
> +#include <linux/types.h>
> +#include <linux/debugfs.h>
> +
> +#include <drm/drm_file.h>
> +
> +#include "a6xx_gpu.h"
> +
> +void a6xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +
> +	if (!minor)
> +		return;
> +
> +	if (!(adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC))
> +		return;
> +
> +	debugfs_create_u32("ifpc_count", 0444, minor->debugfs_root,
> +			   &a6xx_gpu->ifpc_count);
> +}

Can we keep this in a6xx_gpu.c untill there are more a6xx debugfs nodes?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 48d3ee4d55d9..e7c3da5d3ac6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1338,6 +1338,11 @@ static int hw_init(struct msm_gpu *gpu)
>  			GENMASK(7, 0), 0x4);
>  	}
>  
> +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC) {
> +		a6xx_gpu->ifpc_counter_last =
> +			gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L);
> +	}
> +
>  	/* Select CP0 to always count cycles */
>  	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL(0), PERF_CP_ALWAYS_COUNT);
>  
> @@ -2334,6 +2339,17 @@ static void a6xx_destroy(struct msm_gpu *gpu)
>  	kfree(a6xx_gpu);
>  }
>  
> +void a6xx_ifpc_count_update(struct a6xx_gpu *a6xx_gpu, u32 cur)
> +{
> +	/* A counter below the last sample means the GMU restarted it */
> +	if (cur >= a6xx_gpu->ifpc_counter_last)
> +		a6xx_gpu->ifpc_count += cur - a6xx_gpu->ifpc_counter_last;
> +	else
> +		a6xx_gpu->ifpc_count += cur;
> +
> +	a6xx_gpu->ifpc_counter_last = cur;
> +}
> +
>  static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> @@ -2347,6 +2363,11 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>  			REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
>  			REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
>  
> +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
> +		a6xx_ifpc_count_update(a6xx_gpu,
> +			gmu_read(&a6xx_gpu->gmu,
> +				 REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L));
> +
>  	return busy_cycles;
>  }
>  
> @@ -2818,6 +2839,9 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
>  #if defined(CONFIG_DRM_MSM_GPU_STATE)
>  		.gpu_state_get = a6xx_gpu_state_get,
>  		.gpu_state_put = a6xx_gpu_state_put,
> +#endif
> +#if defined(CONFIG_DEBUG_FS)
> +		.debugfs_init = a6xx_debugfs_init,
>  #endif
>  		.create_vm = a6xx_create_vm,
>  		.create_private_vm = a6xx_create_private_vm,
> @@ -2889,6 +2913,9 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
>  #if defined(CONFIG_DRM_MSM_GPU_STATE)
>  		.gpu_state_get = a6xx_gpu_state_get,
>  		.gpu_state_put = a6xx_gpu_state_put,
> +#endif
> +#if defined(CONFIG_DEBUG_FS)
> +		.debugfs_init = a6xx_debugfs_init,
>  #endif
>  		.create_vm = a6xx_create_vm,
>  		.create_private_vm = a6xx_create_private_vm,
> @@ -2921,6 +2948,9 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
>  		.gpu_busy = a8xx_gpu_busy,
>  		.gpu_get_freq = a6xx_gmu_get_freq,
>  		.gpu_set_freq = a6xx_gpu_set_freq,
> +#if defined(CONFIG_DEBUG_FS)
> +		.debugfs_init = a6xx_debugfs_init,
> +#endif
>  		.create_vm = a6xx_create_vm,
>  		.create_private_vm = a6xx_create_private_vm,
>  		.get_rptr = a6xx_get_rptr,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 79912a33e17c..8f0cb168a535 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -139,6 +139,10 @@ struct a6xx_gpu {
>  	spinlock_t aperture_lock;
>  
>  	u32 slice_mask;
> +
> +	/* Total GMU IFPC entries, accumulated from the XOCLK_4 counter */
> +	u32 ifpc_count;
> +	u32 ifpc_counter_last;
>  };
>  
>  #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
> @@ -254,6 +258,12 @@ struct a7xx_cp_smmu_info {
>  #define A6XX_PROTECT_RDONLY(_reg, _len) \
>  	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
>  
> +#ifdef CONFIG_DEBUG_FS
> +void a6xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor);
> +#endif
> +
> +void a6xx_ifpc_count_update(struct a6xx_gpu *a6xx_gpu, u32 cur);
> +
>  extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
>  extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
>  extern const struct adreno_gpu_funcs a7xx_gpu_funcs;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index f892731cd3d3..ba81a1c9c551 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -680,6 +680,10 @@ static int hw_init(struct msm_gpu *gpu)
>  	gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_1,
>  		  FIELD_PREP(GENMASK(7, 0), 0x4));
>  
> +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
> +		a6xx_gpu->ifpc_counter_last =
> +			gmu_read(gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L);
> +
>  	/* Select CP0 to always count cycles */
>  	gpu_write(gpu, REG_A8XX_CP_PERFCTR_CP_SEL(0), 1);
>  
> @@ -1354,6 +1358,11 @@ u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
>  			REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
>  			REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
>  
> +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
> +		a6xx_ifpc_count_update(a6xx_gpu,
> +			gmu_read(&a6xx_gpu->gmu,
> +				 REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L));
> +

This is all unnecessary plumbing. This counter is not useful outside of a litmus test to see
if IFPC works. Also, this won't work if devfreq is disabled for some reason
or with performance/powersave governors.

We can just read the register from the debugfs callback instead.

-Akhil

>  	return busy_cycles;
>  }
>  
> 

