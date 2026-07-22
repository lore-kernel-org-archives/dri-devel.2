Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2191AC44532
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EF210E4A4;
	Wed, 22 Jul 2026 16:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="faYKN4WM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E21210E4A4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 16:42:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43A0641664;
 Wed, 22 Jul 2026 16:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24611F00A3A;
 Wed, 22 Jul 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784738532;
 bh=+FhwspSsIo41xwcPLmC+dyiiLCiUUuaWQEh6t7ru9uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=faYKN4WMeaW3u8R+K0FNqrlYG74xfnPBt5Hjvn29tszXyM1h4abxhZYq5klf9EB2C
 6Y8T/Y0b8rMJ3QdO2FQ4M6qOaQjXgGf59vA10nCHkEPRZ5Z947tPOW8ROluPW4KFLg
 YhzgBR7t4Nces/bDK+hM1LIWwe7O55QzCtWZE/J0Sx0P0zF6FRJUX6jHbomhit85PC
 CjtG2Rb3cffCJTt3as2g36MiFn6+DnwtbF3tb7xIQaIczYWJGTSBYmYhXgAW92IhRZ
 VKE6rG299/L753DHfepHuINHL9SFY+SSmC3GFUPVUvYH3K7LygIXC9H25Svx/5s8Sm
 52nHtydab+0JQ==
Date: Wed, 22 Jul 2026 11:42:10 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH v2 30/46] dt-bindings: display: mediatek: Introduce
 MT8196 Layer Blender
Message-ID: <20260722164210.GA1075204-robh@kernel.org>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-31-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114414.184512-31-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 14, 2026 at 01:43:58PM +0200, AngeloGioacchino Del Regno wrote:
> Add documentation for the Overlay Layer Blender IP found in the
> newer generation SoCs like MT8196, MT8894, MT6991, and their
> variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8196-blender.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-blender.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-blender.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-blender.yaml
> new file mode 100644
> index 000000000000..402eccb5fd70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-blender.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-blender.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Display Overlay Layer Blender
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The MediaTek Display Overlay Layer Blender hardware is responsible
> +  for performing the alpha blending operation for overlapping layers
> +  from various sources.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8196-disp-blender
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port

You must have descriptions of what each port is.

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port

