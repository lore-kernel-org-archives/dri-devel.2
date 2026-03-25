Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A6FEA82F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3083F10E817;
	Wed, 25 Mar 2026 08:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U6WxswBz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3887C10E817
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:18:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E54824191E;
 Wed, 25 Mar 2026 08:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D309C4CEF7;
 Wed, 25 Mar 2026 08:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774426738;
 bh=l5hbhBxK0vQal/zDiyjexDnCisT8vaZyQAqn5AAN1d0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U6WxswBz1yLsbEY+xondEzkTMuDm0moXJREF1w7n//W18yp3UzKPmamuortP7Bb2s
 Lwbw4Zar1SbgCbhaV513HhOQya6II4lAEeN2qqIVbYU89mb8+oY4BO6vHsMsIofAqq
 aLcksX0bJsdbdiY5HfJChnDmiws+ri4Nsbvm0VwoY1GOMM4DQyRHH8TpWkzqn4K0ZB
 2ZuH/OsYouMq+RSJEKfZU/Ka+ncgHrTQ1PNA7McshNnYxWjotELQayE9FZ2Oo+SNsh
 yjJTw+hLvnwsVaKYJMAojm5Tz9uwKraD2YX+o9Ol4hC6MQfv40bSOiYwmRQOHY+hWT
 xhYIvvqPnfJFg==
Date: Wed, 25 Mar 2026 09:18:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] dt-bindings: display: mediatek: disp-tdshp: Add
 support for MT8196
Message-ID: <20260325-cautious-giraffe-of-serenity-b55d8f@quoll>
References: <20260324125315.4715-1-jay.liu@mediatek.com>
 <20260324125315.4715-5-jay.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324125315.4715-5-jay.liu@mediatek.com>
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

On Tue, Mar 24, 2026 at 08:52:01PM +0800, Jay Liu wrote:
> Add disp-tdshp hardware description for MediaTek MT8196 SoC
> 
> Signed-off-by: Jay Liu <jay.liu@mediatek.com>
> ---
>  .../display/mediatek/mediatek,disp-tdshp.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml

I don't see improvements.

Considering how vague your changelog is and you only implemented coding
style, not review comments, then NAK.

Implement everything I asked for.

Best regards,
Krzysztof

