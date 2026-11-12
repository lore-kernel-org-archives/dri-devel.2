Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B55606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGiHyeyL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7994D10E1ED;
	Thu, 12 Nov 2026 23:26:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE811123DE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AF1343714;
 Thu, 12 Nov 2026 23:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BB31F000C5;
 Thu, 12 Nov 2026 23:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526005;
 bh=/2iZyvu5nnNT1qhW02gosScCtdtiSCf7+Rz/gPQTZoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jGiHyeyLDL8wVUbwusnr1nSMo60GwEiQ8Apf0zjJ9QSzCsSBSrQKIJEXVBQaXxfS1
 1gO6vFkSV8XfyxHSA0xF1zJJRW+NTjlYxRTmsKUHGirjAJW5ffsWeYGe0QeypEJuR6
 yJYNZri6/Aj0zz+D3ZLuyq0adRJDt+E18vts76lgAM+54tYpixiAuv7m9SpJltzN9Q
 v3Z3Of63WP4eCUpAt8nrN153UKTXbOr6FmQHFhS1mili/8cYL1qblPz/gLjwzTNpPU
 FMJt6xZSw/QFL0f1iES8O1KHuLTvCQ19bQN3NSTtDHq0XvVXGuscQtARTdQAmyunky
 yR5r8Foyx7qCg==
Message-ID: <sashiko-outbox-211951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/13] drm/powervr_sgx: Add contexts, the scheduler
 and SUBMIT_JOBS
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-8-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-8-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:26:44 +0000
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

Thank you for your contribution! Sashiko AI review found 12 potential
issues to consider:
- [Critical] drm/powervr_sgx: UAF and hung jobs racing context_destroy()
  and submit
- [High] drm/powervr_sgx: reset race and unreferenced fence in
  pvrsgx_job_quiesce()
- [High] drm/powervr_sgx: unplug race with pvrsgx_timedout_job() and
  poll_work
- [High] drm/powervr_sgx: unsynchronized pvrsgx_job_fault_check() during
  GPU reset
- [High] drm/powervr_sgx: premature fence signal and kobj leak in
  pvrsgx_run_job()
- [High] drm/powervr_sgx: NULL job and split-inval conflict under
  PVRSGX_UKFW_DONE_SEQ
- [High] drm/powervr_sgx: GFP_KERNEL allocation in fence signalling path
  on reset
- [High] drm/powervr_sgx: circular refcount leak on unbind in
  pvrsgx_job_unplug()
- [Medium] drm/powervr_sgx: VM user refcount race in
  pvrsgx_ioctl_create_context()
- [Medium] drm/powervr_sgx: broken intra-submit timeline syncobj waits
  in job_sync_ops()
- [Medium] drm/powervr_sgx: lost hardware fence error code in
  pvrsgx_timedout_job()
- [Low] drm/powervr_sgx: unused signals fields and misplaced comment in
  pvrsgx_job
--

commit ededc4928ab614ae6dedb811977080403c02305f
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add contexts, the scheduler and SUBMIT_JOBS

This commit adds render and transfer contexts, the DRM GPU scheduler
integration, timeout recovery, and the SUBMIT_JOBS ioctl with syncobj
synchronization and tracepoints.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_job.c b/drivers/gpu/drm/p=
owervr_sgx/pvrsgx_job.c
> new file mode 100644
> index 0000000000000..bc1e8ea282d80
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_job.c

[ ... ]

> +/* Whether the oldest job on the GPU is done; for the hard IRQ handler. =
*/
> +bool pvrsgx_job_oldest_done(struct pvrsgx_device *sdev)
> +{
> +	struct pvrsgx_job *job;
> +	unsigned long flags;
> +	bool done;
> +
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	job =3D list_first_entry_or_null(&sdev->active, struct pvrsgx_job, node=
);
> +	done =3D job && (sdev->fw.features & PVRSGX_UKFW_DONE_SEQ ? jobs_finish=
ed(sdev) > 0 :
> +		       job_done(job, pvrsgx_ccb_consumed(sdev)));
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +	return done;
> +}
> +
> +/*
> + * A page fault stalls the faulting requestor, and the SGX545 raises no =
host
> + * event for it: check the BIF here, and end the job at once rather than=
 at its
> + * timeout. Only while jobs are out, so the core is powered.
> + */
> +static bool pvrsgx_job_fault_check(struct pvrsgx_device *sdev)
> +{
> +	bool fault;
> +	int idx;
> +
> +	if (READ_ONCE(sdev->faulted) || READ_ONCE(sdev->lost) || !READ_ONCE(sde=
v->powered) ||
> +	    !drm_dev_enter(&sdev->base, &idx))
> +		return false;
> +	fault =3D sgx_rd(sdev, SGX_CR_BIF_INT_STAT) & sdev->cr->bif_int_stat_fa=
ult_req;
> +	drm_dev_exit(idx);
> +	if (!fault)
> +		return false;
> +	WRITE_ONCE(sdev->faulted, true);
> +	drm_sched_fault(&sdev->sched);
> +	return true;
> +}
> +
> +/* Signal every job the firmware has finished. Runs in the IRQ thread an=
d the poll work. */
> +void pvrsgx_job_process_done(struct pvrsgx_device *sdev)
> +{
> +	struct pvrsgx_job *job, *tmp;
> +	unsigned long flags;
> +	bool more, reap =3D false;
> +	LIST_HEAD(finished);
> +	bool cookie;
> +	u64 consumed;
> +	s64 n;
> +
> +	mutex_lock(&sdev->done_lock);
> +	/* Under the lock a reset fails the old jobs under: no count from befor=
e it. */
> +	consumed =3D pvrsgx_ccb_consumed(sdev);
> +	cookie =3D dma_fence_begin_signalling();
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	n =3D jobs_finished(sdev);
> +	list_for_each_entry_safe(job, tmp, &sdev->active, node) {
> +		if (n >=3D 0 ? !n : !job_done(job, consumed))
> +			break;
> +		if (n > 0) {
> +			n--;
> +			sdev->done_seq++;
> +		}
> +		list_move_tail(&job->node, &finished);

[Severity: High]
How do DRM_POWERVR_SGX_JOB_TYPE_NULL jobs complete when PVRSGX_UKFW_DONE_SEQ
is enabled?

When PVRSGX_UKFW_DONE_SEQ is set, jobs_finished() returns a non-negative
count, so pvrsgx_job_oldest_done() and pvrsgx_job_process_done() never call
job_done(job, consumed) even though job->done_cpu is NULL.  Both a NULL job
in pvrsgx_run_job() and ccb_split_inval() emit an identical
PVRSGX_KCMD_PROCESS_QUEUES command with six zero data words, while only the
NULL job is added to sdev->active.  If the microkernel does not increment
t->done_seq for PVRSGX_KCMD_PROCESS_QUEUES, NULL jobs never finish and
always time out; if it does increment t->done_seq, ccb_split_inval()
advances t->done_seq without an entry on sdev->active and prematurely
signals the next active job's fence.

> +		if (job->type =3D=3D DRM_POWERVR_SGX_JOB_TYPE_RENDER) {
> +			sdev->renders_done++;
> +			reap =3D true;
> +		}
> +	}
> +	more =3D !list_empty(&sdev->active);
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +
> +	list_for_each_entry(job, &finished, node)
> +		pvrsgx_prime_flush(job, true);
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	list_for_each_entry_safe(job, tmp, &finished, node) {
> +		list_del_init(&job->node);
> +		if (job->type =3D=3D DRM_POWERVR_SGX_JOB_TYPE_RENDER)
> +			atomic64_add(ktime_get_ns() - job->start_ns, &job->ctx->usage->render=
_ns);
> +		trace_pvrsgx_job_done(job->type, job->hw_fence->seqno);
> +		dma_fence_signal_locked(job->hw_fence);
> +	}
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +	dma_fence_end_signalling(cookie);
> +	mutex_unlock(&sdev->done_lock);
> +
> +	if (reap || !list_empty_careful(&sdev->inval_waits))
> +		queue_work(sdev->free_wq, &sdev->reap_work);
> +	if (more && pvrsgx_job_fault_check(sdev))
> +		return;
> +	/* With a count the interrupt does it, and the poll is only a backstop.=
 */
> +	if (more)
> +		mod_delayed_work(sdev->wq, &sdev->poll_work,
> +				 sdev->fw.features & PVRSGX_UKFW_DONE_SEQ ? HZ / 10 : 1);
> +}

[Severity: High]
Can pvrsgx_job_fault_check() run concurrently with pvrsgx_fw_start() during
a GPU reset?

CPU0 (poll_work / IRQ thread)     CPU1 (work_tdr)
pvrsgx_job_process_done()         pvrsgx_timedout_job()
  more =3D !list_empty(&active)
  mutex_unlock(&sdev->done_lock)
                                    ...
                                    list_del_init(&job->node)
                                    WRITE_ONCE(sdev->faulted, false)
                                    pvrsgx_fw_start(sdev)
                                      deinit_script(sdev)
                                        sgx_wr(SGX_CR_CLKGATECTL, 0)
                                        fsleep(10000)
  pvrsgx_job_fault_check(sdev)
    sgx_rd(SGX_CR_BIF_INT_STAT)  <-- clocks gated / stale fault bit

Because more is evaluated before dropping done_lock and pvrsgx_timedout_job=
()
neither cancels poll_work nor holds reset_lock until after the reset clears
the BIF state, pvrsgx_job_fault_check() can also keep poll_work armed when
sdev->faulted is already true.  Reading SGX_CR_BIF_INT_STAT while
deinit_script() has gated the clocks can hang the bus, or observe the old
pre-reset fault bit before pvrsgx_reset() clears it and fault the next
innocent job.

[ ... ]

> +	pvrsgx_prime_flush(job, false);
> +	WRITE_ONCE(job->ctx->vm->ran_gen, sdev->fw_gen + 1);
> +	if (job->type =3D=3D DRM_POWERVR_SGX_JOB_TYPE_RENDER) {
> +		mutex_lock(&sdev->kobj_lock);
> +		sdev->renders_submitted++;
> +		mutex_unlock(&sdev->kobj_lock);
> +		err =3D 0;
> +		for (u32 k =3D 0; k < job->render.nkicks && !err; k++) {
> +			pvrsgx_render_job_build(job, k, data);
> +			err =3D pvrsgx_ccb_send(sdev, PVRSGX_KCMD_TA, data, &job->ccb_seq);
> +		}
> +	} else if (job->type =3D=3D DRM_POWERVR_SGX_JOB_TYPE_TRANSFER) {
> +		pvrsgx_transfer_job_build(job, data);
> +		err =3D pvrsgx_ccb_send(sdev, PVRSGX_KCMD_TRANSFER, data, &job->ccb_se=
q);
> +	} else {
> +		/* A NULL job is a no-op command: done when the microkernel has taken =
it. */
> +		err =3D pvrsgx_ccb_send(sdev, PVRSGX_KCMD_PROCESS_QUEUES, data, &job->=
ccb_seq);
> +	}
> +	if (err) {
> +		drm_err_ratelimited(&sdev->base, "job not sent to the microkernel (%d)=
\n", err);
> +		goto fail_exit;
> +	}
> +
> +	job->start_ns =3D ktime_get_ns();
> +	trace_pvrsgx_kick(job->type, job->ccb_seq, fence->seqno);
> +	dma_fence_put(sdev->last_fence);
> +	sdev->last_fence =3D dma_fence_get(fence);
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	list_add_tail(&job->node, &sdev->active);
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +	mod_delayed_work(sdev->wq, &sdev->poll_work, 0);
> +	drm_dev_exit(idx);
> +	return fence;
> +
> +fail_exit:
> +	drm_dev_exit(idx);
> +fail:
> +	cookie =3D dma_fence_begin_signalling();
> +	dma_fence_set_error(fence, err);
> +	dma_fence_signal(fence);
> +	dma_fence_end_signalling(cookie);
> +	return fence;
> +}

[Severity: High]
What happens in pvrsgx_run_job() if kick 0 of a multi-kick render job
succeeds in pvrsgx_ccb_send() and kick 1 fails?

Kick 0 is already queued in the kernel CCB with the doorbell rung, but the
error path immediately signals fence without halting the GPU or putting the
job on sdev->active, allowing the job's buffers, VM mappings, and runtime PM
reference to be released while the GPU is executing kick 0.  In addition,
because sdev->renders_submitted is incremented before pvrsgx_ccb_send() and
never rolled back on failure, sdev->renders_submitted stays ahead of
sdev->renders_done and prevents pvrsgx_kobj_reap() from reaping later
graveyard objects.

> +/*
> + * A job ran too long. Blame its context, fail what was on the GPU, and =
start
> + * the microkernel again from a clean control block and an empty CCB, ra=
ther
> + * than rescan the old one.
> + */
> +static enum drm_gpu_sched_stat pvrsgx_timedout_job(struct drm_sched_job =
*sched_job)
> +{
> +	struct pvrsgx_job *bad =3D to_pvrsgx_job(sched_job), *job, *tmp;
> +	struct pvrsgx_device *sdev =3D bad->ctx->sdev;
> +	bool fault =3D READ_ONCE(sdev->faulted), lost, cookie;
> +	unsigned long flags;
> +	int idx;
> +
> +	drm_sched_stop(&sdev->sched, sched_job);
> +	/* Every fence on the GPU and in the queue waits on what follows. */
> +	cookie =3D dma_fence_begin_signalling();
> +	/* After unbind (pvrsgx_job_unplug) the hardware is gone: fail, touch n=
othing. */
> +	mutex_lock(&sdev->reset_lock);
> +	lost =3D READ_ONCE(sdev->lost) || !drm_dev_enter(&sdev->base, &idx);
> +	if (lost)
> +		goto fail;
> +	if (fault)
> +		drm_err(&sdev->base, "job page fault at 0x%08x (BIF status 0x%08x); re=
setting\n",
> +			sgx_rd(sdev, SGX_CR_BIF_FAULT) & sdev->cr->bif_fault_addr,
> +			sgx_rd(sdev, SGX_CR_BIF_INT_STAT));
> +	else
> +		drm_err(&sdev->base, "job timed out (ccb %llu, consumed %llu); resetti=
ng\n",
> +			bad->ccb_seq, pvrsgx_ccb_consumed(sdev));
> +	WRITE_ONCE(bad->ctx->state, DRM_POWERVR_SGX_CONTEXT_STATE_GUILTY);
> +	pvrsgx_coredump(sdev, bad);
> +	/* Stopped before any fence signals: userspace may free the jobs' memor=
y then. */
> +	pvrsgx_fw_halt(sdev);
> +
> +fail:
> +	mutex_lock(&sdev->done_lock);
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	list_for_each_entry_safe(job, tmp, &sdev->active, node) {
> +		list_del_init(&job->node);
> +		if (job->ctx !=3D bad->ctx)
> +			WRITE_ONCE(job->ctx->state, DRM_POWERVR_SGX_CONTEXT_STATE_INNOCENT);
> +		dma_fence_set_error(job->hw_fence, lost ? -ENODEV : job !=3D bad ? -EC=
ANCELED :
> +				    fault ? -EFAULT : -ETIME);
> +		dma_fence_signal_locked(job->hw_fence);
> +	}
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +	mutex_unlock(&sdev->done_lock);
> +	if (lost)
> +		goto out;
> +
> +	/*
> +	 * No power-off handshake with a hung microkernel, which cannot answer:
> +	 * straight into the full start (clocks, scripts, a reset that drains
> +	 * pending faults, the first kick).
> +	 */
> +	sdev->reset_count++;
> +	sdev->fw_running =3D false;
> +	/* The restart's reset clears the BIF's fault state. */
> +	WRITE_ONCE(sdev->faulted, false);
> +	if (pvrsgx_fw_start(sdev)) {
> +		drm_err(&sdev->base, "microkernel did not restart: device lost\n");
> +		/* Lost: the cores stay in reset, and run_job fails every job. */
> +		pvrsgx_fw_halt(sdev);
> +		WRITE_ONCE(sdev->lost, true);
> +		/* DMA is off and the fences are signaled: tell userspace to rebind. */
> +		drm_dev_wedged_event(&sdev->base, DRM_WEDGE_RECOVERY_REBIND, NULL);
> +	}
> +	drm_dev_exit(idx);
> +out:
> +	mutex_unlock(&sdev->reset_lock);
> +	dma_fence_end_signalling(cookie);
> +	drm_sched_start(&sdev->sched, 0);
> +	return DRM_GPU_SCHED_STAT_RESET;
> +}

[Severity: Medium]
Does the error set on job->hw_fence here ever reach
sched_job->s_fence->finished?

drm_sched_stop() at the top of pvrsgx_timedout_job() removes sched_job->cb
from job->hw_fence while job->hw_fence is still unsignaled and clears
sched_job->s_fence->parent =3D NULL.  When drm_sched_start(&sdev->sched, 0)
runs at the end, it sees parent =3D=3D NULL and completes s_fence->finished=
 with
-ECANCELED instead of -ETIME, -EFAULT, or -ENODEV.

[ ... ]

> +static void lockdep_prime(struct pvrsgx_device *sdev)
> +{
> +	if (!IS_ENABLED(CONFIG_LOCKDEP))
> +		return;
> +	fs_reclaim_acquire(GFP_KERNEL);
> +	might_lock(&sdev->reset_lock);
> +	might_lock(&sdev->done_lock);
> +	might_lock(&sdev->ccb_lock);
> +	might_lock(&sdev->kobj_lock);
> +	fs_reclaim_release(GFP_KERNEL);
> +}

[Severity: High]
Doesn't pvrsgx_timedout_job() perform GFP_KERNEL allocations while holding
sdev->reset_lock and inside dma_fence_begin_signalling()?

In pvrsgx_timedout_job(), pvrsgx_fw_start() -> pvrsgx_reset() ->
pvrsgx_mmu_map_pages(sdev->reset_mmu, ...) -> pte_get() allocates page
tables with GFP_KERNEL when draining a fault in an unpopulated PDE slot, and
drm_dev_wedged_event() -> kobject_uevent_env() also allocates with
GFP_KERNEL.  Both run under sdev->reset_lock and before
dma_fence_end_signalling(cookie), which triggers a lockdep splat against the
fs_reclaim priming here and can deadlock if reclaim waits on GPU fences.

[ ... ]

> +void pvrsgx_job_unplug(struct pvrsgx_device *sdev)
> +{
> +	struct pvrsgx_job *job, *tmp;
> +	unsigned long flags;
> +	bool cookie;
> +
> +	drm_sched_wqueue_stop(&sdev->sched);
> +	/* A reset under way finishes first; one after this sees @lost. */
> +	mutex_lock(&sdev->reset_lock);
> +	WRITE_ONCE(sdev->lost, true);
> +	pvrsgx_fw_stop(sdev);
> +	mutex_unlock(&sdev->reset_lock);
> +	cancel_delayed_work_sync(&sdev->poll_work);
> +	/* Stopped: nothing translates any more, so unmapped memory can go. */
> +	pvrsgx_ccb_inval_reap(sdev, true);

[Severity: High]
Should pvrsgx_job_unplug() also call pvrsgx_kobj_reap(sdev, U64_MAX)?

Each per-VM struct pvrsgx_kobj holds a reference to its pvrsgx_vm, which
holds a reference to sdev->base via drm_gpuvm.  Without reaping sdev->grave=
yard
and sdev->kobj_unmapped on unbind, kernel objects released by earlier render
contexts keep sdev->base alive forever, so the drmm release callback
pvrsgx_device_release() -> pvrsgx_kobj_fini() never runs.

> +
> +	mutex_lock(&sdev->done_lock);
> +	cookie =3D dma_fence_begin_signalling();
> +	spin_lock_irqsave(&sdev->fence_lock, flags);
> +	list_for_each_entry_safe(job, tmp, &sdev->active, node) {
> +		list_del_init(&job->node);
> +		dma_fence_set_error(job->hw_fence, -ENODEV);
> +		dma_fence_signal_locked(job->hw_fence);
> +	}
> +	spin_unlock_irqrestore(&sdev->fence_lock, flags);
> +	dma_fence_end_signalling(cookie);
> +	mutex_unlock(&sdev->done_lock);
> +	drm_sched_wqueue_start(&sdev->sched);
> +}

[Severity: High]
Can pvrsgx_job_unplug() race with pvrsgx_timedout_job() and
pvrsgx_job_process_done()?

CPU0                              CPU1 (work_tdr)
pvrsgx_job_unplug()               pvrsgx_timedout_job()
  drm_sched_wqueue_stop()
                                    drm_sched_stop(&sdev->sched, ...)
  mutex_lock(&sdev->reset_lock)
  WRITE_ONCE(sdev->lost, true)
  mutex_unlock(&sdev->reset_lock)
  ...
  drm_sched_wqueue_start()
                                    mutex_lock(&sdev->reset_lock)
                                    ...
                                    drm_sched_start(&sdev->sched, 0)
                                      <-- pending_list walked while
                                          scheduler workqueues run

drm_sched_wqueue_stop() does not stop work_tdr, and pvrsgx_timedout_job()
calls drm_sched_stop() and drm_sched_start() outside sdev->reset_lock, so
pvrsgx_job_unplug() can restart the scheduler workqueues while
pvrsgx_timedout_job() is in the middle of a reset.  In addition,
cancel_delayed_work_sync(&sdev->poll_work) runs before sdev->active is
emptied under done_lock and before IRQs are torn down, allowing a concurrent
pvrsgx_job_process_done() to see more =3D=3D true and re-arm poll_work.

> +
> +/*
> + * System sleep: no new job reaches the GPU, and the jobs on it finish, =
or the
> + * timeout's reset ends them, within a job timeout. -EBUSY aborts the su=
spend.
> + */
> +int pvrsgx_job_quiesce(struct pvrsgx_device *sdev)
> +{
> +	long left =3D msecs_to_jiffies(job_timeout_ms) + HZ;
> +
> +	/* A reset restarts submission; stop it again after one. */
> +	for (int i =3D 0; i < 2; i++) {
> +		struct dma_fence *last;
> +
> +		drm_sched_wqueue_stop(&sdev->sched);
> +		/* Set only by run_job, which is stopped. Jobs finish in order. */
> +		last =3D sdev->last_fence;
> +		if (!last || dma_fence_is_signaled(last)) {
> +			flush_work(&sdev->reap_work);
> +			return 0;
> +		}
> +		left =3D dma_fence_wait_timeout(last, false, left);
> +		if (left <=3D 0)
> +			break;
> +	}
> +	drm_err(&sdev->base, "GPU still busy: not suspending\n");
> +	drm_sched_wqueue_start(&sdev->sched);
> +	return -EBUSY;
> +}

[Severity: High]
Can pvrsgx_job_quiesce() return 0 while pvrsgx_timedout_job() is still
resetting the GPU?

CPU0 (suspend)                    CPU1 (work_tdr)
pvrsgx_job_quiesce()              pvrsgx_timedout_job()
  drm_sched_wqueue_stop()
  last =3D sdev->last_fence
  dma_fence_wait_timeout(last)
                                    dma_fence_signal_locked(job->hw_fence)
  /* i =3D 1 */
  drm_sched_wqueue_stop()
  dma_fence_is_signaled(last) -> true
  return 0
                                    pvrsgx_fw_start(sdev)
                                    drm_sched_start(&sdev->sched, 0)
                                      <-- restarts scheduler during suspend

Because pvrsgx_timedout_job() signals job->hw_fence before calling
pvrsgx_fw_start() and drm_sched_start(), pvrsgx_job_quiesce() wakes up, sees
last signaled on the second pass, and lets system suspend proceed into
pvrsgx_fw_stop() concurrently with pvrsgx_fw_start() and drm_sched_start().
Moreover, last is used without dma_fence_get(), so if drm_sched_start()
runs before dma_fence_wait_timeout() returns, a newly started job can
replace and free sdev->last_fence while pvrsgx_job_quiesce() is still using
it; and on normal completion in pvrsgx_job_process_done(), job->hw_fence is
signaled before queue_work(&sdev->reap_work), so flush_work(&sdev->reap_wor=
k)
can run before reap_work is queued.

[ ... ]

> +	ctx =3D kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->vm =3D pvrsgx_vm_lookup(sfile, args->vm_context_handle);
> +	if (!ctx->vm) {
> +		kfree(ctx);
> +		return -ENOENT;
> +	}
> +	ctx->sdev =3D sdev;
> +	ctx->type =3D args->type;
> +	ctx->usage =3D pvrsgx_usage_get(sfile->usage);
> +	kref_init(&ctx->ref);
> +	err =3D ctx->type =3D=3D DRM_POWERVR_SGX_CTX_TYPE_RENDER ?
> +	      pvrsgx_render_ctx_init(sdev, ctx, args->param_buffer_pages) :
> +	      pvrsgx_transfer_ctx_init(sdev, ctx);
> +	if (err)
> +		goto err_put;
> +	err =3D drm_sched_entity_init(&ctx->entity, sched_priority(args->priori=
ty), &sched, 1, NULL);
> +	if (err)
> +		goto err_put;
> +	pvrsgx_vm_user_get(ctx->vm);

[Severity: Medium]
Can pvrsgx_ioctl_destroy_vm_context() drop ctx->vm->users to 0 before
pvrsgx_ioctl_create_context() calls pvrsgx_vm_user_get()?

CPU0                              CPU1
pvrsgx_ioctl_create_context()     pvrsgx_ioctl_destroy_vm_context()
  ctx->vm =3D pvrsgx_vm_lookup()
  ...
                                    xa_erase(&sfile->vms, handle)
                                    pvrsgx_vm_user_put(vm)
                                      /* users: 1 -> 0 */
                                      vm_unmap_all(vm)
  pvrsgx_vm_user_get(ctx->vm)
    /* users: 0 -> 1 on torn-down VM */

pvrsgx_vm_lookup() only takes ctx->vm->ref under xa_lock(&sfile->vms), so a
concurrent DESTROY_VM_CONTEXT can drop vm->users to 0 and unmap the VM befo=
re
pvrsgx_vm_user_get() increments vm->users back to 1.

[ ... ]

> +static void context_destroy(struct pvrsgx_context *ctx)
> +{
> +	/* Its queued jobs are on the GPU or cancelled before its VM's mappings=
 may go. */
> +	drm_sched_entity_destroy(&ctx->entity);
> +	pvrsgx_vm_user_put(ctx->vm);
> +	context_put(ctx);
> +}
> +
> +void pvrsgx_context_destroy_all(struct pvrsgx_file *sfile)
> +{
> +	struct pvrsgx_context *ctx;
> +	unsigned long handle;
> +
> +	xa_for_each(&sfile->contexts, handle, ctx) {
> +		xa_erase(&sfile->contexts, handle);
> +		context_destroy(ctx);
> +	}
> +}
> +
> +int pvrsgx_ioctl_destroy_context(struct drm_device *drm, void *data, str=
uct drm_file *file)
> +{
> +	struct drm_powervr_sgx_ioctl_destroy_context_args *args =3D data;
> +	struct pvrsgx_context *ctx;
> +
> +	if (args->_padding_4)
> +		return -EINVAL;
> +	ctx =3D xa_erase(&to_pvrsgx_file(file)->contexts, args->handle);
> +	if (!ctx)
> +		return -ENOENT;
> +	context_destroy(ctx);
> +	return 0;
> +}
> +
> +struct pvrsgx_context *pvrsgx_context_lookup(struct pvrsgx_file *sfile, =
u32 handle)
> +{
> +	struct pvrsgx_context *ctx;
> +
> +	xa_lock(&sfile->contexts);
> +	ctx =3D xa_load(&sfile->contexts, handle);
> +	if (ctx)
> +		kref_get(&ctx->ref);
> +	xa_unlock(&sfile->contexts);
> +	return ctx;
> +}

[Severity: Critical]
What stops pvrsgx_ioctl_destroy_context() from running context_destroy()
while pvrsgx_ioctl_submit_jobs() is still using ctx->entity?

CPU0                              CPU1
pvrsgx_ioctl_submit_jobs()        pvrsgx_ioctl_destroy_context()
  job_create()
    ctx =3D pvrsgx_context_lookup()
    drm_sched_job_init(&job->base,
                       &ctx->entity, ...)
                                    ctx =3D xa_erase(&sfile->contexts, ...)
                                    context_destroy(ctx)
                                      drm_sched_entity_destroy(&ctx->entity)
                                        /* frees entity->stats,
                                           sets entity->stopped =3D true */
                                      pvrsgx_vm_user_put(ctx->vm)
  drm_sched_job_arm(&job->base)
    /* UAF on entity->stats */
  drm_sched_entity_push_job(&job->base)
    /* stranded on stopped entity */

Because pvrsgx_context_lookup() only takes ctx->ref and context_destroy()
immediately destroys ctx->entity and drops ctx->vm's user count upon
xa_erase(), drm_sched_job_arm() dereferences freed entity->stats, and
drm_sched_entity_push_job() queues the job onto an already-killed entity
where its fence never signals and its job, VM, and runtime PM references
leak forever.

[ ... ]

> +/* The latest earlier job of this submit that signals handle at point, o=
r -1. */
> +static int intra_signaller(const struct job_args *prev, u32 nprev, u32 h=
andle, u64 point)
> +{
> +	for (int k =3D nprev - 1; k >=3D 0; k--) {
> +		for (u32 s =3D 0; s < prev[k].nsignals; s++) {
> +			if (prev[k].signals[s].handle =3D=3D handle &&
> +			    prev[k].signals[s].point =3D=3D point)
> +				return k;
> +		}
> +	}
> +	return -1;
> +}
> +
> +static int job_sync_ops(struct drm_file *file, struct job_args *ja,
> +			const struct drm_powervr_sgx_obj_array *arr,
> +			const struct job_args *prev, u32 nprev)
> +{
> +	struct drm_powervr_sgx_sync_op *ops;
> +	int err =3D 0;
> +
> +	ops =3D pvrsgx_obj_array_get(arr, sizeof(*ops), PVRSGX_MAX_SYNC_OPS);
> +	if (IS_ERR_OR_NULL(ops))
> +		return PTR_ERR_OR_ZERO(ops);
> +
> +	ja->signals =3D kvcalloc(arr->count, sizeof(*ja->signals), GFP_KERNEL);
> +	ja->intra =3D kvcalloc(arr->count, sizeof(*ja->intra), GFP_KERNEL);
> +	if (!ja->signals || !ja->intra) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	for (u32 i =3D 0; i < arr->count && !err; i++) {
> +		u32 type =3D ops[i].flags & DRM_POWERVR_SGX_SYNC_OP_FLAG_HANDLE_TYPE_M=
ASK;
> +		bool timeline =3D type =3D=3D DRM_POWERVR_SGX_SYNC_OP_FLAG_HANDLE_TYPE=
_TIMELINE_SYNCOBJ;
> +		struct dma_fence *fence;
> +
> +		if ((ops[i].flags & ~PVRSGX_SYNC_OP_FLAGS_MASK) ||
> +		    (type !=3D DRM_POWERVR_SGX_SYNC_OP_FLAG_HANDLE_TYPE_SYNCOBJ && !ti=
meline) ||
> +		    (!timeline && ops[i].value)) {
> +			err =3D -EINVAL;
> +			break;
> +		}
> +
> +		if (!(ops[i].flags & DRM_POWERVR_SGX_SYNC_OP_FLAG_SIGNAL)) {
> +			int k =3D intra_signaller(prev, nprev, ops[i].handle, ops[i].value);
> +
> +			/* Its fence exists once that job is armed: added then. */
> +			if (k >=3D 0) {
> +				ja->intra[ja->nintra++] =3D k;
> +				continue;
> +			}
> +			err =3D drm_syncobj_find_fence(file, ops[i].handle, ops[i].value, 0, =
&fence);

[Severity: Medium]
Does intra_signaller() preserve timeline syncobj semantics when jobs in the
same submission signal and wait on a timeline syncobj?

When intra_signaller() matches job k, job_sync_ops() skips
drm_syncobj_find_fence() and pvrsgx_ioctl_submit_jobs() only adds ja[k].done
as a dependency instead of the dma_fence_chain node later installed by
drm_syncobj_add_point(), dropping dependencies on any unsignaled fences
already in the timeline syncobj as well as earlier points signaled by jobs
before k on other contexts.  Furthermore, intra_signaller() checks for exact
point equality (prev[k].signals[s].point =3D=3D point) rather than >=3D poi=
nt (or
point =3D=3D 0 for the latest signaled point), so waiting on a smaller time=
line
point or point 0 misses the earlier job in the batch.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_job.h b/drivers/gpu/drm/p=
owervr_sgx/pvrsgx_job.h
> new file mode 100644
> index 0000000000000..87d3744c79eba
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_job.h

[ ... ]

> +	/** @hw_fence: Signalled when the firmware has finished the job. */
> +	struct dma_fence *hw_fence;
> +	/** @hw_fence_mem: @hw_fence's memory from submit until run_job initial=
izes it. */
> +	struct dma_fence *hw_fence_mem;
> +	/** @ccb_seq: Kernel CCB command that carries the job. */
> +	/** @start_ns: When run_job sent it to the microkernel. */
> +	u64 start_ns;
> +	u64 ccb_seq;

[ ... ]

> +	/** @ranges: The bytes of imports the job reads or writes, flushed arou=
nd it. */
> +	struct pvrsgx_cache_range *ranges;
> +	/** @nranges: Number of @ranges. */
> +	u32 nranges;
> +	/** @signals: Syncobjs to signal with the job's fence. */
> +	struct pvrsgx_signal *signals;
> +	/** @nsignals: Number of @signals. */
> +	u32 nsignals;
> +};

[Severity: Low]
In struct pvrsgx_job, signals and nsignals are unused (syncobj signals are
kept in struct job_args), and the @ccb_seq kernel-doc comment is placed
above start_ns instead of ccb_seq.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D8
