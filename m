Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87798C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D331F10F601;
	Fri,  3 Jul 2026 03:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="fE0Uw2/G";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BDB10F607
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493bab44440so355825e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047726; x=1783652526;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwRdstWb2Ca9k/qyCFyUDUWmOvWt84KgtkInv8204cw=;
 b=fE0Uw2/GYHEYj0zYdS/9X2ZKVgo36XFRHbDqIhj/QkNKVGWrQ7tZVv3A3REivspr79
 UEGxNh9Odc80OWPng2wvVLugDXnreAXrhqyYvuNqDjHmIMlONqDl3lK5woXOZLeK/bUp
 rNTtvRo7f1AlyMIj4smH3JxYeyCEtbnaN01bEPikGB1Uzg77h5JOkqBmCLZUR6PVgnbe
 r+I1d3kBg6OZVx7/blthRfucCX5nXoPnCWYZ1ueCtIHjw8TXc9aXbudXBDmaSMvNWNRx
 nLiwJ4H6nR/AHxQUS2015kKb8lz1F+cm5KmihIIJcJ35BjkVfYCXIDO1yz4xFn/iMDD9
 EmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047726; x=1783652526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwRdstWb2Ca9k/qyCFyUDUWmOvWt84KgtkInv8204cw=;
 b=daJRz0xHvE71qyIRJVG+nmP9ut3nB7BCxXl2AaW9+ZcMHZnROhBOR1IJJXWaVQZe8+
 0SRORw/ijVjGpDeXt6lZ1tNNWoTjtDglx+ExU9SyEA6f00tUl86z5vL9bCmlqjnS9UdH
 4la3/9DiVJHTTHj1vRHLnXD1xFdOs0qFAFhmVsyfXsFZ8y/xk7CTUP5WmqBIvhZBzrjO
 ZFgaHBC3N/ysPkZZYisK+vxBPJ6sMKv4jKzgL3mn6yOjx3Ld/74jxu2HlWtyEV9KM4T0
 OXLXh4gMNDDBNFcNkcRc/MCHpFscG07pYgKCtSJxwpWjMY3LaS7lXfwSovFvHoZIASFx
 3ZlA==
X-Gm-Message-State: AOJu0YxRNnu/yBLdSnYL2k96U7NMp9cHF5eA1FgMYqeYWagmJHH7Czvx
 fRdMX5WciS41eC5GOv+F5x9U4MPDHe9W6r1BcK8xQTlI8oWucn9KZffwymmQ2cOMng==
X-Gm-Gg: AfdE7ckkESByPLyc0VyPZFJyVZjyDYVsdgOkxKbx/uYHIqVTDTDzCf0uJy0uTCWOv67
 SanioaQzUI4ZtVZbSQ1JtJhvMiQkb3ycGfaEgnk9cuBhYtbWobtSQG8J0/QBHE5fZSVw2vzndw5
 xjoscaqlDgnyNI8vB7paEFVcfJm1T7tw4ZssnwedFvDx9k+GUp27Dt409g/uoNleuLAsuG9pm6T
 CKJXlmB2UHLdjqloB+s/lwRWVUdKqhr8OJ7JAdI2HSfVuvbNsNLg4FwfCl7lHsQhhJdNi1wlllk
 bWOMg5ry1vd+ddUYaMDYpJ5983TcjVTUIexpOpyDtlekuCBKTriuI2vKBCgQ/8v18iKSc3mtgp0
 bExb8tMpPNBclYR59JQ7J1caXbP9JN+JL/el/QmGoKoEm64dwdbh6VUBRSxxBr5Fa6IZMnAEtRM
 QCrProyzq74Jb29dflwX+AwU6T+ZkRPFDY0G5xuPWaduQw6UqDYXnCW8+n
X-Received: by 2002:a05:600c:34ca:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-493c9b4d759mr26290045e9.5.1783047726415; 
 Thu, 02 Jul 2026 20:02:06 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/18] rust: add sysfs device attribute groups
Date: Fri,  3 Jul 2026 04:01:01 +0100
Message-ID: <20260703030123.2814-15-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

A driver that exposes control files under sysfs -- for instance DisplayLink's
evdi, whose /sys/devices/evdi/{count,add,remove_all} files let the daemon create
and destroy virtual display cards -- had no safe way to do so from Rust.

Add a sysfs module: a driver implements DeviceAttributes (an ATTRS list plus
show()/store(), dispatched by attribute name) for the type it stores as a
device's driver data, and AttributeGroup::register_root() creates a standalone
root device (root_device_register(), under /sys/devices/<name>) hosting the
files. Reads and writes trampoline to show()/store() with the driver data
recovered from the device; the file mode (Attr::ro/wo/rw) gates access. The group
removes the files, reclaims the driver data and unregisters the device on drop.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/lib.rs   |   1 +
 rust/kernel/sysfs.rs | 245 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)
 create mode 100644 rust/kernel/sysfs.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8baa13079071..13729ec06333 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -128,6 +128,7 @@
 pub mod std_vendor;
 pub mod str;
 pub mod sync;
+pub mod sysfs;
 pub mod task;
 pub mod time;
 pub mod tracepoint;
diff --git a/rust/kernel/sysfs.rs b/rust/kernel/sysfs.rs
new file mode 100644
index 000000000000..f6df17c5013d
--- /dev/null
+++ b/rust/kernel/sysfs.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Sysfs device attributes.
+//!
+//! A driver can expose a set of named sysfs files on a device by implementing [`DeviceAttributes`]
+//! for the type it stores as that device's driver data, and registering an [`AttributeGroup`].
+//! Reads and writes are dispatched by attribute name to the type's [`show`](DeviceAttributes::show)
+//! and [`store`](DeviceAttributes::store) methods; the file mode (see [`Attr`]) controls which are
+//! reachable from userspace.
+//!
+//! [`AttributeGroup::register_root`] additionally creates a standalone "root" device
+//! (`root_device_register()`, appearing under `/sys/devices/<name>`) to host the group -- the shape
+//! DisplayLink's evdi uses for its `add`/`remove`/`count` control files.
+//!
+//! C headers: [`include/linux/sysfs.h`](srctree/include/linux/sysfs.h),
+//! [`include/linux/device.h`](srctree/include/linux/device.h)
+
+use crate::{
+    bindings,
+    error::{from_err_ptr, to_result},
+    page::PAGE_SIZE,
+    prelude::*,
+    types::ForeignOwnable,
+    ThisModule,
+};
+
+/// Definition of one sysfs attribute file: its name and permission mode (e.g. `0o444` read-only,
+/// `0o200` write-only, `0o644` read-write).
+pub struct Attr {
+    /// The file name.
+    pub name: &'static CStr,
+    /// The permission bits (`umode_t`).
+    pub mode: u16,
+}
+
+impl Attr {
+    /// A read-only (`0o444`) attribute.
+    pub const fn ro(name: &'static CStr) -> Self {
+        Self { name, mode: 0o444 }
+    }
+    /// A write-only (`0o200`) attribute.
+    pub const fn wo(name: &'static CStr) -> Self {
+        Self { name, mode: 0o200 }
+    }
+    /// A read-write (`0o644`) attribute.
+    pub const fn rw(name: &'static CStr) -> Self {
+        Self { name, mode: 0o644 }
+    }
+}
+
+/// The show/store behaviour of a device's sysfs attribute group.
+///
+/// Implemented by the type a device stores as its driver data. A shared reference to it is handed
+/// to [`show`](Self::show)/[`store`](Self::store), dispatched by the attribute `name`.
+pub trait DeviceAttributes: Send + Sync + 'static {
+    /// The attributes exposed by this group.
+    const ATTRS: &'static [Attr];
+
+    /// Handle a read of attribute `name`, writing up to one page into `buf` and returning the
+    /// number of bytes written. Only called for readable (`ro`/`rw`) attributes.
+    fn show(&self, name: &CStr, buf: &mut [u8]) -> Result<usize> {
+        let _ = (name, buf);
+        Err(EINVAL)
+    }
+
+    /// Handle a write of `buf` to attribute `name`. Only called for writable (`wo`/`rw`)
+    /// attributes.
+    fn store(&self, name: &CStr, buf: &[u8]) -> Result {
+        let _ = (name, buf);
+        Err(EINVAL)
+    }
+}
+
+/// A registered sysfs attribute group hosted on a `root_device_register()` device.
+///
+/// Dropping it removes the files, reclaims the driver data, and unregisters the root device.
+pub struct AttributeGroup<T: DeviceAttributes> {
+    root: *mut bindings::device,
+    /// Backing storage for the `device_attribute`s handed to `device_create_file()`; must stay
+    /// alive (and not move) for as long as the files exist, so it lives in this heap allocation.
+    attrs: KVec<bindings::device_attribute>,
+    _p: core::marker::PhantomData<T>,
+}
+
+// SAFETY: the root device and its attributes are internally synchronized by the driver core; `T`
+// is `Send + Sync`.
+unsafe impl<T: DeviceAttributes> Send for AttributeGroup<T> {}
+// SAFETY: see `Send`.
+unsafe impl<T: DeviceAttributes> Sync for AttributeGroup<T> {}
+
+impl<T: DeviceAttributes> AttributeGroup<T> {
+    /// # Safety
+    /// `dev`'s driver data is a live `T` set via [`device::Device::set_drvdata`].
+    unsafe extern "C" fn show_trampoline(
+        dev: *mut bindings::device,
+        attr: *mut bindings::device_attribute,
+        buf: *mut crate::ffi::c_char,
+    ) -> isize {
+        // SAFETY: `dev` is a valid device with `T` driver data (invariant of `register_root`).
+        let ctx = unsafe { borrow_ctx::<T>(dev) };
+        // SAFETY: the attribute name is a valid C string for the callback's duration.
+        let name = unsafe { as_cstr((*attr).attr.name) };
+        // SAFETY: sysfs guarantees `buf` is a writable page.
+        let slice = unsafe { core::slice::from_raw_parts_mut(buf.cast::<u8>(), PAGE_SIZE) };
+        match T::show(ctx, name, slice) {
+            Ok(n) => core::cmp::min(n, PAGE_SIZE) as isize,
+            Err(e) => e.to_errno() as isize,
+        }
+    }
+
+    /// # Safety
+    /// `dev`'s driver data is a live `T` set via [`device::Device::set_drvdata`].
+    unsafe extern "C" fn store_trampoline(
+        dev: *mut bindings::device,
+        attr: *mut bindings::device_attribute,
+        buf: *const crate::ffi::c_char,
+        count: usize,
+    ) -> isize {
+        // SAFETY: as in `show_trampoline`.
+        let ctx = unsafe { borrow_ctx::<T>(dev) };
+        // SAFETY: the attribute name is a valid C string for the callback's duration.
+        let name = unsafe { as_cstr((*attr).attr.name) };
+        // SAFETY: sysfs guarantees `buf` holds `count` readable bytes.
+        let slice = unsafe { core::slice::from_raw_parts(buf.cast::<u8>(), count) };
+        match T::store(ctx, name, slice) {
+            Ok(()) => count as isize,
+            Err(e) => e.to_errno() as isize,
+        }
+    }
+
+    fn make_attr(a: &Attr) -> bindings::device_attribute {
+        let mut da: bindings::device_attribute = bindings::device_attribute::default();
+        da.attr.name = a.name.as_char_ptr();
+        da.attr.mode = a.mode;
+        da.__bindgen_anon_1.show = Some(Self::show_trampoline);
+        da.__bindgen_anon_2.store = Some(Self::store_trampoline);
+        da
+    }
+
+    /// Create a root device named `name` and expose `T`'s attributes on it.
+    ///
+    /// `T` becomes the device's driver data; the attribute callbacks recover it by name-dispatch.
+    pub fn register_root(
+        name: &CStr,
+        module: &'static ThisModule,
+        ctx: impl PinInit<T, Error>,
+    ) -> Result<KBox<Self>> {
+        // Build the attribute array up front (no external resources yet, so a failure here needs
+        // no cleanup).
+        let mut attrs: KVec<bindings::device_attribute> =
+            KVec::with_capacity(T::ATTRS.len(), GFP_KERNEL)?;
+        for a in T::ATTRS {
+            attrs.push(Self::make_attr(a), GFP_KERNEL)?;
+        }
+        // Box the context; its foreign pointer becomes the device's driver data.
+        let ctx_ptr = KBox::pin_init(ctx, GFP_KERNEL)?.into_foreign();
+
+        // SAFETY: `name` is a valid C string; `module` is this module.
+        let root = match from_err_ptr(unsafe {
+            bindings::__root_device_register(name.as_char_ptr(), module.as_ptr())
+        }) {
+            Ok(r) => r,
+            Err(e) => {
+                // Reclaim the context box we have not attached anywhere yet.
+                // SAFETY: `ctx_ptr` came from `into_foreign()` above and was not consumed.
+                drop(unsafe { <Pin<KBox<T>> as ForeignOwnable>::from_foreign(ctx_ptr) });
+                return Err(e);
+            }
+        };
+        // SAFETY: `root` is a freshly-registered, valid device; `ctx_ptr` is its driver data now.
+        unsafe { bindings::dev_set_drvdata(root, ctx_ptr) };
+
+        // Register each file against its stable slot in `attrs`.
+        for da in attrs.iter() {
+            if let Err(e) = to_result(unsafe { bindings::device_create_file(root, da) }) {
+                // `root_device_unregister` (device_del) removes any files created so far;
+                // reclaim the context box first.
+                Self::teardown(root);
+                return Err(e);
+            }
+        }
+
+        match KBox::new(
+            Self {
+                root,
+                attrs,
+                _p: core::marker::PhantomData,
+            },
+            GFP_KERNEL,
+        ) {
+            Ok(group) => Ok(group),
+            Err(e) => {
+                Self::teardown(root);
+                Err(e.into())
+            }
+        }
+    }
+
+    /// Reclaim the driver-data box and unregister the root device (which removes its files).
+    fn teardown(root: *mut bindings::device) {
+        // SAFETY: `root` is a valid registered device whose driver data is a `Pin<KBox<T>>` (or
+        // NULL); `dev_get_drvdata` returns the pointer stashed in `register_root`.
+        let ptr = unsafe { bindings::dev_get_drvdata(root) };
+        if !ptr.is_null() {
+            // SAFETY: `ptr` came from `Pin::<KBox<T>>::into_foreign`.
+            drop(unsafe { <Pin<KBox<T>> as ForeignOwnable>::from_foreign(ptr) });
+        }
+        // SAFETY: `root` was created by `__root_device_register` and not yet unregistered.
+        unsafe { bindings::root_device_unregister(root) };
+    }
+}
+
+impl<T: DeviceAttributes> Drop for AttributeGroup<T> {
+    fn drop(&mut self) {
+        for da in self.attrs.iter() {
+            // SAFETY: each `da` was passed to `device_create_file` on `self.root` and not removed
+            // since.
+            unsafe { bindings::device_remove_file(self.root, da) };
+        }
+        // Reclaim the driver-data box and unregister the root device.
+        Self::teardown(self.root);
+    }
+}
+
+/// Borrow the `T` driver data of the device `ptr`.
+///
+/// # Safety
+/// `ptr` is a valid `struct device` whose driver data is a `Pin<KBox<T>>` stashed by
+/// [`AttributeGroup::register_root`], valid for the returned reference's lifetime.
+unsafe fn borrow_ctx<'a, T>(ptr: *mut bindings::device) -> &'a T {
+    // SAFETY: `ptr` is a valid device by the contract.
+    let data = unsafe { bindings::dev_get_drvdata(ptr) };
+    // SAFETY: `data` is the pointer `Pin<KBox<T>>::into_foreign` returned, i.e. a valid `*mut T`
+    // live for the borrow.
+    unsafe { &*(data as *const T) }
+}
+
+/// # Safety
+/// `ptr` is a valid, NUL-terminated C string for the returned reference's lifetime.
+#[inline]
+unsafe fn as_cstr<'a>(ptr: *const crate::ffi::c_char) -> &'a CStr {
+    // SAFETY: by the contract, `ptr` is a valid NUL-terminated C string. `crate::ffi::c_char` is
+    // `u8` while `core::ffi::CStr::from_ptr` takes `*const i8`, so cast the pointer.
+    unsafe { CStr::from_ptr(ptr.cast()) }
+}
-- 
2.55.0

