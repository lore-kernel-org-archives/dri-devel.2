Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660F1FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:00:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD9410E09F;
	Mon, 27 Apr 2026 11:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="V4zLCz3Z";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E3810E09F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=4XRJaWFbqSFsmBGRLBmlvpPymX1vBXalsYhJharnm3k=; b=V4zLCz3ZLjDozLT4o/LAggRxW+
 /7tTwM/7AIduZZExmA/N0ISPGIhudlvQr8OIZLfqqpl3dZzFBMZO1+CHO4S8/p8hIQThRYm7H+6Kw
 qUkz/RARTegoCwhvGlEh1G2dMvmMhgeaxaOhhWF1lOqflCgkHilvK6JFcoBJJcc6z7QZTy5pHVYxG
 W9MKn34IY0Srn89vDSGxcQR1sfCsVcWFb3In1Ti8EhUxZReRvvRM0/7nKkCmR621tabBfYgWvbiql
 WQsl/2EmAYv0jtLQJdv8PT+fJNaOnJl8mfbz3nHEmX1FbNG529k3mzs/2eOoeE1awhg2afR8w/mLW
 oKv+HpAA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 02/10] drm/bridge: Add detect_ctx hook and
 drm_bridge_detect_ctx() helper
Date: Mon, 27 Apr 2026 13:00:35 +0200
Message-ID: <11399494.CDJkKcVGEf@phil>
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-2-d778e70c317b@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-2-d778e70c317b@collabora.com>
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

Am Sonntag, 26. April 2026, 02:20:14 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Cristian Ciocaltea:
> Add an atomic-aware .detect_ctx() callback to drm_bridge_funcs and a
> drm_bridge_detect_ctx() helper that accepts an optional
> drm_modeset_acquire_ctx.
>=20
> This enables bridge drivers to perform operations requiring modeset
> locking during connector detection, such as SCDC management for HDMI
> 2.0.  When both ->detect_ctx and ->detect are defined, the former takes
> precedence.  When ctx is NULL, locking is managed internally with EDEADLK
> retry.
>=20
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

while this looks sane to me, my drm insights are spotty, so I can
only provide the lighter

Acked-by: Heiko Stuebner <heiko@sntech.de>


