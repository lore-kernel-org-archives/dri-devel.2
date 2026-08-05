Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B2C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D8910ED59;
	Wed,  5 Aug 2026 07:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="rvs9mQ47";
	dkim-atps=neutral
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5301E10ED59
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785916618; x=1786175818;
 bh=UqoBD0Cqi+4OW0duE/0WFx5/iF38b6ct0CIrOG2fTIo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rvs9mQ47vD2eZBdwC3UTU1ZmTym6+/v4RsOy+OVzyasBFFX1x2tAWW+WyseWUa/Hi
 xC5/XRYa2UmU5MgU4KWzLX/7RFzsM166CMoJKlqjYQFf0cBo2lTCkpkUmxifk5fDET
 b13ilwOFhReOBqY2iJTE7gpBflkrJFgbwQYb6aWtE0FFV22ZGQJf391yOLclWg03JG
 pRfjgSonyNLmfZPvyK7sF8JiTy0gMjjKize+b5ZPJOWAIQhgsyKOvPErSGEgxT14ER
 NrnSGdrUvtBxplHg4yqx0nKR10+8Z+DzfEpZnKFQHuPbnACW9885DnFawK6pana/hK
 GuluQBLwM7dAg==
Date: Wed, 05 Aug 2026 07:56:51 +0000
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
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Message-ID: <nidXxvSX5VG1kylWXmxh0v-9A4q58Ab-3vQyR3MOXyQXkGP9w6cf5bgAbdBtIFQ7neRR8a1f2i-C_92rm86cBcE1eUb9DvfH0T8YqTy3nlY=@geanix.com>
In-Reply-To: <178591600766.274551.9164227801232973400.b4-review@b4>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
 <178591600766.274551.9164227801232973400.b4-review@b4>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: a0e4d879edf7187c27fcb399c305cbba888e84fe
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

On Wednesday, August 5th, 2026 at 09:47, Luca Ceresoli <luca.ceresoli@bootl=
in.com> wrote:

> On Mon, 03 Aug 2026 16:57:03 +0200, Esben Haabendal <esben@geanix.com> wr=
ote:
>=20
> Hi Esben,
>=20
> > Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> > callers has a chance to handle the failure.
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
>=20
> Thanks for the improved patches!
>=20
> Patches 1-2 look like big fixes, so they need a Fixes tag along with 'Cc:
> stable'.

Added for v4.

> Other than that they look OK to me.

/Esben
