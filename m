Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDB0F364C1
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C3810E0AD;
	Thu,  9 Apr 2026 21:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOA4YSqW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eWKJEQxb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FF610E045
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:36:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639L9ERe1730291
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TkJRO6Oo2pp+w//8GQnSgMgSzv0FXnFgaEUwgsNX1S4=; b=kOA4YSqWunwDnBf7
 PZEsJ4gRm6TFadnMermJIbJp9qe4l0tJMan+tjJ7C5KdmtduGZQzJjQJHHjaxNeZ
 o8qFJAwB9GlGMdjgGzNoVI0Uz1OLAPUFl2pChxXveCHHZiwuvliq3Oivjx1iTD/y
 Lyw1/v8ADl3BsfOHtd+bV2SlJc0UznsdZP2ySJfeiRCgF/8csU0oAuFVDflZrvTB
 XkTi7O2EM6L1ifqceIEVmZTK2f7P2BzGWaK/JlJDF1+NkjxpzJ+6E055M/Br2KET
 i1Yy3fwJNRpt8GS2EwNDYxGYwLJS0dn6PfBgk2D/Bo6BETBfnqmvVVJCShGiG9B2
 7HR0IA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxhrg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:36:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b274f94f8so30026951cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775770574; x=1776375374;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TkJRO6Oo2pp+w//8GQnSgMgSzv0FXnFgaEUwgsNX1S4=;
 b=eWKJEQxbRjxzYO/EdWqQFtChyWf+jD8Kutq9xsOapjA2lTowuWFK++lL66mDwKRe4y
 030PrrRO6O7tn/tm7UsFra23MP0Q59ISIObAfJOoBMQhtXwraOKhjX/pRvEWRdcT97hN
 hT+vV/borv8XPjpyiGtd+Va+LoK4UbpFtHt/7EJgVOjC0RqQ4WjsELI2F2FQhJuF8Q3K
 5+xFqz/QJ1NS9eqTfq1D0KiUj4PBcsuGFybJYhIAaPxucu4+0hn5RLiqUjG6zinBq0dn
 uB7LfQaRRu9HuqXP22QLQdi01ewJ+rYAci5/Q8B+cjYcoP6y9TBz5oqB74WKlSTl/Jp1
 Av2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775770574; x=1776375374;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TkJRO6Oo2pp+w//8GQnSgMgSzv0FXnFgaEUwgsNX1S4=;
 b=nN2/obMoMv5tKhC+Hq/BbYUSJBzLg1SWDuFy549XObYr9gvPyLXIrPR4rp31mAFX8/
 qsbZKeKrPncm9KC72ME14BQTHtgvjdJUPzjd2/JhqPNWCukveGmtw+XOyydRpnOjKyei
 aM26QLMveYwqh90vQq4N4EyWi9Cr+F+awmLJPRbtiqF2RF1/t22ZxzMP85HoB18utlpg
 Z+33W7sczIKzgZOMQzI5Bq4m68uqQitYEGKvMwWs5ACYR06fHuvN5C4on3YCUeptzHqL
 gOBeu3INfFlioQurvE//eHqknFNKhvP4i3pZZy/BOlFXACXJ11Sa+nDDsTcbm2dUIkZd
 3B2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8gDwceW2gFLrGICMsV0p0ZlWOoqxhfLCIYQ989SyWHGxoPjBwgAWY6AXJgkN3D5X2wt4vO5k4ISs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDla8cEbt87FkpW+GM/RBTc90hNmXeafTFODEDexO4HC77SpAl
 CcSH0IbBLoHe61eCKZS1AVCxmLMfSUQoY+ArO5f+OGXmHI301GC1P26upugCVdFuPUKIrnBer/7
 TO4mcNPXeSnCS5TJLYRANO+9s2Dofxh/pk3420l/lZG9zgHWica7nvZRjJ+4bOjJlFNUIe9Y=
X-Gm-Gg: AeBDietK1Vrv1fGhJC8iWOUsKTPMGqovKgbxgyzZeth4Yqr4lkJCFkLI2uY3GZrbr2h
 fFGqJ3u2VC9q3qZIJeDGu+Tzt5cJTRmwEYjiaX8csmRS4kF9JZwuHqYEMwNLl9AMzs+tvdI+5IJ
 +15Qt83klWo5VAwYjRkN4REIKCk+2NLzyqQVUUzAypO40BWSXXQs/8CMychjDdZa9JW/TcWwtr5
 PY8gqIouD3faoBNlrZGwOTsnQIpC8FLKAl5b0y7aKQLRTIsgChHTAYvM5AoGeyd3gMeMOb7++Br
 g2mfWs8nY1Z5BTfCojbfe9SOvPJj02zsMMkWtaFpwlOo5/hyvhE/x2Bu1mMfRjEgQRSnTgJngas
 RzLuGxVifAGLslczICvKM9Xvs5zz0tbY5h5wFJaKbIVvn+trvBriv27sXOYj1UiwdMCT5O3xVp1
 zwdTJerf/QQvlTJsiv5/JCymTvhPCYAi9wQYU=
X-Received: by 2002:a05:622a:8305:b0:4ed:70d7:aa5a with SMTP id
 d75a77b69052e-50dc1acdc38mr55450991cf.25.1775770574001; 
 Thu, 09 Apr 2026 14:36:14 -0700 (PDT)
X-Received: by 2002:a05:622a:8305:b0:4ed:70d7:aa5a with SMTP id
 d75a77b69052e-50dc1acdc38mr55450611cf.25.1775770573510; 
 Thu, 09 Apr 2026 14:36:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee86784sm174147e87.8.2026.04.09.14.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 14:36:12 -0700 (PDT)
Date: Fri, 10 Apr 2026 00:36:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH RFC 00/12] Add support for DisplayPort link training
 information report
Message-ID: <u4ononk4cpccx77gvlywtfen5rmyslvr72v7olkhdrjf65aqce@xo777vofhcan>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <adgNxaFhbQaxC5E_@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adgNxaFhbQaxC5E_@intel.com>
X-Proofpoint-ORIG-GUID: Y9c9hjHUAoliZhjywkcp32oqouT6tEYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5OSBTYWx0ZWRfX4Gr71BlF8rZ2
 6TauWY6QGpbxA6XOC8yxg8Y5/0ysOw7jL2QXaNUL/qvPppDAaLcV7nLqIFG6o/m1AstBwWQflyz
 5c7rME9peh7yepxL36PpIaSvllHMKN5BKdoq3ILl7NI98jGgG76B7s4IwGa7EIJifsr5+KvjucX
 WujxsmCr41AOz879LqPMx52/YiI95uDX5GsijzlGX9VRB08czW5SssqlEFG0asQj7WZ6vCUANnN
 g3k6fRAGc45M4PKP2+7kVD8JxyotVwGznLH0WQIm7PNYR99wGGN9FrZuKVWVT17TkphSzGnOJgn
 ErkeXevOFFlAze3IFnXtWmVsIgvuyRp8legrNUNChroDdlshSrbE6l0ZuSbYHjA5IhQ3PO2ZbqB
 3psH4RBsb3gU+8G+Bqzo2mZGK02HFd3RM6bmTP471NSo/Vv6qH251a6EIvnRpJPYKeXEojuziH6
 ork+Odt/jIC/5KFXpzQ==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d81bcf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=F7xsp-YMIWaRqylmYmQA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Y9c9hjHUAoliZhjywkcp32oqouT6tEYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090199
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

On Thu, Apr 09, 2026 at 11:36:21PM +0300, Ville Syrjälä wrote:
> On Thu, Apr 09, 2026 at 07:08:16PM +0200, Kory Maincent wrote:
> > DisplayPort link training negotiates the physical-layer parameters needed
> > for a reliable connection: lane count, link rate, voltage swing,
> > pre-emphasis, and optionally Display Stream Compression (DSC). Currently,
> > each driver exposes this state in its own way, often through
> > driver-specific debugfs entries, with no standard interface for userspace
> > diagnostic and monitoring tools.
> > 
> > This series introduces a generic, DRM-managed framework for exposing DP
> > link training state as standard connector properties, modeled after the
> > existing HDMI helper drmm_connector_hdmi_init().
> > 
> > The new drmm_connector_dp_init() helper initializes a DP connector and
> > registers the following connector properties to expose the negotiated link
> > state to userspace:
> > 
> > - num_lanes:      negotiated lane count (1, 2 or 4)
> > - link_rate:      negotiated link rate
> > - dsc_en:         whether Display Stream Compression is active
> > - voltage_swingN: per-lane voltage swing level (lanes 0-3)
> > - pre_emphasisN:  per-lane pre-emphasis level (lanes 0-3)
> 
> I don't see why any real userspace would be interested in those (apart
> from maybe DSC). If this is just for diagnostics and whatnot then I
> think sysfs/debugfs could be a better fit.

I'd agree here. Please consider implementing it as a debugfs interface,
possibly reusing the Intel's format.

-- 
With best wishes
Dmitry
