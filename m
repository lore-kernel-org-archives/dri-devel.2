Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080D4C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690CA10ED7E;
	Tue, 14 Jul 2026 14:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CHtrnOnW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E8D10ED7E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C348743612;
 Tue, 14 Jul 2026 14:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848591F000E9;
 Tue, 14 Jul 2026 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784039674;
 bh=EwNVTon+/nbjRpzwjhhjH2A7QsMv/Rt06oFZ3UT6FIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CHtrnOnW5stVfjfg02P3Kk3ImhP5f3aFDPiEpGg6wdMgZ/9LXy0mTkI/lSmvI8Bgt
 xKuMEw2BY1JQ9HgU/AfzfHhwYqrV2ATAE2ixtJSv2E83srd2sFcJiRsYQ/nUBOM5nm
 w8S3vB5vdcGKxe5jrQgeg/IUqs0r/tBaUdl6WZ3Car+jDA5rOYOfYOxTQI+F08O/aG
 sOenvtzBEEyvzW37bXxTsBV+Vx/Z7As0lmA90UCQnEL3RIz7KldYtPma9E37lNt9eH
 wbSoy0aJ4DYRQ9XuTxgKcOOtAowJrenvQ+CiR/ezRgldOVVw3gfJPIBuET81HqDMpi
 +Nr7MZgJ4rbHw==
Date: Tue, 14 Jul 2026 09:34:33 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add
 compatibles for more SoCs
Message-ID: <20260714143433.GA1476641-robh@kernel.org>
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-10-angelogioacchino.delregno@collabora.com>
 <20260713144221.2C4F91F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713144221.2C4F91F00A3A@smtp.kernel.org>
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

On Mon, Jul 13, 2026 at 02:42:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The compatible string `mediatek,mt6893-disp-wdma` is incorrectly added to the standalone enum instead of the fallback items list.
> --
> 
> --- Patch [9]: [PATCH v4 09/10] dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs ---
> commit 8001f83833ae9c684be67bc719c7aaa056f90763
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs
> 
> Multiple MediaTek SoCs have the Write DMA hardware in their Display
> Controller. This commit adds the missing compatibles for Dimensity 1200
> (MT6893) and for Kompanio 500/520/820/1200.
> 
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> > index 97d052b0fb614..c3ed867d058d9 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> > @@ -22,11 +22,16 @@ properties:
> >    compatible:
> >      oneOf:
> >        - enum:
> > +          - mediatek,mt6893-disp-wdma
> 
> [Severity: Medium]
> Does this incorrectly place mediatek,mt6893-disp-wdma as a standalone
> compatible string rather than in the items list requiring a fallback?
> 
> If a device tree uses compatible = "mediatek,mt6893-disp-wdma" to satisfy
> this schema, the DRM driver will not probe the device since it only matches
> mediatek,mt8173-disp-wdma. If the developer instead provides the fallback 
> compatible = "mediatek,mt6893-disp-wdma", "mediatek,mt8173-disp-wdma" so the
> driver can probe it, won't the device tree fail schema validation here?

Sashiko fails to look at patch 10. However, the commit message gives no 
clue whether mt6893 is or is not compatible with something else. If not 
compatible, explain why it isn't. What's different?

Rob
