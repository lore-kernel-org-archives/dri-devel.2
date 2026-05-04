Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10197CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 21:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E1410E089;
	Mon,  4 May 2026 21:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NjnrJfQP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F9310E089
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 21:42:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 86E7640AC1;
 Mon,  4 May 2026 21:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F107C2BCB9;
 Mon,  4 May 2026 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777930937;
 bh=2Kn+VQS1xL6KW9gjkVCLV6SPW/vQgPHfS3gY0L9jnLI=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=NjnrJfQPokVseDYqHGLboEZ1IPPAg88lxhWgdqCPLhNgJqCiYT7EUWR0kEPI6W3yw
 jgrJMswFC3LIHdFKX0AVoMAm7Yg3rjEAoGwjYvOxYbW78uddk3OObBLOSM0F+KxHxl
 FI+PeAqF7UFURlnuUjcmKu5JC00lFWd4tP07UkfIZ82ta/Y1VbUCYaq3/UtVHNZDVv
 eYHowwvUxfXlkmpvqkcw3SSTDT9WXlFiJKhL7MKb25nAT1C8GVjNw7XQ3lioZGLySY
 yUb7Dgk2EByZZIga9pNjZVd0VS80+0XtWvNu5KBhKisgXsxh+aQ9glHPOzygRauRGU
 yXIg9BvHQKDaQ==
Date: Mon, 04 May 2026 16:42:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 laurentiu.palcu@oss.nxp.com, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, victor.liu@nxp.com, 
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@pengutronix.de
To: Marco Felsch <m.felsch@pengutronix.de>
In-Reply-To: <20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de>
References: <20260504-v7-1-topic-ldb-fixes-v1-0-0125d937ff7f@pengutronix.de>
 <20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de>
Message-Id: <177793093475.108918.8253046049656563262.robh@kernel.org>
Subject: Re: [PATCH 2/4] Revert "dt-bindings: display: bridge: ldb: Fill in
 reg property"
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


On Mon, 04 May 2026 22:21:42 +0200, Marco Felsch wrote:
> This reverts commit 16c8d76abe83d75b578d72ee22d25a52c764e14a.
> 
> Remove the 'reg' and 'reg-names' property from the LDB.
> 
> The LDB is either part of the IOMUX_GPR (i.MX6SX) or the BLKCTRL
> (i.MX8MP, i.MX93) register space. Both IOMUX_GPR and BLKCTRL are
> register ranges with loose register definitions. E.g.
> 
>   - On the i.MX8MP there is one register which controls the AXI
>     threshold for two different IPs (BIT(31:16) - IP1, BIT(15:0) - IP2).
>   - On the i.MX6SX IOMUXC_GPR5 controlls: CSI2 mux, WDOG3 settings, PXP
>     handshake, ...
> 
> In conclusion: it can't be ensured that one register belongs to one
> dedicated IP and the LDB is rather an exception than the rule.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/display/bridge/fsl,ldb.yaml       | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.example.dtb: blk-ctrl@32ec0000 (fsl,imx8mp-media-blk-ctrl): bridge@5c: 'reg', 'reg-names' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.example.dtb: blk-ctrl@32ec0000 (fsl,imx8mp-media-blk-ctrl): bridge@5c: Unevaluated properties are not allowed ('reg', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.example.dtb: bridge@5c (fsl,imx8mp-ldb): 'reg', 'reg-names' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/bridge/fsl,ldb.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260504-v7-1-topic-ldb-fixes-v1-2-0125d937ff7f@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

