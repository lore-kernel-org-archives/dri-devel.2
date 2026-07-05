Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5320C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137BD10E1A9;
	Sun,  5 Jul 2026 12:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8gyfHdU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDTp40pD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC7610E1A9
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 12:08:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6655tlNt896558
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 12:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=; b=P8gyfHdUAKSYbw5F
 ebPDrmUaIX13Jvn7JpP3n+q2E1UyjZJPvFp1eFAxNT5r9u5//qLxaHYmrmLHJ1QB
 rU6mbCndxiBnsUpoWGzNIxON+uFnzuEJjJiR/vblAOxOhgzg421bfw+xBSUNyN3v
 dECLnkLM9iGPoO0cjONObMCUB3R1zLv5WEXtgnGlOfImdbX24ZtX/2OEsrFZ+s+V
 0hlfG17GbXz4VT/5JNWGKdSV3kvOrYRizXR81CsilZXcgfVSVbmI6i+0VBalQQ7B
 owMYY3wAmNW4t7tV1dMLajYQtYISi2YPKOpvUZGFHG2ONseW1h4n4GVRtwvOiLx1
 D0HV1Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgty1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:08:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ab059052so1700864a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783253304; x=1783858104;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=;
 b=kDTp40pDSOX3YFRR5fMgJSJE1UcbxuPOqTPCYJuIJh2tPvxfwoaRJWIGOMsbAOYK7b
 8Ly9/ZFR7bJ7bkAMN71AEKPiXkTYzazPE/CPHNxr1U4zUHupKbnqfec5/YzSaiFsfysi
 DUBF3wG4732YBupBvs19yLF0KKLEazEyKdSRjStG5xuHyRSNTVluquapeNdy4cQN20p/
 g/GXD11TxeEWf9VQGKqDDVqLbOzK0dg8nr+sn2hUbopjZpOK855MBM3jDJWBJIXLMG3k
 1Ma93DsivO5xjeH0eJ4VUoPqicZrt4ndRw8GGwkbtIU+L9vM6Di8Ifxte+JyTjKwd55h
 3bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783253304; x=1783858104;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=;
 b=ermEsBAY0FJ5JJXOCmrk3mnEYKrna4pVW71dWjVfw+KlUa7SQyuGiap5VbxS9H2AYu
 Xt+aj7Oz3fHJ0Jju/HVtzfS1PMsYEg5aTsM5yYGhxKm4a57y0xReBhVjPZ8ypuEdwdUW
 QVm2cRcl58CsmUvxWlEiT65Pdd5QCCvzXd3oV+rzEHNRukXGCw3um3HRau5QalaAGLLx
 yOjSKmGF+TDvdUbVVBpecgz6o3UtS8Co3VB2LaNq6KYCQ5cB3tLNeUGgLzNCGrf1Pcol
 pukAQd33NXcbW1wx2NhqjJ6lCE6AD8QiVcdGC7dlQgxCTStFZNRJT504Y3BrkU1UtQJA
 OXJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQkV8voUR+bdPMdAmvn/iekv4Q/3/IwqP006TPzoUwNtPT1BDL493Wa4VHr6A/6CkjyuAauu/Cn/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxneNineuvrtrf+RG0OwNWOn6TxiLBxd4ECij5rW16VCZfMPZ6d
 ubBh9Az0kd+jllCbyN3XZW/BLJW1bkZxSoUbz7GHbe7PacOhjpVuK1gOr+B9PoSVpQvkMMgTJJe
 5eqN2dvwiWpaEczlTsNuZp7460dbTiGBKanL6rQD+tlNSjd+Vj6zF779hFijjqYtw0XayGEjsGD
 wcK4w=
X-Gm-Gg: AfdE7clJ9BrmIWvpLm/xC15CX9VeyOjjXyqjpf/92stUF7/8kp0Lf3WdNloUtvim1Il
 hC8wpNMzzb6z+DkbyyV13SU9zee3nEaXnGxKimJhQlHmb1UOvsxhI7eSaPYKDYu88nZn5D8Dgga
 h9VOUDge5fhm111PHAlzmDhV9sgX8Ds+OI6po8pODZxMRGR4OGqpR9J/93qlJE5UdRnSPmtZW0J
 DqzPK6GFzr8dh2kV8FZgBGQZ0k7JInkyL6OLkv8Xtp4wk/Z6qoNIZiXIxvBLj2ywLOqsejiRT6C
 EUNbK/Q841W9OjmLH8nw0qOJh47QJrxWd0OTppFoZPtE6vDE9pnFOWqQ4bYLn10m1mNOV4NCLi/
 VuyORmW6nHaOfK6o4oHrC+da//3Jykoue/A==
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id
 98e67ed59e1d1-381122ebe5amr11701448a91.11.1783253303551; 
 Sun, 05 Jul 2026 05:08:23 -0700 (PDT)
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id
 98e67ed59e1d1-381122ebe5amr11701402a91.11.1783253303057; 
 Sun, 05 Jul 2026 05:08:23 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.78])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31151fff32fsm6354185eec.21.2026.07.05.05.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 05:08:22 -0700 (PDT)
Message-ID: <81c657b0-7e61-4db3-b72c-46c213c707e9@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 17:38:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm/msm/a6xx: Increase HFI GX perf level limit to
 24
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4a4938 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b2dfFiZiitoj8S2i2yzycg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=PFfvJpCOjzcRVZi79uIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: _Hpv_XEO_EApsavrBttak0WU2W91Fs_H
X-Proofpoint-GUID: _Hpv_XEO_EApsavrBttak0WU2W91Fs_H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEyNyBTYWx0ZWRfX1BW2UuQ+sXng
 rWITM3KrPpFxjnf+ZkSXK57mbfmh4PrKMuPf8TI82L5mLPe9n8KcZDjC6x4tLeHBWd2/h7Y0nzh
 R+OxpQSdwM3sYBVtYR4ZcI6lDgkkopM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEyNyBTYWx0ZWRfX4R2ymdJW4ubQ
 ZEDYTDayRQjNHWPKht8ad4J1cuDfW4XWXAaYMlKls8Efqhx8sajQo1dn1CzP/MgQEJpIG9ZrFQ9
 ujC3vOGBAGvFHXVdZMfzuUHcRCR1bfiChXB5HbYfk9guXuWO9QfRMNu1oud2i8V6tjlm6uUmxS5
 Z8RxnqkBquSfZcDR13L48GfRRynunflrOGZIPp3db9eJC3InNqRgkMlesX20l8K0v8BEiUnSXBm
 FM7eggU9T3p227YLVPGtZOTxD0K6L/c2Om1CBVoxbT+EvuWgBvfCcKGSjmgenSKD1ea5J0MdBvw
 HkDExU/QCWOXciLWMfl3CLFZbXZbsgaZ1jWl52DarqHvzgMojqsMcYb+jIes1GJVWJwsOrVt8Fq
 4i4sAOarFkthFOJA1tn+6UT1/C586qQ8UJINQIOdcGvwhDdNhN0U/K2p6YPBVLAi+o/hvmP7SvU
 vWGBl5s2nABsmU6Vaew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050127
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

On 7/5/2026 1:30 PM, Akhil P Oommen wrote:
> Newer Adreno GPUs expose more than 16 GX frequency levels. Introduce
> HFI_MAX_GX_LEVELS and use it to size the perf-table and bandwidth-table
> GX vote arrays, and to derive GMU_MAX_GX_FREQS, so these levels are not
> truncated.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 3f96b10b5f61..62e3fb230cd3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -20,7 +20,7 @@ struct a6xx_gmu_bo {
>  	u64 iova;
>  };
>  
> -#define GMU_MAX_GX_FREQS	32
> +#define GMU_MAX_GX_FREQS	HFI_MAX_GX_LEVELS
>  #define GMU_MAX_CX_FREQS	6
>  #define GMU_MAX_BCMS		3
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> index e10d32ce93e0..f4da73a555c6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> @@ -5,6 +5,7 @@
>  #define _A6XX_HFI_H_
>  
>  #define HFI_MAX_QUEUES 3
> +#define HFI_MAX_GX_LEVELS 24
>  
>  struct a6xx_hfi_queue_table_header {
>  	u32 version;
> @@ -119,7 +120,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
>  
> -	struct perf_level gx_votes[16];
> +	struct perf_level gx_votes[HFI_MAX_GX_LEVELS];

This will break older firmwares (A7x/6x). Luckily, A8x uses
HFI_TABLE_GPU_PERF interface instead of this, which is more flexible.

Will drop this patch.

-Akhil.

>  	struct perf_level cx_votes[4];
>  } __packed;
>  
> @@ -128,7 +129,7 @@ struct a6xx_hfi_msg_perf_table {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
>  
> -	struct perf_gx_level gx_votes[16];
> +	struct perf_gx_level gx_votes[HFI_MAX_GX_LEVELS];
>  	struct perf_level cx_votes[4];
>  } __packed;
>  
> @@ -144,7 +145,7 @@ struct a6xx_hfi_msg_bw_table {
>  	u32 cnoc_cmds_addrs[6];
>  	u32 cnoc_cmds_data[2][6];
>  	u32 ddr_cmds_addrs[8];
> -	u32 ddr_cmds_data[16][8];
> +	u32 ddr_cmds_data[HFI_MAX_GX_LEVELS][8];
>  } __packed;
>  
>  #define HFI_H2F_MSG_TEST 5
> 

