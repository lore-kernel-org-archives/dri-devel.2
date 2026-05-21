Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B925CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880FB10E48F;
	Thu, 21 May 2026 09:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="egc7+pmF";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE9B10E48F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=FVUeWlKKpdLIZvOOLJnl3h9BUHCCwQDUhwgZkOAnPCw=; b=egc7+pmFKxo9bXuGpGKaODVu3c
 mInxx6dPQ5IWFQ5XLFIMeAvngzaZwCRkpWjbw4o0Vbr84YasEymd02U5+/aenR1B7qNm1ozn/294+
 7xX9kzv9kJcE1QgREU7dUHnDu+aO5shFIN/vyUl0PAVRh/losQwesRsQF+4Z8vHy79tusnVCe4KCn
 jryUgY8KouDTZAhJKHpRWtlre4uIcYbBog+8gsgAyAH0zF+KjS3b5HDdEYus5x9nhHVjyXT2ZwCqg
 LgPmP1CmSK04D/2jnqNMsSK8JatYzo2bfhiPhdB0Csca4gn1bd7s6ptPPqY/R5DsVhzdkXVMgIc+A
 XeujQ25w==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2 00/11] drm/rockchip: dw_hdmi: Misc cleanup and
 propagate bus format
Date: Thu, 21 May 2026 11:40:48 +0200
Message-ID: <5220966.G96rZvMJ2N@phil>
In-Reply-To: <20260518193748.2482823-1-jonas@kwiboo.se>
References: <20260518193748.2482823-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Montag, 18. Mai 2026, 21:37:34 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Jonas Karlman:
> This series include misc cleanup of the dwhdmi-rockchip driver and
> prepares for future support of YCbCr output and Deep Color modes.
>=20
> Patch 1-7 cleanup and changes to use drmres helpers for the encoder.
> Patch 8 prepare for use of a display-connector bridge for RK3568/RK3566.
> Patch 9-10 prepares for future support of YCbCr and Deep Color modes.
> Patch 11 changes to use resume_early pm ops for system suspend.
>=20
> This series depends on the patch "drm/rockchip: dw_hdmi: avoid direct
> dereference of phy->dev.of_node" [1] from the series "Split Generic PHY
> consumer and provider API" [2].
>=20
> [1] https://lore.kernel.org/linux-phy/20260505100523.1922388-16-vladimir.=
oltean@nxp.com/
> [2] https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.o=
ltean@nxp.com/

With Vladimir's agreement, I've pulled that patch out of the phy-series
and applied it to drm-misc-next - as it's a change that can stand on
its own.

Series:
Tested-by: Heiko Stuebner <heiko@sntech.de> #rk3328



