Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D04CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A7E112263;
	Fri,  9 Oct 2026 19:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XWyX/C87";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AC2112263
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:24:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 227AD60267;
 Fri,  9 Oct 2026 19:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E071F000FF;
 Fri,  9 Oct 2026 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573861;
 bh=lIRi1tU0uYPQj0f0YsP3c9x/AIh8eBDksOOxV9AkN7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XWyX/C87cf2+AbJ3PHg/owfYxiNvRAMzyLwO1C7PRVPbq6cVqhniqYyle9X+/AX1Q
 sZgLI3MH9Vm9bAw6Fv31+JUFlfzpBOXPlVy7gmS7B0h08u6GcoTO3y/jnd3juwqaT1
 7jZjiveZijCQDDGzQtuvivzvEHv56M3pvl1qtpLjVGTKj/Al3s5y4Oujn+lDlxBmZ9
 d97qhF66ZYijHCOI7UY0fCew9oywJntM+CQwk7Nkdkzha0xlMtbRskzXLhGELByLKR
 5YAqInSHwpmwOHUm5IsjlXYci+0BxSKNHkBFw6WZfO+XKKt4YA8pvjsMiZ0vlqKY55
 TDzy9gSUlSseQ==
Message-ID: <sashiko-outbox-165998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 6/6] rust: drm: Add JobQueue
To: "Philipp Stanner" <phasta@kernel.org>
Cc: media-ci@linuxtv.org, gary@garyguo.net, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009191124.1022902-8-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
 <20261009191124.1022902-8-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 19:24:20 +0000
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
- [Critical] drm/job_queue: recursive spinlock deadlock when signaling intr=
a-queue dependencies
- [High] drm/job_queue: job is permanently lost when queue capacity is exce=
eded
- [High] drm/job_queue: submit_worker completely ignores dependencies and r=
uns unready jobs
- [High] drm/job_queue: synchronous job completion is permanently missed du=
ring run_job
- [High] drm: JobQueue runs run_job in atomic context due to RevocableGuard
- [Medium] drm/job_queue: capacity is leaked when SubmitWorker cleans up si=
gnaled jobs
- [Medium] drm/job_queue: JobQueue API is unusable due to borrow checker co=
nflict
--

commit 4ab6c27823ae4ac383ac1e5112edd966e2143dbd
Author: Philipp Stanner <phasta@kernel.org>

    rust: drm: Add JobQueue
   =20
    JobQueue is a pure Rust component that handles job submissions for GPUs
    with firmware scheduling, i.e., GPUs that support one exclusive ring per
    execution context.

[ ... ]

> diff --git a/rust/kernel/drm/job_queue.rs b/rust/kernel/drm/job_queue.rs
> new file mode 100644
> index 0000000000000..b5c7f4ecb3f46
> --- /dev/null
> +++ b/rust/kernel/drm/job_queue.rs
> @@ -0,0 +1,525 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +impl<T: JobQueueOps + Send + Sync> ScopedWorkItem for SubmitWorker<'_, T=
> {
> +    fn run(work: &ScopedWorkRef<Self>) {
> +        let Some(jq_accessor) =3D work.jq.inner.try_access() else {
> +            return;
> +        };

[Severity: High]
The JobQueue documentation explicitly states that jobs are submitted in
process context, which normally permits sleeping. However, does this
try_access() call enter an atomic context?

When try_access() returns a RevocableGuard, it intrinsically holds
rcu::read_lock(). Because the jq_accessor guard remains alive across the
subsequent call to T::run_job(), the driver callback is executed entirely
within an RCU read-side critical section, where sleeping is forbidden.

Will this regression cause a "scheduling while atomic" panic if a driver re=
lies
on the documented process context guarantee to sleep, wait on mutexes, or u=
se
GFP_KERNEL allocations inside run_job?

> +
> +        let mut jq =3D jq_accessor.lock();
> +
> +        while let Some(mut job) =3D jq.as_mut().project().waiting_jobs.p=
op_front() {
> +            let new_capacity =3D jq.capacity as i64 - job.cost as i64;

[Severity: High]
Does this bypass the dependency system? JobQueue::submit() pushes jobs
unconditionally to waiting_jobs, and this loop iterates over them and execu=
tes
them as long as there is sufficient queue capacity.

However, it never checks if job.nr_of_deps =3D=3D 0 before executing the jo=
b. Will
this regression result in jobs being sent to the hardware immediately,
regardless of pending dependency fences?

> +            if new_capacity < 0 {
> +                break;
> +            }

[Severity: High]
When this loop encounters a job that exceeds the available capacity, it exe=
cutes
a break to exit. Because the job was already removed from the waiting_jobs =
list
via pop_front(), breaking the loop drops the local job variable, destroying=
 it.

Since the job is never pushed back onto waiting_jobs, its hardware operatio=
ns
will be lost and its completion fence will never signal. Will this regressi=
on
cause a permanent hang for anything depending on it?

> +            *jq.as_mut().project().capacity =3D new_capacity as u64;
> +
> +            let runnable_job =3D JobRunnable {
> +                seqno: job.fence().as_ref().expect("fence not present").=
as_fence().seqno(),
> +                data: job.fence().as_ref().expect("fence not present").d=
eref(),
> +            };
> +
> +            let jq_data =3D work.jq.fctx.deref().deref();
> +
> +            drop(jq);
> +            T::run_job(jq_data, runnable_job);
> +            // The driver could now have taken the lock here and try to =
complete
> +            // this very job. It would then not get signaled because it =
was not
> +            // yet in the running list. However, since the driver comple=
tes jobs
> +            // by sequence number, its subsequent calls to jq.complete_j=
obs_up_to_seqno()
> +            // will signal this job, because then it will be in the runn=
ing_jobs
> +            // list.
> +            // We accept this race because it makes the implementation m=
uch
> +            // simpler and avoids locking issues. Otherwise, complete_jo=
bs_up_to_seqno()
> +            // would need a distinct signaler-object-list to avoid races=
 between
> +            // this work item and said function.
> +            jq =3D jq_accessor.lock();
> +
> +            jq.as_mut().project().running_jobs.push_back(job);

[Severity: High]
The code drops the queue lock before calling T::run_job(). If the driver
completes the job immediately (e.g. via synchronous execution or a very fast
hardware interrupt) and calls complete_jobs_up_to_seqno(), the completion
handler will search running_jobs.

Since the worker hasn't yet pushed the job to running_jobs here, the handler
will completely miss it. If this is the last job in a burst, and no subsequ=
ent
jobs trigger completion, will this regression leave the job hanging forever=
 in
running_jobs without its fence signaling?

> +        }
> +
> +        // Now clean up all already-signaled jobs, dropping their fences.
> +        let mut jq =3D jq.as_mut().project();
> +
> +        let mut cursor =3D jq.running_jobs.cursor_front();
> +
> +        while let Some(job) =3D cursor.peek_next() {
> +            let mut job =3D job.remove();
> +
> +            if !job.fence().as_mut().expect("fence not present").as_fenc=
e().is_signaled() {
> +                jq.running_jobs.push_front(job);
> +                // Jobs complete in order. No point in checking the rest.
> +                break;
> +            }

[Severity: Medium]
This cleanup loop iterates over running_jobs and removes any job whose fence
is signaled. Unlike the standard completion path in
complete_jobs_up_to_seqno() which restores capacity via
*jq.capacity +=3D job.cost, this loop drops the job without updating jq.cap=
acity.

Will this regression cause a permanent reduction in the queue's tracked cap=
acity?

[ ... ]

> +    /// Create a new job.
> +    pub fn new_job(&'a self, cost: u32, data: T::JobDataType) -> Result<=
Job<'a, T>> {

[Severity: Medium]
This borrows the JobQueue immutably (&'a self) for the lifetime of the
returned Job. Later, JobQueue::submit takes a mutable reference (&mut self)=
 and
the Job.

Because self cannot be borrowed mutably while the job's immutable borrow is
active, this creates a strict compile error. While the documentation comment
acknowledges this problem, does this regression make the API structurally
impossible to call from driver code?

[ ... ]

> +    pub fn complete_jobs_up_to_seqno(&self, seqno: u64, status: Result) {
> +        // unwrap() can't fire because `self` is valid.
> +        let jq =3D self.inner.try_access().unwrap();
> +        let mut jq_locked =3D jq.lock();
> +        let mut jq =3D jq_locked.as_mut().project();
> +
> +        let mut cursor =3D jq.running_jobs.cursor_front();
> +
> +        while let Some(job) =3D cursor.peek_next() {
> +            let mut job =3D job.remove();
> +
> +            if job.fence().as_mut().expect("fence not present").as_fence=
().seqno() > seqno {
> +                jq.running_jobs.push_front(job);
> +                break;
> +            }
> +
> +            *jq.capacity +=3D job.cost as u64;
> +
> +            if let Some(fence) =3D job.fence() {
> +                fence.signal(status);

[Severity: Critical]
This function acquires the queue's SpinLockIrq (jq.lock()) and calls
fence.signal() on completed jobs. If another job in the same queue was
configured to depend on this fence, DependencyWaker::on_signal() is executed
synchronously by the dma-fence subsystem.

Since on_signal() then attempts to acquire the exact same queue spinlock via
jq.deref().lock(), will this regression result in a guaranteed recursive
spinlock deadlock on the same CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009191124.1022=
902-2-phasta@kernel.org?part=3D6
