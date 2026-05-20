Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB16CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFC310E702;
	Wed, 20 May 2026 13:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="seeAHkXc";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EDF10E132
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=jWvPtMXBC6V+sabMNNPJgMaYJQgiL74yyRrCn7qKa1A=; b=seeAHkXcoPB5vUNlthUqldH2XP
 D4WDyOt3foxW3mavM/9n3kKaZt1G+/6gdIa9lZseyh/qNJcQinacTyHR1dyWyjVxsIFbU8x/jrhFy
 eHrKYKhO2iMtvkSTGqlQGuYXv1yh2z+3ZjHHdxWrkwal0j/qziQXRiUySD02v593NkKzSrhIrjzdz
 0ZdJCi0JXXsLP9/ccix6zOD3Dp25EplfH6bXGjpLuxjqLQCoAqQw3i41SUMxFKni11TuYk6HLDhHG
 4LJZIrGj1tbwAovELijw/pb1Ke5R2Cy6/XoBhSdR8roPYXVmYjVZmfhmr2prxZVAFNvK5pF9w4iLq
 YgSP1Orw==;
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 4/8] drm/bridge: inno-hdmi: Use the common TMDS char rate
 constant
Date: Wed, 20 May 2026 15:00:05 +0200
Message-ID: <30961091.gRfpFWEtPU@phil>
In-Reply-To: <20260519144712.1418302-5-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-5-javierm@redhat.com>
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

Am Dienstag, 19. Mai 2026, 16:47:00 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Javier Martinez Canillas:
> Replace the driver local INNO_HDMI_MIN_TMDS_CLOCK define with the shared
> constant defined in the <drm/display/drm_hdmi_helper.h> header.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


