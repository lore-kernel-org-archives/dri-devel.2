Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E28DCDB47B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF0510E675;
	Mon, 22 Jun 2026 12:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2Jy+v9z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0r2yTFg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5811E10E683
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:09:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAn6H9452379
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mr4b8FTNexAmgmJ4RnPwr7PK
 MazeMTB2C3P0KtH/3lM=; b=E2Jy+v9zgX1nmku4m/z8gU5ZwNFUqSxWQRgVVwXH
 Krc9jv3RVP2Blv4t3AN2C727h1uu1ApiwcRwAP4BR5zV4k5cWFtZmDpE38nJyOut
 u9ADrzfrLLTyEyw4izytmlrHASxQTA4E+4pvV0EtJqjlHUpJnzBHi0LICAsv3S+9
 a+bmMAs+VN1+KAaa4Gw62fEvWk3R0tPokE+jqappdVA/lhFc5wBIZPfE+lOuCvCo
 IdPBfmH8zwZSlrmHp6beb4U6a7aOV5K0v+FmYb8/zGdeYl1bDi6PMFl5e+fcLCb7
 9+oniIWm2LlGppv02W2SlWfXYd5+uVUl4LP31QRiSxPmLQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj8dc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:09:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84531eaf8a8so6350321b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782130148; x=1782734948;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mr4b8FTNexAmgmJ4RnPwr7PKMazeMTB2C3P0KtH/3lM=;
 b=S0r2yTFgVKpYK+UErdujJiDmcdsGafPj9hLh0q1YIM3Nt8i9PToegFxOZAVOB25s0D
 c9s1EUofhtTogihCWx/XOXQlj66EenbaQjWOOL+Cd00buUdD7nFPdRAISfxHKuS94HqS
 3fWSu9rgh3IYfLbO7CzCtJjRqBtQH8ANbNCX6PRXpQ1KyrtLoWdC+FZHj4N9eMS+O82k
 oL5lIFqmad7ZPogyrdLooMwZOtb3hBgV8cqi7My3XDelrOKBJGL09aqOjSUjI7nIZoE3
 Oive3BhN+8LMZeAIe0onPYsvZqSKAxLmoi401PSzgfGXk2Gl/dJW1Bz/3Ufl0vU2uCw+
 JAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782130148; x=1782734948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr4b8FTNexAmgmJ4RnPwr7PKMazeMTB2C3P0KtH/3lM=;
 b=b6tXhfsxjZF7UMydSFqi9f/UZx5Mn0bk03O1CRw2uqCbglyOIbpiP7jgRGespm6krl
 YUGzZTZci/hRtctwx1DyfvIewbm7xbsIembQDkpbEveW+HUdq0ZgIgC8wmvlbveyBqkL
 uzioVOB714rTj1L/LHi2LYZ0DUQPolK8dnaf4gK07iaDXoic3MaTe3f9Ylq51W1GmfFH
 YvpgUd5lYAnn+yyBSnzHOs6yTFdXtG5yLHTCju17g2hU4UBjWFSS861HkcL1kTQ6u26c
 zDeWp6mttQL7gB9zJtTOMQkrLpSIiaaSCNnfW1i8N0gtYmRAYMS3ArUeNVs0V0N2glV6
 mZhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sz40EY1RoDGRdtEynNz+O8mG9L8g5rsjyCMjLH54Ui5Q7J2HYjZg7BFzI/+EcwcmCsK5LZUXhsC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy437X0AQdOP57iunLGBb2+A5nsTmRpzDKKqRTPqFzh6In6rjAN
 R5ady3sfdTrHZDERQ8PmCjd9HCGh3bUf2pteiLw/qN0S1FCOQ4a+JehenH/PXZOJ/fejlCBcBtQ
 6+lOaewZFa/FOrYwsOFUPPba6DepOh48KmQIgheJaMp9CWdpYQp2S42g8Q2k+9nEb1dPQaxg=
X-Gm-Gg: AfdE7clseCV8pJ94vMwxOH4ZRILnujW3Eo9bG0CDaLpAyH4vzSESu7hFQ3q9c2a/j7t
 dr7KsKem39QmiAbFI0GUsxaEFhiaZauiwtGaxExrRIu6glAUgG17EUSkUdNF8YWOXRfTfa57MfU
 jghn0IIzKrKZ3B7UiBxH6shnuPz2ltJK04xR3TgbBFc67PapoarfBydyZ5SWJWnDHA2Uz/MAW11
 sFWVBXYnbp3SGLoNaB/diXBNrRHQoHD0ztl3jcBNEaHo9ozgfAtGAAdkCz0mkfRcPF1eu1ZMygf
 wDYkUZEyThl5m2tqKLhG28hc9u27W6thaf5Hq0nAd3mVQJTwMRs4Iplxf/RVV7vm34UDgkfv0Qe
 VfBWd3uCdRwhtGx3PTZWOE+VXICopOKhCmNV/
X-Received: by 2002:a05:6a00:2288:b0:845:36a0:9eb2 with SMTP id
 d2e1a72fcca58-84550887f06mr19610377b3a.34.1782130148077; 
 Mon, 22 Jun 2026 05:09:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:2288:b0:845:36a0:9eb2 with SMTP id
 d2e1a72fcca58-84550887f06mr19610315b3a.34.1782130147591; 
 Mon, 22 Jun 2026 05:09:07 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d6813bsm7651346b3a.8.2026.06.22.05.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:09:07 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:38:58 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 3/4] drm-bridge: lontium lt9611c: fixes and improvements
Message-ID: <ajkl2kl5oFh5tNG6@hu-mdsor-hyd.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-3-42abbcd3bb1e@oss.qualcomm.com>
 <DJ6YOZ4G73A3.37QF618MHAR4F@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ6YOZ4G73A3.37QF618MHAR4F@bootlin.com>
X-Proofpoint-ORIG-GUID: D8oDP8-0WUpTuNKv4K282zvXVswcCpoy
X-Proofpoint-GUID: D8oDP8-0WUpTuNKv4K282zvXVswcCpoy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEyMCBTYWx0ZWRfX86bX1bh1U+XR
 MBYAVtiWeGXlfYwiWmTcuHhZp6bRBO/Zq0ERRygq8El7RDhYKAV//bx+Q+0cBmGr9u5Wn3AIWm0
 CP/HlUtFgnpmXpmSuRLjp8F4rN6ONIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEyMCBTYWx0ZWRfX96wgica7atN/
 Uo86fzKSLaH9Di3GihxN0IP3Vz2Cx3Ky6TyeIw9fLsGy7j7IFqfIR/NlN4v8ix1ZbOiGJXTeiPa
 kzAzHBxEbWiLMvlYJyS8l6Dpvb48b5sb9hDRaOu4lOq12ZiPdP8OCVI+wKgkkAEOrXW4C5vTNPF
 kXmCSciqJ33w1+kH80TtrTbguV47zzhrWmKZ3TBfp+XSye+3hFvNbd/PXImFhJKr9fHMULF3KFM
 ur9Fz5D2+wCTmlHeA/8TZoKD9YYqbxr0VXnAjNohK2PrmyvTzEJEaLTm7czuBdVMQXrzUPF0Bnk
 aEat0ZIW2Dfo2LrRA4AL7t2Y3Hi3NoVd/sfZBNqvN+7hVzskXZTx6VG1YgnL981c9fsPX7auawn
 r40EmmQSU6Rohf9cOTwSoCpjtpTLXOWeMb+xVoBBrUDtPHJIwoxt/O+cZNg6JdvnTNKDvuBJzTi
 22T0ugG3NAylb7I0eSw==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a3925e4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=hmx0KWIcr96AgVAgIYIA:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220120
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

On Fri, Jun 12, 2026 at 11:26:34AM +0200, Luca Ceresoli wrote:
> On Wed Jun 10, 2026 at 11:14 PM CEST, Mohit Dsor wrote:
> > Remove two redundant lt9611c_reset() calls:
> >
> > 1. In lt9611c_bridge_atomic_pre_enable(): a reset is already performed
> >    during probe and resume; calling it again on every display enable
> >    adds ~440ms of unnecessary latency.
> >
> > 2. At the end of lt9611c_probe(): a reset was already performed earlier
> >    in probe before lt9611c_lock(). The second reset is redundant.
> >
> > Also, the DRM HDMI bridge framework requires hdmi_write_hdmi_infoframe and
> > hdmi_clear_hdmi_infoframe callbacks for HDMI vendor-specific infoframe
> > (VSI) support, used for features such as HDR metadata signalling.
> >
> > This patch add stub implementations that return success. Wire them into the bridge
> > function table.
> >
> > Also, Store the chip variant enum value in the of_match_table .data field and
> > retrieve it via of_device_get_match_data() when probing from a DT node.
> > Fall back to i2c_device_id.driver_data for non-DT (e.g. ACPI) probe
> > paths.
> >
> > This is the standard kernel pattern for passing per-compatible data
> > through the OF match table, and avoids relying solely on the I2C device
> > ID table for chip type detection when DT is available.
> >
> > Populate bridge.vendor and bridge.product so the DRM HDMI framework can
> > report the correct manufacturer and product name in the HDMI connector
> > properties (visible via xrandr --prop and related sysfs entries).
> >
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> 
> These are several unrelated changes and should be separate commits.
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Hi Luca,
Thanks for the review.
I see your point about separation, but in this case I intended this as a single cohesive update to the driver rather than unrelated changes.

The redundant lt9611c_reset() removals are cleanup to avoid unnecessary latency during enable/probe.
The HDMI VSI infoframe callbacks are required to align with the DRM HDMI bridge framework expectations.
The OF match data change ensures correct chip variant detection when probing via DT.
The bridge vendor/product population improves user-visible HDMI connector reporting.

All of these are small, tightly scoped updates that improve correctness, framework compliance, and observability of the same driver without introducing independent functional changes.
Given that, I felt keeping them together makes the update easier to review in context. However, I can split them if you strongly prefer that.
Regards,
Mohit
