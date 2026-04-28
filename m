Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F2AFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF88510EA69;
	Tue, 28 Apr 2026 07:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHDI5OGF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/xZlffi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF7110EA58
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:54:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S3PXXs1238182
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9cA7LAzSpt18mLOuNqWwo3S8
 rGMWsexeG+BWcJAofWQ=; b=cHDI5OGFrJg5pJb5fwr5FRv2Tuh4HH/uFFMD3beQ
 ElVtfTpLjzyFZIkFFz62IjZQvSZaNoB9fBFYZRg9/UOPmamOe+1NJAvzQXhSAbVW
 78PuTwTGCzUBbm/5t6w0JXvllVMP/RJYJ824/THltlXdhJLeLok5FTf8+y55YnLU
 fXC7qRJtAh9fFuJYqrK3vlNc/ngrfByEo4mTErC2ppj4DjWwSIRG/N+juLQZJX/D
 JabhhbauLaxFnr5W/Af4gt9jTYQZ07HFpfsKrIcqTKPGSiZG6KZcqSQFOnc2GWCq
 LEaCRTM9piJsfRTx6WbrHrmum2uW4tdUSXp5QNT4zrLDyw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4m7nx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:54:12 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56b6751339fso13534225e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777362852; x=1777967652;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9cA7LAzSpt18mLOuNqWwo3S8rGMWsexeG+BWcJAofWQ=;
 b=a/xZlffiLTVScr0JOV9MfZSyaimqj2wyMwO1Sc751a+Ba+Nbserhp7EaHRdPO5zV3y
 qIsTS8lYhxtJmiQMUAs+11dDilzwZLkZtCU/9gVW3dEOUBvjaWTqXDVN9gyf4nQX9gmF
 jepqIgfLIm9RvZLoaIhboksmSGS67V7IulGmXtxL7QhGLAV4XZoSnD6yb2l55WXaePDr
 Pl8xhSNi9/40DnJkmkQr1qdCYTlgjodEyknzWT+/06hPaSZkZD31cHZnpFRk9acKXMsn
 4fJ/5LaVpS/zrAHlXvsBwV8wpyqA6yOlsjkg6KR/dqA9evmETkMXhdjFseOzNSnprptn
 PFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777362852; x=1777967652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cA7LAzSpt18mLOuNqWwo3S8rGMWsexeG+BWcJAofWQ=;
 b=oJPM0wHp2ew/ba/SmkYzNUF9ut0RQCkGbFRV2GOPuHBDXZa6vIUMm73tttvZRDtNfM
 JdnTOXFYdC9400ucBYbiWuc5HXFM9vZynxSV2JSuVLpCqTyJfPEJOlai97+5JuIn/Lwp
 HH7IAwMghHsaMplB7pqhTUuNinv4/sc8FCqgirtWwGl3VysIaPl3rANeNn34Vu6N1zwM
 ItiStUI2kZAN7nAIxL5IQQwm08LILuI6VdoODISseCKHJigPGtDr6YZDyZXVPiMzcHfB
 /ObkMX2Ct6qZ1OZznRogWJ7NLargdWtiyKpICMRjhKScbujmlbl7FkNlRuG9YkSxdjge
 mGpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wpawEDqThr603n/WuEe3welSDp+mxbQWcqaKsLxqMfclKZqu8MMCiVpIsNVuVFm0jgOHyxjUlBvQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznU+PdL1EgW1rCiZCRxDSsh698rInDkZznbk9XzPJPxI7VeK90
 ibKzQ+WF5BGycZ0Tx6a+uksFea+NdzmcevFzGXCralBwZmlpM5ZlaZNWlj+klUE6LcQ4+EdBD/4
 JEI0zpPvowQ0mNx0WkYRuHNRsivOPRpetKbhW9cWdIEkYuDh21R+wkHRddzHRlsugq0i5/U8=
X-Gm-Gg: AeBDiesg3/aZU0PoEITkPTN/kb3Dbd2Eto67FVuHd3f3Al56hh0DMQCfc/J8DZ34M6F
 UINVCWbZmZCMMfGRzcSCj+sQI4uBnPsFubyNhljf13QQ/doRJzvaPsEAdAlVoaua8euujVq6bsV
 0DhcPiVdLmWJChv8Zms6q+yBVG955xM7Re+9Ud8d/1TDcmzMXns9mpPvnQfYGGaAkqiVItV5Mts
 m8PSq49eRmn2CX4Q2wLXwo3YZTvsYKlaPVu8cn8dz51PPlpiBuCKcb+QQAx31Q5L4rVKur1MsOR
 Y6I+IzQ4Zx/IXatnN7l6xHmUJqgj6a56pQIZPI8MSpTR1L7rgQiHsJWJeKxX04knizYbhOiRWbG
 hBeQoufbU8tJ1zdiASjEob7ixfeoHfvMogy7k+b5n2/Tt1reYdFIBjjd0i92uVgZW0R/rbd079d
 xDbA1WJNpOjVi2GYEda738akGWSEnoDMieZtt+XVpy7NSzaw==
X-Received: by 2002:ac5:c9bb:0:b0:56c:f222:7d7e with SMTP id
 71dfb90a1353d-573a56d9161mr441364e0c.10.1777362850380; 
 Tue, 28 Apr 2026 00:54:10 -0700 (PDT)
X-Received: by 2002:ac5:c9bb:0:b0:56c:f222:7d7e with SMTP id
 71dfb90a1353d-573a56d9161mr441349e0c.10.1777362849827; 
 Tue, 28 Apr 2026 00:54:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f31f2fesm5123161fa.12.2026.04.28.00.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:54:08 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:54:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: William Bright <william.bright@imd-tec.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Add TSD TST070WSBE-196C 7" DSI panel driver
Message-ID: <wy5rqmwe5fwd3vneplwojuaavwdxi22cjgj4ytiiyufszgv7re@h75gdudgtwli>
References: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
 <20260427-imdt-dsi-display-v1-2-bb2768de120b@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-imdt-dsi-display-v1-2-bb2768de120b@imd-tec.com>
X-Proofpoint-ORIG-GUID: ZG6uWEInhC5OZPA6f5wsDHXgdBl3aRLC
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69f067a4 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=xWt6wN_oAAAA:20 a=gNcS5RXMAAAA:8 a=z5WFC0DZfZEC-hT1myoA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22 a=VeqYHxXNbGx7SVBbL1V1:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: ZG6uWEInhC5OZPA6f5wsDHXgdBl3aRLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX4elHubgPTZr9
 X3VpUQe6sxEbj306Ad1XmO3tfKp2gS99ouOfkJ/cizAx+j+K1bDjDYoYs1PgptmgIK/hQUnBh5E
 rdGvFC8Na1PRC9cCgDqZihhf4JURwncXstqoS/r6qNdLkczNFe5yT7vQ827Ll2EeC6CNvq2z7Z3
 RLtSvyvOg0KPio8HHVugeWL+/iVnGiPsCb0IUI8USQ7CtCkC4VpNDDk00XyBOpmr/swcrmZx2c4
 DY1zxbJk/I7pMoZu77IXg/7hpXzNxwAqcMk5ktFRhtanr3pSL51Bqay1Helk4W6MWQUpWa/LgD6
 tsJTb+3ZozRKG27pxXMTCYWxpDVB1ViSdVygvjNs8YZys+w2tfBRrS43sSNcEs3uuqbaVxS7TzC
 CjEYf+627483UTmS8vgGqkvF4WPMqX8x9iVxpNtz0eUMeGI1yaS722FZuBL+dfre3UBC5yKzEsl
 4laGK9rEPD+aRT/Nl9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280071
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

On Mon, Apr 27, 2026 at 04:21:10PM +0100, William Bright wrote:
> Add a dedicated panel driver for the TSD TST070WSBE-196C, a 7" 1024x600
> MIPI-DSI TFT LCD panel using an EK79007AD controller.
> 
> The driver supports power supply control, reset and enable GPIOs, and
> the backlight framework.
> 
> The initial driver was built mostly using
> "linux-mdss-dsi-panel-driver-generator" [1], reading the downstream
> file "dsi-panel-imdt-tst070wsbe165c-video.dtsi" [2].
> 
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
> [2] https://raw.githubusercontent.com/imd-tec/meta-imdt-qcom/refs/heads/kirkstone/recipes-display/displaydevicetree/displaydevicetree/0001-Initial-bringup-of-IMDT-Display-3.patch
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>  MAINTAINERS                                       |   6 +
>  drivers/gpu/drm/panel/Kconfig                     |   9 ++
>  drivers/gpu/drm/panel/Makefile                    |   1 +
>  drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c | 168 ++++++++++++++++++++++

As there seem to be no DSI programming going on, could it instead go to
the panel-simple.c?

>  4 files changed, 184 insertions(+)
> 

-- 
With best wishes
Dmitry
