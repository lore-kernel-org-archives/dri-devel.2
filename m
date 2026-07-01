Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98520C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90FAF10E3D5;
	Wed,  1 Jul 2026 14:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CW81gr08";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E4310E3A9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69FBB4172F;
 Wed,  1 Jul 2026 14:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288F71F00AC4;
 Wed,  1 Jul 2026 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782915824;
 bh=L+MQqoMdTb10quuKjj21cquQc2SQagarqLqHoeQ9/rY=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=CW81gr08/6J3xgLYZqeMUjS5S8MAX27dufuEN6oZM/k/TED4PyD+vkkGZ5DmD5J1E
 uZ49HNe3o4iDB9XKWBlELTolRsUaDMTt2jKlaHfXCFlZT/INQEHZXNozYwNlQsQZe4
 JvKjXqzgOt0iq62BIusGQ+anmtq8f3FxDStbZNW5HbIHEIeOuqjUgZ4bgqauiZa3MD
 9gWB9X1JR8kU37EUKr08+s4nmL363X43JW/sB2tjC3MQINmycor97RpJFo1oGicYB/
 Zt0jNTBcVsnBh+bhF4RTtFBQTau7XUnFQlnezMZwBZDt7ryWbew0RO/wyYBoNrQkzH
 bdtra1G8tBtPA==
Date: Wed, 01 Jul 2026 09:23:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, chunkuang.hu@kernel.org, 
 matthias.bgg@gmail.com, mripard@kernel.org, jason-jh.lin@mediatek.com, 
 kernel@collabora.com, devicetree@vger.kernel.org, justin.yeh@mediatek.com, 
 simona@ffwll.ch, p.zabel@pengutronix.de, tzimmermann@suse.de, 
 conor+dt@kernel.org, airlied@gmail.com, maarten.lankhorst@linux.intel.com, 
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-39-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-39-angelogioacchino.delregno@collabora.com>
Message-Id: <178291581802.4116105.6915436352274822148.robh@kernel.org>
Subject: Re: [PATCH 38/42] dt-bindings: display: mediatek: Introduce MT8196
 2D Sharpness Processor
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


On Wed, 01 Jul 2026 14:20:53 +0200, AngeloGioacchino Del Regno wrote:
> Add documentation for the Two-Dimension Sharpness Processor, or
> "TDSHP", found in many MediaTek SoCs including MT8196 and its
> variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8196-tdshp.yaml       | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.example.dtb: /example-0/tdshp@321e0000: failed to match any schema with compatible: ['mediatek,mt8196-disp-tdshp']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701122057.19648-39-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

