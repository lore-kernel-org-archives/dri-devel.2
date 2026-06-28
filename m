Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1FBC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB58910E5E7;
	Sun, 28 Jun 2026 11:43:37 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91DF410E5AC
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 09:29:19 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2c9d87b1f9eso2121845ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 02:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782638959; x=1783243759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msiQeoD9bE2+9m/GBRmkavuhnEjua8HjkhejH4gaLD4=;
 b=cR5494CKYH/CWztuP1hWX1P7i0zENrD10pcVBAQo0Kj64fau6Rwa2ITZYMsj1U1vvu
 ALjyp3cLkkW4q/LplLTDIIkgQkO01TYzt3dxLLfEEnvQLEKRzxE9rdyR7cmCIUrCPcbQ
 yaBtzTO4yhCnjCVGijA0yvKgQhDhO4TVA2/8SVHY8uV5kEDQnbYnd0jzlptuQbnRa4iD
 UaXwcNP2iYHnrKgfOYOQdGmPBs1HaheDU0gqEr8DhglP2MQhNSLoGmL+DIKGzKqCMYl/
 atvCMs+lOVpjZ7Qqdn0CMLA19JbTIov1p+Va9jBJJGqJP67b+C/ySCS2TSLnrmvPdSKa
 9Esw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzAZo9KnV8/qQMjjSXpnR0lhcvt2pLYqo4RtNzS65k0sfUff7i2xk58VT+aBYxyLEvYTqjvwGndqE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyh7FkHevquSSXknqDDYXCG6Odw0cdnIEUzihq5myE22D+F7a5o
 sJFaKB1wQYx9m2i3UYjskPhtnN0yZccNIXv4qvTNLFEu+7YwCxJBs6rd
X-Gm-Gg: AfdE7ckSh/FkJzlUntVahOaoMFVUC+3+2SaZMHzE5VPNeXjHG6vKjLPGK7kzzMK4PmA
 x3xVKygpSFC0MIHQ111pHsQXiLx6ZufJSmCAgCia4zh26YhH3y7mAiW+B4xICl47TIJTIHABE6u
 d0dOI0OGjtGK6FAfApasOhihrN0x9UqYeZjpQrnokAeaAOzY1C1IZFbsXBJIFP+Jj0IMh19TZp6
 abWCtJxCSEVugm0bisLlXpym8AkkfkMoYPBtcaG0bpnzNz9tSxPxdYHp9Gwwq0K7CmrCkF9AgPH
 B4CkG+zje3Ne0qlEiyy9/bKz0mEMlm2sYMfFBMLDKDjeZcqrHNTdQmbXHhSk90lOsgRh6BZk58U
 mXgPizd1QeNZjMpbesPxNoJ5AP8B+usjbxnpHmMyI/0Z+Gy1Y7Y2dGeChAwGUTbpqeSNy9purvP
 3CA2YO6s70KD1iwbsissau1FLPKvhU4kUxthLMn5yh4MCtJDHibg==
X-Received: by 2002:a17:903:1ac3:b0:2c9:97a7:3288 with SMTP id
 d9443c01a7336-2c997a733f5mr55740665ad.42.1782638958963; 
 Sun, 28 Jun 2026 02:29:18 -0700 (PDT)
Received: from trevor.localdomain (n119236170163.netvigator.com.
 [119.236.170.163]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b43aeb3bsm23041205ad.54.2026.06.28.02.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 02:29:18 -0700 (PDT)
From: Trevor Chan <trev@trevrosa.dev>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, a.hindborg@kernel.org, paul@paul-moore.com,
 airlied@gmail.com, simona@ffwll.ch, aliceryhl@google.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, igor.korotin@linux.dev,
 boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk,
 daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com,
 j@jananu.net, akpm@linux-foundation.org, acourbot@nvidia.com
Cc: david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, jack@suse.cz,
 ljs@kernel.org, liam@infradead.org, bhelgaas@google.com,
 kwilczynski@kernel.org, ptikhomirov@virtuozzo.com,
 elle@weathered-steel.dev, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org
Subject: [PATCH v5] rust: aref: make `AlwaysRefCounted::inc_ref` an associated
 function
Date: Sun, 28 Jun 2026 17:28:53 +0800
Message-ID: <20260628092853.16550-1-trev@trevrosa.dev>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

`AlwaysRefCounted::inc_ref` is a function that shouldn't be called lightly.

To prevent accidentally calling it, change `inc_ref` to be an associated function.

Modify all `AlwaysRefCounted` implementors to work with this change.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1177
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Trevor Chan <trev@trevrosa.dev>
---
Changes in v2:
 - Don't word wrap the patch
Changes in v3:
 - Make argument name of `Empty::inc_ref` consistent with `Empty::dec_ref` 
Changes in v4:
 - Rebase to new rust-next, change new implementors
 - Reword explanation for change in `AlwaysRefCounted::inc_ref` doc comment
Changes in v5:
 - Change commit message to be imperative
---
 rust/kernel/auxiliary.rs        | 4 ++--
 rust/kernel/block/mq/request.rs | 4 ++--
 rust/kernel/cred.rs             | 4 ++--
 rust/kernel/device.rs           | 4 ++--
 rust/kernel/device/property.rs  | 4 ++--
 rust/kernel/drm/device.rs       | 4 ++--
 rust/kernel/drm/gem/mod.rs      | 4 ++--
 rust/kernel/fs/file.rs          | 8 ++++----
 rust/kernel/i2c.rs              | 8 ++++----
 rust/kernel/mm.rs               | 8 ++++----
 rust/kernel/mm/mmput_async.rs   | 4 ++--
 rust/kernel/pci.rs              | 4 ++--
 rust/kernel/pid_namespace.rs    | 4 ++--
 rust/kernel/platform.rs         | 4 ++--
 rust/kernel/sync/aref.rs        | 9 ++++++---
 rust/kernel/task.rs             | 4 ++--
 rust/kernel/usb.rs              | 8 ++++----
 17 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a239..75a61b51cf79 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -345,9 +345,9 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+        unsafe { bindings::get_device(obj.as_ref().as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index ce3e30c81cb5..f41d01ea4595 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -234,8 +234,8 @@ unsafe impl<T: Operations> Sync for Request<T> {}
 // keeps the object alive in memory at least until a matching reference count
 // decrement is executed.
 unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
-    fn inc_ref(&self) {
-        self.wrapper_ref().refcount().inc();
+    fn inc_ref(obj: &Self) {
+        obj.wrapper_ref().refcount().inc();
     }
 
     unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index ffa156b9df37..d53cbc792fa3 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -78,9 +78,9 @@ pub fn euid(&self) -> Kuid {
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
 unsafe impl AlwaysRefCounted for Credential {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_cred(self.0.get()) };
+        unsafe { bindings::get_cred(obj.0.get()) };
     }
 
     #[inline]
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 645afc49a27d..ec44dcc405d5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -449,9 +449,9 @@ pub fn name(&self) -> &CStr {
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::get_device(self.as_raw()) };
+        unsafe { bindings::get_device(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 5aead835fbbc..c39ccc1458b9 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -361,10 +361,10 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for FwNode {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the
         // refcount is non-zero.
-        unsafe { bindings::fwnode_handle_get(self.as_raw()) };
+        unsafe { bindings::fwnode_handle_get(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 477cf771fb10..0c70ec010bd9 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -363,9 +363,9 @@ fn deref(&self) -> &Self::Target {
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
 unsafe impl<T: drm::Driver, C: DeviceContext> AlwaysRefCounted for Device<T, C> {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::drm_dev_get(self.as_raw()) };
+        unsafe { bindings::drm_dev_get(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index c8b66d816871..ee9e412066ab 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -52,10 +52,10 @@ unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $
             Self: IntoGEMObject,
             $( $( $bind_param : $bind_trait ),+ )?
         {
-            fn inc_ref(&self) {
+            fn inc_ref(obj: &Self) {
                 // SAFETY: The existence of a shared reference guarantees that the refcount is
                 // non-zero.
-                unsafe { bindings::drm_gem_object_get(self.as_raw()) };
+                unsafe { bindings::drm_gem_object_get(obj.as_raw()) };
             }
 
             unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd240..8e5967afcd11 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -199,9 +199,9 @@ unsafe impl Sync for File {}
 // makes `ARef<File>` own a normal refcount.
 unsafe impl AlwaysRefCounted for File {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_file(self.as_ptr()) };
+        unsafe { bindings::get_file(obj.as_ptr()) };
     }
 
     #[inline]
@@ -235,9 +235,9 @@ pub struct LocalFile {
 // makes `ARef<LocalFile>` own a normal refcount.
 unsafe impl AlwaysRefCounted for LocalFile {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_file(self.as_ptr()) };
+        unsafe { bindings::get_file(obj.as_ptr()) };
     }
 
     #[inline]
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..1a9882a64c4b 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -425,9 +425,9 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
 
 // SAFETY: Instances of `I2cAdapter` are always reference-counted.
 unsafe impl AlwaysRefCounted for I2cAdapter {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::i2c_get_adapter(self.index()) };
+        unsafe { bindings::i2c_get_adapter(obj.index()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
@@ -501,9 +501,9 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for I2cClient<C
 
 // SAFETY: Instances of `I2cClient` are always reference-counted.
 unsafe impl AlwaysRefCounted for I2cClient {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+        unsafe { bindings::get_device(obj.as_ref().as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 4764d7b68f2a..c955cbd884b8 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -57,9 +57,9 @@ unsafe impl Sync for Mm {}
 // SAFETY: By the type invariants, this type is always refcounted.
 unsafe impl AlwaysRefCounted for Mm {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The pointer is valid since self is a reference.
-        unsafe { bindings::mmgrab(self.as_raw()) };
+        unsafe { bindings::mmgrab(obj.as_raw()) };
     }
 
     #[inline]
@@ -93,9 +93,9 @@ unsafe impl Sync for MmWithUser {}
 // SAFETY: By the type invariants, this type is always refcounted.
 unsafe impl AlwaysRefCounted for MmWithUser {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The pointer is valid since self is a reference.
-        unsafe { bindings::mmget(self.as_raw()) };
+        unsafe { bindings::mmget(obj.as_raw()) };
     }
 
     #[inline]
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index b8d2f051225c..7df40777654c 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -36,9 +36,9 @@ unsafe impl Sync for MmWithUserAsync {}
 // SAFETY: By the type invariants, this type is always refcounted.
 unsafe impl AlwaysRefCounted for MmWithUserAsync {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The pointer is valid since self is a reference.
-        unsafe { bindings::mmget(self.as_raw()) };
+        unsafe { bindings::mmget(obj.as_raw()) };
     }
 
     #[inline]
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..0f16cf0da3d7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -482,9 +482,9 @@ impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::pci_dev_get(self.as_raw()) };
+        unsafe { bindings::pci_dev_get(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 979a9718f153..381c9f980b1f 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -43,9 +43,9 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
 unsafe impl AlwaysRefCounted for PidNamespace {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_pid_ns(self.as_ptr()) };
+        unsafe { bindings::get_pid_ns(obj.as_ptr()) };
     }
 
     #[inline]
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..85068ae5a405 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -519,9 +519,9 @@ impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+        unsafe { bindings::get_device(obj.as_ref().as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index b721b2e00b98..2ae2130d5bb1 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -44,7 +44,10 @@
 /// alive.)
 pub unsafe trait AlwaysRefCounted {
     /// Increments the reference count on the object.
-    fn inc_ref(&self);
+    ///
+    /// This function should not be called accidentally; a type might declare their own `inc_ref`
+    /// function and it shouldn't be confused with this one.
+    fn inc_ref(obj: &Self);
 
     /// Decrements the reference count on the object.
     ///
@@ -145,7 +148,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
 
 impl<T: AlwaysRefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
-        self.inc_ref();
+        T::inc_ref(self);
         // SAFETY: We just incremented the refcount above.
         unsafe { Self::from_raw(self.ptr) }
     }
@@ -162,7 +165,7 @@ fn deref(&self) -> &Self::Target {
 
 impl<T: AlwaysRefCounted> From<&T> for ARef<T> {
     fn from(b: &T) -> Self {
-        b.inc_ref();
+        T::inc_ref(b);
         // SAFETY: We just incremented the refcount above.
         unsafe { Self::from_raw(NonNull::from(b)) }
     }
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38273f4eedb5..a7711e1558c2 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -349,9 +349,9 @@ pub fn group_leader(&self) -> &Task {
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
     #[inline]
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
-        unsafe { bindings::get_task_struct(self.as_ptr()) };
+        unsafe { bindings::get_task_struct(obj.as_ptr()) };
     }
 
     #[inline]
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 7aff0c82d0af..c039059c1891 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -393,11 +393,11 @@ fn as_ref(&self) -> &Device {
 
 // SAFETY: Instances of `Interface` are always reference-counted.
 unsafe impl AlwaysRefCounted for Interface {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The invariants of `Interface` guarantee that `self.as_raw()`
         // returns a valid `struct usb_interface` pointer, for which we will
         // acquire a new refcount.
-        unsafe { bindings::usb_get_intf(self.as_raw()) };
+        unsafe { bindings::usb_get_intf(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
@@ -444,11 +444,11 @@ fn as_raw(&self) -> *mut bindings::usb_device {
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl AlwaysRefCounted for Device {
-    fn inc_ref(&self) {
+    fn inc_ref(obj: &Self) {
         // SAFETY: The invariants of `Device` guarantee that `self.as_raw()`
         // returns a valid `struct usb_device` pointer, for which we will
         // acquire a new refcount.
-        unsafe { bindings::usb_get_dev(self.as_raw()) };
+        unsafe { bindings::usb_get_dev(obj.as_raw()) };
     }
 
     unsafe fn dec_ref(obj: NonNull<Self>) {
-- 
2.47.3

