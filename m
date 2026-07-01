Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B77C44503
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007D810E3AB;
	Wed,  1 Jul 2026 14:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8ZxcfA6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800A810E397
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:23:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 690564402A;
 Wed,  1 Jul 2026 14:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7681F000E9;
 Wed,  1 Jul 2026 14:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782915822;
 bh=4WnOHXZX/INC4S31BQeT/b5fl4DW5lZDfWWLUWbCoEg=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=R8ZxcfA6TySd3kAUAwcju+kRAXeFc27y05xP9WwOeygl9EY0Vsy0LjTjNC+toVYL2
 TjT8znSlLYzwE/uGxxdfhAbLKmKvw4DVfPgQ252n4nWcpz/gTHZSyoLUPEb6L1w5dW
 PpJUJTZ/RZF4K5z0fllaxO6+a8lWx+J2D5+/sFOkhBBmI4EJ6FrBKEU9QrfiA9a/w+
 kKmv8eZiIDnqAIVYuHVQIAwYu+aEyiAV+nYpCSG4rIFNpGNg9qWTGZFim5QXivoYpA
 oYtdCM0Ev6L4jxuiBNIhTxjHS3BqpkHZBd3I5v/wNG7HvDOhNCaCuT+UBO4AzyXGmR
 jocUMMEoMwbqw==
Date: Wed, 01 Jul 2026 09:23:41 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, mripard@kernel.org, devicetree@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, p.zabel@pengutronix.de, 
 krzk+dt@kernel.org, chunkuang.hu@kernel.org, matthias.bgg@gmail.com, 
 tzimmermann@suse.de, airlied@gmail.com, linux-mediatek@lists.infradead.org, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, jason-jh.lin@mediatek.com, 
 justin.yeh@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260701122057.19648-29-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
 <20260701122057.19648-29-angelogioacchino.delregno@collabora.com>
Message-Id: <178291581550.4115656.11254665059124480356.robh@kernel.org>
Subject: Re: [PATCH 28/42] dt-bindings: display: mediatek: Introduce MT8196
 extended DMA Engine
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


On Wed, 01 Jul 2026 14:20:43 +0200, AngeloGioacchino Del Regno wrote:
> Add documentation for the extended DMA Engine (exDMA) IP found in
> the newer generation SoCs like MT8196, MT8894, MT6991, and their
> variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8196-exdma.yaml       | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-exdma.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-exdma.yaml: ignoring, error in schema: properties: compatible
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-exdma.example.dtb: /example-0/dma-controller@32850000: failed to match any schema with compatible: ['mediatek,mt8196-disp-exdma']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701122057.19648-29-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

