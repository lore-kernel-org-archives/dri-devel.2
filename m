Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1605DCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA1010F194;
	Thu,  7 May 2026 14:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSWA7BgP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UrJXMiLu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF56110F18F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:48:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647APIwV880188
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DKXU0I6LMH/BMCj9EeRl1cnpVQr3dSMcJSJRMFTrF9M=; b=NSWA7BgPgkyxZqm5
 9/yjPKr19EdktGHjzpulRC8gXOTgu5o4o5Og3iJPp3IQDycJCdTQAXsMPwkdj+Fy
 eIqK3cbrvmW7VKTCC7BxNH40BefUhXMjp8kz1zI/mdaJc3AnszyxElK6D9GT3Y47
 Bmo0MWn0Bkuhn3ue64sz6QxUCv3TZFWaLWvHhc/Y/i7JYr+y9PLACAQFVSUzPc/W
 MUmD9JF1n8FTnov7EI2QsEZ7i1eSVYBYjetCuVmS/IpaIQq0VNSii1DmQBmN4ugO
 HPy43xDbIAZeOQnpqpCrtjb6Li+l47fK0TDNA3Kb+imSbYeWkC48UhsgWDRHRWLd
 yJahuA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq2asd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:48:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba718173d1so18451495ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778165289; x=1778770089;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DKXU0I6LMH/BMCj9EeRl1cnpVQr3dSMcJSJRMFTrF9M=;
 b=UrJXMiLuCrEA3YEGSDYUK+yyUBl3VN2nj+sCZGtxwADQmoPROHW1R5i9WTLp+HK3+L
 Dsd9LtIyEvRJ+A6ic+kdtd2COpzGP98x+CGjd63FwibifBLRrx/Cng+dDd1/OkCQW1/+
 2+f/S0vDoze/lpq+x9oKkwOiwd9dN7afnJkAdzWnJ0ktDeNkHijkyV7lT+6ySditqqZ7
 PQ/5y1XZ2KT+03gBBvanCQmDwp8PhKN5fS2dT7T5IjDwvATdHoZ9haZBfwtzn15deysp
 NsXMFN+tyQDtvGYzUNohPnrpDNmVatIRGhx+gxCI4XKL5wR/VVMEQR2x8zcEH2LKWE1A
 o+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165289; x=1778770089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKXU0I6LMH/BMCj9EeRl1cnpVQr3dSMcJSJRMFTrF9M=;
 b=o5YkBitAwTx6cGFFETjiledwXWBeui+18d+Qc8WnfxPT8SSVXvRvWCm72dHNgfHUVN
 Hq6baUyUxUF8urE0zicZpCT/eaYbPanmTDRIEBASu7BgFBKgWctsaMOCIQHuC+zKbwnB
 omccdH/jixrQfPeDGryazVtthu3ip9y9iT8We3jEVYru0VX5W7oDvrHPdkEg29FiUSc0
 BtmLqhMheFNyfEI9bYf3bpGEMn9dsrOoiubUjHtPDFrRdxWpHBTF2Xh/+0ofXanVzpGz
 jEEu5X93bMncH7nsmt6TibXJpV9Vds8zQyyHZZQAhkucIPTPLD7vbuKhc2bmW5LiLAQs
 u6jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ872YqKNFAKjIsN6S2vOGmheL8sT2nqtmcgCwAa1GpLk1egnwwj8Mmtf4oNJU7D9A6mC2RpMQl36L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOMx29PTJAUUff2Am+ib42aJHvsRjg9FVyM982yuh57Bjr42I3
 Z82vUoZUoCD+V0zCEdNw5Q8ieQbdTcLrn177WVeqBPAGCtc3NTFjXvcJ5CfnbGo7H9OqRrsK9Px
 s+XlLwpL+UFhZ7nVJ2P/n+YlaVvmd2ZPz1kCr4cGmOZubapmygnVB+pnefO0WYEugU+o0m5k=
X-Gm-Gg: AeBDieuxOmoGIZI4kd70s8CT/4+Acww+ef2JJCtCDn/Ub93PYbMACWZ/QUGeE2XO6yU
 RJVXy6SNtVvGbCc94xJAA/53EJ4v04R/pt6VuZP8+QfYGGCaopuORpy4mWvr/DiqEYiYmgAuOlr
 gc7YR38fXkfZ60Cur5dknkWgHsKiXc4h48VbEvIsga68v/P3HZSxuMGI2remRrHtUK6+w5Xw6xi
 1XzW1UURLojd8i0oFX/N/5ji2ZVvBtfWDaEXOfoBJnFIJdqwgONdQ8QfeSh0St40gcMlFFFkPC/
 2l6EX0H4M5pyr/nJUH8kjXv/mxPllHmSlhdm39cLgHrULgKMetzGcQZFQbKw74vkwnvCMeBfsT6
 cM8axpQaAqjgcGgXPY1IU0pyK5teIL7i8PwSh2+ZI0Fmw2mEVL9MXuZDJuB6axXh2LA==
X-Received: by 2002:a17:903:1ab0:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2ba7a34b378mr93506235ad.33.1778165289009; 
 Thu, 07 May 2026 07:48:09 -0700 (PDT)
X-Received: by 2002:a17:903:1ab0:b0:2b2:4bf9:1766 with SMTP id
 d9443c01a7336-2ba7a34b378mr93505935ad.33.1778165288547; 
 Thu, 07 May 2026 07:48:08 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babaaed237sm27158205ad.27.2026.05.07.07.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:48:08 -0700 (PDT)
Message-ID: <6ea04749-d432-486a-b04e-46adaa9d0666@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:18:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] drm/msm/adreno: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-18-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-18-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fca62a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BTchm6ImzknZz8NDhdQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: p5JyaGnfYyxpu7ForRbnwWzqiviCK2LP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0OCBTYWx0ZWRfXybquI4SMaGei
 1LKLSfnVXP0+YFgo7/bQeR9FW43iKPSbjjP6BISOFg/+UQOdv4gnh/SWFs8e9Y87a4YUe4tc4Mf
 f1Sish1THfpxz2iA0W8l14ZK2daE4u5/nCDqnQ7kV7S2UuyXpgsbVG+r9ByM8bQCrUu1CCR3uds
 WtXEz9xVnL/Wv914h9p6XhNAnkejdpmBri+4TuiUxEmFJtVQOMHOwDIJLd+DksTsj5j8xU4yPf9
 nlf8igXLHldXCYWy8woAWxa5OkuE0uL9fAFIOiTu4TZle/UarzN4CCQJAwIyJM3OIYw0r2ML0Uf
 aedw2GqNbKic7R4hnMCllx2yOfgxHASeQ6LCUC/c1hAakH5O42wBFTZM7x4ECStmK6Ky9QOlg+w
 DZRdl6e5zvCIPam+qwIRtVGZINrJUDjF2onQFd/0arAGuB0a3xsXXx98G1rWxbkweJnfatc3YtN
 mACES5WtJ9IsNm/rzEA==
X-Proofpoint-GUID: p5JyaGnfYyxpu7ForRbnwWzqiviCK2LP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070148
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

On 5/7/2026 6:33 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of checking the UBWC version
> directly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 5c17565b0499..a88489bdad9a 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -747,7 +747,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
>  	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
>  	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
> -	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
> +	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
>  	bool min_acc_len_64b;
>  	u8 uavflagprd_inv = 0;
>  	u32 hbb_hi = hbb >> 2;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 867c7d05f670..5c73a9ebb22b 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -279,7 +279,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
>  	bool rgba8888_lossless = false, fp16compoptdis = false;
>  	bool yuvnotcomptofc = false, min_acc_len_64b = false;
> -	bool rgb565_predicator = false, amsbc = false;
> +	bool rgb565_predicator = false;
> +	bool amsbc = qcom_ubwc_enable_amsbc(cfg);
>  	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
>  	u32 ubwc_version = cfg->ubwc_enc_version;
>  	u32 hbb, hbb_hi, hbb_lo, mode;
> @@ -288,21 +289,17 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	switch (ubwc_version) {
>  	case UBWC_6_0:
>  		yuvnotcomptofc = true;
> -		amsbc = true;
>  		rgb565_predicator = true;
>  		break;
>  	case UBWC_5_0:
> -		amsbc = true;
>  		rgb565_predicator = true;
>  		break;
>  	case UBWC_4_0:
> -		amsbc = true;
>  		rgb565_predicator = true;
>  		fp16compoptdis = true;
>  		rgba8888_lossless = true;
>  		break;
>  	case UBWC_3_0:
> -		amsbc = true;
>  		fp16compoptdis = true;
>  		break;
>  	default:
> 

