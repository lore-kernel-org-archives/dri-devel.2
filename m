Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2A606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=AZknOMeO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86EA10FBB5;
	Wed, 28 Oct 2026 11:42:12 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F83410FBB2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:42:06 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EF3A4F1;
 Wed, 28 Oct 2026 12:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793187592;
 bh=Rsw2IDjWS22qxc49wx+UxcDu6FoabmR4PaoHgFRbUhI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AZknOMeOj+3yO8Q00UR3u69hCTdB7OXi4xmSamQpnyRDdok74NZGOQup/vXPVWaju
 fcZtuqO7zNTRBRDrddUYkBVcbgc88T5WGRUSjYXvlF/Pxw5mlPNEU7atW59XuiW4h2
 qmjbURehHXOLGZnJo3Yx6YMFmVywEosKpqHsfmhY=
Message-ID: <1d50c475-9ab4-47de-b62d-0610454c9d42@ideasonboard.com>
Date: Wed, 28 Oct 2026 13:42:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] drm/bridge: tc358762: Various small fixes
To: dri-devel@lists.freedesktop.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Marek Vasut <marex@denx.de>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andreas Kemnade <andreas@kemnade.info>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Ping for reviews or tested-bys.

  Tomi

On 15/10/2026 14:15, Tomi Valkeinen wrote:
> While trying to get Raspberry Pi display v1.1 working on Beagleboard
> platforms, I noticed various small issues with the tc358762 driver.
> 
> The series also contains a patch to fix the timings in the
> powertip,ph800480t013-idf02 panel. The combination of tc358762 +
> ph800480t013 is used in the Raspberry Pi display module, so it makes
> sense to fix them together.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v5:
> - Rebase on v7.3-rc7 to remove a minor patch context conflict
> - Link to v4: https://patch.msgid.link/20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com
> 
> Changes in v4:
> - Rebased on latest upstream, fixing the minor compilation issues that it
>    brought
> - Added R-b tags
> - Link to v3: https://lore.kernel.org/r/20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com
> 
> Changes in v3:
> - Add missing #include <linux/bitfield.h>
> - New patch: "drm/panel-simple: Fix powertip,ph800480t013-idf02 timings"
> - Link to v2: https://lore.kernel.org/r/20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com
> 
> Changes in v2:
> - Always enable VTG. There should be no downside, and it fixes unstable
>    hsync
> - Add four new patches at the end
> - Extend the patch desc in "Drop SPICMR write" a bit
> - Link to v1: https://lore.kernel.org/r/20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com
> 
> ---
> Tomi Valkeinen (13):
>        drm/bridge: tc358762: Clean up register defines
>        drm/bridge: tc358762: Improve SYSCTRL register defines
>        drm/bridge: tc358762: Improve LCDCTRL defines
>        drm/bridge: tc358762: Configure SYSCTRL first
>        drm/bridge: tc358762: Drop SPICMR write
>        drm/bridge: tc358762: Improve DPI enable handling
>        drm/bridge: tc358762: Update comment about the number of lanes
>        drm/bridge: tc358762: Support VTG
>        drm/bridge: tc358762: Fix sync polarities
>        drm/bridge: tc358762: Move tc358762_init() into tc358762_enable()
>        drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
>        drm/bridge: tc358762: Set DE_POL and DCLK_POL properly
>        drm/panel-simple: Fix powertip,ph800480t013-idf02 timings
> 
>   drivers/gpu/drm/bridge/tc358762.c    | 203 +++++++++++++++++++++++------------
>   drivers/gpu/drm/panel/panel-simple.c |  14 +--
>   2 files changed, 144 insertions(+), 73 deletions(-)
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20260326-tc358762-fixes-6f666500da9e
> 
> Best regards,
> --
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 

