Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55BEE85367
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A61E10E462;
	Fri,  3 Apr 2026 14:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HcoDspUZ";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909FA10E462
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 14:55:18 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so1171407f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775228117; x=1775832917; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BnyXm/MMCgxKZfV/FUPCVYB+a80rSW6pzmRtAw3BM9w=;
 b=HcoDspUZ1Ql6eyFrMlKvcjAtMsdOSbGiCCu88AEOUQSWSlV0PC57/aTOBFuPTk4WYA
 cA8CwtIZbD0w4V5iKlc++QaOqWD3bydNZ0ZFg2FVxwXR35LyxjkqwhTQ0kIvqYqjr4LN
 uIB76xxqJWW+afxn6IaKzKToTKcdXL9QJaORcUmCIHyWuqGfSrmDvTj7Jhh1Eh0CHcTw
 lSfh5xd+/dN3ZM2VOm1WhRBmLxyIWZXRqko4Hk/r9Ne+fIlD8sb0hHf5TV/AI+vuCUEI
 MFlu7dkE+N49GyLY+Sme1wbscwBU8PUpDkWvEvonfQ0Cq6r6PYTyMoyHoUlCTrTu64vH
 DNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775228117; x=1775832917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnyXm/MMCgxKZfV/FUPCVYB+a80rSW6pzmRtAw3BM9w=;
 b=V3CSZL0pm3qoDnRB8J1AZ6Wd7k5fnqiXVMSLSyldz1xIM2KkywMwBKpNMO0m6QvbRq
 QresNJXDe6rfGFAon0b5syaaLbwbfSC9LuZVKeQnmgVPtwH55XefzXhOBlurP3FNXCI9
 o6nh8iXwcL3nOqeiRBIRbKR+9eWWFKsEjeuHXM6e5QbfxskHVNeFHyu3WVVFsBwdqFSC
 wEdc7L+TtNOj7Quq51T+8t73nfgQBZLOTP8MNodM2OS7Wf8pEeibBvLAevnpjSDCHDmd
 Jpp9zstEDPoNUgzf3sYeHW2bIc+2TzFuFXcPUGnRPbJLcbJUhD4Bck8Q5wOjq0Gl/MId
 Yxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHEuky+sPc8wuew9UHqQ2H1Zetc77Y14XFbfLyJVq05vwYJMpYGhZh++X8Pcf/DLRiCZOv/b1Lwc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ5IHtKttNTGPZxmXqoSpLLIAREKMY/6S45FzUJyz7prlP9b0d
 8XJQ4yA/gFvTIl4POCkkWOpJ/62YNBsZWEfvl18paniD1kbRltoyB1Nw
X-Gm-Gg: AeBDiet01rRbND3KgTzWwznhSwMulLexZL9U5bMnHm4iw5ubu8dGcu1iMfssDMBPI7/
 sRt1NRXG8jDWcS+FNp2phRjPJF8wDGrRRWPVIGbpXRGw2RqNKczQ2sSIYKFERDNG0mbPVnhu4Jb
 8/YulRBOxLt1SsFjdqBRDs4T/qIFxsPBY44sMwziFRqEhpfYAjJWp+4Qo0nBMLmgZAYVPMw9Zmy
 QpG0BRx/exemGeTa7D928Rz3UixwThpcoslW6GrYyp3ditf7hWrvVHvx+lFyUK7PsjdeIL6lwP4
 w2LuO88Gx1ZzKMvOpQkVZ25sQ1/qxr1USZ5rxl9eYUUy1VAFubqJzazNBJMr/KwWyJ2Lwdu5PXd
 KVOBUokLcC2nQ+GrKXVSTeYOrqSBjvGEahSpOMDBlPa/Wgcn6b+L/P6iFd6BdVhMwaSz7zdZNaL
 lBpcI1aQ7vjwhAZHRwpu6PCNLcxHApCPMOIlRXgCRacUeUjLxKgu2LtGPvw/Jo4ETPx99g
X-Received: by 2002:a05:6000:40cc:b0:43c:dc99:771c with SMTP id
 ffacd0b85a97d-43d292ff698mr5342103f8f.42.1775228116853; 
 Fri, 03 Apr 2026 07:55:16 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:a944:abe7:1177:5b7b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d2971sm17108705f8f.22.2026.04.03.07.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:55:16 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:55:14 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Kees Cook <kees@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Fix bridge leak when host
 attach fails
Message-ID: <ac_U0uwNHNHO-iay@osama>
References: <20260402210054.42074-1-osama.abdelkader@gmail.com>
 <DHJBJBQEIBVE.1MWBVWSTQ0THU@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHJBJBQEIBVE.1MWBVWSTQ0THU@bootlin.com>
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

Hello Luca,

On Fri, Apr 03, 2026 at 08:50:29AM +0200, Luca Ceresoli wrote:
> Hello Osama,
> 
> On Thu Apr 2, 2026 at 11:00 PM CEST, Osama Abdelkader wrote:
> > dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
> > drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
> > the bridge stayed registered without drm_bridge_remove(), leaking the
> > bridge reference and leaving the device on the global bridge list.
> >
> > On failure, undo in the same order as host_detach(): for dw-mipi-dsi,
> > drm_of_panel_bridge_remove() then drm_bridge_remove(); for dw-mipi-dsi2,
> > drm_bridge_remove() then drm_of_panel_bridge_remove().
> >
> > Fixes: 90910a651123 ("drm/bridge/synopsys: dsi: add ability to have glue-specific attach and detach")
> > Fixes: 0d6d86253fef ("drm/bridge/synopsys: Add MIPI DSI2 host controller bridge")
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c  | 7 ++++++-
> >  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 7 ++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > index ca4dea226f4b..ffa169c2de73 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > @@ -345,10 +345,15 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
> >  	if (pdata->host_ops && pdata->host_ops->attach) {
> >  		ret = pdata->host_ops->attach(pdata->priv_data, device);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto err_remove_bridge;
> >  	}
> >
> >  	return 0;
> > +
> > +err_remove_bridge:
> > +	drm_of_panel_bridge_remove(host->dev->of_node, 1, 0);
> 
> It was added by a devm_action, you shouldn't remove it here. Besides,
> devm_drm_of_get_bridge() might return A) a panel_bridge or B) a pointer to
> another, pre-existing bridge (and the called can't know which one got
> returned). drm_of_panel_bridge_remove() unconditionally removes a
> panel_bridge so it's wrong in case B.
> 
> Which means the drm_of_panel_bridge_remove() in _host_detach is probably
> wrong and you should look at it.
> 
> > +	drm_bridge_remove(&dsi->bridge);

Thanks for the information, I'm going to look at it in another patch.

> 
> This is correct, even though using devm_drm_bridge_add() instead of
> drm_bridge_add() above is probably the simplest solution.
> 
> Same for the other driver in this patch.

Thank you, I just did that in v2. 
Thanks,
Osama

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
