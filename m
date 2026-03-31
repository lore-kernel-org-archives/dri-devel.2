Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D00109B481
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A108310E9B3;
	Tue, 31 Mar 2026 15:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CtWYsn2X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G3fdPFWx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5DD10E9B3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:01:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VE384v058044
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iGKZX/BUGzT6h8NG+iSYgUMZ
 RnWrIOl4D2qOqQdlIH0=; b=CtWYsn2XGUJ5Albxfn0ABBSzAhT90w06rojSFjcH
 ctdaREu/5goXnHGCmrAQAS4Gn1+SjTZ/Iamxrq8PZS2SWH8jJjcNqcgbKwurWt1f
 S0W813NXBMoYBw6VYrfo/IadW+Teg1mShkYzDyN4fwW48mucZ+hGcmrN3E1TmtMe
 wjYJH+hgTcnzA90iZz3tb+/EL9gA82U3glkVrK5WULFCw2UyJ0H+MoCSQtKqMf3J
 HCaE7hCy4J8LQ5TEovt/p0bM1CR/LbdP/vDeiiH7W4ndlSUyLOdeRFqnvknNcX1a
 KBbGZe7Yz6E4bKIoGsT3PbdGqixRc7BvD/iMZL/i/K/S3w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8ahksrys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:01:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94e9d49f7c7so11811764241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774969285; x=1775574085;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iGKZX/BUGzT6h8NG+iSYgUMZRnWrIOl4D2qOqQdlIH0=;
 b=G3fdPFWxGTRF2xlgmofGq8YQaupzrez4eI7AY1m/++b5sc/r+nqsJhODRslk3c2/IQ
 djZsCMKhiz/y1kwKO/u7ofUhO2veRdUblhfkfaEizD91wF/l4JYZhqOHZqpBjrtupM0X
 luoignPz7XbomJskAAfKkwUkojtp0Bzabyu5fMQYcGUewsA9Pv9sh+k3GjcM3NqF24Bd
 TFuJ6NoaRb8UPAsDoOM8Nw4MYi2c+dQdrwhIIXq/ICmdWhzzFmEip9LJEfrzsH3gvcMH
 ILvie3PeMVbLBKnY/fg+WB3yvqEHelvUBVFwk/GTqeht8hxsiJPxomm+2JipZx075PIX
 0kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969285; x=1775574085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGKZX/BUGzT6h8NG+iSYgUMZRnWrIOl4D2qOqQdlIH0=;
 b=QUA9BZvT5gkv06T34dWc1Wt2avJCxXdzru268dS5aEDUYrzVo6GAa49R5qSxEgX3Nt
 JIiZhv/lx9HIiZradj2h4THQJmRSBJTe2Jq/w5273Xchq0jNY9Ki0Aa1RnYMrkM6q5R/
 ZJR3gcBQwY7ZP5VaNwMxyhlHrbEMbU592BeT+L7WulV0zmn3mum8kMkkpFUCyo3adSBM
 wfj8ZTankGv5KNlJ/Fbt7rmgI2bvICn6fNd5ers1LpwzROgqvt0gxuY6Nl/HoQ/SA3Sc
 EXP4Mnaz00XPT4mOpVxDgVsiW/80zVfux0Ay/9DffWKq9LjEAEdTIvSyaFM6TVkvUSuZ
 rNxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqu07G5xFAvoc3yjnYBY424iq+l4G1EquOCxdGpvYOsNRyBcssLgebST8m+2TjTy52pF80jPjWTjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBcX9DBbFwcx60owinap2KZLrINSegWMqfoIwGRZ9N889UBOiP
 v4Qrqnht94Ap+lI89VdFUQKegcr/tNvlBDN6Uy6D4WAqTfUXBgX9FUBlgw7xvusn8bfjxThl3BX
 gR/ZXAmNgO0oW/vts3k+RGudUMMseXKasL+A53zFaIycBoLOmMvZxrG3SbmErzBvZ/sX0y5cYdO
 ptChY=
X-Gm-Gg: ATEYQzxPbQl3nGAQKr4t/CPcQSIdl9I2Cs7mgESHLIY76xcWrpmHlbH5TfhOB3ttd1t
 Y3UDYbqFeq2cehrFjZh/vYzk6tJqWsare8TASahyfUqusSWONO4sT6Xq9XKAclHaCQjoxHQNRa4
 FopFjth/L1C76IwGPnFGPetkawScJLVfRf/COht26ZL6R0VS3dGIT+sh48UMycw5pNtwFowslke
 fRnAQY4EthjsYTpxsEplqbkVBq38zj597sfqT6z26bQXDzSlXARRqEVn5I2wxFcOxYVYHNO+Sxl
 xTtjgmBEZ9yDaFFUL68rlX1T+IgxZUBBaHfg7E7SBPbmKFG+KAIZ7DKvUAePrDBZ3aV+WAeRmuv
 xllVfM5rYjQBlvyy1Oq+R1HLvZXHvRz6E4fCEKkaeqRawnnUn9gHec4reNzhqVgAfbA5T2kwiKb
 fb9kiwoq1+8nlwqnPWCKsUPouuPNFyW2LXE9c=
X-Received: by 2002:a05:6102:808b:b0:605:38d2:26c4 with SMTP id
 ada2fe7eead31-60538d26ed1mr3475616137.1.1774969284620; 
 Tue, 31 Mar 2026 08:01:24 -0700 (PDT)
X-Received: by 2002:a05:6102:808b:b0:605:38d2:26c4 with SMTP id
 ada2fe7eead31-60538d26ed1mr3475468137.1.1774969283481; 
 Tue, 31 Mar 2026 08:01:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c836d4381sm22780401fa.2.2026.03.31.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:01:22 -0700 (PDT)
Date: Tue, 31 Mar 2026 18:01:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: waveshare,dsp2dpi: describe
 DSI2LVDS setup
Message-ID: <557vnv2cpd7onrfkrzv3wngfdbznrb5bxmtmp2t5utjzmuhu62@6z3ihzgsr6po>
References: <20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com>
 <20260330-ws-lcd-v1-1-309834a435c0@oss.qualcomm.com>
 <20260331-roaring-carrot-stork-edaef8@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-roaring-carrot-stork-edaef8@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NiBTYWx0ZWRfX6Jocqjjn0tQB
 lAPxPW4yJ3XzT7Vpt3hyCrLuMSmCbpdMsusO+oFCkUZtufky1FosS7fDbk+Uq2olntw755MRYEt
 f572AZH9Sga5q5h5zyIBRKBq6aBRZVgcEVJc3yHqX6XUsJIl2rASCQKPd2svFd9XCiuTWXQf8hp
 wa4T+aCq1yJ64WdgLidjltkEdeV8lT+r2szjTkRqqvf+SOhI8axqQhuziUmR8V9Eq5ga6rWgBVF
 0qrku0jwxneWKYgwiSgmT3yH0SbJtPu9P2gLYZQHCtXB7B9VB8rqi2X3enM2EWwSzHIDQK3Ut/E
 jDrtAv/WGbApkWMvpHNlRD+nhcH2r3m5SnGeg77iukg1cecCzBwnsbuGu1wYOL9U4GoQgP8Y2SE
 B9Jo8h+22u+mzoGFKRa64vL+9bPkyLAo8hJHjcT9pztfRFIKA3EPAtDbOlT9e6+wLX3/kYpr9WV
 pPs7/CaDK4WGTPVEetA==
X-Authority-Analysis: v=2.4 cv=K4wv3iWI c=1 sm=1 tr=0 ts=69cbe1c5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=UKDlnwwNcwxo8CKECkgA:9
 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: J5jBjiE87UqxUulqQbkOalDoIs9xl8it
X-Proofpoint-GUID: J5jBjiE87UqxUulqQbkOalDoIs9xl8it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310146
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

On Tue, Mar 31, 2026 at 10:40:12AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Mar 30, 2026 at 04:25:50PM +0300, Dmitry Baryshkov wrote:
> > Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
> 
> If you know the hardware bridge used, should not it be the front
> compatible (with waveshare,dsi2lvds fallback)? Or even alone? Can the
> waveshare kits come with different bridges? I guess yes, they could.

I assume so. I have only several samples. Probably we can decode it from
the kit images, when available.

> 
> > together with the LVDS panels. Define new compatible for the on-kit
> > bridge setup (it is not defailed and it uses Waveshare prefix since the
> 
> typo: detailed
> 
> > rest of the integration details are not known).
> > 
> 
> Please also update at least description:
> "...converts DSI to DPI or LVDS."
> or similar.
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry
