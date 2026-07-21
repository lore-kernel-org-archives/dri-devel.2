Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351C8C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E0B10E15B;
	Tue, 21 Jul 2026 09:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="AI3np4m1";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2BC10E15B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 09:36:05 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id C96472061E;
 Tue, 21 Jul 2026 11:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784626562;
 bh=LkbTUzJ7Xgd7EcsbWW/V1SykEOd0nQdvevXT30R5Sls=; h=From:To:Subject;
 b=AI3np4m1E64keLXTufUzfthcPErhnjJFYusJRMeMCRhbwgxM3yQt9ljj2GHGr0Cuh
 c1QhN+XiWip8PQXJKyZzBbCTNGeAr3h7gp4sxwF9ZT8zL7yKLUcNOUcZGSxl8AHIlg
 h2+2od8AllziKPWeMiRmQd5xyDpTrWeX7Q4GvMs66w3CbyfUqIrJP+8hm5IdtX4xAB
 lcjMJpMaOA5X4dRLGkMLGNagLWc/Hq8HsEu2b8vGCNn+hgkKzBQkEnMG9tCFC2ztsV
 SWDvaSb6YGCctjBcN2PIlbUd1GRylT0Kny1N63wu0TVFPX6Db8Mq8CHgpndRxhMMp7
 3WQlXLfCapMOw==
Date: Tue, 21 Jul 2026 11:35:57 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/4] drm: mxsfb: Allow optional LCDIF interface format
 override
Message-ID: <20260721093557.GA61843@francesco-nb>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-3-francesco@dolcini.it>
 <bfhx5yyyyqxa6aty4ybdmwp7t7q6kyh5jacotlugf6cyhohmwt@ygi7jioxbyt4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfhx5yyyyqxa6aty4ybdmwp7t7q6kyh5jacotlugf6cyhohmwt@ygi7jioxbyt4>
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

Hello Marco,

On Tue, Jul 21, 2026 at 10:52:37AM +0200, Marco Felsch wrote:
> On 26-07-17, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
> > format reported by the downstream panel or bridge describes the display
> > input, but it does not describe how the LCDIF data pins are physically
> > wired on the board.
> > 
> > These can differ. For example, a 16-bit LCDIF bus can be connected to a
> > 24-bit display by wiring the available color bits to the corresponding
> > display inputs. In that case, using the display's 24-bit format to
> > configure LCDIF selects the wrong data-bus mode and changes the assignment
> > of color bits on the LCD_DATA pins.
> > 
> > Read the optional interface-pix-fmt property from the LCDIF node and use
> > it to select the media bus format used to configure LCDIF. This allows
> > the LCDIF bus mode to describe the physical interface independently of
> > the downstream display format.
> > 
> > When the optional property is absent, continue using the format reported
> > by the downstream display device, preserving the existing behavior.
> > 
> > This follows the same approach already implemented in
> > drivers/gpu/drm/imx/ipuv3/parallel-display.c.
> 
> According the driver comment, this is a legacy property. If you just
> want to limit the physical bus width you could use the common of-graph
> endpoint bus-width property.

Yes, I will change to that. Thanks for the feedback.

Francesco

