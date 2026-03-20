Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2231109317A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F384A10EA87;
	Fri, 20 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1UbVc33";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uf3ivET0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8FD10EA87
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:38:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2Y9G93558008
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e1jtdLTR8LSxuOmbCFJP8N3o
 W++FXdcqMYVb+LnFgdg=; b=E1UbVc33JwnEYjRLL0pbfacWqX2gWHBLKhPMitmi
 OI4UfkYT7k87s0yhQKJLsqOls9+0txoOHOL9izSIRpvAPzljwD8AAePRNxpDjuof
 oyPmcwYPIkNXM4547E7QZeDHnqlYqFtS42MejUj2Q4mHlDDxvSMZAXRgWoV7fuwi
 EtRt//nVoIlrb83QrCF93KiH+dnygnxtTXgBG6u/bVlyeBgpDGy+i4Y1kFDMmlpv
 lumDvP3wk1Vgq2oIdM9ROFP2JgG2EUC1Tl3OmiLMqm6a7Sv2BzarEWsnpLmNG05F
 QG1XRdr0rNjgZP4+XsbJVCSHz/lu4JbIgtnfzFHEPfPbsA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gsaet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:38:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50925fed647so130808491cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773988732; x=1774593532;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e1jtdLTR8LSxuOmbCFJP8N3oW++FXdcqMYVb+LnFgdg=;
 b=Uf3ivET0GGBpwPvE7rbAZG9EFLKaeoVP1HHQVNJCwv+ruGWLCSD0rZtvuU9puTWUWd
 YzxRF2Tn0MrkJMjw8SWEfm8/tU/kZCL08/lgSvSire4P1nRf7uyHFURZbHa+mbopHdoW
 vcluTQ/7GthDiMEBy367875n0tjAxEHR1RthM8QVYmhGlqQSSAuTymKH3aQymk7gh157
 6SgnL9AKjwrZWUVBj/5dk1z/GiwLKJwwEA1ejUrIWGH5ExGvqaccPgZrbgSuJTpkrSZ3
 u5IjBkiKlJSff1MA2Q0aBIKqp4dT8PX0GAdh4V4ZlfvOSvLQ+m/xIA3CX1wlzeVYTNR7
 5vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773988732; x=1774593532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1jtdLTR8LSxuOmbCFJP8N3oW++FXdcqMYVb+LnFgdg=;
 b=mdZqAZyfDPHD5C77Ewx2BQJlH/4K5vubpTzSSR0MumOSvZdaXRqlf+BWhWVvMVm8H4
 6skLP5oaK4atL7MptFavKlrM5/5dGMFicWuJV5YpJrYAF7eE/GF6bZV7eim3VeJzocHt
 AvbVDm2eCpPaE2RTGSp3CM9ERJDRR+IDn7zjIo8iugCVGSe5kxc5viNpofGZsZkARblw
 Wb7gNahdaJoxxJukfO1/+SuJcX4h8spUX9XcvOuyW+aX5wIdvJYAiPmMvHxC1QlWokMp
 /G1JS1PiCCCvFh4qYEgRRCfR88nH5e4e1iNQSwgJaB+gmih60WSKIuJ1/+ATMb1RWUWy
 KZ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdi1idXKSklA/1mcYOzKm+W6MRl5TdwyDX1kRD4et7zdZHbnvS+rc9Apl8sz2LyJp4QM9XTcvqNY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcKMx2zLzxGW893ZoAv/smBbuGWFvUqTLcZYUDpZaCvB2IlPnz
 jvzkN5MOs72vfim22oRD387T0d/wrX1K5VnLXydJVMCUgIz/Ox08tTrYIRZ17cxO768b58jNAMw
 hXrFjmWl5WSjUaAWe9wdBmf14FnusYRZXM07unfixqcCzlYoJKDBLdNL2oUGJ2ZjuabKKvaE=
X-Gm-Gg: ATEYQzwZcTKLoE20XBHqUsuDT139U+W83w35MEESYtp/QocyQ7Q+pGqnNuq9IMYLseH
 e9cO1SZHynZV45PGOzMrHF+odEVR+b+JzCIAg/ltsqhg6FwAgxogRSxqICMKvGUJzgiWpq3D+jO
 MEAoynM6UtEk32D4yHMsdSqCKIlPluL0o5j+Z31C6xR/+kLlM0xlHxXDG1nbLgh0jixqX3MFYyX
 ZZ0OQmBSBkMBJhrL1fL+lrjLM8V+YeonDn48fdgB8QxAU0zO4EPRm7T3x89eFA2cpyNG7+KJnb1
 8thCfoCv7892OURNqdMWluh8yEcEMmoYankrv3kRm/E1fiKosC9165iD+Ye78MDTkW3ZKZnM1Ck
 yKZzaL2wRhAQ4XgHw20PDs//QnKcN56JfQqrCG31cGDKEiHZEOnYy2N9PSUMZcdUd3fXoKquhZx
 Ic5PzpGVjDD/reKfqGlzR1sBql9CUR+UJD3M4=
X-Received: by 2002:a05:622a:6097:b0:50b:2640:22e3 with SMTP id
 d75a77b69052e-50b373a0221mr27399381cf.11.1773988731731; 
 Thu, 19 Mar 2026 23:38:51 -0700 (PDT)
X-Received: by 2002:a05:622a:6097:b0:50b:2640:22e3 with SMTP id
 d75a77b69052e-50b373a0221mr27399051cf.11.1773988731214; 
 Thu, 19 Mar 2026 23:38:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192da8sm357209e87.10.2026.03.19.23.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 23:38:50 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:38:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
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
Message-ID: <a7jukaag6juswudeeuskgzahzbixxn5oq4qjnxfny2oapinfnv@kmn7b33yxric>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
 <pVeuxasxaau60kEIgTW1W6DmFLuzLUGYvmYtTN_Cv0htPbokC6lMObfmql3lWkAxtO5Lp-aD2l0Uzt_xL8cGYVxBmDey-5-HA7968eocg8c=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pVeuxasxaau60kEIgTW1W6DmFLuzLUGYvmYtTN_Cv0htPbokC6lMObfmql3lWkAxtO5Lp-aD2l0Uzt_xL8cGYVxBmDey-5-HA7968eocg8c=@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA0NyBTYWx0ZWRfX8sySVGc6bDBT
 wFkhIbIOjvxrMsNM0F2/RaRaWXSqwu/HFjt/3atyTy2nPj96KPixbukNQiWXW7XC6sckXqgvkoa
 1aXchdVz9XM+Q1bkrcU3tEVpMNRtKIs8tUopPib94a7uWWSwNMtGsdRF9dXOoEF7vu661ZguVHj
 IFrKvr5OFINtG5MsTvqplG7DCRMcCMY4/wYztlABhhiKV6bBbL9KFLEZUHf+w6EkKiXG+7FZGT/
 zRsqvaOXaEDVlPw27CbL8QHXQx/0qCM3+YH00xkWsid7x0uR5jUTZ6YoidUi2gEMU3c+jiG1pSt
 NJqEQOEcyexbYCU8nDHd8wOv5xfDAWNXOVTAnbpxAZyztwAur7DVM4EPb0N4QMcxrbUcXfFRb6T
 if2Blj5WqKQ0WGmDV4f2yyssEF8g5mPglC5xBg2mhBFHkNPqgSQwX9MQ389W7JH4//DnxWb0LPb
 FZL2DFTd9A3vpWvZByw==
X-Proofpoint-GUID: kgU1mtGajIQ20BiILRA4BwvKeYMx0VVq
X-Proofpoint-ORIG-GUID: kgU1mtGajIQ20BiILRA4BwvKeYMx0VVq
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bceb7c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=RAbU-raeAAAA:8
 a=87TsUx9vdYXdEiTG-ZoA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200047
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

On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovich wrote:
> On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <jonathan@marek.ca> wrote:
> 
> > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> > ...
> > >>
> > >> That's not how it works. INTF (which feeds DSI) is after DSC compression.
> > >>
> > >> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
> > >> the INTF timing should match what is programmed on the DSI side (hdisplay,
> > >> which is calculated as bytes per line / 3).
> > >>
> > >> (fwiw, the current "timing->width = ..." calculation here blames to me, but
> > >> what I wrote originally was just "timing->width = timing->width / 3" with a
> > >> comment about being incomplete.)
> > >>
> > > Okay. After reading the docs (sorry, it took a while).
> > >
> > > - When widebus is not enabled, the transfer is always 24 bit of
> > >    compressed data. Thus if it is not in play, pclk and timing->width
> > >    should be scaled by source_pixel_depth / compression_ratio / 24. In
> > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > >
> > >    For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
> > >    by the factor of 3 (= 24 / (30 / 3.75))
> > >
> > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
> > >    more than 24 bits. In this case the PCLK and timing->width should be
> > >    scaled exactly by the DSC compression ratio, which is
> > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > >
> > > So, this piece of code needs to be adjusted to check for the widebus
> > > being enabled or not.
> > >
> > 
> > The widebus adjustment on the MDP/INTF side is already in
> > dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for
> > 48-bit widebus instead of 24-bit. there shouldn't be any other
> > adjustment (downstream doesn't have any other adjustment).
> > 
> > a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sends
> > out 48-bit compressed data per pclk and on average, DSI consumes an
> > amount of compressed data equivalent to the uncompressed pixel depth per
> > pclk."
> > 
> > Based on that comment, this patch is correct, and the
> > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustment
> > only applies to DSI. 
> 
> If I keep the INTF side at /24 and change the DSI side to:
> 
> if (wide_bus)
>         new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> else
>         new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc), 24);

Please check the actual fps (I'm usually using a vblank-synced GL, e.g.
kmscube).

At least this matches my expectations.

> 
> This also works on my panel.
> 
> Should I send this in a v4 for this series or just leave it for a seperate
> change as panel seems to work with /24 here anyways?
> 
> > (note: newer downstream looks like it would divide
> > by 3.75 here, which doesn't make sense. older downstream would divide by
> > 3 here. I guess downstream is broken now and video mode + 10-bit dsc
> > doesn't get tested?)
> > 
> > on DSI side, "uncompressed pixel depth" shouldn't matter either: DSI
> > only sees the compressed data. But based on that comment, when widebus
> > is enabled, by setting DSI_VID_CFG0_DST_FORMAT(?) to 30bpp, then the DSI
> > pclk is in 30-bit units instead of 24-bits. And with this series DSI
> > side ends up with the right result if 30bpp format and widebus is enabled.
> > 
> > 
> 
> Thanks,
> Alex

-- 
With best wishes
Dmitry
