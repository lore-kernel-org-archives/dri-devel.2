Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63CCCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E758010EE32;
	Tue, 29 Sep 2026 10:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EoTbshS1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7892510EE32
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:49:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE446600E2;
 Tue, 29 Sep 2026 10:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4642C1F000FF;
 Tue, 29 Sep 2026 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790678998;
 bh=32ZRANfll4O1x2Q2EOwPJ1LVv3bI8+SuK9JS0e4fRVE=;
 h=From:To:Cc:Subject:Date;
 b=EoTbshS1GNDmu/Ij033xgySahdEik2+stQ35zh3yDQyNnscycEd2aX0BEjWfXSkRi
 BZqCW2pDT4/pomvP4E23ETv/Fc73KLuL72bv5m0hlG9O9zqQfKod/fNj9Xc6v5HA9s
 znnDsscEvuVtyoKYbtSiiarYSYK1NrOrRcApduMuNfsNtAKApsMP/oRR77GslCAN1a
 /Be3OZccwuJQdq4IwmWC3PYev+8R7AaYo0LQfq9P2U6voZ/S+BX0shkiCXdAmeU/ue
 Gib5set7pxgX5lNCLt8gtRcs1PZ1Iqkx+3hrk00xQEkYFdLrwzSOkNXVYvPuxtBv/T
 RYyn5uJBA8u9A==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v4 0/3] rust: Add drm::JobQueue
Date: Tue, 29 Sep 2026 12:47:00 +0200
Message-ID: <20260929104703.934128-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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

Philipp Stanner (3):
  rust: DmaFence: remove static lifetime
  rust: DmaFence: Implement Deref for FenceContext
  rust: drm: Add JobQueue

 rust/kernel/dma_buf/dma_fence.rs |  17 +-
 rust/kernel/drm/job_queue.rs     | 493 +++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs           |   4 +
 3 files changed, 510 insertions(+), 4 deletions(-)
 create mode 100644 rust/kernel/drm/job_queue.rs

-- 
2.55.0

