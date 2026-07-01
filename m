Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D3C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EE410E596;
	Wed,  1 Jul 2026 14:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ePjixhTP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB2F310E596
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:38:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A65742E2A;
 Wed,  1 Jul 2026 14:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC81F000E9;
 Wed,  1 Jul 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782916731;
 bh=DoAPIKHlQF01BQdUW983/8p5nb/vO5Fh5kJQWUG/dxQ=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=ePjixhTP3XZgrzhZdeHkU+VCPkYuzgpl2DzTg6EuV5D7zoGrCxE0H4loNSi3lbqPB
 MNpNB+p5gzVEaG47iCyZ4SXEN3tuV4PQXnjqaJqWIoWDU+CZVLWoKOQAqOeyVREenz
 0znKSxkVXVcTPQm9s0hgMVON/QEjwg6v+AEr+0fusTrOfe/Uxlg61jXskQP/77qw5R
 4MD7BSMdgHs0ENBjVjyKjrkouPznJtTI3qYypogcwNTr1a+0ZAzLGizfVYHGO5NT/G
 mKHNPd3iTm80lkGSARlqEXZSJoWXuynP0L5f9lodG2UxDokboZhdPa57EWFTKPbzU3
 0jk3Ld++wS1Ww==
Date: Wed, 01 Jul 2026 09:38:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, 
 p.zabel@pengutronix.de, linux-mediatek@lists.infradead.org, 
 vkoul@kernel.org, chunfeng.yun@mediatek.com, linux-phy@lists.infradead.org, 
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, justin.yeh@mediatek.com, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, chunkuang.hu@kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122008.19509-2-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-2-angelogioacchino.delregno@collabora.com>
Message-Id: <178291673047.19807.6106947084460440701.robh@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: phy: Document MT8195 and MT8196
 DisplayPort PHYs
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


On Wed, 01 Jul 2026 14:19:57 +0200, AngeloGioacchino Del Regno wrote:
> This adds bindings for the DisplayPort and Embedded DisplayPort
> PHYs found in the MediaTek MT8195 SoC (and variants of) and for
> the Embedded DisplayPort found in the MT8196 SoC (and variants).
> 
> This PHY supports varying impedance calibrations for the various
> signals to reach an optimal EYE signal pattern for any specific
> board(s), especially useful for very high bitrates such as HBR3
> and higher, depending on board design.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/phy/mediatek,mt8195-dp-phy.yaml  | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.example.dtb: phy@1c500000 (mediatek,mt8195-dp-phy): reg: [[0, 475004928], [0, 8192]] is too long
	from schema $id: http://devicetree.org/schemas/phy/mediatek,mt8195-dp-phy.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701122008.19509-2-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

