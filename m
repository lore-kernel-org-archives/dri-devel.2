Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CEFC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B4AE10EDFE;
	Tue, 14 Jul 2026 15:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="0PmzAdpN";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B5910EDFE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=zLaxl7OxlxMFCnSPhkyE01FY6akqGQYk1tPfRA+r0DA=; t=1784044506; x=1785254106; 
 b=0PmzAdpNH+22fn+aS8PP2y0877DBe1KFaTy+rJBDTqdypFMyIbsaCIru4vq6i8ajcBiCInr10wI
 wzM2mI9uTgoBc2c9KjUlNsvnoveWF3ZocdkNlDKt/KjyToFtoXvzppUdAg9xD4qEbcKQnetLBvIPE
 Tav5W6bDnJES/aBkZUiegCV6PjRL+7X9l3yfc5pjf1t110wYLHXrlZPsDVtIRDFs8FYkRpdfLZGgy
 aeUET0lvnlqBc1ynA9ffYRqB78lGbLNT5Z9lvrLqzIH5FtuqdGYGLgvLugseYqxk9jqRVNA8X/OXw
 9ih5SaWIUPZ+bBxhSziGoFF+cdBIX5kQ2RgQ==;
Date: Tue, 14 Jul 2026 17:53:37 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260714175337.4ad430fc@akphone>
In-Reply-To: <24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
 <20260707122203.0bbc973e@kemnade.info>
 <24368e1c-171f-4f6b-80f8-58accab1d3be@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; aarch64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 12 Jul 2026 22:07:53 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > b/drivers/gpu/drm/omapdrm/dss/dsi.c index
> > 3f22929c36e2..eb3cd0d23cae 100644 ---
> > a/drivers/gpu/drm/omapdrm/dss/dsi.c +++
> > b/drivers/gpu/drm/omapdrm/dss/dsi.c @@ -3267,7 +3267,7 @@ static
> > int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
> >   	 * updates stop working. This is probably related to DSI
> > spec stating
> >   	 * that the DSI host should transition to LP at least
> > once per frame. */
> > -	r = dsi_vc_send_bta_sync(dssdev, vc);
> > +	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
> >   	if (r < 0) {
> >   		DSSWARN("failed to send bta sync between frames:
> > %d\n", r); goto err;
> > 
> > 
> > 
> > Then the call is equal to the original one done via send_nnop.
> >   
> 
> With that change it seems to work properly, will keep that version of 
> the driver for the time being.

will send a v5 with this change included

Regards,
Andreas
