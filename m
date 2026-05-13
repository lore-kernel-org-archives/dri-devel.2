Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954D9CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AC510E5B4;
	Wed, 13 May 2026 19:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ctcRFAXl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF8010E5B4
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:03:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CFC3B42A4E;
 Wed, 13 May 2026 19:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAC4C2BCB7;
 Wed, 13 May 2026 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778698987;
 bh=EFHyCV5Fzy8lGU/TCEK6Y6BJe4DrIl8NrL1B869ZVsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ctcRFAXlqMutmFA6F/+gFzVfl4BL8HfCR1MZmVwUsvKfoeiFexzmU7e1ULgorBHya
 vOLibPt5AAjx/H/IiEvnLBN4/MRP6qEXdju7mbASCoQG2VFpTzbQPodE9xSeO4Ibmi
 OjSh0jm8fpxd27hlo7GYc/70GZoq4kHyvTQSvICc6OecO//a3aFKpRj0zRtuKUfltq
 icI3GYe1TuVDTqSHtBAXEYbn5X8IqgboNkbpxwfBK6R/JVsIjQrK4mp/48wJ4KaC/e
 nF4op8QaKdOdjN2NfAFFTEolmxUzGFTRbN76BNpSboJthpTYkOr/YllfGpNZtDD0bK
 5OnkVEJXgJ2Ig==
Date: Wed, 13 May 2026 14:03:04 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2] media: dt-bindings: mediatek: Constrain iommus
Message-ID: <20260513190304.GA1677938-robh@kernel.org>
References: <20250821065900.17430-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821065900.17430-2-krzysztof.kozlowski@linaro.org>
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

On Thu, Aug 21, 2025 at 08:59:01AM +0200, Krzysztof Kozlowski wrote:
> Lists should have fixed constraints, because binding must be specific in
> respect to hardware.  Add missing constraints to number of iommus in
> Mediatek media devices and remove completely redundant and obvious
> description.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Ack
> 2. Mention dropping description
> ---
>  .../bindings/display/mediatek/mediatek,ovl-2l.yaml           | 5 ++---
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml   | 5 ++---
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml  | 4 +---
>  .../devicetree/bindings/display/mediatek/mediatek,wdma.yaml  | 4 +---
>  4 files changed, 6 insertions(+), 12 deletions(-)

Applied, thanks.

Rob
