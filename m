Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DECD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56ED410F441;
	Tue,  2 Jun 2026 17:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="U0Z6oRMK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD0C10F43F
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ji3R873SgQHyxfzMQgkhE7LmK1MPE9r7ND0eG5Mf4OM=;
 b=U0Z6oRMKHZ1Rp3DNPpuOBzOllSe8JSxL+MciuLZgnkDOUGY+K+EjY6IlFUJS3CUUIkQa8G
 pEqgasmQAsvz3EywRmwTkxvnBUOjzdfBKSMFFdWgbZeI3JxW8FCxnk0SNYBBZ7uFIOF0KZ
 pehHYl0G+9I7BZu4iOapecGaweZ8Y5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-hcXIVyfUOHO65GIIA9MZ-Q-1; Tue,
 02 Jun 2026 13:28:31 -0400
X-MC-Unique: hcXIVyfUOHO65GIIA9MZ-Q-1
X-Mimecast-MFC-AGG-ID: hcXIVyfUOHO65GIIA9MZ-Q_1780421308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0E1D18005B5; Tue,  2 Jun 2026 17:28:27 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.81.216])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90A7219560A7; Tue,  2 Jun 2026 17:28:24 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Danilo Krummrich <dakr@kernel.org>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v16 3/6] rust: sync: Add SetOnce::reset()
Date: Tue,  2 Jun 2026 13:25:02 -0400
Message-ID: <20260602172807.1051806-4-lyude@redhat.com>
In-Reply-To: <20260602172807.1051806-1-lyude@redhat.com>
References: <20260602172807.1051806-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: UNQfFvO6rMQEvkz7fgtwQuOh3GOYVpMg76-rx6lzpl8_1780421308
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This function simply drops the contents of the SetOnce, given a mutable
reference - since that proves we have exclusive access to the SetOnce.
Additionally, update the invariants for SetOnce to make it clear as to why
this is safe.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/set_once.rs | 60 +++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index 139cef05e935f..d6e4fc2695673 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -15,7 +15,7 @@
 ///
 /// # Invariants
 ///
-/// - `init` may only increase in value.
+/// - `init` may only increase in value, unless modified through a mutable reference.
 /// - `init` may only assume values in the range `0..=2`.
 /// - `init == 0` if and only if `value` is uninitialized.
 /// - `init == 1` if and only if there is exactly one thread with exclusive
@@ -110,17 +110,61 @@ pub fn copy(&self) -> Option<T>
     {
         self.as_ref().copied()
     }
+
+    /// # Safety
+    ///
+    /// If this function returns `true`, `self` must be freed or `init` must be reset to `0`.
+    unsafe fn drop_val(&mut self) -> bool {
+        if *self.init.get_mut() != 2 {
+            return false;
+        }
+
+        let value = self.value.get_mut();
+        // SAFETY: Via our type invariants, `init` == 2 means `value` is initialized.
+        unsafe { value.assume_init_drop() };
+
+        true
+    }
+
+    /// Unset the [`SetOnce`].
+    ///
+    /// After this function is called, the [`SetOnce`] is empty and uninitialized. This function is
+    /// mainly intended for usage in destructors.
+    ///
+    /// Returns `true` if `self` was previously initialized.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// # use kernel::sync::SetOnce;
+    /// let mut value = SetOnce::new();
+    /// assert_eq!(value.populate(67), true);
+    ///
+    /// assert_eq!(value.reset(), true);
+    /// assert!(value.as_ref().is_none());
+    /// assert_eq!(value.reset(), false);
+    ///
+    /// assert_eq!(value.populate(69), true);
+    /// ```
+    pub fn reset(&mut self) -> bool {
+        // SAFETY: We write `0` to init below if this returns true.
+        let dropped = unsafe { self.drop_val() };
+        if dropped {
+            // INVARIANT:
+            // - We set `init` back to 0 through a mutable reference.
+            // - We dropped `value` above.
+            *self.init.get_mut() = 0;
+        }
+
+        dropped
+    }
 }
 
 impl<T> Drop for SetOnce<T> {
+    #[inline(always)]
     fn drop(&mut self) {
-        if *self.init.get_mut() == 2 {
-            let value = self.value.get_mut();
-            // SAFETY: By the type invariants of `Self`, `self.init == 2` means that `self.value`
-            // contains a valid value. We have exclusive access, as we hold a `mut` reference to
-            // `self`.
-            unsafe { value.assume_init_drop() };
-        }
+        // SAFETY: We are dropping this value.
+        unsafe { self.drop_val() };
     }
 }
 
-- 
2.54.0

