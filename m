Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC34AC88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E90E10E61E;
	Fri, 11 Sep 2026 09:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aJL0a3De";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2972810E61E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789120452;
 bh=+bJcP3hgZKncl50ol86uNSzjg8GhtHkhKyT01/iVVxE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aJL0a3DeMKgi7ul0Z9H6t09PYjjGFDedS6yCc1pcRb1HWMKUZiK6olr4TnJ+toy43
 oD3nRc+6KHeV6J4tHmYrC8widsgFKJobzIi324Z23h3iH3/6Mh8MvsFdHmFb2JUm+Q
 gQ4Yl00CWCobnb4xN/Zc1+y16yfG3W7fnZOTNo1NOqfxCL2QgeY6RMYHMYyT60UxBx
 sNMY/qyd1ikLp2x/vmEKNd2jaiVeFvAOT8GKNXC5nXxQVnuvllFGnnl3hSxWsf2qWl
 RN50cXeTCtgeGJXfEIM5fkanbMqeuzVL9qcdnSPxNfCMe33Nehh9qg4r+4yZ7ZS1hX
 KTriq5oA7FBZg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5434917E0785;
 Fri, 11 Sep 2026 11:54:12 +0200 (CEST)
Date: Fri, 11 Sep 2026 11:54:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Adrian Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/18] drm/panthor: Complain if the SOFT_RESET fails
Message-ID: <20260911115406.1758b0eb@fedora-21.home>
In-Reply-To: <aqNsLgZRLw_el4h4@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-13-982cc8f4234b@collabora.com>
 <aqNsLgZRLw_el4h4@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Fri, 11 Sep 2026 04:40:01 +0100
Adrian Larumbe <adrian.larumbe@collabora.com> wrote:

> On 26.08.2026 16:56, Boris Brezillon wrote:
> > We rely on a functioning SOFT_RESET to avoid HW UAFs when the GPU was
> > in a state where AS commands were no longer accepted. If we silently
> > ignore RESET failures, we're just pretending to be safe while exposing
> > ourselves to the very UAFs we were trying to avoid. On the other hand,
> > there's basically nothing we can do if both the SOFT_RESET and the
> > AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly and
> > taint the kernel with a WARN_ON().
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_hw.h | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> > index 4531c1239cb6..f13fd7b335c1 100644
> > --- a/drivers/gpu/drm/panthor/panthor_hw.h
> > +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> > @@ -41,9 +41,17 @@ int panthor_hw_init(struct panthor_device *ptdev);
> >  int panthor_hw_power_status_register(void);
> >  void panthor_hw_power_status_unregister(void);
> >  
> > -static inline int panthor_hw_soft_reset(struct panthor_device *ptdev)
> > +static inline void
> > +panthor_hw_soft_reset(struct panthor_device *ptdev)
> >  {
> > -	return ptdev->hw->ops.soft_reset(ptdev);
> > +	/* We're relying on the SOFT_RESET to reset the MMU block if some AS
> > +	 * were stuck for some reason. Failing to reset the MMU/L2 means we're
> > +	 * exposing ourselves to HW UAFs. On the other hand, there's basically
> > +	 * nothing we can do if both the SOFT_RESET and
> > +	 * the AS_COMMAND(UNMAPPED) fail, so do what we do best: complain loudly
> > +	 * and taint the kernel.
> > +	 */
> > +	drm_WARN_ON(&ptdev->base, ptdev->hw->ops.soft_reset(ptdev));  
> 
> I think you forgot to include drm/drm_print.h, although Sashiko probably picked up on this.
> 
> On top of that, I wonder if failure to soft reset should be carried up the call stack and
> eventually lead to an early unplug, just like you do when panthor_fw_post_reset() fails.

That's what I had in earlier versions of this patchset, and I decided
to get rid of it after discussing it with Liviu and Steve: if a
SOFT_RESET can fail and there's nothing above it to guarantee that the
HW is off and can't do any access to the memory it knew about, we're
just screwed, because then we have to leak resources at unplug time. I
tried it, and it's nasty, so in v4 (or v3, I don't remember) I got back
to something simpler, with the assumption that SOFT_RESET will never
fail (which seems to be the case in practice by the way).
