Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C535C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6914210E464;
	Sun, 13 Sep 2026 23:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtbwsMPs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJCPV+Vv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A8D10EA61
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK04Ys1986787
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8Yheiyhi3WlnjH2Jpbi31UKC
 puZDDkybu8z16cN4/BU=; b=JtbwsMPsJmvf+dZsFgRQcBsixwMCVlMrCEY3J5ca
 q0y0pjULPeXwoZm6Oroee7nNFfYyPr+68ohuacU5QvFbGYxiqvM3JV0DF9KrTMLr
 IY9F4Q7mmneVaEoKmhXO6dYaFokLpHwj0FWy9wtOxZ/MZMfGqBmrlKJF6bRBtUbl
 sBi5rZxM4o5qOAPVPJ4fiQNi26iApO5D2fm3QDHXtczwlJ8T80EbIUjVRFDpQrw9
 wjiRRYj9sr9NunZbXNkhpmToMdfK5YD3ZVnn55eQ3FUKoOY4yTqGfMZGYM91oCE+
 nRo6nbTHk1zOJr6GV0vVp7DHqPjuKAjAt+KXA4RRUkFwOQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9ccafb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:49 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c8337b12d0so821703e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789342309; x=1789947109;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Yheiyhi3WlnjH2Jpbi31UKCpuZDDkybu8z16cN4/BU=;
 b=OJCPV+VvbHbuJZICe+/Rv5EQPHLkX4rWVTDpx1XLiWVagO07BE191Hn7QO4Or/5Hdf
 uRx+l9n7tPHlBAoIgyATp6hfUi5zz9RYdASx6H1liD8iGvhrPLCo6eppaxqvptwK8L+U
 m+lY+dyuq9zTYAwx8TO7uJaisXdCSGI2zO5n3yM2xE91yfJ6tSl5bvGZf99wi0gC0qK0
 m/gKwBNuWy/AQS6VHp6BqJsN9ewANXL+B6eFiTuHcFjLUywBIpOO1iyM5EJB+lS2NBKA
 gESGJQUL+asUucl48RlzOV/7wTHvrduVQlLFH1HPufosbmMunJcv1FbjcFI6JGvsCJ+q
 RT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789342309; x=1789947109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Yheiyhi3WlnjH2Jpbi31UKCpuZDDkybu8z16cN4/BU=;
 b=lRxNQ5RONvzEPB1IY8ZwHyHLBBKSDv76yPtEQCSRY5s9LQZqI2ZHfw+l3mhnOYAdm4
 7zeQpAT2uJ5vl8gNWq06518rg3iCsnUGDvoh4cek+nhJjU+FVVEOodhPuYGc1iS4Pxet
 k0eeCU24ekOKvFV+TgloXRBEoNMEbAUqz1LM3m4dSdkpa0qT6gUrRNdOEhhnIbLI6JCZ
 UwN4yLnXhHuqCimYxKWOr+iJmdiBL7bzKEJtOyXJo1w1yArC8gsB3ws1tOqihq3Fi1kS
 4GzwBcNvYEqNrIhLTufcAIKNEf8pMHZrZRbmJdc9cD9ucUOxOn9Hh9jugcoutkH/aff2
 8AUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIbHcmiiNq7wsVzSGPeXOVj5HC6IeE9Rc9BXtFRFTL06h67oHVNipb9CrTKGKpkRCpQ3bif7iTbo0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mb2Bte3144bwkFtOpMBdn/zUvpuODgJT4P3Mdfrnl9sUSCTtIK
 LuD94DhqYosYxLaYWOZsPwOZGfkYr/KHSgdp0nWIwS7Bfed/ZhwdE36KAr9bzHRyX2zZ35550dt
 5aEt2A6uzJha1NRvJKmbIvj1TqOtriJZ9NtKcpTunos/wYNQvVztdRr4vabAj231yZqJr8U4=
X-Gm-Gg: AYBFou1f2tP/sUjE1qZcoAOAQ4ptbFizJGkPQdrIB0lHN48+IH/ALCyir2S7R0vV+je
 38g40np+dsQyoe+cJUNgqqq0oZo/p4One/8hTwpR4B9+ftzxkjdvXAkChDVGfrKzAf187PU+98Z
 NyRYuOHXv/mqdq2PnI/PT6MAL4TeV9czDCJJGiMNi0AMfrMLQP3w8EmHZ3faasuoXyF9478f7+6
 jX0FTRoN83utd+TlUs8YUMoM0nnnLz7wqM0P2cmNHaANSS7psbfJKjYh0r16rqP0yv3MSJpwyVc
 YrjxvABPoX5WAC3nib547W/SNim/2/5Odz7iCKqRU3Dyx9Mt5KsZwZZsnUhfLv0x5fzn5+Dmgke
 +rMRfbW5FPK8K80swmE1as1exFATii4qPudVMKLU3IcMkcLSejSCro9KHwx9v9NrT1YKGdBJE36
 IAttyilHbLdAgf
X-Received: by 2002:a05:6102:50ab:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-79b56df0dfamr17583137.3.1789342308905; 
 Sun, 13 Sep 2026 16:31:48 -0700 (PDT)
X-Received: by 2002:a05:6102:50ab:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-79b56df0dfamr17547137.3.1789342308261; 
 Sun, 13 Sep 2026 16:31:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a046c5fcsm1989692e87.52.2026.09.13.16.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:31:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:31:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 03/17] dt-bindings: display/msm: Document Nord MDSS
Message-ID: <gfqmo7exo363iyg2q32s7iczl3ctt7yjejtekehbirbkrtmfdl@pui6tpk5c443>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-GUID: fKpJcgYreb9kJYtMrrxJaCh8q9Rl1atB
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa73265 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=jN8BCOdiAmMTBh1ippcA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfXzWzRKQTaNUHd
 FEqMmGo+Wyp8jtlhC86K0XSd+HXaABIqgiCD8Xy/NiAU2zywt4CijJbnH0z0+OlYnTGItVL4ihS
 dkb2/OQhjz9U8+XPwP3vGDFUCURoMEE=
X-Proofpoint-ORIG-GUID: fKpJcgYreb9kJYtMrrxJaCh8q9Rl1atB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX5/+RO1SpFjTC
 LP24gwDZ9zOFT4l5iI/cLUnxZZ6DbkY7+HXe3eSSuZFzwBlJ4vwZic9IXdHH2FOlDALk7jOjYpH
 X4jb7zYoViLwy/oWjKrJB59/bJmktAMKYmZ4V4v6GPcuzrZoaeZL2lhxY7nQu3lrYTYaj/w4Br/
 blSGWa9fJNqJTiAQ5x94ZKW66qbEKo7xhCp8ez+cHxuEIoBlUqOetDAHfE+WPuKw3ApdMHu+dW9
 xsiLbysbH27kJs/NlOLRZwU+vSrtJgDk7y+z8zJT/zoL0MxKqzxtGwb1KFwNjciQTF/J+TcXlqS
 9nUrvfZphUibehG5UaYsR90uxmNotLG2uOm8wXPvxmUod4pNkwFGuzBRtjkDc81N2XoyD6iaCO8
 KweeIalwrEH7B4MUI0jpM8TK5XuiG/sn/ADmpBcIayd/+AEWa38wvYSsjK61ulJYJvBRuM83fMA
 ugjhtjvmAaLIZUyjlLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130337
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

On Fri, Sep 11, 2026 at 09:06:34PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the binding for the display subsystem (MDSS) found on the Qualcomm
> Nord SoC. Nord is MDSS 12.1, DP-only (no DSI), with two independent DP
> controllers.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/qcom,nord-mdss.yaml       | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> new file mode 100644
> index 000000000000..0b0cacdca9db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,nord-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Nord display subsystem (MDSS)
> +
> +maintainers:
> +  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
> +
> +description:
> +  Nord display subsystem consists of MDSS (display controller), DPU 1499A
> +  (display processing unit), and display interface controllers (DP only, no DSI).
> +  This is MDSS 12.1, DP-only, with 2 independent DP controllers.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,nord-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB
> +      - description: Display hf AXI
> +      - description: Display core
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    items:
> +      - description: Interconnect path from mdp0 port to the data bus
> +      - description: Interconnect path from CPU to the reg bus
> +
> +  interconnect-names:
> +    items:
> +      - const: mdp0-mem
> +      - const: cpu-cfg
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dpu
> +
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dp
> +
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dp-phy
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,dispcc-nord.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    display-subsystem@ae00000 {
> +        compatible = "qcom,nord-mdss";
> +        reg = <0x0ae00000 0x1000>;
> +        reg-names = "mdss";
> +        power-domains = <&dispcc_gdsc>;
> +        clocks = <&dispcc DISPCC_MDSS_AHB_CLK>,
> +                 <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc DISPCC_MDSS_MDP_CLK>;
> +        clock-names = "iface", "bus", "core";
> +        resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        iommus = <&apps_smmu 0x800 0x420>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;

No subdevices? Not even a DPU?

> +    };
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
