Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7B606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DL3bJFwi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8A210F6CD;
	Tue,  3 Nov 2026 16:07:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F32610F6DB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:07:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A59EB60136;
 Tue,  3 Nov 2026 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD091F000C1;
 Tue,  3 Nov 2026 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793722045;
 bh=QA+8wheMrzB43CaPNGq9pZLq3F+Cy0tklwPtORiGicI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DL3bJFwiqmIA+ShtdiejpnpY4i9mq8t+Y59f12kZQ31e/0VGHokJR1P+5y8g34rml
 u/e5e7nBFVcWu0My7for8Jplw0EjMYVpUQK6J6xn62IG17IPauh/ybnnqTgGSr+uQ4
 Xng3lRDyOKjBS6KH2FEmjph9JP9Tu7/XBRO6gS0GchwmdvKshW9WUvPbXiFK40zRYT
 Ov9QMmj860GITK14BfdH2PiZvg+wGFRGk9eoEmBt1JQeUk/f6Z0IlKh3fYtJDFP1Rf
 XLjOC7qRkDZ/M3jx/6TdqPLUbsZZoVHwpeKw/uagBqDHTiEijElAuxwDq1aDuNrg11
 iKnLUhUMCli6A==
Message-ID: <sashiko-outbox-195697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 8/8] samples: rust: Add JobQueue Tester
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261103153138.1087330-10-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-10-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:07:24 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] samples: rust: DriverFence drop order in init() sleeps under spinl=
ock
- [High] samples: rust: premature job completion and seqno 0 leak queue cap=
acity
- [High] rust: dma_fence: DriverFence::drop() drops NonNull instead of payl=
oad
- [Medium] samples: rust: broken Kconfig select and missing DRM=3Dy depende=
ncy
- [Medium] samples: rust: vacuous blocked-job checks and late job4/5 submit=
 in init()
- [Medium] rust: drm: DependencyWaker::on_signal() runs jobs after dependen=
cy error
- [Low] samples: rust: missing Signed-off-by and wrong module description
--

commit 8d8d7d10602aa63f4a1f88e3bb899d199cf28755
Author: Gary Guo <gary@garyguo.net>

samples: rust: Add JobQueue Tester

This commit adds a sample Rust module to test drm::JobQueue job submission,
dependency handling, and completion.

>     samples: rust: Add JobQueue Tester
>    =20
>     Some test code for the JobQueue

[Severity: Low]
This isn't a bug, but is the commit message missing a Signed-off-by tag?

> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 31d62533ef25f..a5754fe03fd5c 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -190,4 +190,15 @@ config SAMPLE_RUST_HOSTPROGS
> =20
>  	  If unsure, say N.
> =20
> +config SAMPLE_RUST_JOBQUEUE_TESTER
> +	tristate "Jobqueue Tester"
> +	select JOBQUEUE_TESTER

[Severity: Medium]
Does this Kconfig entry cause a Kconfig warning and build failure when
CONFIG_DRM is disabled or built as a module?

No Kconfig symbol named JOBQUEUE_TESTER exists in the tree, so selecting it
triggers an undefined symbol warning.

In addition, samples/rust/rust_jobqueue_tester.rs unconditionally imports
kernel::dma_buf and kernel::drm, which are gated in rust/kernel/lib.rs:

    #[cfg(CONFIG_DMA_SHARED_BUFFER)]
    pub mod dma_buf;
    pub mod driver;
    #[cfg(CONFIG_DRM =3D "y")]
    pub mod drm;

Should SAMPLE_RUST_JOBQUEUE_TESTER drop select JOBQUEUE_TESTER and add depe=
nds
on DRM=3Dy?

Furthermore, when CONFIG_DRM=3Dy is enabled, does rust/kernel/drm/job_queue=
.rs
compile cleanly? It currently imports new_scoped_work, ScopedWork,
ScopedWorkItem, and ScopedWorkRef and calls Queue::enqueue_scoped(), none of
which exist in rust/kernel/workqueue.rs, and implements FenceCallback (which
requires Send + 'static in rust/kernel/dma_buf/dma_fence.rs) for non-'static
DependencyWaker.

[ ... ]

> diff --git a/samples/rust/rust_jobqueue_tester.rs b/samples/rust/rust_job=
queue_tester.rs
> new file mode 100644
> index 0000000000000..48dd1188f7dbe
> --- /dev/null
> +++ b/samples/rust/rust_jobqueue_tester.rs
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Small example demonstrating how to use [`drm::JobQueue`].
> +
> +use kernel::dma_buf::{FenceContext, FenceContextOps, Fence, FenceStatus};
> +use kernel::drm::{JobQueue, JobQueueOps, JobRunnable};
> +use kernel::prelude::*;
> +use kernel::str::CString;
> +use kernel::task::might_sleep;
> +use kernel::time::{delay::fsleep, Delta};
> +
> +module! {
> +    type: RustJobqueueTester,
> +    name: "rust_jobqueue_tester",
> +    authors: ["Philipp Stanner"],
> +    description: "Rust minimal sample",
> +    license: "GPL",
> +}

[Severity: Low]
This isn't a bug, but was the description "Rust minimal sample" in module!
copied from samples/rust/rust_minimal.rs instead of describing the JobQueue
tester?

[ ... ]

> +struct JobPayload {}
> +
> +impl Drop for JobPayload {
> +    fn drop(&mut self) {
> +        might_sleep();
> +    }
> +}

[Severity: High]
Does JobPayload::drop() ever get invoked when jobs and their fences are
dropped?

JobQueue stores T::JobDataType (JobPayload) as the FenceDataType of its
internal FenceContext. In rust/kernel/dma_buf/dma_fence.rs, DriverFence hol=
ds
data: NonNull<DriverFenceData<'a, T>>, and DriverFence::drop() currently
runs:

    // SAFETY: Valid because `self` is valid.
    unsafe { drop_in_place(&raw mut self.data) };

Because self.data is a NonNull pointer wrapper with no Drop implementation,
drop_in_place(&raw mut self.data) is a no-op instead of dropping
(*self.data.as_ptr()).data. As a result, T::FenceDataType is leaked and the
sleepable drop test in JobPayload::drop() is bypassed.

> +
> +impl JobQueueOps for JqData {
> +    type JobDataType =3D JobPayload;
> +
> +    fn run_job<'a>(&self, job: JobRunnable<'a, JobPayload>) {
> +        // Simulate GPU work completing after a short delay. In a real d=
river
> +        // this would submit work to the hardware ring.
> +        pr_info!("run_job: seqno {}\n", job.seqno);
> +    }

[ ... ]

> +        let driver_name =3D CString::try_from_fmt(fmt!("rust-jobqueue-te=
ster"))?;
> +        let timeline_name =3D CString::try_from_fmt(fmt!("rust-jq-tester=
-hw-timeline"))?;
> +        let jq =3D KBox::pin_init(
> +            JobQueue::new(0, driver_name, timeline_name, 1_000_000, JqDa=
ta::new()),
> +            GFP_KERNEL,
> +        )?;
> +
> +        pr_info!("Test 1: Test submitting two jobs without dependencies.=
\n");
> +        let job1 =3D jq.new_job(1, JobPayload {})?;
> +        let job2 =3D jq.new_job(1, JobPayload {})?;
> +
> +        let fence1 =3D job1.submit();
> +        let fence2 =3D job2.submit();
> +
> +        // Complete both jobs by seqno so their fences get signaled.
> +        jq.complete_jobs_up_to_seqno(fence2.seqno());
> +
> +        // Give the submit worker a chance to run.
> +        fsleep(Delta::from_millis(100));

[Severity: High]
Does passing initial_seqno =3D 0 to JobQueue::new() and calling
complete_jobs_up_to_seqno() before sleeping cause premature job completion =
and
leak queue capacity?

First, in rust/kernel/drm/job_queue.rs, JobQueue::new() initializes
JobQueueInner::last_completed to 0:

    inner <- new_spinlock_irq!(try_pin_init!(JobQueueInner {
        capacity,
        last_completed: 0,
        waiting_jobs: UniqueList::new(),
        running_jobs: UniqueList::new(),
        drop_list: UniqueList::new(),
    })),

When initial_seqno is 0, FenceContext::next_seqno() assigns seqno 0 to the
first submitted job, which immediately satisfies jq.last_completed >=3D seq=
no
(0 >=3D 0) in SubmitWorker::run() even before complete_jobs_up_to_seqno() is
called.

Second, in Test 1, Test 2, and Test 5 (phases 1 and 4),
jq.complete_jobs_up_to_seqno() is called synchronously right after
job.submit() and before fsleep(). Because SubmitWorker runs asynchronously =
on
a workqueue, the jobs are still in waiting_jobs rather than running_jobs wh=
en
complete_jobs_up_to_seqno() executes, so complete_jobs_up_to_seqno() only
updates last_completed =3D seqno while running_jobs and drop_list are empty.

When SubmitWorker::run() later processes those jobs, it subtracts job.cost
from jq.capacity and takes the jq.last_completed >=3D seqno branch:

    if jq.last_completed >=3D seqno {
        fence.signal(Ok(()));

        // Drop here directly if possible. Otherwise, let the DropWorker
        // take care of it.
        if core::mem::needs_drop::<T::JobDataType>() {
            jq.drop_list.push_back(job);
        }
    } else {
        jq.running_jobs.push_back(job);
    }

Unlike complete_jobs_up_to_seqno(), that branch never restores jq.capacity =
+=3D
u64::from(job.cost), permanently leaking capacity credits, and never calls
check_start_drop_worker() after pushing onto jq.drop_list.

[ ... ]

> +        pr_info!("Test 3: Test that a job with unfulfilled dependency do=
es not get run.\n");
> +        let unsignaled_alloc =3D dep_fctx.new_fence_allocation(())?;
> +        let unsignaled_fence =3D unsignaled_alloc.new_fence();
> +
> +        let mut job4 =3D jq.new_job(1, JobPayload {})?;
> +        job4.add_dependency(unsignaled_fence.as_fence())?;
> +
> +        let blocked_job_fence =3D job4.submit();
> +
> +        // Give the submit worker a chance to run (it should NOT run job=
4).
> +        fsleep(Delta::from_millis(100));
> +
> +        if is_signaled(&blocked_job_fence) {
> +            pr_info!("Test 3 failed.\n");
> +            return Err(EAGAIN);
> +        }

[Severity: High]
If RustJobqueueTester::init() returns an error here in Test 3 or later in
Test 5 while an unsignaled dependency DriverFence has a registered callback,
will stack unwinding sleep while holding a spinlock with interrupts disable=
d?

Because jq is declared before unsignaled_fence in Test 3 (and before job3 a=
nd
unsignaled_fence1, unsignaled_fence2, and unsignaled_fence3 in Test 5), Rust
drops the unsignaled DriverFence locals before job3 and jq on any early err=
or
return.

When an unsignaled DriverFence is dropped, DriverFence::drop() in
rust/kernel/dma_buf/dma_fence.rs acquires dma_fence_lock_irqsave(), sets
ECANCELED, and calls dma_fence_signal_locked(). That synchronously invokes
DependencyWaker::on_signal() in rust/kernel/drm/job_queue.rs with
Err(ECANCELED):

    fn on_signal(&mut self, res: Result) {
        if let Err(err) =3D res {
            // Dependencies are unfulfilled and will never be fulfilled. Ha=
lt the
            // submit_worker and tell the driver to tear this JQ down.
            self.jq.revoked.store(true, Relaxed);
            self.jq.srcu.synchronize();

Calling self.jq.srcu.synchronize() (synchronize_srcu()) while holding
dma_fence_lock_irqsave sleeps in atomic context.

[Severity: Medium]
Also in DependencyWaker::on_signal(), when res is Err(err), execution does =
not
return after calling T::kill() and instead falls through to:

        // Last dependency kicks the worker.
        if self.nr_of_deps.fetch_sub(1, Relaxed) =3D=3D 1 {
            // The drop-order of JobQueue ensures that all DependencyWakers=
 are
            // cancelled before the JobQueue itself is dropped.
            self.jq.check_start_submit_worker();
        }

In SubmitWorker::run(), work.revoked.load(Relaxed) is only checked once bef=
ore
the while let Some(job) =3D jq.as_mut().project().waiting_jobs.pop_front() =
loop,
and is not re-checked after retaking work.inner.lock() across T::run_job().
Could a failed dependency decrement nr_of_deps to 0 and allow SubmitWorker =
to
run a job whose dependency errored?

[ ... ]

> +        pr_info!("Test 5: Submit unblocked jobs, then a blocked one, the=
n unblocked ones.\n");
> +        let job1 =3D jq.new_job(1, JobPayload {})?;
> +        let job2 =3D jq.new_job(1, JobPayload {})?;
> +        let mut job3 =3D jq.new_job(1, JobPayload {})?;
> +        let job4 =3D jq.new_job(1, JobPayload {})?;
> +        let job5 =3D jq.new_job(1, JobPayload {})?;
> +
> +        let unsignaled_alloc1 =3D dep_fctx.new_fence_allocation(())?;
> +        let unsignaled_fence1 =3D unsignaled_alloc1.new_fence();
> +        let unsignaled_alloc2 =3D dep_fctx.new_fence_allocation(())?;
> +        let unsignaled_fence2 =3D unsignaled_alloc2.new_fence();
> +        let unsignaled_alloc3 =3D dep_fctx.new_fence_allocation(())?;
> +        let unsignaled_fence3 =3D unsignaled_alloc3.new_fence();
> +
> +        job3.add_dependency(unsignaled_fence1.as_fence())?;
> +        job3.add_dependency(unsignaled_fence2.as_fence())?;
> +        job3.add_dependency(unsignaled_fence3.as_fence())?;
> +
> +        let fence1 =3D job1.submit();
> +        let fence2 =3D job2.submit();
> +        let fence3 =3D job3.submit();
> +
> +        // Complete unblocked jobs 1 and 2.
> +        jq.complete_jobs_up_to_seqno(fence2.seqno());
> +        fsleep(Delta::from_millis(100));
> +
> +        if is_signaled(&fence3) || !is_signaled(&fence1) || !is_signaled=
(&fence2) {
> +            pr_info!("Test 5 failed (phase 1).\n");
> +            return Err(EAGAIN);
> +        }
> +
> +        // Signal two of three dependencies =E2=80=94 job3 should still =
be blocked.
> +        unsignaled_fence1.signal(Ok(()));
> +        unsignaled_fence3.signal(Ok(()));
> +        fsleep(Delta::from_millis(200));
> +
> +        if is_signaled(&fence3) {
> +            pr_info!("Test 5 failed (phase 2).\n");
> +            return Err(EAGAIN);
> +        }
> +
> +        // Signal the last dependency =E2=80=94 job3 should now be runna=
ble.
> +        unsignaled_fence2.signal(Ok(()));
> +        fsleep(Delta::from_millis(500));
> +
> +        // Complete job3 and the remaining jobs.
> +        jq.complete_jobs_up_to_seqno(fence3.seqno());
> +        fsleep(Delta::from_millis(100));
> +
> +        if !is_signaled(&fence3) {
> +            pr_info!("Test 5 failed (phase 3).\n");
> +            return Err(EAGAIN);
> +        }
> +
> +        let fence4 =3D job4.submit();
> +        let fence5 =3D job5.submit();

[Severity: Medium]
Are the blocked-job checks in Test 3 and Test 5 (phases 1 and 2) able to
detect if a blocked job is run prematurely, and should job4 and job5 be
submitted before job3 is unblocked?

In SubmitWorker::run(), running a job calls JqData::run_job() and moves the
job to running_jobs without signaling the job fence unless
jq.last_completed >=3D seqno. Because JqData::run_job() only prints a messa=
ge
and complete_jobs_up_to_seqno() has not been called for blocked_job_fence in
Test 3 or fence3 in Test 5 phases 1 and 2, is_signaled(&blocked_job_fence) =
and
is_signaled(&fence3) will always return false even if SubmitWorker ignored
dependencies and called run_job() immediately.

Additionally, Test 5 states "Submit unblocked jobs, then a blocked one, then
unblocked ones" and creates job1 through job5 up front, with the phase 3
comment saying "Complete job3 and the remaining jobs." However, job4.submit=
()
and job5.submit() are only called here in phase 4 after job3 has already be=
en
unblocked and completed, so job4 and job5 are never queued behind the block=
ed
job3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103153138.1087=
330-2-phasta@kernel.org?part=3D8
