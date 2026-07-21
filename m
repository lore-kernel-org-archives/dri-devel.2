Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9845C44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BBC10E649;
	Tue, 21 Jul 2026 07:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXlaZcOT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A5E10E2E2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D0DF43B1C;
 Tue, 21 Jul 2026 07:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9011F000E9;
 Tue, 21 Jul 2026 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618276;
 bh=fCSJLrM3wpF4ZT3rSwFQBI0szIx432J0fxBl0Ud7i/Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bXlaZcOTyst7TR/Uw0badkW7pSfYRemCHNze7qoDVHPAneTxSm97tKTwquLFjBCmu
 vAYgtmMMfCtxX6iAegxWQGaXs1KBznNjzi/AWP0/qwiMBEiDmZK9M3veygMxl2RtNE
 AQShhCXGG4ip+TgY67khsbn+47VTuGSEru82vNesRkS5Xo2+oN8v6Ka434xlxmTn43
 gWnnZ8IrC/9KhHQghbc7kdRXfAuRhINGAURLMYRIKDgcXQd38O+NwXr9olsTWlP4+n
 +j03lZrcVU2ZJ4CkLNNKL9ANAZNDCC9s9rGPIjY45DdZx3/uAO/6hiCvy+1OBCaYdm
 8Rd/DZBex5CTw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 07/13] drm/amdkfd: add knod provider core
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <20260719175857.4071636-8-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-8-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:55 +0000
Message-Id: <20260721071755.EE9011F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 22 potential issue=
(s) to consider:
- [Critical] Reliance on a user-space binary (/bin/sleep) to provide a proc=
ess context for the GPU network offload core.
- [Critical] Vulnerability to PID recycling in `stop_umh()`, leading to pot=
ential arbitrary process termination.
- [High] Hardcoded VFS path lookup from kernel space to open DRM render nod=
es makes the core vulnerable to namespace spoofing.
- [High] AMDGPU ring buffer write pointers are defined as 32-bit signed int=
egers instead of `u64`, causing sign-extension corruption.
- [High] Global `accels` array is overwritten when multiple AMD GPUs are in=
itialized.
- [High] Array bounds overflow for queue structures due to `NR_CPUS` vs `KN=
OD_MAX_QUEUE_CNT` mismatch.
- [High] GPU memory allocated by `__knod_alloc_mem` is silently leaked upon=
 free.
- [High] GPU virtual addresses are passed as `__user` pointers to KFD queue=
 creation.
- [High] The KFD process and MMU notifier are leaked on initialization erro=
r paths in `knod_alloc_ctx_init` and `knod_alloc_ctx`.
- [High] Hardcoded access to `pdds[0]` causes index mismatches on multi-GPU=
 systems.
- [High] SDMA queue GPU memory is not explicitly zeroed, causing the hardwa=
re engine to execute garbage commands.
- [High] `knod_exit()` tears down knod contexts without stopping the backgr=
ound worker thread, leading to a Use-After-Free.
- [High] Concurrent modification of a single SDMA ring buffer across multip=
le CPUs.
- [High] Modifying `accel_ops.xdp_ops` during per-device feature activation=
 overrides features for all devices system-wide.
- [High] Unprotected concurrent modifications to the global `ctx_list`.
- [High] Data race between MMU notifier cleanup and KNOD's explicit queue t=
eardown.
- [High] Concurrent feature lifecycle operations can lead to a data race on=
 `knod->worker`, causing multiple threads to simultaneously stop the same k=
thread.
- [High] Hardware packets and descriptors are written to GPU memory using h=
ost native endianness instead of little-endian.
- [High] A memory barrier is missing before writing to the AQL doorbell, wh=
ich can cause the GPU to observe a stale dispatch ID.
- [Medium] Lack of locking in `knod_accel_xdp_register()` allows it to race=
 with `knod_attach()`, causing missed XDP initialization.
- [Medium] `knod_init` returns 0 (success) on allocation failure, causing s=
ilent failures during accelerator initialization.
- [Low] A typo in the endianness conditional macro for `knod_aql_rsrc1` cau=
ses the struct to be empty on big-endian architectures.
--

--- Patch [7]: [RFC PATCH net-next 07/13] drm/amdkfd: add knod provider cor=
e ---
commit 3676145304477ec735999c96871ed634c55e8b47
Author: Taehee Yoo <ap420073@gmail.com>

drm/amdkfd: add knod provider core

This patch introduces the knod accelerator provider into amdgpu. It allocat=
es
and drives GPU AQL/SDMA queues, manages GPU memory for the RX data path, and
registers a knod accelerator that binds to a NIC via the knod core.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_knod.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_knod.c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_knod.c
> @@ -0,0 +1,2202 @@

[ ... ]

> +static int launch_and_get_pid(void)
> +{
> +	static const char * const argv[] =3D { "/bin/sleep", "2147483647", NULL=
 };

[Severity: Critical]
Is it safe to rely on a user-space binary to provide the process context?

The core uses call_usermodehelper_exec() to launch /bin/sleep to bind the
KFD GPU context. If the /bin/sleep process is killed by an administrator, t=
he
OOM killer, or exits unexpectedly, the KFD MMU notifier will asynchronously
tear down the GPU resources locklessly.

Can this lead to a severe crash in the network driver?

[ ... ]

> +static void stop_umh(pid_t umh_pid)
> +{
> +	struct pid *p =3D find_get_pid(umh_pid);
> +
> +	if (!p)
> +		return;
> +
> +	kill_pid(p, SIGKILL, 1);
> +	put_pid(p);
> +}

[Severity: Critical]
Is there a risk of terminating unrelated processes due to PID recycling?

When the KNOD context is released, stop_umh() looks up the user mode helper
process by its numeric PID and unconditionally sends a SIGKILL.

Because knod_alloc_ctx() drops the safe struct pid reference immediately
after creation, if the original helper process exited prematurely, its PID
might have been reassigned. Could detaching the network device
unintentionally kill an innocent process?

[ ... ]

> +struct knod_mem *__knod_alloc_mem(struct knod *knod, size_t size,
> +				  int flags)
> +{
[ ... ]
> +	err =3D amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(kdev->adev, mem->gaddr,
> +						      size, pdd->drm_priv,
> +						      &mem->mem, NULL, flags,
> +						      false);

[Severity: High]
Does this code leak GPU memory when the packets are freed?

Looking at __knod_alloc_mem(), it uses
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu() directly which bypasses the KFD
tracking list.

However, knod_free_mem() uses kfd_process_free_gpuvm() which expects the
memory to be in the process tracking list. If it is not found, will the GPU
memory remain permanently leaked?

[ ... ]

> +void knod_sdma_copy(struct knod *knod, u64 dst_offset,
> +		    u64 src_offset, int idx, int size)
> +{
> +	struct knod_sdma *sdma =3D &knod->sdma[idx];
> +	u32 ring_mask =3D (sdma->sdma->size / 4) - 1;
> +	u64 *wptr =3D (u64 *)sdma->queue->kaddr + 1;
> +	u32 *ptr =3D sdma->sdma->kaddr;
> +
> +	ptr[sdma->idx++ & ring_mask] =3D SDMA_PKT_HEADER_OP(SDMA_OP_COPY) |
> +		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
> +		SDMA_PKT_COPY_LINEAR_HEADER_TMZ((0));

[Severity: High]
Can this sequence cause data races and ring buffer corruption?

This function is called from NAPI context by multiple RX queues concurrentl=
y,
but it increments the software write cursor (sdma->idx++) and writes to the
ring buffer without locks or atomic operations.

[Severity: High]
Are these descriptors written to the GPU in the correct byte order?

AMDGPU hardware typically expects ring buffer packets to be formatted in
little-endian. Writing multi-byte fields directly using native host
endianness might cause the hardware to interpret garbage commands on
big-endian systems. Should helpers like cpu_to_le32() be used here?

[ ... ]

> +static void knod_destroy_one_queue(struct knod *knod, int idx)
> +{
[ ... ]
> +	if (knod->aql_queue_created[idx]) {
> +		int ret;
> +
> +		ret =3D knod_destroy_queue(knod->process,
> +					 knod->aql_queue_id[idx]);

[Severity: High]
Does this manual queue teardown race with the lockless MMU notifier cleanup?

If the dummy /bin/sleep process is killed, mmu_notifier_release() will
call pqm_uninit() which locklessly iterates over and frees pqm->queues.

If the KNOD framework concurrently initiates cleanup via
knod_destroy_queue(), which locks p->mutex and deletes queues from the exact
same list, could this lead to list corruption and double-freeing of
process_queue_node structures?

[ ... ]

> +static int knod_alloc_one_queue(struct knod *knod, int idx,
> +				struct kfd_topology_device *topo_dev,
> +				struct kfd_process_device *pdd, void *ptr)
> +{
[ ... ]
> +	qp.write_ptr =3D
> +		(void __user *)((u64)knod->kaql[idx].queue->gaddr + 0x38);
> +	qp.read_ptr =3D (void __user *)((u64)knod->kaql[idx].queue->gaddr + 0x8=
0);

[Severity: High]
Can casting a GPU virtual address to a user-space CPU address cause faults?

KFD queue management uses get_user() and put_user() on these pointers. Since
the raw GPU virtual address has no CPU mapping in the user process, won't
this trigger an -EFAULT page fault during queue creation or sync operations?

[ ... ]

> +static void knod_stop_worker(struct knod *knod)
> +{
> +	if (!knod->worker)
> +		return;
> +
> +	if (knod->flush_fn)
> +		knod->flush_fn(knod->worker_ctx);
> +
> +	kthread_stop(knod->worker);
> +	put_task_struct(knod->worker);

[Severity: High]
Is there a data race here that could lead to a double-free of the task stru=
ct?

knod_stop_worker() checks and modifies knod->worker without holding any
locks. If feature transitions and module unload invoke this concurrently, t=
wo
threads could simultaneously pass the if (!knod->worker) check.

Both would then call kthread_stop() and put_task_struct() on the same task
structure, potentially dropping the refcount to zero prematurely.

[ ... ]

> +static int knod_alloc_ctx_init(struct knod *knod, int id, void **doorbel=
l,
> +			       struct kfd_topology_device **out_topo_dev,
> +			       struct kfd_process_device **out_pdd)
> +{
> +	struct kfd_topology_device *topo_dev;
> +	struct kfd_process_device *pdd;
> +	struct file *drm_file;
> +	size_t mem_size;
> +	char path[64];
> +	int err;
> +
> +	sprintf(path, "/dev/dri/renderD%d", id);
> +
> +	drm_file =3D filp_open(path, O_RDWR, 0);

[Severity: High]
Does this hardcoded VFS path lookup introduce a namespace spoofing risk?

The initialization path uses filp_open() from kernel space to obtain a stru=
ct
file for the DRM device, which resolves in the user-space mount namespace.

If an unprivileged user in a user namespace bind-mounts a malicious file
over /dev/dri/renderD0, could this lead to arbitrary kernel memory read/wri=
te
when AMDGPU casts filp->private_data without validating the inode?

[ ... ]

> +	pdd =3D knod->process->pdds[0];

[Severity: High]
Will unconditionally accessing pdds[0] fail on multi-GPU systems?

This hardcodes access to the first AMD GPU, regardless of the renderD node
passed to knod_alloc_ctx_init().

On a system with multiple GPUs, would this result in initializing the VM of
GPU 0 with the DRM file of a different GPU?

[ ... ]

> +err_unref_process:
> +	kfd_unref_process(knod->process);
> +err_filp_close:
> +	fput(knod->drm_file);
> +	return err;
> +}

[Severity: High]
Are the KFD process and MMU notifier leaked on this error path?

The setup code earlier takes two references to the KFD process, but
kfd_unref_process() is only called once here.

Additionally, kfd_process_notifier_release_internal() is omitted. Will this
leave the process permanently embedded in KFD's hash tables and mmu_notifier
tracking?

[ ... ]

> +struct knod *knod_alloc_ctx(struct knod_dev *knodev, int queue_cnt, int =
id,
> +			    int channels)
> +{
[ ... ]
> +	for (idx =3D 0; idx < knod->sdma_cnt; idx++) {
[ ... ]
> +		knod->sdma[idx].sdma =3D knod_alloc_mem(knod, PAGE_SIZE << 4,
> +			KFD_IOC_ALLOC_MEM_FLAGS_GTT |
> +			KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE |
> +			KFD_IOC_ALLOC_MEM_FLAGS_COHERENT |
> +			KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED |
> +			KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE);

[Severity: High]
Can the hardware engine execute garbage commands here?

Unlike the AQL queues which use memset() to clear the memory, the SDMA queue
memory (sdma, queue, and queue_signal) allocated here is not explicitly
zeroed.

When this queue is submitted to the hardware, could the command processor
read uninitialized read/write pointers and execute random garbage memory?

[ ... ]

> +	list_add_tail(&knod->list, &ctx_list);

[Severity: High]
Is it safe to modify the global ctx_list without holding a lock?

knod_alloc_ctx() adds the newly allocated context to the global ctx_list
via list_add_tail(), and knod_release_ctx() removes it via list_del().

Neither of these operations appears to be protected by spinlocks or mutexes,
which could lead to list corruption if multiple interfaces are attached or
detached concurrently.

[ ... ]

> +void knod_release_ctx(struct knod *knod)
> +{
> +	int idx;
> +
> +	list_del(&knod->list);
[ ... ]
> +	kfree(knod);
> +}

[Severity: High]
Does tearing down the context here leave the worker thread running?

Neither knod_exit() nor knod_release_ctx() calls knod_stop_worker().
If the module is unloaded while a knod context is still active, the active
knod->worker kthread might be left running in the background and could
immediately dereference the freed knod context, causing a Use-After-Free.

[ ... ]

> +static int knod_feature_activate(struct knod *knod)
> +{
[ ... ]
> +		/*
> +		 * Publish xdp_ops, then phase B: register the offload dev so
> +		 * user XDP progs/maps can bind (their install/free route
> +		 * through accel_ops.xdp_ops->xdp_install).
> +		 */
> +		WRITE_ONCE(accel_ops.xdp_ops, registered_xdp_ops);

[Severity: High]
Will this override the features for all devices system-wide?

accel_ops is a single static global instance shared among all registered
knod_accel contexts. Modifying accel_ops.xdp_ops during a per-device
feature activation will immediately alter the operations for all other
devices concurrently.

[ ... ]

> +static u32 knod_accel_d2h_submit(struct knod_dev *knodev, u64 dst, int q=
ueue,
> +				 u32 page_idx, u16 off, u32 len)
> +{
> +	struct knod *knod =3D knodev->accel->priv;
> +	struct knod_sdma_copy_desc c;
> +
> +	/* The netmem page_pool dma_addr is the NIC address; SDMA needs
> +	 * the GPU VM address, so derive the source from buf[queue].
> +	 */
> +	c.src =3D knod->buf[queue]->gaddr + ((u64)page_idx << PAGE_SHIFT) + off;
> +	c.dst =3D dst;
> +	c.len =3D len;
> +	return knod_sdma_submit(knod, 0, &c, 1);

[Severity: High]
Does hardcoding the SDMA queue index to 0 cause concurrent modifications?

knod_accel_d2h_submit() passes 0 for the SDMA queue index to
knod_sdma_submit().

Because this is called from NAPI context by multiple RX queues concurrently,
it will result in data races and corrupted SDMA ring buffers across multiple
CPUs.

[ ... ]

> +void knod_accel_xdp_register(struct knod_accel_xdp_ops *xdp_ops)
> +{
> +	int i;
> +
> +	/*
> +	 * Module load advertises the feature and sets up the permanent
> +	 * per-attach state (bpf_offload_dev) on already-attached accels;
> +	 * GPU compute resources wait for ->activate() on feature select.
> +	 */
> +	WRITE_ONCE(registered_xdp_ops, xdp_ops);

[Severity: Medium]
Is there a race condition with knod_attach() here due to a lack of locking?

knod_accel_xdp_register() writes to registered_xdp_ops and iterates over
accels[i]->knodev without synchronization.

If a device is attaching simultaneously, knod_attach() might read
registered_xdp_ops as NULL, while knod_accel_xdp_register() sees
accel->knodev before it is fully initialized, potentially missing the
initialization or crashing.

[ ... ]

> +int knod_init(struct amdgpu_device *adev)
> +{
> +	int base_id =3D adev_to_drm(adev)->render->index * KNOD_MAX_AQL;
> +	struct knod_accel *accel;
> +	int i, n;
> +
> +	n =3D KNOD_MAX_AQL;
> +
> +	for (i =3D 0; i < n; i++) {
> +		accel =3D kzalloc_obj(struct knod_accel, GFP_KERNEL);
> +		if (!accel) {
> +			pr_err("knod: Failed to allocate accel node %d\n", i);
> +			goto err;
> +		}
> +
> +		INIT_LIST_HEAD(&accel->list);
> +		accel->type =3D KNOD_TYPE_GPU;
> +		accel->accel_ops =3D &accel_ops;
> +		accel->owner =3D THIS_MODULE;
> +		accel->id =3D base_id + i;
> +		snprintf(accel->name, sizeof(accel->name), "amdgpu-%d", i);
> +		knod_accel_register(accel);
> +		accels[i] =3D accel;

[Severity: High]
Does this unintentionally overwrite the global accels array for system GPUs?

The global accels array is populated based on index i (which loops 0 to
n - 1, where n is KNOD_MAX_AQL which is 1). Since knod_init() is called
per-device, it will unconditionally store the allocated context at accels[0=
].

On systems with multiple AMD GPUs, this overwrites accels[0], leaking the
previous GPU's context and preventing its teardown later.

> +	}
> +	nr_accels =3D n;
> +
> +	return 0;
> +
> +err:
> +	while (i-- > 0) {
> +		knod_accel_unregister(accels[i]);
> +		kfree(accels[i]);
> +		accels[i] =3D NULL;
> +	}
> +	return 0;
> +}

[Severity: Medium]
Should the error path return a negative error code instead of 0?

If kzalloc_obj() fails, the err label cleans up the allocations but
immediately returns 0. This masks the allocation failure from the upstream
caller, leading to silent failures and likely null-pointer dereferences
downstream.

> diff --git a/drivers/gpu/drm/amd/amdkfd/knod/kfd_knod.h b/drivers/gpu/drm=
/amd/amdkfd/knod/kfd_knod.h
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/knod/kfd_knod.h
> @@ -0,0 +1,270 @@
[ ... ]
> +union knod_aql_rsrc1 {
> +	struct {
> +#if defined(__LITTLE_ENDIAN)
> +		unsigned int base_address_hi : 16;
> +		unsigned int stride : 14;
> +		unsigned int cache_swizzle : 1;
> +		unsigned int swizzle_enable : 1;
> +#elif defined(__LITTLE_ENDIAN)

[Severity: Low]
Is the second elif directive a typo for big-endian architectures?

The conditional macro uses elif defined(__LITTLE_ENDIAN) again instead of
elif defined(__BIG_ENDIAN).

On a big-endian system, neither condition is met, leaving the struct
entirely empty and causing compilation errors.

[ ... ]

> +struct knod_aql {
> +	struct knod_mem *aql;
[ ... ]
> +	u64 *doorbell;
> +	int idx;
> +};

[Severity: High]
Can this signed 32-bit integer write pointer cause sign-extension corruptio=
n?

The AQL write pointer idx is declared as a signed int instead of a u64.
After enough operations, this pointer will overflow to a negative value.

In knod_setup_header(), this negative value will undergo sign-extension to
64 bits when written to the hardware doorbell via writeq(), which breaks the
hardware's monotonic expectation and violates AMDGPU subsystem rules.

[ ... ]

> +struct knod {
> +	struct list_head list;
[ ... ]
> +	struct knod_aql kaql[NR_CPUS];

[Severity: High]
Could this array sizing cause a heap buffer overflow?

The array fields for queue tracking are sized using NR_CPUS. However, in
knod_alloc_ctx(), the loop iterates up to queue_cnt, which can be up to
KNOD_MAX_QUEUE_CNT (32).

On kernel configurations where NR_CPUS is less than 32, this loop will
write out-of-bounds.

[ ... ]

> +static inline void
> +knod_setup_header(struct knod *knod,
> +		  const struct knod_dispatch_params *p, int q_idx)
> +{
> +	struct amd_queue *amd_queue =3D (struct amd_queue *)knod->kaql[q_idx].a=
md_queue->kaddr;
> +	int curr_idx =3D knod->kaql[q_idx].idx;
> +	int next_idx =3D curr_idx + 1;
> +	u64 *ptr =3D knod->kaql[q_idx].doorbell;
> +
> +	knod_setup_invalidate(knod, next_idx % knod->nr_aql_ring, q_idx);
> +	knod_setup_dispatch(knod, curr_idx % knod->nr_aql_ring, p, q_idx);
> +	WRITE_ONCE(amd_queue->write_dispatch_id, curr_idx);
> +	writeq(curr_idx, ptr);

[Severity: High]
Is a memory barrier needed before writing to the AQL doorbell?

While WRITE_ONCE prevents compiler reordering, it does not prevent CPU
reordering. The CPU can reorder the doorbell write so it becomes visible to
the hardware before the write_dispatch_id store reaches memory.

Should there be a wmb() before the writeq() to ensure the GPU does not
observe a stale dispatch ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D7
