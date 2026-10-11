Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2998DCA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B75710E0AC;
	Sun, 11 Oct 2026 17:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OEmLQX7o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228E710E0AC
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:56:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B12D600E2;
 Sun, 11 Oct 2026 17:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DEB1F0089B;
 Sun, 11 Oct 2026 17:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791741405;
 bh=ewCpzS2s4tOwMYP/OxFl8kzWh/42xhfpOANzWNUdJss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OEmLQX7o0RsdylKtVrxN/3ZD4Ut4W81az7Y6vd7H9TY/QHKeZ/2DyXu6Vv19vAPwn
 7ODV53D7X6k2S/VnZhBG8dpmhbO1bJyR7qebYdmyMeA7ty/RO7uYkaPfCLaBwBuPyq
 S623aVXhjZkuXy1qFEqHhqdvldhvICVrbn4alovcnNTyHazRMmnI/0qcyhU8rE5+qU
 ks8vUnzOlC9aaOEdeZcSJoE84Nf98XNjaDa7oXnX/D34TWuYIKwclR7NlXeScrP1xK
 iSOLTTIpgvl1UIQPY5P2E81ZQRca8xkYWxe1ZzliXQw0AJ+6DTdKYs0FNucFGwbSaZ
 2tXqIPguGq/zg==
Message-ID: <sashiko-outbox-167363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/8] drm/panthor: Implement sample handling
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011-panthor-performance-counters-v7-6-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-6-12c32495062f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 17:56:44 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] drm: Integer overflow in user_sample_size bypasses BO size val=
idation
- [High] drm: 64-bit division by variable size_t breaks 32-bit builds
- [High] workqueue: CPU hog due to immediate requeueing in panthor_perf_sam=
ple_worker during reset
- [High] drm: Unbounded loop in panthor_perf_handle_fw_samples allows firmw=
are to hang kernel
- [High] drm: Incompatible pointer type in bitmap_from_arr64 corrupts memor=
y on 32-bit big-endian
- [High] drm: panthor_perf_pool_destroy leaks session pool and PM reference=
s on unplug
- [High] drm: panthor_perf_session_destroy fails to re-enable global FW sam=
pling
- [High] drm: Missing memory barriers in FW ringbuffer communication
- [High] drm: sleeping lock in wait_event_timeout condition triggers might_=
sleep() warning
- [High] drm/panthor: UAF and NULL-deref when device unplug races with file=
 close
- [Medium] drm: Timestamp accumulation zeroed out by skipped blocks
- [Medium] drm: Undefined behavior in BLK_MASK macro when argument is zero
- [Medium] drm/panthor: memory and pm runtime leak in panthor_perf_pool_des=
troy()
--

commit 3f117df9269c8346ebf5d90d19e892acc18e5210
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panthor: Implement sample handling

Adds performance counter sample handling for the Panthor driver. It
introduces a ring buffer for firmware-to-kernel sample communication,
handles interrupts for new samples or overflows, and accumulates partial
hardware samples into a user-facing buffer.

> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/pan=
thor/panthor_perf.c
> index 76c3469811508..c66ad658a95db 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
[ ... ]
>  static void panthor_perf_handle_fw_samples(struct panthor_device *ptdev,
>  					   u32 extract_idx, u32 insert_idx)
>  {
>  	struct panthor_perf *perf =3D ptdev->perf;
>  	const size_t ann_block_size =3D
>  		get_annotated_block_size(ptdev->perf_info.counters_per_block);
>  	u32 i;
> =20
>  	for (i =3D extract_idx; i !=3D insert_idx; i++) {

[Severity: High]
Are there any bounds checks on extract_idx and insert_idx? Since these
come directly from untrusted firmware shared memory, could a malicious or
buggy firmware return a bogus insert_idx (e.g., extract_idx + U32_MAX)
that forces this loop to execute billions of times, permanently stalling the
kernel worker thread?

[ ... ]
> +#define BLK_MASK(x) GENMASK_ULL((x) - 1, 0)
> +
> +static u64 get_sc_mask(struct panthor_device *ptdev)
> +{
[ ... ]
> +static int panthor_perf_setup_fw_buffer(struct panthor_device *ptdev, st=
ruct panthor_perf *perf)
> +{
[ ... ]
> +	const struct panthor_perf_fw_block blocks[DRM_PANTHOR_PERF_BLOCK_MAX] =
=3D {
> +		[DRM_PANTHOR_PERF_BLOCK_METADATA] =3D {
> +			.block_count =3D has_metadata ? 1 : 0,
> +			.phys_mask =3D has_metadata ? BIT_ULL(0) : 0,
> +		},
> +		[DRM_PANTHOR_PERF_BLOCK_FW] =3D {
> +			.block_count =3D info->fw_blocks,
> +			.phys_mask =3D info->fw_blocks ? BLK_MASK(info->fw_blocks) : 0,
> +		},
> +		[DRM_PANTHOR_PERF_BLOCK_CSHW] =3D {
> +			.block_count =3D info->cshw_blocks,
> +			.phys_mask =3D BLK_MASK(info->cshw_blocks),
> +		},

[Severity: Medium]
If any hardware capabilities (like info->cshw_blocks, tiler_blocks, or
memsys_blocks) have a count of 0, does BLK_MASK(0) expand to
GENMASK_ULL(0 - 1, 0)? Passing -1 (or ULLONG_MAX) as the high bit
argument to GENMASK_ULL triggers an invalid shift and undefined behavior.
Should these usages have a ternary guard for zero similar to how
info->fw_blocks is protected?

[ ... ]
> +static void session_accumulate_sample(struct panthor_device *ptdev,
> +				      struct panthor_perf_session *session,
> +				      u8 *session_sample, u8 *perf_sample)
> +{
> +	const struct drm_panthor_perf_info *const perf_info =3D &ptdev->perf_in=
fo;
> +	struct panthor_perf_enable_masks *em =3D session->enabled_counters;
> +	struct panthor_perf_sample_block_iter iter;
> +	const u32 counters =3D perf_info->counters_per_block;
> +
> +	sample_block_iter_init(perf_info, perf_sample, session_sample, &iter);
> +
> +	while (sample_block_iter_next(&iter)) {
> +		DECLARE_BITMAP(enabled_ctrs, PANTHOR_PERF_EM_BITS);
> +		const struct panthor_perf_counter_block *src_blk =3D iter.src_blk;
> +		struct panthor_perf_counter_block *dst_blk =3D iter.dst_blk;
> +
> +		bitmap_from_arr64(enabled_ctrs, em->mask[dst_blk->header.block_type],
> +				  PANTHOR_PERF_EM_BITS);

[Severity: High]
bitmap_from_arr64() expects a const u64 * source, but em->mask[type]
is declared as an unsigned long array. On 32-bit big-endian architectures,
reading a 64-bit integer from a pair of 32-bit unsigned long values
effectively swaps the two words. Will this silently scramble the entire
enable mask?

> +		bitmap_clear(enabled_ctrs, 0, PANTHOR_HEADER_COUNTERS);
> +
> +		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =3D
> +			src_blk->counters[PANTHOR_CTR_TIMESTAMP_HI];
> +		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =3D
> +			src_blk->counters[PANTHOR_CTR_TIMESTAMP_LO];

[Severity: Medium]
Because the intermediate buffer perf->sample is completely zeroed out at
the end of each worker run, if the firmware did not produce a sample for a
given block in the current batch (prfcnt_en =3D=3D 0), its block remains all
zeros.

Since this unconditionally copies timestamps from the intermediate block,
will this overwrite the session's previously accumulated valid timestamp
with zero?

[ ... ]
> +static void session_copy_sample(struct panthor_device *ptdev,
> +				struct panthor_perf_session *session, u32 flags)
> +{
[ ... ]
> +	new_sample =3D session->samples + (insert_idx % session->ringbuf_slots)=
 * sample_size;

[Severity: High]
Because insert_idx is a u64 and session->ringbuf_slots is a size_t,
does this perform a 64-bit by 32-bit modulo operation on 32-bit
architectures? This can result in a link-time error (__umoddi3 undefined).
Since ringbuf_slots is guaranteed to be a power of two during creation,
could this be optimized to a bitwise AND
(insert_idx & (session->ringbuf_slots - 1)) to avoid the division entirely?

[ ... ]
> +static void panthor_perf_sample_worker(struct work_struct *work)
> +{
> +	struct panthor_perf *perf =3D container_of(work, struct panthor_perf, s=
ample_work);
> +	struct panthor_device *const ptdev =3D perf->ptdev;
> +	struct panthor_fw_global_iface *glb_iface =3D panthor_fw_get_glb_iface(=
ptdev);
> +	const u32 extract_idx =3D READ_ONCE(glb_iface->input->perfcnt_extract);
> +	const u32 insert_idx =3D READ_ONCE(glb_iface->output->perfcnt_insert);
> +	const u32 ack =3D READ_ONCE(glb_iface->output->ack);
> +	const u32 req =3D READ_ONCE(glb_iface->input->req);
> +	const u32 events =3D (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT=
_OVERFLOW);
> +	const u32 flags =3D events & GLB_PERFCNT_OVERFLOW ? DRM_PANTHOR_PERF_SA=
MPLE_OVERFLOW : 0;
> +
> +	/* Defer sample processing until the pending reset completes. */
> +	if (panthor_device_reset_is_pending(ptdev)) {
> +		queue_work(perf->sample_workq, &perf->sample_work);
> +		return;
> +	}

[Severity: High]
Since sample_workq is created with WQ_HIGHPRI | WQ_UNBOUND, does
immediately re-queueing the work create a tight busy-loop? Could this pin a
CPU at 100% utilization until the reset completes, potentially starving the
reset handler itself? Would it be safer to use queue_delayed_work() or
rely on the reset handler to kick the queue?

> +
> +	/* A stale notification must not complete a userspace sample request. */
> +	if (extract_idx =3D=3D insert_idx)
> +		goto ack_events;
> +
> +	panthor_perf_handle_fw_samples(ptdev, extract_idx, insert_idx);
> +	WRITE_ONCE(glb_iface->input->perfcnt_extract, insert_idx);

[Severity: High]
Is an smp_rmb() needed before parsing the payload in
panthor_perf_handle_fw_samples()? The architecture's weakly-ordered memory
model might permit the CPU to speculatively load sample data before the
insert_idx read guarantees the data is fully written.

Similarly, is an smp_wmb() required before the WRITE_ONCE updates
perfcnt_extract, to ensure all payload reads complete before the firmware
reclaims the slots?

[ ... ]
> +static int panthor_perf_request_sync(struct panthor_perf *perf,
> +				     struct panthor_perf_session *session, session_state_cb cb)
> +{
> +	int ret;
> +
> +	perf_fw_request_sample(perf);
> +
> +	ret =3D wait_event_timeout(session->state_wq, cb(session),
> +				 msecs_to_jiffies(1000));

[Severity: High]
wait_event_timeout() explicitly sets the task state to
TASK_UNINTERRUPTIBLE before evaluating its condition. The condition
callbacks (like session_is_stopped_locked and
session_is_active_locked) unconditionally acquire a sleeping lock
(mutex) via guard(mutex).

Does calling a sleeping lock while the task state is not TASK_RUNNING
violate kernel scheduling rules and trigger might_sleep() kernel warnings
every time the condition is checked?

Furthermore, if the mutex is contended, the slowpath overwrites the task
state back to TASK_RUNNING. When the condition callback returns false,
schedule_timeout() is called with TASK_RUNNING, causing it to return
immediately without sleeping and create a busy-wait loop.

[ ... ]
> +int panthor_perf_session_create(struct drm_file *file,
> +				struct drm_panthor_perf_session_create *create_args,
> +				unsigned long *sid)
> +{
[ ... ]
> +	user_sample_size =3D ptdev->perf_info.sample_size * slots;
> +
> +	ret =3D panthor_perf_bo_get(file, create_args->ringbuf_handle,
> +				  user_sample_size, &ringbuffer);

[Severity: Critical]
Userspace provides create_args->sample_slots, which is validated only by
is_power_of_2(). Could slots be large enough that multiplying it by
ptdev->perf_info.sample_size overflows the 32-bit size_t
user_sample_size on 32-bit platforms, wrapping it to 0?

If it wraps to 0, panthor_perf_bo_get() bypasses size validation entirely
because of the "if (expected_size && ...)" check. Does this bind a massive
slots count to a maliciously small GEM BO, allowing out-of-bounds memory
corruption when the worker emits data?

[ ... ]
> +int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
> +{
[ ... ]
> +		xa_erase(&pfile->sessions->xa, handle);
> +		ret =3D perf_disable(perf);
> +
> +		scoped_guard(mutex, &perf->session_lock)
> +			perf_detach_session(perf, session);
> +	}
> =20
>  	session_put(session);

[Severity: High]
After stopping firmware sampling via perf_disable(perf) and detaching the
session, this function neglects to call perf_enable(perf). If a single
session is destroyed by userspace, does this permanently stop firmware
sampling globally and starve all remaining active sessions of data?

[ ... ]
>  void panthor_perf_unplug(struct panthor_device *ptdev)
>  {
> +	int ret;
>  	struct panthor_perf *perf =3D ptdev->perf;
> =20
>  	if (!perf)
>  		return;
> =20
> +	scoped_guard(mutex, &perf->op_lock)
> +		ret =3D perf_disable(perf);
> +	if (ret)
> +		drm_err(&perf->ptdev->base, "Failed to disable performance counter sam=
pling!");
> +
> +	disable_work_sync(&perf->sample_work);
> +
> +	panthor_kernel_bo_vunmap(perf->rb);
> +	panthor_kernel_bo_destroy(perf->rb);
> +
>  	ptdev->perf =3D NULL;
>  }

[Severity: High]
If panthor_device_unplug() runs concurrently with the closing of a DRM
file descriptor containing multiple sessions, could panthor_postclose()
safely bypass ioctl synchronization?

If panthor_perf_unplug() frees perf->rb and clears ptdev->perf to
NULL while panthor_perf_pool_destroy() is iterating, could xa_for_each()
either pass a NULL pointer to panthor_perf_session_remove() (causing a
panic) or call perf_enable() on the freed perf->rb, triggering a
use-after-free when writing its virtual address to the device register?

[ ... ]
>  void panthor_perf_pool_destroy(struct panthor_file *pfile)
>  {
>  	struct panthor_perf_pool *pool =3D pfile->sessions;
>  	unsigned long handle;
>  	struct panthor_perf_session *session;
> =20
>  	if (IS_ERR_OR_NULL(pool))
>  		return;
> =20
> +	if (!pfile->ptdev->perf)
> +		return;
> +
>  	xa_for_each(&pool->xa, handle, session) {
>  		xa_erase(&pool->xa, handle);
> +		panthor_perf_session_remove(pfile->ptdev->perf, session);
>  		session_put(session);
> +		pm_runtime_put_sync(pfile->ptdev->base.dev);
>  	}
> =20
>  	xa_destroy(&pool->xa);

[Severity: Medium]
If panthor_device_unplug() has already cleared ptdev->perf to NULL,
this early return completely bypasses the xa_for_each() cleanup loop.

Does this result in a persistent memory leak of the xarray, all active
panthor_perf_session objects, the pool structure itself, and the
associated Power Management (PM) runtime references taken during session
creation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-panthor-pe=
rformance-counters-v7-0-12c32495062f@arm.com?part=3D6
