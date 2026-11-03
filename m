Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC78606D836
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq5TULc5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6702110E2C5;
	Tue,  3 Nov 2026 15:32:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FB710E2C5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:32:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 699856021D;
 Tue,  3 Nov 2026 15:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5321F000C1;
 Tue,  3 Nov 2026 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719952;
 bh=VyeiR5vnw71KrKc2dGrrliTZpBidJK/i1XEfJAb6e3g=;
 h=From:To:Cc:Subject:Date;
 b=Pq5TULc5Z+s0xoKNjOnTxsWIe9aBmcz/nGPtud3kgt1buEe/bnaodo7vMpSF+ajAS
 vJClZT9gyXL3ybxShcQZDd0tN5Z9z3jzu0+LaXspRSF3W/7lEjYsVTyNBLw0dEHws+
 opru8B2PtDBGX5LaKO93Hx+d1H8DpzvfinC24vXhHYQaxFno92hYnsZdPo0mCtwGMB
 BjXC5oCowfypwUpQ0oQZPAjb2f72lwbvHU7PLQS4kMFdrhthyVxXaqpE7rTD6ugGqm
 lZ2+ClMGcd59/k6JFkmNCQSN0glHSmKbPtvHm4qBuowk1X3WYHjJfkOYXGAAsz1JnO
 dZw7Yfd3t28MQ==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v7 0/8] rust: Add drm::JobQueue
Date: Tue,  3 Nov 2026 16:31:30 +0100
Message-ID: <20261103153138.1087330-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I really hoped that I could present you guys with a v1 today, but, of
course, I discovered an issue that was overlooked over the last months.
See below.

tl;dr: If JQ1 has dependencies on JQ2, and JQ2 dies, then we also need
to inform JQ1 somehow and act accordingly (teardown).

We need to discuss the desirable solution for that problem, thus I'm
requesting comments by you guys and remain on RFC for now.

Based on drm-rust-next plus ScopedWork by Danilo & Alice [1] and my
lock-error-fix [2]. My branch with a minimalist tester (my old tester updated
by Gary) can be found here [3].

[1] https://lore.kernel.org/rust-for-linux/20261020-rust-workqueue-v3-0-ea7c74d02068@google.com/
[2] https://lore.kernel.org/rust-for-linux/20261022160725.2215244-2-phasta@kernel.org/
[3] https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/tree/jobqueue-jobqueue-rfc-v7-2?ref_type=heads

Changes in v7:
  - Unfortunately, I discovered a design question that we completely
    overlooked so far: If a "neighboring" JQ dies, its fences get
    signaled with an error – but the callbacks registered on a fence
    don't query that error, leading to UB by that GPU ring relying on
    the work being done. Thus:
      - Always inform about errors in
	FenceCallbackRegistration::on_signal() about errors.
      - Similarly, replace Fence::is_signaled(). It's a useless function.
	You *must* query whether a fence got signaled *successfully*.
      - !!! RFC: Add a JobQueueOps::kill() to tell the driver to tear this
	JQ down.
  - Add ID accessors for FenceCtx and JQ.
  - By Gary: Working self references + PinInit. Kudos to Gary!
      - Among the many changes that he did is a portation to a new
	minimalist list-type, since the default list collides with
	self-references.

Changes in v6:
  - Rework DmaFence so you can signal fences without dropping them
    (since we'd have to drop in atomic context otherwise)
  - Use synchronize_rcu() for fence dropping for now – with a fast path
    optimization! – instead of call_rcu() because the latter can run in
    atomic context.
  - Add DropWorker for JobQueue which drops jobs and their fences in
    process context.
  - Rework locking design: All JQ API functions can be invoked without
    any driver locks. run_job() is not executed with the JQ lock held,
    thus the driver can sleep.
  - Add a seqno based approach to catch potential races with the
    unlocked call to run_job().
  - Redesign JobQueue::complete_jobs_up_to_seqno() so that by default
    jobs are completed with status == Ok(()). This is done because it
    makes the race-catcher above easier to implement (otherwise we'd
    have to carry the last error around, and if we ever implement batch
    submissions we'd need a list of errors).
  - Since our design assumption is that users will always close their
    ring and drop their JQ if anything goes wrong on the ring, just
    provide one function that signals with an error on teardown:
    JobQueue::teardown().
  - Move the work items out of the locked JobQueueInner, since the work
    queue lock already synchronizes everything. The
    Revocable<JobQueueInner> needs to stay, however, so that the
    SubmitWorker can be safely cancelled on JQ::drop().
  - Fix various logical bugs that I found (code is unfortunately still
    untested).
  - Extend documentation significantly.
  - Formatting.

Changes in v5:
  - Add back the Revocable<JobQueueInner…> from my earliest RFCs. Reason
    is still the same: JQ dropping while dependency fences signal could
    deadlock. Similarly, this solves a dependency kicking of the work
    item again while drop() is running.
  - Do not call run_job() with a lock held, since run_job() might sleep.
    AFAICS, this also makes the proposed XArray solution impossible and
    demands that we use a list.
  - Re-add the earlier credit-count-system, so that run_job() is
    infallible. Simplifies the design quite a bit. (Danilo)
  - Drop jobs in a deferred manner through the work item so that job
    payload data can do atomic-hostile stuff.
  - Because of the point above, I suggest that we stop dropping a
    DriverFence on signal (Danilo's and my idea). It has no real
    advantage, and getting rid of it allows for better controlling what
    drops when through JobQueue. For fence it's only relevant that there
    is an RCU grace period, thus:
  - Replace DriverFence::drop()'s call_rcu() with synchronize_rcu(). We
    would, therefore, demand that everyone who's got a problem with the
    delay drops via work item.

This can still not be tested as I'm blocked by pin-init vs self-ref.
Just FYI.

I would appreciate confirmation of these following thoughts on locking
design:

1.
I believe that callers of jq.new_job() and jq.submit_job() do not need
an outer serialization mutex. Reason is that JQ serializes with its
internal lock. Sequence numbers cannot take over older seqnos because it
is submit_job() who sets the seqno.

2.
I, furthermore, believe that a driver will not need to hold a
driver-lock while calling jq.complete_jobs_up_to_seqno().

IOW, I am suggesting that a driver can always safely use JQ without an
outer lock, and actually *should* do so to avoid potential locking
issues.

Reason:

let driver_stuff = foo.lock();
let current_gpu_seqno = driver_stuff.get_seqno();
drop(driver_stuff);
jq.complete_jobs_up_to_seqno(current_gpu_seqno);

Thus, I believe that it is OK for me to take the JQ lock in
jq.complete_jobs_up_to_seqno().

Please correct me if I'm missing something.

Should I be wrong and a lock inversion could occur, then we could
hypothetically add a fence Signaler object, with which we could signal
fences with a different lock. Similar to how drm_sched does it with the
hardware_fence.


Regards
P.


====

Cover letter from v4:

As the commit messages and code comments detail, progressing JobQueue is
currently somewhat blocked because of an issue with self-referential
PinInit, which Gary generously offered to investigate.

This code compiles, but the example does not because of the
aformentioned issue. Nevertheless, I wanted to provide another RFC here
so that we can move our discussions forward in the meantime, especially
since very much about JobQueue has changed.

Our, now upstreamed, DmaFence abstractions informed some of the notable
changes in JobQueue. Most notably, JobQueue now owns the FenceContext,
Jobs are created on the queue and own the DriverFence. Jobs, again, are
owned by the JobQueue. We hope to enforce correct behavior that way,
having FenceContext, JobQueue and firmware ring all correspond with each
other 1:1:1.

I suspect that a potential deadlock on JQ drop still exists. I
previously solved that with Revocable, which I tend to think will also
be the way to go here.

(One very great news btw is that we almost magically solved a number of
issues with the new DmaFence design – in combination with this JobQueue
design, for the first time it would be possible to fully support the
dma_fence backend_ops. The driver-unload-problem previously had most
users use intermediate fences, like the drm_sched_fence, which means
that callbacks, e.g. from userspace, could not be passed through to the
driver. Now, with FenceContextOps <-> JobQueueOps, we can theoretically
support all of them)

The differences between this draft and Daniel / Tyr's prototype which
probably are most noteworthy are the different lock design
("Philipp"-JobQueue has one big lock, wheres Tyr-JobQueue has 2, 3 if
you count the XArray lock) and the used data structure.

The presented solution uses lists over XArray because:
  1. XArray is semantically more complex and has an additional lock.
  2. An Xarray-as-ringbuffer needs own algorithms for index tracking,
     wrapp around etc. With list you enqueue into a waiting list, and
     for running you move into the running_list.
  3. The memory reservations we need for pre-allocating everything for
     our job-submission path are solved in one go with list, because a
     job simply contains a list head.
  4. Most notably, it is unclear how XArray behaves for ever-increasing
     indices with a sliding window, whereas the list semantic is well
     understood and deterministic.

I obviously don't claim to own all the wisdom in that regard; it's just
that I still propose this solution because these arguments make me
believe that it is the right one.

Since all the list handling is done with iterators, there is currently
no unsafe needed.


I hope we can discuss many things here before we, hopefully soon, can
address the lifetime issue and move to a v1.


This is based on drm-rust-next (10a6623a24a8), plus Danilo's ScopedWork
[1] and my patches [2][3] regarding 'static and lock errors.

Regards,
Philipp

[1] https://lore.kernel.org/rust-for-linux/20260807165252.3849875-1-dakr@kernel.org/
[2] https://lore.kernel.org/rust-for-linux/20260922083631.444614-2-phasta@kernel.org/
[3] https://lore.kernel.org/rust-for-linux/20260924085523.2620704-2-phasta@kernel.org/

Gary Guo (1):
  samples: rust: Add JobQueue Tester

Philipp Stanner (7):
  rust: DmaFence: Implement Deref for FenceContext
  rust: DmaFence: Add ID accessor for fctx
  rust: DmaFence: Don't drop on signal
  rust: DmaFence: Replace call_rcu() with synchronize_rcu()
  rust: DmaFence: Replace is_signaled() with status()
  rust: DmaFence: Tell results in signaling callbacks
  rust: drm: Add JobQueue

 rust/helpers/dma_fence.c             |   4 +-
 rust/kernel/dma_buf/dma_fence.rs     | 225 ++++----
 rust/kernel/dma_buf/mod.rs           |   3 +-
 rust/kernel/drm/job_queue.rs         | 826 +++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs               |   4 +
 samples/rust/Kconfig                 |  11 +
 samples/rust/Makefile                |   1 +
 samples/rust/rust_jobqueue_tester.rs | 242 ++++++++
 8 files changed, 1195 insertions(+), 121 deletions(-)
 create mode 100644 rust/kernel/drm/job_queue.rs
 create mode 100644 samples/rust/rust_jobqueue_tester.rs

-- 
2.56.0

