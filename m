Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FE8C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB15310E75D;
	Thu, 16 Jul 2026 09:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mciUsrw/";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEFE10E75D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=F6kMKx71nc+0C/6xe+wA+PP8TXOkqAa99DC4sFSlhV8=; b=mciUsrw/S/X4rBkJLp4jcRAw2M
 vGVHwSXT96QuDHTXho+SXOLI8LVbVkm08ONelnPK885a+UW+vPP/lU+9vjx0ym9Zsz14aKwxj91Pk
 e6/MQKemRy0acdapW4DD8IJ03OrAKjWOHYCpMm1OjcJ/uJM4ZaQ2KSWqR713hJ0wN/4cxZT2sZrQz
 TO4uJ3Dj5k1wjnXMp7lPSwVRvA4BqoqEJUkMbd21dQ6B/ftJVGlkx+W3wA+x/IYc9JEygIi8GZLqp
 IxXgJcX0L82X48g/KJGXqudgEOtOY6xioTWbhTCdU+Hi+mmwizr861o/QFmrzxMMbHqh7apO00tz6
 3/vFqqRg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wkISN-000JTs-04; Thu, 16 Jul 2026 11:32:39 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wkISL-000IpU-3A; Thu, 16 Jul 2026 11:32:38 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Gary Bisson <bisson.gary@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Esben Haabendal <esben@geanix.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature
 PLL locking
Date: Thu, 16 Jul 2026 11:32:37 +0200
Message-ID: <3962826.kQq0lBPeGt@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <aleQlpx73a5R8QgR@owl5> <48f6f55f-43fd-4355-88b9-d2e2d0e26d07@kontron.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/28062/Thu Jul 16 08:25:13 2026)
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

Hi,

Am Mittwoch, 15. Juli 2026, 16:14:42 CEST schrieb Frieder Schrempf:
> On 15.07.26 15:52, Gary Bisson wrote:
> > Hi Esben and Luca,
> >=20
> > On Wed, Jul 15, 2026 at 10:52:18AM +0200, Luca Ceresoli wrote:
> >> On Sat, 11 Jul 2026 13:51:15 +0200, Esben Haabendal <esben@geanix.com>=
 wrote:
> >>
> >> Hi Esben,
> >>
> >> +Cc Gary
> >>
> >>> [...]
> >>>
> >>> This is the same issue as addressed in the patch by Gary Bisson [1],
> >>> but changing the ti-sn65dsi83 driver instead, so we don't have to cha=
nge
> >>> all other drivers that could potentially be used with this chip.
> >>>
> >>> [1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gma=
il.com/
> >>
> >> AFAICU your patch would replace Gary's one. Also Gary's patch has been
> >> reported to introduce regressions but it hasn't been reverted yet. Can=
 you
> >> reply to that thread mentioning your patch, so everybody in the discus=
sion
> >> is aware of your alternative proposal?
> >=20
> > Thanks for including me. I just tested this change and reverted my other
> > one (mtk_dsi) and confirm that it works on my Tungsten510 + SN65DSI83 +
> > tm070jdhg30 panel.
> >=20
> > Tested-by: Gary Bisson <bisson.gary@gmail.com>
> >=20
> > Note that the sn65dsi83 driver wasn't changed as I thought the PLL lock
> > in pre-enable was on purpose. It was introduced by Frieder with this
> > commit. Adding him to the thread to weigh in.
> > dd9e329af723 drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet =
spec
>=20
> Thanks for the mention. This was introduced to keep the init order
> according to the datasheet. The DSI host first needs to put the DSI
> lanes into the correct state in its pre_enable(). Then the bridge needs
> to be enabled (including the PLL) in the pre_enable() of the bridge
> driver. Only after that the DSI host is allowed to stream data.
>=20
> Moving the PLL init from pre_enable() to enable() probably violates this
> order. In the past this lead to sporadic issues with some hardware
> setups (depending on the display and the DSI host). Some of this is also
> described in the docs: [1]
>=20
> So from the first glance, I would assume this issue needs to be fixed in
> the DSI host driver.
>=20
> [1]
> https://docs.kernel.org/gpu/drm-kms-helpers.html#mipi-dsi-bridge-operation

This link says
> Ordinarily the downstream bridge DSI peripheral pre_enable will have been
> called before the DSI host. If the DSI peripheral requires LP-11 and/or t=
he
> clock lane to be in HS mode prior to pre_enable, then it can set the
> pre_enable_prev_first flag to request the pre_enable (and post_disable)
> order to be altered to enable the DSI host first.

So IIRC if pre_enable() already requires LP-11 on data and HS on clock,
pre_enable_prev_first should be true then.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


