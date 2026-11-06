Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B493606D818
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeDynIun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE60E112DE6;
	Fri,  6 Nov 2026 14:09:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03917112E01
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:09:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 197DB6020F;
 Fri,  6 Nov 2026 14:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884051F0089F;
 Fri,  6 Nov 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974162;
 bh=+l3jNbIDS76WPNvh/NK944sUo4wbpr4s9at1CgYGR6g=;
 h=From:To:Cc:Subject:Date;
 b=WeDynIunenyp7YlBM64P8U3/KYF0JPTr973XGHfE2NzH0frBK2n8pb+XsD1F0/euL
 meQ9bkWa3mWhIUnXMqfJu1iDyFgS7gfyHOANjx/AP+MzknIFIv4FIP5liLS4jmZaBY
 7RJpgWn7SZKCjxI39fU1kIQokvODS75dvDCyQtU5t8N2jsip/1wZd9owG5lNwtqRVc
 ZvmjiHLQHoiuVdQs2ww8KXJDqJ4PT/51uBXAMWFEV8qcemh50A5zSm8DhjYrQ+u5yZ
 2Pk+E1OiGo3xH9DrRXl5xFuZED716nN+JsCyUuM7bVriCNc38R567HkPjm6oRYXnGh
 +SHu+aFUatZgA==
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
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 0/8] rust: Add drm::JobQueue
Date: Fri,  6 Nov 2026 15:07:45 +0100
Message-ID: <20261106140752.520386-2-phasta@kernel.org>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes since RFCv7:
  - Write a bunch of documentation, mostly about the kill() backend_ops.
  - Add creations of own work_queues (requires some work with the life
    times still; last relevant TODO AFAICS).

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


Philipp Stanner (8):
  rust: DmaFence: Implement Deref for FenceContext
  rust: DmaFence: Add ID accessor for FenceContext
  rust: DmaFence: Don't drop on signal
  rust: DmaFence: Replace call_rcu() with synchronize_rcu()
  rust: DmaFence: Replace is_signaled() with status()
  rust: DmaFence: Pass result in callbacks
  rust: drm: Add JobQueue
  MAINTAINERS: Add drm::JobQueue to drm_sched's entry

 MAINTAINERS                      |   1 +
 rust/helpers/dma_fence.c         |   4 +-
 rust/kernel/dma_buf/dma_fence.rs | 234 ++++-----
 rust/kernel/dma_buf/mod.rs       |   3 +-
 rust/kernel/drm/job_queue.rs     | 873 +++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs           |   4 +
 6 files changed, 996 insertions(+), 123 deletions(-)
 create mode 100644 rust/kernel/drm/job_queue.rs


base-commit: 7a6bc132f1b51437063c9203e7221067b40a791e
prerequisite-patch-id: f5e24f7b3717f2ab0445b5395c7f12b554861d78
prerequisite-patch-id: e4ebcb108207c2d06130382c59c12ffe09a7a6db
prerequisite-patch-id: 8dc24064e858240a6bb5411a261a987a7eae3fad
prerequisite-patch-id: eefbd4a72ed6da0083e20811882738cc3b05604f
prerequisite-patch-id: ea89aac6f42582c91174068c1db4d171bd7a8920
-- 
2.56.0

