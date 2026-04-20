Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BF9EA71B9
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 03:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50AF10E154;
	Mon, 20 Apr 2026 03:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYuPE5UB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jmLeRDyu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001A010E154
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:12:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMUNf81341507
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iIpJhYwWUklQ7vfgGsge3mg/
 ZXlhfe7X8mN9MTgJ+gE=; b=VYuPE5UB8NJw/zGh0H7YAbDFj6YoMTU/VZKlf/GE
 uez5InlRGbViccqDOs8HEz6RS6F16L2rHL65QuKy19x/oGrIP499cvhwBnaSXFjM
 kmLAYZd212iJ3QXw8rthgCN9IEInvGKYsYRI92X6meSB03Dxo4i+SXWQtFtLCd62
 wUuyt1C/qG8JCnTSfep/1orU3w5cr6b7GdMTolPcJzVUel5xGI4NQ7ni9B/9HvOL
 jx+Vco75/hxAu0RFRZCOUPA+QGKKEDx0aMZCWF+qX+4f4MxKfDYWxIAbLOGH3ZcX
 5Zm50PhdXnOjv0CxyBDdXegmoGlTVWe1wPLPNGcpS9bGMQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm34hbqwm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 03:12:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4678c6171so29372935ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 20:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776654736; cv=none;
 d=google.com; s=arc-20240605;
 b=XoCIuYkJbOl5PHYUE68Nz8aw7iB89JwCGycg2h2OtUyu/na4r7GKsAsKnoV+9/e2nf
 Pw5I/iSBgUZpnqTsk762P5MQq+8pwhHIgI8IjYNXOVn01OKlZjRC0HRSi+yVjG5ljxSe
 DbJnzq26IMT+HCXYAl2cdEkKYnqEtU7rs6U/VJzfsAl5iyiFp1/ogTYmZrCLXqRkdH35
 0qjZZkG3Ji6PwD5/xVo4YiKcRVEBYiOhIqONJtfTxJpAFNQmJd2vQK4XJngj9fmYXEr1
 zb3WpoeP9kNq1rtjttUej4gHSfafiRRfUTDut4+jtjMlwwWTA5cU4V7AJvFY/tGnavtZ
 exlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iIpJhYwWUklQ7vfgGsge3mg/ZXlhfe7X8mN9MTgJ+gE=;
 fh=W5KsnypePjqjw5Kn9XECGU4JrzJly+kaTOWK6zw7l/o=;
 b=QtYsXLP9LrVp4NXCJhsyHUEEQDyWwhgsMzvKeexJjgh1S46nyhIKXmwHWU7MhtFaSz
 TjqbfAE0R/QqpicBnyUadvDZV7W6yIfuz78kiq97djdx/ujqtlyd3aCSnF1K/+lX3pX1
 GVOi6wP3YrlfBHWYQzu11E1wqgfOcfuNuDFILeo6al+m8KZK6Yb7MynDyfMyZGrOaOTA
 8B911uvLbDEj/7RHBmEO++yWBu/bgd+xalYVQUKlbFsr1KUPmlj60mt49qMrrpi+/Xtb
 4rDxcPSxNA9biqFdCUcaesBE4Dzktrf1EuqvtiiUVYwqNgkWPZQhGayVCW6YSFtE2e+I
 N1lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776654736; x=1777259536;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iIpJhYwWUklQ7vfgGsge3mg/ZXlhfe7X8mN9MTgJ+gE=;
 b=jmLeRDyuY96VRM6dZdvFxSfYup5UIYdtx1ZhzQ6S5b9KCcFqDLoqfC+nkxlFXARdfS
 6JXs/SgEd9ubw92IPDxmwcforYPM9ldye4+xJ04s/qLi508i4WumiKPZ7Isqib2JLwsK
 c6i0ZyicgW1T0oQmunR1OkCXxcRVMz/rUjMB5tykAT73uJkCkmLFR7tfDlR3DNxOj02c
 s6q3eB0btEq6vn7CcPF3qoVJFgLg1KWQy7zwkk40IjWBDLGHC37fEkVoUbv/LPNrBeSk
 aMxiMMnHw3pIDUSVm2hKQWjAdvh4KixaMZdRxIXXyv7sFl1Zzt7JRBNnTso5dH1RQViH
 5/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776654736; x=1777259536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIpJhYwWUklQ7vfgGsge3mg/ZXlhfe7X8mN9MTgJ+gE=;
 b=fBe7V3Zbp/XQtdT3Z3kvolf5CBpKXALodb3D615C6NuTM2dhvXotxjRCfgZSP3MYQc
 NCtzwMyEDGmDowhbOPUHOVH6j8HpNaZyrzJ/QmpcnU4T0j/vrJ1dV5oR2afqBNhIGXKL
 xa1oj6CzRoEEPt96OLTaHLqvWGiperKoXDxFdADn+fIM4vTcpDJkaIEnKt1tR2u+rZcp
 S9p6KSyk/1I9JrMq+d8sW9+JZU3cDD2hqrJhJzeT22vF4NfMpvdMc+exS6c60/L823Ru
 MORY4d7P3Jwc5K/fUV9m2NfYAsXhVicDYQGnVLzeE1C+yFfR0teTDHoryzb4+btTwrOt
 lgbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nr8jqRYze2JlKNf+81ZTipTevWhywk+t9tNB4cj9FKmxJXL1biZDG4DFUdVDejSzec9MvZOFX7C0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxI+eZHZYToSAxPqKrhCbARjzhGx2pbl+lfoWZqoUqUeTDmYJiB
 +IExj50EwY+kXQ/XxXVwYoSlprv2y5FUd6yLgd+AO+OZhRW9KNZViKTaoUXTNsbUqjf/zKvSmzb
 iJYS4Os7YyPX3pzhphmIFVKjHacCya9i/rE7WHkprsBoRU0/5H8qntg7I1C30krDSvfvym7RXzj
 oJ4sJWkuD122lpwha7YHLCrx43PiiznG0bBaLFHpAFtzxLXA==
X-Gm-Gg: AeBDievPsfLPOztk9RAaqAixiYBiDVWIAyZeAtGQVfKQDzwR/2qaC9BkbpazameJkNO
 ETsvwCEqgRdwmwCPcs7ah2KE11Rj3+C+v6gSNVi5iUaY7NDoIMFvriypU97gwUscjw5e0JOgaY2
 LuiU7thKCKNVOybBHktup8pGmcImZNRix6ib8m23Vho1xIUaT4yNB12QAf+jUiCrO1U8l0O8k3j
 TcPt4Mzu4ZQ15s=
X-Received: by 2002:a17:903:3905:b0:2b0:7e4d:f43f with SMTP id
 d9443c01a7336-2b5f9ffe73amr112669945ad.41.1776654735817; 
 Sun, 19 Apr 2026 20:12:15 -0700 (PDT)
X-Received: by 2002:a17:903:3905:b0:2b0:7e4d:f43f with SMTP id
 d9443c01a7336-2b5f9ffe73amr112669635ad.41.1776654735266; Sun, 19 Apr 2026
 20:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260420023354.1192642-1-syyang@lontium.com>
 <20260420023354.1192642-2-syyang@lontium.com>
In-Reply-To: <20260420023354.1192642-2-syyang@lontium.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 06:12:09 +0300
X-Gm-Features: AQROBzCSFGtiR6FT4_RuPPkrIrQ_huU99l3J_ksJ3m7ehGSiWAi3jzOQFLL_AXU
Message-ID: <CAO9ioeWhWemzyF30t8KDJht6_59b1Y5+GrH9nYCeKuPwddVLHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings:bridge Add LT7911EXC binding
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=J46aKgnS c=1 sm=1 tr=0 ts=69e59990 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8 a=Kz8-B0t5AAAA:8
 a=i0hb4mhT3AluH089dv8A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: 19JbK1_SWyFEM3wKGdKqWWeFYYZskSrm
X-Proofpoint-ORIG-GUID: 19JbK1_SWyFEM3wKGdKqWWeFYYZskSrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDAyNyBTYWx0ZWRfX/G1Tb3AbCeuy
 01qdjkbodFBNa+0yL7Z4ul7tSupCkNlT8pQWqmahRHyDWJw8hgABxuZCH8oMABuYicZxDQ2ls8O
 hm2ZPR+4ij+tR2MIJQp49AP4F6typX2hqHD+o/MptzWbW56XYCNOy4wW4RxnUxOwJGtO2t7W3dh
 EQ4XqNf9fhvQTuOO6fMCD52P4RTe4hOSGtpMvKGMKFsyR+ekx2Sas2MWC6pyWNI+8PYXWnsSnP9
 HXs70YJG1e7hXELnlHDx7nHh1zdROvxEWxnMRaInaIobCsnWINyy3R7o3/ZjV2kUfPMwoCwa4k7
 NaOSbtu/RhWkKf3Z9IAeYLDPwIX/HYZXgYTOdrKLmgMxN+9y5qPz1s4PeKx32RYK6m+J98Ujv4l
 +/y0sDXvRPJ/xmvWBD0g6W7ugY9W6A+SEUeHltOFGFl+QZ3rOoS0Tuj4i3w1KGyDFTPHb9T/HTe
 hvfo8MKKD9ue0bE5ZQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200027
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

ote, your message didn't reach dri-devel. Please check why. You might
need to switch to B4 Web relay submission, if there are any issues
with the SMTP on your side.

On Mon, 20 Apr 2026 at 05:34, <syyang@lontium.com> wrote:
>
> From: Sunyun Yang <syyang@lontium.com>
>
> -binding for lt7911exc.

Less is more, but here please settle for slightly more information
about the chip.

>
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  .../display/bridge/lontium,lt7911exc.yaml     | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
> new file mode 100644
> index 000000000000..54a73d41635a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911exc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lontium LT7911EXC eDP to MIPI Bridge
> +
> +maintainers:
> +  - Sunyun Yang <syyang@lontium.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lontium,lt7911exc
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to RST_ pin.
> +
> +  vdd-supply:
> +    description: Regulator for 1.2V MIPI phy power.
> +
> +  vcc-supply:
> +    description: Regulator for 3.3V IO power.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for mipi dsi output.

MIPI, DSI

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Video port for eDP input.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vdd-supply
> +  - vcc-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mipi-bridge@41 {
> +            compatible = "lontium,lt7911exc";
> +            reg = <0x41>;
> +            reset-gpios = <&gpy8 8 GPIO_ACTIVE_HIGH>;

Reset pins are usually active low.

> +            vdd-supply = <&lt7911exc_1v2>;
> +            vcc-supply = <&lt7911exc_3v3>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    bridge_out: endpoint {
> +                        remote-endpoint = <&panel_in>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +
> +                    bridge_in: endpoint {
> +                        remote-endpoint = <&edp_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };

-- 
With best wishes
Dmitry
