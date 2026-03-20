Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5798109317F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5136B10E982;
	Fri, 20 Mar 2026 07:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESeV3J8U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQhKaXiK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADD610E982
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:36:47 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2Xgap3614544
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tBSvIF6akWxqZAvBPkW/jgbs
 GGZxl59HuTz3JSGfNpA=; b=ESeV3J8UEqA27SZP3XN1RcWjYnw+cF6CMOgpRCWN
 rT0CD/Pa+J6TriIMjv9NW/StEKw7EUwKQ4p8kXmOmo/uVDMIW2fSTzAuaa20zYjS
 MvsA6aZfZxZiCvSkuG6AfhpE3DDLstUf9VasDhEKb2nHYTclsoGf3qVM/nY2f6R8
 cbCf1VS88Q/zNrOnwR8GImB06vAys1z4PHQXVWr03/V+WSg0VTNYWTQ36/YSlNn+
 WchKmrizuKIxSiimauBM2gOe/hjY8cbTOt50pD+8hPt7DWKmsPwqL/Jdo8qMUxSs
 mtTwCNrO+no5GRt0dFPUl3fiEptD+64Amex7wyaISfW+Hw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0qg79hm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:36:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b2cbe7223so101856831cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773992205; x=1774597005;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tBSvIF6akWxqZAvBPkW/jgbsGGZxl59HuTz3JSGfNpA=;
 b=ZQhKaXiKfOcEZ0phOo4fsM5IIao0E9V7Ht4dl2ZoJoTcnozRVq+7VSFGlIrlKoGO+N
 4MeZ/xbj2dUb/BzeYTFLNhlDwevXdMA3LZUKsQDNAuSuWjrIRIT6DRDdZqiPgLAi6TD+
 EfklGgkWlBDoGP+eJ+ogcVIrHPkgVksKzx+quhSrmxaLrWEmzrjL4AuDC7f0eiQ5c3Y+
 OaceUSB9ifPwix2nz8yDG7xKMsEjnl4dJgyoUzZmJpu9KLvYDCLrNPiL7FhEEo1WgNNR
 qPek/leWDA+PDh3xfHoE22lBTst25JNJIvvNGAGr5oEAE4QGu4492cM1YXdrkV+59ERs
 ywBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992205; x=1774597005;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBSvIF6akWxqZAvBPkW/jgbsGGZxl59HuTz3JSGfNpA=;
 b=sZ0jtp6U4EWtuatcHv97WA3uPBJOm95aN3SzHWy9/ePBykGV3e90IYyJ2fMlV9uB/p
 mI+T96IF9jgP8lcXDCj1KKq/PCeMDL/k4tjwj4+trdV09DY2X8VgZwiyOMCs8kuPq9ZM
 ArBTyiO7+u8lSiLBux9gz7VYbfjP3BM2AfMu56TCsHohhUX8XTtGmnYNgCaZkOKJ8SZz
 oLyiDM2IywUG/kZhSHJmCgrfhIaidDWn+a7Dm/2ajwyxaXRQwEmrdh984v9y72Y2ZP/e
 JxHpWQ0VGroFkHJwt1JQL+sCaG/Y8ANrYxXtpM5kKlIqOfqFqN2gnDnLHUDjqh9ZKNqu
 8hdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlRumponGDZFyEtg03tBMikouZzKharPGM534Z7sua5bh3utGsyxR/8hJ/21sKCITxzR7XfOecXRM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGgrMaApJNgIvIlXFCrKIQ7CUMinWrWycMhr/5PHMdyVOjgMOh
 qQNkwUOr9CvWI/wAcJj3J6ZztgzYEFXSe0dvpMyyGEt1TcaiCaGJ+VvxXn/Y4aYCP55IfOfxdyP
 zlodQ9AWJEeYIf3n0XfYeXyWWNb0ewdCZQl+Ij7WxEZZJSGsaI2K+WHmLRWzsZK4qDVEQgnKCmp
 pWAL8=
X-Gm-Gg: ATEYQzyc/rsEoFYwaMUq3UCJFjBpJZZ+ikyer83L/UoJ8tQNotWh+iutDlSjL2Ct8F4
 Lr1trTz3B3c0kLJ11FusfFMpavXqlZyXV0N8DNSRrKgpkEF7PR8mQbZuv2OZ+qfT9szqPAh/Bok
 d2yoE905zT5soe07cgLAEVNetj2r9/eTyfbEs2ZsW1Ry9Sl+KnK+fLblzMGhlQR1fC2V+3AKzAR
 76Fp1oa2MlcKDlaZp1jvJ/FeOI10K3+MLNJQhrqZco+6x6NS2XTVD5CagN15WbpJOMvqFYCr4Tm
 Mzr2Mv71cqdje+31EabXrqsXsObd1bKbF8DZTGl8Ueos24xGi8FQaWYgkKQs/I1MO875IJeZUuK
 G4X2idn4AJfK8wf/tUqhvotpvFIpGnRLktCwBkPTxrNMqva8x29VhrYQTG2HxVRRUI40/IybUgG
 eynNlHdo8ViVvwP+c6utHB3W3dW1HCVDYrKAo=
X-Received: by 2002:a05:622a:4cc5:b0:509:1b01:8916 with SMTP id
 d75a77b69052e-50b3738b7famr30761471cf.4.1773992205001; 
 Fri, 20 Mar 2026 00:36:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc5:b0:509:1b01:8916 with SMTP id
 d75a77b69052e-50b3738b7famr30761261cf.4.1773992204505; 
 Fri, 20 Mar 2026 00:36:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192dbfsm378336e87.1.2026.03.20.00.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:36:43 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:36:41 +0200
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
Message-ID: <7o6ddv23aft3eerc7xz7r5rawe24d6vl3qp33ewnqllv5xkfrf@n3dosrwbvlhf>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
 <pVeuxasxaau60kEIgTW1W6DmFLuzLUGYvmYtTN_Cv0htPbokC6lMObfmql3lWkAxtO5Lp-aD2l0Uzt_xL8cGYVxBmDey-5-HA7968eocg8c=@pm.me>
 <a7jukaag6juswudeeuskgzahzbixxn5oq4qjnxfny2oapinfnv@kmn7b33yxric>
 <jv_kU6i1uCSu--2-KIWkgsC0NsVK1yE396Nv_fCFA5v9uR-zrMGhrBmKNnG_ztHPiKPqlcjWif3R-XF1bINB387ezJEKtXDY453253BM6fc=@pm.me>
 <nVcYZQOh7dB65LsiaXejmQP-Cmp-eSxp7fvDiTwS2P5WJc03m4CwXtUP_2w-D2dflxo9rwKPI68FxnfswATouZxK8QhF256JJf3F7BkbmY0=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nVcYZQOh7dB65LsiaXejmQP-Cmp-eSxp7fvDiTwS2P5WJc03m4CwXtUP_2w-D2dflxo9rwKPI68FxnfswATouZxK8QhF256JJf3F7BkbmY0=@pm.me>
X-Proofpoint-ORIG-GUID: Tcmnzu4edIx0b33dwgVEQCgp04a_11Ul
X-Proofpoint-GUID: Tcmnzu4edIx0b33dwgVEQCgp04a_11Ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA1NiBTYWx0ZWRfXzx60u/wEOLxR
 Aqwnh+Hzpkd9TIW1JWigiRH7f6ZEjcl1WgFPt+dvG/qHsLWJtchDB57qk2BLuIAG749zurYoclC
 m7QR3/fX0QzDW4V14hmO60Ij5YgNaE9FWVXWwpjT6pKuQlHV4CA28cXLTqg7DMCiFWhvAz9hEo+
 42OIA8jDD52DxT80Vw/ZlVpHttmMxi0hMn740prugWslviWZ4a+aQcqykNpK8ys4M5uZyr6YJ9I
 5tCDNHciPAUD+L3TeuGeJxcl1ROkgjS153zxcX8WuORWFoOFS//gRDejdmfXc1f5aZkwHVQzxYa
 w4HxmUDUJXvAQ7//GWnQMskiqMP6Skwnszxz2cxxm0k/dRb9Dj1X5IhtxgyiAIb0wtEdIMEDHce
 7nhcUtW+1rTnh0KgFUtA+LztAAoJUzAvTYsrJjtfhPaTiEr5jtMRlG0qszlq0kwT+JfEsja3b2J
 2F9+T5GcqDvH/ksA2MQ==
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69bcf90e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=tVI0ZWmoAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RAbU-raeAAAA:8
 a=UeJVVWTCdUyxyh09lF8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200056
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

On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich wrote:
> On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich <akoskovich@pm.me> wrote:
> 
> > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > 
> > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovich wrote:
> > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <jonathan@marek.ca> wrote:
> > > >
> > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> > > > > ...
> > > > > >>
> > > > > >> That's not how it works. INTF (which feeds DSI) is after DSC compression.
> > > > > >>
> > > > > >> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
> > > > > >> the INTF timing should match what is programmed on the DSI side (hdisplay,
> > > > > >> which is calculated as bytes per line / 3).
> > > > > >>
> > > > > >> (fwiw, the current "timing->width = ..." calculation here blames to me, but
> > > > > >> what I wrote originally was just "timing->width = timing->width / 3" with a
> > > > > >> comment about being incomplete.)
> > > > > >>
> > > > > > Okay. After reading the docs (sorry, it took a while).
> > > > > >
> > > > > > - When widebus is not enabled, the transfer is always 24 bit of
> > > > > >    compressed data. Thus if it is not in play, pclk and timing->width
> > > > > >    should be scaled by source_pixel_depth / compression_ratio / 24. In
> > > > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > > > > >
> > > > > >    For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
> > > > > >    by the factor of 3 (= 24 / (30 / 3.75))
> > > > > >
> > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
> > > > > >    more than 24 bits. In this case the PCLK and timing->width should be
> > > > > >    scaled exactly by the DSC compression ratio, which is
> > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > > > > >
> > > > > > So, this piece of code needs to be adjusted to check for the widebus
> > > > > > being enabled or not.
> > > > > >
> > > > >
> > > > > The widebus adjustment on the MDP/INTF side is already in
> > > > > dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for
> > > > > 48-bit widebus instead of 24-bit. there shouldn't be any other
> > > > > adjustment (downstream doesn't have any other adjustment).
> > > > >
> > > > > a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sends
> > > > > out 48-bit compressed data per pclk and on average, DSI consumes an
> > > > > amount of compressed data equivalent to the uncompressed pixel depth per
> > > > > pclk."
> > > > >
> > > > > Based on that comment, this patch is correct, and the
> > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustment
> > > > > only applies to DSI.
> > > >
> > > > If I keep the INTF side at /24 and change the DSI side to:
> > > >
> > > > if (wide_bus)
> > > >         new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > else
> > > >         new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc), 24);
> > >
> > > Please check the actual fps (I'm usually using a vblank-synced GL, e.g.
> > > kmscube).
> > >
> > > At least this matches my expectations.
> > 
> > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS with 30. So I guess that's a no go
> 
> Although it was using dsc->bits_per_component * 3 regardless before for
> dsi_adjust_pclk_for_compression so I guess that's what Jonathan was
> referring to earlier...

Do you have any of the patches by Marijn or Pengyu?

- https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regresses-again-v1-1-6a422141eeea@somainline.org/

- https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlatltl@gmail.com/

-- 
With best wishes
Dmitry
