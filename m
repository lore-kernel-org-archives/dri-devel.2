Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A4210FC445
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 21:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B9910E6E3;
	Wed,  8 Apr 2026 21:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VNtRtYrH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC2210E6E3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 21:33:42 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4723D241;
 Wed,  8 Apr 2026 23:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775683932;
 bh=1PsHHAVlfYudK7174uS0wwaNW8CiA1Xyq+dEBvmz6QQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VNtRtYrHWCMuQAzSAUQPof8hyxmRXRrhoykppZA3vNFc2wRw5D2ChoARk0mO8vWJV
 GbWjXydt62A8w5DvVM5XmIwLBjUGjov9FSJBfZzLdBttGZSExbe4Da3YmM/jb6D2WF
 GkAIKxsORpkcdJEDo/S8Kx3SRnkwR4tqcd3O9k+U=
Date: Thu, 9 Apr 2026 00:33:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] drm: renesas: rz-du: rzg2l_du_encoder: convert to
 of_drm_find_and_get_bridge()
Message-ID: <20260408213339.GM1965119@killaraus.ideasonboard.com>
References: <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-0-421781c8c061@bootlin.com>
 <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-1-421781c8c061@bootlin.com>
 <a3c30888-9818-4355-9d09-5398172cd698@bootlin.com>
 <DHNYGMWPQWLM.3OBWO5G9NPWK5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DHNYGMWPQWLM.3OBWO5G9NPWK5@bootlin.com>
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

On Wed, Apr 08, 2026 at 07:39:03PM +0200, Luca Ceresoli wrote:
> On Wed Apr 8, 2026 at 5:44 PM CEST, Louis Chauvet wrote:
> 
> >> @@ -83,10 +83,21 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
> >>
> >>   		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
> >>   							 DRM_MODE_CONNECTOR_DPI);
> >> -		if (IS_ERR(bridge))
> >> -			return PTR_ERR(bridge);
> >> +		if (IS_ERR(bridge)) {
> >> +			// Inhibit the cleanup action on an ERR_PTR
> >> +			ret = PTR_ERR(bridge);
> >> +			bridge = NULL;
> >> +			return ret;
> >> +		}
> >
> > Can't you use
> > https://elixir.bootlin.com/linux/v6.19.11/source/include/linux/cleanup.h#L230?
> >
> > return PTR_ERR(no_free_ptr(bridge));
> 
> Ah, nice cleanup indeed! However, being this patch already reviewed ans
> tested, I'll postpone this cleanup to a later series.

I think this modification is minor enough to keep the tags.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> > With or without this modification:
> >
> > Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Regards,

Laurent Pinchart
