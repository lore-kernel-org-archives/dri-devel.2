Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB91CDB470
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEA010E17E;
	Mon, 22 Jun 2026 13:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pkH1eov6";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410EE10E17E
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:01:53 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7868227;
 Mon, 22 Jun 2026 15:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782133273;
 bh=N1ETn9Jj5pisDG1bq4JWbw7aNdqW9tjRev1AlON/zSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pkH1eov6TunNPB/42dP+l4CcIVfCj0VfhTOtlWUFC495AwNZ/wTA8JXegYFwKSzeK
 ztro35Mvx9mLkJtnKzEdv6cdcxFzzx9mljL16idQzi+AtSINWRDmQ7YFuH1BY+wMNR
 l9muZ7J2YuFPTUw8073tBmt+rCj9ABAd0e1tgALE=
Date: Mon, 22 Jun 2026 16:01:50 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: biren pandya <birenpandya@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/gem: modernize locks to use scoped_guard()
Message-ID: <20260622130150.GA3948118@killaraus.ideasonboard.com>
References: <20260616181956.61476-2-birenpandya@gmail.com>
 <20260622115544.GA3899302@killaraus.ideasonboard.com>
 <CAAeMi9LMootkxmRE0tjo0mwijAuA0u+49HhxWxRGU-pSz+Cggw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeMi9LMootkxmRE0tjo0mwijAuA0u+49HhxWxRGU-pSz+Cggw@mail.gmail.com>
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

On Mon, Jun 22, 2026 at 06:22:27PM +0530, biren pandya wrote:
> On Mon, Jun 22, 2026 at 5:25 PM Laurent Pinchart wrote:
> > On Tue, Jun 16, 2026 at 11:49:57PM +0530, Biren Pandya wrote:
> > > Several GEM core functions manually managed mutex_lock() and
> > > mutex_unlock() over single scopes or error paths. This adds boilerplate
> > > and carries the risk of lock leaks if error paths are refactored.
> > >
> > > Modernize these locks by deploying the <linux/cleanup.h> scoped_guard()
> > > macro. This ensures that the locks are reliably dropped when the block
> > > exits, cleanly removing goto out_unlock paths and tightening the
> > > lifecycle.
> >
> > What's the reason for doing so in in drm_gem and not other areas in DRM
> > ?
> 
> Hi Laurent,
> 
> Thanks for taking a look.
> No deeper reason than it being where I happened to start — I didn't
> mean to single it out, and I'd rather the treatment be consistent than
> piecemeal.
> 
> > > @@ -1021,37 +1018,34 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> > >               goto out;
> > >       }
> > >
> > > -     mutex_lock(&file_priv->prime.lock);
> > > +     scoped_guard(mutex, &file_priv->prime.lock) {
> > > +             spin_lock(&file_priv->table_lock);
> > > +             ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
> > > +                             GFP_NOWAIT);
> > > +             spin_unlock(&file_priv->table_lock);
> >
> > And why don't you use guards for the spinlock as well ?
> 
> Fair point — the spinlocks here are equally good candidates; I only
> kept v1 to mutexes to keep it small.
> 
> That said, this is a pure cleanup with no functional change, so it's
> entirely your call whether it's worth carrying.
> If you'd like it, I'll send a v2 that converts both the mutexes and
> the spinlocks in drm_gem.c consistently. If you'd prefer not to take
> cleanup-only churn, I'm happy to drop it — no problem either way.

I'll let the maintainers of that code decide (I'm not one of them).

-- 
Regards,

Laurent Pinchart
