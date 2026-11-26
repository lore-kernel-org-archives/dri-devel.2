Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBED606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sgyqsby1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49F710E9E9;
	Thu, 26 Nov 2026 16:12:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D2510E3CA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:12:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E19FA43596;
 Thu, 26 Nov 2026 16:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A61F000C6;
 Thu, 26 Nov 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795709563;
 bh=DaEirMw/1djdkLL110qkB/wjVzmaSRnYjY3X7hDvR40=;
 h=From:To:Cc:Subject:Date;
 b=Sgyqsby1rJTlvbxx1/BcyqfrxcTOaFYybGvJ1oEbx/1j+YRqHQaXhASvfxtF4Dihq
 jj8/xkDY3rzyqnICs3QcWrY1McDRzcz1YNlHx+WLAF8eVgPhz/HBSOFyISdyPITtKc
 R2L8W2N9tNwzrgeslg7pDV60iKy1nAL+eEpe9ANpYu+wL1BFDBVHpu/Iu/st7v5iJ7
 bRWUgn6XuYOd9Fmi6Z7WZVIhZkgYxHCGYeR9etTX/ijTMdn3Ium9msrJT5n8Mm14zS
 g3nAIvaMtVRJiphVcuj4opC0uHP3En4SMfbSLkFvaoezapvhgSV5TyAAvylcOV9VsG
 Zl/p7XT9W435w==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v3] rust: DmaFence: Remove warning about unsignaled drop
Date: Thu, 26 Nov 2026 17:11:47 +0100
Message-ID: <20261126161144.2337064-4-phasta@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DriverFence::drop() contains a pr_err!() for when the fence drops
unsignaled. This warning gets in the way of canonical teardown in Rust:
when you drop a lock, it unlocks itself, when you drop a KBox, it frees
itself etc. Congruently, users should be able to tear down fences they
don't care about anymore with ECANCELED, which is already the default
error code.

Remove the warning.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v3:
  - Fix Typo. (Daniel)

Changes in v2:
  - Also update docu accordingly.
---
 rust/kernel/dma_buf/dma_fence.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index a1d851656562..01a7ae807273 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -631,8 +631,9 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 /// It is crucial that a [`DriverFence`] always correctly represents the state
 /// of the associated job on the hardware. Especially, it is strictly necessary
 /// that the owner ensures that all [`DriverFence`]s eventually get signaled.
-/// As a last resort, a [`DriverFence`] will signal itself if it drops
-/// unsignaled and print a warning.
+///
+/// A [`DriverFence`] that drops unsignaled will signal itself with the error
+/// code ECANCELED.
 ///
 /// This design intends to implement the [`bindings::dma_fence_ops`] in such a
 /// way that the driver-data necessary to implement the callback's functionality
@@ -942,7 +943,6 @@ fn drop(&mut self) {
         // SAFETY: `guard` is valid until the `call_rcu()` below.
         let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(guard.as_raw()) };
         if !signaled {
-            pr_err!("DriverFence drops unsignaled. Danger of memory corruption!\n");
             // SAFETY: `guard` is valid until the `call_rcu()` below. The fence
             // must not have been signaled yet, which we check directly above.
             unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANCELED.to_errno()) };
-- 
2.56.0

