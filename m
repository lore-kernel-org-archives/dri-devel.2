Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C529CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FDD10E122;
	Wed, 20 May 2026 12:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="qVO0wHRe";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D3810E122
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=opxFNSCMNcLpVtG2W4aJu0gKzFEG2TjT8s3JPH0wd5Q=; b=qVO0wHReoTwaD29llFHGpMuXMJ
 PRPbVN7GAtbeAHMJWQ9UYDHn3I4xmoptHKMhC6kHa+WKBG1wca31gZkqqj5PxrxHTWBofT2p1TvPN
 mfKe9Xli1oaBzWOyK/tPkjz+LGfEjs1GK46mj5+1tVxA5+At7VZnnY+f/F5I4hgkyskkdnKwRWC6B
 sljVM14s5BczSHEm/VYzOnUB0sZQbuAlU/24RLd/BO8ItTAHFUqRdtcBgtYuf2ZBQbFxUzEu+C2tU
 f1J8ll/BI+mOGGN3lEOsiIwnyc5p2saLFWnTgY0M63YwEZCQjevm3PpY7K0npOrrYDBTib2v/Aolo
 y7oWFMaA==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 2/8] drm/bridge: dw-hdmi: Use the common TMDS char rate
 constant
Date: Wed, 20 May 2026 14:59:25 +0200
Message-ID: <3785011.g5d078U9FE@phil>
In-Reply-To: <20260519144712.1418302-3-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-3-javierm@redhat.com>
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

Am Dienstag, 19. Mai 2026, 16:46:58 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Javier Martinez Canillas:
> Replace the driver local HDMI14_MAX_TMDSCLK define with the shared
> constant defined in the <drm/display/drm_hdmi_helper.h> header.
>=20
> The local define incorrectly referenced HDMI 1.4, but the 340 MHz
> maximum TMDS character rate was actually introduced in HDMI 1.3.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



