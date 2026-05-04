Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B832FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672B010E735;
	Mon,  4 May 2026 14:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ELuN4VS2";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B05510E735
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:59:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 13DE7C5EF23;
 Mon,  4 May 2026 15:00:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 98A6E5FD5F;
 Mon,  4 May 2026 14:59:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C3CA11AD2B53; 
 Mon,  4 May 2026 16:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777906781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=D5kXuj7b0TezzOkReAqdEFpDHHOBFpeEkg4j1HAsgMU=;
 b=ELuN4VS2xlI5vaE6U4aJ/dDmji7zC8pUoNwPtsl3i1Dx+uvjf4ptdVXGbHGLkcTGdc67fa
 ZIaVg5GvPrK6pukeOdWxUOJIgkvzsWFWhOvq5ImQatc6Y/F7gyMwoiIorSYMbqOmSE4XQ1
 k7HPpKDl3wqzV4NXlTfg5AdYLCp6qVYtJdUSkkHzfDIrvkzycf9gHZOOkh+38XJLdo0oz3
 oLr5K9FN9J1L+livE9E/4gVddUwls+/3tgM7IMtnS/K2mduPhbSFhbkjMg8pBzJ5gc+eeD
 ykkBjc+NVKe7iDZ9SzwV90WfdYaMBazejqISTuyVw58i2JLzWlS4nRb1SIqY+w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jyri Sarha <jsarha@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, kernel test robot <lkp@intel.com>, 
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20260417155446.1068893-1-kory.maincent@bootlin.com>
References: <20260417155446.1068893-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] drm/bridge: tda998x: Return NULL instead of 0 in
 tda998x_edid_read()
Message-Id: <177790677669.485185.3751177951490441273.b4-ty@b4>
Date: Mon, 04 May 2026 16:59:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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


On Fri, 17 Apr 2026 17:54:45 +0200, Kory Maincent wrote:
> tda998x_edid_read() returns a const struct drm_edid pointer, but when
> tda998x_edid_delay_wait() fails (process killed while waiting for the
> HPD timeout), the integer literal 0 is returned instead of NULL,
> triggering a sparse warning: "Using plain integer as NULL pointer"
> 
> Replace 0 with NULL to fix the sparse warning.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: tda998x: Return NULL instead of 0 in tda998x_edid_read()
      commit: b5d0ad616ca8dd8c7b6b24dc13012e342278a085

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

