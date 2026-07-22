Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60706C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB1510EE37;
	Wed, 22 Jul 2026 15:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MMd3LIqc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BC8310EE37
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:46:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8774600E1;
 Wed, 22 Jul 2026 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6441F000E9;
 Wed, 22 Jul 2026 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784735205;
 bh=9nrjiIeKKD8Gx6LukkoYpq5DLz0jKwg7ibNVwWPKONQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MMd3LIqcR9eZc08C538x3+vfewjPoQD2Qh9Ks9jWUsdIvoSkXiEcgeMbCrm/mLL6g
 /y3tFXjyeKsvNh2+/M3r3v/npHcsMw9iPfoz+dCINnf7WMY+/vX8DvSybuwgsAMMdW
 MiDTAb4BjGFMEhzWFt1Kcp5JIKiX6tK3fliwydFMNWnbIQzdbzf+e6gDyZNFa+FA1A
 f/f3rbl+kC7LPbxlP4IYTL5jjZR0nVrY6C/W/lwkUSsQFL+3OsQ57+zh1Yvgypwn+Y
 dbDsxYRO+GW7+iDKSbGMuB9OqEreq1tVARDyVOVhFrPO5H1FrIv+1cSES4tguFhBAk
 DAiebRoRyc+Sg==
Date: Wed, 22 Jul 2026 10:46:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, simona@ffwll.ch, jason-jh.lin@mediatek.com,
 linux-arm-kernel@lists.infradead.org, airlied@gmail.com,
 kernel@collabora.com, p.zabel@pengutronix.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, mripard@kernel.org,
 dri-devel@lists.freedesktop.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 justin.yeh@mediatek.com, tzimmermann@suse.de,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 12/46] dt-bindings: soc: mediatek: mutex: Allow
 #trigger-source-cells
Message-ID: <178473520265.995028.6530833938909188983.robh@kernel.org>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714114414.184512-13-angelogioacchino.delregno@collabora.com>
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


On Tue, 14 Jul 2026 13:43:40 +0200, AngeloGioacchino Del Regno wrote:
> This hardware controls trigger sources, and there's even a generic
> binding just for that: allow #trigger-source-cells in MuteX, so
> that this is allowed to provide triggers to external HW.
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

