Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ED6C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12D110F3E3;
	Thu, 13 Aug 2026 16:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sn+MIkWj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZDb36BJG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C363010F3C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:16:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFUAr02838512
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nQigXckDkcyL4OY2GZibJ85XWo/01iQSzsDtvAyCXM4=; b=Sn+MIkWjon6qgcG5
 EKQGAIp/d+SMrI3ZToBkcc6gksApeWNlj6HB+FJvDW/wPEd31WPdq2j5dBWkm5V/
 vOJyBdNOZkpXa7SG1s5GSjFgyRr1RUWRUkZkQRUmJ4o+uAemzTmIzUrisV15Dpcg
 238ELuAcVaaPqsz50tGB5Mhd/S1PknUZXmPItlv7feyHa9vIQDyEQ9M9pNOH2qMX
 +gJaJhSoO+gfPDdK4UF/+jh2mGCOmkFNcv3aZfV6y638pyCKNqMnhmeuRisHHqrW
 9/Zqgme5j9W14zMC1ajs0DmTRwkYw+9YDCYLk2ZQxm5DsbidOFkkDpsPLquPmY1D
 6dowOA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g143hugdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:16:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so1574661cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786637760; x=1787242560;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nQigXckDkcyL4OY2GZibJ85XWo/01iQSzsDtvAyCXM4=;
 b=ZDb36BJGSuhaFZ+3ZO7u70EcSPtLfrZYnySPU4RaFfACAW6pQoXmVn93webm5FHhjW
 onLC3e17eySajbuBnSGkcbMq2TusrPI8c5Ra335ieg+CwuAJSuv++cqOcPxpzG+xv5rs
 CsmI4sZGd6ohWOSN3vgyZ18G+LYBZ1g6EbPkQgbAbvaW7hGbtuoFmt/E22BvsAT3A8HL
 DCR3xc7aAwK6nj9EICtzPvE9OxAUqZVcGlMpmGV1u04npeG/80VbH59wOgLLOtYHbBGg
 O2wCH0/CBOg/cX9y5HjBW/UgmD7f8GE8nqo6nQ+PebNub7H6YQYeRg4hf106hycZpSp4
 QT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637760; x=1787242560;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nQigXckDkcyL4OY2GZibJ85XWo/01iQSzsDtvAyCXM4=;
 b=RXp2It/qDPZuLgOI8elPIAzb0Zd8RN9Fupbkhofs8H/WB6VSlI0yEx0QuftmV855dB
 t08YjNSCQI9QM1KP9I0EJ2qmW52KVnTNzrTVw/T6tNWxiNhk+ik9ElZODoDG2064gmWR
 7pv+ypKiK6M8QoXFM3ecl6bNdFq6NbSUBYCf2LCA6JjYtDzdva7L2b5tjTSqYwrfo9q5
 dUqikFwAhE/u62ZMoZmMPBLdIAhzFAyzRgFMTP2eCcBE6qHrNjvK26FFrv/nahpxwfyr
 KYPA0QlKCAfDlfuu96iI0ZOeoRADl6Fuj3+mQ6/sXSzQl2GONERZF8x81U/OAn4A6eYF
 aGUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0YLip/0uxYrna2UgJ4G6FXRHIeN6XzXoS0rTqiuEiv+lWYobP3vN+BwhhSOUi7378oRSEvQEymBo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOdJWWqgTwRdNmu0ppxcsp588jGmzBZK5BF6m+jo5IFoaH2dHh
 gvnDoETg8QnIVpgxrO4cm6dwhSSIpl9Gkvktc3J+myg1rJEr0wekT/+soepmLFyefibLOGeZJFQ
 +I78dq5u4uY2+PS4vBpsDAo0AUpDq/9PYOwaroGwOtwGnWtGDzL28AL2GVlc4HiKozTzVs5c=
X-Gm-Gg: AR+sD11q8kMYNAH/Ji1g9zlRzAQSIlV0LMeRuTQZQFKz6UNni6lhrGXFuMxZTN55bWE
 va/aVQ7x3q9Mve7OIXtRvHQU17MAtJupXkH7V0DTnJ1TVCg8Z38DZXm7GjsnVd9BBr2vWRGFroU
 A4ZFwCs3NLAle4ULkPWTDles65B+xK2rm91miMD7rHgZmaNbAw7S73pmRX88uSEDi2T5xjvsDWG
 95ItLIpxBhu1CG3+ZDVY9QiIGwJ9Wr2Gop9ltTRLgsEHQS7otIHgMr3i0HRF5sXOKzPXxMSXdEj
 yyKsBWvxI8Nvrc82KHjmrHucGAaj8qhB5PpWHx7rtXB9maCOXb82Sdu0igb6f1O8EJdMJ+OFwMj
 eUvE3YmVe0dlO96IdsBMX9NAvJ5O958PQeiw3JLzs6G2WbGfYqyktPioIBODuuQcHKl1MKpSVgI
 mJIswZhErZ0uYK
X-Received: by 2002:a05:622a:1925:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d73c4bfb2mr80778911cf.14.1786637760013; 
 Thu, 13 Aug 2026 09:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1925:b0:51c:1291:911c with SMTP id
 d75a77b69052e-52d73c4bfb2mr80777751cf.14.1786637759504; 
 Thu, 13 Aug 2026 09:15:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a130872f84sm441111fa.1.2026.08.13.09.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:15:56 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:15:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8750: Add GPU cooling
Message-ID: <bnkma57sumxaoqe5ommkmugkwpvqsb2i5drs2g5grzysikltuw@g5vaqnajtanh>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-4-207ad1fac1c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809-pakala-gpu-v1-4-207ad1fac1c7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=R5oz39RX c=1 sm=1 tr=0 ts=6a7dedc1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=i6UeDzd0F3NWq6oLIEcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNiBTYWx0ZWRfX6rNWXztQ8XsB
 9YPzQO/aoKidgvDXIhpnC7KXA8JPrKjnhkxBUw2NRxBp9KTeNTP54GLHDrpPtF7U7jhvjIECeOU
 d4GPB2aijv6OWz44CihYBKtqW9x9FqhMDqyF5z6kRj8vlsJx+fMsJW512PneLPT51FJotgKrpH9
 QBeeyeWGdbWLb/AR0NFdhCbBNeoahk+1ATtlQLGMRzRhCoUPFdlw8e1oA0Oxc7hsGE6Q6HZUbjM
 vg4sREwGGSRA2WrPK98L543K9n2MaxATtIOOlZDmepM7ugiq5R5by4wy8Tb2QSn2zb4a7I9vv3U
 g1HCVIj+tPyN3ZXWasf+4FpXXFaTcYqQ/Xc/z7OChpGk+CPGKR62YtaCA/UwQbcwJZgTCETuaJm
 +1r+uGtgOMI5DO9yM/sGgdO2UmU/wlJ9VgQJnogoy2Q/E78Ar4C+YcznxHMBMcqNxCBfXnHgasc
 Lcp9H40t6e/KSHDRcGQ==
X-Proofpoint-GUID: bip67_vryfgg8EGsgW3WvNRCB_VT30G_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNiBTYWx0ZWRfX/B2TQ5d0iWV4
 mhYUQz+E/UWMK5Vn6/OWwMv86vzMC6Mp6eKuyDKXGxf3Zml/IaxCoQLhJnPZALgP6IpeRTVASsF
 8kT4tl3/NVkMovo9TjA2nry+NXZVOBM=
X-Proofpoint-ORIG-GUID: bip67_vryfgg8EGsgW3WvNRCB_VT30G_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130116
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

On Sun, Aug 09, 2026 at 01:53:11AM +0530, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically
> when it reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 104 +++++++++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 24 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
