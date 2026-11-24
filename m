Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD102606A688
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHAhYtW7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F7310E866;
	Tue, 24 Nov 2026 12:30:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0872D10E866
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:30:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4B8743C82;
 Tue, 24 Nov 2026 12:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325981F000CF;
 Tue, 24 Nov 2026 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523423;
 bh=VG8BxwmxK2eEGyGiTPMxLHYfSj68j9MEuEHEhkL+Yaw=;
 h=From:To:Cc:Subject:Date;
 b=OHAhYtW7ROWFK6+c+ktPF4Oqi42/OuyUcEwEabMdWWwFXxEvlkv6JwJKqJ0xsajr3
 sBCDSVsct1SwREWbbE6oy1t+4eM34eIS0gaqB5GI9da5Pq6H/NdK6Nb1hZ7IveZsz6
 mLA76U5yUuTAKMDsIHqRWPqCp71YNSnw0j54GltcApNScy7XNxi9Y5BGN0PiVVvYwk
 1Qp39dxEIQQ1FCv1ESm7XKETxZ6Hm2si1GzThbaXfvoGFv7USVpawKC37Q33indmow
 nnuv++EJpYHBs84WwLwv5hIVqGaw9VHBU7qUScU/uTLnkHNSrNyjw2vKK8cQFR7zwL
 VCXNwVDoohsVA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 00/10] rust: Add drm::JobQueue
Date: Tue, 24 Nov 2026 13:29:42 +0100
Message-ID: <20261124122951.878199-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v2:
  - Fence:
    - Use cond_synchronize_rcu() to speed up fence dropping. (Gary)
    - status(): Don't lock anymore, since I fixed the misordering
      in C [1].
  - JQ:
    - In v1, jobs could be forgotten without being submitted, causing
      UAF. Fixed it by incrementing the atomic by 1, decremented then
      later in submit.
    - Fix bug where I was holding the lock while dropping stuff. (Younes)
    - Add support for park() and unpark() for Tyr.
    - Do not check for parked (revoked) in DropWorker, so that a
      park()ed JQ can continue to drop. Is safe thx to drop order.
    - Use our own workqueues, with MEM_RECLAIM flag set for the submit
      workqueue.
    - Rename SubmitWorker consistently to RunWorker. Now, submit always
      means job.submit(), and run always means run_job().
    - Add max_capacity, so you can never submit jobs that are too
      expensive.
    - Dependency fences:
        - Do not kill the JQ anymore if dependencies got signaled with
	  an error. Just run these jobs anyways, like drm_sched. (Boris)
	- Thus, remove the kill() callback.
	- In a future extension, we can pass the error codes through a
	  suitable data structure to the driver in run_job().
	- Why was this done? To be discussed in detail, but implementing
	  it like this allows us for centralizing dep error handling in
	  run_job(), *if* drivers should care. As far as can be seen in
	  the DRM drivers, they don't.
	  And if they do we would have to come to a common position
	  about fences' errors' meaning.
	  So the proposal is to upstream it like this for now to unblock
	  Tyr. Dependency error checking can then be added once our
	  discussions reached a common ground.
  - Fix CLIPPY warnings.
  - Update the docu to reflect the points above.
  - Update the doctest examples accordingly.

Changes since RFCv7:
  - Write a bunch of documentation, mostly about the kill() backend_ops.
  - Add creations of own work_queues (requires some work with the life
    times still; last relevant TODO AFAICS).

[1] https://lore.kernel.org/dri-devel/20261120111615.2940647-2-phasta@kernel.org/


Depends on the workqueue series:
https://lore.kernel.org/rust-for-linux/20261020-rust-workqueue-v3-0-ea7c74d02068@google.com/

Besides based on drm-rust-next

Daniel tested an earlier RFC (v6 I think) on Tyr and reports that it ran
well. In v2 I want to have our own workqueues ready, perhaps after the
workqueue has gone upstream.

But I thought it's time to present this as v1 since we settled on the
design, it's mostly working already and we can now begin diving out the
remaining problems.

So please review :)

Thx again to everyone who helped with moving this forward.

Last RFC:
https://lore.kernel.org/dri-devel/20261103153138.1087330-2-phasta@kernel.org/

Repo:
https://gitlab.freedesktop.org/pstanner/linux-drm-work/-/tree/jobqueue-jobqueue-v1-2?ref_type=heads


PS:
Note that this version now obtains a fence->error under lock,
because I strongly suspect that this pattern

if (dma_fence_is_signaled(f))
  pr_info("err: %i\n", f->error);

is UB since there is no memory ordering between the reads (which would
proof that fences' locks are not "just for the cb_list", as was sometimes
suggested). My discussions regarding fixing that in C can be found here:

https://lore.kernel.org/dri-devel/20261020100034.759183-2-phasta@kernel.org/
https://lore.kernel.org/dri-devel/2db0f1b4-6628-465e-928e-d779b89f59dc@amd.com/

Philipp Stanner (10):
  rust: rcu: Add get_state_synchronize_rcu()
  rust: rcu: Add cond_synchronize_rcu()
  rust: DmaFence: Implement Deref for FenceContext
  rust: DmaFence: Add ID accessor for FenceContext
  rust: DmaFence: Don't drop on signal
  rust: DmaFence: Replace call_rcu() with cond_synchronize_rcu()
  rust: DmaFence: Replace is_signaled() with status()
  rust: DmaFence: Pass result in callbacks
  rust: drm: Add JobQueue
  MAINTAINERS: Add drm::JobQueue to drm_sched's entry

 MAINTAINERS                      |   1 +
 rust/helpers/rcu.c               |   5 +
 rust/kernel/dma_buf/dma_fence.rs | 261 +++++-----
 rust/kernel/dma_buf/mod.rs       |   3 +-
 rust/kernel/drm/job_queue.rs     | 863 +++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs           |   4 +
 rust/kernel/sync/rcu.rs          |  23 +
 7 files changed, 1038 insertions(+), 122 deletions(-)
 create mode 100644 rust/kernel/drm/job_queue.rs


base-commit: 4325f4aad9727a6e8e7f10c5d2ebf490470cf938
prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
prerequisite-patch-id: e4ebcb108207c2d06130382c59c12ffe09a7a6db
prerequisite-patch-id: e19d2e11fc6c6fc121d65c8502bfa557e1dfc5ec
prerequisite-patch-id: 47301119dc7bc6fdc83256002e92c781a872b142
-- 
2.56.0

