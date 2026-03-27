Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9848410BA445
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5DA10E402;
	Fri, 27 Mar 2026 08:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="exyRGiEB";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A7410E402
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:34:08 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 347E67CA;
 Fri, 27 Mar 2026 09:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774600367;
 bh=Rmk3YZOfeV80Jfhg4CfzxfdypSaxPXEVhEAPVsjEkUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=exyRGiEBRpJf+51y+H0CSqe6/fPqeCUMrzT2XfyVvvcPEENDkOLBHvzewHFmJO0x+
 VESpApUpUdLHvgmlmgnKKhFU0Bygk9dixMYw9yNhJNLvhmZeOkV99hsa5aN1Lqvu1I
 qiyYKmsDLhTCda1gvAxuj/Njt/d4mWN1Vox5yxUs=
Date: Fri, 27 Mar 2026 10:34:04 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Amin GATTOUT <amin.gattout@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert to of_drm_find_and_get_bridge()
Message-ID: <20260327083404.GA2993961@killaraus.ideasonboard.com>
References: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
 <DHDEL0VTRYDP.2D45EP8E07Y08@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DHDEL0VTRYDP.2D45EP8E07Y08@bootlin.com>
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

Hi Luca,

On Fri, Mar 27, 2026 at 08:57:45AM +0100, Luca Ceresoli wrote:
> On Thu Mar 26, 2026 at 9:10 PM CET, Amin GATTOUT wrote:
> > of_drm_find_bridge() is deprecated.
> > Replace it with of_drm_find_and_get_bridge() which increments
> > the bridge refcount as required.
> 
> Thanks for taking care of the conversion to the new API!

I suspect you may be talking to a machine (possibly through a human
proxy).

> > --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> > +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
> > @@ -72,7 +72,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
> >  		if (IS_ERR(bridge))
> >  			return PTR_ERR(bridge);
> >  	} else {
> > -		bridge = of_drm_find_bridge(enc_node);
> > +		bridge = of_drm_find_and_get_bridge(enc_node);
> 
> This change alone is not correct I'm afraid. The difference between
> of_drm_find_bridge() and of_drm_find_and_get_bridge() is the latter get a
> reference to the bridge, so you have to put that reference when the bridge
> pointer is no more accessible.
> 
> Have a look at previous commits doing the same API replacement, you can
> find examples similar to this one, where:
> 
>  * the bridge pointer is stored in a local variable (not saved in a struct)
>  * the bridge pointer could be set wither by of_drm_find_bridge() or
>    a function adding a panel bridge
> 
> Luca

-- 
Regards,

Laurent Pinchart
