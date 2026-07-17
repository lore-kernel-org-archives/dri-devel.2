Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1FCC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AC110E498;
	Fri, 17 Jul 2026 14:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nl7TwgaG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85A410E498
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:51:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F5B0434EF;
 Fri, 17 Jul 2026 14:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF841F000E9;
 Fri, 17 Jul 2026 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784299914;
 bh=3Duoeoo110DbZrKZ4PxQfoBi3CcQu5zCYlkp7oI2Bkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nl7TwgaGI/ltnF/vCMXtyZmia9735PgdyKGC9gfdqr/6Sgz2NCppHh4a4ut7S5BDs
 vZVvIwv/ujYG0+DC6ULctWxjwNhr2a6x6e4rwCVT6bsCxPkZJI5fli3lKfWReaC9QI
 p1Xfh0yu4wHroSLWIoljNGgyfSRc0QbaVtQAKewtPk24oMlumIva6fuXgJMGoYTQLZ
 lzEnPUbXBYvHK0oGvwOtHKG7EKC5qJJzMxU5hDPEK0MyDeVZaGloGVoqB1y6uAvfhH
 gPQkBUblNM0TPOE4sVcIPe64Q7kKwDEkG6JZcF2l65tJRYKgGaqH/9SAy7lpG6+YIv
 zYV6lPW9nG8Fg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkjuq-00000007cg2-0ViK;
 Fri, 17 Jul 2026 16:51:52 +0200
Date: Fri, 17 Jul 2026 16:51:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <alpBiFzfbaTXae8l@hovoldconsulting.com>
References: <20260717085716.1619275-1-johan@kernel.org>
 <20260717122035.GB1926197@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717122035.GB1926197@killaraus.ideasonboard.com>
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

On Fri, Jul 17, 2026 at 03:20:35PM +0300, Laurent Pinchart wrote:

> On Fri, Jul 17, 2026 at 10:57:16AM +0200, Johan Hovold wrote:
> > Make sure to drop the i2c adapter device and module references on failed
> > regulator and enable gpio lookup (and regulator enable) during probe
> > (e.g. on probe deferral).
> > 
> > Note that of_get_i2c_adapter_by_node() does not return error pointers,
> > but i2c_put_adapter() can handle a NULL argument so the error pointer
> > check at remove works even if it is misleading.
> 
> I've already sent a fix for this, see
> 
> https://lore.kernel.org/dri-devel/20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com/

Ah, ok. If that series is blocked perhaps you can send the fix
separately.

Johan
