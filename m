Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B31CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDEE10E6FA;
	Mon, 18 May 2026 08:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YA5NaFXT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cheQPuKU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD67C10E6F6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:05:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I3QVAm1683834
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 le7TwpeIaCt4Dszj2+Eo4xIdzJ64VCiTbnhEt4L1OnA=; b=YA5NaFXT1UdDLSIk
 P3pVvYwWkEdF47yMa2THbxzgoBXfGVHqyz5YYSVMulnzEdWkvsA6WyckBWO1a97P
 MMG2m9P9pLiParKDT0TpgLwvk4tR083ttlkqjVWGvzTpoJipJdGlVJLHOVgsVjsu
 NgQ4DToZ3UZ24/sdE/yWq+Qz26JFv6RSNG36q5n8brUdvyvEvaSKrB3D/lfTMHJo
 ntEdr8Rsyj7n/n0kRhKth1onOvRxkLE0Dn1JKntkI2r/bSEOtQRkmGCvKQZjrlDX
 zRLKLmDnHlqLzUxfG9MJs29hIJ1YcnJKyubBb9iJQBT/GOMmwuFwO+Huz1xZbIaX
 SIonMQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7w9q6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:05:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb98b09d3so7411241cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779091558; x=1779696358;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=le7TwpeIaCt4Dszj2+Eo4xIdzJ64VCiTbnhEt4L1OnA=;
 b=cheQPuKUyQ5DLw+dPYR7nHPq/dGqcKPMfYpCDbK4DX+vHWI50vLt0V4eJ6T6Kpqtjs
 mb1VIviwkCKbhWU2F2uW6z9zP5WeYv7iGdqlqUpp6xUAtYrLq8jc0h4/UIboLj6DgQqs
 85uSDXML7dpPYgcKvsph0NcjqBB/sUisPj5vi5GrxsFkkFJr5hicSR1pk6BPpfy6M3lh
 P3WfANjJyaGPb9HMHKIHeDdi0j7gH4lUSsm1ESM/EYDG7YbyCowZP0Q+aTKx5WQ3Z2gd
 OCLwXehBB2GrvIZgqU3DVn98El1dum4/V/IOQRBbpVNY7v23UqKU2pmS0m0CSURcEMgT
 6IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091558; x=1779696358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=le7TwpeIaCt4Dszj2+Eo4xIdzJ64VCiTbnhEt4L1OnA=;
 b=o+KT0cbiISyeAyuxRTBjROc0THoN57MgAmKlPClV5qz7LOLK5yLQKD+xZZOV0CTL9I
 vF7ZzDPVtDDQnf/thXTAiYE4f8+6eGkO57E/+3DJTLBXd22zZYZ/pfY1UayWHuMi1TnP
 1VH/5jrqpEhgFtBtz3AytxCGgGrpsGA8nDqwMr+0Vv6l02pFVRhRUeW8fLKuTpT5JD1o
 ux23ImRKax9+gL6OeF+CyKPgGcYbBPjIICw1sinOGbyEs9hNvuTR0MnlKka5BIhZuqif
 CNRIuTKZ7qR+mkEE/Ex2H1AETFzUWK2yf6q21ZSTb9mIRkl5eeaRQf5iXmPqf0NSgGen
 eVrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xLuL45UwRFZwXV4tKnP2kesLWGN/nA9Gy76o+qEJXqwKqGh5qkm/fcenGYCDrfWo7R1omGtMQjeI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUQ8a64LuRuW9VoaNG02epJ6PZ7mMrHXsRW7mR6m5b4cnTzHT+
 E2yz95a6vu18cdAUn9BYB8PzjeL5UaJLeWJTt/4RdvP3RVv9QO3AIVzHjTB7XVKeRhX3EDUZSLI
 chiOLy7GWUn+MhCQyov/QjxFRErY4Cr8LNcR9OuYLP43MqA06mnDQpC6WzrsXBhxJLHesp9lz4m
 ZZiH8=
X-Gm-Gg: Acq92OHoU21p7/9NDsTO0AAAKYzd4n3FJi3pYsP+yUPmBqCidkEkRtEXhU5EiWuRz9x
 xtLHseMcp2V5tWIWPqwEPYuY0L8+eJPWO8gZn6JSgwIOJ7GM21Ul6ypadGgCCdIGqkkB2MFOHK2
 oE9H/ZpcBR3aA3Q4rifp72ZJFEaXIAgcR/3zDIQjgVemYYx+G0WTmTdKIK969c3UXvRuVPSvJXn
 RlvxgOFN3cnA8sbUfHa3fkOErbc1SzFNCl1PaYpvQ0c3nlP6tv/ccg+5XXmSvo1OVSP8KC5Q1kp
 qgtTL2HIPjiWQzaHeuYWahQWTBW/7/RE8t1edPgC37W1XgyA4Zkh2+6cN08iAvCXaFawocQUJ6s
 lzMCFnkTuB7bUdAhshhGrznmBj9cp47ljd/0iUA/cBE7CQIxE2JcYE40hs0iiTDri7kGLfrmZsO
 6nb0M=
X-Received: by 2002:ac8:7dc4:0:b0:510:144a:636 with SMTP id
 d75a77b69052e-5165a22eb4emr131419971cf.8.1779091558193; 
 Mon, 18 May 2026 01:05:58 -0700 (PDT)
X-Received: by 2002:ac8:7dc4:0:b0:510:144a:636 with SMTP id
 d75a77b69052e-5165a22eb4emr131419781cf.8.1779091557649; 
 Mon, 18 May 2026 01:05:57 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd1bc9sm545007266b.9.2026.05.18.01.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:05:56 -0700 (PDT)
Message-ID: <159aa418-ed40-479d-a635-a170e0ab06c5@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/msm/a6xx: Add HFI support for CLX feature
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260516-a8xx-clx-support-v1-0-62508bf651ac@oss.qualcomm.com>
 <20260516-a8xx-clx-support-v1-1-62508bf651ac@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260516-a8xx-clx-support-v1-1-62508bf651ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3NSBTYWx0ZWRfXzwROtzcEMQPe
 SIbKuilwIRfVBOf7Q/VFoYfpqYR/3Z+DvzEyohCAKOf3WJadJfDqbwxibxMH9SD5RPvJIuA2Ahi
 c+LgSfdr003GNyp0Or2QCJCOlHMSsz4+2uwMGC5J0a7W/dAHz8/Z3OUFukWLQgwDROCOEXiG4Bj
 7qhzpkkq3YonEEA9yDLDCvX5RW8kc2nQETccui0fH2XvFsrhxIXn30kcSFhmc2EMwKaRRKIlZkt
 Ya6EPF2LWwbaXgWwV82JXv2MtdzxVNLmOTmJwtfSS06IsMxP74/AlooSTgInsTeePKSGVOs1EXi
 NanCbQwLg4ZulnbY0VyXBOqNdMvEHanG+GFbUZfWorI4bNMTQq0SfA+NSUoXryNE87FFAn5h2Ms
 YSUf95nkInldImuPaHmkeT/nbytx4SO0kETEm1hSDLn/Vz4fBIT4NKZqagKKA7HIjPuhwyxXi+a
 llO8W3L6VYijyoQ/b1Q==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a0ac867 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=2SAFw1Xh2MQk1rVR-FgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: SVTiPsKYOmi_pijCcAnq_lBiwcPBWEQz
X-Proofpoint-GUID: SVTiPsKYOmi_pijCcAnq_lBiwcPBWEQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180075
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

On 5/15/26 10:07 PM, Akhil P Oommen wrote:
> Add support for Current Limit Extension (CLX) feature found on a few A8x
> GPUs. This feature is required to limit the peak current consumption to
> avoid HW spec violation on GX/MX rails.
> 
> Add the necessary HFI interface support to pass the recommended CLX and
> IFF/PCLX limits tables to the GMU. Per-GPU configuration is consumed
> from the catalog entries.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 15 ++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 71 +++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index eb431e5e00b1..f6a3f1924bb3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -34,6 +34,19 @@ struct cpu_gpu_lock {
>  	uint64_t regs[62];
>  };
>  
> +struct a6xx_limits_tbl {
> +	/** @tbl: List of limits table **/
> +	struct a6xx_hfi_limits_tbl *tbl;
> +	/** @count: Number of entries in the list **/
> +	u32 count;
> +};
> +
> +#define DECLARE_ADRENO_LIMITS_TABLE(name)	\
> +static const struct a6xx_limits_tbl name = {	\
> +	.tbl = name ## _tbl,			\
> +	.count = ARRAY_SIZE(name ## _tbl),	\
> +}
> +
>  /**
>   * struct a6xx_info - a6xx specific information from device table
>   *
> @@ -54,6 +67,8 @@ struct a6xx_info {
>  	u32 gmu_cgc_mode;
>  	u32 prim_fifo_threshold;
>  	const struct a6xx_bcm *bcms;
> +	const struct a6xx_hfi_clx_table_v2_cmd *clx_tbl;
> +	const struct a6xx_limits_tbl *limits_tbl;
>  };
>  
>  struct a6xx_gpu {
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> index 487c2736f2b3..13ae34d0d898 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> @@ -886,6 +886,73 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
>  	return 0;
>  }
>  
> +static int a6xx_hfi_enable_iff_pclx(struct a6xx_gmu *gmu, const struct a6xx_limits_tbl *limits)
> +{
> +	struct a6xx_hfi_table_entry *entry;
> +	struct a6xx_hfi_table *tbl;
> +	size_t entry_size;
> +	size_t size;
> +	int ret;
> +
> +	if (!limits)
> +		return 0;

Is this considered a valid configuation (CLX on without IFF_PCLX data)?
If not, let's throw an error here since it's only called from _enable_clx()

Konrad
