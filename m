Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE21C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEABF10E858;
	Mon,  6 Jul 2026 09:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EqGfpZzk";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B13110E858
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:48:05 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EAFAA9CE;
 Mon,  6 Jul 2026 11:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783331235;
 bh=EuqCo/QlvrI79+V1pXPimVKOgUhKcGwqk8VWf/R9Nsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EqGfpZzkrVId0m5JwkQwo267E/t4tcJfTTo6P5SwLPQiChvw7E9fj82HmtFcKSoIc
 RMS9TKlQTp7ZDwTypnHelQg+mT/aNPx5rzc+Vmx4NunZjb5X3kg3LswrYJ995w1VGU
 o5rv8FkW8rND5ZuL4ac4n35MkVrkcM2Nau9FzU0E=
Date: Mon, 6 Jul 2026 12:48:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 4/4] [DNI] arm64: dts: renesas: salvator: Add overlay for
 Dell P1911 VGA display
Message-ID: <20260706094801.GB42740@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVtK2qKHLWfyWYaPx1cYgmF0jtzh3CAPrJ4QbZ0VxypXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVtK2qKHLWfyWYaPx1cYgmF0jtzh3CAPrJ4QbZ0VxypXA@mail.gmail.com>
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

On Mon, Jul 06, 2026 at 10:16:22AM +0200, Geert Uytterhoeven wrote:
> On Sun, 5 Jul 2026 at 23:35, Laurent Pinchart wrote:
> > Add an overlay that hardcodes the EDID of the Dell P1911 VGA display
> > connector to the VGA port of the Salvator board. This is meant to test
> > EDID hardcoding and should not be merged upstream.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/salvator-vga-dell-p1911.dtso
> 
> I know this is not meant to be applied, but nothing below is
> Salvator-specific (except for the comment).  Hence this can be applied
> to any "vga" connector, and I'd rather drop the "salvator-"-prefix
> from the file name.

Sure, but it won't be merged :-)

> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree overlay for the Dell P1911 monitor connected to VGA port of a
> > + * Salvator-X or Salvator-XS board
> > + *
> > + * Copyright 2026 Ideas on Board Oy
> > + */
> > +
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +&{/vga} {
> > +       edid = [00 ff ff ff ff ff ff 00 10 ac 74 a0 55 4b 55 30
> > +               2b 14 01 03 80 29 1a 78 ee ee 95 a3 54 4c 99 26
> > +               0f 50 54 bf ef 80 95 00 71 4f 81 80 95 0f 81 00
> > +               01 01 01 01 01 01 9a 29 a0 d0 51 84 22 30 50 98
> > +               36 00 98 ff 10 00 00 1c 00 00 00 ff 00 31 57 4b
> > +               4a 56 30 41 4b 30 55 4b 55 0a 00 00 00 fc 00 44
> > +               45 4c 4c 20 50 31 39 31 31 0a 20 20 00 00 00 fd
> > +               00 38 4b 1e 53 0e 00 0a 20 20 20 20 20 20 00 ba];
> > +};

-- 
Regards,

Laurent Pinchart
