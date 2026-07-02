Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718C8C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C4410F1CF;
	Thu,  2 Jul 2026 07:53:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="env7wj8w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13CA10F1CF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:53:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 250AE60120;
 Thu,  2 Jul 2026 07:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A267B1F000E9;
 Thu,  2 Jul 2026 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782978779;
 bh=RggIXQChyrd9PGRMbf+vMro4+L7wE747ABQYOAEiDL0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=env7wj8wcJfIuCtiqo2vta7nC186527y80FragjdAc/RxQ5ScaDRP4J4T3DllIWsE
 y/oCXXrMyyA10nC8qPxYSwd9jLj272kw1s9l2jnzrnuCSuw9xezvcyfbUTosfMLlrt
 S0RLngLUyu20SuO6o4/xwJ1cmZzVnqkogmrOauVjic58rC30njyzut0demB8x2BXFK
 J1t65ElN9x8747Pzzi0vsBEeTaC/dP3bearigkZWFXVZ/G1n9vct3IIDoW5etiX7B6
 sS1h3pACCRoAzYaNqxDHEiq5ouMcX7h+rD6WjrFR+K2TVYP+60La/bQVogr1LPx8bX
 uucpi7VH4ZLIw==
Date: Thu, 2 Jul 2026 09:52:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, matthias.bgg@gmail.com,
 andi.shyti@kernel.org, djakov@kernel.org, broonie@kernel.org,
 jitao.shi@mediatek.com, 
 ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH 1/6] dt-bindings: soc: mediatek: mutex: Improve title and
 description
Message-ID: <20260702-congenial-honest-platypus-39d90a@quoll>
References: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
 <20260701122043.19612-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701122043.19612-2-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:20:38PM +0200, AngeloGioacchino Del Regno wrote:
> Improve both the title and the description of this hardware to
> disambiguate its functionality from a hardware mutex and/or from
> a hwspinlock.
> 
> Though in datasheets this is called "DISP_MUTEX", the meaning is
> is "Mute-X" (where "X" means "any hardware trigger signal") really
> as this is what this piece of hardware does: muting or unmuting of
> signals in each sub-IP of the display or other multimedia related
> controllers.
> 
> Based on that, also clarify the description text, as to make sure
> that the information is actually accurate.
> 
> While at it, also avoid forcing literal blocks in the description
> as there is nothing in there needing that (no ascii graph or other
> stuff that needs a literal block anyway), and add myself in the
> list of maintainers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/soc/mediatek/mediatek,mutex.yaml   | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

