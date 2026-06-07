Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBCCCD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 11:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FD489266;
	Sun,  7 Jun 2026 11:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="R0UOy+QW";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20EC89266
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=hvmoiqjOQVbFviJTTLxFf9UohtoI+0J4703merDW6PA=; b=R0UOy+QWsNdnDRzocdebEgam5X
 3zDCaOOTjDKaobICL/EDvz290uost3oEE/D4ZOv+LGlqfEGlUkw8IRpe9asIuO2K1MKExhUxv0y5e
 SX9bdTk8ChBdRM/59sFyGRRlkk/nsI3ncxv1D6nFSbzXXUD1sS0FO20E0cQZRPtf2MLc8qQ0AD84k
 vVnzhN8q2bDKhlJ7YkjQb0BtdhukpY7+8DU09U6Q4ipbiuv51jVowmwU1YQicFY1vA/XabD4l92r/
 NaGgBajU2uYy6YtYXyaHcX0XeOGOB8o/ilx44KV75XBWFKz3bbe8gsEFTrefPIuId75EYh/seF0NM
 vKdB6wNw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Diogo Silva <diogompaissilva@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Diogo Silva <diogompaissilva@gmail.com>
Subject: Re: [PATCH] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
Date: Sun, 07 Jun 2026 13:00:15 +0200
Message-ID: <5449269.L4jQFfv3LO@phil>
In-Reply-To: <5277524.h16uAIiOU7@phil>
References: <20260604123224.192543-2-diogompaissilva@gmail.com>
 <5277524.h16uAIiOU7@phil>
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

Am Sonntag, 7. Juni 2026, 12:59:00 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Heiko Stuebner:
> Hi Diego,

sorry for mangling your name, Diogo.


Heiko


