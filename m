Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAC8F506D2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C948210E542;
	Mon, 16 Mar 2026 14:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBsuAzhu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DhVp5EXU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E66810E52D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:04:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GBp8dS2672713
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TXMzseGdS1JyGf4j7zPhMUou
 RAfM9EvXWtgjN13Iduo=; b=YBsuAzhupByTJfJBlwIqRmPVeqBg7Depk4yhjrNL
 2NoPy0cexHQwdlYQ6ddvOiJugAWiE0JrF7xvL3P80bR7duIBVnqqooXa971KGB1S
 bw0L8yobsQ3/NG430SB+xgDeyH9DbZe7XIFT0B1zJjGM3wJ5ZsSitnRiozD1enBJ
 XdOfG0CNKImUGgxfv01j4+PYx6TtSn++xk0Mncu88LZ9BoA8nS5jgdg6LEglQlpy
 wT+16cmko+W6eyF/df4eU6xaQWOXbpOPqR8e5aFJLTdxGAtxP1ueivxob9ELFhZI
 NVxNPu8bF8rLW1fbSurhKmRNhky/f+FGZQSZeTC1pWoj6Q==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xp478-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:04:51 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-67be26d440fso53603191eaf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773669891; x=1774274691;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TXMzseGdS1JyGf4j7zPhMUouRAfM9EvXWtgjN13Iduo=;
 b=DhVp5EXUexax0Rak+ZzA9GWf6Zd7aef/4Du+gaoIcD039CknuHSWDGr64FN4Kny7np
 6jU5hI6JXWOvMr2BG89iN1d1d2wTfpsqNNUGNKNE6rFU9k/EOOEo+rllNnMXaYYUacpt
 9SbWqAeCPzMP+bt4K4ghIsD+GMQ1b6utF6QpphmMFy4cGnOFRha2yrGzOWL0C9I6cLPI
 SepHu8TwaalFk/l7nBgefV0Q6w6W40JGD4plOyYsJvXbFbbjwopVrqaS1THBeyoHRBei
 uIlARLoNVqinVWPvbv8fx1S9/N4aMmq16FzGnY1ImWJOVwcy7i8h5fZRtVQ8JM0oUq2E
 +C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773669891; x=1774274691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXMzseGdS1JyGf4j7zPhMUouRAfM9EvXWtgjN13Iduo=;
 b=NBP0MfoR5RaFdToJLof1/ytqLu7Y1pYdjgP29kIM69jqATVVIs9NeFvYCenxhkhcWl
 e82MPp5Q2ikqB8ThR8ppRFPtkzsS8+fLM7lz6dPXbOz9uV+9UrWYclgs/ElX7tBId3DR
 A5zDCI+xvX7VQ7tcUbmnhhgmpwh1SwEqHz8vI0uQiu32RTgZOEo3jfDeTPVu8+LS8s6e
 0Sat4arw6hdd78PIlwtaIsz8z5vjMOXyoFxXSlCtvzbFj78DWn1BzLTQSMViaHT4HLY/
 JqKMWT87kNpSK34N1zCscrkHv3Xm2Xw/+rDearm1hCaLr2oOLFbetgcvKIxWtwsYpxFJ
 kNgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMICtcCQu8crKRAZ5fT2UNbJ4/E4ovFdIEadC/c8PXbOVV0lBcq95tt7W1BJ3AhGx1gF391MHWjw4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjMHzZTeW7CgGn+8z2mYLUbA8zYmu9LtL9YK29/RPMn5Cl91c0
 +Q2U0fbq0hBcz1dcTT2Tvc/NFCVE4ADoheC93xal2nuINgPLXzwvcIbviqaKrHYLPCjiusdskRE
 Ap/dDvqheE7uKqgD7yxhfOIErDJrYR6/CzOhaZ6T6kmMyGwDphFuSVLF3lh/v2VNj3+lvY4A=
X-Gm-Gg: ATEYQzxmkDrWd8WZVMu9N1YnKb7HgF82uHwnuVMDvvrWGPyknGAsafAeU4OfdssrHLq
 +0OanQ3nxdkm2LrJed3UTcXPIoy1JsSSJVGj6YCfo7+BGkkwQcggqJ3d+2zP+9ZN5N5W9c9KR4i
 UVYDDwlPmrnutBg9pGlCFNdcg/bhWUKDfrwoDcEAnDmhGvb7gXRI0PrqhMN+wKjoRUQ+4dwfSRE
 aCeZShr8t4VEpVYFw/pnr0daxRTGuZkmJ390ffietgG7l9aVJdWyp4MqzheUeWIoPM1YmU0h7tp
 FWN/3p5G0yIJMad3q4J65sseCKFN6vrucAOaGxME3c9fXb5wcIYFCpuVUWEeHUnRAYVD77bE+i4
 uER0n/GNeyPLHjX7v53jeUttUN4zFKgoxw21ic57fsAuAGCPyzZteOeCf7S95A7VuHlaWJkhX/E
 utJ7b7gQUQWad+Co6CjYS1LAShGyMF8Qks7Zo=
X-Received: by 2002:a05:6820:220f:b0:67b:b337:d421 with SMTP id
 006d021491bc7-67bdaa8b763mr9184164eaf.70.1773669890558; 
 Mon, 16 Mar 2026 07:04:50 -0700 (PDT)
X-Received: by 2002:a05:6820:220f:b0:67b:b337:d421 with SMTP id
 006d021491bc7-67bdaa8b763mr9184114eaf.70.1773669889944; 
 Mon, 16 Mar 2026 07:04:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15636206bsm3550873e87.67.2026.03.16.07.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:04:48 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:04:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
Message-ID: <hmamyk4lzo6ekswqvjlen6hc5stny2ucj5fxy5g2tvl3fqpbq2@ux7l4j4drm6z>
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
 <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
 <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
 <fe151ffe-aea2-429d-a725-4697381c4a93@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe151ffe-aea2-429d-a725-4697381c4a93@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNSBTYWx0ZWRfX3xrqd6S/iIbO
 OGfYg/z8vHpYnakBw28kw2lttYLtYOsd2UlCXlhPpYv5CEKMrDwIpnIey9bkblT9e5z0YBauFhR
 SA5CqvRBOs5JBX9cY50OVsSqIIxHU/o5NRKUFVbiz2BAlpBDtwStyypapqicP38e31jOfYFt7H/
 QCk4JtcOyV8z5oSLk+P0cJHZT9TTkq4l0axCv6/qNL9ZF5l8oGjpnqT3yTXqnHiSsgR/69dDM/8
 CV182/M3cnm7sjvruo8uuzV50MwvOhgW9XqVAAzt3kiTF8dSrSBIw9frMSAGCBwrZb8zukMqeLL
 GVDP6ujye3UBu1NFSQehxIfxCrZAJzxKuR71VRKFl6vWRebGXmTMsTH6bE0nQK0fC+EPCX4QwUN
 eDvbX56uj0mF6yIEIPnTEFdg73gDaMF6SEM5qfOyIVU/EUKMdXaXi3DXgyO3ZrUlV990ehj2aOd
 MyrLbSfc0VJ4MEqPlNA==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b80e03 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rdkhQm5gyLQ6vEK1D9EA:9 a=CjuIK1q_8ugA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: fpdYuee5h65ozZtkfENaaxQwoTaLV--g
X-Proofpoint-GUID: fpdYuee5h65ozZtkfENaaxQwoTaLV--g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160105
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

On Mon, Mar 16, 2026 at 11:08:00AM +0100, Konrad Dybcio wrote:
> On 3/13/26 3:26 PM, Dmitry Baryshkov wrote:
> > On Fri, Mar 13, 2026 at 11:19:59AM +0100, Konrad Dybcio wrote:
> >> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> >>> Use freshly defined helper instead of checking the UBWC version
> >>> directly.
> >>>
> >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>> ---
> >>>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> >>> index ca59bcdde7b2..04efc29f38cd 100644
> >>> --- a/drivers/gpu/drm/msm/msm_mdss.c
> >>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> >>> @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
> >>>  	if (qcom_ubwc_macrotile_mode(data))
> >>>  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
> >>>  
> >>> -	if (data->ubwc_enc_version == UBWC_3_0)
> >>> +	if (qcom_ubwc_enable_amsbc(data))
> >>>  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
> >>
> >> I know it's already there, but fwiw downstream doesn't seem to be
> >> concerned with toggling AMSBC in MDSS (perhaps incorrectly?)
> > 
> > Downstream enables it only for the cases where encoder and decoder
> > use exactly UBWC 3.0. This is not completely correct as the bit doesn't
> > exist for MDSS 6.x+. For 5.x this is equivalent to the code from the
> > patch: enable AMSBC if targeting UBWC >= 3.0 (because MDSS 5.x don't
> > support UBWC 4.0 or higher).
> 
> Right, this seems to indeed be the case
> 
> While trying to confirm that, I noticed that some lower-end MDSS 5.x
> chips (like Talos) report UBWC3 in the register, but the MDSS docs say
> they're UBWC2 - any idea?

I don't see a complete pixel format document for Talos, but my guess is
that one of the blocks (GPU, Venus or Camera) doesn't support UBWC 3.0
pixel formats. MDSS is just one piece of picture and unfortunately we
need to use format which is supported by all the blocks.

-- 
With best wishes
Dmitry
