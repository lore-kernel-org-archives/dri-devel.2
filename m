Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26D9CD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5031C10E4A3;
	Sat,  6 Jun 2026 12:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="epA/xh5e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NFM9c+2O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE4A10E4A3
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:04:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BDfZf1327097
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XOo34K6z2SJt+/XdhMaWPTPX
 KCn7NtY7Eb/CY41noFw=; b=epA/xh5efiSTIo51Y6kwzJKxFc6bXjPbW2in4GD/
 R31AYeZcqmJDjkLc1I76zguSsp4KrZoTF5kKft5OOvSZhX0JVuzxSN+cW5gfcRlF
 SJYs5b8MzHXDcCOFlfFNmC9LeiVW6ZS0QECw8kG3/hdNoD4o1Yo9YTeWga0P6Ht2
 r5xheBfUEetLhEMQI82c1Q5gTIQ6gRESKaaaKFeo5M0ZcKsYDUZ3TW5UC35ie1rZ
 dYaqw+JQXEU22FT7fC3pok3OMXI/tE7kEg2vp3Itow28SLDom9j+VGMqot7Uv0Jz
 BVDzLHPKzv81OctUYUh2UsQScxZdSLfgAYHa3LHUvUY16Q==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8rs1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:04:50 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6751db2792dso1639855137.3
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780747489; x=1781352289;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XOo34K6z2SJt+/XdhMaWPTPXKCn7NtY7Eb/CY41noFw=;
 b=NFM9c+2OQPz3gF46m9bob5fGj7n430qaGrL8uc8fNXCcRu71TMY4kEIia/GK+AS9Ok
 dbYYky5YabWYK7Qz+olCm0fV6hwF065aiZQVTYSBcd8Knmzf0s6El/F62IBmiawP3FJ2
 0jKs39UsHIjGvr1KYYyMUrGfAyVyhpb8hl7lmJSJokc2tOby9gLWhOl7NQt4vlKy+ZEP
 EiHLjbXIlUP3xYxxvnJSNvvkSh4+S7NKxnZ627BR9iNBlo+cCQOQeLJL1wz7+WOme02Z
 tkZ035USEkmkfr5BocNLZ5dm6gNdpQm/uVWryBXBEt88BK/zch1tXi7/JTJpj3NPJYSo
 1QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780747489; x=1781352289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOo34K6z2SJt+/XdhMaWPTPXKCn7NtY7Eb/CY41noFw=;
 b=eRnLNDDoRWoixgALsr3+Ot0O8QQTU++i+fbkfigxqz7a3iGHXfFbwU/75eBk7i4DAD
 JuiyN9QwCyd8yqKI30zKrL0iD6HHbj8Iq10+Ixm7Ub8rt4NGmKWgx7BJ7ujSoxuEcBHD
 Yozb5+TVVa2KEFss70RR8D8teIhYNjgMdPv2cF1DNCzePUBca4GY64OdWxJYrSlYYqcF
 AgCoiUIUbJoSazLUfUPa8Uil0GJF1rCDDgdehRRR7fesJWpPNs1/NBxmB37bHfI3aWI7
 Oj0XgvHXAwQag5U9VZ4Y/wR3ACSXlWUs0Pt9jxzLfx7euGJc7L98QidvI7P29jTQAjNi
 m1tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OyryZ0xI+DK+YC3kT3CXl+kBTgiQT5dm6hEbd7o8KPyO087vYET6NCTna8aQbTl0ZmPLX9P0HRaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySmw+LA5SAkHZ8K9UQgZN6jF++D3Sw3JITY4mOSksyHNCWWvfx
 f+RFUh9wcXK8RJlAfH3v7U/KN2XWNmXr4gaDM6NUUI6crBX8u0ihT6c8zoRsr/te3wLhs+y3OyD
 dN3GRbEo6yg/vE0YTdz697wQNw0B9D8i4dEIFKf+8aVSqQ53P0ZwknK2NtAu0WjEFUz1wau4=
X-Gm-Gg: Acq92OEhIcmvMFS8lowPAUD3tft5LSRlgA+tvsuA0Vk5GB4SJvy0ikAN7MuINlRB2rF
 32GF7a2KgAJPk9SWGNwYpZVKRgiXHHGmvp6nXyWZW28sPN7yE8JqoTxzC7YcTCwkd1Z6Sr9HMGp
 /1hdlGL0m8oVejYJ8Jd+sG8nFJWy6eMl8C0XAajyDQf4Fvs+aVJY63Yx3B5ZzYNsi15KsS/qnmA
 2nLpZ/wrBLhgWuJiz3UBlv+vmAuyNTph7/lTbVqeLQ+netBCpYaDqjHBnTSAuv2D7nWpwExvt8f
 3POOSM1FN1wpmH/PjFZNxfuluA2v+GaAbRBqIx+qYhDgsXy4FdL8CZCxdqFMvSP7CG7lw7WTppJ
 nSyp2K7ZyOJUpJ9MtNRc+0VoEnoDKZNptI9aYbvIKDj05gkuXZPBSH25kApZ9QjdjMlYN6YCzvz
 zm7cayfjR8rKzKE9m4rGcoURIZNDwxBnCiZoVl3ywQIH5XGQ==
X-Received: by 2002:a05:6102:3594:b0:62f:34db:9474 with SMTP id
 ada2fe7eead31-6fefbf1a290mr3455620137.20.1780747489246; 
 Sat, 06 Jun 2026 05:04:49 -0700 (PDT)
X-Received: by 2002:a05:6102:3594:b0:62f:34db:9474 with SMTP id
 ada2fe7eead31-6fefbf1a290mr3455588137.20.1780747488814; 
 Sat, 06 Jun 2026 05:04:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97a73asm2419279e87.51.2026.06.06.05.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:04:47 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:04:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 3/6] drm/msm/a6xx: Fix A663 GPUCC register list for state
 capture
Message-ID: <ox3hiaoxj76rjt2dkymf7sxsls6fmwajdhmwsktslv4hhygenr@yvxvyiszbs4b>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-3-2caa04f7287c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-assorted-fixes-june-v1-3-2caa04f7287c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cpSEsKUpC5bz0O_RPhymLPOw_x8cGLfr
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a240ce2 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=npCoGp_I_a_DEMxlm3EA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMCBTYWx0ZWRfX9oCvgwuP9HOQ
 5Kw7uKDiZYhwi3PdD+2lP3eGyPQ5aEuZnSKtTfZyNCz10FgVjsbUBqhWHvoDX9qDHcbDqod+Gk7
 q37+Dj8rCsc8LeC5WWVyazdxGLrkvKZV3EG3FE7WJHiCn0TePq+BZyen6JyvsYTtnounmb7I16h
 EFkQx1cfuOWX1J9bxvpEbTd6Ay0paTRAY1Vnh1lgppcwNB6fOHOaO7Qivecn6zyPnaJnev68bVP
 a2j6p1UJIMeZobQF9vBUF07Txh/0FAWiJMLvjmuF2PTbA3A5AFfWMw90bCjNupHfp87dPZ2xkID
 hT1SpyReAfw/L4npwuyUToq9Dol6FfSRh1uIqCvJP+go+S5g/9KxDknsmpx0MHRCjxsXnZk30Wm
 CqTAvDZLdDszgglzbqQGJtfqNLliNxpICM4XV0L3NLBw3lRIueX8qBstAzZaF4FbFgAUu+yxWw0
 dmArAO6uACgnoVhDs+A==
X-Proofpoint-GUID: cpSEsKUpC5bz0O_RPhymLPOw_x8cGLfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060120
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

On Fri, Jun 05, 2026 at 01:38:19AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> The GPUCC register list for A663 is incorrect, which can cause
> out-of-bounds register access during GPU state capture.
> 
> Update it to use the correct register ranges.
> 
> Fixes: 5773cce8615c ("drm/msm/a6xx: Add support for A663")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
