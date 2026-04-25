Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD7CFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B34910E1B9;
	Sat, 25 Apr 2026 21:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCc64IYQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gTJnQCtI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F1F10E1B9
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:45:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PGNHWB2935649
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f7RZGJSN3+WAdtDl5rsnVh3J53kF5urGcCMS3HU8Vss=; b=HCc64IYQood0E5bQ
 AlFPx6OvkHkwa+Zof3Wz+yWMy1ecMhIpTttSv863tnJO2Db2vapgafoxrbmZjuUZ
 cwdDVCrC/Frfl93m9h4MUzmOfwvZC2qJTx6ym8tsyHw0/6C7yw8cTVlPL5bbfDc6
 vkzmdJgS0n7UaX7uYhdzTQ+szOdQ5oK/llQzHTIwzKZTv0ZgSOhNY7mp2OL1g1fg
 rTJ1U9wQVHHhZMh0SpHMwKBaeAy19RzUr3Y/5tT/TVwnxFcvLkmeXDU2sgOJxWh5
 IIjHZuSc5Msh9NOQkUH/T7Eed7QhvkYImpDZn7jyf2y5DRz7W3XOrK9QpNu2Yx+Y
 CKaa3g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drp07hqdt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:45:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50edf01172bso165981041cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777153503; x=1777758303;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f7RZGJSN3+WAdtDl5rsnVh3J53kF5urGcCMS3HU8Vss=;
 b=gTJnQCtIsPZZkIpbd/tpXJwy9S4/smU2kQlANUzEWd6Pp5pvFkcQDqFCyohrObG1Oq
 1kp23nfHs/6CW3i0DZSixzs7DBZ9nZdgkWuM5uMr/IRGIiNUT3lQ41vibSqRHpP8HxmH
 +mKlnqdXcR3sR42peEGSB4yFWtuHmksFitioiqY8YRA8zV94MHUH5dv7YewHA5WQz8l9
 Td9SePcrm9AqcBiAez4YS7i+TIb7SXTZ/u1PiSW1Mw/m6tfOgLgGXxWV3Bl++Naxycn2
 c76OObmO9EMDB6eIAvrAAk16vFwbQBFHPOod9AjRYAMPR3ufFgC/xrC7K5zi8bdExWyA
 Ozww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777153503; x=1777758303;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7RZGJSN3+WAdtDl5rsnVh3J53kF5urGcCMS3HU8Vss=;
 b=r/ty080fyRR4CfXyUJxvBqF0eikF8GyjZPy/xeph4kQ0+44M6oxO1wbOfyKcy1VGFv
 e8DffQuR4mCEdYtThWnBUHJjT93UwYLb4YkzVj5mVvBADvguFY3u8UCdvCatlA+ZZe1B
 72PBsaCmKKegTUOcNWb6ouPH7XTz89kZ3GpofnZh9v8amIUSB1sj4E9RCdOME/2+nb/1
 3NTNWNHh8NJ5NZjKNd7kqmvUfO8ikw9SN8EEhGMQDRVEUIcS3g9pa0vfMJjHE88H3SxG
 3a/lwwXlvdu/EJcqfv4h3F6wyW9ADfnIBkIhivpdKLsMS9GEdy8+6B6Zfy9H82mk1wGn
 F0PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ96MsFVPanN2eSCYrn0p5xaVgnmW4Mqu0BOWh8gqXGmzAvtKvNb52mPZDGtQBmqzKyjv/szfjmjFes=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweVjnAfPwdMLZ0r2SRC09Z2Z9FuEESpVX32CWrsKLvOFjv9ThR
 nZwGxEFGPjbhPLJuzbe2yUxDZURkt8m60PjtLvuU8q09ABG5YCQFgUtXHGnp73/2+ws6LH1aWyz
 Qi2V5HcbztKQsP2CO3uFNJsvcj4GQB5s+HlY+mFmBwJDUV3BeZ+tm/tRoq8MWzUe8bCT88yU=
X-Gm-Gg: AeBDietpqvsAm4SDpsPex1BXy7/Pjp4JGSdoJ/35ZPvbtGCr/axLlFx3kSimWnnzN95
 hmMERM/OTHbSZZxaMgl6mw74sqr7Dx6NlKSAWqWtFbfrztOS5C4VUYGod9Cdgz1lwes8hTzZSKU
 YUTuitIPD4IhUfRxFFurS4LAjAc/nlUXwXp+g+5wp4Z1OD9Gpi4it9kFU/TiaC6RxqrMgPgwUCD
 MM+BLB58M5XU9UxY+EvizVY+6cUvCiTIu6MRMr285wpj6SzMzWqwN0luCRC7TuTgTmXXjEY/L6i
 l8Nd234cCRCpi0T66vhe3bLSS4DtsNrexNYH0Hej+jeTwQrQno7BlHSyYgRMUzPAs/mdVKvIFTV
 VHXUMOUOW9swa6ft5rbVVSv45I+QEmiocW71X6yPoJTZQEUFhEUd9bLTVV3Ee2wPQeP7RCncYT8
 Dz9NAV/p9cFdzq0mgQ80Ttau3hfnZ2NUdGzaRVwIBABaaj7g==
X-Received: by 2002:a05:622a:1f0d:b0:50d:aae1:7070 with SMTP id
 d75a77b69052e-50e36c56a1dmr524175481cf.48.1777153503572; 
 Sat, 25 Apr 2026 14:45:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0d:b0:50d:aae1:7070 with SMTP id
 d75a77b69052e-50e36c56a1dmr524174881cf.48.1777153502621; 
 Sat, 25 Apr 2026 14:45:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0c5sm7017077e87.10.2026.04.25.14.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 14:45:01 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:44:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dennis Gilmore <dennis@ausil.us>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] drm/bridge: simple: Add the Lontium LT8711UXD
 DP-to-HDMI bridge
Message-ID: <ur7mow4lw47ylxj3uigwwasrfywe6n42zb2to7ygeyjlkcgfkf@guzkembyy5hc>
References: <20260425031011.2529364-1-dennis@ausil.us>
 <20260425031011.2529364-4-dennis@ausil.us>
 <20260425112844.GB2964234@killaraus.ideasonboard.com>
 <45evt7lkzuykoqsc2z27hsvm7fasmn6sr6gbjtdnme54jauehf@dmvon2o5emzd>
 <CAABkxwt1=n=CnrVfCcw+EHjqjfsLkp67POk451fV8Gqw4vdnQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABkxwt1=n=CnrVfCcw+EHjqjfsLkp67POk451fV8Gqw4vdnQw@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=69ed35e0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=c7CpEUyHu0UMHcTobk4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: y3xombKvkWFk69lSiM2EmR3X2nBQBBNh
X-Proofpoint-GUID: y3xombKvkWFk69lSiM2EmR3X2nBQBBNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDIyNyBTYWx0ZWRfXyAUcCZBC16fO
 xoMAvi0b/Go4C1r8iivJvGlWrwIj97Fst8mFev9/Jl/F539eTyzd4ouIBpBc0y2BXR97LuYuTWY
 NbOZFsSwwjNJXd2QYHtAlYE3rDDkzXKvbzMT4JTUeA+s02BmLI9mKMsA3vjxpYuQvzv5YEoYvwu
 bwi/YTaY68Szmh1kF31TThPwTXcYArj1lUVw9d8U++S1CZ3FX+wIWTIqKwHKaaOtXe+PbbWMhIq
 NnEDtd+NX966XqN0Vsx7W7GJtzyBKILsFvfPbnMRwqZ4k3qSHHX5DHLvBZSFklS7vZXALNMGwwS
 mevFYJziBrEWpRRwwj0ODxxPimNJVEUWq+sXzZxzIhsH8TmH3rUJ+Wgw5s8S7RLdL1kDuGU06JV
 v88+3BlPVBNZg/4DYoZ8aVQj3NTJqYs/pyh2oxmiaOYQLADgo6K5kOfoOKmr8nD+Loj2W85V8go
 BTo9Tpa7ZWoR07FJHEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250227
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

On Sat, Apr 25, 2026 at 01:10:02PM -0500, Dennis Gilmore wrote:
> On Sat, Apr 25, 2026 at 9:24 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Sat, Apr 25, 2026 at 02:28:44PM +0300, Laurent Pinchart wrote:
> > > Hi Dennis,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Apr 24, 2026 at 10:10:08PM -0500, Dennis Gilmore wrote:
> > > > The Lontium LT8711UXD is a high performance two lane Type-C/DP1.4
> > > > to HDMI2.0 converter, designed to connect a USB Type-C source or
> > > > a DP1.4 source to an HDMI2.0 sink.
> > >
> > > As far as I can tell, the LT8711UXD has an I2C control interface.
> > > Shouldn't it be an I2C device ?
> >
> > From the datasheet:
> >
> > The device is capable of automatic operation which is
> > enabled by an integrated microprocessor that uses an
> > embedded SPI flash for firmware storage. System control
> > is also available through the use of a dedicated
> > configuration I2C slave interface.
> >
> > My guess was that it can either be an I2C device or it can function as a
> > simple platdev with no I2C controls. Please correct me if my
> > understanding was wrong.
> >
> > But now looking at the schematics, it seems to be connected to I2C6.
> > Which means that it should be desribed (and bound) as such.
> 
> Hi Dmitry and Laurent,
> 
> While the schematic shows that it can use I2C and has been wired up,
> it also shows that both MODE_SEL and I2C_ADDR have unpopulated 10k
> resistors; as a result, MODE_SEL is connected directly to GND, putting
> the bridge in autonomous mode. I confirmed this by running `i2cdetect
> -r -y 6`, with the only device on the bus being the HYM8563 RTC at
> 0x51. Without reworking the board, the device is not directly
> controllable and just runs autonomously.

I think it would be nice to mention:
- In the commit for the bindings, that the device can be running
  uncontrolled or it can be attached over I2C, bindings describe the
  uncontrolled mode.
- In this commit message, the same.
- In the commit message for the board DT mention your findings about the
  board, mention soldering R9 or R17 (which one?) and R27.
> 
> Dennis
> 
> > >
> > > > Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> > > > index 8aa31ca3c72d..42c1f3d5ba0c 100644
> > > > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > > > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > > > @@ -270,6 +270,11 @@ static const struct of_device_id simple_bridge_match[] = {
> > > >             .data = &(const struct simple_bridge_info) {
> > > >                     .connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > > >             },
> > > > +   }, {
> > > > +           .compatible = "lontium,lt8711uxd",
> > > > +           .data = &(const struct simple_bridge_info) {
> > > > +                   .connector_type = DRM_MODE_CONNECTOR_HDMIA,
> > > > +           },
> > > >     }, {
> > > >             .compatible = "parade,ps185hdm",
> > > >             .data = &(const struct simple_bridge_info) {
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
