Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40490C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 15:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EED10E30C;
	Sat, 11 Jul 2026 15:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RogktxIt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE44710E30C
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 15:08:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D347660052;
 Sat, 11 Jul 2026 15:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C2F1F000E9;
 Sat, 11 Jul 2026 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783782492;
 bh=m35O9uD/U+TaQ848Y04SAAFcQbtyJ5oGcy3AMnA+LCM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RogktxIt1oUimSNaB2eJ/JBshJZ6HswdELFaAY6mRo5VtRBA/1zIn0NHfYbFlvIYU
 M4WsYVO+2jR8QPbpk8703X4cr8YImO3/UUWKPfjiPcd6rtyZDjlvcFxEg6hgJJVUlu
 vDJweMWJC007cT5r06hSgpIfYJpxhRk03UePx02tzusX9ZYcE0qCSS+CMtOCUYpDDA
 Bx27+bhosBrBkShgSzHTZiGwUaoljoN8R98iifTzUVpFVEJNyqQZa7QaNKIYKxgoCG
 TMD2sic22TDce/JT0kHNLi7Ni0XzQ+LyPGpfH/EwHn/R4xMW/kjDBJBsk1hEpzvhJP
 WuKkKlUTj5bIQ==
Date: Sat, 11 Jul 2026 17:08:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, granquet@baylibre.com, 
 rex-bc.chen@mediatek.com, dmitry.osipenko@collabora.com, ck.hu@mediatek.com, 
 amergnat@baylibre.com, justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v4 01/12] dt-bindings: display: mediatek: dp: Deprecate
 nvmem efuse data
Message-ID: <20260711-heavy-neat-armadillo-c0f493@quoll>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709113148.49090-2-angelogioacchino.delregno@collabora.com>
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

On Thu, Jul 09, 2026 at 01:31:37PM +0200, AngeloGioacchino Del Regno wrote:
> Deprecate nvmem-cells and nvmem-cell-names and clarify their
> purpose, as those are for PHY calibration data, not for the DP
> IP itself, and that data shall go in the PHY binding instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dp.yaml     | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

That phy binding should be posted somewhere and maybe even squashed
here, so we do not end up with deprecated property alone.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

