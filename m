Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F342C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561F510F4EE;
	Fri, 17 Jul 2026 11:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A4ud/hQL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080A010F4EE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:01:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE6AA41348;
 Fri, 17 Jul 2026 11:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780F01F00A3D;
 Fri, 17 Jul 2026 11:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784286074;
 bh=W4UybwNSII4IhLhoZkmMZHlHRpCzNqNhvUoBY4RCHI0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A4ud/hQL0GMiXr7RzR80gyp0YMP2+PMLtfJ8avKIDL9lU2Xiadx1LHS7LdN0GUfrk
 U+0PtghzpXqAZVvYpkbqpnhTbLCO/kFQxEfj5wfzXSpVnZydw5UZk+NRoHveTT7cCK
 ergn0ylncxd80R/Whbm5ZtrIMcyej53JGyauPjVniqIXvzGeDSIDZs3Gm2Zvgv7vVX
 U+JFADaP/NY4EC6h+Fl/9GtjzINucdxNeAIYDvSN5XQoyGsnnGG2ceIeusciM7ikr1
 5KVSOEE3vuwwmvdCfP1DDyGuAt7xwa+c/GL8Evv90+u/f5bIsMUv2ABgN/JOHNk69L
 kpfbUGSLPwigQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 7/8] misc/arm-cla: Manage domain contexts
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-8-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-8-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:01:14 +0000
Message-Id: <20260717110114.780F01F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Active hardware context and registers are freed when a domain =
is broken, allowing hardware to DMA into freed memory.
- [High] Unsafe VMA iteration in `cla_domain_zap()` without holding an acti=
ve mm reference, leading to use-after-free.
- [High] Domain context switch silently skips devices with offline CPUs ins=
tead of failing, leading to broken context isolation.
- [High] A CLA device coming online via CPU hotplug fails to restore the do=
main's currently assigned context.
- [Medium] Missing format string argument for `%u` when creating the per-de=
vice kthread worker.
--

--- Patch [7]: [RFC PATCH v1 7/8] misc/arm-cla: Manage domain contexts ---
commit 62c539a6d69f0f095ec0d6a00c78d57199599362
Author: Ryan Roberts <ryan.roberts@arm.com>
Subject: misc/arm-cla: Manage domain contexts

A CLA domain cannot be used by multiple address spaces concurrently. This
commit introduces context tracking and scheduling for CLA domains, running
hardware operations via kthread workers.

> diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-i=
nit.c
> index 0451d97bc95b3..5335c55568add 100644
> --- a/drivers/misc/arm-cla/cla-init.c
> +++ b/drivers/misc/arm-cla/cla-init.c
[ ... ]
> @@ -171,6 +172,46 @@ static void cla_dev_reinit(struct cla_dev *dev)
>  	cla_reg_write(dev, CLA_REG_LRESP, 0);
>  }
> =20
> +static int cla_dev_worker_init(struct cla_dev *dev, int cpu)
> +{
> +	struct kthread_worker *worker;
> +
> +	worker =3D kthread_run_worker_on_cpu(cpu, 0, "cla-dev-worker/%u");

[Severity: Medium]
Is it possible this leaks uninitialized memory to user-space? The string
"cla-dev-worker/%u" expects an integer argument, but the wrapper macro
kthread_run_worker_on_cpu() only takes the name format and does not forward
arguments to the underlying kthread_create_worker_on_cpu() function. Will=20
this cause vsnprintf() to consume a random stack slot or register for the
thread name?

> +	if (IS_ERR(worker))
> +		return PTR_ERR(worker);
> +
[ ... ]
> @@ -227,6 +268,10 @@ static int cla_dev_setup(unsigned int cpu)
>  			 dev->accelerators);
>  	}
> =20
> +	ret =3D cla_dev_worker_init(dev, cpu);
> +	if (ret)
> +		goto err;
> +
> +	return 0;

[Severity: High]
When a CPU is hotplugged back online, will this setup path leave the hardwa=
re
out of sync with the domain?

It initializes the worker but does not appear to check domain->assigned_ctx
or queue work to restore the active context to the hardware. If the domain
only has one active context, a subsequent reassignment will abort in
cla_domain_reassign() because next_ctx and prev_ctx evaluate to NULL. Can
this permanently bypass context restoration and cause memory faults?

>  err:
>  	cla_dev_reinit(dev);
> diff --git a/drivers/misc/arm-cla/cla-sched.c b/drivers/misc/arm-cla/cla-=
sched.c
> new file mode 100644
> index 0000000000000..18b54cc386b7c
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-sched.c
[ ... ]
> +static int __cla_domain_switch_ctx(struct cla_domain *domain,
> +				   struct cla_ctx *prev_ctx,
> +				   struct cla_ctx *next_ctx)
> +{
[ ... ]
> +	for (i =3D 0; i < domain->nr_devs; i++) {
> +		dev =3D domain->devs[i];
> +		call =3D &dev->call;
> +
> +		call->sched.prev_ctx =3D prev_ctx;
> +		call->sched.next_ctx =3D next_ctx;
> +		call->sched.ctx_id =3D i;
> +		call->ret =3D 0;
> +
> +		mutex_lock(&dev->lock);
> +		if (dev->worker && !dev->broken)
> +			kthread_queue_work(dev->worker, &call->switch_ctx);
> +		mutex_unlock(&dev->lock);

[Severity: High]
If dev->worker is NULL because the CPU is offline, does this silently bypass
the context switch for that device?=20

Since call->ret is initialized to 0 and there is no else branch to return an
error, the domain switch will complete and report success. When the CPU com=
es
back online, could the device retain a stale context and break isolation?

> +	}
[ ... ]
> +static void cla_domain_zap(struct cla_domain *domain, struct cla_ctx *ct=
x)
> +{
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +
> +	/*
> +	 * If the context is dying it has already been unmapped, no need to zap
> +	 * it here.
> +	 */
> +	if (!ctx || cla_ctx_is_dying(ctx))
> +		return;
> +
> +	/*
> +	 * Iterate over vmas in prev_ctx's mm, looking for vmas that map
> +	 * prev_ctx's file. Zap any portions of those vmas that map the domain.
> +	 */
> +	mmap_read_lock(ctx->key.mm);
> +	vma_iter_init(&vmi, ctx->key.mm, 0);
> +	for_each_vma(vmi, vma) {

[Severity: High]
Is it safe to acquire the mmap_read_lock() and iterate the maple tree here
without an active mm reference?

The context only holds a passive mmgrab() reference. If a concurrent
unprivileged userspace process exits, mm_users could drop to 0, and
exit_mmap() might tear down the VMA maple tree. Should this code use
mmget_not_zero() to prevent a use-after-free while walking the tree?

> +		if (vma->vm_file !=3D ctx->key.file)
> +			continue;
[ ... ]
> +static void cla_domain_reclaim(struct kthread_work *work)
> +{
> +	struct cla_domain *domain;
> +	struct cla_ctx *ctx, *next;
> +
> +	domain =3D container_of(work, struct cla_domain, reclaim.work);
> +
> +	mutex_lock(&domain->lock);
> +	list_for_each_entry_safe(ctx, next, &domain->dying_ctxs, queue_node) {
> +		list_del_init(&ctx->queue_node);
> +		WARN_ON(domain->assigned_ctx =3D=3D ctx);
> +		cla_ctx_put(ctx);

[Severity: Critical]
If a domain becomes broken, is it possible for the active hardware context =
to
be freed while still programmed in the device?

In cla_domain_schedule_reassignment(), the reassign work is skipped if the
domain is broken, meaning the context is never uninstalled from the hardwar=
e.
Then here in cla_domain_reclaim(), the dying context is unconditionally fre=
ed
by calling cla_ctx_put(), which drops the PGD and software state.

Will this allow the broken hardware to perform page walks into freed and
reallocated memory?

> +	}
> +	mutex_unlock(&domain->lock);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D7
