Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39045CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B14410E6B5;
	Mon, 12 Oct 2026 13:45:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FA710E6B5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:45:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 03BC14073B;
 Mon, 12 Oct 2026 13:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820A21F0089B;
 Mon, 12 Oct 2026 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791812716;
 bh=zFahgcdTQO6vKQ8Rz11lc8v3voIpYK0X5AAFMfjO7d8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V4STVeJImHOmnwSI7XYm8VV2IyJnc+WjbRZ+RDN/xR5rrEG52837wiqjN/jmKtbAj
 Q7lTOOkhm6PdF9z/UVAw44LbAc6MoM/0Esp0RxiKDCl9nh7BnWtLEmdmIz3g1DUJ2F
 1Wf8K0TjhCMMsyH0b+ZqxGV1F/ttz7Q+eUVkdgR1TZPjpBrWsiLzqFPtJBpOR2cQPD
 tj/yP0TlfWyOAdiicW6nDXG1+MaY+cVI0mtjxpnbEV5PsjQ0VDhUYLGie22s7ihuPD
 n5mXZMPUkB79OYjsJ4Q3fqyugetEbf7sUHZq96Gd4ZcISt7/1trmRjcyQ/uMpKusuY
 aYGuB1yRvgmtw==
Message-ID: <sashiko-outbox-168208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: display/msm: Document Nord MDSS
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, linux-phy@lists.infradead.org, conor+dt@kernel.org,
 olteanv@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20261012-nord-drv-dt-v2-3-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-3-a2ab9af954d2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:45:16 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing #interrupt-cells in qcom,nord-mdss required=
 list
- [Medium] dt-bindings: display/msm: missing schema for qcom,nord-dpu bypas=
ses validation
--

commit a8ede601ef532b71d1dd3db5e26ddef317404570
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

dt-bindings: display/msm: Document Nord MDSS

Nord has a new MDSS 12.1 revision with DPU 1499A and two independent,
DP-only display interface controllers (no DSI), which no existing
schema describes. Add a dedicated qcom,nord-mdss binding to document.

> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss=
.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
> new file mode 100644
> index 0000000000000..abd80dae4e7f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml

[ ... ]

> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,nord-dpu

[Severity: Medium]
Since additionalProperties is set to true and there is no $ref to a common
DPU schema, won't this allow any arbitrary properties, typos, or invalid
data types in the qcom,nord-dpu child node to silently pass validation?

Is there an external schema for qcom,nord-dpu, or should this node
reference an existing DPU schema to ensure proper dt_binding_check
enforcement?

[ ... ]

> +required:
> +  - compatible

[Severity: Medium]
Since the hardware acts as an interrupt controller (as demonstrated in the
example block with interrupt-controller and #interrupt-cells =3D <1>), does
#interrupt-cells need to be added to this required list?

According to the subsystem guidelines, when a variant adds provider
capabilities like an interrupt controller, the corresponding properties
must appear in the required list with appropriate constraints to prevent
incomplete device tree nodes from bypassing schema validation.

> +
> +unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-nord-drv-d=
t-v2-0-a2ab9af954d2@oss.qualcomm.com?part=3D3
