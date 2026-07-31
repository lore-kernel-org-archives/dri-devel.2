Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4FCC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C7A10F23C;
	Fri, 31 Jul 2026 12:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="1t2Dccnq";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CC510F23C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=In-Reply-To:References:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=NX7y02AytQR/eBKRBBahNpRVTejIjfYTyHXAd68tZJc=; t=1785499735; x=1786709335; 
 b=1t2DccnqK6cdVI6BfdImFschE+4CJIsJnWZxCPj1nolw6szmUdWvh3r3mRgSYFUygvamN4VZL6j
 QZl1oVf2KVcsob+TTNZvGM54UzYoaLZTwbpzgidS8aMAaWoYeDlPOBH5YNoAvEV0m28Vq0AaHQVDl
 hzgvKb2aTTn5ioPWP0IY7mMvXqV3Tpk6d2AEJu2Y79TTVtrRl6KEnXEuZvAm0copkbt/x39vUvN1v
 G4RXBn4MiHj1jZrZ8AZtGC1XexbkR5+jmApKGUTAaSAd7U3lJpkzJ6bwuAhTmFygwQ4u3Osaq/lHp
 /kGiOjT7cuw16bpW9yvVo5o29iCyCH2PItgA==;
Date: Fri, 31 Jul 2026 13:42:56 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 hns@goldelico.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH v5] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <amyKQNbemhTMKTk8@akepd>
References: <20260725165909.508612-1-andreas@kemnade.info>
 <39434782-9909-4bb4-b3da-a507acfc5e3d@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39434782-9909-4bb4-b3da-a507acfc5e3d@ideasonboard.com>
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

On Wed, Jul 29, 2026 at 02:15:33PM +0300, Tomi Valkeinen wrote:
> > -	/*
> > -	 * TODO: we do not always have to do the BTA sync, for example
> > -	 * we can improve performance by setting the update window
> > -	 * information without sending BTA sync between the commands.
> > -	 * In that case we can return early.
> > -	 */
> > +	/* TODO: find out if more needs to be done for MIPI_DSI_MSG_REQ_ACK */
> > -	r = dsi_vc_send_bta_sync(dssdev, vc);
> > -	if (r) {
> > -		DSSERR("bta sync failed\n");
> > -		return r;
> > +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> > +		r = dsi_vc_send_bta_sync(dssdev, vc);
> > +		if (r) {
> > +			DSSERR("bta sync failed\n");
> > +			return r;
> > +		}
> >   	}
> 
> The dsi_vc_send_bta_sync() function does dsi_get_errors(), which we now
> don't always do here. I think that might cause any errors to be left there,
> which would trigger error handling on next read or write-with-bta.
> 
> _omap_dsi_host_transfer forward declaration can now be remove.

I will produce a v6, when I have the possibility to test again,
probably on Monday.
> 
> I don't have HW to test this, but other than the above, it looks reasonable.
> Although I have to say, based on my past experience, it's also very easy to
> break a use case =).
> 
Probably these usecases should use MIPI_DSI_MSG_REQ_ACK.

Regards,
Andreas
