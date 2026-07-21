Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC76C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6339310EAFD;
	Tue, 21 Jul 2026 18:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aa9dwQfD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aAWZLLsE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1577410EB10
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:18:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2UOh2548696
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4QBS1Lbjs3T8Bi8cwftIEYn+
 AAPcSxijVVdaZ7ikGUg=; b=Aa9dwQfDhcfc0r0EcjH1Xr3an1xQ+QC34uzc2ekz
 CmiTn907Igw+JrtVbV2NiDLgtFLn1Sev3arqXzpS158DGmPt8IgPbUxQid3E4vV0
 HegiAZFvCKlS6OxqPOZPGlvxs5yjxi5hnq2n6fltX/WEl+Pg8ljHPHBydu/e8yaD
 WLZ52/1TcJRcXCFgt1laSsBD+ddh7Ecx9Cs0qOjX55quWGqxyf2EeAgyZLMD5hyn
 Q+gVjv0JNxan8+FvnbIQhROHLuHbLNNLal7piX4huO5WGXuQFCFMialWog27h1S2
 9E1nWVhBOM0ARQUK16gyIUZzRzycqsHEjFXEnG/ig9kJww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3jbsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:18:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso36514251cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784657936; x=1785262736;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4QBS1Lbjs3T8Bi8cwftIEYn+AAPcSxijVVdaZ7ikGUg=;
 b=aAWZLLsEQ3HXOKQla/O63ozKL2atl6TSIYV7JWpwoNlnQxac5V2kRvdlCEVKqecMS8
 XyCO+cXbyu0joeCb5ejBOP7a0iLI3lU1mbS2G+bTXhT2CE5cK6kKNfjjzLd1neerCWrA
 9UmjYBjq3s1I8y6FwEGUEJQN45yVfLhL77aPDd2NQFGDL02qLRcQGOiMnJltKSyNWDMW
 itHohmrX5P9cfdoj2RY5z5ukFQ6gjvtqpIGceQ34KrXLpL7JPZAvgttMgUESf7qG28Ui
 f8G+HHruTzVXJboMWhB++avZAIHhe1Yfdbw4b16ynFtmjIJTdFvI1sB+91HbKS70okFh
 lcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784657936; x=1785262736;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4QBS1Lbjs3T8Bi8cwftIEYn+AAPcSxijVVdaZ7ikGUg=;
 b=Iuk5xCPlXvVXu42JKUnDsRdZ0IGChDk/6swHXLkBXNnIVps31MVdDjHtWsBpAPOxEq
 qiX7pFP7Bo9ErXUqYc+V/q+jPXP9I3WMErWm65kRDI+uc+6BIPyvGi9TzHhpLmQqStCQ
 yj/rYBBG+p0dd1nPUVvpyPuXNReGRmhziK6K+zLPLpKfuk+4mpO3CKW1+yGDhgNYc4eC
 wooeNCsYSJktA5jTj+jbEumBfOMC1qvTZqOxElOK7mB5B7Y1KKKUMiYgxdWQ0xHSAwgu
 lFrtfNvD9+jfQQu/9P8gtdDT9s6nAib/Cu3OjP1ISttieADRSkJsQ69tLMDWIs/PAz+S
 gKlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIIjUcj65UcmMQVgHQFkHKo4RPAvidHd0vXxUu8Q+GaP0xyur1no/sLqDdPy4eM55g5MPmLTGJZLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp+iiN4RFPWWQkp1Bpbm2x/BibeTHYlu8w1zl676c+sHSIpZTM
 WUzQHX2VRhu1K9/GgCWgOFVwIUxjgCtdsdo8e/9ZtfWNG/QdTEW5rmlqSYV0GhWguWSRlaIkJTI
 6uvfOJfSTWiZikUc52CFwMOa9KmtWSXUhHnUWq8fib578MuMlUESQEi8dQdWCSskKCv8L53Q=
X-Gm-Gg: AfdE7cn2L4Aeg2zbdxEijhrb21i1uJFZaoGYUccFP0TmcgrrXidKYob8ayYBJFaT/LU
 QUD1fDCbfJljFi4maR7z+gDEQLCm6RmrjOfXoH1TSYPWoSxER4mwapOlm4/7NxsObVT661Z095T
 xbuvw1E8MIWddUQDqxY7T5J6iq2O+VNuza2k/ObGh7surfSHZICzjzAHb7MBSS7jO8fSspAh0dp
 LxsDaIYxa0TWqRUqVUJdTkB0OJEl8ZqbHh+0cbHdQm1GNmzbGHNPHHK6hOfUPExUJgK62x+ELhf
 9UAQeVKvnLlv/NLRAoCQkKTF01Bjdzyr/FNrbCA8XwDfdOsb3HzTva1b+88cBTlAx/Q17la3stn
 fjMaN0fV/D8vVFuxDrwqK75Pblz6JNJWSlFgCWeXwVeu/fMW/b+as/+L/n2lS5oTY6u0vyW9Z2z
 qEiHC1jOENHYRIqw==
X-Received: by 2002:a05:622a:1c05:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-527a640e6eemr9782931cf.11.1784657936453; 
 Tue, 21 Jul 2026 11:18:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1c05:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-527a640e6eemr9782501cf.11.1784657935963; 
 Tue, 21 Jul 2026 11:18:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b9ac81sm65135e87.21.2026.07.21.11.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:18:54 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:18:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <nqxbpcwxwastqutkfkaqz4o2telev3lixgrdlmb6anftpywjog@ibfxfb4e42xd>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5MiBTYWx0ZWRfX58eQOPivn2KA
 4r74gVKQSHgKwl2aRwrj6mGcts4Kb2twHtJzOADIPKOySMmY6EYPVlOno99DHpQvNzvj18nih/Z
 4GzetL1++KlYx56CwizeoEYxZ5S9YLh4HfJ0IPIc4em8vT4/67+7vfV8p0u8im1HbvHEnSA02Xt
 djKZaUiL9sv7hT5kWvlp5UwGsp/1wUvsybmXs7s44WxQn2ZBnNd24R/6VyvoT8NL/tXxbbkeB8i
 zpnnlpQN/UbH3IvcFAQPnqxHN8h3+b4MTSz8rgbjvToXRsRHwkKD8JnYCfbpDwZUM5PVnzwII5o
 09bp8/KUHpQI6KkTa9DyC1V3qVjo0HxXEKAi4co+sablX5+Q8VDNCV1SswquxEYlUWAmIZE3Z+5
 7xfnEotiDyvOw6p2xRrUKFhHhuqkb2aPYayAIJkJWeyh1zrcU2X/4kF/wDN9FFEcDAgD6XxxFQ1
 UeJv1A4+tyWb3cOK1mg==
X-Proofpoint-ORIG-GUID: ONJggY1tzCjaGUHsmbZOfpsxpFwXTYMy
X-Proofpoint-GUID: ONJggY1tzCjaGUHsmbZOfpsxpFwXTYMy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5MiBTYWx0ZWRfX0HQ2HyQ7yN18
 hd5tYSn7UQohAJV7tuC5Sfu3aMoXkWWDRLmhCM5tmW51D4r1Q57qAP+86l+seKSnbVkInJJaMoY
 KR6wT6is/+a7wDJPlBr/rqJO0FVsF2s=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5fb811 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=HlDJ1ZyWpHQnnzQbUF8A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210192
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

On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
> Kaanapali (SM8750) and Glymur use two display power domains.
> CORE_GDSC powers the main display hardware while INT2_GDSC
> powers a subset of SSPP blocks.

I see that INT2_GDSC is defined since SC8280XP / SM8450. Does it need to
be enabled on all those platforms?

> 
> Allow the MDSS bindings to describe both power domains and
> their corresponding power-domain-names values.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>  .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>  .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
