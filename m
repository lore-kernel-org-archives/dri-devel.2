Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2730FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832EB10F607;
	Fri,  3 Jul 2026 03:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="wlVFbR81";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1610F607
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:10 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so432565e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047729; x=1783652529;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJo7TDfciSOR3fPsvfGRU1Um27ufdThVMtKgOOefwMI=;
 b=wlVFbR81uO56Za7adDHgJAC7c7gP5t9GPXBSwTOlO1WSH9lsUDRXMwPhpW9RoVkCpY
 3JWMsrUZLjtbeIY4VJTPjBuwBT/gLAzXRGmyyoOY48eH1fWC6/Bgwz/V2FhWpTj0VkfU
 OdEcprwu0JnE55Y7RybDA5uYtYt2wpNGIa3jxJkzymQWz06X6LOF21KepiDPywdqxJK7
 WdXzYGd+Do2CkbRrQnRXdZ+tnykgsSq5D9scXtk6qSV4UKqOqFSVXyidrho7QeE/5x2l
 j0Z/CIRUh7co6HEVOp2rQLMQjPq/Ztzv7XvtmTsl8EEi5FuUFaM3YvatsiZPq+uN74yc
 Fl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047729; x=1783652529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJo7TDfciSOR3fPsvfGRU1Um27ufdThVMtKgOOefwMI=;
 b=moKFcEvkFWXZKeT+FlJiHe+YbDgu3b633i+JynvY6o7PcviA2gOofy97bc06wb+d0Y
 /CU5hQ+JGY6BppGVP9+ceG7FaNYxVOrKcEZdXlxKaSLWjTXHbL8Mqk+3b1+q2J9YFFGA
 /fuhD6DSHU6R8As4777bMkJ3pV0cskyGD/Yfu958snNk7uayiw8XBsi8unFkd0nZ5pg5
 s4dIvglg9mVnjo1DnCTWGZ0PUUfAL8erh1QIK1FnOdKUFkLFYDLmIM45SEivbLNQAXEs
 yJ9W8XCLGj3sVKU/r5Jd4gKPNOROfHHZ/BqU5xubxxqfWrvonhxZMfY/iM2D9q3jOOol
 p6pg==
X-Gm-Message-State: AOJu0YzTHhGgjrngeGpZTEp+aYluUmHq8+JzV3LCHwsXOuye74FF9y31
 Bu4yCf3IiJOCcxzy/sk65d7xpGXZ2/iqAQTt5z8JQXqJVSGgArMdh1cTAWUdn/QJzrZ9kdHkU1W
 8QgY8eAP9
X-Gm-Gg: AfdE7clazrpl7lGvdBWAhVK4dTkp8B6knc1wLh5Tfx2bbS+usVVBJaovRgUWvWJy6X0
 BgXpiNzQZkTsAbxW4Gntk+WDWpjjkx0jm5WCMGOWHTAJ9sWrMfyfcS3Tpvq/h8ew8AjQupPK06i
 JnNrsRrhFZBTbEzPNiY4qLzuf6PBlmetM0mEtAQlRsSGlLWWOgKIZKchkOIjNwx0a5Nh6mWjxkC
 iNYKMJS5EurdbtCdXm77PNFKfkF2wfddzdoKm70QIc2dk12MJdFU3USvEbpeyE++H4TRE1FKuZc
 FgVMOs9kEy6TrvU6LGXb9FLqgQsrM3uQe2Rcl7y7+ipL7Yk2tAy6q6xiYumDH1HR7P5nrc7JoM1
 N9FvkN8OB9uJ9xdrvxDZLv6NeoAFUrchki7yjUtdgw0tgUiqw7T3atDLxodWnuZ99BM0Jgrji3+
 yoAWYYibI3+xwWGMfRHQWcZwQfGVpbLy7dPANnHJIQzWHyWNEpi/lxLfIA
X-Received: by 2002:a7b:c34e:0:b0:493:ad8a:e7fd with SMTP id
 5b1f17b1804b1-493c3cd9d76mr72546515e9.14.1783047729025; 
 Thu, 02 Jul 2026 20:02:09 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:07 -0700 (PDT)
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
Subject: [RFC PATCH v2 15/18] rust: drm: support hardware cursor planes with
 sleepable event delivery
Date: Fri,  3 Jul 2026 04:01:02 +0100
Message-ID: <20260703030123.2814-16-mike@fireburn.co.uk>
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

A driver that forwards a hardware cursor plane's contents to userspace (e.g.
DisplayLink's evdi, whose daemon composites the cursor itself) needs to hand the
client a GEM handle for the cursor bitmap on each update. drm_gem_handle_create()
may sleep, so the connected file must be reachable from sleepable context -- but
drm::event::EventChannel stored the receiver under the device event_lock (a
spinlock).

Rework EventChannel to guard the receiver with a Mutex instead: send() holds it
across the event_lock-protected reserve+queue (so delivery still cannot race a
close), and a new with_receiver() runs a closure with the connected File while
holding the mutex, allowing a sleepable GEM-handle creation without the file
closing underneath it (notify_close() takes the same mutex). new() now takes a
lock class so the class lives in the driver module. connect/disconnect/
notify_close/is_connected no longer need the device.

Add the accessors such a cursor consumer needs:
  - plane state crtc_x()/crtc_y() (cursor position) and hotspot_x()/hotspot_y();
  - Framebuffer::format() (FourCC) and Framebuffer::create_handle() (a GEM handle
    for plane-0 in a given file).

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/event.rs           | 179 +++++++++++++++--------------
 rust/kernel/drm/kms/framebuffer.rs |  28 +++++
 rust/kernel/drm/kms/plane.rs       |  20 ++++
 3 files changed, 138 insertions(+), 89 deletions(-)

diff --git a/rust/kernel/drm/event.rs b/rust/kernel/drm/event.rs
index 39d65d2a8fb2..dadb38c7df20 100644
--- a/rust/kernel/drm/event.rs
+++ b/rust/kernel/drm/event.rs
@@ -13,8 +13,8 @@
 //! target `struct drm_file` must be valid for that whole critical section. Reading the target file
 //! pointer outside the lock is a classic source of use-after-free/NULL-deref crashes (a driver's
 //! flush worker racing a client disconnect). [`EventChannel`] encodes that rule in its API: the
-//! receiver file is only ever touched while `event_lock` is held, so registration, teardown and
-//! delivery cannot race.
+//! receiver file lives behind a mutex and [`send`](EventChannel::send) holds it across the whole
+//! `event_lock`-protected reserve+queue, so registration, teardown and delivery cannot race.
 //!
 //! C header: [`include/drm/drm_file.h`](srctree/include/drm/drm_file.h)
 
@@ -29,8 +29,9 @@
     error::to_result,
     interrupt,
     prelude::*,
+    sync::{LockClassKey, Mutex},
 };
-use core::{cell::UnsafeCell, mem};
+use core::mem;
 
 /// A driver-defined DRM event payload.
 ///
@@ -63,94 +64,101 @@ struct EventStorage<T: EventPayload> {
 
 /// A per-device channel that delivers driver events to the [`File`] registered as the receiver.
 ///
-/// The receiver pointer is stored under the owning device's `event_lock` — the same lock the DRM
-/// core requires held while queuing events — so [`connect`](Self::connect),
-/// [`disconnect`](Self::disconnect), [`notify_close`](Self::notify_close) and [`send`](Self::send)
-/// are all serialized against each other and against the core's own event handling. This makes the
-/// "send to a file that just disconnected" race unrepresentable.
+/// The receiver `drm_file` is stored behind a [`Mutex`], not the device `event_lock`, so it can be
+/// touched from sleepable context — in particular so a driver can create a GEM handle for the
+/// connected client (`drm_gem_handle_create` may sleep) via [`with_receiver`](Self::with_receiver).
+/// [`send`](Self::send) still acquires the device's `event_lock` (as the DRM core requires) while
+/// holding the mutex, so the receiver pointer is valid for the whole reserve+queue and cannot race
+/// [`disconnect`](Self::disconnect)/[`notify_close`](Self::notify_close). This makes the classic
+/// "deliver to a file that just closed" use-after-free unrepresentable.
 ///
-/// A channel is bound to exactly one [`Device`]: always pass the same device to every method.
+/// A channel is bound to exactly one [`Device`]: always pass the same device to [`send`](Self::send).
 /// Drivers must call [`notify_close`](Self::notify_close) from their `postclose` hook (and/or
 /// [`disconnect`](Self::disconnect) when tearing the logical connection down) so the receiver
 /// pointer never outlives the file it refers to.
+#[pin_data]
 pub struct EventChannel {
-    /// The receiver `drm_file`, or null when no client is connected.
+    /// The receiver `drm_file` address, or `0` when no client is connected.
     ///
-    /// Only ever accessed while the owning device's `event_lock` is held.
-    receiver: UnsafeCell<*mut bindings::drm_file>,
+    /// A `usize` (not a raw pointer) so the `Mutex` is `Send`/`Sync` on its own; the value is only
+    /// ever turned back into a `*mut drm_file` while the mutex is held.
+    #[pin]
+    receiver: Mutex<usize>,
 }
 
-// SAFETY: `receiver` is only accessed while holding the owning device's `event_lock`, which
-// serializes all access across threads.
-unsafe impl Send for EventChannel {}
-// SAFETY: See `Send`.
-unsafe impl Sync for EventChannel {}
-
 impl EventChannel {
     /// Create a new, disconnected channel.
-    pub const fn new() -> Self {
-        Self {
-            receiver: UnsafeCell::new(core::ptr::null_mut()),
-        }
+    ///
+    /// `key` is the lock class for the receiver mutex; pass
+    /// [`static_lock_class!()`](crate::sync::static_lock_class) from the driver so the class lives
+    /// in the driver module.
+    #[inline]
+    pub fn new(key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            receiver <- Mutex::new(0, c"EventChannel::receiver", key),
+        })
     }
 
     /// Register `file` as the receiver for events sent through this channel.
     ///
-    /// Any previously registered file is replaced. Runs under `dev`'s `event_lock`.
-    pub fn connect<D: drm::Driver, C: DeviceContext, F: DriverFile>(
-        &self,
-        dev: &Device<D, C>,
-        file: &File<F>,
-    ) {
-        let irq = interrupt::local_interrupt_disable();
-        let _guard = dev.event_lock().lock_with(&irq);
-        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
-        unsafe { *self.receiver.get() = file.as_raw() };
+    /// Any previously registered file is replaced.
+    pub fn connect<F: DriverFile>(&self, file: &File<F>) {
+        *self.receiver.lock() = file.as_raw() as usize;
     }
 
     /// Clear the receiver, dropping any future events on the floor until the next
-    /// [`connect`](Self::connect). Runs under `dev`'s `event_lock`.
-    pub fn disconnect<D: drm::Driver, C: DeviceContext>(&self, dev: &Device<D, C>) {
-        let irq = interrupt::local_interrupt_disable();
-        let _guard = dev.event_lock().lock_with(&irq);
-        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
-        unsafe { *self.receiver.get() = core::ptr::null_mut() };
+    /// [`connect`](Self::connect).
+    #[inline]
+    pub fn disconnect(&self) {
+        *self.receiver.lock() = 0;
     }
 
     /// Clear the receiver if it is `file`.
     ///
     /// Intended to be called from the driver's `postclose` hook so the stored pointer never
-    /// outlives the file. Runs under `dev`'s `event_lock`.
-    pub fn notify_close<D: drm::Driver, C: DeviceContext, F: DriverFile>(
-        &self,
-        dev: &Device<D, C>,
-        file: &File<F>,
-    ) {
-        let irq = interrupt::local_interrupt_disable();
-        let _guard = dev.event_lock().lock_with(&irq);
-        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
-        unsafe {
-            if *self.receiver.get() == file.as_raw() {
-                *self.receiver.get() = core::ptr::null_mut();
-            }
+    /// outlives the file.
+    pub fn notify_close<F: DriverFile>(&self, file: &File<F>) {
+        let mut recv = self.receiver.lock();
+        if *recv == file.as_raw() as usize {
+            *recv = 0;
         }
     }
 
-    /// Whether a receiver is currently connected. Runs under `dev`'s `event_lock`.
-    pub fn is_connected<D: drm::Driver, C: DeviceContext>(&self, dev: &Device<D, C>) -> bool {
-        let irq = interrupt::local_interrupt_disable();
-        let _guard = dev.event_lock().lock_with(&irq);
-        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
-        !unsafe { *self.receiver.get() }.is_null()
+    /// Whether a receiver is currently connected.
+    #[inline]
+    pub fn is_connected(&self) -> bool {
+        *self.receiver.lock() != 0
+    }
+
+    /// Run `f` with the connected receiver [`File`], if any, returning its result.
+    ///
+    /// The receiver mutex is held for the duration, so `f` may sleep (e.g. to create a GEM handle
+    /// in the client's file with [`Framebuffer::create_handle`](crate::drm::kms::framebuffer::Framebuffer::create_handle))
+    /// without the file being closed underneath it: [`notify_close`](Self::notify_close) takes the
+    /// same mutex and so blocks until `f` returns. Returns [`None`] if no client is connected.
+    ///
+    /// # Type parameter
+    ///
+    /// `F` must be the same [`DriverFile`] type the receiver was [`connect`](Self::connect)ed with.
+    pub fn with_receiver<F: DriverFile, R>(&self, f: impl FnOnce(&File<F>) -> R) -> Option<R> {
+        let recv = self.receiver.lock();
+        let raw = *recv as *mut bindings::drm_file;
+        if raw.is_null() {
+            return None;
+        }
+        // SAFETY: `raw` was stored from a live `File<F>` by `connect`; it stays valid because
+        // `notify_close`/`disconnect` (which clear it) take this same mutex, held here.
+        let file = unsafe { File::<F>::from_raw(raw) };
+        Some(f(file))
     }
 
     /// Deliver `payload` to the connected receiver.
     ///
     /// Allocates the backing event, fills its `drm_event` header, and hands it to the DRM core
-    /// under `event_lock`. If no receiver is connected the event is silently dropped and `Ok(())`
-    /// is returned (mirroring the C drivers, which cannot deliver to a closed client). If the
-    /// client has no space left in its event queue this returns `Err(ENOMEM)` and the event is
-    /// dropped; the caller may retry later.
+    /// under `event_lock` (acquired while the receiver mutex is held). If no receiver is connected
+    /// the event is silently dropped and `Ok(())` is returned (mirroring the C drivers, which
+    /// cannot deliver to a closed client). If the client has no space left in its event queue this
+    /// returns `Err(ENOMEM)` and the event is dropped; the caller may retry later.
     pub fn send<D: drm::Driver, C: DeviceContext, T: EventPayload>(
         &self,
         dev: &Device<D, C>,
@@ -175,41 +183,34 @@ pub fn send<D: drm::Driver, C: DeviceContext, T: EventPayload>(
         storage.pending.event = ev_ptr;
         let pending: *mut bindings::drm_pending_event = &raw mut storage.pending;
 
-        let irq = interrupt::local_interrupt_disable();
-        let guard = dev.event_lock().lock_with(&irq);
-
-        // SAFETY: `receiver` is only accessed under `event_lock`, which is held here.
-        let receiver = unsafe { *self.receiver.get() };
+        // Hold the receiver mutex across the whole reserve+queue so the file can't close underneath
+        // us, then take `event_lock` as the C API requires.
+        let recv = self.receiver.lock();
+        let receiver = *recv as *mut bindings::drm_file;
         if receiver.is_null() {
-            drop(guard);
-            // `storage` is dropped here, freeing the allocation.
+            // No client; `storage` is dropped here, freeing the allocation.
             return Ok(());
         }
 
         let dev_raw = dev.as_raw();
-        // SAFETY: `dev_raw` and `receiver` are valid; `pending`/`ev_ptr` point into a live
-        // allocation; `event_lock` is held as required by the C API.
-        let ret = unsafe {
-            bindings::drm_event_reserve_init_locked(dev_raw, receiver, pending, ev_ptr)
-        };
-        if ret != 0 {
-            drop(guard);
-            // Reservation failed, so `pending` was never queued: `storage` frees the allocation.
-            return to_result(ret);
+        let irq = interrupt::local_interrupt_disable();
+        {
+            let _ev = dev.event_lock().lock_with(&irq);
+            // SAFETY: `dev_raw`/`receiver` are valid; `pending`/`ev_ptr` point into a live
+            // allocation; `event_lock` is held as required by the C API.
+            let ret = unsafe {
+                bindings::drm_event_reserve_init_locked(dev_raw, receiver, pending, ev_ptr)
+            };
+            if ret != 0 {
+                // Reservation failed, so `pending` was never queued: `storage` frees it.
+                return to_result(ret);
+            }
+            // SAFETY: The event is reserved against `receiver`; hand ownership of the allocation to
+            // the DRM core, which frees it (via `kfree` of the `drm_pending_event` at offset 0)
+            // once delivered or the file closes. `event_lock` is held as required.
+            unsafe { bindings::drm_send_event_locked(dev_raw, pending) };
         }
-
-        // SAFETY: The event is reserved against `receiver`; hand ownership of the allocation to the
-        // DRM core, which frees it (via `kfree` of the `drm_pending_event` at offset 0) once the
-        // event is delivered or the file is closed. `event_lock` is held as required.
-        unsafe { bindings::drm_send_event_locked(dev_raw, pending) };
         let _ = KBox::into_raw(storage);
-        drop(guard);
         Ok(())
     }
 }
-
-impl Default for EventChannel {
-    fn default() -> Self {
-        Self::new()
-    }
-}
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index c7089b12d0d1..e12fa7a24e15 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -121,6 +121,34 @@ pub fn pitch(&self, index: usize) -> u32 {
         unsafe { (*self.as_raw()).pitches[index & 3] }
     }
 
+    /// The framebuffer's pixel format as a FourCC code (`DRM_FORMAT_*`).
+    #[inline]
+    pub fn format(&self) -> u32 {
+        // SAFETY: a valid framebuffer always has a non-null, immutable `format` descriptor.
+        unsafe { (*(*self.as_raw()).format).format }
+    }
+
+    /// Create a GEM handle for this framebuffer's plane-0 backing object in `file`'s handle space,
+    /// returning it.
+    ///
+    /// This lets a driver hand a userspace client (e.g. via an event) a handle to a buffer the
+    /// client did not create itself -- for instance a cursor bitmap set by a compositor that a
+    /// separate control daemon needs to read. May sleep.
+    pub fn create_handle<F: crate::drm::file::DriverFile>(
+        &self,
+        file: &crate::drm::File<F>,
+    ) -> Result<u32> {
+        // SAFETY: `as_raw()` is a valid framebuffer; `obj[0]` is its plane-0 GEM object.
+        let obj = unsafe { (*self.as_raw()).obj[0] };
+        if obj.is_null() {
+            return Err(EINVAL);
+        }
+        let mut handle = 0u32;
+        // SAFETY: `file` and `obj` are valid; `drm_gem_handle_create` initializes `handle`.
+        to_result(unsafe { bindings::drm_gem_handle_create(file.as_raw().cast(), obj, &mut handle) })?;
+        Ok(handle)
+    }
+
     /// Map this framebuffer's plane-0 backing pages into the kernel address space for CPU
     /// access, for the duration of the returned guard.
     ///
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 3863dfe1b84c..fcaa8ba550fe 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -605,6 +605,26 @@ fn crtc_h(&self) -> u32 {
         self.as_raw().crtc_h
     }
 
+    /// The X position of this plane's destination rectangle within the CRTC (`crtc_x`).
+    fn crtc_x(&self) -> i32 {
+        self.as_raw().crtc_x
+    }
+
+    /// The Y position of this plane's destination rectangle within the CRTC (`crtc_y`).
+    fn crtc_y(&self) -> i32 {
+        self.as_raw().crtc_y
+    }
+
+    /// The cursor hotspot X offset (`hotspot_x`), for a virtualized cursor plane.
+    fn hotspot_x(&self) -> i32 {
+        self.as_raw().hotspot_x
+    }
+
+    /// The cursor hotspot Y offset (`hotspot_y`), for a virtualized cursor plane.
+    fn hotspot_y(&self) -> i32 {
+        self.as_raw().hotspot_y
+    }
+
     /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
     fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
     where
-- 
2.55.0

