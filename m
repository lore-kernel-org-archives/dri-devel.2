Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC2606A886
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKuNDMp+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17420112489;
	Fri, 13 Nov 2026 13:15:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560B2112489
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F5EA60218;
 Fri, 13 Nov 2026 13:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138DA1F000C5;
 Fri, 13 Nov 2026 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794575733;
 bh=lb8KR+Nue1lRmIPk4zybGM2Qc+EufpikbeiwCexgqXs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AKuNDMp+hoTs+Eiy4jxzWBpglJSUSwWwJHNmKnhenuVVNisDAAdcHb2eiSdq7JQ1/
 2jO90D0sozGz1sUfhj514JQn8yssa8ZnfKQtVCVaqCbwq2nc9ikJj59TPx6EFykKyr
 zl/eosmFJqy7cpPgAER7rtpU0SVPNOoeZF5mZ92TmDlq5+LYmUACea8gfLIb3m4m0s
 FlMyGMX+/Uh4ez/FlsIwgG5PnwRB+/CKChey3NB7Ywwiq8SJO9gJzh6T86d+9ibQ1E
 GbsqMpzy9esQPbU5tvySIKC6L1ZjX5v/gJS1So4U8ky2Hw3Gn2zMpl1YQoxUNvnVGK
 gKVPvOq6yAFyQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 13 Nov 2026 14:15:10 +0100
Subject: [PATCH v6 3/4] rust: io: copy `SysMem` with `atomic::memcpy`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-page-volatile-io-v6-3-5603e527c919@kernel.org>
References: <20261113-page-volatile-io-v6-0-5603e527c919@kernel.org>
In-Reply-To: <20261113-page-volatile-io-v6-0-5603e527c919@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=tOkGXAMnaKn9f2AQd5fFm5ug6coHQ3+z+mgOQZsfjhE=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq9w1hYQc5v35ColdrkhXNlvmYeEfxmpHwCKa1z
 nhS1Fa9r6eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavcNYQAKCRD6UCkIqsW9
 0CE7EACS+EcQMRLZA1sOXun+NWadZSjSvsM1ZLXGk7MkJczn4FHvjHpyJgK5TBVfJdJ6g997hLf
 fKsFKFkXakJ+D6D5ZhHDOC53dV4u8oKGGQJNf0oi+NqLUQXAjpsPlQeGkKw7zLr7CwQtYSvnkYU
 RKNp0QH8WGnOQBbrib3kl8LZtM47GVV/KI4jOuFG8QMyGfrtWukwnJ9EJeVNYkTPx2Urvlqk5HN
 z7nQu+PAQtJTc21VX/q0JCnufQWbBZm5RAWi8Um98smnLOBxp1AwEk5HFKXLt8UwJucoz3iNku0
 POt9IgoLK+cYqYjGAf4OWMKaC5wZIS49P7YOwHbYzqteqh2LVM63XbX6A9dP5eACnDGyUctefGd
 W+GgcNSSdU38z7dilGHWKXcNe67ihvFRtXbXygoo6J4Gbfww2Og4gYAl6jre3vzPkkJAmTDMH88
 qqUwRebkngZbZNyVTAk2zWRgekAnmOGkj3lpFL5/R6NIcaQPlSJrf78XZr4IWlmZdsSek5Ybhl8
 VWU2w1j/0HzSl6lFVRC1rrtQbJZnW4OUarBLdnZlH59lVNiGvHgbahAWwy16LyWTIuumlY5HYrC
 W4aS1ytYWMOPCOB8UCkM6wNY+js/uVdRpwm+pR3n3PwIU0aOa7rzQO3/uHQOwUnM0eGCyiHqGCe
 cGeVr3SgX/aIvqw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

The `IoCopyable` implementation for `SysMemBackend` calls
`bindings::memcpy()` directly. The comments say that this is done "for
volatile", but the requirements of the call are not stated anywhere.
The reason the call is sound is that the kernel's `memcpy()` is
byte-wise atomic, and that no plain access races with either side of
the copy.

Call `kernel::sync::atomic::memcpy()` instead, so that the requirements
are spelled out at the call site and checked against the invariants of
`SysMem` and the safety requirements of `IoCopyable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/io.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 00bab24d613c..76904c63eb0a 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -21,7 +21,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sync::atomic, //
 };
 
 #[cfg(CONFIG_HAS_IOMEM)]
@@ -1501,20 +1502,26 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 impl IoCopyable for SysMemBackend {
     #[inline]
     unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
-        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
         // SAFETY:
-        // - `view.ptr` is in CPU address space and valid for read.
-        // - `buffer` is valid for write for `view.size()` bytes which is equal to `view.ptr.len()`.
-        unsafe { bindings::memcpy(buffer.cast(), view.ptr.cast(), view.ptr.len()) };
+        // - Per type invariant, `view.ptr` is a valid kernel accessible memory region of
+        //   `view.ptr.len()` bytes, and no plain access races with this read.
+        // - Per the safety requirements of this function, `buffer` is valid for volatile writes for
+        //   `view.size()` bytes, which is equal to `view.ptr.len()`, so it is valid for atomic
+        //   writes.
+        // - Per the safety requirements of this function, `buffer` does not overlap with `view`.
+        unsafe { atomic::memcpy(view.ptr.cast(), buffer, view.ptr.len()) };
     }
 
     #[inline]
     unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
-        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
         // SAFETY:
-        // - `view.ptr` is in CPU address space and valid for write.
-        // - `buffer` is valid for read for `view.size()` bytes which is equal to `view.ptr.len()`.
-        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.ptr.len()) };
+        // - Per the safety requirements of this function, `buffer` is valid for volatile reads for
+        //   `view.size()` bytes, which is equal to `view.ptr.len()`, so it is valid for atomic
+        //   reads.
+        // - Per type invariant, `view.ptr` is a valid kernel accessible memory region of
+        //   `view.ptr.len()` bytes, and no plain access races with this write.
+        // - Per the safety requirements of this function, `buffer` does not overlap with `view`.
+        unsafe { atomic::memcpy(buffer, view.ptr.cast(), view.ptr.len()) };
     }
 
     #[inline]

-- 
2.54.0


