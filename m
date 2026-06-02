Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283ACCD6E69
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4568B10F44C;
	Tue,  2 Jun 2026 17:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bXgZ04tb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DBF10F43D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n2gylv3DYJqAPYFDxLeYUmhNrr6JQO+YmoPANh0AXF0=;
 b=bXgZ04tb2xlENDnfM78KsK7Lii7V1KByMYxKY6tJ3YdQiXBbiNyCd2ZBvWOO8hfOCGvUqx
 Z9Qn/MyoO7zI9qA8PTleU3hki2zMK3Yqno+XQKk/Os/vn14ogKQwgKoePlm0DaSFHfo6EK
 plxUJSAHilbowWMbQfa5E+U5nTEPPPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-MVVaJtVhNfCOyC0yL5awjQ-1; Tue,
 02 Jun 2026 13:28:34 -0400
X-MC-Unique: MVVaJtVhNfCOyC0yL5awjQ-1
X-Mimecast-MFC-AGG-ID: MVVaJtVhNfCOyC0yL5awjQ_1780421311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76E7519560B5; Tue,  2 Jun 2026 17:28:31 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.81.216])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D2DE19560B0; Tue,  2 Jun 2026 17:28:28 +0000 (UTC)
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
Subject: [PATCH v16 4/6] rust: gem: shmem: Fix Default implementation for
 ObjectConfig
Date: Tue,  2 Jun 2026 13:25:03 -0400
Message-ID: <20260602172807.1051806-5-lyude@redhat.com>
In-Reply-To: <20260602172807.1051806-1-lyude@redhat.com>
References: <20260602172807.1051806-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: EA33EbKaENXLLe2Z70Aaswme5um3iktARRiZvI-c2qA_1780421311
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

I completely forgot when coming up with this type that #[derive(Default)]
only works if all generics mentioned in the type implement Default (and T
usually doesn't). This being said: We don't use `T` for anything besides
using it for a reference type, so whether or not it implements `Default`
shouldn't actually need to matter.

So, fix this by just manually implementing Default instead of deriving it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/shmem.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 843869056b1d7..d8bda8c8e2fb2 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -50,7 +50,6 @@
 ///
 /// This is used with [`Object::new()`] to control various properties that can only be set when
 /// initially creating a shmem-backed GEM object.
-#[derive(Default)]
 pub struct ObjectConfig<'a, T: DriverObject> {
     /// Whether to set the write-combine map flag.
     pub map_wc: bool,
@@ -61,6 +60,16 @@ pub struct ObjectConfig<'a, T: DriverObject> {
     pub parent_resv_obj: Option<&'a Object<T>>,
 }
 
+impl<'a, T: DriverObject> Default for ObjectConfig<'a, T> {
+    #[inline(always)]
+    fn default() -> Self {
+        Self {
+            map_wc: false,
+            parent_resv_obj: None,
+        }
+    }
+}
+
 /// A shmem-backed GEM object.
 ///
 /// # Invariants
-- 
2.54.0

