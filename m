Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8CC88E5A
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B241510E51D;
	Sun, 13 Sep 2026 10:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLgZxZ2O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F0510E51D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 10:44:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DFC24483B;
 Sun, 13 Sep 2026 10:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA51F00893;
 Sun, 13 Sep 2026 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789296261;
 bh=+nditHmexPW/lqQ+6UzeYP/gHiOGs4Gndjs9rnADJZE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=OLgZxZ2O8sGhl/Of1OwzeV77kksP/bNeBpBJc6Zpugxgem7Q59jWQMn4UBZq0MaoW
 sOLAjgeT48gkLiHYp2A4mmUhuLtMhskGe12Nbf19nEhg6z2pgmUTh2Nztw4gL8Eq1/
 M77JPDzqYZHSmF7zYeGQ88l/vBO71MN/zTPuBkqWOsH2QjxvI+SjnJfWJuZR9RMACN
 KTP5IUHmirvUQzywEhhN3RkY2J+LF+cNiVHcCx89CWWBpV43Igiznsa629PU87eayl
 qrDZ2OQ1+oV4VLmzlysLsBCD00gM/bQiJYzuoVfSnsDlVMLBVNUQ1JOFLlpMLNBUOQ
 FMpjtNyJiIHfg==
From: Vinod Koul <vkoul@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, p.zabel@pengutronix.de, 
 chunkuang.hu@kernel.org, neil.armstrong@linaro.org, matthias.bgg@gmail.com, 
 granquet@baylibre.com, justin.yeh@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260911074015.9994-1-angelogioacchino.delregno@collabora.com>
References: <20260911074015.9994-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 0/2] MediaTek MT8195 HDMI PHY Fixes
Message-Id: <178929625740.194170.3391606721825248662.b4-ty@kernel.org>
Date: Sun, 13 Sep 2026 16:14:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Fri, 11 Sep 2026 09:40:13 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>  - Fixed commit description of patch [2/2] (Mani)
> 
> This series adds two fixes for the MT8195-class HDMI PHY, found in
> MT8195, MT8188 and Genio variants.
> 
> This is fixing PLL calculation, and TMDS clock dividers, to achieve
> all of the modes requiring data rates higher than 3.4Gbps, with the
> successfully tested target being 3840x2160@60Hz.
> 
> [...]

Applied, thanks!

[1/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc divisor overflow
      commit: de7f29a1fe1dc2864d8a47f8c39d508442cae167
[2/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit ratio setting
      commit: 486a70ef848264dcf9a57f0bb0452848db9537de

Best regards,
-- 
~Vinod


