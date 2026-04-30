Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D4CCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC3010F289;
	Thu, 30 Apr 2026 08:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dlPct4Ak";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D101810F289
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:15:58 +0000 (UTC)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 5FD171F944;
 Thu, 30 Apr 2026 10:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777536956;
 bh=z7rIiToRgE+nZeOOewdljFLRTEwBQZYMDjiEiHcBfrY=;
 h=Received:From:To:Subject;
 b=dlPct4AkNODrr8olTkq370zruXf+DPd9eWXFrCXd1nZN78PCzIyooUNST/5737Db/
 E1hbUFlSRIYAE5U15RpFSaLyN/0XCoM+mJuKZfmLzHu9qFtyvfUe5FB2CLuLDE9pc4
 36MR9trbz0AAuR8nT+03NXxGAEebFwlaRHtQva76cKtfx29w7Yslp/8pRYy/769PDz
 G/UJ4MbzwQEOJcQEDDZE1YxG22hNZyRyGwMRDtSpdPNNZJnwxVXf1LddaswMUoCaDQ
 CyfNjm8C3gvaYGQh6tnMpeDQJ9O3jbWqw3gP/r5seLf5LJcq8xjC/KVqc/u7cFWsur
 Jpaea5oreHzEg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 0AF207F9D1; Thu, 30 Apr 2026 10:15:56 +0200 (CEST)
Date: Thu, 30 Apr 2026 10:15:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, max.oss.09@gmail.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Message-ID: <afMPu8sBwtq0tOK-@gaggiata.pivistrello.it>
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
 <20260429133333.GA68737@francesco-nb>
 <DI6BS0B8HTLP.2Q00QFIUQUZRU@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI6BS0B8HTLP.2Q00QFIUQUZRU@bootlin.com>
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

On Thu, Apr 30, 2026 at 09:53:08AM +0200, Luca Ceresoli wrote:
> Hi Francesco,
> 
> On Wed Apr 29, 2026 at 3:33 PM CEST, Francesco Dolcini wrote:
> > +Dmitry, Luca
> >
> > Hello all,
> > how to get this patch considered and eventually merged? I see that this
> > is not moving since long.
> >
> > Considering that Adrien Grassein is not visible on the mailing list
> > since 2022, and that I have various HW available that is using this
> > combination (on TI Sitara and Jacinto, on a DPI-DSI tc358768 bridge,
> > and NXP i.MX), I have access to the (little) documentation that is
> > available from Lontium I can propose myself as a maintainer here.
> 
> Thanks for volunteering! I am not a DRM maintainer, so I'll let others
> chime in, but I suspect you should just send a patch to add yourself to the
> MAINTAINERS entry and (as a separate patch?) remove Adrien, unless he
> speaks up by then.

Separate patch coming, thanks.

> I'm applying it in ~1 week. It would be good if you could check it still
> applies on drm-misc-next before that, report back if it does

It applies cleanly.

Thanks!
Francesco

