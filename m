Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3278FC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC2910E464;
	Wed, 22 Jul 2026 15:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bsjF49+n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20B710E464
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:45:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC188600AB;
 Wed, 22 Jul 2026 15:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0DB1F000E9;
 Wed, 22 Jul 2026 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784735103;
 bh=/OsIhPpVYT3n9diLVUiR7498vs3ZnyRvw7xjAByzCgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bsjF49+nysB5MqTTiGuxAQwzjtDFeEXvEIeCB6m6+CUqR0A4ru9FDJnUOaO+B2oWX
 CXKTsoDKJpLBZqdvHYPZKXFivbA9Evrf0q16oC30RCW2bWRo3xgJ+o/sgzpeqJxFC6
 zeA6A8HTmsLYWxeTsgohoG59Jyh0Zzfhcvlq5eTYrGNktN2q2HnZXiY1RqqTbo4rOz
 pGGrI/YEV2oPbWC3at+oO0C/RmKf99VgeV4n6lhbl7wvASpXOmx/N8pIs24iVVDifV
 pbmV4IyCdHwB2eCKbaUF3kM0fdzeWs7JX3SAGiBkMiyV5z9PBSCTdpp6JsflIU2QJC
 z/Qee/jv9Ki+w==
Date: Wed, 22 Jul 2026 10:45:00 -0500
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
Subject: Re: [PATCH v2 12/46] dt-bindings: soc: mediatek: mutex: Allow
 #trigger-source-cells
Message-ID: <20260722154500.GA988735-robh@kernel.org>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 14, 2026 at 01:43:40PM +0200, AngeloGioacchino Del Regno wrote:
> This hardware controls trigger sources, and there's even a generic
> binding just for that: allow #trigger-source-cells in MuteX, so
> that this is allowed to provide triggers to external HW.
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

You ack-ed your own patch?

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index 5267cfe92572..886e6f904b78 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -54,6 +54,9 @@ properties:
>      items:
>        - description: MUTEX Clock
>  
> +  '#trigger-source-cells':
> +    const: 1
> +
>    mediatek,gce-events:
>      description:
>        The event id which is mapping to the specific hardware event signal
> @@ -116,6 +119,7 @@ examples:
>              interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
>              power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
>              clocks = <&mmsys CLK_MM_MUTEX_32K>;
> +            #trigger-source-cells = <1>;
>              mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
>                                    <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
>          };
> -- 
> 2.54.0
> 
