Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02AA109E53D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143AF10E1D3;
	Thu, 26 Mar 2026 02:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sre7zWdJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF86410E053;
 Thu, 26 Mar 2026 02:19:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F71044219;
 Thu, 26 Mar 2026 02:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C39C2BCB0;
 Thu, 26 Mar 2026 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774491585;
 bh=xjze9U0KGxUtPZhnGjAmYRMpkSRQ9LRTSM1swxtBVH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sre7zWdJkwyHIBVNbNcQdwkoTMBVvPqAPpBUsifEItoB9/faCUfVf2/2yJdPlXxOp
 tgZNjsFi1PYwcyJahXWzzXXqu1U5VZkj84iaZ7DmNIPdjZ00YVnZs38rQK2jYJj889
 vdtczH+Wny36V19NA3gFD5ubR0VVbjeZjHQBsLOaGbqGoazg80XOG33dFXNqzdOMIZ
 A/WeWwEYMih49HI90FltiIyJs1Q/TEiJjxlJSFrHmRlPsD+qoNXNc1/cz8gTi5yMnr
 7Bwh2k4uLbwNbKHM61so7z2MY9nPlcLEswRfdwSGo42iENpVsRr+/3XN8XjLXj1fQl
 Q7EGtD88RoXJA==
Date: Wed, 25 Mar 2026 16:19:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] workqueue: Add interface to teach lockdep to
 warn on reclaim violations
Message-ID: <acSXwPliraMdYTFH@slm.duckdns.org>
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-2-matthew.brost@intel.com>
 <acQGehvhyfU5j6uL@slm.duckdns.org> <acSQxyclGs7FYvbS@gsse-cloud1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acSQxyclGs7FYvbS@gsse-cloud1>
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

On Wed, Mar 25, 2026 at 06:49:59PM -0700, Matthew Brost wrote:
> On Wed, Mar 25, 2026 at 05:59:54AM -1000, Tejun Heo wrote:
> > Sorry about the tardiness. Traveling during spring break. Getting more than
> > I can catch up with each day.
> > 
> > On Sun, Mar 15, 2026 at 09:32:44PM -0700, Matthew Brost wrote:
> > > @@ -403,6 +403,7 @@ enum wq_flags {
> > >  	 */
> > >  	WQ_POWER_EFFICIENT	= 1 << 7,
> > >  	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
> > > +	WQ_MEM_WARN_ON_RECLAIM	= 1 << 9, /* teach lockdep to warn on reclaim */
> > 
> > Shouldn't this require WQ_MEM_RECLAIM?
> 
> Yes, so what is suggestion here? If WQ_MEM_WARN_ON_RECLAIM is set
> without WQ_MEM_RECLAIM fail the WQ creation with -EINVAL?

Yes.

> > Why is this function necessary? It feels rather odd to use wq as the source
> > of this information. Shouldn't that be an innate knowledge of the code
> > that's using this?
> 
> This, for example, would be used in DRM sched (the existing scheduler)
> or DRM dep (the proposed replacement) to ensure that driver-allocated
> WQs passed into the layers are created with these flags. DRM sched or
> DRM dep has strict DMA-fencing, thus reclaim rule that we expect DRM
> drivers to follow. Historically, DRM drivers have broken these rules
> quite often, and we no longer want to give them the opportunity to do
> so—lockdep should enforce them.

I see. Yeah, that makes sense. Please feel free to add

 Acked-by: Tejun Heo <tj@kernel.org>

Please let me know how you wanna route the patch.

Thanks.

-- 
tejun
