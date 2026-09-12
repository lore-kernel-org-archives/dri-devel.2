Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED87DC88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8A910E736;
	Sat, 12 Sep 2026 15:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pfqv5n9H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fo4idc8/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E793B10E732
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:17:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEdhIW2606769
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DxV8IeqIQCW45D15BdZkPDG3iBvqGgjXMxRH57fUWiU=; b=pfqv5n9HZ3L6Uvic
 C1+bM5SMpH34M657wyw0PdhK+YeNjqHuFiyM+wU97Xf81JPnyFZ+OHT1hOYLBfyh
 y0666Me3uKm4B0ijzco2TACGTqFzXjXMYIvtj5PQm6whnLFu9Q24kuJEh6UhfGtj
 AvwZJJ6Tg/ZxRsfMtfLeiPiF6D9GG2gtlhibHi1n2kHj+cJPCIuAr0auxROy4gaB
 kY/0nU1B8VL3LRPIY1L+w4E62ET/czloZ6ONxv2LZkiw9h9XwPtND+O2PQqwlp2f
 Fwny9WNEmM56gXEpFCSyOvTAXGQ9sJbdwLBoqDy1FOPkjq8Xhpr3tbsxCnV5ueg0
 xl+LRg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c97kh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:17:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8699b293a80so1789321b3a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789226257; x=1789831057;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DxV8IeqIQCW45D15BdZkPDG3iBvqGgjXMxRH57fUWiU=;
 b=Fo4idc8/KgEG8diow45RidnwV4mghafg0YkBiCfdwbE4WrgItTkvt8HuxtquUkM9+0
 EkSXMF0X/8P9rdgKl2X5JTvvzTh24rTUHQdPifLq+GMchgdBRoUuSZCWmmRN9E46On+l
 jEmFEuWUxEI9MvRgV34jsqt22fWpJuts6utba3pmfc6ZQPrK95NFIgOuJ+NoBVvBEzRi
 szbuJHgvc4KYthC/CvMJHy0cDZhH54CTKzj7Hye7ZWcWql7gQPJk5X5jOF1dzhcMMw4c
 nY6QEh4l9W5HafmCqztKhXHQM6YwSRAn9B91Ox9ZKvvuQkH+rkZ1XVRlBjyvYulZMtRw
 ACaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789226257; x=1789831057;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DxV8IeqIQCW45D15BdZkPDG3iBvqGgjXMxRH57fUWiU=;
 b=A3tCHQmYyJ++8MyfnXxDolzJXSwSYMHSJ6SsxPkTRmqwUPWsTsqboLVeGtGIgRKp6Z
 mpDYpCJDN2PSAMeGtjcIDHRAGomkzFScH/oqyIW7R74+vchY8pcNhIGRJ9bSremtOjNC
 s4D47wQyhgNsWCkwCEA10qWJ3X1qm+iEdAk7bf4rBcuQIhin2Ai3K6Alh0wXqC1rGbxA
 7JZudo2kSWYgTV6HjGe1mWqb8kR1YrbyfFGxM0VzwJtAvANBQScFZIpGFc+sazctx0/d
 hfyE8zBlQS618in7NtTWwbHZhIB1drrYLMZE9xzKcUObTdWW+RBJgaIKUQwVPx8gIFlm
 eI+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9IPHr1uUZ3GZhicMBLeAWz/DXkfN1VdtlRos5XjZEQTvdq5sBlPyup3w1uWUeHm33BgX5NEj1Hxw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++luSVR9mmOtxxS8b5HpXLsYHBqIqFMd6hQpr76tft0kPlydywnS
 k9o/kJRqP+s9Ofb/0YrykkzihJcCyfGaDT6sYr7nAmM/oxfyNbVOCtJnOB5R4+9L1L9qqcNzYU3
 UCmcjEfESLOKECAYBIydKw3hWhBCsfrk7VKVvhzDp3JZaQIu5iywumaQjLFS5uKgF6cjSgAA=
X-Gm-Gg: AYBFou3D5OymBwWNNsUWt+9mi0dSCrvsqEns98eK3Dz33RqnCT1a/CIqj8qo2hQF3Qa
 m7mFQl9j54gsf9HEMeAoW9dkhMYTOcTm8TVYgV822kYWTAgMT0+IImr0Y1KW99CZq2ZYIoT1mY4
 2grRkwQJr6VYBfBUHr8vbONtL33MZTO0hviuV6B7f7djGeCkP0UOdekouAiRzZvpAN0bX/fhF6r
 Tjys38jksbVpKaAFAvm3HeKVV/lpIfELkSnaSmEPyO3mwgegzGTh0plixEdGOZa8F8oNRn0FfDM
 +m0K6IJz/CLNYi1ofzFXSzn9empjPMDbVzOlglrHBCbLiovZ1Xdp66y0Sw6oAk9drDoZZg5TAJs
 dtBfN4qDU1Ohhq0FpVNb2sQxu+w==
X-Received: by 2002:a05:6a20:1441:b0:3cc:eea9:f757 with SMTP id
 adf61e73a8af0-3daed5d254cmr18886647637.16.1789226256740; 
 Sat, 12 Sep 2026 08:17:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:1441:b0:3cc:eea9:f757 with SMTP id
 adf61e73a8af0-3daed5d254cmr18886587637.16.1789226256341; 
 Sat, 12 Sep 2026 08:17:36 -0700 (PDT)
Received: from [192.168.1.12] ([106.222.234.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm12386938eec.5.2026.09.12.08.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2026 08:17:35 -0700 (PDT)
Message-ID: <8c23a2a5-cfa0-46f3-b8c8-61487093d3e4@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 20:47:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a6xx+: Increase GMU FW init timeout
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Greg Ociepka <greg@ferrisoft.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jE0nRtWglpB_ZD8ln0ycWECzwbTmp7R_
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa56d11 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=O4klB1SvihdYS1QJdo4Llw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=flHQxk_lLiAmmIxDZ5oA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDIyMSBTYWx0ZWRfX48bBcMQbz5wc
 fzV6J9/SG4dx3knR8TZQH+5eLXk+Y6XplzftaDnUMKD/ZFdDtctn/94Ta2VL+GOUoWK/5bQqNWY
 7N8uio1UZdpgBmi57JofM4uAy1HjyEs=
X-Proofpoint-ORIG-GUID: jE0nRtWglpB_ZD8ln0ycWECzwbTmp7R_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDIyMSBTYWx0ZWRfXxWANkeRuqVDi
 IbsgC82sgwWSSPXLLMTiFAH9K2fJdEdOVIt+4faFXbqB8BKqRiWRYzKtrFSWJFkBT5o18/pZiZx
 ortG8/Xy+xEKp3iFQzDiKFFMofSg41Yjy3T92p6tUCYdgjbFPKuHwMtAawjTYzrC8j+Frxo38d1
 8aSPcNPJvI7AdE/dnMsEh0E1MvG4pruuSYzfjRPlDdbU2egfgizITkFy4NC7nKuIosmz4uE65rI
 v6tj2N4wTgQbB5nhGnTzrL3EW3ihKa+l1rfyqsLJZYg6InbHoUq8CXPMjiOf9d3tUg+9Wa1jWt7
 3VNEuLIlpbdKdIRzUP1aJFpX4mlwPUm7CmlSFAsxiui5HMn9kwRPae6pDqY5ukxhRYxDLZ42ei2
 sYFvCZ90b3LsY8JrW50mEha+jQI/E6tMHwfHM2zms+fyVAFclD6V+MyqYdLKYcS9Q0vnq8l/yQH
 diI8v6XfH/sdKS/gfRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120221
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



On 9/12/2026 8:39 PM, Rob Clark wrote:
> We were using 10ms, kgsl uses 100ms.  In practice it is usually takes
> less than 10ms, but very occasionally goes a bit above 10ms, leading to
> a "GMU firmware inialization timed out", from which point things go
> south.
> 
> There are probably some things that could be done to speed up init, like
> increasing GMU freq.  But to be safe, increase the timeout to match
> kgsl.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 2170bf7bb045..9290010c8cdd 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -320,7 +320,7 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
>  	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 0);
>  
>  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, val,
> -		(val & mask) == reset_val, 100, 10000);
> +		(val & mask) == reset_val, 100, 100000);
>  
>  	if (ret)
>  		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");

