Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5C7C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 13:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B673910FA8F;
	Fri, 25 Sep 2026 13:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GSoaOEXq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360E810FA8F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:24:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DAE660230;
 Fri, 25 Sep 2026 13:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1A11F000FF;
 Fri, 25 Sep 2026 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790342690;
 bh=JcvwxJfj+wQCvTyKCuDmOvkUWIndsvAdclXPqwL6QjM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GSoaOEXqNZo5+lFu4BWpMyM+JE4KVsAWFxigirREnjn9EsPKMGSXqy6zl+1JRw4dm
 3U0v1lVUBRas/uYlViba9t+pwZ7GuOvS/CJJXOpFmu1sberKqQygJmySBYCf3ycyp4
 WvXUDgAxGmgJLJYcldjLPV2k9kmJsPLnVrhrQE5Rgxx1pd1IXH2Ld4PbCi05X3sEMk
 z7+1KJsjNpR9btN0PPFvJBbcDgR8JadJYt+p7Lus/nPk+0oR55RlDDn0uG8WYtWyj8
 o6VxOCBheopmhNVFgCDB/Jgjw8GuX14GXG+SzVRHn/ShaPfg2sA9qGq8yuX3XzRRBd
 tHA2EHtPG0A8A==
Date: Fri, 25 Sep 2026 15:24:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: mediatek: dpi: Add
 compatible for mt8167
Message-ID: <20260925-inventive-crystal-firefly-0deffe@quoll>
References: <20260921113914.779393-1-l.scorcia@gmail.com>
 <20260921113914.779393-2-l.scorcia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921113914.779393-2-l.scorcia@gmail.com>
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

On Mon, Sep 21, 2026 at 01:38:55PM +0200, Luca Leonardo Scorcia wrote:
> MediaTek mt8167 SoC has two Digital Parallel Interface (DPI) blocks,
> one can be routed to a DPI display while the other is wired to the HDMI
> block. They are not compatible with any other device, so add a new
> compatible to describe them in the device tree.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

