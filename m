Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D29C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D4910E49D;
	Fri, 17 Jul 2026 18:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iZgq4XYQ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7105510E49D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 18:42:40 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8E8A664;
 Fri, 17 Jul 2026 20:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1784313702;
 bh=O/On+t6NH7FIUwf5eOrp3o3fXMmLkuqMuRWAk4VgT5g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iZgq4XYQJ1R7SThlFwvEVIqJe5VZdTleXFsX+QiHeeL9E9pyIgUVRKV0Irm45bfh3
 pSJkAGXJ4UyP05dmctqI9OVRKf8YA/HZ/gHZ6lSZYZGX1E/EttCB0mdlsqWXXu3oMb
 hkj9cA0gtZ0nb50HSwFXtoyG1RGjHWtJhzo/soCs=
Date: Fri, 17 Jul 2026 21:42:37 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Johan Hovold <johan@kernel.org>
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
 linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Message-ID: <20260717184237.GE1889304@killaraus.ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
 <alpEVeVmH5oiqmaj@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpEVeVmH5oiqmaj@hovoldconsulting.com>
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

On Fri, Jul 17, 2026 at 05:03:49PM +0200, Johan Hovold wrote:
> On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
> > If the probe function returns an error after getting the I2C adapter for
> > DDC, the reference to the adapter is never released. Fix it by releasing
> > it in the bridge .destroy() handler.
> > 
> > There is no need to test the ddc pointer with !IS_ERR(), as
> > of_get_i2c_adapter_by_node() returns NULL on error.
> 
> I stumbled over this this morning as well and posted a fix here (which
> releases the adapter on driver unbind as is currently done):
> 
> 	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.org/
> 
> > Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
> 
> I believe this issue was first introduced by commit 2e2bf3a5584d
> ("drm/bridge: display-connector: add DP support") a few releases
> earlier.

You're right. I'll update the Fixes: tag.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>

-- 
Regards,

Laurent Pinchart
