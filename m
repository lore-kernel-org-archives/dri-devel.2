Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC6FF3ED67
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FFE10E056;
	Sun, 12 Apr 2026 00:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVgzHLsM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dVbPYkK+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B9910E056
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:44:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B41TC23377186
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oUcmc+2Ei2fVaFQX3mJ3mFtBKVYvWD4maAZTsml9Xhk=; b=EVgzHLsMkL1w4vie
 kjql4uteP484THvM45Yi6af048RJKQ8nT2JjXfsG+iOwauFjdSjwJ/74MrQsjsDk
 KvpDNL4woYK1KaYNszh5JXpMgiEH07AKFw3BFlZ+2/DEr0fXXrDNErAFv1MEhano
 ZIRD6vf+Uioa5nMZaFrDfqBnuGGV1IaeHGnDpmcRvXNGSP69R7jxNhtgNol0bt2p
 xFG/JUgk1S7czwhcrUMVOu8ysYzXCokXvt37RRzRJ47im2LbtswHZ7pptpkSKyu8
 2Q7/LZzZKHaIUCq5PWOHl5fE5UbL9johjLpo13n4AyrHJ65Yy+Mtid2GC3J84xKu
 nywikA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewksk65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:44:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358e425c261so3972557a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775954679; x=1776559479;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUcmc+2Ei2fVaFQX3mJ3mFtBKVYvWD4maAZTsml9Xhk=;
 b=dVbPYkK+pz30QGk9wT9lzlCNMX7feYn5ltLSKPsL9oCqdBeiU0jXzsLiJdn3LMSMiW
 kpj05VHlWOwQCYw8jQVZUxLKmP63poLIEDWJQyXHDV0c83wFyYPWOepKT2yQYwvna3eV
 vTlST0AFG31/j3kNwT8a/yvDlNA2YsBPNItqO2u2Xh7Xni/6Ek1dRntWHOdb43gVRYpF
 S2ZO1pZ4Ha+mSlxQ0ENxmQiFjkrOh6A5J/cN+EHo7tjkWxtmKZo9rPRlzYmIJwOfN98d
 FJ4otCPU6oeKIcYxK51izmDk6VALBTBlssGJqjytHL419y5Gkdg3MYA8AnW5nBA0wFn3
 IEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775954679; x=1776559479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUcmc+2Ei2fVaFQX3mJ3mFtBKVYvWD4maAZTsml9Xhk=;
 b=FUIBx8tlrVQtV5euFJ0SGnlKC7jvxJh9b3ZzUEyPoDhPBuIjHm+Q1gvw5zJyHkNQol
 7x/HYaGOU12ffbhyW60j8W66UXxfSN83MMERqzI8RFA+iWQee6pTioOU4dXPaQ7sZsXe
 40lPMOabvvRKPA4IDeqH6KFJHpA9PWd3SWEYvEcnWVKsbBIDKHBqaeNwVe2Xl6eIa/YL
 X7Qgt+I6LWyttWYfCnWxmrVoZiJSVCoknjdGCh7mbfsib+wid6z8eEQvkdA7tH2DwkAG
 L98BgWL2Enuk301waXc9483L+sKRi7lFXXuuYTsxp8t0n0vvs1DONpgbHT42kzmzQ77B
 plbQ==
X-Gm-Message-State: AOJu0YzAtxqfNz3ekWeRTctzvMgKH2v9yaIhzA4WPrXSSSgRVVNz45Kp
 WRcsDaqSA5eURROCjHcZIlyZejL8e31yP++9R8xrykOml0Ked2uLtUCBuD6+RS9FyEMKgwtGfGq
 XpZJpiNtp3jAsIx+2ztSLIK/UfoecmPkxI/MUHHNvq8NRd1Jt0oAkewSP+R2NVvUw6m3i08o=
X-Gm-Gg: AeBDietwOsZ6g7nUBYga4qctf4lsgmO07/wR+atNnQbXr8rk/qJcuXGw9tST20RFQSp
 FK7CUFUG5+aL0kJ1Srf3vSQzOZlaMZhoBTCuoV/c7UzmjNosF76LDuUvfOoUj9t/V6ia+Y8JnF5
 aOslWIznOAGjLWtdBXV2KBhM8+4Mqd5bTY1MpRNTHBcRuqefqPyPc3GRtYg2aQ72n3AOb/QjlLx
 GnErTXiWvcmjC3dVk0m8Ky0eecRvP/vmSLMe1mrDRBADAvZyRgLUujVLoLWEfu1oa+wXosOgnwt
 Bb2s0i2BxGDQAChj8K1x6c9hwI7d8fs7DbTVx1M7B3Sb6A0Aem8En3tP9/wEgFsDL7aPPCme5o8
 rZztsKG92eDFvhDWdAa8haw4SpzOxw7P+UsVf7PBUYoA9js7qD03sn8goClzeI1jw6gNaLY3Hd8
 GS/P9m1Z5WdQ==
X-Received: by 2002:a17:90b:2e49:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-35e42846f87mr7914810a91.17.1775954678918; 
 Sat, 11 Apr 2026 17:44:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2e49:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-35e42846f87mr7914796a91.17.1775954678438; 
 Sat, 11 Apr 2026 17:44:38 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e41355470sm7751367a91.17.2026.04.11.17.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 17:44:37 -0700 (PDT)
Message-ID: <85a1c43e-7cf9-44db-903e-4a0dd73e3447@oss.qualcomm.com>
Date: Sun, 12 Apr 2026 08:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/21] dt-bindings: dipslay/panel: describe panels
 using Focaltech OTA7290B
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69daeaf7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=XmleDvvGYaDDAQC-lZAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMyBTYWx0ZWRfXzZlBtkUWzr3g
 NE52IpzlAK4UjCPX6Kd6APzkER6sQWrhxD9zyCb14dfSY3s7BjXxyHOjulG8hJ9m32qyksCqSx1
 ysTaFJz7cz9JNvYr/MkjXibr6kQ4vfw/p1JmdwQpWpJZ6KEZcG41MzMT+SpvkRzS4MxjfXZLYDc
 ufvq/0gF5idrkIGZelcZTItuGeR/EqYFIoXMkt0PTkKmEK/5nJqCOoyIt6bVFPw37cZjXv8pjf3
 gTCOk/TP30CQsXvMJswtMdM9I8N+cTpInx2H8hqASnkn4zpHjPZsJTIXBIlknJwVnSzBQvrjCUC
 CX7YA/krKtnWqLQS1FaJRbBIAhq4wYAB4boitqX9H0DTQt3wBOEmbKKvXiYXowqPVF5fjPsaR0P
 lVleYMYVF4GgYw7CRxS5NIJ4vAfNH/0YBg752Is5qJChbG+QHtXG/X+lSvINMIu0og4v+bt1yBs
 ZhZVuyMMIQLemAE+tJQ==
X-Proofpoint-ORIG-GUID: _efbHbgS0R8zQaDNI5Brbjag9QncmAyz
X-Proofpoint-GUID: _efbHbgS0R8zQaDNI5Brbjag9QncmAyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604120003
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



On 4/11/2026 8:10 PM, Dmitry Baryshkov wrote:
> Add schema for the panels using Focaltech OTA7290B controller. For now
> there is only one such panel, from the Waveshare 8.8 DSI TOUCH-A kit.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   .../bindings/display/panel/focaltech,ota7290b.yaml | 70 ++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
> new file mode 100644
> index 000000000000..f2f6e254b7de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/focaltech,ota7290b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Focaltech OTA7290B DSI panels
> +
> +maintainers:
> +  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: waveshare,8.88-dsi-touch-a

mismatch with the compatible in the example.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: supply regulator for VDD, usually 3.3V
> +
> +  vdda-supply:
> +    description: supply regulator for VDDA, 7-10V
> +
> +  vcc-supply:
> +    description: supply regulator for VCCIO, usually 1.5V
> +
> +  reset-gpios: true
> +  backlight: true
> +  rotation: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vccio-supply

defined as vcc-supply in property block.

Thanks,
Jie

> +  - reset-gpios
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
> +            compatible = "waveshare,8.8-dsi-touch-a";
> +            reg = <0>;
> +            vdd-supply = <&vdd>;
> +            vccio-supply = <&vccio>;
> +            reset-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> +            backlight = <&backlight>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint = <&mipi_out_panel>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> +
> 

