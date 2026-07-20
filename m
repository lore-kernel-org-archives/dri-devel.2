Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AA8C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C4410E8BF;
	Mon, 20 Jul 2026 11:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BDrGf7Nz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A34F10E8BF
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:43:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56F24403F5;
 Mon, 20 Jul 2026 11:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8181F00A3E;
 Mon, 20 Jul 2026 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784547815;
 bh=kgEbuRaZ7fC8I4l3wHHvaMm3ff8vOKykqDqNHrxX4ow=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=BDrGf7NzG0L0sB92Cx3an0HY1ia4T3Hj7SKz4jZfVtUVZKNaE0lMcuzwpN3POvU+y
 QW/1xfdjtYXcXfpfoizjUartFQ5DITdV9VV4RzKBfW6+RmwdEqwpw19lk6lxTBjwpA
 OVdlzEOOHgbjPIbNgnUS3mBUcpmxuT5xpU1+zf17X/0Nu+Fp+2G7PS+MCjp7dXAOtw
 XQd3v8cy/BdrIgrYxKeL5S29+gSDF+Fzbmu0AGMofTzCfibJI4EUXSVlIbMfs+cN1N
 zpkR13ypArj3x2L/8tCe3SWBDgIB8mB2dJJUcYcuUNULhtOAtKNb2W1ofEqS7sRVU0
 qRLKSqctmGPHw==
From: Vinod Koul <vkoul@kernel.org>
To: chunfeng.yun@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
 matthias.bgg@gmail.com, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com
In-Reply-To: <20260713103805.23030-1-angelogioacchino.delregno@collabora.com>
References: <20260713103805.23030-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 0/2] PHY: Add support for MT8196 DSI PHY
Message-Id: <178454780918.1388616.17680006872088012294.b4-ty@kernel.org>
Date: Mon, 20 Jul 2026 17:13:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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


On Mon, 13 Jul 2026 12:38:03 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v3:
>  - Actually sent the correct patch series (sorry, I had messed up v2)
>  - Added definitions for minimum and maximum PLL rates
> 
> Changes in v2:
>  - Added a few comments and fix scheduling while atomic issue in clk
>    enable ops by waiting with udelay() instead
>  - Removed one unnecessary delay after clk/pwr isolation disablement
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: mediatek,dsi-phy: Add support for MT8196
      commit: 215cd5def8eca1c2aa7ca043483d96155a1c3ed6
[2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
      commit: 2ec9c210c1f931389709aee403d28e4f32676385

Best regards,
-- 
~Vinod


