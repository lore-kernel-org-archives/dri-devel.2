Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F80C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABDC10E17E;
	Sun, 12 Jul 2026 14:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NF6HSxKp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB07A10E17E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:58:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D7CC41452;
 Sun, 12 Jul 2026 14:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474981F000E9;
 Sun, 12 Jul 2026 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783868286;
 bh=cYlrCYAk24mXMLq9q2GfdwKY9UjeWZbbcT39tHA3VgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NF6HSxKpblUsmxb46pVdmmngRPByG+2D5w8fQIWWKziA+oqgrnsCwLSWW7tnZNJtN
 Cv1B60rpWrsJup0ONxK9VM+liWOKr4H0EHBqy23w/4w3JHsM853UB8bnB5as4bhh1a
 07BvC5WvGUbXGHHzpq+zOT8Be1t5MM6BCjQjGlCfC48rSIbRdkyOm90JtEeg/7gUyF
 dB/pnGf+gCdFQjSVHzEdaNTm2JJwsV+495i/ma4GssOjawUEhT+y2jHEjPlXXGEpMC
 yO+gQD5+cvrJZGRr96FFweVZlj8e949xV1sJyokFzOsk6haiShuKSACHoF4m8Ma29Q
 Y/SQBu1vX6JFQ==
Date: Sun, 12 Jul 2026 16:58:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com
Subject: Re: [PATCH 03/10] dt-bindings: display: mediatek: dsi: Document
 MT8189 and MT8196
Message-ID: <20260712-beryl-rooster-of-agreement-cdaee8@quoll>
References: <20260701121950.19454-1-angelogioacchino.delregno@collabora.com>
 <20260701121950.19454-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701121950.19454-4-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:19:43PM +0200, AngeloGioacchino Del Regno wrote:
> Add compatible strings for MT8189 and MT8196 SoCs.
> These are compatible with the DSI IPs found in the MT8188/95 and
> others, but with differences making them not fully compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.yaml      | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

