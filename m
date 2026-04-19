Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB9F99C8D
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC9D10E45F;
	Sun, 19 Apr 2026 00:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrWWp7hI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sc1neZtM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEE310E45B
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:31:44 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63INJZQJ2771456
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9BJnRhBdmjMPv2ZgiiB7rIRn
 IlSfrZe2ds8ryjQycys=; b=MrWWp7hIE0X6GGmP3gxzsyulbMwB6bPoIs80//yB
 dssa5P1FjWVlbbxy0pDN3dG3AXJB7j7bFw9oGg7xxZlgaPoS107JuHuR2Dtay8KQ
 EFnflp9Uftl3OX+/0tJkp0DUOd2SUETV6kZx74CJ/w4NEQKCjD3CC32udtNtaDgM
 hLDS0dsgdEGqXAKGeC5IalCWs7LGBWj101GU6IRHW30Z2gFzo6LYNyr72f/Tt6g5
 N0ypaqz0RkFLr6Brqk/VT5EdFXUQ8gfmfDNangGoJ9OLk+kALvDrv3ZzxdTJ0/fX
 aHrvvqlXULb0nafgdRpsa30RlCkJce4WE6E3qb1Thl/+4g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b71nax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:31:43 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-56f71e90581so1571897e0c.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776558703; x=1777163503;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BJnRhBdmjMPv2ZgiiB7rIRnIlSfrZe2ds8ryjQycys=;
 b=Sc1neZtMo7ZoWVMQw1T7UuD6O8TypbmihnPAhbkBaajKudkXlG4Vwyq0AZ8iW/60ui
 Za+VdB3NpmXCt84Na3DZQPTiSnprxVaRWgmZOmSan94iyvY9WGwrGihx2Xv7uesvzCH0
 h5LwFvpiwbp6SgxpuAZrw8lkxEPDsLWNwimmpAQCdTn1OBiHZ+IftnOGCau+GJ8htA96
 74HUXmHEwbyiRauD4RJXrzA2nWi2QsjHR2pERJWh+xGiHPSiBbJierFwOVlFcvmVE/bP
 8VoVbve0sT0IUzGzlyD7qr9xm0edhb/hSdwKNHCUk5DEhRKbMiKgbmEqGuGkVdx453qq
 46PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776558703; x=1777163503;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BJnRhBdmjMPv2ZgiiB7rIRnIlSfrZe2ds8ryjQycys=;
 b=RwcIBnHBeJ3TMnZavFVafhADM6Uv7wyMoaEegIogBV6sHktGmw4wHkloH+VH3mjzdn
 VVf6aMAkCCvKN66GF0CCOzSFdq5vuKUOPMg+QEN6jowGwFEtkyeVSFbS3MRG3A7EjcHQ
 MtqSOElOU4kzAiXDViVa1UBi5vJgYZd3fa7mZa4eEgy5xrmBfLQfoa4By8Ga8z8fenPn
 U0YHS0tgI7sdD8HVWqIiA6KJiWTDpXNu4ESvTiPMqtZasuY4EU0VthK/5rr91FD6nr6L
 Fgj/JFuC88EG6C6kQDNmLm3WoI85I7G0OsuePekm9ToKiAzewvdAnDLO1l9NjCEljNcz
 Ylxw==
X-Gm-Message-State: AOJu0Yw2K+GpC0itMbyA77GJoDIOCxjtY3RJ6OVq+E4OEKBPijhQiYh8
 L01D/H3RuZ27XzaE28dphNOGzn9rf/2GeWy8ItoTvoZBUDtI4PUt6LvAku1aA48I/ze3Y81godX
 HS0F7DhxrIoAtC1rwMx7Amkv/LqfAV81dBDFmJeN3yOx6RyXgCjhgV6VOZH/uJmIql1scCpY=
X-Gm-Gg: AeBDietmEC3Uo6yxixJz+y/wvh7qVgoAOiIpvOTp/OuHKLHZSQMqa9TgvexgzFROsgt
 msdJfcQ4tCx+8lq7bVEPsM+MSeRrTZJBjdywgYwBK3NbayMfn1lfpvEY0lf8Ab/qRvWifyd+t2v
 CxWOh9nVrplW/k91dwTAYLkEn9ijdWfawNxgLSYlk1TXImeX8Yw4+xBaHGTer0hhJMq9pPsp2hJ
 CXKKzeoT0/wFu50lmxd/MWTBw0olBHcUjV0DxVehfce3nMHAeo0PEiV0pZlidJku1bDRr9oXVCr
 owPcEO4jfUjbfxaJbDE9Vw4Psu+Hlw12IXP2G30iwLL+S2CpyQ7Jb8+uRt8yUvlaJ295ya92Lpc
 VPVdnq+bLPA31Nn8qLb+YfqJ6wFT4UtlJTKLemouBQ6/TeYAIRLCgASfRGrw8TB5i3+dUXzGwHX
 XqxSp6K8aEudWy2RKqm8J8LWM3i/RSYXUW1b/ICj51nwUO2Q==
X-Received: by 2002:a05:6102:38cb:b0:608:a01d:f7e3 with SMTP id
 ada2fe7eead31-616f7c60edamr4073077137.31.1776558702915; 
 Sat, 18 Apr 2026 17:31:42 -0700 (PDT)
X-Received: by 2002:a05:6102:38cb:b0:608:a01d:f7e3 with SMTP id
 ada2fe7eead31-616f7c60edamr4073068137.31.1776558702431; 
 Sat, 18 Apr 2026 17:31:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb290095sm13831621fa.0.2026.04.18.17.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:31:40 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:31:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Simona Vetter <simona@ffwll.ch>, linux-gpio@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Jie Gan <jie.gan@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
 Ondrej Jirman <megi@xff.cz>, Thomas Zimmermann <tzimmermann@suse.de>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: gpio: describe Waveshare GPIO
 controller
Message-ID: <bvldldozdtwzcst7vsdjhcwe355r6khhu6jlq5cvdu2mh6ioyo@m322ojan3pa4>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
 <20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com>
 <177647276773.3416847.5121391765535033685.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177647276773.3416847.5121391765535033685.robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e4226f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8 a=0awkmHLjsCMGZ7zvgVIA:9
 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwNCBTYWx0ZWRfX/1PYgl6ygv02
 QkXaD6Z6GZ/IDk2GQlR0/9UbCk5zyjdbW44RlMovKnSDxKm1NIBWF2HuOt3BGf6T9lEqI+wDmW7
 Vyv5z1KkmCank5iFvKcIeH7aE3eAQ+f4GSjkHOlSqNSvUQcIX6rvyxVPxjnhYQXSZFwbnjN+iCe
 66k93s9JNyHOiJfQd2uDOKNsZKYV/uEYzUB+ncYdNpm33dC+/VKYL/IBn7yOpENOBObLitmgXBM
 AgbMxdtF/uD16BRX8XsITp+5Ew88DZQMm6c1zozjOU42IG+CEigNNzo/XOjWKc0NLzJLcjeOXWD
 yAgjGw5sfY9TBC89oHKS0zdtZx4SF23RKXqDN+9AvjprEdnMCdi3MsNm8r0xeCqU8UnE38jL0Mn
 ivlFHYuLmaQCeH1gazNCyG9NIec+mg4zphOzujaegO9kRJ2FJkvRLczx3+5IMLRETwyJLjOEHi0
 YTmO5DDktQycZ+v4vhg==
X-Proofpoint-GUID: zilNEqBXk6Kyl4_cZpHXTVUVqUjcSFPo
X-Proofpoint-ORIG-GUID: zilNEqBXk6Kyl4_cZpHXTVUVqUjcSFPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190004
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

On Fri, Apr 17, 2026 at 07:39:27PM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 18 Apr 2026 02:16:22 +0300, Dmitry Baryshkov wrote:
> > The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> > controller, which controls power supplies to the panel and the touch
> > screen and provides reset pins for both the panel and the touchscreen.
> > Also it provides a simple PWM controller for panel backlight.
> > 
> > Add bindings for these GPIO controllers. As overall integration might be
> > not very obvious (and it differs significantly from the bindings used by
> > the original drivers), provide complete example with the on-board
> > regulators and the DSI panel.
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: panel@0 (waveshare,8.0-dsi-touch-a): compatible:0: 'waveshare,8.0-dsi-touch-a' is not one of ['anbernic,rg-ds-display-bottom', 'anbernic,rg-ds-display-top', 'chongzhou,cz101b4001', 'kingdisplay,kd101ne3-40ti', 'melfas,lmfbx101117480', 'radxa,display-10hd-ad001', 'radxa,display-8hd-ad002', 'taiguanck,xti05101-01a']
> 	from schema $id: http://devicetree.org/schemas/display/panel/jadard,jd9365da-h3.yaml
> Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['waveshare,8.0-dsi-touch-a', 'jadard,jd9365da-h3']
> 

Sorry, yes. This patch is now a part of drm-misc-next, but is not in
-next, until 7.1-rc1.

> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
With best wishes
Dmitry
