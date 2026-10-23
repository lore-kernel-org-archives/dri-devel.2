Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3aSYYbE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A41D10E0DF;
	Fri, 23 Oct 2026 17:58:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3253910E0DF
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 17:58:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3B1B43DA2;
 Fri, 23 Oct 2026 17:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12221F01829;
 Fri, 23 Oct 2026 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792778322;
 bh=rbckzzyzIkFqZpi1BADHlyG5EWbCbTqZ1QrQLEtCk1s=;
 h=From:To:Cc:Subject:Date;
 b=l3aSYYbEdOUtAjoqARzhPp6sXqmfcJ897g7NKkVz5enpyxTriBHdNBONSCRMfjRiz
 sX+koQMwZgR2V+H0XVMvrn5Sj6TsurF9Y0aQSEivs5+WOLpos3LMKmknzoIN1ZvuZ9
 09l+I4NUI49ccg3wJIjUs3v3CvcP+LFPhhR5o2PijNOZEx6gGWgqavIWjWdUjuGcrG
 AA5uu3s0zGdp0G3mxGTrppkoX0mvV8tLtOEPDsnxvpqD7qfFyrL9syqBKXS26g0hPP
 Mw5Vp8zMwIoWVcNbL6J3bc/mDKOChwO22Ich++hfojQD1NQOH8jD7fyoBoPyOGdidx
 +85FJYpdUsldQ==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: DmaFence: Initialize for 64-bit seqnos
Date: Fri, 23 Oct 2026 19:57:51 +0200
Message-ID: <20261023175750.2979015-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When dma_buf::DriverFence et al. were added, it was completely
overlooked that dma_fence has to be instructed to use the desired 64-bit
sequence numbers with a special init function, dma_fence_init64().

Replace the bindings call to dma_fence_init() with one to
dma_fence_init64().

Fixes: 3282d5916019 ("rust: Add dma_fence abstractions")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index a1d851656562..de0bbaf18c7f 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -744,7 +744,7 @@ pub fn new_fence(self) -> DriverFence<'a, T> {
         // SAFETY: `fence_ptr` has been created directly above. It will live
         // at least as long as `Self`. The same applies to `&Self::OPS`.
         unsafe {
-            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
+            bindings::dma_fence_init64(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
         };
 
         self.data.fctx.nr_of_unsignaled_fences.fetch_add(1, Relaxed);
-- 
2.56.0

