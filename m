Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA07CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 14:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2D910F19D;
	Thu,  7 May 2026 14:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKvZO0E0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKoV5zNz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D114F10F193
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 14:57:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AOmUn879574
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 14:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4npxAss+cBkEEkowA0VPvewqjM3l+sBKHX3dTsvFTvA=; b=IKvZO0E0r2pupgEl
 87XJIk8uojF4AcTI1foHZax3+hTAnQAzOH19HwAJsU/VmHevm8oE4Tn3vmJ2RSgq
 fYxRzW1JHA/c44O3gK0nrJc6/3iwygll9fXpsSqqiN8aKHFwfbE5kO3DbxfW4ifi
 sV2r/XhPWEC+HNdPzT692Ih+lxEhEHmVDK2SRRyHVL4I6UOm5XrY9E3UQcC0EWEk
 n/ATea9ikR94ynTW8DvwQN5+bzNECxwpcmFmxa87EsgHDYQPLMIK+2nTjsMxiYeh
 kLpIJfBl7RrrFfUQWC/niCOhnVMxozvM+IsQuRwFW/ZbeBJHhcMxdX176R0car2C
 7RwnTA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq2btt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 14:57:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9b8137828so10718645ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778165830; x=1778770630;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4npxAss+cBkEEkowA0VPvewqjM3l+sBKHX3dTsvFTvA=;
 b=MKoV5zNzMh5kwSl6fLcWo6vnHKBDsVPK9BgM4mZGzjJJwDeZ+EB6jJlu5BNnRpZDYk
 Qa3nfh43UT7J2TtOUMyJyc/vhwpxFXXZyakc82h1Kiu1/f+Kyv5UpbFCWsA0uVlU0f1M
 4lxYYHx8tOQry2OTLjI0ImF/CLE9c9w6HdG3nA7SK6V3SAdK63hFZiyg3GugtD70N0f2
 MQmLZ/VgXvETklX3riC08gDIemvhdPDq62UZA7k4v8710/bsNjNIkLCGAgKquGQlf9wr
 RTpV9Sz8QaPITI2HQrWp8c8O42x/PO4OR+M6MaS+bFdXr54OkIFT9uOYyg4tJAUs04oF
 iLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165830; x=1778770630;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4npxAss+cBkEEkowA0VPvewqjM3l+sBKHX3dTsvFTvA=;
 b=TRsa5WFTGRTvo/T6vI3CBZI+Y+Pk/3KF6/F83WqX2cX5bfo721YSI/wrQ1gkDCzm/i
 bxEPhDuefKqcCegthtM7IvZ+EBorTxuB8nlusc3WTYGWc3SJ0BjRgoDp6Qtq9EItk7H1
 S6WJWQzVZzBWnlDbuWMGs+v1vWTfU8H0YOqmTqiJYzGrq4T47xqZV+WJuD3Cb1CqTLgE
 z8LDlOMg8lowBv58Nf8m/w9bajORedMbO92uAKblqMbsj77QyZw1DalqwX3jWrDELZU+
 KPHUyGfuX6FGuAQzXXKMfm8O3HeFw+WfAno1ObBjVzCcGNVVxhQmIQiE+kTkvEt+kZXG
 h9Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91XL2pPkifmIeo32uc8lQltAqLLZCkE0M3BW1kS4V+M3zxAWqdCgE8Vq+2eoeXZITtL3h6Z2Vwpkc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyH0X1ORlfG2w5HuLLMWaOEYm33yXApfTqHb18GYHot/O2RAgq6
 QeoBSC965SPKW3+Be/fZzTlCFVx/6Q/z6jG0WK8K406MhOtVlVh5isxa0sVZ86G1x0RS3xk9h1Z
 qgVftTnZBO3dBRBTEdOM7gLVoZYMYpOsqmuYA+cW9fQVS24R6Lr6X3WEy37VC39HADY3B13o=
X-Gm-Gg: AeBDiesc5bxEaUgSz9PARICYcJNhr50SMdvwiuEKcfJ3QPGBYcgrCMojOFdtGBgRYRm
 MDPq4VnM9cW5wUF+4cP62MBylBLagRT4vKeCbAY59+I3ZyaFT63X5PoG3FIvXkaOcKH8NwnN4AA
 e87Gtp4Zf6ZPU7AbJzmR6klGI3DKxOvkDCR02g+MulhGVgufevVjzCV2ZfPjjqnEeJEwazkjhlM
 KZXKtkXjqPESIP0UZJgL5sAIwNIwTnrTWxXN+pe+//Vi2X5h67DXJmClM4pyfbk4ojm6ZBxvRUU
 QlDitx16lSi6wYVVxk7Ood0GNnsiJ/ZupsYi79KDUYUB99ICMArCmDOrt/25CEKXsQfmUphS99x
 qigSAEwhy5RKN7oJwYbKFLIrYoExIEE9pXxyUHjIa3nz2JxKhQ9orClY=
X-Received: by 2002:a17:903:3201:b0:2b2:9f9f:fe6b with SMTP id
 d9443c01a7336-2ba79bda3e7mr81185505ad.40.1778165829775; 
 Thu, 07 May 2026 07:57:09 -0700 (PDT)
X-Received: by 2002:a17:903:3201:b0:2b2:9f9f:fe6b with SMTP id
 d9443c01a7336-2ba79bda3e7mr81185225ad.40.1778165829268; 
 Thu, 07 May 2026 07:57:09 -0700 (PDT)
Received: from [10.206.103.12] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadee7c8sm27872465ad.57.2026.05.07.07.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 07:57:08 -0700 (PDT)
Message-ID: <581743f9-6385-4803-a91e-0b7d38fa6a17@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:27:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/29] drm/msm/adreno: use version ranges in A8xx UBWC
 code
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
 <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507-ubwc-rework-v4-19-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fca846 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=F66dyu4Cpv24ktMMw0UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: wW6nl6s8X36bPDhke-LJzuvmxs10k8GE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1MCBTYWx0ZWRfX/q1Ojv6TEL3V
 mVT0wWKndNCfIAZmhEQw1KHTavZyJkCL3eH2DTOAxKqjJnO6rMdPio4a1wajxbq9mhzKNe1xIs5
 3D0JspQLCiZVkHq9AcuXB1Bbocglsi62Moc29llSIgyLwLb3Hpf7SoyaUqV4m3YG8YPajM4N7eA
 oDaGbxDm143D1BVeCk2OA+jzFAzi/BC+VG9B/zdywhGp6joFpllbgMg+lSrsUgbgw4HpylDXxba
 ToygVlOckyfL1OeyjzepgQCdVEoQIMqLd3HggSwzbZdqfOi35YQ+wvSnKGSsf+q3jYxNmuSLaLx
 tHv+1pa19+LYGCC6EHycEf76kWrnVdXb147hjH2a3uR+aKDsbS1CIv8r3s2P9bj3NVI763ybiJ2
 Ia0F1cArxJw12TLRY9HyRgs/vd+cXqmn+klfM2xLQcYejpvLvJRryFIbBpOedtWd8jJRNh2S6ro
 zOKPfVYvX5/Aww6p7mA==
X-Proofpoint-GUID: wW6nl6s8X36bPDhke-LJzuvmxs10k8GE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070150
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
> In order to simplify handling of UBWC minor revisions (like 3.1 or 4.3)
> use version ranges instead of a case switch.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 5c73a9ebb22b..29d559fe4683 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -286,26 +286,24 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
>  	u32 hbb, hbb_hi, hbb_lo, mode;
>  	u8 uavflagprd_inv = 2;
>  
> -	switch (ubwc_version) {
> -	case UBWC_6_0:
> +	if (ubwc_version > UBWC_6_0)
> +		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
> +
> +	if (ubwc_version == UBWC_6_0)
>  		yuvnotcomptofc = true;
> -		rgb565_predicator = true;
> -		break;
> -	case UBWC_5_0:
> -		rgb565_predicator = true;
> -		break;
> -	case UBWC_4_0:
> -		rgb565_predicator = true;
> -		fp16compoptdis = true;
> +
> +	if (ubwc_version < UBWC_5_0 &&
> +	    ubwc_version >= UBWC_4_0)
>  		rgba8888_lossless = true;
> -		break;
> -	case UBWC_3_0:
> +
> +	if (ubwc_version < UBWC_4_3)
>  		fp16compoptdis = true;
> -		break;
> -	default:
> -		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
> -		break;
> -	}
> +
> +	if (cfg->ubwc_enc_version >= UBWC_4_0)
> +		rgb565_predicator = true;
> +
> +	if (ubwc_version < UBWC_3_0)
> +		dev_err(&gpu->pdev->dev, "Unsupported UBWC version: 0x%x\n", ubwc_version);
>  
>  	mode = qcom_ubwc_version_tag(cfg);
>  
> 

