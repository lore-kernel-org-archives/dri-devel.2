Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2079C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381DE10F602;
	Fri,  3 Jul 2026 03:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Yzracabq";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525FB10F601
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-475417f010dso40505f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047713; x=1783652513;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUSHh2GQ3I5KH9hTK1NKMZdfJZAKYGKGP6z5fIcheuI=;
 b=YzracabqGsWXStS5y7FGCWrVwOU0WJpdbMxjmsVEemLrFLnB9/Z355hLfiPcljYVlA
 RrLH8k4V+Xcw7m1nxtAlKn19L48lhNueT6wB33AIzwpLgPqAAVxXTW7+jtFNBp7Udckj
 B7SAgmMVgU6y/CHt0qo1S4pnsl0sqH41368CDqC7MgWhqwRF3vSGVGTgKZaM3IcMUrKa
 DNaLLPKC3dnI0e+ea8IoUdbZK01D8Oo1hgBmJX25jAP/84LCBMlUzIanYN1LhEcJc+Vj
 yFpGu1TGdAAYH+zZMrdmkWcJK1AubRBhcNXSIoudfcTd6lPxcWNpZDGH4NvV07ppl7/I
 077g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047713; x=1783652513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kUSHh2GQ3I5KH9hTK1NKMZdfJZAKYGKGP6z5fIcheuI=;
 b=KwSAzY/gyHtOIxcTjiPMnPb786VnlCoBac/+JE1TC2eqZGD1KuH6E0n/akmBaXcrIR
 CYCmm8WDMV17nru04G+2syJBi2S2gbNKT3Q5YOY2QiWf4gVuF1QT1Jp+J17xXF1TKv4l
 HJ83sR82kksAilHSN8aoKHoYaRihj4FjnFDVQWuBHInuDSxNSnFtux62hmoyaEfHnj0n
 GghrLYq3PRNxHtR8nhIKg2pqf4CBd0ppknrCSn7r+YXexIM7LpeETZMD5bPpLVhNIqJc
 kDq+UxcVUvzBc6YhXWmUtq3OIRJ9RUN+2YLNVWHfiliOx1EsyVhcvEFA7DZATnyr8Z8f
 z9rA==
X-Gm-Message-State: AOJu0Yztf1KOTh6kpeZ9KfqbyhIVIYlYRj9C6hVgERyMRkSuk4TaftN9
 WouiiQ7yQJfLj+Tm2YMd8FpzDeqpF5K028Znx9dzxieQO9JsRfAd6b3LIUSY5m/tSg==
X-Gm-Gg: AfdE7cl+Ia17U0B3LgGqZwwK+WzJcPwCqShbRTH72rEBNCHzJRPyl4HDai2PFyjr9JE
 lcogJQEYKuHie/Dq6eJ6N42wyYH8aBinKt9W6/dD8vpJWklmeUXVaWbeR0jTowoqLLaBnY1RJLk
 gB+Ubwc2nKtDoifG3ygN23+Hqs/Qm5Vbk2GyK4GqYQqy2n1Z6VJel6CriXhgV9Ix/bC24AkV6aD
 2TwMiaCJ6HACNkYvKCmQO5X1ZRx10J2NRIfzur7m+LACRS0L/JgH13p9zSzyahyeB2NCAqZStuT
 AteV1kFaxVHz3CxeL4ueSJDTSuQExNAas5qKP0wwMLe/9FEWzfZ+0wbMy3GOEgEKphBMIzdnbpL
 cER2GwTVKOyphY0OSOeFwezqmv8XDe0Z6BCta3umAu3L3JkfhccUNvBpbAseD26RyIFd9UzEZN9
 WAiEVmFrEt4P5Oaklg2fPiz9J+q30eq8c1ysBbjecpjCBJW06CTEQZGhYE
X-Received: by 2002:a05:6000:2606:b0:475:e7f7:ef7a with SMTP id
 ffacd0b85a97d-4775779827cmr12406067f8f.23.1783047712619; 
 Thu, 02 Jul 2026 20:01:52 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:51 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 09/18] rust: drm: add drm_event delivery
Date: Fri,  3 Jul 2026 04:00:56 +0100
Message-ID: <20260703030123.2814-10-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

DRM drivers deliver asynchronous events to the userspace client that owns a
struct drm_file (vblank completions, and driver-defined events such as the
DisplayLink evdi driver's mode/cursor/dpms/ddcci notifications), which userspace
reaps through the poll(2)/read(2) interface of the DRM character device. The
Rust DRM abstractions had no binding for this at all.

Add a drm::event module providing:

  - EventPayload, an unsafe marker trait for a #[repr(C)] event struct whose
    first field is a drm_event header (filled in by the binding);

  - EventChannel, which stores the receiver drm_file under the device's
    event_lock -- the same lock drm_event_reserve_init_locked() and
    drm_send_event_locked() require held -- so registering, clearing and sending
    are serialized against file close. The classic bug of reading the target
    file pointer outside the lock and delivering to a client that just
    disconnected (a NULL/UAF oops) is therefore unrepresentable.

event_lock() moves from the KMS Device impl to the core drm::Device impl, since
events are a DRM-core concept, not a KMS one; the vblank callers are unaffected.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/device.rs |  19 +++-
 rust/kernel/drm/event.rs  | 215 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/drm/kms.rs    |  11 +-
 rust/kernel/drm/mod.rs    |   1 +
 4 files changed, 236 insertions(+), 10 deletions(-)
 create mode 100644 rust/kernel/drm/event.rs

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 5b84ce18fb29..7088db9420fb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -19,9 +19,12 @@
     },
     error::from_err_ptr,
     prelude::*,
-    sync::aref::{
-        ARef,
-        AlwaysRefCounted, //
+    sync::{
+        aref::{
+            ARef,
+            AlwaysRefCounted, //
+        },
+        SpinLockIrq,
     },
     types::{
         ForLt,
@@ -353,6 +356,16 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
         self.dev.get()
     }
 
+    /// Returns a reference to the `event` spinlock of this [`Device`].
+    ///
+    /// This is the `struct drm_device::event_lock` that the DRM core requires to be held while
+    /// reserving and sending events to userspace (see the [`event`](crate::drm::event) module).
+    #[inline]
+    pub(crate) fn event_lock(&self) -> &SpinLockIrq<()> {
+        // SAFETY: `event_lock` is initialized for as long as `self` is exposed to users.
+        unsafe { SpinLockIrq::from_raw(&raw mut (*self.as_raw()).event_lock) }
+    }
+
     /// Returns a reference to the registration data with lifetime shortened
     /// from `'static`.
     ///
diff --git a/rust/kernel/drm/event.rs b/rust/kernel/drm/event.rs
new file mode 100644
index 000000000000..39d65d2a8fb2
--- /dev/null
+++ b/rust/kernel/drm/event.rs
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM event delivery to userspace.
+//!
+//! A DRM driver can deliver asynchronous events to the userspace client that owns a
+//! [`File`][crate::drm::File]. Userspace reaps them through the `poll(2)`/`read(2)` interface of
+//! the DRM character device. The C core calls this mechanism "events" and drivers such as
+//! `vkms`/`vc4`/DisplayLink's `evdi` use it to hand back vblank completions, mode-change
+//! notifications, cursor updates and so on.
+//!
+//! The C API (`drm_event_reserve_init_locked()` + `drm_send_event_locked()`) has one non-obvious
+//! rule: the `struct drm_device::event_lock` must be held while reserving and sending, and the
+//! target `struct drm_file` must be valid for that whole critical section. Reading the target file
+//! pointer outside the lock is a classic source of use-after-free/NULL-deref crashes (a driver's
+//! flush worker racing a client disconnect). [`EventChannel`] encodes that rule in its API: the
+//! receiver file is only ever touched while `event_lock` is held, so registration, teardown and
+//! delivery cannot race.
+//!
+//! C header: [`include/drm/drm_file.h`](srctree/include/drm/drm_file.h)
+
+use crate::{
+    bindings,
+    drm::{
+        self,
+        device::DeviceContext,
+        file::{DriverFile, File},
+        Device,
+    },
+    error::to_result,
+    interrupt,
+    prelude::*,
+};
+use core::{cell::UnsafeCell, mem};
+
+/// A driver-defined DRM event payload.
+///
+/// This is the fixed-size structure copied verbatim to userspace when the event is read. It must
+/// begin with a [`bindings::drm_event`] header; [`EventChannel::send`] fills that header's `type`
+/// and `length` for you from [`EventPayload::TYPE`] and `size_of::<Self>()`.
+///
+/// # Safety
+///
+/// Implementers must guarantee that:
+/// - `Self` is `#[repr(C)]` and its first field is a [`bindings::drm_event`], so that a
+///   `*mut Self` is also a valid `*mut drm_event`;
+/// - `Self` is plain-old-data: it has no [`Drop`] glue and every bit pattern written by the driver
+///   is safe to copy to userspace (do not place kernel pointers or padding holding secrets in it).
+pub unsafe trait EventPayload: Copy + 'static {
+    /// The `struct drm_event::type` code identifying this event to userspace.
+    const TYPE: u32;
+}
+
+/// Backing allocation for one in-flight event.
+///
+/// The [`bindings::drm_pending_event`] is deliberately the first field: once handed to the DRM
+/// core, the whole allocation is freed by a single `kfree()` of the `drm_pending_event` pointer
+/// (on delivery or on file close), which is only correct if it sits at offset 0.
+#[repr(C)]
+struct EventStorage<T: EventPayload> {
+    pending: bindings::drm_pending_event,
+    event: T,
+}
+
+/// A per-device channel that delivers driver events to the [`File`] registered as the receiver.
+///
+/// The receiver pointer is stored under the owning device's `event_lock` — the same lock the DRM
+/// core requires held while queuing events — so [`connect`](Self::connect),
+/// [`disconnect`](Self::disconnect), [`notify_close`](Self::notify_close) and [`send`](Self::send)
+/// are all serialized against each other and against the core's own event handling. This makes the
+/// "send to a file that just disconnected" race unrepresentable.
+///
+/// A channel is bound to exactly one [`Device`]: always pass the same device to every method.
+/// Drivers must call [`notify_close`](Self::notify_close) from their `postclose` hook (and/or
+/// [`disconnect`](Self::disconnect) when tearing the logical connection down) so the receiver
+/// pointer never outlives the file it refers to.
+pub struct EventChannel {
+    /// The receiver `drm_file`, or null when no client is connected.
+    ///
+    /// Only ever accessed while the owning device's `event_lock` is held.
+    receiver: UnsafeCell<*mut bindings::drm_file>,
+}
+
+// SAFETY: `receiver` is only accessed while holding the owning device's `event_lock`, which
+// serializes all access across threads.
+unsafe impl Send for EventChannel {}
+// SAFETY: See `Send`.
+unsafe impl Sync for EventChannel {}
+
+impl EventChannel {
+    /// Create a new, disconnected channel.
+    pub const fn new() -> Self {
+        Self {
+            receiver: UnsafeCell::new(core::ptr::null_mut()),
+        }
+    }
+
+    /// Register `file` as the receiver for events sent through this channel.
+    ///
+    /// Any previously registered file is replaced. Runs under `dev`'s `event_lock`.
+    pub fn connect<D: drm::Driver, C: DeviceContext, F: DriverFile>(
+        &self,
+        dev: &Device<D, C>,
+        file: &File<F>,
+    ) {
+        let irq = interrupt::local_interrupt_disable();
+        let _guard = dev.event_lock().lock_with(&irq);
+        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
+        unsafe { *self.receiver.get() = file.as_raw() };
+    }
+
+    /// Clear the receiver, dropping any future events on the floor until the next
+    /// [`connect`](Self::connect). Runs under `dev`'s `event_lock`.
+    pub fn disconnect<D: drm::Driver, C: DeviceContext>(&self, dev: &Device<D, C>) {
+        let irq = interrupt::local_interrupt_disable();
+        let _guard = dev.event_lock().lock_with(&irq);
+        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
+        unsafe { *self.receiver.get() = core::ptr::null_mut() };
+    }
+
+    /// Clear the receiver if it is `file`.
+    ///
+    /// Intended to be called from the driver's `postclose` hook so the stored pointer never
+    /// outlives the file. Runs under `dev`'s `event_lock`.
+    pub fn notify_close<D: drm::Driver, C: DeviceContext, F: DriverFile>(
+        &self,
+        dev: &Device<D, C>,
+        file: &File<F>,
+    ) {
+        let irq = interrupt::local_interrupt_disable();
+        let _guard = dev.event_lock().lock_with(&irq);
+        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
+        unsafe {
+            if *self.receiver.get() == file.as_raw() {
+                *self.receiver.get() = core::ptr::null_mut();
+            }
+        }
+    }
+
+    /// Whether a receiver is currently connected. Runs under `dev`'s `event_lock`.
+    pub fn is_connected<D: drm::Driver, C: DeviceContext>(&self, dev: &Device<D, C>) -> bool {
+        let irq = interrupt::local_interrupt_disable();
+        let _guard = dev.event_lock().lock_with(&irq);
+        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
+        !unsafe { *self.receiver.get() }.is_null()
+    }
+
+    /// Deliver `payload` to the connected receiver.
+    ///
+    /// Allocates the backing event, fills its `drm_event` header, and hands it to the DRM core
+    /// under `event_lock`. If no receiver is connected the event is silently dropped and `Ok(())`
+    /// is returned (mirroring the C drivers, which cannot deliver to a closed client). If the
+    /// client has no space left in its event queue this returns `Err(ENOMEM)` and the event is
+    /// dropped; the caller may retry later.
+    pub fn send<D: drm::Driver, C: DeviceContext, T: EventPayload>(
+        &self,
+        dev: &Device<D, C>,
+        payload: T,
+    ) -> Result {
+        let mut storage = KBox::new(
+            EventStorage {
+                pending: bindings::drm_pending_event::default(),
+                event: payload,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // Fill the `drm_event` header that begins `event`.
+        // SAFETY: `EventPayload` guarantees `T` begins with a `drm_event`.
+        let ev_ptr: *mut bindings::drm_event = (&raw mut storage.event).cast();
+        // SAFETY: `ev_ptr` points to the live `drm_event` header inside `storage`.
+        unsafe {
+            (*ev_ptr).type_ = T::TYPE;
+            (*ev_ptr).length = mem::size_of::<T>() as u32;
+        }
+        storage.pending.event = ev_ptr;
+        let pending: *mut bindings::drm_pending_event = &raw mut storage.pending;
+
+        let irq = interrupt::local_interrupt_disable();
+        let guard = dev.event_lock().lock_with(&irq);
+
+        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
+        let receiver = unsafe { *self.receiver.get() };
+        if receiver.is_null() {
+            drop(guard);
+            // `storage` is dropped here, freeing the allocation.
+            return Ok(());
+        }
+
+        let dev_raw = dev.as_raw();
+        // SAFETY: `dev_raw` and `receiver` are valid; `pending`/`ev_ptr` point into a live
+        // allocation; `event_lock` is held as required by the C API.
+        let ret = unsafe {
+            bindings::drm_event_reserve_init_locked(dev_raw, receiver, pending, ev_ptr)
+        };
+        if ret != 0 {
+            drop(guard);
+            // Reservation failed, so `pending` was never queued: `storage` frees the allocation.
+            return to_result(ret);
+        }
+
+        // SAFETY: The event is reserved against `receiver`; hand ownership of the allocation to the
+        // DRM core, which frees it (via `kfree` of the `drm_pending_event` at offset 0) once the
+        // event is delivered or the file is closed. `event_lock` is held as required.
+        unsafe { bindings::drm_send_event_locked(dev_raw, pending) };
+        let _ = KBox::into_raw(storage);
+        drop(guard);
+        Ok(())
+    }
+}
+
+impl Default for EventChannel {
+    fn default() -> Self {
+        Self::new()
+    }
+}
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 7207466094e7..874a2ebc7887 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -12,7 +12,7 @@
     },
     error::to_result,
     prelude::*,
-    sync::{aref::{ARef, AlwaysRefCounted}, Mutex, MutexGuard, SpinLockIrq},
+    sync::{aref::{ARef, AlwaysRefCounted}, Mutex, MutexGuard},
 };
 use bindings;
 use core::{
@@ -377,6 +377,9 @@ pub(crate) fn mode_config_mutex(&self) -> &Mutex<()> {
         unsafe { Mutex::from_raw(addr_of_mut!((*self.as_raw()).mode_config.mutex)) }
     }
 
+    // NOTE: `event_lock()` now lives in `drm::device` since events are a DRM-core concept, not a
+    // KMS one. See [`crate::drm::Device::event_lock`] and the [`crate::drm::event`] module.
+
     /// Return the number of registered [`Crtc`](crtc::Crtc) objects on this [`Device`].
     #[inline]
     pub fn num_crtcs(&self) -> u32 {
@@ -387,12 +390,6 @@ pub fn num_crtcs(&self) -> u32 {
         unsafe { (*self.as_raw()).mode_config.num_crtc as u32 }
     }
 
-    /// Returns a reference to the `event` spinlock for this [`Device`].
-    #[inline]
-    pub(crate) fn event_lock(&self) -> &SpinLockIrq<()> {
-        // SAFETY: `event_lock` is initialized for as long as `self` is exposed to users.
-        unsafe { SpinLockIrq::from_raw(addr_of_mut!((*self.as_raw()).event_lock)) }
-    }
 }
 
 impl<T: KmsDriver> Device<T> {
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index 7503f298db08..77067fc00d2a 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -4,6 +4,7 @@
 
 pub mod device;
 pub mod driver;
+pub mod event;
 pub mod file;
 pub mod fourcc;
 pub mod gem;
-- 
2.55.0

