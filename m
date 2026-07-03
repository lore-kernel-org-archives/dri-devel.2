Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4031C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 568D610F606;
	Fri,  3 Jul 2026 03:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="GNIHIMT7";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A6E10F606
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:05 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47362928f65so96885f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047724; x=1783652524;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=031sIZWe4JTCBupEXr5DXAC9PJaWSnyeiEEKJDEA+7w=;
 b=GNIHIMT7K9OwD4WHeazXFcqwIIYiKIaHqQfZJfa+5UzT8+2Gbr/KhGRLRSEoGDpXdk
 a6r2kx7mZ5bwt3LeTUe1+ACtW9Ai7AA5qrL7Acjw7MTtBBQ58oIfg03ZXHulSds70qhf
 6w3I7XEqH/bG/SlbrlvzQJTCiU6SwAyC4OJKJCD97fd3qROy1eH8sHIqTEszs9zDS0n8
 qA9PeOZgos4lg2Z+seilePhlOPtDEOBQ6mfiwn8mX4OqkEr/lGjqplo6TYaeEK5KZird
 eQ6eodkPYYTcYqhPzvaYVdLOVf/CW86SuYzv0sGRJx+5ME1IF+l0/ane4nUfqslIviOW
 oV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047724; x=1783652524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=031sIZWe4JTCBupEXr5DXAC9PJaWSnyeiEEKJDEA+7w=;
 b=WrtxKZHnjhlSG9FWnffmn+XRBY8GNowQwPZ+M98ajcc+XyeiEscsrIr/QloK8cYzUP
 QbwoHYOEJ/gOXyqoqEN6lCERP5ngC4FLE92N66zPvLC/wz8wi6wYse0u+XgOHKUbxYFd
 JYwVIgd3tYuG5Z+JFybEqpeCXNY/DAIhP/frNUTndEC71XF15w3OidDb2ZJPGGlkvwkB
 6qlMpDu08C+M44Czc4O6Arax4rRA7uMW2ZdJmG179hEGHWFy5yicdShj+GyFQBCUuaKR
 CHhLBt9/kN5aAXK6nvgHlDuSb9n8v6uofB7/8VQfaKW0PKhDTvKP0+sklt40zZHcwCkf
 8l7g==
X-Gm-Message-State: AOJu0Yz/sig2eFJB9mrcSrsNMIrELDIPT1yXkEElkCNRxmQVJRKGZL53
 TK+ZT27LLuju50SIdWs5EF9TxextmcE7haq+Od7NOkHM72yUcmuDjtH1TNbrJ/SdRQ==
X-Gm-Gg: AfdE7clKvAQ15BvRSv2l9dqXoqYnypn35O0BzjAnblONuRTsLR7davFBST98mDsPheS
 63Sj7QOezcNSmdkXlR6HvgAzUkH/JZaD9eaI/GziOmtn9LCFeMj6cqWWMfNZCKR36U05OSQ27Qy
 KnHwnJOagQMSnmd1nzN3+SLG8I2voD4YIpgt6EBVTcKtg0xhRPV1j3fl+6cWTw73PpQWJtWye8Q
 bjai6PJe8j5TeHzch8hwaAyYMq9/eS2riKvi69Y62qp6XsBt7+i8mw7EZOj2vpgeuv9AfvjIjMl
 R023U6QNsCkslqHCPiJBPrN5U9WAnPF6qPj/BNjesOi1gsXjXaKW6E2WjybFsJrKiLqYDdR/kTk
 VyH2JFeMlptmJYaXFbQ63KEvGFpC8lzZ/wBJNaUzkk/f9o2XGxGmGOFZsNKbdjWz9Twis1UvRev
 O7ZP6ArnDDscbgzwE5dRCIynPh8hjo5VyCJTVeR0frCs2c08Htgq0RMGzpinabuXIBRdk=
X-Received: by 2002:a5d:50c9:0:b0:475:5e4b:588f with SMTP id
 ffacd0b85a97d-4775a2eff42mr10021826f8f.16.1783047724132; 
 Thu, 02 Jul 2026 20:02:04 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/18] rust: i2c: add adapter-provider (bus controller)
 registration
Date: Fri,  3 Jul 2026 04:01:00 +0100
Message-ID: <20260703030123.2814-14-mike@fireburn.co.uk>
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

The I2C abstraction can register an I2C *client* driver (i2c::Driver), but not
provide a bus. A driver that presents a virtual I2C bus and services the
transfers itself -- e.g. DisplayLink's evdi, which exposes a DDC/CI channel so
userspace monitor-control tools can reach the display -- needs the controller
side.

Add i2c::BusController (a trait with master_xfer/functionality over a
driver-supplied Context) and i2c::BusAdapter, which fills a struct i2c_adapter
whose i2c_algorithm dispatches to the trait via trampolines, calls
i2c_add_adapter() on creation and i2c_del_adapter() on drop. i2c::Msg is a
#[repr(transparent)] view over struct i2c_msg exposing addr/flags/is_read and
the payload as a (mutable) byte slice, so a transfer routine needs no unsafe.
FUNC_I2C is exported for the common functionality() return.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/i2c.rs | 192 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0..5cde59a3ce46 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -601,3 +601,195 @@ unsafe impl Send for Registration {}
 // SAFETY: `Registration` offers no interior mutability (no mutation through &self
 // and no mutable access is exposed)
 unsafe impl Sync for Registration {}
+
+// ===========================================================================
+// I2C adapter (bus controller / provider) side
+// ===========================================================================
+
+/// A single I2C message presented to a [`BusController`]'s transfer routine.
+///
+/// Wraps a `struct i2c_msg`; `#[repr(transparent)]` so a C `i2c_msg` array can be viewed directly
+/// as a `[Msg]`.
+#[repr(transparent)]
+pub struct Msg(Opaque<bindings::i2c_msg>);
+
+impl Msg {
+    /// The 7-bit (or 10-bit) target address.
+    #[inline]
+    pub fn addr(&self) -> u16 {
+        // SAFETY: `self.0` is a valid `i2c_msg` for the callback's duration.
+        unsafe { (*self.0.get()).addr }
+    }
+
+    /// The message flags (`I2C_M_*`).
+    #[inline]
+    pub fn flags(&self) -> u16 {
+        // SAFETY: as above.
+        unsafe { (*self.0.get()).flags }
+    }
+
+    /// Whether this is a read (`I2C_M_RD`) rather than a write.
+    #[inline]
+    pub fn is_read(&self) -> bool {
+        self.flags() & (bindings::I2C_M_RD as u16) != 0
+    }
+
+    /// The message length in bytes.
+    #[inline]
+    pub fn len(&self) -> usize {
+        // SAFETY: as above.
+        unsafe { (*self.0.get()).len as usize }
+    }
+
+    /// Whether the message is empty.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// The message payload of a write, as a read-only slice.
+    #[inline]
+    pub fn buf(&self) -> &[u8] {
+        // SAFETY: `buf` points to `len` bytes valid for the callback's duration.
+        unsafe { core::slice::from_raw_parts((*self.0.get()).buf, self.len()) }
+    }
+
+    /// The message buffer of a read, as a mutable slice to fill with the reply.
+    #[inline]
+    pub fn buf_mut(&mut self) -> &mut [u8] {
+        // SAFETY: `buf` points to `len` writable bytes valid for the callback's duration.
+        unsafe { core::slice::from_raw_parts_mut((*self.0.get()).buf, self.len()) }
+    }
+}
+
+/// `I2C_FUNC_I2C`: the adapter supports plain I2C (not just SMBus) transfers.
+pub const FUNC_I2C: u32 = bindings::I2C_FUNC_I2C;
+
+/// A Rust-implemented I2C bus adapter (the controller/provider side).
+///
+/// This is the counterpart to the [`Driver`] trait above: rather than binding to an I2C client on
+/// an existing bus, an implementer *is* a bus and services transfers. Virtual buses -- e.g. the
+/// DDC/CI channel DisplayLink's evdi exposes so userspace monitor-control tools can reach the
+/// display -- use this.
+pub trait BusController: 'static {
+    /// Per-adapter driver context, made available to the transfer callbacks.
+    type Context: Send + Sync;
+
+    /// Transfer `msgs` on the bus, returning the number of messages successfully transferred
+    /// (as the C `master_xfer` does), or an error.
+    fn master_xfer(ctx: &Self::Context, msgs: &mut [Msg]) -> Result<usize>;
+
+    /// Report the bus functionality bitmask (`I2C_FUNC_*`).
+    fn functionality(ctx: &Self::Context) -> u32;
+}
+
+/// An owned, registered I2C adapter driven by a [`BusController`].
+///
+/// [`BusAdapter::new`] fills a `struct i2c_adapter` (pointing its algorithm at trampolines that
+/// dispatch to `T`) and calls `i2c_add_adapter()`; dropping it calls `i2c_del_adapter()`.
+#[pin_data(PinnedDrop)]
+pub struct BusAdapter<T: BusController> {
+    #[pin]
+    adapter: Opaque<bindings::i2c_adapter>,
+    #[pin]
+    algo: Opaque<bindings::i2c_algorithm>,
+    ctx: T::Context,
+    registered: core::sync::atomic::AtomicBool,
+}
+
+// SAFETY: the adapter is internally synchronized by the I2C core; `ctx` is `Send + Sync`.
+unsafe impl<T: BusController> Send for BusAdapter<T> {}
+// SAFETY: see `Send`.
+unsafe impl<T: BusController> Sync for BusAdapter<T> {}
+
+impl<T: BusController> BusAdapter<T> {
+    /// # Safety
+    /// `adap` is a valid adapter whose `algo_data` points to a live `T::Context`.
+    unsafe extern "C" fn xfer_trampoline(
+        adap: *mut bindings::i2c_adapter,
+        msgs: *mut bindings::i2c_msg,
+        num: crate::ffi::c_int,
+    ) -> crate::ffi::c_int {
+        // SAFETY: by the invariant established in `new`, `algo_data` points to the `T::Context`.
+        let ctx = unsafe { &*((*adap).algo_data as *const T::Context) };
+        // SAFETY: the I2C core passes `num` valid `i2c_msg`s; `Msg` is `#[repr(transparent)]`.
+        let slice = unsafe { core::slice::from_raw_parts_mut(msgs.cast::<Msg>(), num as usize) };
+        match T::master_xfer(ctx, slice) {
+            Ok(n) => n as crate::ffi::c_int,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// `adap` is a valid adapter whose `algo_data` points to a live `T::Context`.
+    unsafe extern "C" fn func_trampoline(adap: *mut bindings::i2c_adapter) -> u32 {
+        // SAFETY: by the invariant established in `new`, `algo_data` points to the `T::Context`.
+        let ctx = unsafe { &*((*adap).algo_data as *const T::Context) };
+        T::functionality(ctx)
+    }
+
+    /// Create and register a new I2C adapter named `name`, parented to `parent`, with driver
+    /// context `ctx`.
+    pub fn new(
+        name: &CStr,
+        parent: &device::Device,
+        ctx: T::Context,
+    ) -> Result<Pin<KBox<Self>>> {
+        let this = KBox::try_pin_init(
+            try_pin_init!(Self {
+                adapter <- Opaque::ffi_init(|slot: *mut bindings::i2c_adapter| {
+                    // SAFETY: `slot` is valid, uninitialized storage; a zeroed adapter is a valid
+                    // starting point (self-referential fields are set below, after pinning).
+                    unsafe { *slot = bindings::i2c_adapter::default() };
+                }),
+                algo <- Opaque::ffi_init(|slot: *mut bindings::i2c_algorithm| {
+                    // SAFETY: `slot` is valid, uninitialized storage.
+                    unsafe {
+                        *slot = bindings::i2c_algorithm::default();
+                        (*slot).__bindgen_anon_1.master_xfer = Some(Self::xfer_trampoline);
+                        (*slot).functionality = Some(Self::func_trampoline);
+                    }
+                }),
+                ctx: ctx,
+                registered: core::sync::atomic::AtomicBool::new(false),
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // `this` now has a stable address; wire the self-referential adapter fields and register.
+        let adap = this.adapter.get();
+        // Copy the name without its NUL into the fixed 48-byte array (capped at 47 so the
+        // already-zeroed array stays NUL-terminated even if the name is over-long).
+        let name_bytes = name.to_bytes();
+        let n = core::cmp::min(name_bytes.len(), 47);
+        // SAFETY: `adap`/`algo`/`ctx` live for `this`'s (pinned) lifetime; `name_bytes` is valid
+        // for `n <= 47` bytes; `parent` is a valid device.
+        unsafe {
+            (*adap).algo = this.algo.get();
+            (*adap).algo_data = (&this.ctx as *const T::Context).cast_mut().cast();
+            core::ptr::copy_nonoverlapping(
+                name_bytes.as_ptr(),
+                (*adap).name.as_mut_ptr().cast::<u8>(),
+                n,
+            );
+            (*adap).dev.parent = parent.as_raw();
+        }
+
+        // SAFETY: `adap` is a fully-initialized adapter.
+        to_result(unsafe { bindings::i2c_add_adapter(adap) })?;
+        this.registered
+            .store(true, core::sync::atomic::Ordering::Release);
+        Ok(this)
+    }
+}
+
+#[pinned_drop]
+impl<T: BusController> PinnedDrop for BusAdapter<T> {
+    fn drop(self: Pin<&mut Self>) {
+        if self.registered.load(core::sync::atomic::Ordering::Acquire) {
+            // SAFETY: the adapter was successfully registered with `i2c_add_adapter` and has not
+            // been deleted yet.
+            unsafe { bindings::i2c_del_adapter(self.adapter.get()) };
+        }
+    }
+}
-- 
2.55.0

