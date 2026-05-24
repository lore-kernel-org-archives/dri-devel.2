Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D07CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 09:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BD710E09C;
	Sun, 24 May 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jj9njkOe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jmqvxk2v";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106A110E09C
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:57:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64O9jpXx189831
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WECMzIHcFOMo/Uik7+1vSfMf
 c4YRMdyFmzp0mcarGAk=; b=jj9njkOenktmdwQzxhbCvaJq8G3QWczahF/njtY6
 oVMjQg2BXT3FMFjkZ6ZAQ5kfOaPBgO7iI8fV6bWrflhgBj4XpWItkFPFyBV37SUs
 YU9a4O6lkD1n7r/VwGXhPFDkewep2ZA/aB5Sk3FyurSsW0I6YJQJyeC9xBSA/QqT
 2tg+nelwnL9QkLe3OCh4ZFVns+iLhUsLBJ/XfiM8Kvr+fdQqPGLCDglbODDwMJmY
 0Fqnoo/MNGv8rvf1iAlx48hmZs9/vdXT2hpKBjyZYKwu6gb6ytbO87JvaWWIpx4K
 rhfT32Cx/EZZbR/EYKi12H1we1Lz4nEaZ7kWjcG9d2zsug==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w2d7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:57:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6326fc1256aso14272914137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779616637; x=1780221437;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WECMzIHcFOMo/Uik7+1vSfMfc4YRMdyFmzp0mcarGAk=;
 b=Jmqvxk2vpa9aafPPt43o0krKh+PBaCZ3zYC75ev9VOlRaok+7u+8IGjQSZxjDm1E9G
 EXvOYPhoz8c4/IRi7Tz0jfW7WuP25PZ6SCsyGYLfNXu3lAaHc9kvZJnYQXHn2p7MMp+9
 OfaubpiV46I0MeeUSik3mesaPhG+qYjZEIHe/OpydxKqLpnCsbMTfRxeCuxtcjcMWOHW
 9SrUMFgvL8hCNP3OZ44EikZyEJoEa8BhY3sHXlH7J11kLfWZGndt8JLTg/bCLnMtfBzp
 Ggxn1eyWZkzJQgEKOyNCx4j/isgkUFksW4i/hEQJVCOMB3JorAi3SpnptmHcW4CzxhGa
 olIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779616637; x=1780221437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WECMzIHcFOMo/Uik7+1vSfMfc4YRMdyFmzp0mcarGAk=;
 b=TAJUFWP70Nu/EtYD8D1N0Hh+gsx1upq0LFlW4wjkfYpONhnHc108gO07pLtvauK+az
 DzMiYRIfeBkD9mj5C+ZmGHDvRn7QRUed3d7hmWdEzG7Peu86LkNdrKOjsNFj/tVlQegs
 vl+989hxugK+2n5TzVxmRUNvt8fu+NnvEniBDeGo4HGy5SjKf82EldnLMjUcpraUT5e4
 bOYm9ETWdgNCrJAfb/MWm+8HhWJpih2t0dInBMS+36Gzb2d5i1m+ga3fj/4HPKudknGZ
 wUbPD6QeBdOqUAxnVuHKD+j8KjmZpdsaYDExOaWOjZHc5MVT8ZoXEhDr3snSg2Kt+K9p
 hMcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w/kZWeez80ApY1sQTeBdJ70xwU+eYf8hBTCpA98NiJCDn1I/56telnBlCoZYk2s79gbHjCGMzSfY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsXFg8LrZQigdrar9OgfBM7z9TsHV9RrrSkFShoJt26P5Ub3zm
 AD1gEq7TIUKdEB2WhzFhO1EOlyHMewk8+ARKGE8Eb3oRRdRqrRZs9SP7JkD10mBRzHs3IREoWMA
 P6u1gYCp/BHSTnIDJw2afnwxkD1KEpM2nlE9YrXQWnuct5DSqOUlh75+CjpfabJ1KPeo2v1A=
X-Gm-Gg: Acq92OFzVSQctTOTdGaLSLsfAMzFwiZx9p8s/qHRIWNdSylW4taGOGVln65gTqdV6V8
 JnD0JRPkoQJbIbTx4Ap9kf6ZJjzrckx55TV7CHVTyapu8WOA4WHQ25LTxGRgkvAhmo73cxsnyw1
 0qMmOQ7OiCgsM8wspolZWnGJGSYl8dKS7A6NR/STVxD7Iol5LGqJhn3Ky9WOdMCxTVQXsbsEzR1
 TSZ67nVHzTg+RiyAqqbJCTOh+gatSaAXjeSiauV3vpS9Xf0B1+5QIHQV6oNAqoStYCC49gBQdI/
 BhfSlm3fSkzzlY2FGzeQnTtR7qItOZm+6wY2jU7QVbfb8NO/zoNwFIfDs2nHI3QOGyicC06b02w
 JfHM/tGfluAmAmFnURdLaUzg926bEnM4Wzu2POTfIz3TKqW8/72EOD2EAf5YE9ANU6Uh5dpENd8
 wHS2JRuYVhuTA8uHA4Qp2HACNyzTh4f8te7EE=
X-Received: by 2002:a05:6102:4424:b0:631:3bbb:f23f with SMTP id
 ada2fe7eead31-67c8113bf3dmr4876270137.26.1779616637401; 
 Sun, 24 May 2026 02:57:17 -0700 (PDT)
X-Received: by 2002:a05:6102:4424:b0:631:3bbb:f23f with SMTP id
 ada2fe7eead31-67c8113bf3dmr4876253137.26.1779616636937; 
 Sun, 24 May 2026 02:57:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cea754sm1782363e87.53.2026.05.24.02.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 02:57:15 -0700 (PDT)
Date: Sun, 24 May 2026 12:57:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/10] drm/msm/dp: Add sink_count to debug logs
Message-ID: <x6wsf7ht26uotuszokvadqttkoglcxs2vepszanuijxqmezpoq@lfjw3zw37t47>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-8-0c8450737d64@oss.qualcomm.com>
 <e8b8834c-3bb2-40fa-9508-53381839d417@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8b8834c-3bb2-40fa-9508-53381839d417@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a12cb7e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=t5iseO5INfQlQVqLfegA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwMCBTYWx0ZWRfX9wYpgMkXwHYR
 JsuwvukGWSVS4toW8J07mCJi74clCzsUrKWQPUa94kizlHL0N699qD3JiRmT1bEH5sVWApHKXKV
 q73T+ePkW5HMtooMfaN5WEy1xFcSw78ENhA82lMV4eZxWs+1mUC9zpgUjaqF+SVhDG15+2CvkCA
 lTjntwGy12k5KzD4rqHho7NcRYXxkHfRjyyx7j7iEoxBSwUqbetY/lJ2JXlKYCNzsqjhZTVkRk5
 7bnAdQ78N6IEdGpXtBY/Ve6Jgy86bH0h/daPAPRPKu8Kv6rH0ma7CUPgXUOlNwVa0v13O4It4Sk
 Yj1hRg+7kDxYUlCp6Q9jiPOEF7SBoLNkNjzrwNa/hg/oK02yRy3XBw0egZjIG32RBgZze3a/Up3
 D+li7A1w+6HUzCykqtubAMN0FPQs5pCk2C3Z6oQPJkBqu0QZOV7t845rOsufSA26q2KLxOc8wbo
 7bVXzDLKxhMnZEzKT8w==
X-Proofpoint-ORIG-GUID: TuEgadzMaK-4J0aWCH877pxqrjHz3Be9
X-Proofpoint-GUID: TuEgadzMaK-4J0aWCH877pxqrjHz3Be9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240100
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

On Fri, May 22, 2026 at 01:40:36PM +0200, Konrad Dybcio wrote:
> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> > From: Jessica Zhang <jesszhan0024@gmail.com>
> > 
> > Add sink count to the debug logs for [un]plug and HPD IRQ handling.
> > 
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > [DB: dropped link_ready handling]
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index d61a8ddd30a8..b4deeea0ec59 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -388,8 +388,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
> >  	int ret;
> >  	struct platform_device *pdev = dp->msm_dp_display.pdev;
> >  
> > -	drm_dbg_dp(dp->drm_dev, "Before, type=%d\n",
> > -			dp->msm_dp_display.connector_type);
> > +	drm_dbg_dp(dp->drm_dev, "Before, type=%d sink_count=%d\n",
> 
> dp->link->sink_count is an u8 (perhaps over-eagerly? 'int' seems to
> be fine for "amount of things") and the struct gets padded anyway as
> of right now

i915 also uses u8 for sink_count. I think we can sort that out later.

-- 
With best wishes
Dmitry
