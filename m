Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40871606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/FFKhyT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970AC11272D;
	Thu, 26 Nov 2026 21:31:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E73711272D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC5FE6117E;
 Thu, 26 Nov 2026 21:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6E71F000C1;
 Thu, 26 Nov 2026 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795728662;
 bh=uZl8aIYv6QUSmI1CZl2HEEVeCCIof2WQz6iKYR0/Igw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F/FFKhyT/yxPbZpajMI8VbKspl6NaN4iQH/h8ttk7xfCjTZwEOcPJPECpxl+w+kSZ
 ERD/o6u8mAelFAVdviU69qs5XukVfqdQ4GhQ1eaBBEWcvVhTgMnwB+7qyu4EeBh9c4
 l6T1ohimnWq1ijDh9DQcq/M9VgSBtgaeSBG8Aj3NA0sdz4tJqyc8DIU3CFrvlR7+0i
 BNnZGX8d1EtJMEamHfvMSXo9YiylHVBKECaYg8F9yt2ibwHqlnKExSiXLnh1bDgS4S
 c4Rz6FLA/nBZvYEAo68AhD1LHsyzonl8a1YtM5AodhVTUJd0lSBZTLvb6IWm188xGF
 4J0d8WADCbLXg==
Message-ID: <sashiko-outbox-236239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] drm/panthor: Implement performance counter
 firmware sampling
To: "Lukas Zapolskas" <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261126-panthor-performance-counters-v8-2-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
 <20261126-panthor-performance-counters-v8-2-6e7db0ec33f5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 21:31:01 +0000
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

Thank you for your contribution! Sashiko AI review found 20 potential
issues to consider:
- [High] drm/panthor: out-of-range GENMASK(32, 16) in
  GLB_PERFCNT_FW_SIZE()
- [High] drm/panthor: WQ_HIGHPRI busy-loop in
  panthor_perf_handle_fw_events()
- [High] drm/panthor: missing sample_work flush in perf suspend and
  pre-reset
- [High] drm/panthor: unsynchronized teardown in panthor_perf_unplug()
- [High] drm/panthor: panthor_perf_bo_get() drops iosys_map.is_iomem
  flag
- [High] drm/panthor: 64-bit modulo in session_copy_sample() breaks
  32-bit build
- [Medium] drm/panthor: leaked runtime PM refs in panthor_perf_unplug()
- [Medium] drm/panthor: raw pm_runtime_resume_and_get() in session
  create
- [Medium] drm/panthor: sample_start_ns clobbered in
  session_try_sample/stop()
- [Medium] drm/panthor: premature sample emission in
  panthor_perf_handle_fw_events()
- [Medium] drm/panthor: unsynchronized state and index access in
  session_copy_sample()
- [Medium] drm/panthor: sample request race in panthor_perf_report_irq()
- [Medium] drm/panthor: zeroed block timestamps in
  session_accumulate_sample()
- [Medium] drm/panthor: enable mask overwrite in
  panthor_perf_handle_fw_samples()
- [Medium] drm/panthor: pending perf sample lost across GPU reset in
  panthor_perf_post_reset()
- [Medium] drm/panthor: lost pending perf sample across reset and
  suspend/resume
- [Medium] drm/panthor: perf reset and suspend lose samples and wedge
  sessions
- [Medium] drm/panthor: race between panthor_perf_unplug() and
  panthor_perf_pool_destroy()
- [Low] drm/panthor: unused ringbuf slot macros disagree with
  perf_ringbuf_slots_set()
- [Low] drm/panthor: unreachable stopping check in session_try_sample()
--

commit af99224f8a37db1bdbdbaef8c01eeb9aff21b441
Author: Lukas Zapolskas <lukas.zapolskas@arm.com>

drm/panthor: Implement performance counter firmware sampling

This commit implements performance counter firmware ringbuffer setup,
interrupt handling, sample accumulation, and session state transitions for
Panthor.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panth=
or/panthor_fw.h
> index 534cbe79a4f1a..2b095f9b38430 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -198,9 +198,12 @@ struct panthor_fw_global_control_iface {
>  	u32 output_va;
>  	u32 group_num;
>  	u32 group_stride;
> -#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
> +#define GLB_PERFCNT_FW_SIZE(x) (((x) & GENMASK(32, 16)) >> 8)
> +#define GLB_PERFCNT_HW_SIZE(x) (((x) & GENMASK(15, 0)) << 8)
>  	u32 perfcnt_size;

[Severity: High]
Should GLB_PERFCNT_FW_SIZE() use GENMASK(31, 16) instead of
GENMASK(32, 16)?  perfcnt_size is a u32, and on 32-bit builds
GENMASK(32, 16) shifts by BITS_PER_LONG - 1 - 32 (-1), failing the build
with -Wshift-count-negative.

> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/pan=
thor/panthor_perf.c
> index a4167bbc33adc..be2618ae31070 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c

[ ... ]

> +/**
> + * PANTHOR_PERF_RINGBUF_SLOTS_MIN - The minimum permitted number of slot=
s in the Panthor perf
> + *                                  ring buffer.
> + */
> +#define PANTHOR_PERF_RINGBUF_SLOTS_MIN (16)
> +
> +/**
> + * PANTHOR_PERF_RINGBUF_SLOTS_MAX - The maximum permitted number of slot=
s in the Panthor perf
> + *                                  ring buffer.
> + */
> +#define PANTHOR_PERF_RINGBUF_SLOTS_MAX (256)
> +
> +static unsigned int perf_ringbuf_slots =3D 32;
> +
> +static int perf_ringbuf_slots_set(const char *val, const struct kernel_p=
aram *kp)
> +{
> +	unsigned int slots;
> +	int ret =3D kstrtouint(val, 0, &slots);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!is_power_of_2(slots))
> +		return -EINVAL;
> +
> +	return param_set_uint_minmax(val, kp, 16, 128);
> +}

[Severity: Low]
PANTHOR_PERF_RINGBUF_SLOTS_MIN and PANTHOR_PERF_RINGBUF_SLOTS_MAX are
unused, and PANTHOR_PERF_RINGBUF_SLOTS_MAX is 256 (which would truncate to
0 in the 8-bit GLB_PERFCNT_CONFIG_SIZE() field) while
perf_ringbuf_slots_set() hardcodes 16 and 128.

[ ... ]

> +static void panthor_perf_handle_fw_samples(struct panthor_device *ptdev,
> +					   u32 extract_idx, u32 insert_idx)
> +{
> +	struct panthor_perf *perf =3D ptdev->perf;
> +	const size_t ann_block_size =3D
> +		get_annotated_block_size(ptdev->perf_info.counters_per_block);
> +	u32 i;
> +
> +	for (i =3D extract_idx; i !=3D insert_idx; i++) {
> +		u32 slot =3D i % perf->sample_slots;
> +		u8 *fw_sample =3D (u8 *)perf->rb->kmap + slot * perf->fw_sample_size;
> +		struct panthor_perf_fw_block_iter fw_iter =3D { .perf_ctx =3D perf };
> +		size_t ann_off =3D ptdev->perf_info.sample_header_size;
> +
> +		for (; panthor_perf_fw_block_iter_valid(&fw_iter);
> +		     fw_iter.offset +=3D fw_iter.perf_ctx->fw_block_size, fw_iter.idx+=
+) {
> +			struct panthor_perf_counter_block *blk =3D
> +				(typeof(blk))(perf->sample + ann_off);
> +			u32 *const block =3D (u32 *)(fw_sample + fw_iter.offset);
> +			const u32 prfcnt_en =3D block[PANTHOR_CTR_PRFCNT_EN];
> +
> +			if (fw_iter.type =3D=3D DRM_PANTHOR_PERF_BLOCK_METADATA) {
> +				/*
> +				 * The host must clear the SAMPLE_REASON to acknowledge it has
> +				 * consumed the sample.
> +				 */
> +				block[PANTHOR_CTR_SAMPLE_REASON] =3D 0;
> +				continue;
> +			}
> +
> +			if (!(perf->blocks[fw_iter.type].phys_mask & BIT_ULL(fw_iter.idx)))
> +				continue;
> +
> +			blk->header =3D (struct drm_panthor_perf_block_header) {
> +				.block_idx =3D fw_iter.idx,
> +				.block_type =3D fw_iter.type,
> +			};
> +
> +			if (prfcnt_en =3D=3D 0)
> +				goto advance_block;
> +
> +			/*
> +			 * The four header counters must be treated differently, because they=
 are
> +			 * not additive. For the fourth, the assignment does not matter, as it
> +			 * is reserved and should be zero.
> +			 */
> +			blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =3D block[PANTHOR_CTR_TIMESTA=
MP_LO];
> +			blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =3D block[PANTHOR_CTR_TIMESTA=
MP_HI];
> +			blk->counters[PANTHOR_CTR_PRFCNT_EN] =3D block[PANTHOR_CTR_PRFCNT_EN];

[Severity: Medium]
When multiple firmware sample slots are processed in one
panthor_perf_handle_fw_samples() call, does assigning
blk->counters[PANTHOR_CTR_PRFCNT_EN] overwrite enable bits from earlier
slots in the batch instead of OR-ing them?

In session_populate_sample(), expand_enable_mask() uses
iter.src_blk->counters[PANTHOR_CTR_PRFCNT_EN] to find which counters in
perf->sample need to be zeroed if they were not requested by the session.
If an earlier slot in the batch had counter bits set in prfcnt_en and a
later slot had prfcnt_en =3D=3D 1 (or a smaller subset), overwriting
PANTHOR_CTR_PRFCNT_EN drops the earlier bits and leaves those unrequested
counters unzeroed in the session's sample buffer.

[ ... ]

> +static void session_accumulate_sample(struct panthor_device *ptdev,
> +				      struct panthor_perf_session *session,
> +				      u8 *session_sample, u8 *perf_sample)
> +{
> +	const struct drm_panthor_perf_info *const perf_info =3D &ptdev->perf_in=
fo;
> +	struct panthor_perf_sample_block_iter iter;
> +
> +	sample_block_iter_init(perf_info, &session->enabled_counters, perf_samp=
le,
> +			       session_sample, &iter);
> +
> +	while (sample_block_iter_next(&iter)) {
> +		const struct panthor_perf_counter_block *src_blk =3D iter.src_blk;
> +		struct panthor_perf_counter_block *dst_blk =3D iter.dst_blk;
> +		unsigned int i =3D PANTHOR_HEADER_COUNTERS;
> +
> +		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_HI] =3D
> +			src_blk->counters[PANTHOR_CTR_TIMESTAMP_HI];
> +		dst_blk->counters[PANTHOR_CTR_TIMESTAMP_LO] =3D
> +			src_blk->counters[PANTHOR_CTR_TIMESTAMP_LO];
> +
> +		for_each_set_bit_from(i, iter.requested_mask, iter.counters)
> +			dst_blk->counters[i] +=3D src_blk->counters[i];
> +	}
> +}

[Severity: Medium]
Can session_accumulate_sample() overwrite valid block timestamps with zero
when accumulating multiple sample batches?

panthor_perf_handle_fw_events() zeroes perf->sample after each run, and
panthor_perf_handle_fw_samples() skips writing PANTHOR_CTR_TIMESTAMP_LO,
PANTHOR_CTR_TIMESTAMP_HI, and PANTHOR_CTR_PRFCNT_EN when prfcnt_en =3D=3D 0.
When a later batch has prfcnt_en =3D=3D 0 for a block (for example after an
automatic sample on a single powered-down shader core),
session_accumulate_sample() unconditionally copies the zeroed timestamps
from src_blk over dst_blk.  In addition, session_populate_sample() sets
blk->counters[PANTHOR_CTR_PRFCNT_EN] solely from iter.requested_mask
without masking against src_blk->counters[PANTHOR_CTR_PRFCNT_EN], and
session_accumulate_sample() never updates
dst_blk->counters[PANTHOR_CTR_PRFCNT_EN].

[ ... ]

> +static void session_copy_sample(struct panthor_device *ptdev,
> +				struct panthor_perf_session *session, u32 flags)
> +{
> +	struct panthor_perf *perf =3D ptdev->perf;
> +	const size_t sample_size =3D ptdev->perf_info.sample_size;
> +	const u64 insert_idx =3D session->insert_idx;
> +	u8 *new_sample;
> +
> +	scoped_guard(spinlock_irqsave, &session->state_lock) {
> +		if (!session_is_active(session) && !session_is_stopping(session))
> +			return;
> +
> +		if (flags & DRM_PANTHOR_PERF_SAMPLE_OVERFLOW)
> +			session->overflow =3D true;
> +		session->sample_flags |=3D flags;
> +	}
> +
> +	new_sample =3D session->samples + (insert_idx % session->ringbuf_slots)=
 * sample_size;
> +
> +	if (session->accum_idx !=3D insert_idx) {
> +		session_populate_sample(ptdev, session, new_sample, perf->sample);
> +		session->accum_idx =3D insert_idx;
> +	} else {
> +		session_accumulate_sample(ptdev, session, new_sample, perf->sample);
> +	}
> +}

[Severity: Medium]
Can session_copy_sample() and session_emit_sample() race with
session_try_start(), session_try_stop(), or session_try_sample()?

CPU0 (sample_work)                CPU1 (ioctl)
panthor_perf_handle_fw_events()
  panthor_perf_handle_fw_samples()
  lock(&perf->session_lock)
  session_copy_sample()
    /* sees STOPPED, returns */
                                  session_start()
                                    lock(&perf->op_lock)
                                    session_try_start()
                                      lock(&session->state_lock)
                                      state =3D STARTING
                                      accum_idx =3D insert_idx - 1
                                      unlock(&session->state_lock)
  session_emit_sample()
    lock(&session->state_lock)
    /* sees STARTING, sets ACTIVE */
    unlock(&session->state_lock)

panthor_perf_handle_fw_events() holds perf->session_lock, while
session_start(), session_stop(), and session_sample() hold perf->op_lock.
session_copy_sample() also reads session->insert_idx and updates
session->accum_idx outside session->state_lock, whereas session_try_start()
updates session->accum_idx under session->state_lock.  If a session
transition occurs after panthor_perf_handle_fw_samples() (or between
session_copy_sample() and session_emit_sample()) before
perf_fw_request_sample() is called, session_emit_sample() completes the
transition using the pre-request automatic sample, which can leave
timestamp_start_ns > timestamp_end_ns or leak pre-start counters into an
active session.

> +
> +static void session_publish_sample(struct panthor_perf *perf,
> +				   struct panthor_perf_session *session)
> +{
> +	const struct drm_panthor_perf_info *const info =3D &perf->ptdev->perf_i=
nfo;
> +	u8 *sample =3D session->samples +
> +		(session->insert_idx % session->ringbuf_slots) * info->sample_size;

[Severity: High]
Does (insert_idx % session->ringbuf_slots) in session_copy_sample() and
session_publish_sample() fail to link on 32-bit architectures?

insert_idx is a u64 and session->ringbuf_slots is a size_t, so the %
operator emits a 64-bit unsigned modulo (__aeabi_uldivmod / __umoddi3) on
32-bit builds where CONFIG_DRM_PANTHOR is enabled (ARM || COMPILE_TEST).
Since panthor_perf_session_create() requires ringbuf_slots to be a power of
two, this can use (insert_idx & (session->ringbuf_slots - 1)).

[ ... ]

> +static void panthor_perf_handle_fw_events(struct panthor_perf *perf)
> +{
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
> +	if (panthor_device_reset_is_pending(ptdev)) {
> +		queue_work(perf->sample_workq, &perf->sample_work);
> +		return;
> +	}

[Severity: High]
Does re-queueing perf->sample_work when panthor_device_reset_is_pending()
is true cause a 100% CPU busy-loop on the WQ_HIGHPRI workqueue?

When panthor_perf_sample_worker() runs, WORK_STRUCT_PENDING_BIT on
perf->sample_work has already been cleared.  Because perf->sample_work is a
work_struct rather than a delayed_work, calling queue_work() from inside
panthor_perf_handle_fw_events() immediately marks it runnable again with no
delay, so the WQ_HIGHPRI worker spins calling
panthor_perf_handle_fw_events() and perf_detach_sessions() until
ptdev->reset.pending is cleared (or across the entire suspend duration if a
reset was scheduled when panthor_device_reset_work() bailed out for
pm.state !=3D PANTHOR_DEVICE_PM_STATE_ACTIVE).  In addition,
panthor_device_reset_work() clears ptdev->reset.pending before calling
panthor_perf_post_reset(), allowing the spinning worker to read
perfcnt_extract and perfcnt_insert before panthor_perf_post_reset()
re-initializes sampling.

> +
> +	if ((u32)(insert_idx - extract_idx) > perf->sample_slots) {
> +		drm_warn_once(&ptdev->base, "Perf FW ring distance exceeds capacity\n"=
);
> +		return;
> +	}
> +
> +	if (extract_idx =3D=3D insert_idx)
> +		goto ack_events;
> +
> +	panthor_perf_handle_fw_samples(ptdev, extract_idx, insert_idx);
> +	WRITE_ONCE(glb_iface->input->perfcnt_extract, insert_idx);
> +
> +	scoped_guard(mutex, &perf->session_lock) {
> +		struct panthor_perf_session *session;
> +
> +		list_for_each_entry(session, &perf->session_list, sessions)
> +			session_copy_sample(ptdev, session, flags);
> +
> +		list_for_each_entry(session, &perf->session_list, sessions)
> +			session_emit_sample(perf, session);
> +	}

[Severity: Medium]
Can automatic firmware samples cause panthor_perf_handle_fw_events() to
call session_emit_sample() before an explicit GLB_PERFCNT_SAMPLE request
has been acknowledged?

Firmware emits automatic samples on shader core power transitions and
GLB_PERFCNT_THRESHOLD interrupts.  Because panthor_perf_handle_fw_events()
calls session_emit_sample() unconditionally without checking whether
GLB_PERFCNT_SAMPLE was acknowledged (or checking the metadata block sample
reason), an automatic sample arriving while a GLB_PERFCNT_SAMPLE request is
still in flight will prematurely transition a STARTING session to ACTIVE
(so the subsequent clearing sample is accumulated into the active session
instead of discarded) or prematurely publish a partial sample for a
STOPPING or pending_sample session.

> +
> +	memset(perf->sample, 0, ptdev->perf_info.sample_size);
> +
> +ack_events:
> +	if (events)
> +		panthor_fw_update_reqs(glb_iface, req, ack, events);
> +}
> +
> +void panthor_perf_report_irq(struct panthor_device *ptdev, u32 status)
> +{
> +	struct panthor_fw_global_iface *glb_iface =3D panthor_fw_get_glb_iface(=
ptdev);
> +	struct panthor_perf *const perf =3D ptdev->perf;
> +
> +	if (!(status & JOB_INT_GLOBAL_IF))
> +		return;
> +
> +	if (!perf)
> +		return;
> +
> +	const u32 ack =3D READ_ONCE(glb_iface->output->ack);
> +	const u32 req =3D READ_ONCE(glb_iface->input->req);
> +	const u32 events =3D (req ^ ack) & (GLB_PERFCNT_THRESHOLD | GLB_PERFCNT=
_OVERFLOW);
> +	const bool sample_acked =3D ((req & GLB_PERFCNT_SAMPLE) =3D=3D (ack & G=
LB_PERFCNT_SAMPLE));
> +	const u32 extract_idx =3D READ_ONCE(glb_iface->input->perfcnt_extract);
> +	const u32 insert_idx =3D READ_ONCE(glb_iface->output->perfcnt_insert);
> +	const bool has_sample =3D sample_acked && insert_idx !=3D extract_idx;
> +
> +	if (sample_acked) {
> +		guard(spinlock_irqsave)(&perf->pend_lock);
> +		perf->fw_sample_requested =3D false;
> +	}
> +
> +	if (events || has_sample)
> +		queue_work(perf->sample_workq, &perf->sample_work);
> +}

[Severity: Medium]
Can panthor_perf_report_irq() race with perf_fw_request_sample() and clear
perf->fw_sample_requested before GLB_PERFCNT_SAMPLE is toggled, or lose a
sample request when the worker has already advanced perfcnt_extract?

CPU0 (ioctl)                      CPU1 (IRQ)
perf_fw_request_sample()
  lock(&perf->pend_lock)
  perf->fw_sample_requested =3D true
  unlock(&perf->pend_lock)
                                  panthor_perf_report_irq()
                                    /* GLB_PING / unrelated IRQ */
                                    /* req & SAMPLE =3D=3D ack & SAMPLE */
                                    lock(&perf->pend_lock)
                                    perf->fw_sample_requested =3D false
                                    unlock(&perf->pend_lock)
  panthor_fw_toggle_reqs(...,
    GLB_PERFCNT_SAMPLE)

Because perf_fw_request_sample() drops perf->pend_lock before calling
panthor_fw_toggle_reqs(), any unrelated JOB_INT_GLOBAL_IF interrupt firing
in that window sees sample_acked =3D=3D true and clears
perf->fw_sample_requested while the request is still in flight; a second
perf_fw_request_sample() then toggles GLB_PERFCNT_SAMPLE back to match ack,
dropping the request.  Conversely, if an already-running
panthor_perf_handle_fw_events() worker consumes the new sample, advances
perfcnt_extract to insert_idx, and wakes session_start() before
panthor_perf_report_irq() runs, an immediate follow-up session_stop() or
session_sample() sees perf->fw_sample_requested =3D=3D true and skips toggl=
ing
GLB_PERFCNT_SAMPLE, after which panthor_perf_report_irq() sees
insert_idx =3D=3D extract_idx, clears perf->fw_sample_requested, and never
queues sample_work.

[ ... ]

> @@ -497,6 +1486,7 @@ int panthor_perf_session_create(struct drm_file *fil=
e,
> =20
>  	kref_init(&session->ref);
>  	INIT_LIST_HEAD(&session->sessions);
> +	init_waitqueue_head(&session->state_wq);
>  	spin_lock_init(&session->state_lock);
>  	session->control =3D control.vaddr;
>  	*session->control =3D (struct drm_panthor_perf_ringbuf_control) { 0 };
> @@ -507,6 +1497,14 @@ int panthor_perf_session_create(struct drm_file *fi=
le,
>  	session->control_buf =3D control;
>  	session->accum_idx =3D U64_MAX;

[Severity: High]
What happens if userspace passes a PRIME-imported GEM buffer backed by
device IOMEM for control_handle or ringbuf_handle?

panthor_perf_bo_get() maps the GEM object with drm_gem_vmap() without
rejecting imported buffers or checking map.is_iomem, and stores only
bo->vaddr =3D map.vaddr:

drivers/gpu/drm/panthor/panthor_perf.c:panthor_perf_bo_get() {
    ...
	ret =3D drm_gem_vmap(obj, &map);
	if (ret)
		goto err_put;

	bo->obj =3D obj;
	bo->vaddr =3D map.vaddr;
    ...
}

The sampling path then performs direct CPU memory accesses and
smp_load_acquire() / smp_store_release() on session->control and
session->samples, and on teardown panthor_perf_bo_put() reconstructs the
map with IOSYS_MAP_INIT_VADDR(bo->vaddr) (is_iomem =3D false), which trigge=
rs
BUG_ON(!iosys_map_is_equal(&dmabuf->vmap_ptr, map)) in dma_buf_vunmap().

> +
> +	ret =3D pm_runtime_resume_and_get(ptdev->base.dev);
> +	if (ret)
> +		goto cleanup_obj;

[Severity: Medium]
Should panthor_perf_session_create() call
panthor_device_resume_and_get(ptdev) instead of
pm_runtime_resume_and_get(ptdev->base.dev)?

When panthor_device_resume() fails, it sets ptdev->pm.recovery_needed =3D 1;
calling pm_runtime_resume_and_get() directly bypasses the
pm_runtime_set_suspended() recovery handling in
panthor_device_resume_and_get() and leaves dev->power.runtime_error
latched.

[ ... ]

> @@ -657,8 +1674,7 @@ static int session_start(struct panthor_perf *perf, =
struct panthor_perf_session
>   * stop the session and restart sampling.
>   *
>   * Return:
> - *  - 0 to request a new sample and wait,
> - *  - 1 to skip the re-request and go directly to wait
> + *  - 1 if the caller should wait for the sample to complete,
>   *  - negative error code on invalid transitions or state
>   */
>  static int session_try_sample(struct panthor_perf_session *session, u64 =
user_data)
> @@ -703,7 +1719,8 @@ static int session_sample(struct panthor_perf *perf,=
 struct panthor_perf_session
>  	if (ret <=3D 0)
>  		return ret;
> =20
> -	/* TODO Calls to the FW interface will go here in later patches. */
> +	perf_fw_request_sample(perf);
> +
>  	return 0;
>  }

[Severity: Low]
In session_try_sample(), the initial !session_is_active(session) check
returns -EINVAL for all non-active states, making the immediately following
if (session_is_stopping(session)) return -EBUSY; check unreachable:

drivers/gpu/drm/panthor/panthor_perf.c:session_try_sample() {
	guard(spinlock_irqsave)(&session->state_lock);

	if (!session_is_active(session))
		return -EINVAL;

	if (session_is_stopping(session))
		return -EBUSY;
    ...
}

[Severity: Medium]
Does overwriting session->sample_start_ns =3D ktime_get_raw_ns() in
session_try_sample() and session_try_stop() clobber the interval start
timestamp recorded in session_emit_sample()?

In session_emit_sample(), the update_session label sets
session->sample_start_ns =3D perf->last_fw_sample_time when the STARTING
clearing sample completes or when a pending sample is published.  Because
session_publish_sample() is only called when session_is_stopping(session)
or session->pending_sample is true, and both session_try_stop() and
session_try_sample() unconditionally overwrite session->sample_start_ns
with ktime_get_raw_ns(), the published sample header's timestamp_start_ns
always reflects when the SAMPLE or STOP ioctl was issued rather than the
start of the accumulation window.

[ ... ]

> +void panthor_perf_suspend(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf =3D ptdev->perf;
> +	int ret;
> +
> +	if (!perf)
> +		return;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	ret =3D perf_disable(perf);
> +
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not stop sampling before suspend, err =
=3D %d", ret);
> +}
> +
> +/**
> + * panthor_perf_resume - Resume the performance counter subsystem after =
system resumption.
> + * @ptdev: Panthor device.
> + *
> + * Indicate to the performance counters that the system has resumed. Thi=
s must not be used
> + * to handle MCU state transitions, for the same reasons as detailed in =
the kerneldoc for
> + * @panthor_perf_suspend.
> + */
> +void panthor_perf_resume(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf =3D ptdev->perf;
> +	int ret;
> +
> +	if (!perf)
> +		return;
> +
> +	guard(mutex)(&perf->op_lock);
> +
> +	ret =3D perf_enable(perf);
> +
> +	if (ret)
> +		drm_warn(&ptdev->base, "Could not resume sampling, err =3D %d", ret);
> +}

[Severity: High]
Does panthor_perf_suspend() (and panthor_perf_pre_reset()) need to flush
perf->sample_work after perf_disable(perf), the way
panthor_perf_session_destroy() and panthor_perf_pool_destroy() call
perf_sync_work(perf)?

CPU0 (reset / suspend-resume)     CPU1 (sample_work)
panthor_perf_handle_fw_events()
  extract_idx =3D 1, insert_idx =3D 3
panthor_perf_pre_reset()
  perf_disable()
...
panthor_perf_post_reset()
  perf_enable()
    panthor_perf_fw_start_sampling()
      perfcnt_extract =3D 0
                                  panthor_perf_handle_fw_samples(1, 3)
                                  perfcnt_extract =3D 3  <-- stale index

Because panthor_perf_sample_worker() does not take perf->op_lock, a pending
sample_work can run concurrently with suspend/reset or with
panthor_perf_fw_start_sampling() on resume/post-reset and overwrite
perfcnt_extract =3D 0 with a stale pre-reset insert_idx.  When the next FW
sample arrives at perfcnt_insert =3D 1, (u32)(insert_idx - extract_idx) wra=
ps
around past perf->sample_slots, triggering "Perf FW ring distance exceeds
capacity" and dropping all subsequent samples.

[Severity: Medium]
Without draining perf->rb in panthor_perf_suspend() and
panthor_perf_pre_reset(), any firmware samples written before
perf_disable() completes are also discarded when
panthor_perf_fw_start_sampling() resets perfcnt_extract to 0, leaving
stale non-zero PANTHOR_CTR_PRFCNT_EN and PANTHOR_CTR_SAMPLE_REASON words in
those ringbuffer slots.  In addition, if panthor_perf_request_sync() times
out because the firmware never acknowledged GLB_PERFCNT_SAMPLE,
perf->fw_sample_requested remains stuck at true and the session stays in
STARTING or STOPPING, causing retries to skip requesting a sample and
panthor_perf_session_destroy() to fail with -EBUSY.

> +
>  /**
>   * panthor_perf_unplug - Terminate the performance counter subsystem.
>   * @ptdev: Panthor device.
> @@ -856,10 +1930,27 @@ int panthor_perf_session_sample(struct panthor_fil=
e *pfile, u32 handle, u64 user
>  void panthor_perf_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_perf *perf =3D ptdev->perf;
> +	struct panthor_perf_session *session, *tmp;
> =20
>  	if (!perf)
>  		return;
> =20
> +	disable_work_sync(&perf->sample_work);
> +
> +	scoped_guard(mutex, &perf->session_lock) {
> +		list_for_each_entry_safe(session, tmp, &perf->session_list, sessions) {
> +			scoped_guard(spinlock_irqsave, &session->state_lock)
> +				session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
> +
> +			list_del_init(&session->sessions);
> +			session_put(session);
> +		}
> +	}
> +
> +	panthor_kernel_bo_vunmap(perf->rb);
> +	panthor_kernel_bo_destroy(perf->rb);
> +
> +	perf->rb =3D NULL;
>  	ptdev->perf =3D NULL;
>  }

[Severity: High]
Can panthor_perf_unplug() race with concurrent session operations or
panthor_perf_pool_destroy() to cause a use-after-free or NULL pointer
dereference?

CPU0                              CPU1
panthor_perf_pool_destroy()
  perf =3D pfile->ptdev->perf
                                  panthor_fw_unplug()
                                    panthor_perf_unplug()
                                      panthor_kernel_bo_destroy(perf->rb)
                                      perf->rb =3D NULL
                                      ptdev->perf =3D NULL
                                    /* destroys fw->sections, fw->vm =3D NU=
LL */
  lock(&perf->op_lock)
  perf_disable(perf)
    /* accesses destroyed glb_iface */
  perf_enable(perf)
    panthor_perf_fw_start_sampling()
      panthor_perf_fw_write_config(ptdev->perf)  <-- NULL deref

panthor_perf_unplug() destroys perf->rb and clears ptdev->perf without
acquiring perf->op_lock, and panthor_fw_unplug() immediately unmaps all
firmware interface sections and clears ptdev->fw->vm.  Meanwhile,
panthor_perf_session_create() reloads ptdev->perf after blocking
allocations, and panthor_perf_pool_destroy() reads pfile->ptdev->perf
before taking perf->op_lock.  Furthermore, panthor_perf_unplug() sets
sessions to PANTHOR_PERF_SESSION_DESTROY without calling
wake_up_all(&session->state_wq) (and session_is_active_locked() does not
check session_is_destroy(session)), leaving any thread in
panthor_perf_request_sync() blocked until timeout.

[Severity: Medium]
Does panthor_perf_unplug() also leak the per-session runtime PM references
acquired in panthor_perf_session_create()?

panthor_perf_session_create() calls pm_runtime_resume_and_get() for each
session.  When panthor_device_unplug() calls panthor_fw_unplug() ->
panthor_perf_unplug(), sessions are removed from perf->session_list and
ptdev->perf is set to NULL without dropping their runtime PM references.
As a result, pm_runtime_put_sync_suspend() at the end of
panthor_device_unplug() cannot suspend the device before driver removal
finishes, and any subsequent panthor_perf_session_destroy() ioctl returns
-EOPNOTSUPP because ptdev->perf is NULL, leaving the session and its
runtime PM reference pinned until the DRM file is closed.

> =20
> @@ -867,6 +1958,9 @@ int panthor_perf_pool_create(struct panthor_file *pf=
ile)
>  {
>  	struct panthor_perf_pool *pool;
> =20
> +	if (!pfile->ptdev->perf)
> +		return 0;
> +
>  	pool =3D kzalloc_obj(*pool);
>  	if (!pool)
>  		return -ENOMEM;
> @@ -880,14 +1974,33 @@ int panthor_perf_pool_create(struct panthor_file *=
pfile)
>  void panthor_perf_pool_destroy(struct panthor_file *pfile)
>  {
>  	struct panthor_perf_pool *pool =3D pfile->sessions;
> +	struct panthor_perf *perf =3D pfile->ptdev->perf;
>  	struct panthor_perf_session *session;
>  	unsigned long handle;
> +	bool sync_work =3D false;
> +
> +	if (!pool)
> +		return;
> =20
>  	xa_for_each_marked(&pool->xa, handle, session, SESSION_REGISTERED) {
> -		scoped_guard(spinlock_irqsave, &session->state_lock)
> +		scoped_guard(spinlock_irqsave, &session->state_lock) {
>  			session_set_state(session, PANTHOR_PERF_SESSION_DESTROY);
> +			sync_work =3D true;
> +		}
> +	}
> +
> +	if (perf && sync_work) {
> +		guard(mutex)(&perf->op_lock);
> +
> +		perf_disable(perf);
> +		perf_sync_work(perf);
> +		perf_enable(perf);
> +	}

[Severity: Medium]
Because panthor_perf_pool_destroy() is called from panthor_postclose()
without drm_dev_enter(), can it race with panthor_device_unplug() ->
panthor_fw_unplug() -> panthor_perf_unplug() and touch MMIO doorbells and
destroyed firmware sections in perf_disable() and perf_enable() after the
device has been unplugged?

> +
> +	xa_for_each_marked(&pool->xa, handle, session, SESSION_REGISTERED) {
>  		xa_erase(&pool->xa, handle);
>  		session_put(session);
> +		pm_runtime_put_autosuspend(pfile->ptdev->base.dev);
>  	}
> =20
>  	xa_destroy(&pool->xa);
> @@ -895,3 +2008,23 @@ void panthor_perf_pool_destroy(struct panthor_file =
*pfile)
> =20
>  	pfile->sessions =3D NULL;
>  }
> +
> +void panthor_perf_pre_reset(struct panthor_device *ptdev)
> +{
> +	if (!ptdev->perf)
> +		return;
> +
> +	guard(mutex)(&ptdev->perf->op_lock);
> +
> +	perf_disable(ptdev->perf);
> +}
> +
> +void panthor_perf_post_reset(struct panthor_device *ptdev)
> +{
> +	if (!ptdev->perf)
> +		return;
> +
> +	guard(mutex)(&ptdev->perf->op_lock);
> +
> +	perf_enable(ptdev->perf);
> +}

[Severity: Medium]
If a GPU reset occurs while a session has a sample request in flight
(session->pending_sample =3D=3D true, or the session is in STARTING or
STOPPING), is that sample request lost across the reset?

During panthor_device_reset_work(), panthor_fw_post_reset() reloads and
zeroes the firmware interface sections (clearing GLB_PERFCNT_SAMPLE in
req/ack and resetting perfcnt_insert and perfcnt_extract to 0).  When the
MCU boot JOB_INT_GLOBAL_IF interrupt fires, panthor_perf_report_irq() sees
(req & GLB_PERFCNT_SAMPLE) =3D=3D (ack & GLB_PERFCNT_SAMPLE) with
insert_idx =3D=3D extract_idx =3D=3D 0 and clears perf->fw_sample_requested=
 =3D false
without queueing sample_work.  panthor_perf_post_reset() then calls
perf_enable(), which re-enables GLB_PERFCNT_EN but never re-issues
perf_fw_request_sample() for sessions with pending requests, leaving
session->pending_sample stuck at true so future SAMPLE and STOP calls fail
with -EBUSY and DESTROY fails with -EINVAL.

[Severity: Medium]
The same loss of an in-flight sample request happens across system
suspend/resume in panthor_perf_resume(): session_sample() releases
perf->op_lock immediately after calling perf_fw_request_sample(), and if
panthor_perf_suspend() and panthor_perf_resume() run before the sample is
delivered, panthor_perf_resume() calls perf_enable() (resetting
perfcnt_extract to 0) without re-requesting a firmware sample for sessions
with session->pending_sample =3D=3D true, wedging the session and blocking =
new
PERF_SESSION_CREATE calls with -EBUSY until the file descriptor is closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-panthor-pe=
rformance-counters-v8-0-6e7db0ec33f5@arm.com?part=3D2
