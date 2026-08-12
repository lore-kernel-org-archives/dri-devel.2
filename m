Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F84C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B23D10EE88;
	Wed, 12 Aug 2026 07:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mbBmGpKE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7398410EE85
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:22:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BDDD40808;
 Wed, 12 Aug 2026 07:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68DD1F000E9;
 Wed, 12 Aug 2026 07:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786519348;
 bh=NilwH3fK/JzWmWRQYl8d1/1N2kdnY/ZL6soeH/hekhM=;
 h=From:To:Cc:Subject:Date;
 b=mbBmGpKEBYZBNjDKlC9wYB7EkahdWSrkg/f9SykHy9E3TeoDDVjV9tR02hdOTPZuo
 BVhVUX3G11ZJWhn5Y+T+M7hjTZbdTmAFg6BG6s1k8Lnneiyn9anFNMkkUK0UuY93x0
 H5zsPZk6jbuEQUlfyuoSmS4fk2aFWatufQ15zK4mWwfY9V68GKN6swt9pNcLvTK+gV
 PKKNLq6X5DELNen6CWx86RqTz5X75SOMRgb18+PBSrj7WSjeF4tXgGzzcmfr/zVwi8
 qmM3NvcmFaoB7gcIRzL40tcaE/Dh2hbBtrgX3ag5hZbi4gCfn2fEICw8pHj3tJYw+T
 GYC48E6okz3mQ==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <burak.emir@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v10 0/2] rust / dma_buf: Add abstractions for dma_fence
Date: Wed, 12 Aug 2026 09:22:15 +0200
Message-ID: <20260812072217.1971807-2-phasta@kernel.org>
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

Changes since v9:
  - Rebase on rust-next, since Miguel has merged our prerequisites.
  - Add R-b from Daniel.
  All from Gary:
  - Use an Atomic<usize> for nr_of_unsignaled_fences.
  - Comment improvement / formatting.
  - *const instead of *mut raw pointer.
  - Make small public functions `inline`.
  - Rename "called" callback to "on_signal".
  - Improve the internal helper lock FenceGuard.
  - Add needs_drop fastpath check in DriverFence::drop().

Changes since v8:
  - Improve function naming. (Daniel)
  - Panic in case of forgotten fences. (Alice)
    (reason being that this cannot happen with the intended JobQueue
    design, it would be a fatal bug anyways and we can easily fix this up)
  - Improve spelling and grammar. (Daniel)
  - Add Daniel's Tested-by
  - Improve Copyright notice to SPDX. (Daniel)

Changes since v7:
  - Remove the forgotten-fences-tracking from FenceContext. Merely warn
    in this unlikely case, using an atomic integer.
  - Be more verbose in warnings about what exactly the problem is.

Changes since v6:
  - Add Timur's error code patch (just so that the series builds. Merge
    however you prefer). (Timur)
  - Replace XArray with list, remove XArray patch.
  - Detail the issue with core::mem::forget() in the commit message.
  - Some code formatting etc.

Changes since v5:
  - Because Rust can "forget" DriverFences, it could bypass the lifetime
    ensuring that DriverFences don't outlive a FenceContext. Mitigate
    this by having the FenceContext keep track of unsignaled fences.
    (Danilo)
  - To support the point above, add support for memory reservations to
    XArray.
  - To support the point above, have FenceContext::alloc_fence()
    increment the sequence number. This is necessary for the xarray
    index. It might become critical with fence seqno holes.. please
    review.
  - Remove acronyms in declarations. (Daniel)
  - Allow for providing initial seqno in FenceContext::new(). (Daniel)
  - Flesh out documentation about DriverFence <-> Fence. (Daniel)
  - Flesh out documentation about weirdness in C backend. (Daniel)
  - Add new, purely internal locking helper / guard for dma_fence.
  - Use the kernel atomics (Gary).
  - Curse angrily at my computer.

Changes since v4:
  - Fix an uninitialized memory bug for FenceCbRegistration with
    ManuallyDrop.
  - Return FenceCtx as impl PinInit
  - Make FenceCtx return an impl PinInit<T, Error> (Danilo)
  - Reformat some comments

Changes since v3:
  - Add a FIXME for an encountered Rust compiler bug. (Gary)
  - Add new Rust files also to DRM drivers & common infrastructure
    MAINTAINERS file. (Danilo)
  - Reposition ECANCELED error code. (Miguel)
  - Replace refcounted FenceCtx in DriverFenceData with a reference plus
    life time. (Boris)
  - Re-add rcu_barrier() patch, since we now can use it for dropping the
    fence context. (Danilo)
  - Add forgotten R-b from Alice, and Acks for MAINTAINERS from
    Christian and Sumit.

Changes since v2:
  - Don't drop DriverFenceData as a whole, but only the members we
    really want to drop. Gives more robustness. (Gary).
  - Break apart large pin_init_from_closure(). (Danilo, Onur)
  - Remove rcu_barrier() and synchronize_rcu() from FenceCtx::drop().
    FenceCtx might drop in atomic context, where you must not perform
    those operations. With the current way C dma_fence is designed, the
    driver must wait for a grace period manually until it unloads.
  - Repair the DriverFenceBorrow implementation, properly injecting a
    life time into it. (Danilo)
  - Fix memory layout bug for rcu_head. (Onur)
  - Drop RCU patches, since this series doesn't need them anymore.

Changes since v1:
  - Remove unnecessary mutable references (Alice)
  - Split up unsafe comments where possible (Danilo)
  - Remove PhantomData + implement FenceCtx ops trait (Boris)
  - Consistently call FenceCtx generic data `T`. FenceDataType is
    derived from that. (Boris)
  - Add abstractions for call_rcu() and synchronize_rcu() (Danilo)
  - Add ECANCELED error code in Rust (Alice)
  - Remove the rcu_barrier() from FenceCtx::drop() – because we now use
    call_rcu(), there can be no UAF access to the FenceCtx anymore. In
    any case, it is illegal to use either call_rcu() or
    synchronize_rcu() in FenceCtx::drop(), because our new
    drop_driver_fence_data() can run in atomic context and might put the
    last fence_ctx reference.
    So we now only have to guard against module unload, which it seems
    either the driver or Rust driver-core / module unload infrastructure
    must solve.
  - Minor formatting etc. changes
  - Add C helpers to MAINTAINERS. (Danilo)
  - Ensure that `Fence::is_signaled()` is fully synchronized, i.e., all
    callbacks really have run. See [1] and [2]. (Myself, Christian
    König)

Changes since the RFCs:
  - Include support for ForeignOwnable for ARef, so that a Fence can be
    stuffed into an XArray et al. (Code by Danilo)
  - Implement ForeignOwnable (with new borrow type) for DriverFence, so
    that it can be stuffed into an XArray.
  - Include the rcu::RcuBox data type to defer dropping data with RCU
    (Cody by Alice)
  - Port DmaFence to RcuBox to make UAF bugs through later, new dma_fence
    callbacks (backend_ops) impossible.
  - Force users to pass their fence data in an RcuBox (or have it not
    need drop()) through a Sealed trait.
  - Document the rules for the user's DriverFence::data's drop
    implementation very clearly (deadlock danger).
  - rustfmt, Clippy.
  - Various style suggestions, safety comments, etc. (Önur)
  - Add __rust_helper prefix to helper functions. (Önur)

Changes in RFC v3:
  - Omit JobQueue patches for now
  - Completely redesign the memory layout: Instead of a Fence
    refcounting a DriverFence, both now live in the same allocation to
    allow for future support the dma_fence backend_ops callbacks which
    need to do container_of. (mostly Boris's feedback)
  - Allow for pre-allocating fences to avoid deadlocks when submitting
    jobs to a GPU. (Boris)
  - Simultaneously, allow for pre-preparing fence callback objects, so
    the driver can allocate them when it sees fit. (code largely stolen
    and inspired by Daniel).
  - Signal fences on drop, ensure synchronization.
  - Force users to set an error code when signalling.
  - Write more documentation
  - A ton of minor other changes.


[1] https://lore.kernel.org/dri-devel/20260608142436.265820-2-phasta@kernel.org/
[2] https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kernel.org/


Alright, so since the last RFCs did not reveal significant design
issues, I decided to transition this series to a v1 and hope that we can
get it upstream.

This now includes code for more common infrastructure that dma_fence
needs, contributed by Danilo and Alice.

---

Old cover letter for RFC:

So, this is the spiritual successor of the first / second RFC [1]. v2
also contained code for drm::JobQueue, but mostly to show how the fence
code would be used. JobQueue is under heavy rework right now, so I don't
want to bother your eyes with it. The docstring examples should show how
Rust fences are supposed to be used, though.

This v3 contains a huge amount of highly valuable feedback from a
variety of people, notably Boris, but also from Alice, Gary and Danilo.

There are some TODOs open (a better trait for fence backend_ops and RCU
support), but my hope is that this effort is now finally approaching its
end.

I would greatly appreciate feedback and especially more information
about what might be missing to make this usable, which is obviously
where Daniel's and Boris's feedback will be valuable once more.

Please regard this patch just as what it's titled: an RFC, to discuss a
bit more and to inform a broader community about what the current state
is and where this is heading at.

Many regards,
Philipp

[1] https://lore.kernel.org/rust-for-linux/20260203081403.68733-2-phasta@kernel.org/

Philipp Stanner (2):
  rust: Add dma_fence abstractions
  MAINTAINERS: Add entry for Rust dma-buf

 MAINTAINERS                      |    5 +
 rust/bindings/bindings_helper.h  |    1 +
 rust/helpers/dma_fence.c         |   48 ++
 rust/helpers/helpers.c           |    1 +
 rust/kernel/dma_buf/dma_fence.rs | 1022 ++++++++++++++++++++++++++++++
 rust/kernel/dma_buf/mod.rs       |   14 +
 rust/kernel/lib.rs               |    1 +
 7 files changed, 1092 insertions(+)
 create mode 100644 rust/helpers/dma_fence.c
 create mode 100644 rust/kernel/dma_buf/dma_fence.rs
 create mode 100644 rust/kernel/dma_buf/mod.rs


base-commit: d8973c47544371613313ecb9a8c3e7b244aa9bbf
-- 
2.55.0

