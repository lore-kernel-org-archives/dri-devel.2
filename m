Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8CVr4TR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F8810EFBF;
	Mon, 16 Nov 2026 12:05:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2B610EFC1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:05:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD9D4629D5;
 Mon, 16 Nov 2026 12:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CC01F000C5;
 Mon, 16 Nov 2026 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794830723;
 bh=vmFvvZJ/Z0G5Y9zBQfarkFRXcOkX1+aT4sNcy7zqqss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M8CVr4TRvBQJJmByyiOFexg8S1xI1qn2kLg/FcGTMi2HmywpZewttlp/fc5g6UrS4
 X2EuqaUb41bvlgnum3+5+BMgcq89NDvupSj8JiuH1X1wMjo3q2FasI3qkYcaN7eEzb
 xYJpRdSEIRuOyQH/h/DCnDH9Dy38vGRW9A/jbSlD4+Lw8p6pQ7hGOqyNaxmEAL3FE5
 ePU/0h1PqDDGM0HB3kWqWp/AkJf+n0b0UmYVMgy8nPJN3qShpJx3bFo1zrHtqztDl+
 m4U1osJ0mLAvT4geoVOq4exEr1LYXpnDISrhzONeukv2gO2N3odmD24f/Re1gqakrv
 0xHOaCp/0EvQg==
Message-ID: <sashiko-outbox-216980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] drm/panthor: Protm support for groups
To: "Ketil Johnsen" <ketil.johnsen@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261116112601.3483649-13-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
 <20261116112601.3483649-13-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 12:05:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/panthor: missing import and exclusivity checks in
  panthor_group_create()
- [High] drm/panthor: AB-BA deadlock between sched->protm.lock and
  vm->sched.work_run_job
- [High] drm/panthor: missing sched->lock in handle_protm_fault() during
  reset
- [High] drm/panthor: stale protm_pending_queues across
  group_unbind_locked()
- [Medium] drm/panthor: NULL deref and pin leak on unplug in
  panthor_group_create()
- [Low] drm/panthor: user GEM BO accounted as private kernel BO in
  add_group_kbo_sizes()
--

commit f5cdea11b7d0262429a726c34516cf02769fb1a4
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Protm support for groups

This commit extends struct drm_panthor_group_create with a user-supplied
protected suspend buffer handle, maps that buffer into the MCU firmware VM
during group creation, and allows queues on groups with a protected suspend
buffer to raise CS_PROTM_PENDING events.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 9c78f04d4f30a..02726cbcce3ca 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1456,10 +1456,15 @@ cs_slot_process_protm_pending_event_locked(struct=
 panthor_device *ptdev,
>  	if (!group)
>  		return;
> =20
> -	/* Do not allow user space work to switch into protected mode, as we
> -	 * do not fully support this quite yet.
> +	/* Do not allow user space work to switch into protected mode if we
> +	 * do not support protected mode on this device.
> +	 * User space should query (and init) this support before attempting
> +	 * to use such GPU instructions.
>  	 */
> -	atomic_or(BIT(cs_id), &group->fatal_queues);
> +	if (group->protm_suspend_buf)
> +		atomic_or(BIT(cs_id), &group->protm_pending_queues);
> +	else
> +		atomic_or(BIT(cs_id), &group->fatal_queues);
> =20
>  	sched_queue_delayed_work(sched, tick, 0);
>  }

[Severity: High]
Can setting group->protm_pending_queues here trigger an ABBA deadlock
between sched->protm.lock and vm->sched.work_run_job when tick_ctx_apply()
enters protected mode concurrently with an asynchronous VM_BIND job on the
same VM?

CPU0                                     CPU1
----                                     ----
down_write(&sched->protm.lock)
                                         drm_sched_run_job_work()
                                           ...
                                           down_read(&sched->protm.lock)
cancel_work_sync(&vm->sched.work_run_job)

 *** DEADLOCK ***

CPU0: tick_work() -> tick_ctx_apply() -> panthor_vm_protm_enter() ->
      panthor_vm_stop() -> drm_sched_stop()
CPU1: drm_sched_run_job_work() -> panthor_vm_bind_run_job() ->
      panthor_vm_exec_op() -> protm_block_timeout() ->
      panthor_sched_protm_block_timeout()

Once group->protm_pending_queues is set, tick_ctx_apply() sees a non-NULL
ctx->protm_group, takes sched->protm.lock in write mode, and calls
panthor_vm_protm_enter(), which stops the VM scheduler and waits for any
in-flight work_run_job to complete.  If work_run_job is already running on
ptdev->mmu->vm.wq and reaches panthor_sched_protm_block_timeout(), both
workqueues hang permanently.

[Severity: High]
Once groups can enter protected mode and populate
sched->protm.active_group, does handle_protm_fault() access CSG slots and
scheduler group lists without holding sched->lock?

drivers/gpu/drm/panthor/panthor_sched.c:handle_protm_fault() {
    ...
	for (csg_id =3D 0; csg_id < sched->csg_slot_count; csg_id++) {
		struct panthor_group *group =3D sched->csg_slots[csg_id].group;
    ...
		group->state =3D PANTHOR_CS_GROUP_SUSPENDED;
		group_unbind_locked(group);

		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));

		if (group_can_run(group)) {
			list_add(&group->run_node,
				 &sched->groups.idle[group->priority]);
		} else {
			list_del_init(&group->wait_node);
    ...
}

CPU0 (reset work)                 CPU1 (queue work / timeout)
panthor_sched_pre_reset()
  mutex_lock(&sched->reset.lock)
  handle_protm_fault()
                                  queue_run_job()
                                    mutex_lock(&sched->lock)
                                    if (group->csg_id >=3D 0)
    group_unbind_locked(group)
      /* lockdep_assert_held(&sched->lock) */
      group->csg_id =3D -1;
      queue->doorbell_id =3D -1;
                                      panthor_fw_ring_doorbell(ptdev, -1)
                                        <-- out-of-bounds MMIO write

panthor_sched_pre_reset() calls handle_protm_fault() while holding only
sched->reset.lock and before panthor_group_stop() stops the per-queue
scheduler and timeout works.  When a protected-mode fault leaves the GPU
unable to exit protected mode, handle_protm_fault() triggers
lockdep_assert_held(&ptdev->scheduler->lock) inside group_unbind_locked()
and races with concurrent sched->lock holders such as queue_run_job() and
queue_timedout_job(), causing an invalid doorbell write or corrupting
sched->groups.idle and group->wait_node.

[Severity: High]
Does group_unbind_locked() leave stale bits in group->protm_pending_queues
when a group is suspended and unbound before it gets to enter protected
mode?

drivers/gpu/drm/panthor/panthor_sched.c:group_unbind_locked() {
    ...
	/* Tiler OOM events will be re-issued next time the group is scheduled. */
	atomic_set(&group->tiler_oom, 0);
	if (cancel_work(&group->tiler_oom_work))
		group_put(group);
}

If a queue raises CS_PROTM_PENDING while another group is picked first on
that tick, and this group is later suspended and unbound (for example due
to slot rotation or preemption), cs_slot_reset_locked() resets the slot's
CS_PROTM_PENDING request bit, but group_unbind_locked() only clears
group->tiler_oom and leaves group->protm_pending_queues non-zero.

When the unbound group is later picked first from
sched->groups.runnable[prio], tick_ctx_pick_groups_from_list() selects it
as ctx->protm_group based on that stale mask.  In tick_ctx_apply(),
tick_ctx_handle_protm_group() then runs before csgs_upd_ctx_apply_locked()
sends CSG_STATE_RESUME, so (cs_iface->output->ack ^ cs_iface->input->req) &
CS_PROTM_PENDING is zero and goes unacknowledged while
group->protm_pending_queues is cleared.  csgs_upd_ctx_apply_locked() then
resumes the group in normal mode (re-raising CS_PROTM_PENDING) and
tick_ctx_apply() immediately calls panthor_fw_protm_enter(), which times
out and triggers a GPU reset.

Clearing group->protm_pending_queues in group_unbind_locked() alongside
group->tiler_oom would let the firmware re-issue CS_PROTM_PENDING once the
group is resumed.

> @@ -4056,14 +4061,10 @@ int panthor_group_create(struct drm_file *file,

[ ... ]

> @@ -4117,6 +4118,41 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
> =20
> +	if (group_args->protected_suspend_bo_handle) {
> +		struct drm_gem_object *obj;
> +
> +		/* Read a correct snapshot of the state */
> +		if (!panthor_fw_protm_is_inited(ptdev)) {
> +			ret =3D -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		obj =3D drm_gem_object_lookup(file, group_args->protected_suspend_bo_h=
andle);
> +		if (!obj) {
> +			ret =3D -ENOENT;
> +			goto err_put_group;
> +		}
> +
> +		if (obj->size < panthor_fw_protm_suspend_size(ptdev)) {
> +			drm_gem_object_put(obj);
> +			ret =3D -EINVAL;
> +			goto err_put_group;
> +		}
> +
> +		group->protm_suspend_buf =3D
> +			panthor_kernel_bo_create_from_gem(ptdev, panthor_fw_vm(ptdev),
> +							  to_panthor_bo(obj),
> +							  DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
> +							  PANTHOR_VM_KERNEL_AUTO_VA,
> +							  panthor_fw_protm_suspend_size(ptdev));
> +		drm_gem_object_put(obj);
> +		if (IS_ERR(group->protm_suspend_buf)) {
> +			ret =3D PTR_ERR(group->protm_suspend_buf);
> +			group->protm_suspend_buf =3D NULL;
> +			goto err_put_group;
> +		}
> +	}

[Severity: High]
Does panthor_group_create() verify that protected_suspend_bo_handle is an
imported DMA-BUF and prevent it from being mapped elsewhere or shared
across groups?

The UAPI comment for struct drm_panthor_group_create states that
protected_suspend_bo_handle must be allocated from a protected DMA-BUF
heap and imported into Panthor, but neither panthor_group_create() nor
panthor_kernel_bo_create_from_gem() checks drm_gem_is_imported(obj).  A
user can pass a normal shmem BO created via DRM_IOCTL_PANTHOR_BO_CREATE
(with flags =3D=3D 0 and exclusive_vm_id =3D=3D 0), mapping a CPU-mmappable=
 buffer
into panthor_fw_vm(ptdev) as the MCU's protected suspend buffer, or pass
the same handle to multiple groups and user GPU VMs so multiple CSG slots
alias the same suspend buffer in the firmware address space.

[Severity: Medium]
Can panthor_kernel_bo_create_from_gem() dereference a NULL vm pointer or
leak a pin reference if panthor_fw_unplug() runs concurrently with or
before group teardown?

CPU0                                     CPU1
panthor_group_create()
  panthor_fw_alloc_suspend_buf_mem()
                                         panthor_device_unplug()
                                           ...
                                           panthor_fw_unplug()
                                             ptdev->fw->vm =3D NULL;
  panthor_kernel_bo_create_from_gem(
    ptdev, panthor_fw_vm(ptdev), ...)
    /* vm is NULL */
    if (vm =3D=3D panthor_fw_vm(ptdev))
      panthor_gem_pin(bo);
    panthor_vm_page_size(vm)
      <-- NULL pointer dereference

panthor_group_create() does not enter a drm_dev_enter() critical section
before reading panthor_fw_vm(ptdev), and unlike panthor_kernel_bo_create(),
panthor_kernel_bo_create_from_gem() (added in commit "drm/panthor: Create
kernel BO from existing GEM") does not check for !vm.  If
panthor_fw_unplug() clears ptdev->fw->vm first, vm =3D=3D panthor_fw_vm(ptd=
ev)
evaluates NULL =3D=3D NULL as true, pins bo, and crashes in
panthor_vm_page_size(NULL).

In addition, panthor_kernel_bo_destroy() checks vm =3D=3D panthor_fw_vm(ptd=
ev)
instead of panthor_vm_for_mcu(vm), so if a group with protm_suspend_buf is
destroyed after panthor_fw_unplug() sets ptdev->fw->vm to NULL,
panthor_gem_unpin() is skipped and the BO remains pinned.

[Severity: Low]
Should add_group_kbo_sizes() still add group->protm_suspend_buf->obj->size
to group->fdinfo.kbo_sizes now that protm_suspend_buf is backed by a
user-supplied GEM handle?

drivers/gpu/drm/panthor/panthor_sched.c:add_group_kbo_sizes() {
    ...
	if (group->protm_suspend_buf)
		group->fdinfo.kbo_sizes +=3D group->protm_suspend_buf->obj->size;
}

group->fdinfo.kbo_sizes tracks internal driver-owned private kernel BOs
that are not exposed through a DRM handle.  Because
protected_suspend_bo_handle is a user GEM handle already accounted by
drm_show_memory_stats(), counting it in kbo_sizes as well inflates
panthor-resident-memory and panthor-active-memory in fdinfo.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116112601.3483=
649-1-ketil.johnsen@arm.com?part=3D12
