Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B384D109317F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A97410E980;
	Fri, 20 Mar 2026 07:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlThu4uE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SSieMrbz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5415510E960
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:34:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K2XlT11191341
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RzyaHrUF+2Rq5v8u7FcJPE2L
 k/P9aTcofVlQu5cNlhs=; b=jlThu4uEcqgP5hdHP6mNYcCVLySotGEvZxIybp+b
 zbvjrdht09MMe78Kz8NLlEtUUsiIqfzHWHvDmre6k7Xy3O7kcoG9TgPYQr5dsisp
 dsqHMiyPREuQpt1NZZl+FnC/mhv1zz0HnU2UJJOxkheQvGJxcL20AFPwzFItAaIg
 vsLbFDCUMoxjllvl7F5mcwfmAWFd2IiIZMzPctNm1gbEyIV0PC9NdHv7g2w2gXN1
 WAPTFkYDy5UnyIve/p7v+dBAVrtdtApY5SPZSxSxWWDT9JyNzBI/ssISLyIYcmcW
 +ETKTeGxFcYSso2O5YUB2sNfZd86Ybb8G3ylLtAwn1DBbg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0pvhsnu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:34:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50939597b85so58695951cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773992074; x=1774596874;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RzyaHrUF+2Rq5v8u7FcJPE2Lk/P9aTcofVlQu5cNlhs=;
 b=SSieMrbzFgl1ulIT45qCdBZpCj5+h969+BaG84BzzyGniQJVZoeQqg42hHmswC6eV/
 y7ABq/8K9Kihl2vQWi2HimMA+D1rEZifdtHkhxSHsZThHclG3qHLWNSkvmdFTx6qL3fZ
 RN+6pUx4PwL5AMMJGMqSoQOYYIqdQD5TVgJwTjg8eO2/7r3tRhRmk4ItgGXB3DS7bmcc
 eYlzKmUq8bYOx5iIWWjkbEZtwuRxSk9RRSPNaFc9ydAI6PzC/5PIg8Yxogw9XlU3Qu/P
 zGCIouy+d8G39R8CTMiv4bhIeE6ZRZxn1gZtqQ1Dl4d5ttbpiz0fOdVLNDsMU6VQT4l4
 ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992074; x=1774596874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzyaHrUF+2Rq5v8u7FcJPE2Lk/P9aTcofVlQu5cNlhs=;
 b=mkDd5PwbzVz+nTsQY/DC7Ujp4ndpfC7ZW7s7naWkoMHvEt62hCTENWuRS8vxv5l9wA
 AiifJxxX3w6QVJE2v02gmR6M33sfuP2p2q1W5Lhbfm+InWufbNQzOzdzvBx8wy5D2Yrh
 K2qiyaYZQ7H42KRgyIGttPVDi9ZrZUeLG8WI/8ss2DNUlvbA/6GsTSoWkLpHicPH2WjM
 JjUkDk/no+r9fsYFtqV7mCXGM3xzsKLWm19vp5izq9DlVFaTmzh9c1gUw0Ka2gQTRPBJ
 Yph3Gq5OFAaNwbLkglpcnihth8SaQf0BNXmpkK/N6TpO0l04W1fxr8JJvgZv3p915l6C
 Szog==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9JeVH8J0dWzWOXUa0Hqb1r3HBqJgFtHhsG9OgzyAXaUW69C/nYdN6u4wMo7Cjm05L7DeLcaQE+60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywf/OSxDKJm6TStumUe3PLkAcIqjNkWGOVrNirFzO2ygs0z72lk
 4z35shyTJwK4gCYx1/z1BkbTgWFd8/L+q0CLB5fU7tjDqoLGUNYuv44GLkG1g+DVVHbl/x/AITj
 7pyzMCG6j1o3kuSSCNPI4keuiPf+9puomi0rU5JZZVfxRGr4Qigbs8E3wFnBb+fiLbNPWKxM=
X-Gm-Gg: ATEYQzxvsgPQCPUTJeundtI5vQ4NsIV/FNl3P/fgSz8nFhoqgnC3Q2FIbZk2W6K1sP/
 Jk/4bFS4X4JUVRs1Dn+DJNKC40/8y95OCVh4hLTIZYEqDqWSTXtfwg7zl8+NDKzMMq/SKTvMmGA
 880o85OH9R8a0IBATgFX4qdqEpDzvfy5fPnT1p7xQBz8r52cgvBIoYvROcr0SvFeDDK/UHGVCY1
 q73WKcDkHB91eD9mCd4eNNSJoYLCzhy9yUL6lB6P3o9WohgQ6iVwB4DwtLqGjf44DuZk2YLk2DY
 8pJhqwnh5hTYRTm+kk0UIk1w70a8V1uKi3io5ikevrYNLbN32brd0yGAx1jeJ1nbjjSZQsy3Xgo
 5PxefWSc3dpjF2+B+QGfWoVl+HdRomPCbhhyHiRmrv4WSeGi/0VGEi/6UbZOTs4VrzTlwS1GCBe
 6GP+2e8JwTR9bpHuToayZVOtAPV9DowEPKyE8=
X-Received: by 2002:a05:622a:5145:b0:50b:2763:2bc7 with SMTP id
 d75a77b69052e-50b37437f1amr27547581cf.31.1773992074458; 
 Fri, 20 Mar 2026 00:34:34 -0700 (PDT)
X-Received: by 2002:a05:622a:5145:b0:50b:2763:2bc7 with SMTP id
 d75a77b69052e-50b37437f1amr27547391cf.31.1773992073962; 
 Fri, 20 Mar 2026 00:34:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285207500sm374535e87.41.2026.03.20.00.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:34:32 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:34:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonathan Marek <jonathan@marek.ca>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
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
Message-ID: <afgu3v6tc6ehgbdv5elptvw4etrxnmwymjempfp3ncgap7xvpz@hllpalflucjv>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
X-Authority-Analysis: v=2.4 cv=F95at6hN c=1 sm=1 tr=0 ts=69bcf88b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=qC_FGOx9AAAA:8
 a=bfie0XZXij7nCIgiEDAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-GUID: VQpUVw1kohES_mD_SmKBuzdh3wBesFGM
X-Proofpoint-ORIG-GUID: VQpUVw1kohES_mD_SmKBuzdh3wBesFGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA1NSBTYWx0ZWRfX8VghKGJJ7xt4
 uoC7DWZmuZ0se+bwRt5CfReW/MePcY1BWIikNUE9QxBTmVPRB0McVbwAcAbhT914OHADW2/jE8r
 gi7WCW0fo0ZIzU3AMQQQbmytIZkFQ9MgiJzhVI42xLt9V6j2wgU8pRP3TGLfprSbvy56JR1NPyK
 ZIc5EnFem8vcEJn3HS8oaA4FcbAlDufVlEfMfvXfnE/U4GOWuifUMdab1cvEVwefbVzMl4qezwg
 nl2ZoDUnkshhnrOkCrYacHjLjOHkdm8gFK5wcRWz/rdhHtALpCm6PQYm7+12fbyLlLBDfBZ5dJs
 Ge7H+wfEbrq9Suky1SwzCiSdycxzyPwsoGAJhqhbPhf1q/h/dfPM1XnuVOj0JRFAwjnqfXIpyRv
 iVpPdf6bUT8CaY3gsYnF8KYvg51rrokBx/quytcnt3bU4voa5Am8mrWYfTi254/QLZFRwiaGpy/
 H/tcY/2KiUJLGqfkOFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200055
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

On Fri, Mar 20, 2026 at 12:25:00AM -0400, Jonathan Marek wrote:
> On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> ...
> > > 
> > > That's not how it works. INTF (which feeds DSI) is after DSC compression.
> > > 
> > > INTF timings are always in RGB888 (24-bit) units. Ignoring widebus details,
> > > the INTF timing should match what is programmed on the DSI side (hdisplay,
> > > which is calculated as bytes per line / 3).
> > > 
> > > (fwiw, the current "timing->width = ..." calculation here blames to me, but
> > > what I wrote originally was just "timing->width = timing->width / 3" with a
> > > comment about being incomplete.)
> > > 
> > Okay. After reading the docs (sorry, it took a while).
> > 
> > - When widebus is not enabled, the transfer is always 24 bit of
> >    compressed data. Thus if it is not in play, pclk and timing->width
> >    should be scaled by source_pixel_depth / compression_ratio / 24. In
> >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > 
> >    For RGB101010 / 8bpp DSC this should result in the PCLK being lowered
> >    by the factor of 3 (= 24 / (30 / 3.75))
> > 
> > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
> >    more than 24 bits. In this case the PCLK and timing->width should be
> >    scaled exactly by the DSC compression ratio, which is
> >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > 
> > So, this piece of code needs to be adjusted to check for the widebus
> > being enabled or not.
> > 
> 
> The widebus adjustment on the MDP/INTF side is already in
> dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for 48-bit
> widebus instead of 24-bit. there shouldn't be any other adjustment
> (downstream doesn't have any other adjustment).
> 
> a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sends out
> 48-bit compressed data per pclk and on average, DSI consumes an amount of
> compressed data equivalent to the uncompressed pixel depth per pclk."
> 
> Based on that comment, this patch is correct, and the
> ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustment only
> applies to DSI. (note: newer downstream looks like it would divide by 3.75
> here, which doesn't make sense. older downstream would divide by 3 here. I
> guess downstream is broken now and video mode + 10-bit dsc doesn't get
> tested?)
> 

For the reference, the commit in question is [1].

> on DSI side, "uncompressed pixel depth" shouldn't matter either: DSI only
> sees the compressed data. But based on that comment, when widebus is
> enabled, by setting DSI_VID_CFG0_DST_FORMAT(?) to 30bpp, then the DSI pclk
> is in 30-bit units instead of 24-bits. And with this series DSI side ends up
> with the right result if 30bpp format and widebus is enabled.

Nevertheless, this matches the docs that I'm looking at.

[1] https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/-/commit/7b4616f157e67e593fae13684237f96da351e877

-- 
With best wishes
Dmitry
