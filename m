Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCD1CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A8010EB34;
	Fri,  9 Oct 2026 19:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N7Tg/vKj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E032510EB34
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:14:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C3260AB9;
 Fri,  9 Oct 2026 19:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9071F00893;
 Fri,  9 Oct 2026 19:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573280;
 bh=IuD3niWZWj/SxlZGkAUiZZ1uFpmjslr0pgDLUkbJfbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N7Tg/vKjTrhKdXBZamwgFtDWtY/wab2gZ5qOpQTzuNRT72Nw8rFsgKILinYQ3506b
 iA+dpZxzVaeuKvSdH8TCYcx3jaowYpDfFssIPgiYL43f5uxbiG+uZ6GRHAtOcN53WQ
 watgzA7Ss57luXxP+mryCi54ClVhOLUT1jw8HDd62D19nxNEQDAuURO8qRA+wCEGnv
 OhAJkAIF3wNhY970rIwJ+SseI91XtfIRT09rAVOdQOJrAQ22d7Ylokh2r13tKeU17k
 mElUxRmhrIjPzxOoyVLDD0tq+1ZAcM6Gfj2UeYz7VDYczWlpBqL2um7u/KPsb28yH/
 D5CNss1VLWHAA==
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
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>, John.harrison@igalia.com,
 da.gomez@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v5 3/6] rust: DmaFence: Don't drop on signal
Date: Fri,  9 Oct 2026 21:11:21 +0200
Message-ID: <20261009191124.1022902-5-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009191124.1022902-2-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
MIME-Version: 1.0
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

The original design for DmaFence intended to comply as strictly as
possible with the "dma_fence contract", which, according to some, says
that a fence must only be signaled once. Thus, the implementation was
made so that a DriverFence drops on signal.

While extending JobQueue's capabilities, it was discovered that this
characteristic causes - unnecessary - trouble: fence-data must be
dropped in an RCU-deferred manner because the C backend demands that.
However, fences are often signaled in atomic context (e.g., interrupt
handler) where you don't want to drop, but signal as quickly as
possible.

Actually, there is no real hard reason to enforce that a fence can only
get signaled once, because the C backend is robust against multiple
signal attempts.

What is decisive is that a) all fences signal and b) they only drop no
earlier than 1 RCU grace period after signaling.

Don't drop a DriverFence on signal().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 0028124e6aa6..b67121c7abd4 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -806,7 +806,7 @@ pub fn as_fence(&self) -> &Fence {
     }
 
     /// Signal the fence. This will invoke all registered callbacks.
-    pub fn signal(self, res: Result) {
+    pub fn signal(&self, res: Result) {
         let fence = self.as_fence().lock();
 
         // SAFETY: `fence` is valid because `self` is valid. The lock must be
-- 
2.55.0

