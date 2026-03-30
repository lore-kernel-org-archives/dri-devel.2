Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9E51061B1F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF6710E7CD;
	Mon, 30 Mar 2026 19:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r4yk2xlZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A971610E7BE;
 Mon, 30 Mar 2026 19:57:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 42679429EE;
 Mon, 30 Mar 2026 19:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E5DC4CEF7;
 Mon, 30 Mar 2026 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774900667;
 bh=c3qtZ+kKZI4i+gpQJZtVZwl68vlayAF2E4m619qBxgM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r4yk2xlZAtlADeoHgNHcU+kzLd42R0+Asa+b4+A1R4WZEFcwb/hgfs4K/3XzpNWKu
 TTPRNch1QeM8Qd5eUxboM5o+KJsxAWW3lkEOE6tC8Cwwbz/YPk8kZUgAzn2HYDxgB2
 Uy2J4RDxmQfFf04ufKIvTN74P0ddfNckTnIZ0HI0JMQYMEHN6u08mN7e/hmeNy0J8S
 nkeH311ovwyVEOsL/OHDRSV6x4W7tZefsBcEbtsFv8sAnRVOL/58/U3dEfaz6F5BZm
 Ip4kDRGIlNWV1D/Y5TNMr2Bdnc10ZTYVTUVWnN/1Iu6hAh8Pa9elMtrE+jZDOVmwDl
 9ZfBC8/xatqMg==
Date: Mon, 30 Mar 2026 14:57:44 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/9] dt-bindings: display: msm: document the Milos
 Mobile Display Subsystem
Message-ID: <20260330195744.GA3196688-robh@kernel.org>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
 <20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com>
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

On Fri, Mar 27, 2026 at 05:12:23PM +0100, Luca Weiss wrote:
> Document the Mobile Display Subsystem (MDSS) on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/display/msm/qcom,milos-mdss.yaml      | 283 +++++++++++++++++++++
>  1 file changed, 283 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
> new file mode 100644
> index 000000000000..0fb66b4b2742
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
> @@ -0,0 +1,283 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,milos-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Milos Display MDSS
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description:
> +  Milos MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
> +  DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,milos-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB
> +      - description: Display hf AXI
> +      - description: Display core
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
> +        const: qcom,milos-dpu
> +
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,milos-dp
> +
> +  "^dsi@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,milos-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl

Use 'contains' and drop qcom,mdss-dsi-ctrl. Don't need to define the 
exact list of compatibles here. The full schema does that.

Rob
