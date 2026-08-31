Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B58C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE3110E9F3;
	Mon, 31 Aug 2026 16:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AqRYz27K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351A410E9F3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:30:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C57AC4058B
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948A81F000E9;
 Mon, 31 Aug 2026 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788193804;
 bh=5vnGB+/gD/xveV+EJ82CQFimFFuTevTUyp5p5/KtGNs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AqRYz27KeZZMcB3bgGOubeyXXxwOirpGlESYbTfkYXYpIxR9afkNXRn4RBNsoz1cl
 0Gg+0WNjnv5uGIX27ugETHnyPAAz5ABvLkDiY9/Urqdgv5HeGX/b3/eSlSg3IALWCY
 5b3rz2L0Fw301F3Cpv9t6CPnT4VrKt0PzyKknMdMC2M8mCZNMq8vo0PSV0rjWdhUkM
 XGZ6IETtoU+P1A1B0s7GvmjtndNgOO2USNSjl3fluX3o17Ixurbr7WbHgif9JHkBqd
 +MFbPSMclx96n+2aHzIZE3kUxb/GdJKJHXBQTR8wwMy0HRNlK99c54k9gA8I2Jukxu
 xk793wVzL61EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdkfd: Unwind debug trap enable
 on copy_to_user failure
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-439-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-439-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:30:04 +0000
Message-Id: <20260831163004.948A81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces a Use-After-Free vulnerability by failing=
 to set `target->debugger_process =3D NULL` during error unwind, leaving a =
dangling pointer.

Pre-existing issues:
- [High] Permanent reference leak of a `kfd_process` due to a race conditio=
n between `KFD_IOC_DBG_TRAP_ENABLE` and target process termination.
--

commit 8dd55ae921073df4d72c79c03882687ae0f9c626
Author: Yongqiang Sun <Yongqiang.Sun@amd.com>

drm/amdkfd: Unwind debug trap enable on copy_to_user failure

This patch adds cleanup logic to the copy_to_user failure path in
kfd_dbg_trap_enable() to undo partial setup, including releasing the
debug event file and decrementing the debugged process count.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_debug.c
> index ba99e0f258aee..5a9435dcd839b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -812,6 +812,12 @@ int kfd_dbg_trap_enable(struct kfd_process *target, =
uint32_t fd,
> =20
>  	if (copy_to_user(runtime_info, (void *)&target->runtime_info, copy_size=
)) {
>  		kfd_dbg_trap_deactivate(target, false, 0);
> +		fput(target->dbg_ev_file);
> +		target->dbg_ev_file =3D NULL;
> +		if (target->debugger_process)
> +			atomic_dec(&target->debugger_process->debugged_process_count);

[Severity: Critical]
Does this error path leave target->debugger_process as a dangling pointer?

In kfd_chardev.c:kfd_ioc_dbg_trap(), the target's debugger_process is set
before calling kfd_dbg_trap_enable():

		if (target !=3D p)
			target->debugger_process =3D p;

		r =3D kfd_dbg_trap_enable(target, ...);

When kfd_dbg_trap_enable() fails and unwinds, it decrements the
debugged_process_count but does not set target->debugger_process to NULL.

If the debugger process then exits, its cleanup routine will skip this targ=
et
(because debugged_process_count is 0), and the debugger's kfd_process struct
will be freed.

If the target process later attempts to self-debug by calling
KFD_IOC_DBG_TRAP_ENABLE on itself, kfd_ioc_dbg_trap() will bypass overwriti=
ng
the dangling pointer because target =3D=3D p:

		if (target !=3D p)
			target->debugger_process =3D p;=20

Then kfd_dbg_trap_enable() will execute:

	if (target->debugger_process)
		atomic_inc(&target->debugger_process->debugged_process_count);

Could this sequence lead to a use-after-free and memory corruption?
Should target->debugger_process be set to NULL on this error path?

> +		target->debug_trap_enabled =3D false;
> +		kfd_unref_process(target);
>  		r =3D -EFAULT;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does kfd_ioc_dbg_trap() have a race condi=
tion
with target process termination that can leak a kfd_process reference?

If KFD_IOC_DBG_TRAP_ENABLE starts and blocks on mutex_lock(&target->mutex),
and the target process simultaneously terminates, the target's mmu_notifier
release triggers and removes it from the global hash table:

kfd_process_notifier_release()
	hash_del_rcu(&p->kfd_processes);

Then it calls kfd_dbg_trap_disable() without holding target->mutex:

kfd_process_notifier_release_internal()
	p->mm =3D NULL;
	kfd_dbg_trap_disable(p);

Since ENABLE hasn't completed, debug_trap_enabled is false, and disable
returns immediately.

When ENABLE finally acquires the mutex, it succeeds, sets
debug_trap_enabled =3D true, and takes an extra kref on the target:

kfd_chardev.c:kfd_ioc_dbg_trap()
	r =3D kfd_dbg_trap_enable(target, ...);

When the debugger process eventually exits, its cleanup iterates over
kfd_processes_table to detach targets. Because the target was already remov=
ed
via hash_del_rcu(), the debugger fails to find it.

Since kfd_dbg_trap_disable() is never called for this target again, does th=
is
permanently leak the extra kref taken by ENABLE, along with all associated
GPU resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-439-sashal@kernel.org?part=3D1
