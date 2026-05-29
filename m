Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FDCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD2C0112447;
	Fri, 29 May 2026 19:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="Lk6PvzQq";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFD1112447
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4oXmrW92wN7TtRG/WLI2i9btFTdZCEIRgoAQMbkoofU=; b=Lk6PvzQqNurzSbZTQC8p0jdiIg
 eiRQ3pJBNrsHXbjdaaojamJf23is/k/l8722KPUHTZLoiER6gJaQ2XjgfwhsJERebIOfdh0HyR44K
 zunfQZhW99Fd2emu7qkXOw7xWdyQ0gvFOLIeR8ZeW6DXL7bjXzxEtBVnNiavaAGTy5iFCOBM2DVj3
 BRAT388SflgYxllBTloDORBqqNEbqn6RfsUtwN4dKNOAhDvverVvJ2iq8pyAKUgs2TFcXKLgrHOi1
 t/sFMglSmYYVRM4Ir/iy7nYzOmOFZzEauEx2FykfyEQfnPLz7/2xiuYjR1axOAg6JWD1rc3bwZbi4
 nbr896+g==;
Date: Fri, 29 May 2026 21:21:27 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v3 10/13] drm/bridge: tc358762: Move tc358762_init()
 into tc358762_enable()
Message-ID: <20260529212127.6cf70ac3@kemnade.info>
In-Reply-To: <20260513-tc358762-fixes-v3-10-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-10-6698b55008b9@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 13 May 2026 16:10:19 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> The only thing tc358762_enable() does is call tc358762_init(). Inline
> the tc358762_init() into tc358762_enable(), for simplicity and to make
> it easier to improve the tc358762_enable() in the following commits. No
> functional change.
> 

hmm, isn't video already on in _enable? I guess  before using high speed mode,
don't we need to have configured the dsi interface relevant registers (lanes, etc.).
If they do not use good default values. Not studied that yet, as I am still
fiddling with my panel driver which does some things differently before trying
to generalize the bridge driver to fit my use case.

Regards,
Andreas
