Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB95DCA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256EA10F347;
	Wed, 30 Sep 2026 11:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RCxaOLh8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F4210F347
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:56:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E00340B3A;
 Wed, 30 Sep 2026 11:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B7A1F000FF;
 Wed, 30 Sep 2026 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790769409;
 bh=jQQlqSCzl3HJKZyu5V29Yw5NiBeFIZqA5N2YuOTS3Ug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RCxaOLh8uQwRVO0Qfk4aWHUrwGAi0Qq9p9I8nZ7QbggWE+R8VbCHThdeDqbkBl0eZ
 fvPho9iiUHssMT/mcVnlrgnL7z6V2FI49YRJD5L4vCqSxEWaELgsD8ijl75umTRA+J
 PHjoqLeOo/kXBGx/EJh48YkqzqCauVpwylASgdVDQq4zR73SMAQHLvi5m6DyAV2Cxh
 Th6do9p1YWsk0NcnYWeUGONcJCI6BS4qMHedccSCXM3Hb4yEHcI6ePjorOzomJitP5
 g+0xV/1A7CMv+1cFhHa45t1FtSzVg0rLMDIP24y+14D0s19PmhhQa9PDpjpbd+fAT1
 8d0UPLncb4p5w==
Date: Wed, 30 Sep 2026 12:57:19 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ryan Roberts <ryan.roberts@arm.com>, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v1 7/8] misc/arm-cla: Manage domain contexts
Message-ID: <20260930115719.GG480985@myrica>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-8-ryan.roberts@arm.com>
 <20260717110114.780F01F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717110114.780F01F00A3D@smtp.kernel.org>
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

On Fri, Jul 17, 2026 at 11:01:14AM +0000, sashiko-bot@kernel.org wrote:
> > +	worker = kthread_run_worker_on_cpu(cpu, 0, "cla-dev-worker/%u");
> 
> [Severity: Medium]
> Is it possible this leaks uninitialized memory to user-space? The string
> "cla-dev-worker/%u" expects an integer argument, but the wrapper macro
> kthread_run_worker_on_cpu() only takes the name format and does not forward
> arguments to the underlying kthread_create_worker_on_cpu() function.

kthread_create_worker_on_cpu() adds the cpu number


> [Severity: High]
> When a CPU is hotplugged back online, will this setup path leave the hardware
> out of sync with the domain?

Yes save/restore on CPUHP will be added later


> > +	for (i = 0; i < domain->nr_devs; i++) {
> > +		dev = domain->devs[i];
> > +		call = &dev->call;
> > +
> > +		call->sched.prev_ctx = prev_ctx;
> > +		call->sched.next_ctx = next_ctx;
> > +		call->sched.ctx_id = i;
> > +		call->ret = 0;
> > +
> > +		mutex_lock(&dev->lock);
> > +		if (dev->worker && !dev->broken)
> > +			kthread_queue_work(dev->worker, &call->switch_ctx);
> > +		mutex_unlock(&dev->lock);
> 
> [Severity: High]
> If dev->worker is NULL because the CPU is offline, does this silently bypass
> the context switch for that device? 

Context cannot be switched on an offline CPU


> > +static void cla_domain_zap(struct cla_domain *domain, struct cla_ctx *ctx)
> > +{
> > +	struct vm_area_struct *vma;
> > +	struct vma_iterator vmi;
> > +
> > +	/*
> > +	 * If the context is dying it has already been unmapped, no need to zap
> > +	 * it here.
> > +	 */
> > +	if (!ctx || cla_ctx_is_dying(ctx))
> > +		return;
> > +
> > +	/*
> > +	 * Iterate over vmas in prev_ctx's mm, looking for vmas that map
> > +	 * prev_ctx's file. Zap any portions of those vmas that map the domain.
> > +	 */
> > +	mmap_read_lock(ctx->key.mm);
> > +	vma_iter_init(&vmi, ctx->key.mm, 0);
> > +	for_each_vma(vmi, vma) {
> 
> [Severity: High]
> Is it safe to acquire the mmap_read_lock() and iterate the maple tree here
> without an active mm reference?
> 
> The context only holds a passive mmgrab() reference. If a concurrent
> unprivileged userspace process exits, mm_users could drop to 0, and
> exit_mmap() might tear down the VMA maple tree. Should this code use
> mmget_not_zero() to prevent a use-after-free while walking the tree?

Yes probably


> > +static void cla_domain_reclaim(struct kthread_work *work)
> > +{
> > +	struct cla_domain *domain;
> > +	struct cla_ctx *ctx, *next;
> > +
> > +	domain = container_of(work, struct cla_domain, reclaim.work);
> > +
> > +	mutex_lock(&domain->lock);
> > +	list_for_each_entry_safe(ctx, next, &domain->dying_ctxs, queue_node) {
> > +		list_del_init(&ctx->queue_node);
> > +		WARN_ON(domain->assigned_ctx == ctx);
> > +		cla_ctx_put(ctx);
> 
> [Severity: Critical]
> If a domain becomes broken, is it possible for the active hardware context to
> be freed while still programmed in the device?
> 
> In cla_domain_schedule_reassignment(), the reassign work is skipped if the
> domain is broken, meaning the context is never uninstalled from the hardware.
> Then here in cla_domain_reclaim(), the dying context is unconditionally freed
> by calling cla_ctx_put(), which drops the PGD and software state.

No, a reference to the mm is kept

