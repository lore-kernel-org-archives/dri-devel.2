Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE33EC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C90610E49F;
	Fri, 17 Jul 2026 18:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="p+N0UHZn";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057A510E49F
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 18:49:46 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 680EF664;
 Fri, 17 Jul 2026 20:48:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1784314128;
 bh=+nTllAieJyIjdxvMH1TIW9EUfls0WsTNMkaOsTLg4O4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p+N0UHZnKmbo1Sxh06p6dYRiG4/itMp2EjjMVCSsnHebf0wC9uMLcRzsFMevb5h/U
 R1oxjVF0kkJClgaigksPAGg/36LGP+XNdX1yjF8ZA9HpFWrWtgMuC5cQI2hMhbXcvg
 6ZnDwPTZN/b68uehPqhLxdFIUNhr6i4mNmhOa5Uo=
Date: Fri, 17 Jul 2026 21:49:43 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on
 probe failure
Message-ID: <20260717184943.GF1889304@killaraus.ideasonboard.com>
References: <20260717085716.1619275-1-johan@kernel.org>
 <20260717122035.GB1926197@killaraus.ideasonboard.com>
 <alpBiFzfbaTXae8l@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpBiFzfbaTXae8l@hovoldconsulting.com>
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

On Fri, Jul 17, 2026 at 04:51:52PM +0200, Johan Hovold wrote:
> On Fri, Jul 17, 2026 at 03:20:35PM +0300, Laurent Pinchart wrote:
> > On Fri, Jul 17, 2026 at 10:57:16AM +0200, Johan Hovold wrote:
> > > Make sure to drop the i2c adapter device and module references on failed
> > > regulator and enable gpio lookup (and regulator enable) during probe
> > > (e.g. on probe deferral).
> > > 
> > > Note that of_get_i2c_adapter_by_node() does not return error pointers,
> > > but i2c_put_adapter() can handle a NULL argument so the error pointer
> > > check at remove works even if it is misleading.
> > 
> > I've already sent a fix for this, see
> > 
> > https://lore.kernel.org/dri-devel/20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com/
> 
> Ah, ok. If that series is blocked perhaps you can send the fix
> separately.

Done.

https://lore.kernel.org/dri-devel/20260717184836.2017386-1-laurent.pinchart+renesas@ideasonboard.com

-- 
Regards,

Laurent Pinchart
