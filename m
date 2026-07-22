Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369FC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADF010E2F4;
	Wed, 22 Jul 2026 19:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EaV3/ZS/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFC110E2F4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:05:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D43F43A9A;
 Wed, 22 Jul 2026 19:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C2F1F000E9;
 Wed, 22 Jul 2026 19:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784747131;
 bh=GTNAXQzdEcbikbTOwRyr/U5VO4eOAsomxKg31uWGKSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EaV3/ZS/pnK9IyioF7sZu71ZXWKcCuseQeNEOler0qJsQybEeMHvqSLpX36aGhTeK
 I+Pd5YmgNsjh1XKY/exNanP/Wae039RRmCV4eACmCxyVWCArBg2D9wpSkYJgOGc1YB
 5zSDgltbZAin3kxbd5qO6jWXx0zkpTCW8raa8XT7Rxaj1FANnHr3SCB6jlUXz2xfQr
 eEFI7ODz6u7YyBwRIsOfd1aW2Dpn5JDWezLPP6x11DqKYqWy9e369sZiSarUcoJ4Yl
 iWstcuQEwTF8jtWqdz1gBuw5Gw72/0bPAu7vXIBJrL1/3eOnuGGdtR5jjKPe4+j4jV
 PIX3vCuMZBaDw==
Date: Wed, 22 Jul 2026 09:05:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Tvrtko Ursulin via Kernel-dev <kernel-dev@igalia.com>,
 dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 linux-kernel@vger.kernel.org, Chia-I Wu <olv@google.com>
Subject: Re: [RFC v3 1/2] workqueue: Add support for real-time workers
Message-ID: <amEUelR4oL_odDuq@slm.duckdns.org>
References: <20260717090209.26931-1-tvrtko.ursulin@igalia.com>
 <20260717090209.26931-2-tvrtko.ursulin@igalia.com>
 <8dffe078-ca2e-4d01-96b3-f1709472ef1b@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dffe078-ca2e-4d01-96b3-f1709472ef1b@igalia.com>
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

Hello, sorry about the delay.

On Fri, Jul 17, 2026 at 11:06:55AM +0100, Tvrtko Ursulin wrote:
> > +	/*
> > +	 * Do not consume all CPUs with RT workers to avoid scheduler
> > +	 * starvation.
> > +	 */
> > +	if (pool->attrs->prio == WQ_PRIO_RT) {
> > +		unsigned int max = num_online_cpus();
> > +
> > +		if (max > 2)
> > +			max = max - 1;
> > +		else
> > +			max = 1;
> > +
> > +		if (atomic_inc_return(&total_rtpri_workers) > max) {
> > +			atomic_dec(&total_rtpri_workers);
> > +			return NULL;
> 
> Sashiko is warning me here this can create a deadlock when called from
> maybe_create_worker(). My apparently naive idea was that this would make it
> wait for a bit, until the load on the currently instantiated workers
> subsides, at which point need_to_create_worker() would say "not any more"
> and allow it to exit.
> 
> But even more importantly, it is also warning me that strict CPU affinity
> creates per CPU threads.
> 
> So my idea of global limit will just not work.
> 
> Tejun, how does this sound to you? Are you okay without having the global
> limit of RT threads?
> 
> I will await sending v4 with other fixes until we can close on this one. I
> also have some vacation pending so there may be a delay in my replies.

I don't think we need to limit the total number of workers. It's not a
meaningful protection anyway (is it ok if max-1 CPUs are pinned in RT?), the
DL server already provides forward progress protection, and it doesn't make
sense to design this assuming malicious / incompetent users.

Thanks.

-- 
tejun
