Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E678606A880
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFHZ8li5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QH1z+yse
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33C510E332;
	Wed, 11 Nov 2026 12:37:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8495710E332
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:37:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZHLG2338579
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=j7Eov7QCrd5XGLBKc9xY69NQ
 W70wVEQfOB1xyPudY0M=; b=YFHZ8li5L4X9140/AZUrRCb8X38ZctH0/QEhSMvb
 7ODW3rWz/hQ/Km2Q4gsTNJ7uW09FggFfhpmYZiOP74/jEgDG7+sbYk9Ryp8CleEj
 O4hehlMqkEs8irOFwd8egTprRksuaWKMIA0T3Cf4x1izcl4zpPPaDKhauHG2lxbu
 opDD9nQtEIHel1L5PsM92NBt+Fitt/2aZ5msIfevKiZoUFVbOvRZL8WSzz2HQgTY
 4+qgE+TTY1ESp1wwL8qAF6L+GverVjB8WBxTZJyZvog5u4fgvfxdJSqBVfdOs5Vw
 eTzBwhzaHrWyg2w6Xpq08VyEDHRT52LXsjOPipJ20KKRDg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmakpg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:37:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91f01e99265so19629606d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794400660; x=1795005460;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j7Eov7QCrd5XGLBKc9xY69NQW70wVEQfOB1xyPudY0M=;
 b=QH1z+ysedLIcNcu48j9AJnVxeUIiMCR1DwmHqD0g4sCUAgXTIwgjXaBHBWk2o860Qu
 4cSX10kwraNmZg3Lieu0SxuezvJGF8VcOGPk47ht6sC4P14BgCsH/zx7tuecWHkv6tnR
 Isx5uIgBOpCICdqeZiQzs6ztT7FwNSDPi1lmQHLf2uVKh0NJt+aMeZxsrzSP03Imy7vu
 Fi2rpCKQ/cdUDCKJYeZU+eQEFcUSHOx+IukeK6x9tdnx5s7KFLwrWvaQ30CI1kZS6XKK
 g8LG5LMASjRhivQgOa3/CDlnSepORNBWqxCNgqArc0DXd1JyVFW8itQRFPnAlPxhxvHA
 ZD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794400660; x=1795005460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j7Eov7QCrd5XGLBKc9xY69NQW70wVEQfOB1xyPudY0M=;
 b=rJkXbXVcPPtutwR3tQVGyuPBRHeDGI9SlqvRPYl5Z7ysEw72DZjqj/FgmoWFyVwkKB
 EdYiHt/pexIl0Rz+yt4JfTk+BI0Sst70QtIN1ZJoJ6qeiQxxBv9qScz3eioT5Iz8pkin
 13MH5y6EQH5akozi0qJj1/qzckTxPl7MxwAsuTH8h5KVfiTK9VcXATi9oWeAYOuVXvSm
 34o9vRcUzXSOxqQ2wL1I8wxvs5z/AcdgC/hHLilaplQGvYjvpKEFskJBPaId1fVXiM/j
 OiGTtE9KE2y6YaEL2jP/ZU2J1lYoh1InyCKPCAksOiOtM343069grFjn2/YaiBA8c4lq
 t7rA==
X-Forwarded-Encrypted: i=1;
 AL+hErHHlnEcpEnmTIBZNrJyFIIRHyJuIp48Cz0QRUWFYKcuTeQWZVFM1suD+I9oKyNphK2cM+Q3lZCnmlU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Ox8uaNX+53lmXQx9AX6cDV2mpxZgCPSAlVhtRi9oNpVM1Gob7
 7aV8eK2pQbXB+lCawFsHihTCaXE4AXYG8u3pyDIyLIo1xOz/yRcYKXj93+YEX+Yt8CC6ooV11pj
 rS1R259/aML07cyfpTm1IHaPKvjhp5Yo1fLzj7kIvqwNVzChlXMVhFxWCXiBI/PjiBLHXaHI=
X-Gm-Gg: AYBFou0KuLf+OC1PhzRODmM5kTeWYVELPsSmzvX2AcUHRHL0UH4dIVJSrtBLLrhPT2X
 +bwCRC/J2pEUWLR9sIlEW74ouyhxVyRKHCYAub6mP9lCRfJIsdmJLEm4QmkZk/AdsNq9gt2JeIu
 d+MJxnGV9EiUAKhdMSX/K97hDKTZGVx6r8DfcOQ2AWDn0eX5NLSZGWYlI5TfaeJLHJhrb0TTt3s
 LYh+SDDHhAJRJhdOP0NSdx2JYWONCX3dbnPUwF9a1UgCafezIUe982Ce/ojDyFte3VbBcrVkAWP
 5kjD6mpywv5fEGlQIZlw5bDSNrU1RnhpigAdYV004gAoGIRD1PONPtT83HN1aJY3j78Ffo6Ez9m
 c6VwJeF9WfgmZN5lH0pCVM2BUTqPMo94tVr6G1lv9rEBZt0d9wDKVvipehm05x8oLLv2v2uxfRQ
 Wyjrynhf69tg6kTJm/mO1DVUzBdxh215hKZB04mo0wta3xEEgzZDt/ayxOg4ZKiQ==
X-Received: by 2002:a05:6214:20eb:b0:91c:63a1:1432 with SMTP id
 6a1803df08f44-91f03e0068dmr39814956d6.6.1794400659392; 
 Wed, 11 Nov 2026 04:37:39 -0800 (PST)
X-Received: by 2002:a05:6214:20eb:b0:91c:63a1:1432 with SMTP id
 6a1803df08f44-91f03e0068dmr39814136d6.6.1794400658706; 
 Wed, 11 Nov 2026 04:37:38 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae0928bd0asm10461021fa.36.2026.11.11.04.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:37:37 -0800 (PST)
Date: Wed, 11 Nov 2026 14:37:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 Michael Walle <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Jens Reidel <adrian@travitia.xyz>,
 Michael Srba <Michael.Srba@seznam.cz>, Shawn Guo <shawn.guo@linaro.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
Message-ID: <oubzclitudtqiv64wvg5lvxvbhuffxmc5bgbsdz4ou24pfhbb4@decarhvjzl2a>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
 <avRM_GhtR8vMdTO4@houat>
 <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
 <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4WGH0QvUPBNnMjGm_QFhBGgENC-9tag_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX0MOBTrYAtV3I
 n9nhv9rTqwgHU2HQk7rlhY3VJm+yfbZB9NcUd+xSGzVaVO+fRbFMxeOgb3ooFRAnKuxWH1a8Pn2
 ehotaav/AZP7TYj2Nn7H/Ktkj0CD9i4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX7webZueYrcF1
 Zrkk3mgsOBs0G7+toAmdY3ji3xw4D/JT4sYPmYzXheM4iHS7qJWnAfe9rVL1B9QFE+tzU70SeVa
 DersKsVvDwGaU+Vrm9yymryrnZw5XzByXUFDCypU7ilkXJZ/qHJB+hNXFfXJ6DAqF8iAqwceNg9
 U4t9WGSXjWfh+rTra72SLF5PHvzytX7DJR/TjY650OwO42A/MPQzV8CCi561wo9W8bOHbvltRot
 JDNliHzq0ZZlcfbAZg9pb6miErZ6fsPfzG/97aJPWGgpUPYRa/oCamzomVeGn/fUDyJMgC+8CRt
 tMEVFY1Vu+403JgbA3Tyc6YdtGfwDbppjp1W4u0h80s80uu5A6XuRnAmQZrYba2XSrHfgl8DyU1
 CH4EHeDTZgu4RXFwoeQSbXF0QFpAeM3namFBcS2fFr5gMAsI7pNIe5ya7OofsC435eobK98As0v
 1iE3SqIk5Y+1eucch+w==
X-Proofpoint-GUID: 4WGH0QvUPBNnMjGm_QFhBGgENC-9tag_
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af46194 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=1dMmzAFpFYDdDQwHOzYA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 01:31:39PM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2026 13:30, Krzysztof Kozlowski wrote:
> > On 11/11/2026 12:13, Maxime Ripard wrote:
> >> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
> >>> DSI panels can be placed under DSI bus directly and many Linux DRM
> >>> drivers will work fine with it: mipi_dsi_host_register() adds device for
> >>> such panel and DRM driver does not use OF graph to configure lanes.
> >>
> >> That's not true. We do use the endpoints to configure the lanes through
> >> the data-lanes property. See drm_of_get_data_lanes*
> > 
> > Some drivers use endpoints, some not. As discussed on other thread,
> > there are more than which do not.
> 
> "there are more than one which do not."

Which means that those should be fixed. We have legacy cases where the
drivers assumed that, but we should not target legacy.

> 
> > 
> >>
> >>> The affected here Linux panel drivers do not use OF graph, either.
> >>>
> >>> Requiring graph port for such panels is tying the binding to one
> >>> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
> >>> requires the port.  The port is not needed for the hardware to operate
> >>> and for some of the Linux drivers, so it should be optional.
> >>>
> >>> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >>
> >> DSI busses can handle multiple devices, and multiple data types. If we
> >> were to drop the port node, how does the upstream video device know
> >> which device it should send its video output to?
> >>
> > 
> > We do not drop the port node, who suggested that?
> > 
> > You do get, that we are not talking about the DSI host, but the panel?

The panel might be driven by the host directly or there can be other
chips on the bus (someboby has been asking about the retimer or
something else sitting on the DSI bus between the host and the panel).

-- 
With best wishes
Dmitry
