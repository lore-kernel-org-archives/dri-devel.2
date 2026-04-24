Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8540DFE521F
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922C310F437;
	Fri, 24 Apr 2026 12:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vdcj+rsS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385AB10F437
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:31:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E17D6012A;
 Fri, 24 Apr 2026 12:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D19C2BCB7;
 Fri, 24 Apr 2026 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777033916;
 bh=GK9+WQJM6GBNOao/w4LCrjLyab9AiYr/M0fE61fgAJM=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=Vdcj+rsSglufIK1l5d/RKfQmIk9HLv2UFu/VkLvzs2kJBUkM35zJAhIqTVx+Cb4UL
 J3jsgCrSAVzi02XOP6INESfEUdH2gsb6zD6s6n9Pqba7Cudhr+hTrQECmlGohg+V7i
 jFWlo8aRFzutXiKjLwyHxsp1CY/v2iUnhjsEbK8izKZT8rR1LUfsYR9vLLDNgxXStV
 mQku5XO+NGJkc/nKtrVvKe3Nxhxqc/7h7csVYIO0pb1JW90Qr0zQ1m0qpV4miUTqcf
 4OtPj8ssr7JYLD6O2uuvAkL5AqDBgWM6SFIkDeH8BNa7sbt72cWU/NFzOKANErELoW
 HaCKwbLGg6vlQ==
Date: Fri, 24 Apr 2026 07:31:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simona Vetter <simona@ffwll.ch>, 
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>, 
 imx@lists.linux.dev, linux@ew.tq-group.com, devicetree@vger.kernel.org, 
 linux-phy@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Robert Foss <rfoss@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ying Liu <victor.liu@nxp.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 David Airlie <airlied@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com>
Message-Id: <177703391401.3671402.9330071570952735700.robh@kernel.org>
Subject: Re: [PATCH v22 3/8] dt-bindings: display: bridge: Add Cadence MHDP8501
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


On Fri, 24 Apr 2026 11:07:16 +0000, Laurentiu Palcu wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp8501.yaml     | 135 +++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml: Unresolvable reference: /schemas/phy/fsl,imx8mq-hdptx-phy.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.example.dtb: display-bridge@32c00000 (fsl,imx8mq-mhdp8501): phy: False schema does not allow {'compatible': ['fsl,imx8mq-hdptx-phy'], '#phy-cells': 0, 'clocks': [[4294967295], [4294967295, 248]], 'clock-names': ['ref', 'apb'], 'phandle': 2}
	from schema $id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml
Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.example.dtb: /example-0/display-bridge@32c00000/phy: failed to match any schema with compatible: ['fsl,imx8mq-hdptx-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260424-dcss-hdmi-upstreaming-v22-3-30a28f89298d@oss.nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

