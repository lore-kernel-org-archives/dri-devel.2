Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0C606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emol58vL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E21910E147;
	Thu,  5 Nov 2026 15:43:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396C210E31B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:43:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 045654142E;
 Thu,  5 Nov 2026 15:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718F21F000C1;
 Thu,  5 Nov 2026 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793893400;
 bh=ZZ30tj2pRrX2TSx9hx+y3zY66lWWQvzA4rqP8T/5bwo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=emol58vLxmuU05NVTBa+dw/u7YLWB3lUJnnwNeMsIC9DjbmhlYrNMp9faLAdwecS6
 2FK61Wc2T0l+Fyi/AAoBGWVzNDHau/78khAym1VqrFdkeY1BSrZtlXeS4okprKzeQc
 n7Tl6bafE7Ex6sZOa1eZtJvrg2qylLnfQbmdqCUGeA2sIrd8QFc3bmLDZAYI8/2eDk
 pRukuRgjh52ViQle+A0H1qps5vpJkhNaWfEh6n7kDoEZ2dvoiY5AtvGf7VnJ13pNGD
 eSw3Zx+THe/ON+cyRQ3U40w6byd2gZfgSziBl0hcHGw/XurYk9Swh9BxNcFyayxH1R
 87STp64t5qhjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 05 Nov 2026 16:42:44 +0100
Subject: [PATCH v3 1/2] rust: impl_flags: add conversion functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-impl-flags-additions-v3-1-5b17c01c2b15@kernel.org>
References: <20261105-impl-flags-additions-v3-0-5b17c01c2b15@kernel.org>
In-Reply-To: <20261105-impl-flags-additions-v3-0-5b17c01c2b15@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3204; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=9iyGL5fNcH/TV1QXaAh95ETqf6dnZuNL8Wwvg0cVRW4=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq7KP/yZD3vXgqIFKq7I/KVPAln5q+4fSmNg7gS
 XyXBeV+1vSJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCauyj/wAKCRD6UCkIqsW9
 0JPoD/99yyIMZ6YfoJx4PjrnuIdp3MXQY/wqWsADpniOGclfkw/Id5NakOn6s5HF3UVh4TLKlnH
 0NfF70PR46pVfbZu+I6xL6MJWYqFNhX0svjtY6Ck65UuV5WNy8Bq3510kbhxj4L6bQKQ9OW+N1t
 1sEeuMnkXPbu3EQCkJrSCACv0aQeEoXzwub1lS0nmB7tEwzO2vrsT13mSeZbyFE763UiU1w+KMn
 z/v2tg1dqcd2TRb8ETmtVjCckzwASGLZKwFFcZatzllc9aOhwndklDe0ajDgJLxVVGn3f9Ha4sd
 DWrKO+GhBu/CGXDko2VTN+kysmsw+31u5LgwuxQ1nYHM4kdsaZ5mgV4wUnRxygkmzB8qqUKRNnb
 9nJva9eHeDo4T/gK/1Zev6sFNM4+iRWSFM2lkfvNlAW9spV9c7aYBE+PJ0mD7VGkf/9uo8hCZ/y
 WxnvFyWlNagowx2If/+fQ+4MMaHRpSDRdsbQdRLQFMVNYcZ+hEorgyax8Onch5Df2P4f5pSuOrH
 HLjcMUy0kINXBvbCd9Lqow91QcYat7+DijI/lFXMB6xg8RHfdEK+CaRTFmxtBDMFGEPBazYjLQK
 HIuikOkGHtHvUBgkR0eTANFO/uVz2ugkfcg+SPJ7kFjyJoAHVfNXqpvRWTH5tHabpO3NzUWCpJO
 DgfPuwBhIzIAZ4Q==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add two conversion functions to the `impl_flags!` macro:

 - A `From<_>` implementation to convert from the flag value enum to
   underlying type.

 - A `TryFrom<_>` implementation to convert from the underlying
   representation to flag container type.

Drop the hand-written `TryFrom<u32> for VmMapFlags` in tyr, which now
conflicts with the implementation generated by `impl_flags!`. The two are
equivalent.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 drivers/gpu/drm/tyr/vm.rs | 13 -------------
 rust/kernel/impl_flags.rs | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b1253..0d6e841a31ed 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -141,19 +141,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl TryFrom<u32> for VmMapFlags {
-    type Error = Error;
-
-    fn try_from(value: u32) -> Result<Self, Self::Error> {
-        let valid = VmFlag::Readonly as u32 | VmFlag::Noexec as u32 | VmFlag::Uncached as u32;
-
-        if value & !valid != 0 {
-            return Err(EINVAL);
-        }
-        Ok(Self(value))
-    }
-}
-
 /// Arguments for a virtual memory map operation.
 struct VmMapArgs<'drm> {
     /// Access permissions and caching behavior for the mapping.
diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
index 6051487f6e28..052759b8038d 100644
--- a/rust/kernel/impl_flags.rs
+++ b/rust/kernel/impl_flags.rs
@@ -73,6 +73,17 @@
 /// // useful for passing the value to a C API.
 /// let raw: u32 = read_only.bits();
 /// assert_eq!(raw, Permission::Read as u32);
+///
+/// // Convert a single flag value to its underlying integer representation.
+/// let raw_read: u32 = Permission::Read.into();
+/// assert_eq!(raw_read, Permission::Read as u32);
+///
+/// // Construct a `Permissions` value from a raw integer. `TryFrom` rejects
+/// // integers whose set bits do not all correspond to declared flags.
+/// let parsed = Permissions::try_from(raw_read | Permission::Write as u32).unwrap();
+/// assert!(parsed.contains(Permission::Read));
+/// assert!(parsed.contains(Permission::Write));
+/// assert!(Permissions::try_from(1 << 7).is_err());
 /// ```
 #[macro_export]
 macro_rules! impl_flags {
@@ -115,6 +126,26 @@ fn from(value: $flags) -> Self {
             }
         }
 
+        impl ::core::convert::From<$flag> for $ty {
+            #[inline]
+            fn from(value: $flag) -> Self {
+                value as Self
+            }
+        }
+
+        impl ::core::convert::TryFrom<$ty> for $flags {
+            type Error = ::kernel::error::Error;
+
+            #[inline]
+            fn try_from(value: $ty) -> Result<Self, Self::Error> {
+                if value & !Self::all_bits() != 0 {
+                    return Err(::kernel::error::code::EINVAL);
+                }
+
+                Ok(Self(value))
+            }
+        }
+
         impl ::core::ops::BitOr for $flags {
             type Output = Self;
             #[inline]

-- 
2.54.0


