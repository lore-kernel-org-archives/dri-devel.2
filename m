Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C167C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE8F10E346;
	Wed, 12 Aug 2026 14:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bhP3XliD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073D210E346
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:12:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DDB460A92;
 Wed, 12 Aug 2026 14:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68931F000E9;
 Wed, 12 Aug 2026 14:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786543922;
 bh=yYnXvYhhf7b5xbUWwE9T2eh0nKOdkbnhxJDvX0wctBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bhP3XliDF7xwdkuJMy0cUM2MpcJZQyH2ddJUa/jz9lGffbaS0dTfwJ1S2bTMNjfg6
 uKwKKydfL8oKqtlRNGqHEdxYKbI/wwfSyCa2Xowy4GwmVGaOc/jB3OJGdb3+eYNnh0
 1WsGAbRWfk9ucE+Gxe+tC2JsGi2nsYj0awLwgfpqzAbVh/OpO55hGkcLxpoUdYpmH9
 54DDP+u4UiVBr6bqjGxiopqXKD1YEFk0xPOvxRnO20MuQTqrbhuPgehb+JQK30F96x
 6hXwibZbJBcdKH6L3KKnjBpW1zOOOlWenY5ixmhM94wkiQXfFLiL3r/s0kbobWCrwk
 YKU04IElk+57Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wu9gW-00000000EDD-228D;
 Wed, 12 Aug 2026 16:12:00 +0200
Date: Wed, 12 Aug 2026 16:12:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
Message-ID: <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
References: <20260716132334.1565183-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132334.1565183-1-johan@kernel.org>
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

On Thu, Jul 16, 2026 at 03:23:34PM +0200, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
> 
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up for 7.3-rc1?

Johan
