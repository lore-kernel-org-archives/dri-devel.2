Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020D1F94CC1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 03:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 605C010E199;
	Wed, 22 Apr 2026 03:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eVvrjGa8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5CcIKPA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F88B10E02C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:39:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LIZldo3377485
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Lf3oiZ9B7GXrBV8eOzokgu9O
 Y13K6aIvRgDfejReTdE=; b=eVvrjGa8HRbuOefO9y5ezfo9E6s0WptDN3K/ccx8
 gUQ5135DiCuY/FrKBZYOuwDfxi0uJm0pHjN3/DS66asCfxi+lAoGOkb3MB6AY1f8
 K9io/1LnbGXPz5k09d667DRjF9INxZa+d0Rb7nRwkcvkm+7ZCFBUiYGMhLyQuKOG
 uJ3UBiY7hqbKli+Dx4dIxKphcjKXCJfEJLJlTyOhPmgk/YAPtBD+bwnPB5LlORiZ
 WKs0a/CWptOo9roGgSgyo0iVvrgSg1vLP3EqszkaAe5OEdY/q6ucIw66951PRCjU
 QlE3t41945Lo4ZV6Y3SQM67UudAmtVgVTSK7s0zGoJNNdA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng1gsw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 03:39:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50da31af14cso136570021cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776829184; x=1777433984;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lf3oiZ9B7GXrBV8eOzokgu9OY13K6aIvRgDfejReTdE=;
 b=Q5CcIKPACtRpqwrt641LGbfi342UDoBvUDy+X0m7bwNejhz9DZrx457iAyCLAR73Y9
 ZWTJ7I+D2UrGMJt2K/HMvn2jpFEQikREnAwrAiT72wdcIi6LsrQyatPPsnh/vvue0nlf
 cXm6iuFZTuuiXTq936bAJhFZJShkJjymPTETwXB1s5QsCdtF/rYkrJxsjY8sDqQ/dZlz
 hBzR8fo6f8pvQ9JVcsfS99sJzBsiNLEqS8oeemNLsNFlkil0/hCb33+uxX1/fgny5aiU
 qu4+/alvnyuXfj/U1sbn4SsykOfvUlMF76NDEBYlMMX0PYRS6ZbeiWWVbrDmZacIdt6C
 Hw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776829184; x=1777433984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf3oiZ9B7GXrBV8eOzokgu9OY13K6aIvRgDfejReTdE=;
 b=rO8YxzHBHR4v5DhfAN4sYljQL4rZcK4Qj10PPMsvlZ8GGE7WGg2Bx8rza6AYrOZibK
 wsm815pEQIZAcgMNSTa+qqnVu/2sLsCMW9OC/wlIEtS7ETtpkCtoo3OQ+EG4BFXu2uCS
 0jG3jM4+FLpKEQJWOKqC0zFTv/8zNDlDKpK+oKQTh6q3BwN0HkyCoM6MoavOKBQNLcFv
 mOMYvirnUlBPZ/hOXwgVid7uZSI9MB70qGdjSCxdi0bg0ETiL/gu2qxu+e1P3vP7Ec1s
 gX9x6wOXTYXO+zopo4ZhbFTe37RS/M6IjwYWUeWNIQT3ZlSYDYx48+zC9Eu8tcI6p7Lq
 kmiw==
X-Gm-Message-State: AOJu0YzhOewSe0Owc6vUKWDFwrEYr6sQFDij8YLI08SSnihXJtD0rwbO
 yIxWfezrjgj6KUV4BR7bpDTGDpfUCzrd5T5RW0ZDU7SEH6fuf1bwsT1q9I98YRZo7FhXoE0zkFA
 MKeFdL+sGYi75JEZF2OkQJk5XNUX1ObYQ8C+xomi9pMiaN/QZlVud40f52/Sh5pJ++JzXG20=
X-Gm-Gg: AeBDiet27Wr3x60NNFAbZs2B2ZNVGmgXPq6xEl4E/PpRJW2+XMoWEq9tl9EFOqFAi4f
 Aln+u1pCaMQZG4PCdkSFgu4GVY41KG1jpKpgaVLwFAKG8NxwAvqQfsl9Nr7WTOH3WvwVZ8+KiwI
 PS/N+Kc7P0gpiPIUbCf1WtGF8go8jylkeYSe8Q8HVkEIR5MheW0T2Na1/zXC6+LugwDRuT4/XcQ
 c/GWOiLPBmDNZuIxROvn0hj50XYCPW7EfWDXT0aex0/JVtme/307/SW0cAgbA/7N6aO04eHZQmY
 LtekHLA/HK4qDybwFlI2QIHAQczqLXOb2lAf6/WcHpXJUanId0go05o7gd47OHzHilVEjSZrlqi
 2TK2J+iGMM1g1QuoL+2ppyD0m/7weoE8bA9kIN3F0U5VpdH45zmQWEpuICOETK//8qTtWWdqu2W
 gtON+7dJaQVETjYD+FAXBHC6zH4+pz+fVCbK5D9kMWPEzM+g==
X-Received: by 2002:a05:622a:544f:b0:50b:2640:22e3 with SMTP id
 d75a77b69052e-50e36821b69mr311781371cf.11.1776829183903; 
 Tue, 21 Apr 2026 20:39:43 -0700 (PDT)
X-Received: by 2002:a05:622a:544f:b0:50b:2640:22e3 with SMTP id
 d75a77b69052e-50e36821b69mr311780971cf.11.1776829183482; 
 Tue, 21 Apr 2026 20:39:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebea2sm4028793e87.76.2026.04.21.20.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 20:39:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:39:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
Subject: Re: [PATCH 03/13] drm/msm/registers: Sync gen_header.py from mesa
Message-ID: <qpvedddi36ihfldioqep7alve7ah3lbsk3txkru57e22f4ud2h@rhxsnu2fovot>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
 <20260420222621.417276-4-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420222621.417276-4-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e84300 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=9RIi00WSWFsP0q8pkWIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: w34EeZsMOK0qs4QrTcOXu8WMMiD7ePRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAzNCBTYWx0ZWRfX8HmVsDQfaOGG
 6Y6XOaxkqimVHjjBB04c36i+cMkXfqaeziOO29krmZgjgaFwqmGfW5fFhTaMVdWmk7AhmJeI0ne
 U0loY6zIf/OL+ZP5LdoGJ4HQ/QofxWrHljUxGYNVLGUvLpb0lQBmJeMqme+u7Mu6kCJ/RMr/lpG
 Llz7QH8S8kQfRKiHa16HHvN47DjshM6bStn8JppF5ucM6+ebVfwxSdek4CuoJz35F43dcIPSJJ7
 djf4w47VxWRDORpbywLABG4fWPS9UcgUkAAcjoa8QzGuANy992Y5Fib8/QUL6Bg6nAUI1K5QwxE
 OGZ76bRrq/XdnTMoYVpaqEXLy4udUV/50ALWGsPOSK1yEnnj2NabfqnxD6IXYdQ315Eijbnuisc
 Lmy0zcWpkf0SS0+x5StixzKV9l184xW04H4279OjZTaJHl4L5I+RuPcHwEizDPVBT0sOTW/HqFE
 poz7raCRNW6ADN8RkPA==
X-Proofpoint-ORIG-GUID: w34EeZsMOK0qs4QrTcOXu8WMMiD7ePRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220034
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

On Mon, Apr 20, 2026 at 03:25:25PM -0700, Rob Clark wrote:
> Update gen_header.py to bring in support for generating perfcntr tables.
> 
> Sync from https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py | 2079 ++++++++++---------
>  1 file changed, 1146 insertions(+), 933 deletions(-)
> 

Syncing with the MR is not so nice, it's a moving target, but I assume
we don't have a choice...

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
