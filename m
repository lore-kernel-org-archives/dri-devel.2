Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1729CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075F010E295;
	Thu,  1 Oct 2026 14:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F3SyWkaW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MP7Nju4S";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB4010E295
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:24:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Dj4n12188538
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 14:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xNjhb7ZZ+zoYrQSoFFi1f5//
 XuwInxKciGFPw8qrI8w=; b=F3SyWkaWeoFqDBWI6oIqWJJVtuaX/DGtokuRLNHk
 PHkzqFUyJ7yJgre+i/AdjvfSw1/uF1zIYALm2r01rOs763bFj63Ej6cM9x9SC4Uw
 NuHmTSRYk8ritFBqU87A+WTw9CsSNQzxiCBfCYUjZEFLJfBE0z93Alwu2GmYvrZm
 0WMypURMJJ+ZOleYtNnSFQYPuEQDL/iJY/xzip871TNlxdSiri+sgsCfUNLwoc9j
 LBvb/S/kTPKSVVTwywUUjhFWEzVXKX4pDtWnlzIt9EV8nUUNGmeBp+81owqPH28T
 SZnWUqZBuEga7t5M1rgxf8bTMg2tnnsplbJ4EiawWqKX4w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pjce5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 14:24:40 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98a95826067so22562241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790864679; x=1791469479;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xNjhb7ZZ+zoYrQSoFFi1f5//XuwInxKciGFPw8qrI8w=;
 b=MP7Nju4Soj+uBF9NecNs23RiSbjK+YYXaN8c2sL/+nel26/e5hqYO4O4Op1LqW1DuZ
 NBCo+knxaXCQgCpJsbFLjFRr70U2jAk0HuxhsFYqcPIwjzYhvjIEKOWozbA5DGv1i1xk
 7Gd4v1kuh4jFL5ELVf1g0s8kWVpcPGuCtjQYL5M5cN5KCRTD7GIht58nkBCzncUoa8Wh
 CdNirGUa/fe3E9hCMq7n0l+86CltEmZUYRQlBPDyPRggQdnBdaUc8DPw6tpjK1rvUNSl
 jzdlurjkX2s7gIem10FQ3eg/a63ACEwvT81TrQ15epp2yEWFY01LpFeagOSHPbjIjOc4
 yNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790864679; x=1791469479;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xNjhb7ZZ+zoYrQSoFFi1f5//XuwInxKciGFPw8qrI8w=;
 b=gyYz7W73QOKi9/V4diyyvvV6674OkcgngKPwE1XOEBQbhfSmqQHvOK+uqkrFjmuqXU
 ERs3EkI5Ftq1h4mAUlVM6Ki64RJEe667ctASKP7FZjOB0LWzt5cg7ggOd3qSZNT92Wf4
 WTnCJeUbXDxRpYyymxGSjv0L+v8bqvnDcHrbE+QMGVf6A6kTPD5BqKFMS4kR/ltW3sSY
 msHtz32V3IUYj/Z7qimYxxedKM5zljU1iz0LqVVXlTilspc3/dKZk9Hf3nSFPQJ7nmst
 lloybDev5abzbmOOTdyAsu7Yhg8zJNhp6xsMcwSyIE13vQqXW1y3VcnrxIvnsg9hosI6
 4Nkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL6OL+z8PRFfIigSwAtdm+WOipTVh1KkA4s7Om3NHdSyuoDertgyBVDA8plA8w51PXIZV7U5XQWxk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUbqwig5XmcMqo3CPnleDtBHFQO0OEkRkz72N1K78DrLJCG88e
 5ZSnFoDVaXrqf2JuKrcCdptl7psdwnu2N7Bntplfh/hVNpae8NZ0Q1AU2UfF7MwR8DU5apvglLj
 I5aKqSnsRBd3kmErvubvsHxxPEp52SF+L3DYxGDBT7tKRGzwj55P8PNTOYi1I1OuxyKcYq9A=
X-Gm-Gg: AYBFou2P07lyB+XxL1txa65bltvKx9ltXlfezfeJCkPlaaLidAokp2ofX+P/OA56Gz+
 RJzUnwTRRyHGdIN6z9Mx0h6bOc6DVd6rd4QTlBfrSlZ/YXI0qOeR5trxxsMFN7fDZM9AHTKPlDD
 optvEbyuOQGgkgLZDTcibUJWljXOpLZKWttbYqqNETCiVfa6Dx5J2yrGAYKoel9Z5TZbE84p5Xv
 7Tjd1CRdsUFmgSO0p/3yC50UsRCf844AW3XTg/EM33nHNQ907GGyAcG2gLtVzm3jRV2l59Y3+Oy
 TtrKUuuKXHIYdVeE9RNOQdFdrbpVhXtWJiDo7aaCo2pbBAtjsfdHuprGeaHBEwJdrm6ipda/Q8W
 6sNiCpm0iR7xqzDli/FIIn3K4EH03cP/80/J4rMUQS/WsAc0xiIZf5C0DSeZRPR4TAjodnWPmoA
 ==
X-Received: by 2002:a05:6102:8488:20b0:7c0:30f3:cb0a with SMTP id
 ada2fe7eead31-7c030f3d9a4mr236238137.19.1790864678690; 
 Thu, 01 Oct 2026 07:24:38 -0700 (PDT)
X-Received: by 2002:a05:6102:8488:20b0:7c0:30f3:cb0a with SMTP id
 ada2fe7eead31-7c030f3d9a4mr236204137.19.1790864677100; 
 Thu, 01 Oct 2026 07:24:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87cffeb0bsm702421fa.28.2026.10.01.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:24:35 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:24:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Message-ID: <wc44ci3adcshejllxi7rksmjclcr3psrsxmjeiq6elsa3oubrk@4gmfmk4xw3h3>
References: <20260727-msm-next-quad-pipe-split-v21-1-965dfa5b669e@linaro.org>
 <CABymUCPO4zDFniBNqicyq20m3NptU3AHB2it2fS8-7zvreZmug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABymUCPO4zDFniBNqicyq20m3NptU3AHB2it2fS8-7zvreZmug@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abe6d28 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=FGnJlOlOCVVlxK1YD5QA:9
 a=CjuIK1q_8ugA:10 a=QYH75iMubAgA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: aLcdHizUHcmDmASw71y-8kNcsnX-NSES
X-Proofpoint-ORIG-GUID: aLcdHizUHcmDmASw71y-8kNcsnX-NSES
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfX3qRQaTVbXxcg
 Pxq7Qjc7X2ddqdeIBzJAlVal0yMH79d9yhqWNXWi68egEx9TD+lDhg8GpDhABt0UL+4B0IFPqsS
 1Dt0AFSRpiI7Q8sewokpZCS/6vQ/2WY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1NyBTYWx0ZWRfX4I0i/wUhdqAo
 hiTmyAF8a2gGBiWZ3kGM0acvDFL31OczHAzPfjbt1qMpvOkiUSd0Wc3vqQFZSpVfdjH9JPG6AH/
 qWJpnKsk0FTP3XxPq0wAyNcGcGE87ImcamparmopqLjE/qcZBG+/hf7iuATNy2ny4pJPohOc/2e
 H+LQ7NEknxt6qaT2a9MO9ac/CCLJBjLLbNt02GACzQ2dHLqfj88llWmqVGOvfIWQX2TF61OoJac
 SWeZUOZq5qupt32/9+pefiASm9SH8qL3OHI0getFWF35yRZOImdOMbSa1lhViUd3OuAQldd52gp
 FxZ8T5ejUoK0zBbnbqxZsyJWPEX895i6PumLDZ3WuFwkNPP6Ex28Pqp1b2sGhBrryNgR0hK/7On
 WFTbDjebr9Kzowc8DDzoZo954522vjV9FT26kXzOSfY1c1KsooSp+RouEmmfs0SlTR69ocqSp26
 ijhNuCzooBPf/WgJUBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010057
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

On Wed, Sep 02, 2026 at 11:20:27AM +0800, Jun Nie wrote:
> Hi Dmitry,
> 
> Any comments on this patch?

For some reasons the patch didn't land in freedreno patchwork, sorry.

> 
> Thanks!
> Jun

-- 
With best wishes
Dmitry
