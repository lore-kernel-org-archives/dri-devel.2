Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81AACD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096A311299C;
	Thu,  4 Jun 2026 19:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="R3/vD+hi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E87E1129A2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780601339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7Z/C3WKzX9d11zFSyCLO1QOj5Cg/fxzu0wnbss0mqw=;
 b=R3/vD+hi/F0LtzfxfGDBX871BtuQUT8/LOV8VgF+PEXal3xP/qNvYNSd32Fq91wvS2UeRS
 GZ8ZkdgBPWHwzGZiowo5yGdm187Myt/4peVuWyO1gZNX1LZbM0xs/oLg2WaB8XnbeGka20
 H7mPYtZ+5lQdRJ83HhBdq/8uEEJ1DWY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-zgX0bRHXN9yWCnDpzcJjUQ-1; Thu,
 04 Jun 2026 15:28:54 -0400
X-MC-Unique: zgX0bRHXN9yWCnDpzcJjUQ-1
X-Mimecast-MFC-AGG-ID: zgX0bRHXN9yWCnDpzcJjUQ_1780601331
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033151800347; Thu,  4 Jun 2026 19:28:51 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.65.199])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 562BF763; Thu,  4 Jun 2026 19:28:47 +0000 (UTC)
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
Subject: [PATCH v18 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
Date: Thu,  4 Jun 2026 15:24:28 -0400
Message-ID: <20260604192740.659240-2-lyude@redhat.com>
In-Reply-To: <20260604192740.659240-1-lyude@redhat.com>
References: <20260604192740.659240-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: DJetJy7UBDg4w5ZtL_4daMqFRs1yd6F0cufWQJNG1bw_1780601331
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

Just a temporary holdover to make locking/unlocking the dma_resv lock much
easier.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Co-authored-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

---
V17:
* Fix format of commit message title

 rust/kernel/drm/gem/shmem.rs | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 084b798ce795b..650c34dd8b7a4 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -30,7 +30,10 @@
         Deref,
         DerefMut, //
     },
-    ptr::NonNull, //
+    ptr::{
+        self,
+        NonNull, //
+    },
 };
 use gem::{
     BaseObjectPrivate,
@@ -244,3 +247,29 @@ impl<T: DriverObject, C: DeviceContext> driver::AllocImpl for Object<T, C> {
         dumb_map_offset: None,
     };
 }
+
+/// Private helper-type for holding the `dma_resv` object for a GEM shmem object.
+///
+/// When this is dropped, the `dma_resv` lock is dropped as well.
+///
+// TODO: This should be replace with a WwMutex equivalent once we have such bindings in the kernel.
+struct DmaResvGuard<'a, T: DriverObject, C: DeviceContext = Registered>(&'a Object<T, C>);
+
+impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C> {
+    #[inline(always)]
+    #[expect(unused)]
+    fn new(obj: &'a Object<T, C>) -> Self {
+        // SAFETY: This lock is initialized throughout the lifetime of `object`.
+        unsafe { bindings::dma_resv_lock(obj.raw_dma_resv(), ptr::null_mut()) };
+
+        Self(obj)
+    }
+}
+
+impl<'a, T: DriverObject, C: DeviceContext> Drop for DmaResvGuard<'a, T, C> {
+    #[inline(always)]
+    fn drop(&mut self) {
+        // SAFETY: We are releasing the lock grabbed during the creation of this object.
+        unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
+    }
+}
-- 
2.54.0

