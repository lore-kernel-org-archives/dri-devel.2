Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E2ACD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47A710F00F;
	Wed, 13 May 2026 18:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZfKTljJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fAKl9JF7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3A410F00F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:57:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DEiA5J4161609
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=K5cyuH7S6t8FYHEcWaWo4Sxp
 hyV6ndXTKkyrR2WlTzY=; b=HZfKTljJdpWmuMUYYQ8OUMxdSUSTV5RDCaVAMQtu
 ZsyHAxIN1pdsGQ26g/K0DQ+833Kl6vGuVX2mPzY6FPSKR6jJWuYSUepFOCFAP8U/
 lErL0F6rhW8LHixdIqrEkUoaI/2n9iumda6+BbUhiX4wJf+LqBzGV3JUFc32fMO9
 nncFrLIXI+I0R3ldkKb8du68DCnk72p8epyCjXnr/IveephB421yl16muPic36az
 7uBy9MKVJfW8jVS9KHkSBB96Q3b5irpWHTue7ie+0fx0Zm4jotLwn76b5O6pjiIf
 vf5a7Gqlv2LbBikI1e3cwnWq+HWs1DZCPRx45TqY/yHvfw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91te7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:57:52 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6343b1bcbe8so2873583137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778698672; x=1779303472;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K5cyuH7S6t8FYHEcWaWo4SxphyV6ndXTKkyrR2WlTzY=;
 b=fAKl9JF76l/nNF9xHhS6ZXMD4aRep3a8iWrrPWP3qzN3sWorT6+yzAYK2ke+tXE+Yf
 EUnyUzKxliFXhQEx1yxqxKU1EOYYWF3IHP6vre0vwBGi62b9pKEB9N21ygIMPxJDLyHZ
 m7OwgRnUpkXCsmc0xgtGmEKLy9MR9kDSOIor/fsVLqNYp1IY/4gFq7xNXh4OQFQKA2A2
 hp1daU4vJoFdLn0yYZPTB+XXYxNjq3HdAb5sR6n9DW2tHRPlfNy4mKEMkNGs2jddkyWl
 adBgRkhEvKg+dL0AR+NUWWahtnNVOTeS+D1ENuGOp9Srl93qyVoFh0C2ncUriBQtPYys
 bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778698672; x=1779303472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5cyuH7S6t8FYHEcWaWo4SxphyV6ndXTKkyrR2WlTzY=;
 b=aXznNYqGOiq4Y7FT+65d6YneXA0sjFu9F2yMR4aF8zQtHHyZ9H5tvwo8lzBqY7qWqm
 v3YwmAO5OdleqewVey1UDwej5EZSXrltk863lNvcJmwc0z7capyFI6MboUmNZ9G/csTF
 zXIoJxSAmYKjfW8KtA/MvVjfcuWMct2RLfpq/G+l1GWNYx7i6QQAhyjEcOd4FExFlNgP
 gMU+aEDgltWZYXfC2HGrL6Sj5AnrSCN+jroIPRZsTvtuSmNCAAVpuY8wZe/VVC9VWL6j
 ZKaT0T6f+EGeUHv8EK7AjfipsroGmZnrKPvGXgYOw0nKFfzY2hMng0lJlbDi3QdAjbUw
 2Vmw==
X-Gm-Message-State: AOJu0YwLvbS+gnG6B0/5+WVCy8VGmG5UhN8OVsOj0JqQCo0KfPoRUTLM
 tHPT0/DQwbSN0MLC+tAs2GAcjjlxScJmeMsmTV+4kJqN9/7kXGTsDgHajFAc91h4NDE1UoV+YTC
 9SOI8DZ70kN0Pn/3xkaMKiixrlYmKfYki52PRltlZCr/d5B1ftVUm1O9nxln+Ic8k7vaZ8oM=
X-Gm-Gg: Acq92OFhpFs23Yj+q03qZIJV7dyJcdNAeQNkHP0HU9BX7cptzBc6ZpyZA09xijC3ey8
 X2/GO5JGCNfWTBsvseOiGRIOemMuxKDyGHr0bsd0mPhBSlLgopsNVIHMTby+ZE1Q3H4Iq1PaGyD
 V3GKNUVrokmmFEpIWABNZs+OxTCUjqe7jmVodxIBfxS2KLtAPVTItwZE2b8L3nuBa6uTBscUMxg
 JMRpgTJlC08Ye/WyblOUEQ03DSUzLWsQT/iicHjY2Gjmfu1gJv90M6jN7VrRFZ2tQEZG/Qolq4u
 e5JI6MGC/eBki153B6o5BH4cmNC5sXUUHyxKe32W7Qgbsq+I9BoT3h9Kyb86oWGXN+s/7ofRW9B
 RxQc+BYRuYmF2mCL3fd4yc19DZNbKVLT/IgG86LhCW/yHSmfajoikg8t7aeMohqX6ORLF7fAa8A
 UEWyhlGjEEAUrzr/wrBzZBBdx3yUZbqPB7bkE=
X-Received: by 2002:a05:6102:370c:b0:632:29a5:2b28 with SMTP id
 ada2fe7eead31-6377239d295mr2571586137.6.1778698666893; 
 Wed, 13 May 2026 11:57:46 -0700 (PDT)
X-Received: by 2002:a05:6102:370c:b0:632:29a5:2b28 with SMTP id
 ada2fe7eead31-6377239d295mr2571565137.6.1778698666342; 
 Wed, 13 May 2026 11:57:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956b2acsm4158737e87.82.2026.05.13.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:57:38 -0700 (PDT)
Date: Wed, 13 May 2026 21:57:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/16] drm/msm: Add per-context perfcntr state
Message-ID: <npv72eupja2jczwrhssujypuigzplbqcid2qt6yjo6fj5wftoj@u6uqcxj2ic2f>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
 <20260511130017.96867-10-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511130017.96867-10-robin.clark@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 6TQc56chD3II74zRLL2x1iQ2x06UmWdN
X-Proofpoint-GUID: 6TQc56chD3II74zRLL2x1iQ2x06UmWdN
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a04c9b0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bDk2b4Cu3fwnQs1PW3sA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NyBTYWx0ZWRfX+/PFB5jr/4YE
 Nqbqx8gKpC3NKXaelmFYyg9MhbEourVAs9E5RdIRV6TfuSRN8TVzzgxz23GmOJKgQ2vMomgfwyS
 r7ShZY+d07iCEv2Z+SN4IupZbgOaC3NpoARFlfoAi9bz0x00AqfBeuGA70m6TB0QVSq1jH++jTu
 9QEQJho1DtB/ZsGRZC5FTb45LuTJQriGc/1g4EbR9WnUI9kcZXIBr4bYjs1Gtq1CWU1wiWaG7i3
 AHhESVij6gcmxrvf3P4pZPr4LULcCoW6LiLHPOKRGIuzumDkq2elYSClW//JiwtxBIJ9bxIH+yK
 3jLKYzuTnz948LuiNjqoLiFccYvP0y50L0xxZshZNYVMwSGQRCrd3OqOMdJ+d2SJnpc80oonsQa
 lig2xi/W/ALWs06RVTjxThxac1oBo+RxVFCe/NnGVr60V9w49ba5VRap2s3kC40vKNJVtaADWnr
 LeIOWFLUaG2xh45OM3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130187
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

On Mon, May 11, 2026 at 05:59:22AM -0700, Rob Clark wrote:
> The upcoming PERFCNTR_CONFIG ioctl will allow for both global counter
> collection, and per-context counter reservation for local (ie. within
> a single GEM_SUBMIT ioctl) counter collection.
> 
> Any number of contexts can reserve the same counters, but we will need
> to ensure that counters reserved for local counter collection do not
> conflict with counters used for global counter collection.
> 
> So add tracking for per-context local counter reservations.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.h         |  5 +++++
>  drivers/gpu/drm/msm/msm_perfcntr.h    | 21 +++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_submitqueue.c |  1 +
>  3 files changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
