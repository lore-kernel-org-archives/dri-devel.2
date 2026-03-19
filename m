Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DAC1091904
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8892210E485;
	Thu, 19 Mar 2026 19:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="keS26P1h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h15IhKLS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C369910E902
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 19:05:08 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JEXVB73648381
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 19:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=YK372rb+CUNWfYh0duhBTEHT
 ammLaznzqmNCWqv9e2M=; b=keS26P1h9dlvOk8F3LxEP5JOaec5YaS6Pc8IqtGG
 vzzHs2di7MDgiyxWJOM4NpyBbU4OyQBVcVxu3uZ1/gTkXSm96XSx5lVZOvE7Mzkw
 MiQv6oV4T+xy5/RkofVsFnXUK7QKQqztJ3qHKmCoNPSXEiXyoqqnbGp/8rdQshvS
 Ubcx4btz0yIO0ZF9mDV2883t9iF6dFnfYMhflzFvXO40yWsdQ4gkhRsh5+iifiJZ
 39/Z6WNgXYfItOB00SRElblWZE2UVqnl6W2dUt79PSImuVYRqFx7+26eQ1EmMjtl
 VqHqbE0H/CiqueJb6TNsbKehTcs83S7TXFLqm2BUSUUa1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0v8yw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 19:05:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5093a985e21so69652901cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773947107; x=1774551907;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YK372rb+CUNWfYh0duhBTEHTammLaznzqmNCWqv9e2M=;
 b=h15IhKLSZwjs5tWlj4FagZySwA4TOgkjaNDOyp5NskvPorbsHhR4e6vdt4JqIHe7YI
 1z82c6c38uWluthPgoS3PtOFaOfNHUBLDtmd2cqd8qnMwXabj75xZNbaaw3m/EigNfLV
 izL7kBuQOHEAy8wBugTLDdJYU5/anL1yuo4sLCr/BekGmEahDvB/GSAp1fAjpelaaD/V
 0/UjWw/g2YJnfVggz863UVyJxWDfG/csxX715fGxBveK+wdbKxRRJwYjknNxDjLQr9Kg
 wisJlOlVZFxdFJ8fokGe608HN+1M8bgkUKv5NaWduiHeTnisWs8bBGNFpkZhOvmIZvQF
 pIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947107; x=1774551907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YK372rb+CUNWfYh0duhBTEHTammLaznzqmNCWqv9e2M=;
 b=EXpReASc029eDkehWQjee+m/Hqz++oi4nw7ITz6bEh/rTFBHjIxAa13hxDGfkcBKFh
 /92HbkosRDM7cS5wBVLHYn7zvnWAdNvp/BxM9rmyNnxNL61qYITbqP+09h0CsvRBlNij
 JyAFn6f/rBkenMITV9WZalqhmWaQXWvMRlw3Zjm6vg3cY9oPu6NkMjlfyxSgwkLW/PG6
 hMbu0NTkPMSEBlSTLRMGf72zuW5F16GRsaFW7f/tc133gIhAd+UDzF0iAw/QYYmTU4HL
 96G0IN+UESQsNds8Rh5Uq4ve1EwgRRtzatJaVGuHSWZDg7Lhd/I1GTNOmHxuxfhgW+V2
 0Y5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMfvKzsJtUkwDSUDDGuapFWfaVOzGtyLodBQEuJQpOi2NBRh3Md/8pS74lTkuqlmr6aNXDiRB6cpA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPTL9CCGVCWpo4EypYu410oH0jUgAMy4tWfKyvikQH0xOoxS7C
 CLvITHDJ1n/9hfj8VjjjKWGIT3sw4ZfkEMAeSkoHmSFYMZ3EL0REob8fG4dDGMG4cQ5dSmG9sNs
 Ogvtt0nQaMgTlE1OfpkTBN/qvU9GHlkl6eUPlGIONqHUmhJOj2bC6grHGNhEQuSZjlf6SBAY=
X-Gm-Gg: ATEYQzyfF0OJReMhwQmdooka3AW6pvPZbH7cPyfoOAXRcM/EgGwWZZI9xjPvTYJtKWP
 AyB9j5L2iDOhsuZ+2ZoNrkWJx715jypf4FIDDgAYFWXIGkbGAaYbH2nX7zHBDbkZTIsBLNGcutf
 SaQPZgIEUUJb8IOu5FNBhByYW9fH84VI/SvjXNFWV6hdUWXkiM7Cka4MtytoILekJKhuUkD17Pk
 fOTJBzCPotkUrNuQLal9hOdMoBIz5tKsr06+Hq1m6FNB5wVwhBakc17b5fMrHsWs/PUcmCWgJr6
 rfFGwm/jrxYNnD2+pVH8L5ktVGwatDOy0I0zGaGgctKTCUB9531ElWBxUkZbgvRDc3yq8gGXs/Q
 Yka8cwslsOXZNv3zs2unpElMzDOTAjD5NCriWeE1C0AFD57KsuPI2sM5srNz7t/bLuQgWhpc2S4
 rHia8IMvJFhZNdSjET8RutV7C+/3SoZ1z5esw=
X-Received: by 2002:ac8:5e07:0:b0:509:28ab:987e with SMTP id
 d75a77b69052e-50b3753b6b9mr5002421cf.37.1773947106862; 
 Thu, 19 Mar 2026 12:05:06 -0700 (PDT)
X-Received: by 2002:ac8:5e07:0:b0:509:28ab:987e with SMTP id
 d75a77b69052e-50b3753b6b9mr5001651cf.37.1773947106250; 
 Thu, 19 Mar 2026 12:05:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b5esm82622e87.16.2026.03.19.12.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 12:05:05 -0700 (PDT)
Date: Thu, 19 Mar 2026 21:05:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <rmv26scjsc6md55dkvs2uam5a45mmslsqbyuf5lh3ssw3tu6uz@wzyg7zm2tfkl>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
X-Proofpoint-ORIG-GUID: Yr03nOrOKQz0yiwlyPHngOkoNYJ9WraF
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bc48e3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=L2_DCg_Kqtn3RnkwlLMA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Yr03nOrOKQz0yiwlyPHngOkoNYJ9WraF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MiBTYWx0ZWRfX/lh3arqqqaWV
 P9vrisPckVXMZuoV1eXiTOrnOW3aiI7Ncff2dcrPlIOtHx4cmn6hCuWcfwRIAffXd5SyKyuYGrX
 7x3EW2qJX8XOGrgkySfTt/+zzLCJxkW5mUcUjqPDZzwAqWT86ZH3+t7bhP2bXvrBZ9sQbQe5S8p
 C8O1XXvdOz+9nw850KgrNdKrXxRhNKjyxCDCuL9svcGLo8LBCPoG5jIYm5OY8tKvJFQdzXr+Ffz
 RRkrr45ArxWEv6NDDt4AQt2/l5tRcZVa8BVpknkGjydUNqYOYAlqOs629kqial3i6nfuufgZLHA
 7iE2rlHb7GXbjDNqp8uNVfgz3lwFaquV+SMq1EIZW6BbaUTAWKR5iCQ3d9b30KK4M1gUG/98fpI
 5QY7ZevfdMyEp68gHTlC9iF2hImJhSvQ0Hi7jZhg3mrW0IvMMYVTKDGqbP7sqj0bleyHTbSqJbm
 Z2WDPvZRDG0gNJwtEgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190152
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

On Thu, Mar 19, 2026 at 03:09:13PM +0100, Neil Armstrong wrote:
> Hi,
> 
> On 3/19/26 12:58, Alexander Koskovich wrote:
> > Using bits_per_component * 3 as the divisor for the compressed INTF
> > timing width produces constant FIFO errors for the BOE BF068MWM-TD0
> > panel due to bits_per_component being 10 which results in a divisor
> > of 30 instead of 24.
> > 
> > Regardless of the compression ratio and pixel depth, 24 bits of
> > compressed data are transferred per pclk, so the divisor should
> > always be 24.
> 
> Not true with widebus, specify why 24 and because DSI widebus is not implemented yet.

Support for the widebus is implemented and enable for DSI >= 2.5.0

> 
> > 
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index 0ba777bda253..5419ef0be137 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
> >   	}
> >   	/*
> > -	 * for DSI, if compression is enabled, then divide the horizonal active
> > -	 * timing parameters by compression ratio. bits of 3 components(R/G/B)
> > -	 * is compressed into bits of 1 pixel.
> > +	 * For DSI, if DSC is enabled, 24 bits of compressed data are
> > +	 * transferred per pclk regardless of the source pixel depth.
> >   	 */
> >   	if (phys_enc->hw_intf->cap->type != INTF_DP && timing->compression_en) {
> >   		struct drm_dsc_config *dsc =
> >   		       dpu_encoder_get_dsc_config(phys_enc->parent);
> > +
> Drop this change
> 
> >   		/*
> >   		 * TODO: replace drm_dsc_get_bpp_int with logic to handle
> >   		 * fractional part if there is fraction
> >   		 */
> > -		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) /
> > -				(dsc->bits_per_component * 3);
> > +		timing->width = timing->width * drm_dsc_get_bpp_int(dsc) / 24;
> 
> It would be helpful to somehow show that 24 is 8 * 3, 8 being the byte width and 3 the compression ratio.

Otherwise I'd have assumed that it is bus width.

> 
> >   		timing->xres = timing->width;
> >   	}
> >   }
> > 
> 

-- 
With best wishes
Dmitry
