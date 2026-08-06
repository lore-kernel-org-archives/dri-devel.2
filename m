Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF080C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D036810E2C8;
	Thu,  6 Aug 2026 09:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="QdGNE368";
	dkim-atps=neutral
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD0C10E2C8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1786008026; x=1786267226;
 bh=7a3VV9lwK+MTSqR1GdSr0rlEZ+9otPy2YiitnCc8ANQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QdGNE368hwR/hP/HDeQ5vbxJPYmbUD0Sbaby/BqzAObKwg478QgWSEESrexAopuaj
 TJVY6fKZQeDNvU6uKw2nfvk3gNP6Z70FoeXh5vKUSltyZKfld639E9ol31iPr2Li45
 gCv5+W5ihdsJv+kFacMj3hekeNcvc8lnv4hTcqfgMmbDUPRT/iqvjZ1mUk5pmnvpbN
 BHNzFzSl4wWN86f+bIizJhOgKwqNoM82Bdv3JCf/8pSVlkP/FvGWAQrVs1bjLG5yn5
 CleFSYyqUdGsrQ0tpeY5/EgjqE5j2QJ8TTQQi22cfqw21htp9OpgNxijV9/stD5wQ8
 GbSYi6Izr7RAA==
Date: Thu, 06 Aug 2026 09:20:21 +0000
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
From: Esben Haabendal <esben@geanix.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Message-ID: <3Y_9pnIakLQ3Fl6gSoSuzmAaCNAVAGLerd8onBuurYCUufSvuv4UpgxsHF2E8TqXulUAAw35fkz1cIowgEMGspX4sB-YKrZkGRIzOdzfYXY=@geanix.com>
In-Reply-To: <DKHQML180X88.1FWP1KUMGYDUS@bootlin.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <DKHQML180X88.1FWP1KUMGYDUS@bootlin.com>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: fb765353ce0c2fc3093c95aa500e86303963d022
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thursday, August 6th, 2026 at 11:02, Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:

> On Mon Aug 3, 2026 at 4:57 PM CEST, Esben Haabendal wrote:
> > This small series adds support for using SN65DSI84 in single-link mode =
with
> > output to LVDS channel B, and provides a fix for a PLL locking issue.
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>=20
> With the planned changes (Fixes/Cc:stable tags, patches 1-2 swapped)
> applied you can send v4 with:
>=20
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks. I have made one additional change for v4 though.

As pointed out by sashiko-bot, I fixed a problem where we would end up with
an unbalanced irq enable counter if/when sn65dsi83_reset_pipe() failed.

And as I am introducing the possibility of sn65dsi_reset_pipe() actually
returning an error, this bug would be a regression introduced by this serie=
s
without this additional fix.

/Esben
