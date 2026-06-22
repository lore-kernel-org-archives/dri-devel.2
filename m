Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11413CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCAB10E648;
	Mon, 22 Jun 2026 11:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="bBbeDaqQ";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9067010E648
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:34:16 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 5CFEF1F8CC;
 Mon, 22 Jun 2026 13:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1782128053;
 bh=eU1CoCMG5+/cLZ/UUrYyeG0yuMtWepq4vudYMIZfk6o=; h=From:To:Subject;
 b=bBbeDaqQdNUlsDO+VAdHsleL79m8jaW4jArmZgwaY7pS+kbltWapwb+0q7nfR3x6l
 JIcH674lp+kbulHf/Z34rd7VpYAdj0t0MqZAYa8BduM5Smnllni0qE42zmE0lbRuQf
 KaVdYD5X+0kjbIAS4AIGP9i+heamxyFHXMc2bCk++o/8IchXIWIxgU1S8eQLysonSz
 Dgg51X8Hatf+m2+TesJoaDtFfY5/YJfmjouRlUMU435wyjIb/9N3oFVKzi2IAfpOBA
 Ia8TtGAe0kgz1yytd2/uIVG8/wGOXZxV3kM9Y3K9TnTqoBm5cgMMX8p0oMU3AGCpBw
 Tx/g96HYMjT9w==
Date: Mon, 22 Jun 2026 13:34:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH 09/37] drm/bridge: lontium-lt8912b: Switch to atomic
 bridge callbacks
Message-ID: <20260622113409.GA54984@francesco-nb>
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-9-b63e6316166b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-9-b63e6316166b@kernel.org>
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

On Wed, Jun 17, 2026 at 12:14:34PM +0200, Maxime Ripard wrote:
> The lontium-lt8912b bridge still uses the deprecated non-atomic bridge
> callbacks.
> 
> Switch to their atomic counterparts, adding the bridge state
> handlers if not already present.

...

> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62

