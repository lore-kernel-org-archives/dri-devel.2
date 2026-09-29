Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC4CCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6535F10E96B;
	Tue, 29 Sep 2026 11:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D6LQ3yVe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01ACE10E96B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:02:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B4424146B;
 Tue, 29 Sep 2026 11:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1DC1F000FF;
 Tue, 29 Sep 2026 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679774;
 bh=PQEy+j7J7dRO94UZazIvOL+o+VQSQ2PIs/AMZyu7yjc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D6LQ3yVe574PPa3Etm1h0DxGDPK1xUprMRgJD7aUkSGJn5H+lkEQ/F3f4HZzvMH2b
 Un8tY92VnYtcfefReLl/2CKTzloPrFIVy68jcsghmZRmAmD1ZzwSv6TBm6YSNzgpUN
 xWS69ZclqO+0N0wQc0r542jEXjGxGvIyb4HpQe6zFhsIVIz4bjNbdEplWBsMhtQta8
 Pb66QLE/Ytch/aYIGbauxGrYdbXyPawtQPsJFpcJgWzzIg2m8r1zIkbj05aWOiAz3k
 W+tzSLfYzBJFp0XL9mplO3i0dPs7eHmbMgkpiSyCvwR/49JmmnKigAVtskYCqBljkr
 xdCe5BEf2547w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 3/3] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: ojeda@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 gary@garyguo.net
In-Reply-To: <20260929104703.934128-5-phasta@kernel.org>
References: <20260929104703.934128-2-phasta@kernel.org>
 <20260929104703.934128-5-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:02:53 +0000
Message-Id: <20260929110254.3D1DC1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm: self-deadlock in JobQueue::complete_jobs_up_to_seqno when sig=
naling fences
- [High] drm: JobQueue permanently stalls if run_job returns false
- [High] drm: JobQueue drops waiting_jobs without signaling their fences on=
 destruction
- [High] drm: lock inversion deadlock between JobQueue lock and driver hard=
ware locks
- [High] drm: use-after-free of ScopedWork during JobQueue destruction
- [High] drm: AB-BA lock inversion between JobQueue lock and dma_fence locks
- [Medium] drm: Job::add_dependency fails with ENOENT for already signaled =
fences
--

commit bfb454136546eb3a954ab9c169ab5c74abe87b91
Author: Philipp Stanner <phasta@kernel.org>

rust: drm: Add JobQueue

JobQueue is a pure Rust component that handles job submissions for GPUs
with firmware scheduling, i.e., GPUs that support one exclusive ring per
execution context.

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..9a6bc1e8fffcb
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs

[ ... ]

> +        // SAFETY: The `waker` is not forgotten.
> +        let registration =3D unsafe { FenceCallbackRegistration::new(fen=
ce, waker) };
> +        match KBox::pin_init(registration, GFP_KERNEL) {
> +            Err(e) =3D> {
> +                let _ =3D job.nr_of_deps.fetch_sub(1, Relaxed);
> +                return Err(e);
> +            },

[Severity: Medium]
Does this correctly handle fences that are already signaled?

If the provided dma_fence has already signaled,=20
FenceCallbackRegistration::new() will return CallbackError::AlreadySignaled.
By returning Err(e) here, this gets translated into a failure (like -ENOENT)
for the user, rather than treating the dependency as successfully satisfied.

Can we treat the already-signaled case as a success instead of aborting
the job submission?

[ ... ]

> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, T=
> {
> +    fn run(work: &ScopedWorkRef<Self>) {
> +        let fctx_data =3D work.jq.fctx.deref().deref();
> +        let mut jq =3D work.jq.inner.lock();
> +        let mut jq =3D jq.as_mut().project();
> +
> +        let mut cursor =3D jq.waiting_jobs.cursor_front();
> +
> +        while let Some(job) =3D cursor.peek_next() {
> +            if job.nr_of_deps.load(Relaxed) > 0 {
> +                break;
> +            }
> +
> +            let mut job =3D job.remove();
> +            let runnable_job =3D JobRunnable {
> +                seqno: job.fence().as_ref().expect("fence not present").=
as_fence().seqno(),
> +                data: job.fence().as_ref().expect("fence not present").d=
eref(),
> +            };
> +
> +            if !T::run_job(fctx_data, runnable_job) {

[Severity: High]
Can this lead to an AB-BA lock inversion deadlock?

T::run_job() is called here with the JobQueue internal spinlock held. If a
driver implementation acquires its hardware lock inside run_job() to submit
the work, the locking order is JQ-lock -> Driver-lock.

If an IRQ handler concurrently acquires the Driver-lock and then calls
complete_jobs_up_to_seqno() (which takes the JQ-lock), the locking order
is Driver-lock -> JQ-lock, causing a deadlock.

> +                // There was no capacity left. The driver will invoke th=
e JobQueue
> +                // later again.
> +                jq.waiting_jobs.push_front(job);
> +                break;
> +            }
> +
> +            jq.running_jobs.push_back(job);
> +        }
> +
> +        *jq.submit_worker_active =3D false;
> +    }
> +}
> +
> +#[pin_data]
> +struct JobQueueInner<'a, T: JobQueueOps + Send + Sync> {
> +    submit_worker_active: bool,
> +    #[pin]
> +    submit_worker: ScopedWork<SubmitWorker<'a, T>>,
> +    #[pin]
> +    waiting_jobs: List<JobInternal<'a, T>>,

[Severity: High]
Can this struct layout cause a use-after-free during destruction?

In Rust, fields are dropped in declaration order. When JobQueueInner is
dropped, submit_worker is destroyed first, followed by waiting_jobs.

When waiting_jobs are dropped, they unregister their dependencies. If an
external fence signals in this exact window, DependencyWaker::on_signal()
will fire and call check_start_submit_worker(), which will enqueue the
already-freed submit_worker into the system workqueue:

JobQueueInner::check_start_submit_worker() {
    ...
    unsafe { workqueue::system_dfl().enqueue_scoped(&*self.submit_worker) };
}

[ ... ]

> +    pub fn complete_jobs_up_to_seqno(&self, seqno: u64, status: Result) {
> +        let mut jq =3D self.inner.lock();
> +        let mut jq =3D jq.as_mut().project();
> +
> +        let mut cursor =3D jq.running_jobs.cursor_front();
> +
> +        while let Some(job) =3D cursor.peek_next() {
> +            let mut job =3D job.remove();
> +
> +            // TODO RFC I couldn't figure out how to access job.fence wi=
thout removing first:
> +            // `if job.deref().fence.get_mut().unwrap().as_fence().seqno=
() > seqno {` ???
> +            if job.fence().as_mut().expect("fence not present").as_fence=
().seqno() > seqno {
> +                jq.running_jobs.push_front(job);
> +                return;
> +            }
> +
> +            job.fence().take().expect("fence not present").signal(status=
);

[Severity: High]
Does this cause a spinlock self-deadlock when dependencies exist within the
same queue?

If job B depends on job A, and job A completes, calling signal() here while
the self.inner.lock() is held will synchronously invoke job B's callback
(DependencyWaker::on_signal).

That callback then immediately tries to acquire the same JobQueue lock via
self.jq.inner.lock(), resulting in an immediate self-deadlock on the CPU.

[Severity: High]
Can this also cause an AB-BA lock inversion with dma_fence locks?

The job is removed from the list and drops at the end of this while loop
iteration, still holding the JobQueue lock. Dropping the job unregisters its
dependencies, which acquires external dma_fence locks (JQ-lock -> Fence-loc=
k).

Concurrently, if an external dependency fence signals, dma_fence_signal()
holds the Fence-lock and invokes DependencyWaker::on_signal(), which tries
to acquire the JobQueue lock (Fence-lock -> JQ-lock).

> +        }
> +    }

[Severity: High]
If T::run_job() returns false, how does the queue ever resume?

When run_job() indicates no capacity, SubmitWorker::run exits and sets
submit_worker_active to false.

When running jobs later finish, complete_jobs_up_to_seqno() frees up
capacity but it never calls check_start_submit_worker() to wake the worker
back up. This leaves the waiting_jobs stranded and the queue permanently
stalled.

[ ... ]

> +#[pinned_drop]
> +impl<T: JobQueueOps + Send + Sync> PinnedDrop for JobQueue<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        self.complete_jobs_up_to_seqno(u64::MAX, Err(ECANCELED));

[Severity: High]
Does this leave userspace processes hanging on waiting_jobs?

This cleanup routine calls complete_jobs_up_to_seqno(u64::MAX), which only
iterates over the running_jobs list. The jobs in waiting_jobs are then
destroyed via struct field drops, but their DriverFence instances will be
dropped without ever being signaled.

Any userspace process or kernel subsystem waiting on these pending jobs
would hang forever. Should waiting_jobs also be aborted and signaled here?

> +        // TODO: Warn if JQ drops with remaining jobs. Or maybe not? It =
is being
> +        // proposed to drop things implicitly.
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929104703.9341=
28-2-phasta@kernel.org?part=3D3
