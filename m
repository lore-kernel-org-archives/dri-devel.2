Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9919C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E1E10E761;
	Mon,  6 Jul 2026 06:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YDyKS0Sa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707C310E761
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:37:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AAFC60018;
 Mon,  6 Jul 2026 06:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA11F00A3A;
 Mon,  6 Jul 2026 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783319852;
 bh=VjcZmBFuXjLsV7sfYoSAPXXZPZioIsyWeSwOGddaHg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YDyKS0SaRDvwlaShaJjV9biNKvr0BeBb2h3WIkgVUVMOtl/pqz7jwholBzal2OxMX
 FJFO0GE0tFw3/VQuPzqDai2SnLB219yrF4noFlP6D6luh0uwUu+TmSh8sTgYmFJly0
 S/KmJOPJe1oDQDBJPrEP6lKy6DMjAWS/XKAxktdISW3zP2sTCIsGevRz1DSwlXWCnp
 A62U9+WLtsCIQ/1RoRqwTojDt0iwpFIFT3kDapWfqoPF9ZWz8nDDWaxeFJcrPgfTIf
 e4sFc8+idj5v1sMgInW8l0tEcSH1fa7qE1vJ/UYlmvIOHzefPNJF4kfD1jKeLXQ+fH
 vWF6kuxUltseQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wgcxN-00000001Y5w-1Pmp;
 Mon, 06 Jul 2026 08:37:29 +0200
Date: Mon, 6 Jul 2026 08:37:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
Message-ID: <aktNKSUuxVYLpqsJ@hovoldconsulting.com>
References: <20260706015507.453222-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706015507.453222-1-lgs201920130244@gmail.com>
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

On Mon, Jul 06, 2026 at 09:55:07AM +0800, Guangshuo Li wrote:
> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
> 
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
> the adapter device reference before the devm action drops it again, and
> it also puts a module reference that was never taken.
> 
> Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
> remove callback. The common devm action releases the adapter device
> reference.
> 
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - Drop the empty remove callback, as suggested by Johan Hovold.
>   - Mention that i2c_put_adapter() also drops a module reference that was
>     never taken.
>   - Fix the Fixes tag.
>   - Add Cc stable.

Please remember to CC reviewers:

Reviewed-by: Johan Hovold <johan@kernel.org>
