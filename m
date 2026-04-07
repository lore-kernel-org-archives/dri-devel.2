Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3733EDB7FD
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1012810E3EB;
	Tue,  7 Apr 2026 11:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="BQvWOtjB";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D099A10E3EB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:07:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F2C32AF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 04:07:25 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 07D213F7D8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775560051; bh=EUpO38MrD5y+ezgw9fFZzH+TjJdtm3V8LmtjHq9rHIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BQvWOtjBJ4+EYfUBWsSaZprUDHBVODqLhJnuCMlTXwk6VW0EsvbsqWU4XcQ0mxCh+
 2WDZg/rWdI6p1PSiDYrG6IFuLyZ+X8R0BQ8yOotU4p1k+2pnHwfC4crmymnDKEVo20
 rhwlwgQMS+6FcfOD/uWzE42CjD7cxuenM+QVeeGk=
Date: Tue, 7 Apr 2026 12:07:27 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>, kernel@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/panthor: Extend VM locked region for remap case
 to be a superset
Message-ID: <adTlbwHZsbCFhU-f@e142607>
References: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
 <adTbdH653uY4CxWh@e142607> <20260407124353.0364f536@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407124353.0364f536@fedora>
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

On Tue, Apr 07, 2026 at 12:43:53PM +0200, Boris Brezillon wrote:
> On Tue, 7 Apr 2026 11:24:52 +0100
> Liviu Dudau <liviu.dudau@arm.com> wrote:
> 
> > On Fri, Apr 03, 2026 at 06:21:11PM +0100, Adrián Larumbe wrote:
> > > In the event of an sm_step_remap() that leads to a partial unmap of a
> > > transparent huge page, the new locked region required by an extended unmap
> > > might not be a superset of the original one. Then, if it leaves a portion
> > > of the initially requested one out, the ensuing map will trigger a warning.
> > > 
> > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > > Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_mmu.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > index fa8b31df85c9..2b96359d3b94 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > > @@ -1709,6 +1709,19 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
> > >  	    start + size <= vm->locked_region.start + vm->locked_region.size)
> > >  		return 0;
> > >  
> > > +	/* sm_step_remap() may need a locked region that isn't a strict superset
> > > +	 * of the original one because of having to extend unmap boundaries beyond
> > > +	 * it to deal with partial unmaps of transparent huge pages. What we want
> > > +	 * in those cases is to lock the union of both regions.
> > > +	 */
> > > +	if (vm->locked_region.size) {  
> > 
> > Why is this check needed? We're updating the vm->locked_region.size later anyway, and I think
> > we can cope with a locked region being of zero size when we are called, unless we consider that
> > to be a bug and we should check earlier for a zero value.
> 
> It's here to detect if this is the initial lock (==0), or the one
> that's done in sm_step_remap() (!=0). If we drop this conditional, the
> adjusted start will always be zero on the initial lock, because both
> vm->locked_region.start and vm->locked_region.size are zero in that
> case (see panthor_vm_unlock_region()).

It makes sense to test the vm->locked_region.start being zero, not the vm->locked_region.size.

In your suggested update of the math, I would go:

	if (vm->locked_region.start)
		start = min(start, vm->locked_region.start);

> 
> > 
> > > +		u64 end = start + size;  
> > 
> > Like Boris pointed out, the calculations can be optimized so that we don't need this line.
> > 
> > > +
> > > +		start = min(start, vm->locked_region.start);
> > > +		size = max(vm->locked_region.start +
> > > +			   vm->locked_region.size, end) - start;  
> > 
> > If we have something like:
> > 
> >  ..... [start .. start+size] ...... [vm->locked_region.start .. vm->locked_region.start + vm->locked_region.size] ....
> 
> First off, that's not supposed to happen.

Yeah, I was thinking from a defensive coding perspective where this function gets attacked.

>  The 3 cases that exist now are:
> 
> [start .. start+size]
> 		[vm->locked_region.start .. vm->locked_region.start + vm->locked_region.size]
> 
> or
> 
> 									[start .. start+size]
> [vm->locked_region.start .. vm->locked_region.start + vm->locked_region.size]
> 
> or
> 
> [start					..					 start+size]
> 	[vm->locked_region.start .. vm->locked_region.start + vm->locked_region.size]
> 
> 
> > 
> > we end up locking
> > 
> >  ..... [start ................................................. vm->locked_region.start + vm->locked_region.size] ....
> > 
> > is that intended?
> 
> We could add a WARN_ON() is there's no overlap between
> the previously locked region and the new one, but I'm
> not convinced this is something for panthor_vm_unlock_region() to
> enforce. Looks more like something the caller should check.

The only caller that might be exposed is panthor_vm_evict_bo_mappings_locked() and it doesn't look like
it could benefit from having the range check. I get it that it is not an expected scenario, just wanted
to double check.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
