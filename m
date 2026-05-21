Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D92CD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 20:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F9810E20B;
	Thu, 21 May 2026 20:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wq1ZWwGM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ioAvfMkt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14C710E20B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 20:24:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGk3RB4049640
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 20:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uVZRuQgXpH0oQJeuIfFR9OF/
 de+BK41TUpqDLiYGHME=; b=Wq1ZWwGMecMD5NVPKIOYE9ctSizCoksfbiV/DtAR
 ug+x1NAZq3nL1jlGbubQc9CX5Fi1girxaGiwVP4M3OODnbCBN+GXCxq/ODI8uii2
 DjsUhscHCxigu+UUf9GZNyck1zPSlfiDudU9I4V9nPS5lLKxsa3rrXEaRSrFmaYb
 NVNxm9wQdn94izhth8ljAYnR80o7t8jM/LInx72TNX3SCd8UQCz6S+AD37ZCNhrO
 OTCPyAIg6RUg/45c9UrK7leqwwn2SjNQVewKjpM+3hhkbOcxrQg9Mw+jjtuf/Q/M
 qzjiiZifEXm4LZ6DxAsrHxLbgNWipX04YoWus9jT56tj6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9sr34563-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 20:24:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514551d5f2aso249456201cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779395092; x=1779999892;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uVZRuQgXpH0oQJeuIfFR9OF/de+BK41TUpqDLiYGHME=;
 b=ioAvfMktewMxHUdpzykidtWefywZlhYIzwTmViS8/lWVppbcgVGAcOVBh5k8Zhm05i
 pkAkZqoFMwCJQ1zb+Ex9KrhXdNaUHRnm/EyLDAp/V7ZtugT3HS7yjw+Qu8MvnDvnbnWU
 fXaCdE7mvRTqzToknZeOIiajKEeMnS+NJzjmpxspSM+oIVq7sXeK6xZBxxYY+/LH9f+D
 lQQM7ZW9t71mYtNYLWP5/3OFyfTG2LmofdwEfVRsonywo9JnEJStlsnYzzAYglE0woZg
 GGaoXpK/fWMnlDhOMP3eiGOFch0n2LIYnjA8/jxFnwb5F9ZUbDtJ++KKCC1vrl4LunA4
 FWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779395092; x=1779999892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVZRuQgXpH0oQJeuIfFR9OF/de+BK41TUpqDLiYGHME=;
 b=KeaSTQjbAzYJCr0ISwUNvPOkZYzaoDaM/VAuQsl2WiRxuHTFbAsPkNlpmUt21ttLna
 Vf8TgUJiGYywge42oMXE7Bujxxf+zEimX1+mCEnGEBfnmGB5VvilKdz+VHf+5jZRrG0j
 wjlHQxIJEv6cJIBCDlPKPz0gYMNi5s8itYlQ7EOpjva4yO07fOw0g1xiQW6+9k261wE6
 44SK9LACLlmV/0DRTS6mGMWxJ9SsSsZo6mnJZQj/nPIjrN4V4QlrdU+2pZ3G2U7lMkyD
 wABKhlKt+O9MKloFgV8mdkR7U0x5/h62SzYsDey10kRyKizpT3ZwStbeisubOMcxp7iG
 5ykg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cAusXlKVsp8Mpde4WW/MkZTGYAPt68weHN+QA5j9zKNKM8uniX9h5CNdhlCzz7DIVAay2P1CP7B4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9AjKgGE4kLDT8jS0mvvcYbZwZJDCE8Uq581TxMfIPIchmtoQR
 sqQr2WHV40gYMhKiI0YR0hwoZIMxVXTnKBqmc1wcAWCEwTPqZbdfSAcoB9kVaNw339GrbsfNv9p
 cO9/ZySvkYV3S2IvH1hdvZik8Lkv9lk1tAcVi1Kzk+qzx+YMtbGMwERptf+3U28khj+6IVnQ=
X-Gm-Gg: Acq92OGK29zuI2LtRyrnZ8iaCFioneMgf27qTS/5zCgSr8aj82rpH7PrM2ELnAubNId
 05kLw6GSAmR++yTlhWsT4NrrsUY6IUylMKQOCSu5dfWdhZhuTdc+F5oo2J7qvTTuC5ECeUM2Ctr
 PkUW7rGOc+zRN3NI74nxPv6bcSV1/W302tcoEtJ2sdp3Xjm6uCSUV5jHySifOQIrPyXNO4ISeJK
 WyfjKmHlwgQDWRctZozPCLLsaG3ohH1O6jzVhab6sBIohxr8vvogWirZhhM1/twdW4bjtUuj5/H
 qYWM3u5HHyF7rdrxgWws6hD6Fr5yTFdm6osJEC7s5qrapay2lzSmmJ7dnDWBApR4dJ4fMvC5hA/
 o4q0f8G1Na9bRcVl5NULDYAp0PCw36s21IBHXEG75/YHqV55E8hm/aGy0VVLXtWr/2XvxgmcQqI
 mY2/AT8SLvJ2n1MvgDF6Ba8ikrGHfQAKjWd4o=
X-Received: by 2002:a05:622a:5d3:b0:50e:d330:f62d with SMTP id
 d75a77b69052e-516d43fb5d4mr13701631cf.56.1779395092167; 
 Thu, 21 May 2026 13:24:52 -0700 (PDT)
X-Received: by 2002:a05:622a:5d3:b0:50e:d330:f62d with SMTP id
 d75a77b69052e-516d43fb5d4mr13701151cf.56.1779395091633; 
 Thu, 21 May 2026 13:24:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d9665f78sm209971fa.27.2026.05.21.13.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 13:24:49 -0700 (PDT)
Date: Thu, 21 May 2026 23:24:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: display: Add Synaptics R63455 panel
 support
Message-ID: <2w6cpuzwxht2dv7a3xj57ukuzqa2b77ba2syl2ewdmq5bprczb@g3rm2k7e4l4h>
References: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
 <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
X-Proofpoint-GUID: PL2UqYxI2W45kCFBon8S-nsITPyok3Ao
X-Proofpoint-ORIG-GUID: PL2UqYxI2W45kCFBon8S-nsITPyok3Ao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwNSBTYWx0ZWRfX3dw12GZQY2Y9
 8GT7n6u9CHg1bhgNzcErrBwBrnsVccPZTewAurTox2WCLfaL8r4MxD2BL4Radt0s/Q7xFU/JSDU
 LrHvbzNxlzdy5uHlGAAm5jxLGnHOoTbpohusBu2KRK7xGF0+8uCL6UthBUSm257g2jKbsAMxex/
 hVupIzpulUH+u65j5JrROTXCMIMFsH/KDBuZCPxySIZX3/7UvB3Hklzt+vhGY7F8K26VQMkb/IZ
 EPVhmqMKZPha7qg5jlCY8SOCXZT0lEUoR4EqVE7yPbOB1uETG5GI+PP5ep2HUqDiP0I+yIyavyz
 wG3tGLQIRYbobkXohDuYKz8eLsUGh6+STvFbAPLP3FJ/DUB3wG4eQt+W5ipSnWZmW9P1cNsfDiV
 egbl3wGSb69/N8S8FcSU1+D+iMu+ax6MrGI6x1zEd2AyLYnhFBzLqKbMC2ex/ts8Azuvzv8xWxL
 cEGQ+SBbjdP858QkvZw==
X-Authority-Analysis: v=2.4 cv=L+YtheT8 c=1 sm=1 tr=0 ts=6a0f6a14 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=KKAkSRfTAAAA:8 a=5IMEwuT189ni8Q75ZTYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210205
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

On Thu, May 21, 2026 at 10:46:06PM +0800, Jun Nie wrote:
> Add support for the dual-panel system found in the virtual reality device.
> This system consists of two physical 2160x2160 panels, each connected via
> a MIPI DSI interface. The backlight is managed through DSI link.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/display/panel/synaptics,r63455.yaml   | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
> new file mode 100644
> index 0000000000000..a94b355ed9557
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/synaptics,r63455.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synaptics R63455 based dual 2160x2160 MIPI-DSI Panel
> +
> +maintainers:
> +  - Jun Nie <jun.nie@linaro.org>
> +
> +description:
> +  Synaptics R63455 is a Virtual Reality Display Driver and VR Bridge, used in
> +  pair in Headset devices. The Virtual Reality Display complex is composed of
> +  two strictly identical display panels, each driven by its own DSI interface
> +  but forms a single virtual display for the human eye perception and thus
> +  requires a strict synchronization of the two display panel content update.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - sharp,ls026b3sa06
> +        - boe,vs026c4m-n52-6000
> +      - const: synaptics,r63455
> +
> +  reset-gpios:
> +    maxItems: 2
> +    description: 2 reset pins for 2 physical panels
> +
> +  left-pos-supply:
> +    description: Positive 5.7V supply for left panel

So, is the R63455 driving both panels or are there two panels, each
having R63455 controller? What if somebody gets a single Sharp panel and
wants to use it in their device? How will it match these bindings?

> +
> +  right-pos-supply:
> +    description: Positive 5.7V supply for right panel
> +
> +  left-neg-supply:
> +    description: Negative 5.7V supply for left panel
> +
> +  right-neg-supply:
> +    description: Negative 5.7V supply for right panel
> +
> +  left-backlight-supply:
> +    description: Backlight 21V supply for left panel
> +
> +  right-backlight-supply:
> +    description: Backlight 21V supply for right panel
> +
> +  vdda-supply:
> +    description: core 1.8V supply for panels
> +
> +  ports: $ref: /schemas/graph.yaml#/properties/ports
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - left-pos-supply
> +  - left-neg-supply
> +  - right-pos-supply
> +  - right-neg-supply
> +  - left-backlight-supply
> +  - right-backlight-supply
> +  - vdda-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    &mdss_dsi0 {

Please drop the MDSS specifics, there should be one (or two) DSI busses,
driving your panels. The rests are details which are not necessary for
the example.

> +        vdda-supply = <&vreg_l3i_1p2>;
> +        status = "okay";
> +
> +        qcom,dual-dsi-mode;
> +        qcom,master-dsi;
> +
> +        panel: panel@0 {
> +            compatible = "sharp,ls026b3sa06", "synaptics,r63455";
> +            reg = <0>;
> +
> +            reset-gpios = <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>,
> +                          <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
> +
> +            left-pos-supply = <&vpos_left>;
> +            left-neg-supply = <&vneg_left>;
> +            right-pos-supply = <&vpos_right>;
> +            right-neg-supply = <&vneg_right>;
> +            left-backlight-supply = <&backlight_left>;
> +            right-backlight-supply = <&backlight_right>;
> +
> +            vdda-supply = <&vreg_l12b_1p8>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    panel0_in: endpoint {
> +                        remote-endpoint = <&mdss_dsi0_out>;

What is mdss_dsi0_out?

> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    panel1_in: endpoint {
> +                        remote-endpoint = <&mdss_dsi1_out>;
> +                    };
> +                };
> +            };
> +    };
> +
> +    &mdss_dsi0_out {
> +            remote-endpoint = <&panel0_in>;
> +            data-lanes = <0 1 2>;
> +    };
> +
> +    &mdss_dsi1_out {
> +            remote-endpoint = <&panel1_in>;
> +            data-lanes = <0 1 2>;
> +    };
> +...
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
