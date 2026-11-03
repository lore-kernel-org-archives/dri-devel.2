Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BC606D80B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzVPe8iO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EA010F68F;
	Tue,  3 Nov 2026 15:32:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F9610F693
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:32:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8ADDB43B72;
 Tue,  3 Nov 2026 15:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDA1F00A16;
 Tue,  3 Nov 2026 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719957;
 bh=CTC0NGl+gn6K/Ev7/WRzoi5Z9SyGzqqJK0cSV/zyFzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VzVPe8iOs70piLZ1J3/guI6ECrDAgUg7jhdGOMfNTMoiHm/z+XpybtOdyVyVgUU4p
 Q2Zkx7Hp2guHXsp9OnuNshn+gEYLNX2S8zXY3OXCiJyLaaH/GX9SHJPrDZbko3QCCf
 rLMAbkrqUlSI0M1jP5B1vvBv66QACpJXAhi06WeyBlaxghoAJjXcOmjGsSCOhy58VR
 oqSw3lteA24pk1SiqC9BYuW/x3w9GRUJVvox1RQHw7ANFw/s5L3FFNumZqfezrKCw+
 stM/65rcsM0/8rmGW8DZYL78zr8pZNbWY3B7MMErMbKTR4zC7GKw72kFYXaM8BZ2O/
 IEnar3lNxgy9w==
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
Subject: [RFC PATCH v7 1/8] rust: DmaFence: Implement Deref for FenceContext
Date: Tue,  3 Nov 2026 16:31:31 +0100
Message-ID: <20261103153138.1087330-3-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103153138.1087330-2-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A FenceContext carries data, which the user should be able to access.

Implement Deref for FenceContext.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index a1d851656562..5300448882e7 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -86,6 +86,15 @@ pub struct FenceContext<T: FenceContextOps + Send + Sync> {
     data: T,
 }
 
+impl<T: Send + Sync + FenceContextOps> Deref for FenceContext<T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.data
+    }
+}
+
 impl<'a, T: Send + Sync + FenceContextOps> FenceContext<T> {
     // This can later be extended as a vtable in case other parties need support
     // for the more "exotic" callbacks.
-- 
2.56.0

