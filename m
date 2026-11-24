Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25695606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N85LW0uK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 884DF10F546;
	Tue, 24 Nov 2026 12:30:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BD410F546
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C4F9441AD;
 Tue, 24 Nov 2026 12:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF6B1F00A3D;
 Tue, 24 Nov 2026 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523450;
 bh=kFO2o9d1HuvRpw65wW5KNZGSLKA1liz6URUAihp77/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N85LW0uK3x4lsIph7va+G/rg6OWdGmC6hG5Js1yZ9iDQ4ZmH7M9jXp3wQnNXLE1Ep
 KZF4XqeohfmqS0ePkxm/FpFAsKDwWTmPUfy2DUkTMhhFd1RJcCoa1L9nxV8pYY9Ogr
 UCwzDI5r0HihmlUkx9+Xr+2Oy4HLI0DjpvnTqyUAxEJT75LSFU/a7jVvf0qqUqeYfm
 cB17e6zKx5WfyA9bErzp7Y5iL5UQ0+z4gcJS/OludTcAP4/+LNjyq+f4ct3kbKzshs
 fBiYSjJ17OsDzVZQmcznjy4FEmfxEVMiKF6yarEApqv064d0jJB1BCRnTKJjEAj+kc
 1gljHQBuBh08g==
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
Subject: [PATCH v2 04/10] rust: DmaFence: Add ID accessor for FenceContext
Date: Tue, 24 Nov 2026 13:29:46 +0100
Message-ID: <20261124122951.878199-6-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124122951.878199-2-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
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

A FenceContext has a fence context number, which can serve as an ID
field. This number can be useful for owners of multiple contexts to
identify them, store them in an XArray etc.

Add an accessor for fctx.nr.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 5300448882e7..897308f60dd3 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -135,6 +135,12 @@ pub fn new<E>(
         })
     }
 
+    /// Obtain the FenceContext's ID number.
+    #[inline]
+    pub fn id(&self) -> u64 {
+        self.nr
+    }
+
     fn next_seqno(&self) -> u64 {
         self.seqno.fetch_add(1, Relaxed)
     }
-- 
2.56.0

