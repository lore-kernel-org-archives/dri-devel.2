Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8ABCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622F010EEE5;
	Wed, 24 Jun 2026 12:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EOHXqrHG";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96D010EEE5
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:20:44 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C61C41F94F;
 Wed, 24 Jun 2026 14:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1782303643;
 bh=Td5KfB6vvL5qWd/AgG+OkXVLJmd0JzIQXPAAlK9mb0s=; h=From:To:Subject;
 b=EOHXqrHGRmO1rYlrFRCpNU2WB+2q2mFKcRK5qrrbEDNPSQgexstLqaS087hlrr4Wd
 KNgGw+SUuisMpShN7qLBsU4TLGDRE39ebpbtS9FIpnSBew8iBU9rMXB3VzdRmDwI3V
 FUbMq4XOEewHVBYtc8bqZNow36D0wr3pLstEFgqyN5+ebxjSdCE8y6rxlRpS08a2+P
 VaOv8Q/RqsmLmVDP8A30lSlN59s6kvpCblKc33BciX2nxL9SWtAHZn0Vjemk0p7xM7
 qkMjqZ3iv0bQhWTWQoe6xd701KHlr8A5LP2TsVYcwzfKa/YWq2XPvggJMFloSFyycE
 PRbClYc2LrRAg==
Date: Wed, 24 Jun 2026 14:20:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shubham <shubham@rebhu.com>
Cc: tomi.valkeinen@ideasonboard.com, robertcnelson@gmail.com,
 dri-devel@lists.freedesktop.org, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v3 00/15] drm/tidss: Add BeagleY-AI display support (and
 some more)
Message-ID: <20260624122038.GA44163@francesco-nb>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
 <20260617075738.3065624-1-shubham@rebhu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617075738.3065624-1-shubham@rebhu.com>
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

Hello,

On Wed, Jun 17, 2026 at 01:27:38PM +0530, Shubham wrote:
> HDMI works. You mention testing the DSI output with the RPi 7" display
> (via the TC358762 DSI->DPI bridge) using extra overlays -- would you be
> able to share that 7" DSI test overlay? It would be an invaluable
> reference for the DSS/DSI videoport wiring. I suspect the crux of my
> problem is that the TD2 5" is a native DSI panel whose reset/power come
> from an i2c MCU, so the panel has a deferred dependency that the
> bridge-based 7" panel does not.

The overlay here is for a different board, but apart using the correct
DSI and I2C interface, you should be able to use it as a reference.

https://lore.kernel.org/all/20260623114329.63142-1-francesco@dolcini.it/

And you will need the following enabled in the kernel

CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_DRM_PANEL_ILITEK_ILI9881C=m

