Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE708F589AF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0595810E0B9;
	Thu, 23 Apr 2026 12:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxiwEAdX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K184tJFl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0171C10E0B9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:33:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uIBK3413367
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9yhHTik6+YYXDB6sgNYl9ejb
 E8BXg1+1GNN5kDTieNM=; b=NxiwEAdXy4FBw15uLotHzVnoyHT8vzjzV1LTdJ4E
 H87ecaF2BTTtGLGiGJyiekNsU0sTXec6eIY4OAcSyiLtUhQxE0QdQXTUnKLp/QHA
 tK/RJadSF1ZSSgzmvbiusS2EUHjSuYizACJsJzNl/t8/gyo0sx+noaM06kyPpzLw
 IQxnj0TNUI98PrjVtBUV3a1lURwI7lfzCzb+VpprrMDYUs7BBxX2EqSWVIuHapEi
 agPIxgkxYJ305GG52TUUtR6EZp9/SuOzeNgsTLXZOsIPnlEpZQx3JC4USbxOyEbR
 3kerizFvi1skn8ncIS00NdDyAZ/MnjkVhqiPE+EdUg1nmQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h6bxsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:33:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35da4795b3cso12473875a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 05:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776947613; cv=none;
 d=google.com; s=arc-20240605;
 b=dgA+c2QVTRgQ3pEXM7ie2GO55j1rqnPSPS3FxPrkzUe1BW0iDKFUtBkJb7mU+Zseei
 I3Bs0mQ9QlrTv1RhycomJUCJ5Svn7VUizjFxmlNYSjWfmQtTsTPOER1qEC20aySkjYhS
 NvIL2x27Fl5wuHr9ErMHkSDNjqoNzCnoCkd54n1+73S0DeIp4uZhnG5IHDDRPuGRrqOr
 gRGZNU6FX/ZPBhW+70DT8lv4Du/2xpTreBfFJ/5ZSESqH6VubfhPQ33LxdlQ1V/Xah59
 jyufyAfnXNRsbT6NSdTRMIqS1m1Ya9Ct3BHcNaCOF+8e9eX77cSHCW9mZDj5+gb7VZw8
 F1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9yhHTik6+YYXDB6sgNYl9ejbE8BXg1+1GNN5kDTieNM=;
 fh=n8xQmACLoretud1pZ0Cefg/oZev1QP7HU9yT3AknGB4=;
 b=NcALqlo4tkhp+pZl32Md5leTQi7prDQ6Hpk+e2URrQUKOAXLdlkwWLujrEcDr8qU0i
 L0mZafJtagf7R1iATwPOPY2mexxvCdVnin/zDqklTLBR4nvPAJ/6XjT+lsl41ORzJzIo
 0LD7W4VkN8WOxaY0rAnxUJa4N+0gBXkqYm7o2BB0fFJf5xp/cNLgkLPXG6ju4yae2Rvw
 xvlMnmwg4dnc+mlugV+BxVz3hl9JnpDatz/8e3bYlfH07nsvgtCCKA/nBIdDWaDK1vu7
 xWEEPrbRsg8a0VeQuXS53O3Q7vc034EW3kEfFt9Rz3J/ANsICEaA9c8vVeVI7PJJ3uAw
 BNaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776947613; x=1777552413;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9yhHTik6+YYXDB6sgNYl9ejbE8BXg1+1GNN5kDTieNM=;
 b=K184tJFl7Tu0h20xrrjnKXJre658sWpxFJmNkE815YhVeue4nmUS5mILL5MfSnzti6
 RAO/+/BvtCqUaWy84CfxlzlCNuhRIujX/FACFi7lMFHwTskDelIOStxdCgc7hVJAzdH4
 cJqnrDkQR3wErStzwr9oadyF1UYdRSzLkCjrkacSyxpE3Zz1xQj43qxsMsGzFl5EfRy7
 DDh8AIyTfwUaf2/iRficDqtNggF1zO0ndNTBKYsdy7QHZ4U4QKIcM4/ElAOYVlw8CG4h
 lrIYrS3wQBtMaZ1zRaD8pLjFs7dNQGRg5VM6n526W0ZKZa1M63WjrIVvWCRib3aqo6zr
 UMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776947613; x=1777552413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yhHTik6+YYXDB6sgNYl9ejbE8BXg1+1GNN5kDTieNM=;
 b=bcHyrEB4wIseJ377i9N8AxkRzY/WcGGwSxcAV+370bxkCL0pTRDMSBqNRjc5DwcieN
 XUkvliE7r8FM+RQRL2R0QoDkyJMFouBzA+kfeJ265ytJGzn2j/mfl6eRRot9kW/WaSLU
 RY/lp94PtfPeaVJitFghIHCDS2PoL9woPRBdsCMRXi53WcZtseyherYBy/Eo1RtCA1Hi
 FG86Il3eAV/qN2HRb2dQ0+2QU0gOuKvfkqySOaEVfFFPuC6R36DKRc75mvEGt4ZXIuSi
 SH6AO+8d6I+OZkxKpYKQ0dAgKcqtkha16Hoymoy8Oy5vG+kA3NDwMaVkY/13ZNcLFuQE
 zdMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rk3DQVo7/KbMCWzMQHZqak22mV7gtMMNN6B2eRgNVAP5IeAaeDT1xLB49ejqVnEBmRFtIKoezhwg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNmUjks1LG8gvruFgK7p4emOokvOQ2K3vcR/6MDIGjB7oEUkPC
 saifYWwSNMiS5DccqkW/QfrFt1lLxosrGf2gkDxsLjA5x3U+tBv2B37UWtbIl4t3tANYbM6EtKf
 8GKc+4dHsx8dAinKTNI8xwvKHCcfBVvtb9Lib+eTQYBkpT+ErBAU1pYkG++RdpcCYl3F4+7EYa8
 1WNoDtSugLS+wWESY6HdEoy3y+gNLQ0YdM2c/hIQszVJgZKw==
X-Gm-Gg: AeBDievgN1BkJspASkCUjvP9yaVEGOfXmGOF1oc3uv964tJcQ/vqoxdpi0XmpC153Nl
 GDOKBws7sbKdDinVV8K0RgJ3A+tAU98PpiNDByMjayUdZsvQgTnarH6AH16iY3RudhO2OPx8jcs
 ehqfdL8JoBqtLyoUjHixIVcdp5AdvP7+IEDIYuqxsikiltHMiO4bGCvtXqFZpu2XN2NiVzpdSzN
 ReibcbU/dGtlvSwtw==
X-Received: by 2002:a17:90b:3c48:b0:35f:9ab2:a5c2 with SMTP id
 98e67ed59e1d1-361403af9b9mr27480058a91.6.1776947612606; 
 Thu, 23 Apr 2026 05:33:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:35f:9ab2:a5c2 with SMTP id
 98e67ed59e1d1-361403af9b9mr27480023a91.6.1776947612081; Thu, 23 Apr 2026
 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
 <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
 <20260423-kickass-fat-boa-209f68@houat>
 <72c2cd94-0a8b-46c8-981b-4ad4a3222e59@ideasonboard.com>
In-Reply-To: <72c2cd94-0a8b-46c8-981b-4ad4a3222e59@ideasonboard.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 15:33:19 +0300
X-Gm-Features: AQROBzA9yKElJlZSZfMBUf0k2tDmMegns4UIL-mhm0IaKhZ3T9zYgupeAQGkFWw
Message-ID: <CAO9ioeVX6OChRTgUrUdgrPF+3s2_7vme7m0yb85pjYtH1MFskw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69ea119d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=RF00TdSWAAAA:8 a=P1BnusSwAAAA:8
 a=m3ymF6_MsKiAG3528zsA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=_nx8FpPT0le-2JWwMI5O:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNCBTYWx0ZWRfX6MwCLNviZv3U
 s/JVYL+teBT4eWrnBwj57GDbuiGB5+vcqcOGR8qZxzRU6aXJJNs6JaplmMVqVRKRuXzcUx50nbN
 ddQCeQvEZbArxdEZZgKqkN98JgcP6BjtPClrr5/1aX5/imNBUgQeOvq+4Ru6haYoOjjJn1IoLvO
 J1YWwRMAP0cCW80J/4Bb7dNUBWdrr2AaJoRl2p41lLT0Kljycsj18xLMUQ+cQlKXPO1w6KXthTN
 DRrKBH3orjZlzEQn7dbUWSdMQBuH5Z7+/yP5QPrtv/P6RdZmXjKy/2IPOF8VwXL/gcM5OiR+PsM
 sR5kifEmLDjTdkwWolrQ2WAu3ZnTDJBZqXp25PBsyMslcMjdOjJROnaAu3qUnolI5ud8MCr+hEU
 hzGgymFY4ku5fT7vaZhobw/h5luqLLtp398AFUq5SOur2geEKwEXTwBEbSjFH+GbnN3z/fcoTt9
 +31JMexOOjdmOX7oElg==
X-Proofpoint-GUID: 1-1iRLL9_gcOKeHOBTu25kY6H3xz7pmR
X-Proofpoint-ORIG-GUID: 1-1iRLL9_gcOKeHOBTu25kY6H3xz7pmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230124
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

On Thu, 23 Apr 2026 at 15:28, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 23/04/2026 15:14, Maxime Ripard wrote:
> > Hi,
> >
> > On Thu, Apr 23, 2026 at 03:01:51PM +0300, Tomi Valkeinen wrote:
> >> On 22/04/2026 22:22, Dmitry Baryshkov wrote:
> >>> On Mon, Apr 20, 2026 at 04:13:36PM +0300, Tomi Valkeinen wrote:
> >>>> Add timings for the panel used in Raspberry Pi 7" DSI Display module:
> >>>> https://www.raspberrypi.com/products/raspberry-pi-touch-display/
> >>>>
> >>>> This has been tested with version v1.1 of the display module.
> >>>>
> >>>> The panel is very strict about the back-porch values, they must be
> >>>> exactly 46 for hbp and 23 for vbp. Other timings can be defined quite
> >>>> freely.
> >>>>
> >>>> The panel is exclusive to Raspberry Pi, and different versions of the
> >>>> display module can have panels from different vendors which are fully
> >>>> compatible. Also, as the panel vendors are not public, the compatible
> >>>> string used is "raspberrypi,7inch-dsi".
> >>>>
> >>>> Note that while the display module has a DSI connector, and the
> >>>> compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the panel
> >>>> itself is a parallel video panel. The display module (as of v1.1) uses
> >>>> TC358762 DSI-to-DPI bridge to do the conversion.
> >>>>
> >>>> We could use DRM_MODE_CONNECTOR_DSI here, which would have the benefit
> >>>> of showing a "DSI-1" connector to the userspace. However, the panel IS a
> >>>> DPI panel, and gets its input from a DSI-to-DPI bridge, and the
> >>>> panel-simple.c behaves differently depending on the connector type used,
> >>>> so, DRM_MODE_CONNECTOR_DPI it is.
> >>>>
> >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >>>> ---
> >>>>    drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
> >>>>    1 file changed, 32 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> >>>> index 91ab280869ba..e75eb20301f2 100644
> >>>> --- a/drivers/gpu/drm/panel/panel-simple.c
> >>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
> >>>> @@ -4208,6 +4208,35 @@ static const struct panel_desc rocktech_rk043fn48h = {
> >>>>            .connector_type = DRM_MODE_CONNECTOR_DPI,
> >>>>    };
> >>>> +static const struct display_timing raspberrypi_7inch_timing = {
> >>>> +  .pixelclock = { 10000000, 30000000, 50000000 },
> >>>> +  .hactive = { 800, 800, 800 },
> >>>> +  .hfront_porch = { 16, 72, 354 },
> >>>> +  .hsync_len = { 1, 32, 40 },
> >>>> +  .hback_porch = { 46, 46, 46 },
> >>>> +  .vactive = { 480, 480, 480 },
> >>>> +  .vfront_porch = { 7, 21, 147 },
> >>>> +  .vsync_len = { 1, 2, 20 },
> >>>> +  .vback_porch = { 23, 23, 23 },
> >>>> +  .flags = DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
> >>>> +  /* Note: the rest of the flags are defined below in bus_flags */
> >>>> +};
> >>>
> >>> This looks pretty close to powertip panels that have been used before
> >>> hand in those modules. Are you sure that powertip,ph800480t013-idf02
> >>> or powertip,ph800480t032-zhc19 don't work for you?
> >>
> >> I haven't tested those, but the hbp and vbp do not seem to be the same. For
> >> me, they had to be exactly as they are here. This was also confirmed from
> >> Raspberry Pi, the panel datasheet had min/typ/max values (i.e. not ranges)
> >> of 46 and 23 for back porches.
> >>
> >> Where did the information come from that powertip,ph800480t013-idf02 or
> >> powertip,ph800480t032-zhc19 are used in the display modules? Or did you mean
> >> that while those models are not used in the Raspberry display module, people
> >> have used them successfully?

For the zhc19 it's a wild guess, but for the idf02 it more of a certainity:

commit d69de69f2be105b2474c05a5ca4827aac3e80ad3
Author: Marek Vasut <marex@denx.de>
Date:   Tue Jul 28 14:12:46 2020 +0200

    drm/panel: simple: Add Powertip PH800480T013 panel

    Add support for Powertip PH800480T013 800x480 parallel LCD, this
    one is used in the Raspberry Pi 7" touchscreen display unit.

In the past I used this panel compat instead of the
panel-raspberrypi-touchscreen.c and it worked.
IIRC Marek splitted the multi-function module into a regulator and the
panel description.

> > It also looks like we have panel-raspberrypi-touchscreen.c and raspberrypi,dsi-7inch in
> > panel-ilitek-ili9881c.c.
> >
> > There's clearly more than one "7-inch rpi panel" so clarifying how it
> > compares to the other two drivers would help.
> Indeed, it's confusing. I'm a bit new to this so I don't know all the
> details. From Dave's mail to me about panel-ilitek-ili9881c.c:

-- 
With best wishes
Dmitry
