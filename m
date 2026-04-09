Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C7910FC463
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A11310E720;
	Thu,  9 Apr 2026 00:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="elb0gje0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0001410E722
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775693828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v84/L+49ZA1uAG2yI2PO3Lh2LKOCLvufu7qPSjG196s=;
 b=elb0gje0hPFKY2wM4UkkPlLSDReXxe3GvimL0WlEPa7/DbfTB5KDuYH2zWCysYYNWrEjcD
 I2rm7X65qS1b5hhsMu0vBXTdzh9PI8Le2z/1wK80VFRNrHyMBKS39JZL/z+C8Nv2pUztds
 NwongLxlvk+5cxqHSqcXj8Ge8SqroNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-KkHRVFXjPYO75nkp0m6NmA-1; Wed,
 08 Apr 2026 20:16:17 -0400
X-MC-Unique: KkHRVFXjPYO75nkp0m6NmA-1
X-Mimecast-MFC-AGG-ID: KkHRVFXjPYO75nkp0m6NmA_1775693773
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FA8219560B0; Thu,  9 Apr 2026 00:16:13 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AC653000203; Thu,  9 Apr 2026 00:16:07 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, Gary Guo <gary@garyguo.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Matthew Maurer <mmaurer@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, christian.koenig@amd.com,
 Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, linux-media@vger.kernel.org,
 Shankari Anand <shankari.ak0208@gmail.com>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linaro-mm-sig@lists.linaro.org,
 Asahi Lina <lina+kernel@asahilina.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@vger.kernel.org
Subject: [PATCH v10 1/5] rust: drm: gem: s/device::Device/Device/ for shmem.rs
Date: Wed,  8 Apr 2026 20:12:47 -0400
Message-ID: <20260409001559.622026-2-lyude@redhat.com>
In-Reply-To: <20260409001559.622026-1-lyude@redhat.com>
References: <20260409001559.622026-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YTFN1I7kC2biY6uC8L0xgFPvDOCesAwlJ4Ax01dREGE_1775693773
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

We're about to start explicitly mentioning kernel devices as well in this
file, so this makes it easier to differentiate the two by allowing us to
import `device` as `kernel::device`.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/shmem.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index d025fb0351954..c643f18b20838 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -12,10 +12,10 @@
 use crate::{
     container_of,
     drm::{
-        device,
         driver,
         gem,
         private::Sealed, //
+        Device,
     },
     error::to_result,
     prelude::*,
@@ -108,7 +108,7 @@ fn as_raw_shmem(&self) -> *mut bindings::drm_gem_shmem_object {
     ///
     /// Additional config options can be specified using `config`.
     pub fn new(
-        dev: &device::Device<T::Driver>,
+        dev: &Device<T::Driver>,
         size: usize,
         config: ObjectConfig<'_, T>,
         args: T::Args,
@@ -150,9 +150,9 @@ pub fn new(
     }
 
     /// Returns the `Device` that owns this GEM object.
-    pub fn dev(&self) -> &device::Device<T::Driver> {
+    pub fn dev(&self) -> &Device<T::Driver> {
         // SAFETY: `dev` will have been initialized in `Self::new()` by `drm_gem_shmem_init()`.
-        unsafe { device::Device::from_raw((*self.as_raw()).dev) }
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
     }
 
     extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
-- 
2.53.0

