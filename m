Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4271094489
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 16:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CAF10E285;
	Sat, 21 Mar 2026 16:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePyL/e//";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ACkHi3jd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310B710E285
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:45:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62LCwZeC324938
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2/N1XFHZigaYi8JcvlnG5wwE
 4V6fkSbgFB8/uIe4z38=; b=ePyL/e//PQz/eiSykNU/683qA09roC+Cafcdp6iD
 KQWOU6EJ1OiYuspTlu9rLOkc4HkvEVVMdoSNb2TUwCRVuDQw2XhlZM0EMtREqSu+
 h73dM3WHOkajbwtUpXGPyzvQVpacwNxDxep0A8WIgbN5hlcHRltXBEDV+bIkfbU5
 J+2k77IO25C0Firn+ZomMWtiLWgKIqOIf/zAVeCTC6LoHG8D5FlK2MX8ixmCMCX4
 c0/xgY5/L5Hk0urp/QvQ+TDVtW2r/4XC3K0FoHU9NavWqqVRHqdXPpUOkgja3YjI
 wSzRnhy+LuO2dzdD8UYkvL0HMO4Z0BLNxD6Ff9vrOm39Wg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1gpk17sh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 16:45:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4987c698so45202871cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774111553; x=1774716353;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2/N1XFHZigaYi8JcvlnG5wwE4V6fkSbgFB8/uIe4z38=;
 b=ACkHi3jdJp+gyX4NYyNNDFhjCcGEHZZou3dLMSH2k+/2clTXeqWnJIu3BxzaBrlpym
 UMywYZmPmffqoAbURDTA+UObeTBOKAjb5+klGIWLHYoo97asf7VF2sExX8kfvK3bh1d2
 1TF2YJdJ0FHfM3Ud7P2/KID8JTGrAtBMGQiQ3N2ec7eG1oY+WkH5WYKpuyN5nJXOWrMA
 BVV3TrVzf1QvfOFPG/IPKTuGqeHBNTTyD+sdQwNt60oZ4LuT4904I+Zr/TcgR/vDYIYg
 a0vFAQk6ukh2N2ZvKSarauM0tfHbDVX0hKMhD2cp9fX5aZzasgCuVN+P6yYqr2QEgb38
 YoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774111553; x=1774716353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/N1XFHZigaYi8JcvlnG5wwE4V6fkSbgFB8/uIe4z38=;
 b=KC+v1JiF3QrZzFzqxL9399nuvMoQQZ6gNrYZpC8PJHbsRhCYpO5q6qiB7vEv8XKFZ+
 jiIeM0QgiFRLixfmebVm3+B9oDs88OPU4f+h1Yep87t5pJ4WP3iVGr04ERV3HZqc7GrQ
 w0Eq1LL+M+fYG4co0OgsIj1KfzKU9JC4pXLBcVOHLNxqjVCJwRhDK/U7vLH3sZbXOMJi
 hJIGlKWNIN/SuC4CmPNBYi/5bgIKrGxOl8QCWZF88v9FE5lbNxJGi6bl/VvFTVVCUm35
 uUdLuE6ZVj4InZCsjWxjKnK0Gi5XOeg5XYae42CthYvGlTf6Zm+y7/i/tF2FXAbMgI2x
 oC5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAe6CshlP80q39XGIBPZ+vWj2ox2Rs6ixGolwBZt+4SKIaEbk3BC5zhpyjSlfp0o1Sfbpvb/idimo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfnFAtgyrV7FZCbyAo2COCxFNQu2sLxR2zhW7mXFigjx+IxJBE
 UTdrZPoYdDzdtAyxIFfmd9ZraJHEQYWYularbIfhIRzvmRgrWNaJq8yUIuEwGZke1D29UbB3PN4
 TKInYAXrPVIIK37e1vhtUiQeDOy8OI20fR43ctwGtj4aLVLWzF0wHtX24F43k/ssAjaHfeqU=
X-Gm-Gg: ATEYQzx3HHXdCx/VOWQthKnf/Yl6Mp5AdoJ589dcShzMhL23OZPS35jyT78miYvF5i+
 W9GRwWEMCQQwkGaoIMQfXNTZG5uDznLj63sDL6uJaA2irp0cGBtNyosirPmbhcQPcu9RMdg2Njy
 RrOgc+3O29oaCvcbB77q31i+mNtCEySLw/np0RbqP+BcQGqWh6q4MHMhk01GP8bCxq9+7IpJdGG
 sbLvMppQ6xjcCAeT3e/GFbA6eCecidUcufysckl0BuS0Riw+eGiJYjq33zR7N5X3G2OTAt8BabN
 FfqYw/jyxpyI/NTwDH0HMum4DxgSeTN7nij3G06ITdjEVVAeZtbATLdMpWOTyvcpn8DwKlTzM13
 2w/KuKkePHiyW6MESYqSmyx1sYihaQM0zGo49URqUpteJpiiLS5E21CEnRr77lPnhbQvO+Hzmd3
 QckSMWJh6oqxqbf5pryd8heSXx1OnDuNS7Bio=
X-Received: by 2002:a05:622a:a6d1:b0:50b:4a3c:8917 with SMTP id
 d75a77b69052e-50b4a3c9321mr25856381cf.24.1774111553227; 
 Sat, 21 Mar 2026 09:45:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a6d1:b0:50b:4a3c:8917 with SMTP id
 d75a77b69052e-50b4a3c9321mr25856101cf.24.1774111552728; 
 Sat, 21 Mar 2026 09:45:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28519f2afsm1227669e87.18.2026.03.21.09.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 09:45:51 -0700 (PDT)
Date: Sat, 21 Mar 2026 18:45:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: cristian_ci@protonmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <sdcfwycey5ykhn2fghun7imx3tjtnwat3ny3mut5dwstl7wvw6@maqrzlycwdn5>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
X-Proofpoint-ORIG-GUID: jOht1pYRVl2oEsTAdTenJDpNHLOAyeIs
X-Proofpoint-GUID: jOht1pYRVl2oEsTAdTenJDpNHLOAyeIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0MiBTYWx0ZWRfX/60fBSl7teJn
 b0zdsi8tcDwBoGNZfugWix4MM0vkUAgFQdtfJzoexPpQUiIx5eya3cJmegpUO3ivsnA/aZYVoc3
 CoiYS+8NQY/tj6b9rwCh/qe9okL1qEc7JrY4sBbZ1Ipo3+WsdYbu1W6BQFcgvyW1BBa0CPIWWnh
 3KLBfjPKcFgmPEm78pKmyjnnDK9LmkG3jrbzgJ/zsjRAlzWzi2hrPr5shG7K0jchQnl1lk728lA
 YVZ2wnfghnG0jTiQt4dEpM2dDrYMnanL/Lby+5AMoU/6r7yKm3K38Dfuo6/d0viYf5yZ3/NIQbL
 4ew0fZ7M2i+7zqX6etXPlWVWfNaCZh3RyWdqms6408GeShaKJ4YqhOuq2JL0sPo5XLQ68bMUI3p
 HGsBux0hy8qkl3QFD1LOQ8xPmOl4oAvbYBR6C672/R89FKV8PRiWk2Q1YCLTiDCNS7n7ZggFGEQ
 IOD9mSkBM8BKo0f5l2Q==
X-Authority-Analysis: v=2.4 cv=QKhlhwLL c=1 sm=1 tr=0 ts=69becb41 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=sfOm8-O8AAAA:8 a=VwQbUJbxAAAA:8 a=dSvQR-6XSxectfY1rdkA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210142
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

On Sat, Mar 21, 2026 at 05:23:20PM +0100, Cristian Cozzolino via B4 Relay wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> Document Novatek NT35532-based DSI display panel.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> ---
>  .../bindings/display/panel/novatek,nt35532.yaml    | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 82 insertions(+)

> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: novatek,nt35532

This is not enough to identify the panel. This name identifies the
controller inside the panel, however the exact settings (and the
behaviour) would depend on the exact TFT "glass" used with this
controller. Downstream usually doesn't care that much and frequently
just uses the controller name or the the controller with some kind of
"description" like ("wqhd-dsc-cmd").

What does it mean for the upstream:
- Try identifying the actual panel used for the phones. Sometimes
  googling for spare or replacement parts would reveal such a name.
  Sometimes it can be seen as a marking on the cable or on the backside
  of the panel (again, googling).

- If not found, come up with some artificial identifier that would
  identify the controller+glass combo (e.g. "tianma,fhd-video" or
  "lenovo,j606f-boe-nt36523w" (where lenovo,j6006f is a device name and
  boe is a "supplier").

- Either use both strings for compat property:
  compatible = "tianma,fhd-video", "novatek,nt36672a"
  or just the first one.

> +
> +  reg:
> +    maxItems: 1
> +
> +  backlight: true
> +  reset-gpios: true
> +
> +  avdd-supply:
> +    description: positive boost supply regulator
> +
> +  avee-supply:
> +    description: negative boost supply regulator
> +
> +  vci-supply:
> +    description: regulator that supplies the analog voltage
> +
> +  vddam-supply:
> +    description: power supply for MIPI interface
> +
> +  vddi-supply:
> +    description: regulator that supplies the I/O voltage
> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vddi-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "novatek,nt35532";
> +            reg = <0>;
> +
> +            backlight = <&pmi8950_wled>;
> +            reset-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
> +            avdd-supply = <&lab>;
> +            avee-supply = <&ibb>;
> +            vci-supply = <&pm8953_l17>;
> +            vddi-supply = <&pm8953_l6>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a626dee5c106..8ed2866bbd6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8171,6 +8171,11 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
>  F:	drivers/gpu/drm/panel/panel-novatek-nt35510.c
>  
> +DRM DRIVER FOR NOVATEK NT35532 PANELS
> +M:	Cristian Cozzolino <cristian_ci@protonmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
> +
>  DRM DRIVER FOR NOVATEK NT35560 PANELS
>  M:	Linus Walleij <linusw@kernel.org>
>  S:	Maintained
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry
