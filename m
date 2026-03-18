Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA8103E164
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A17310E7F6;
	Wed, 18 Mar 2026 11:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qaLRF/EP";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 277AE10E7F6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:13:46 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id CE007460;
 Wed, 18 Mar 2026 12:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773832352;
 bh=kezOWi+Y/xWmOoKYVNDub0JBhGMIjj8YtFSMTo7i91o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qaLRF/EPead4EDfD8PzWORi3ykRZS0QfFOkhU/AagZWdbC7q/xjxh9cUcSEcAyfGJ
 DvVR5EYhy0d3cqSfvJlElYqU1oJNSRC/Fy4WBP785kYoKclaWyfuerHS7EQskuFHZ+
 9veEtORAOru2tbcaIEFuCrH6Joc317yQrbIxRWvA=
Date: Wed, 18 Mar 2026 13:13:43 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "tomi.valkeinen" <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 1/4] drm: rcar-du: Ensure correct suspend/resume ordering
 with VSP
Message-ID: <20260318111343.GF408929@killaraus.ideasonboard.com>
References: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260317231930.595719-2-laurent.pinchart+renesas@ideasonboard.com>
 <TY3PR01MB11346D728D12D6330033B1E46864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346D728D12D6330033B1E46864EA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On Wed, Mar 18, 2026 at 10:32:53AM +0000, Biju Das wrote:
> On 17 March 2026 23:19, Laurent Pinchart wrote:
> > 
> > The VSP serves as an interface to memory and a compositor to the DU. It therefore needs to be
> > suspended after and resumed before the DU, to be properly stopped and restarted in a controlled
> > fashion driven by the DU driver. This currently works by chance. Avoid relying on luck by enforcing
> > the correct suspend/resume ordering with device links.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> 
> FYI, made similar changes on rz-du and confirm S2ram and s2idle works fine on RZ/G3L.

Thank you for testing, I'm happy it fixed your issue.

> > ---
> >  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 16 ++++++++++++++++  drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_vsp.h |  2 ++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_vsp.c
> > index 94c22d2db197..a4a49dcd8233 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> > @@ -20,6 +20,7 @@
> >  #include <drm/drm_vblank.h>
> > 
> >  #include <linux/bitops.h>
> > +#include <linux/device.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > @@ -458,6 +459,9 @@ static void rcar_du_vsp_cleanup(struct drm_device *dev, void *res)
> > 
> >  	kfree(vsp->planes);
> > 
> > +	if (vsp->link)
> > +		device_link_del(vsp->link);
> > +
> >  	put_device(vsp->vsp);
> >  }
> > 
> > @@ -482,6 +486,18 @@ int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
> >  	if (ret < 0)
> >  		return ret;
> > 
> > +	/*
> > +	 * Enforce suspend/resume ordering between the DU (consumer) and the
> > +	 * VSP (supplier). The DU will be suspended before and resume after the
> > +	 * VSP.
> > +	 */
> > +	vsp->link = device_link_add(rcdu->dev, vsp->vsp, DL_FLAG_STATELESS);
> > +	if (!vsp->link) {
> > +		dev_err(rcdu->dev, "Failed to create device link to VSP %s\n",
> > +			dev_name(vsp->vsp));
> > +		return -EINVAL;
> > +	}
> > +
> >  	ret = vsp1_du_init(vsp->vsp);
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h b/drivers/gpu/drm/renesas/rcar-
> > du/rcar_du_vsp.h
> > index 67630f0b6599..a6731249db34 100644
> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
> > @@ -12,6 +12,7 @@
> > 
> >  #include <drm/drm_plane.h>
> > 
> > +struct device_link;
> >  struct drm_framebuffer;
> >  struct rcar_du_format_info;
> >  struct rcar_du_vsp;
> > @@ -26,6 +27,7 @@ struct rcar_du_vsp_plane {  struct rcar_du_vsp {
> >  	unsigned int index;
> >  	struct device *vsp;
> > +	struct device_link *link;
> >  	struct rcar_du_device *dev;
> >  	struct rcar_du_vsp_plane *planes;
> >  	unsigned int num_planes;

-- 
Regards,

Laurent Pinchart
