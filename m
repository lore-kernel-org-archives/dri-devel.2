Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57708C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64F910F619;
	Fri,  3 Jul 2026 03:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="h8URsLsm";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B36910F61A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:59 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4629051c946so47188f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047778; x=1783652578;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd9riX2bySBqO74qeyGz+OA/pHdGADSq9oSEOnCfq4o=;
 b=h8URsLsmPP8w3OmcIXpWDIDCwDYtXlF2eoZyLT7vP5sZpig0eSKXUsm0A85zxj53EB
 tK33mdqKnIhOQTxjREC7IVnrYURodbU8+cO8ZqdZYCn0oPoMKaslMi6+glXxM7kE2q/R
 /JVPALyDb6OWHYzPGDS6JKGHtVVkdzAhGrKEt3YIwLzwi5Vy1n1ShqyG2rl5XpTkcxRU
 hRoKNH4RuZvYjsFcrc4G0rrFdZf4aDqVnLr+XDawVXlAZfNz52rGxlUNphlZ3T4CFlmu
 0MxXHE0CldYgquiCr+gfeutMqPnrfs6as9AcU9Z0qOmE3/iChhAxx5XKEGLeN2YP2bsF
 yFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047778; x=1783652578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fd9riX2bySBqO74qeyGz+OA/pHdGADSq9oSEOnCfq4o=;
 b=L65WTrinxN0bE/kyU8GgaYm7KhJSzL3huXtVd3xBNU+te5hgJJJbhObKZVxvUwBbRW
 J4Bo7AuedsTEWoEzTKSLTz8IpGsyO/pLcq5vNgL0/XlKmuLzGLNxH2lOBwNRwkYb01Gn
 u97rNreE23absgOqAOx5Oy8lPo0p8FcKOngpcwNOApDgizHBmvUJcbj4h/8Yln/+mfgU
 G8LA7MEix1utX8AqimIIlAPigIO55xPy1o+LWGDBM+wrPlMOmh9YgyysaGH26ynOYsCW
 BM5yS6J9y3lYTJqXFlmCgawU4Ld2iDdQdJVer5oMwQbdqBUbXe6JQ1HY9jYK5iCCPTsS
 KIkQ==
X-Gm-Message-State: AOJu0Yyylu2O16ILzR/5nIyXuOSjOEJ6DWjDDZ13BqTyVuoQ6XBUxHAE
 XqUQwSJJr3pP2X24jG4V1TO8ASDv2WNayxVLG3AgImBHhHyBo4jsFTQzaxZciKOe4w==
X-Gm-Gg: AfdE7ck4vdZaU5tottzlzmq8Yt6egoiiB7Zob02g0KBGmW1QzAtZsp6J6pB0VMWJEkF
 I+/ENfBvZx3+nicaS/mPwtihbsVK2vglsyXon/s37FokN4FLufE6ff4fMdpaIWN/5f0fvWqs3DI
 It6Oy7tJEaqYiPsOrNH6ELEUDAeL1uFfN30FDaqHcE5Q11oeqLqRViiYQHOPOd9weAcmsvur8mT
 dw5qnzVm+39JXjAF+wJHfIGhUPwVvBRcv1uuxqYh+SVket7jzNzlx29hXjUJwNeKHiwKfx00pzT
 0FBAFZ106KUl1LwDVjfFm0rI4+deKi0io+/bb6Fe3DDx3e8sdVa6O6J3UHa64f4TVbzhHuTU8Mr
 qZkPh0Gk4XyjENYnvUnsowqe6uNt12eV/yHkNccTqkOAE50hAnUhRm92ahR8Qpe/ol7eTWlM1d4
 V6VqVuY3xY/YH5j5D1fprVXpIBBWsFQ8ZH7g9hGLzJrVTHhxevXv+5vq+cIUOcINndnoU=
X-Received: by 2002:a05:6000:41e2:b0:478:3df9:5d8c with SMTP id
 ffacd0b85a97d-479343d1d56mr3615379f8f.2.1783047776586; 
 Thu, 02 Jul 2026 20:02:56 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde1a4fdsm15198199f8f.26.2026.07.02.20.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:55 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH 2/2] drm/evdi: add the Rust EVDI virtual-display driver
Date: Fri,  3 Jul 2026 04:02:47 +0100
Message-ID: <20260703030249.2949-3-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030249.2949-1-mike@fireburn.co.uk>
References: <20260703030249.2949-1-mike@fireburn.co.uk>
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

A from-scratch Rust reimplementation of DisplayLink's EVDI kernel module: a
virtual DRM/KMS display whose framebuffer is pulled by a userspace client
(DisplayLinkManager via libevdi) rather than scanned out to local hardware.

The driver registers a single-head atomic-KMS output with a primary and a
cursor plane, creates cards on demand through /sys/devices/evdi (optionally
bound to a USB dock so they appear and disappear with it), and exposes the
libevdi private ioctl ABI (CONNECT / REQUEST_UPDATE / GRABPIX /
DDCCI_RESPONSE / ENABLE_CURSOR_EVENTS) plus the drm_event output stream. GRABPIX
tracks FB_DAMAGE_CLIPS and hands back only the changed rectangles per frame. It
identifies itself to userspace as "evdi" for compatibility with the existing
libevdi / DisplayLinkManager stack.

Built on the safe KMS mode-object layer; consumes the binding fixes/helpers in
the preceding patch. It is a real file tree under drivers/gpu/drm/evdi/ and also
maintained as the standalone "revdi" project.

NOT FOR UPSTREAM SUBMISSION as posted -- it depends on the not-yet-merged Rust
DRM/KMS bindings and is carried here for local integration.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 drivers/gpu/drm/Kconfig         |   2 +
 drivers/gpu/drm/Makefile        |   1 +
 drivers/gpu/drm/evdi/Kconfig    |  20 +
 drivers/gpu/drm/evdi/Makefile   |   2 +
 drivers/gpu/drm/evdi/ddcci.rs   |  43 ++
 drivers/gpu/drm/evdi/evdi.rs    | 405 ++++++++++++++++++
 drivers/gpu/drm/evdi/ioctl.rs   | 248 +++++++++++
 drivers/gpu/drm/evdi/kms.rs     | 729 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/evdi/painter.rs | 199 +++++++++
 drivers/gpu/drm/evdi/uapi.rs    | 210 +++++++++
 10 files changed, 1859 insertions(+)
 create mode 100644 drivers/gpu/drm/evdi/Kconfig
 create mode 100644 drivers/gpu/drm/evdi/Makefile
 create mode 100644 drivers/gpu/drm/evdi/ddcci.rs
 create mode 100644 drivers/gpu/drm/evdi/evdi.rs
 create mode 100644 drivers/gpu/drm/evdi/ioctl.rs
 create mode 100644 drivers/gpu/drm/evdi/kms.rs
 create mode 100644 drivers/gpu/drm/evdi/painter.rs
 create mode 100644 drivers/gpu/drm/evdi/uapi.rs

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8fb9c9f787ba..e855f6f7bced 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -362,6 +362,8 @@ source "drivers/gpu/drm/virtio/Kconfig"
 source "drivers/gpu/drm/vkms/Kconfig"
 source "drivers/gpu/drm/vmwgfx/Kconfig"
 source "drivers/gpu/drm/vino/Kconfig"
+
+source "drivers/gpu/drm/evdi/Kconfig"
 source "drivers/gpu/drm/xe/Kconfig"
 source "drivers/gpu/drm/xen/Kconfig"
 source "drivers/gpu/drm/xlnx/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 42a04359cc63..3f22c7131e51 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -186,6 +186,7 @@ obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VGEM)	+= vgem/
 obj-$(CONFIG_DRM_VKMS)	+= vkms/
 obj-$(CONFIG_DRM_VINO)	+= vino/
+obj-$(CONFIG_DRM_EVDI)	+= evdi/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 obj-$(CONFIG_DRM_NOVA) += nova/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
diff --git a/drivers/gpu/drm/evdi/Kconfig b/drivers/gpu/drm/evdi/Kconfig
new file mode 100644
index 000000000000..3177edc02dc5
--- /dev/null
+++ b/drivers/gpu/drm/evdi/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_EVDI
+	tristate "Extensible Virtual Display Interface (Rust)"
+	depends on DRM
+	depends on RUST
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	help
+	  Rust reimplementation of DisplayLink's EVDI: a virtual DRM/KMS display
+	  whose framebuffer is pulled by a userspace client (DisplayLinkManager
+	  via libevdi) rather than scanned out to local hardware. Cards are
+	  created on demand through /sys/devices/evdi and can be bound to a USB
+	  dock so they appear/disappear with it.
+
+	  The module identifies itself to userspace as "evdi" for compatibility
+	  with the existing libevdi / DisplayLinkManager stack.
+
+	  To compile this as a module, choose M here: the module is called evdi.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/drm/evdi/Makefile b/drivers/gpu/drm/evdi/Makefile
new file mode 100644
index 000000000000..9c5e1a66337c
--- /dev/null
+++ b/drivers/gpu/drm/evdi/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DRM_EVDI) += evdi.o
diff --git a/drivers/gpu/drm/evdi/ddcci.rs b/drivers/gpu/drm/evdi/ddcci.rs
new file mode 100644
index 000000000000..e12c919f82af
--- /dev/null
+++ b/drivers/gpu/drm/evdi/ddcci.rs
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// DDC/CI over a virtual I2C adapter. Monitor-control tools (ddcutil, the desktop brightness
+// slider, ...) issue I2C transfers to the DDC/CI address on the adapter EVDI registers; those are
+// forwarded to the DisplayLinkManager client as DDCCI_DATA events, and the client's reply comes
+// back through the DDCCI_RESPONSE ioctl (see `EvdiDrmData::ddcci_transfer`/`ddcci_respond`).
+
+use kernel::{i2c, prelude::*, sync::aref::ARef};
+
+use crate::kms::{EvdiDrmData, EvdiDrmDevice, DDCCI_ADDRESS};
+
+/// The EVDI DDC/CI I2C bus controller.
+pub(crate) struct EvdiI2c;
+
+impl i2c::BusController for EvdiI2c {
+    type Context = ARef<EvdiDrmDevice>;
+
+    fn master_xfer(dev: &ARef<EvdiDrmDevice>, msgs: &mut [i2c::Msg]) -> Result<usize> {
+        let ddev: &EvdiDrmDevice = dev;
+        let data: &EvdiDrmData = ddev;
+        let mut transferred = 0usize;
+        for msg in msgs.iter_mut() {
+            // Only DDC/CI traffic is forwarded to the client; ignore anything else on the bus.
+            if msg.addr() != DDCCI_ADDRESS {
+                continue;
+            }
+            let addr = msg.addr();
+            let flags = msg.flags();
+            let is_read = msg.is_read();
+            if data
+                .ddcci_transfer(ddev, addr, flags, is_read, msg.buf_mut())
+                .is_ok()
+            {
+                transferred += 1;
+            }
+        }
+        Ok(transferred)
+    }
+
+    fn functionality(_dev: &ARef<EvdiDrmDevice>) -> u32 {
+        i2c::FUNC_I2C
+    }
+}
diff --git a/drivers/gpu/drm/evdi/evdi.rs b/drivers/gpu/drm/evdi/evdi.rs
new file mode 100644
index 000000000000..735fa1cbefa3
--- /dev/null
+++ b/drivers/gpu/drm/evdi/evdi.rs
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! EVDI — Extensible Virtual Display Interface, Rust implementation.
+//!
+//! A from-scratch Rust rewrite of the DisplayLink `evdi` kernel module. It presents virtual DRM
+//! displays whose scanout is pulled by a userspace daemon (DisplayLinkManager) over a stable
+//! ioctl + `drm_event` ABI. The module name and that ABI are kept identical to the C driver so
+//! existing userspace (libevdi/DLM) keeps working unchanged.
+//!
+//! Structure:
+//! - [`uapi`]: the DLM-facing ABI ([`evdi_drm.h`] mirror).
+//! - [`kms`]: the DRM/KMS device (one virtual head, GEM-shmem dumb buffers).
+//! - [`painter`]: connection state + `drm_event` delivery.
+//! - [`ioctl`]: the five driver-private ioctls.
+//! - This file: the platform driver (one DRM card per `evdi` platform device) and the module.
+
+use kernel::{
+    device::{self, Core},
+    drm, platform,
+    prelude::*,
+    sync::{aref::ARef, new_mutex, Mutex},
+    types::Opaque,
+    ThisModule,
+};
+
+mod ddcci;
+mod ioctl;
+mod kms;
+mod painter;
+mod uapi;
+
+use kms::{EvdiDrmData, EvdiDrmDevice, EvdiDrmDriver};
+
+/// Per-bound-device data held by the platform driver: the registered DRM card, whose lifetime is
+/// otherwise tied to the bound platform device via devres. Dropped when the platform device unbinds.
+struct BoundData {
+    _ddev: Option<ARef<EvdiDrmDevice>>,
+    /// The DDC/CI virtual I2C adapter (dropped → `i2c_del_adapter` on unbind).
+    _i2c: Option<Pin<KBox<kernel::i2c::BusAdapter<ddcci::EvdiI2c>>>>,
+}
+
+/// The `evdi` platform driver. It binds to the `evdi` platform devices created by [`EvdiModule`]
+/// (and, later, by the sysfs `add` attribute) and registers a DRM/KMS card parented to each.
+struct EvdiPlatformDriver;
+
+impl platform::Driver for EvdiPlatformDriver {
+    type IdInfo = ();
+    type Data<'bound> = BoundData;
+
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        let cdev: &device::Device<Core<'_>> = pdev.as_ref();
+
+        // Allocate an unregistered DRM device parented to this platform device, wire up its KMS
+        // pipeline (`KmsDriver::probe` runs inside `UnregisteredDevice::new`), then register it and
+        // tie its lifetime to the bound platform device via devres.
+        let ddev: Option<ARef<EvdiDrmDevice>> =
+            match drm::UnregisteredDevice::<EvdiDrmDriver>::new(pdev, EvdiDrmData::new()) {
+                Ok(unreg) => match drm::driver::Registration::new_foreign_owned(unreg, cdev, (), 0)
+                {
+                    Ok(reg) => {
+                        dev_info!(cdev, "evdi: DRM/KMS card registered\n");
+                        Some(reg.into())
+                    }
+                    Err(e) => {
+                        dev_err!(cdev, "evdi: DRM registration failed ({e:?})\n");
+                        None
+                    }
+                },
+                Err(e) => {
+                    dev_err!(cdev, "evdi: DRM device allocation failed ({e:?})\n");
+                    None
+                }
+            };
+
+        // Register the DDC/CI virtual I2C adapter, parented to this platform device, so
+        // monitor-control tools can reach the display. Non-fatal.
+        let i2c =
+            ddev.as_ref().and_then(|d| {
+                match kernel::i2c::BusAdapter::<ddcci::EvdiI2c>::new(
+                    c"DisplayLink I2C Adapter",
+                    cdev,
+                    d.clone(),
+                ) {
+                    Ok(a) => Some(a),
+                    Err(e) => {
+                        dev_err!(
+                            cdev,
+                            "evdi: DDC/CI I2C adapter registration failed ({e:?})\n"
+                        );
+                        None
+                    }
+                }
+            });
+
+        Ok(BoundData {
+            _ddev: ddev,
+            _i2c: i2c,
+        })
+    }
+}
+
+/// One created card: its registered `evdi` platform device plus the USB device it was attached to
+/// (`null` for a generic, non-USB card). The USB pointer is only ever compared for equality (never
+/// dereferenced) — used to match the dock when it is unplugged (`USB_DEVICE_REMOVE`).
+struct CardEntry {
+    _dev: platform::RegisteredDevice,
+    usb: *mut kernel::bindings::usb_device,
+}
+
+// SAFETY: `usb` is only ever compared, never dereferenced; `RegisteredDevice` is itself `Send`.
+unsafe impl Send for CardEntry {}
+
+/// The device registry behind the sysfs control interface
+/// (`/sys/devices/evdi/{count,add,remove_all}`): the set of `evdi` platform devices created on
+/// demand by the DisplayLink daemon or udev. Stored as the sysfs root device's driver data.
+#[pin_data(PinnedDrop)]
+struct EvdiRegistry {
+    #[pin]
+    devices: Mutex<KVec<CardEntry>>,
+    /// USB-removal notifier. When the dock a card is attached to is unplugged, its DRM device would
+    /// otherwise linger — keeping the compositor's fds open and the module refcount pinned — so this
+    /// tears the card down. `container_of` recovers the `EvdiRegistry` in the callback; registered in
+    /// [`EvdiRegistry::new`], unregistered in the [`PinnedDrop`].
+    #[pin]
+    notifier: Opaque<kernel::bindings::notifier_block>,
+}
+
+// SAFETY: `notifier` is a `notifier_block` owned by the kernel's internally-synchronized USB notifier
+// chain once registered; we only touch it single-threaded (register in `new`, unregister in
+// `PinnedDrop`) and never mutate it otherwise. `devices` is mutex-guarded. So the registry is safe to
+// share and move across threads.
+unsafe impl Send for EvdiRegistry {}
+// SAFETY: See `Send`.
+unsafe impl Sync for EvdiRegistry {}
+
+/// USB notifier callback: on `USB_DEVICE_REMOVE`, tear down any card attached to the removed device.
+unsafe extern "C" fn usb_remove_notify(
+    nb: *mut kernel::bindings::notifier_block,
+    action: usize,
+    data: *mut core::ffi::c_void,
+) -> core::ffi::c_int {
+    if action as u32 == kernel::bindings::USB_DEVICE_REMOVE {
+        // SAFETY: `nb` is the `notifier` field of a live `EvdiRegistry` — registered in `new` and
+        // unregistered in `PinnedDrop` before the struct is freed, so the container is valid here.
+        let registry = unsafe {
+            &*kernel::container_of!(
+                nb.cast::<Opaque<kernel::bindings::notifier_block>>(),
+                EvdiRegistry,
+                notifier
+            )
+        };
+        registry.remove_usb(data as *mut kernel::bindings::usb_device);
+    }
+    kernel::bindings::NOTIFY_DONE as core::ffi::c_int
+}
+
+/// Maximum bus/port depth of a parsed `usb:` device address.
+const MAX_USB_ADDR: usize = 8;
+
+/// Scratch used to locate a USB device by its bus/port address while iterating `usb_for_each_dev`.
+struct UsbPath {
+    addr: [u32; MAX_USB_ADDR],
+    len: usize,
+    found: *mut kernel::bindings::usb_device,
+}
+
+/// `usb_for_each_dev` callback: match `data` (a [`UsbPath`]) against `usb`'s bus/port chain,
+/// walking parents leaf-first exactly like the C evdi. Stores the device and returns 1 on a match.
+unsafe extern "C" fn match_usb_path(
+    usb: *mut kernel::bindings::usb_device,
+    data: *mut core::ffi::c_void,
+) -> core::ffi::c_int {
+    // SAFETY: `usb_for_each_dev` is called below with a `&mut UsbPath` as `data` and passes a live
+    // `usb_device` for `usb`.
+    let m = unsafe { &mut *(data as *mut UsbPath) };
+    let mut pdev = usb;
+    let mut i = m.len as isize - 1;
+    while !pdev.is_null() && i >= 0 && (i as usize) < MAX_USB_ADDR {
+        // SAFETY: `pdev` walks the valid parent chain of a live `usb_device`.
+        let mut port = unsafe { (*pdev).portnum } as u32;
+        if port == 0 {
+            // SAFETY: a live `usb_device` always has a valid `bus`.
+            port = unsafe { (*(*pdev).bus).busnum } as u32;
+        }
+        if port != m.addr[i as usize] {
+            return 0;
+        }
+        // SAFETY: as above.
+        let parent = unsafe { (*pdev).parent };
+        if parent.is_null() && i == 0 {
+            m.found = usb;
+            return 1;
+        }
+        pdev = parent;
+        i -= 1;
+    }
+    0
+}
+
+impl EvdiRegistry {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            devices <- new_mutex!(KVec::new()),
+            notifier <- Opaque::ffi_init(|slot: *mut kernel::bindings::notifier_block| {
+                // SAFETY: `slot` is this field's stable final address. Fill in the callback and link
+                // it onto the USB notifier chain; `usb_register_notify` keeps no other reference.
+                unsafe {
+                    (*slot).notifier_call = Some(usb_remove_notify);
+                    (*slot).next = core::ptr::null_mut();
+                    (*slot).priority = 0;
+                    kernel::bindings::usb_register_notify(slot);
+                }
+            }),
+        })
+    }
+
+    /// Tear down every card attached to `usb` (the just-removed USB device). Runs in the USB
+    /// notifier's sleepable process context; the platform devices are unregistered after the
+    /// `devices` lock is released so the (sleeping) teardown does not run under the lock.
+    fn remove_usb(&self, usb: *mut kernel::bindings::usb_device) {
+        let mut to_drop: KVec<CardEntry> = KVec::new();
+        {
+            let mut devices = self.devices.lock();
+            let mut i = 0;
+            while i < devices.len() {
+                if devices[i].usb == usb {
+                    if let Ok(entry) = devices.remove(i) {
+                        let _ = to_drop.push(entry, GFP_KERNEL);
+                    }
+                } else {
+                    i += 1;
+                }
+            }
+        }
+        drop(to_drop);
+    }
+
+    /// Create a card for the USB device named `token` (e.g. `"2-1.1"`), giving its platform device a
+    /// `device` sysfs symlink to that USB device — the pairing libevdi/DisplayLinkManager look up.
+    fn add_usb_device(&self, token: &str) -> Result {
+        // Parse "<bus>-<port>[.<port>...]" into a bus/port address (bus first, leaf last).
+        let mut m = UsbPath {
+            addr: [0; MAX_USB_ADDR],
+            len: 0,
+            found: core::ptr::null_mut(),
+        };
+        let mut dash = token.split('-');
+        let bus = dash.next().ok_or(EINVAL)?;
+        m.addr[m.len] = bus.parse::<u32>().map_err(|_| EINVAL)?;
+        m.len += 1;
+        for p in dash.next().ok_or(EINVAL)?.split('.') {
+            if m.len >= MAX_USB_ADDR {
+                return Err(EINVAL);
+            }
+            m.addr[m.len] = p.parse::<u32>().map_err(|_| EINVAL)?;
+            m.len += 1;
+        }
+
+        // SAFETY: `usb_for_each_dev` calls `match_usb_path` for each live USB device with our
+        // `&mut m`; it retains no reference, so `m.found` is only used synchronously below.
+        unsafe {
+            kernel::bindings::usb_for_each_dev(
+                &raw mut m as *mut core::ffi::c_void,
+                Some(match_usb_path),
+            )
+        };
+        let usb = m.found;
+        if usb.is_null() {
+            return Err(EINVAL);
+        }
+
+        let regdev = platform::RegisteredDevice::new(c"evdi", platform::DEVID_AUTO, None, 0)?;
+        let pdev =
+            regdev.device() as *const platform::Device as *mut kernel::bindings::platform_device;
+        // SAFETY: `pdev` is the platform device just registered above; `usb` is the matched, still
+        // live USB device. `sysfs_create_link` copies `name` and takes no lasting reference; the
+        // link is removed automatically when the platform device's kobject is destroyed on drop.
+        let ret = unsafe {
+            kernel::bindings::sysfs_create_link(
+                &raw mut (*pdev).dev.kobj,
+                &raw mut (*usb).dev.kobj,
+                c"device".as_char_ptr(),
+            )
+        };
+        kernel::error::to_result(ret)?;
+        self.devices
+            .lock()
+            .push(CardEntry { _dev: regdev, usb }, GFP_KERNEL)?;
+        Ok(())
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for EvdiRegistry {
+    fn drop(self: Pin<&mut Self>) {
+        // Stop USB-removal callbacks before the card list is torn down. `usb_unregister_notify`
+        // waits for any in-flight callback, so no `remove_usb` can race the field drops that follow.
+        // SAFETY: `notifier` was registered exactly once in `new`.
+        unsafe { kernel::bindings::usb_unregister_notify(self.notifier.get()) };
+    }
+}
+
+impl kernel::sysfs::DeviceAttributes for EvdiRegistry {
+    const ATTRS: &'static [kernel::sysfs::Attr] = &[
+        kernel::sysfs::Attr::ro(c"count"),
+        kernel::sysfs::Attr::wo(c"add"),
+        kernel::sysfs::Attr::wo(c"remove_all"),
+    ];
+
+    fn show(&self, name: &CStr, buf: &mut [u8]) -> Result<usize> {
+        if name == c"count" {
+            write_uint(buf, self.devices.lock().len())
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    fn store(&self, name: &CStr, buf: &[u8]) -> Result {
+        if name == c"add" {
+            let text = core::str::from_utf8(buf).map_err(|_| EINVAL)?.trim();
+            // DisplayLinkManager (via libevdi) creates a card for a specific dock by writing
+            // "usb:<bus>-<port>[.<port>...]:<intf>"; a bare integer creates that many generic cards.
+            if let Some(rest) = text.strip_prefix("usb:") {
+                let token = rest.split(':').next().unwrap_or("").trim();
+                self.add_usb_device(token)
+            } else {
+                let count: u32 = text.parse().map_err(|_| EINVAL)?;
+                let mut devices = self.devices.lock();
+                for _ in 0..count {
+                    let dev =
+                        platform::RegisteredDevice::new(c"evdi", platform::DEVID_AUTO, None, 0)?;
+                    devices.push(
+                        CardEntry {
+                            _dev: dev,
+                            usb: core::ptr::null_mut(),
+                        },
+                        GFP_KERNEL,
+                    )?;
+                }
+                Ok(())
+            }
+        } else if name == c"remove_all" {
+            self.devices.lock().clear();
+            Ok(())
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
+/// Format `v` as decimal followed by a newline into `buf`, returning the byte count written.
+fn write_uint(buf: &mut [u8], mut v: usize) -> Result<usize> {
+    let mut tmp = [0u8; 24];
+    let mut i = tmp.len();
+    loop {
+        i -= 1;
+        tmp[i] = b'0' + (v % 10) as u8;
+        v /= 10;
+        if v == 0 {
+            break;
+        }
+    }
+    let digits = &tmp[i..];
+    let total = digits.len() + 1;
+    if total > buf.len() {
+        return Err(EINVAL);
+    }
+    buf[..digits.len()].copy_from_slice(digits);
+    buf[digits.len()] = b'\n';
+    Ok(total)
+}
+
+/// The module state.
+///
+/// Field/drop order matters: `_sysfs` (which owns the device registry, and thus every card) is
+/// declared first so it is dropped -- unregistering every card -- *before* the driver registration.
+#[pin_data]
+struct EvdiModule {
+    _sysfs: Option<KBox<kernel::sysfs::AttributeGroup<EvdiRegistry>>>,
+    #[pin]
+    _driver: kernel::driver::Registration<platform::Adapter<EvdiPlatformDriver>>,
+}
+
+impl kernel::InPlaceModule for EvdiModule {
+    fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("evdi: Rust EVDI loading\n");
+        try_pin_init!(Self {
+            _sysfs: kernel::sysfs::AttributeGroup::register_root(c"evdi", module, EvdiRegistry::new())
+                .inspect_err(|e| pr_err!("evdi: sysfs root registration failed ({e:?})\n"))
+                .ok(),
+            _driver <- kernel::driver::Registration::new(c"evdi", module),
+        })
+    }
+}
+
+module! {
+    type: EvdiModule,
+    name: "evdi",
+    authors: ["Mike Lothian"],
+    description: "Extensible Virtual Display Interface (Rust)",
+    license: "GPL",
+}
diff --git a/drivers/gpu/drm/evdi/ioctl.rs b/drivers/gpu/drm/evdi/ioctl.rs
new file mode 100644
index 000000000000..46cecf2279ec
--- /dev/null
+++ b/drivers/gpu/drm/evdi/ioctl.rs
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// EVDI driver-private ioctls (libevdi / DisplayLinkManager entry points), declared via
+// `kernel::declare_drm_ioctls_ext!` in `kms.rs`. Each handler runs inside a
+// `drm_dev_enter/exit` critical section (returns `ENODEV` if the card was unplugged).
+
+use kernel::{
+    device::Bound,
+    drm,
+    error::code::EAGAIN,
+    platform,
+    prelude::*,
+    uaccess::{UserPtr, UserSlice},
+};
+
+use crate::kms::{EvdiDrmData, EvdiDrmDriver, EvdiDrmFile};
+use crate::uapi;
+
+/// Maximum EDID blob we accept from userspace (128-byte base block + up to 255 extensions).
+const EDID_MAX: usize = 32 * 1024;
+
+type Dev = drm::Device<EvdiDrmDriver>;
+type Parent = platform::Device<Bound>;
+type File = drm::File<EvdiDrmFile>;
+
+/// `DRM_IOCTL_EVDI_CONNECT`: the DLM client connects (with an EDID) or disconnects the
+/// virtual display. Registers/clears the event receiver for this device.
+pub(crate) fn connect(
+    dev: &Dev,
+    _parent: &Parent,
+    _reg: &(),
+    arg: &mut uapi::DrmEvdiConnect,
+    file: &File,
+) -> Result<u32> {
+    let data: &EvdiDrmData = dev;
+    if arg.connected != 0 {
+        // Copy the EDID the client supplied so the connector's mode list reflects the real
+        // monitor. A zero-length/NULL EDID is allowed (connector falls back to a default mode).
+        let len = arg.edid_length as usize;
+        let mut edid = KVec::new();
+        if len > 0 && arg.edid != 0 {
+            if len > EDID_MAX {
+                return Err(EINVAL);
+            }
+            UserSlice::new(UserPtr::from_ptr(arg.edid as *mut kernel::ffi::c_void), len)
+                .read_all(&mut edid, GFP_KERNEL)?;
+        }
+
+        // Register this file as the event receiver, then mark connected and publish the EDID
+        // (which fires a hotplug so the compositor re-probes the connector's modes).
+        data.events.connect(file);
+        file.inner()
+            .connected
+            .store(true, core::sync::atomic::Ordering::Release);
+        data.painter.lock().connected = true;
+        if !edid.is_empty() {
+            data.set_edid(dev, edid);
+        }
+    } else {
+        data.events.disconnect();
+        file.inner()
+            .connected
+            .store(false, core::sync::atomic::Ordering::Release);
+        data.painter.lock().connected = false;
+        // Drop the EDID so the connector reports disconnected until the next CONNECT.
+        data.clear_edid(dev);
+    }
+    Ok(0)
+}
+
+/// `DRM_IOCTL_EVDI_REQUEST_UPDATE`: the client asks to be told (via UPDATE_READY) when the
+/// next frame is ready to grab.
+pub(crate) fn request_update(
+    dev: &Dev,
+    _parent: &Parent,
+    _reg: &(),
+    _arg: &mut uapi::DrmEvdiRequestUpdate,
+    _file: &File,
+) -> Result<u32> {
+    // If an ungrabbed frame is already waiting, return 1 so the client grabs immediately (libevdi's
+    // `grabImmediately`); otherwise return 0 and let the next flip's UPDATE_READY wake it. We do NOT
+    // send an event from here — that self-triggering request->event->grab->request cycle was the
+    // busy-loop. Every real flip still signals via `atomic_update`, so content updates propagate.
+    let data: &EvdiDrmData = dev;
+    if data.painter.lock().frame_dirty {
+        Ok(1)
+    } else {
+        Ok(0)
+    }
+}
+
+/// `DRM_IOCTL_EVDI_GRABPIX`: copy the current scanout framebuffer to the client's buffer.
+///
+/// The pixels are read through the safe [`FramebufferVmap::as_bytes`] slice and written to
+/// userspace one row at a time (bounded by both the framebuffer and the client's buffer geometry),
+/// so no oversized or per-pixel `copy_to_user` is performed.
+pub(crate) fn grabpix(
+    dev: &Dev,
+    _parent: &Parent,
+    _reg: &(),
+    arg: &mut uapi::DrmEvdiGrabpix,
+    _file: &File,
+) -> Result<u32> {
+    // XRGB8888: 4 bytes per pixel (the only format the primary plane advertises).
+    const BPP: usize = 4;
+
+    let data: &EvdiDrmData = dev;
+    // No frame has been flipped in yet: tell the client to try again.
+    let Some(fb) = data.scanout_fb() else {
+        return Err(EAGAIN);
+    };
+
+    // Take the regions accumulated since the last grab and mark the frame consumed.
+    let mut dmg = {
+        let mut p = data.painter.lock();
+        p.frame_dirty = false;
+        let d = p.damage;
+        p.damage.clear();
+        d
+    };
+
+    let map = fb.vmap()?;
+    let src = map.as_bytes();
+    let src_pitch = fb.pitch(0) as usize;
+    let fb_w = fb.width() as i32;
+    let fb_h = fb.height() as i32;
+
+    let dst_stride = arg.buf_byte_stride as usize;
+    if arg.buffer == 0 || dst_stride == 0 {
+        return Err(EINVAL);
+    }
+    let max_w = core::cmp::min(fb_w, (dst_stride / BPP) as i32);
+    let max_h = core::cmp::min(fb_h, arg.buf_height as i32);
+
+    // Nothing recorded (the client polled without a flip): fall back to one full-frame rectangle.
+    if dmg.count == 0 {
+        dmg.rects[0] = (0, 0, fb_w, fb_h);
+        dmg.count = 1;
+    }
+
+    // Clamp each rectangle to the framebuffer and the client's buffer, dropping empty ones.
+    let mut rects = [(0i32, 0i32, 0i32, 0i32); crate::painter::MAX_DAMAGE_RECTS];
+    let mut count = 0usize;
+    for &(rx1, ry1, rx2, ry2) in &dmg.rects[..dmg.count] {
+        let x1 = rx1.clamp(0, max_w);
+        let y1 = ry1.clamp(0, max_h);
+        let x2 = rx2.clamp(x1, max_w);
+        let y2 = ry2.clamp(y1, max_h);
+        if x2 > x1 && y2 > y1 {
+            rects[count] = (x1, y1, x2, y2);
+            count += 1;
+        }
+    }
+    if count == 0 {
+        return Ok(0);
+    }
+    // The client's `rects` buffer holds `num_rects` entries; if we somehow have more, coalesce into
+    // a single bounding box so we never overrun it.
+    let cap = (arg.num_rects.max(1) as usize).min(crate::painter::MAX_DAMAGE_RECTS);
+    if count > cap {
+        let mut bb = rects[0];
+        for &(x1, y1, x2, y2) in &rects[1..count] {
+            bb = (bb.0.min(x1), bb.1.min(y1), bb.2.max(x2), bb.3.max(y2));
+        }
+        rects[0] = bb;
+        count = 1;
+    }
+
+    // Report the rectangles so DLM transmits exactly them (`struct drm_clip_rect` = 4x u16). Leaving
+    // num_rects/rects unset makes DLM decide nothing changed and send nothing (black).
+    if arg.rects != 0 {
+        let mut buf = [0u8; crate::painter::MAX_DAMAGE_RECTS * 8];
+        for (i, &(x1, y1, x2, y2)) in rects[..count].iter().enumerate() {
+            let o = i * 8;
+            buf[o..o + 2].copy_from_slice(&(x1 as u16).to_ne_bytes());
+            buf[o + 2..o + 4].copy_from_slice(&(y1 as u16).to_ne_bytes());
+            buf[o + 4..o + 6].copy_from_slice(&(x2 as u16).to_ne_bytes());
+            buf[o + 6..o + 8].copy_from_slice(&(y2 as u16).to_ne_bytes());
+        }
+        UserSlice::new(
+            UserPtr::from_ptr(arg.rects as *mut kernel::ffi::c_void),
+            count * 8,
+        )
+        .writer()
+        .write_slice(&buf[..count * 8])?;
+    }
+    // The IOWR arg is copied back to userspace, so the count reaches DLM.
+    arg.num_rects = count as i32;
+
+    // Copy each changed rectangle into the client's (persistent, full-frame) buffer at the same
+    // position, so DLM's frame accumulates the per-grab deltas.
+    for &(x1, y1, x2, y2) in &rects[..count] {
+        let xoff = x1 as usize * BPP;
+        let span = (x2 - x1) as usize * BPP;
+        for y in y1 as usize..y2 as usize {
+            let so = y * src_pitch + xoff;
+            if so + span > src.len() {
+                break;
+            }
+            let dst = arg
+                .buffer
+                .checked_add(y * dst_stride + xoff)
+                .ok_or(EINVAL)?;
+            UserSlice::new(UserPtr::from_ptr(dst as *mut kernel::ffi::c_void), span)
+                .writer()
+                .write_slice(&src[so..so + span])?;
+        }
+    }
+    Ok(0)
+}
+
+/// `DRM_IOCTL_EVDI_DDCCI_RESPONSE`: the client returns a DDC/CI reply to be handed back to
+/// the in-kernel I2C adapter.
+pub(crate) fn ddcci_response(
+    dev: &Dev,
+    _parent: &Parent,
+    _reg: &(),
+    arg: &mut uapi::DrmEvdiDdcciResponse,
+    _file: &File,
+) -> Result<u32> {
+    // Copy the client's DDC/CI reply (capped at the 64-byte DDC/CI payload) and hand it to the
+    // waiting I2C transfer.
+    let len = core::cmp::min(arg.buffer_length as usize, uapi::DDCCI_BUFFER_SIZE);
+    let mut resp = KVec::new();
+    if len > 0 && arg.buffer != 0 {
+        UserSlice::new(
+            UserPtr::from_ptr(arg.buffer as *mut kernel::ffi::c_void),
+            len,
+        )
+        .read_all(&mut resp, GFP_KERNEL)?;
+    }
+    let data: &EvdiDrmData = dev;
+    data.ddcci_respond(resp);
+    Ok(0)
+}
+
+/// `DRM_IOCTL_EVDI_ENABLE_CURSOR_EVENTS`: toggle delivery of CURSOR_SET/CURSOR_MOVE events.
+pub(crate) fn enable_cursor_events(
+    dev: &Dev,
+    _parent: &Parent,
+    _reg: &(),
+    arg: &mut uapi::DrmEvdiEnableCursorEvents,
+    _file: &File,
+) -> Result<u32> {
+    let data: &EvdiDrmData = dev;
+    data.painter.lock().cursor_events_enabled = arg.enable != 0;
+    Ok(0)
+}
diff --git a/drivers/gpu/drm/evdi/kms.rs b/drivers/gpu/drm/evdi/kms.rs
new file mode 100644
index 000000000000..1d39163ddf3b
--- /dev/null
+++ b/drivers/gpu/drm/evdi/kms.rs
@@ -0,0 +1,729 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// The EVDI DRM/KMS device: registers a `struct drm_device` presenting one virtual
+// display head (CRTC + primary plane + virtual encoder + virtual connector) with
+// GEM-shmem dumb buffers, built on the safe KMS mode-object layer (`kernel::drm::kms`).
+//
+// Unlike a real display driver, EVDI's scanout is *pulled* by userspace: the
+// DisplayLinkManager daemon grabs framebuffer pixels via the GRABPIX ioctl and is
+// told when to do so through `drm_event`s (see `painter.rs`). The KMS callbacks here
+// therefore translate atomic commits into those events rather than programming any
+// hardware.
+
+use core::sync::atomic::{AtomicBool, AtomicI64, AtomicPtr, Ordering};
+use kernel::{
+    bindings,
+    drm,
+    drm::event::EventChannel,
+    drm::kms::{
+        connector::{self, ConnectorGuard},
+        crtc::{self, AsRawCrtc as _, CrtcAtomicCommit, RawCrtc as _, RawCrtcState as _},
+        encoder,
+        framebuffer::Framebuffer,
+        plane::{self, PlaneAtomicCommit, RawPlaneState as _},
+        vblank::{RawVblankCrtcState as _, VblankGuard, VblankSupport, VblankTimestamp},
+        KmsDriver, ModeConfigGuard, ModeConfigInfo, ModeObject as _, NewKmsDevice, Probing,
+    },
+    impl_has_hr_timer,
+    interrupt::LocalInterruptDisabled,
+    prelude::*,
+    sync::{aref::ARef, new_condvar, new_mutex, new_spinlock, Arc, ArcBorrow, CondVar,
+        CondVarTimeoutResult, Mutex, SpinLock},
+    time::{
+        hrtimer::{
+            ArcHrTimerHandle, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerPointer,
+            HrTimerRestart, RelativeMode,
+        },
+        Delta, Monotonic,
+    },
+    types::ForLt,
+};
+
+use crate::painter::PainterState;
+use crate::uapi;
+use kernel::error::code::{ERESTARTSYS, ETIMEDOUT};
+
+/// DDC/CI slave address on the virtual I2C bus (as used by monitor-control tools).
+pub(crate) const DDCCI_ADDRESS: u16 = 0x37;
+/// How long a DDC/CI transfer waits for the userspace client's reply.
+const DDCCI_TIMEOUT_MS: u32 = 50;
+/// Maximum DDC/CI payload carried in one event.
+const DDCCI_BUFFER_SIZE: usize = 64;
+
+/// `DRM_FORMAT_XRGB8888` (`fourcc_code('X','R','2','4')`) — EVDI scans out 32bpp.
+pub(crate) const DRM_FORMAT_XRGB8888: u32 = 0x3432_5258;
+static PRIMARY_FORMATS: [u32; 1] = [DRM_FORMAT_XRGB8888];
+
+/// `DRM_FORMAT_ARGB8888` (`fourcc_code('A','R','2','4')`) — cursor bitmaps carry alpha.
+pub(crate) const DRM_FORMAT_ARGB8888: u32 = 0x3432_5241;
+static CURSOR_FORMATS: [u32; 1] = [DRM_FORMAT_ARGB8888];
+
+/// Fallback mode advertised before the DLM client delivers an EDID via CONNECT.
+const FALLBACK_W: u32 = 1024;
+const FALLBACK_H: u32 = 768;
+
+// libevdi (`is_evdi_compatible`) requires `major == 1 && minor >= 9`; match the C evdi's version so
+// DisplayLinkManager accepts the card. Bumped past the 1.0.0 that made libevdi reject every device.
+const INFO: drm::DriverInfo = drm::DriverInfo {
+    major: 1,
+    minor: 14,
+    patchlevel: 16,
+    name: c"evdi",
+    desc: c"Extensible Virtual Display Interface",
+};
+
+/// The EVDI DRM driver marker type.
+pub(crate) struct EvdiDrmDriver;
+
+/// Convenience alias for our concrete `drm::Device`.
+pub(crate) type EvdiDrmDevice = drm::Device<EvdiDrmDriver>;
+
+/// DRM device-private data: the painter (connection + event delivery + pixel grab
+/// bookkeeping) and a stashed pointer to our single connector so CONNECT can push a
+/// fresh EDID into its mode list.
+#[pin_data]
+pub(crate) struct EvdiDrmData {
+    /// Event channel to the connected DLM client (`drm_event` delivery).
+    #[pin]
+    pub(crate) events: EventChannel,
+    /// Painter state (connection status, cached EDID, cursor-events flag, dirty rects).
+    #[pin]
+    pub(crate) painter: Mutex<PainterState>,
+    /// The framebuffer currently flipped in on the primary plane, refcounted so GRABPIX can map
+    /// and copy it after the atomic commit that set it has returned. `None` until the first flip.
+    #[pin]
+    pub(crate) scanout: Mutex<Option<ARef<Framebuffer<EvdiDrmDriver>>>>,
+    /// Slot for a DDC/CI reply from the client, guarding the request/response handshake between
+    /// the I2C `master_xfer` (which waits) and the DDCCI_RESPONSE ioctl (which fills + notifies).
+    #[pin]
+    pub(crate) ddcci_resp: Mutex<Option<KVec<u8>>>,
+    #[pin]
+    pub(crate) ddcci_cv: CondVar,
+    /// Pointer to our connector's driver data, stashed during `KmsDriver::probe` so
+    /// CONNECT can reach its cached-EDID slot without walking DRM's mode-object list.
+    /// Written once during single-threaded probe; read-only thereafter.
+    pub(crate) connector: core::sync::atomic::AtomicPtr<EvdiConnector>,
+}
+
+impl EvdiDrmData {
+    pub(crate) fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            events <- EventChannel::new(kernel::static_lock_class!()),
+            painter <- new_mutex!(PainterState::new()),
+            scanout <- new_mutex!(None),
+            ddcci_resp <- new_mutex!(None),
+            ddcci_cv <- new_condvar!(),
+            connector: core::sync::atomic::AtomicPtr::new(core::ptr::null_mut()),
+        })
+    }
+
+    /// Send one DDC/CI message to the connected client and wait for its reply. `buf` carries the
+    /// write payload (or, for `is_read`, is filled with the reply, up to its length). Returns
+    /// `ETIMEDOUT` if the client does not respond in time.
+    pub(crate) fn ddcci_transfer(
+        &self,
+        dev: &EvdiDrmDevice,
+        addr: u16,
+        flags: u16,
+        is_read: bool,
+        buf: &mut [u8],
+    ) -> Result {
+        let mut ev = uapi::DrmEvdiEventDdcciData {
+            base: uapi::DrmEvent {
+                type_: 0,
+                length: 0,
+            },
+            buffer: [0u8; DDCCI_BUFFER_SIZE],
+            buffer_length: buf.len() as u32,
+            flags,
+            address: addr,
+        };
+        let n = core::cmp::min(buf.len(), DDCCI_BUFFER_SIZE);
+        ev.buffer[..n].copy_from_slice(&buf[..n]);
+
+        // Hold the slot lock across send+wait so the reply cannot be signalled before we wait
+        // (no lost wakeup): `ddcci_respond` can only run once `wait_*` has released the lock.
+        let mut slot = self.ddcci_resp.lock();
+        *slot = None;
+        self.events.send(dev, ev)?;
+        let jiffies = kernel::time::msecs_to_jiffies(DDCCI_TIMEOUT_MS);
+        match self.ddcci_cv.wait_interruptible_timeout(&mut slot, jiffies) {
+            CondVarTimeoutResult::Woken { .. } => {
+                if is_read {
+                    if let Some(resp) = slot.take() {
+                        let m = core::cmp::min(resp.len(), buf.len());
+                        buf[..m].copy_from_slice(&resp[..m]);
+                    }
+                }
+                Ok(())
+            }
+            CondVarTimeoutResult::Timeout => Err(ETIMEDOUT),
+            CondVarTimeoutResult::Signal { .. } => Err(ERESTARTSYS),
+        }
+    }
+
+    /// Store a DDC/CI reply from the client (DDCCI_RESPONSE ioctl) and wake the waiting transfer.
+    pub(crate) fn ddcci_respond(&self, resp: KVec<u8>) {
+        *self.ddcci_resp.lock() = Some(resp);
+        self.ddcci_cv.notify_one();
+    }
+
+    /// Record the framebuffer currently on the primary plane (bumping its refcount) so a later
+    /// GRABPIX can map it. Called from the plane's atomic commit.
+    pub(crate) fn set_scanout(&self, fb: Option<&Framebuffer<EvdiDrmDriver>>) {
+        *self.scanout.lock() = fb.map(ARef::from);
+    }
+
+    /// Take a refcounted handle to the current scanout framebuffer, if any, for GRABPIX to map.
+    pub(crate) fn scanout_fb(&self) -> Option<ARef<Framebuffer<EvdiDrmDriver>>> {
+        self.scanout.lock().clone()
+    }
+
+    /// Install a new EDID blob (from CONNECT) into the connector and fire a hotplug so
+    /// the compositor re-probes the connector's mode list.
+    pub(crate) fn set_edid(&self, dev: &EvdiDrmDevice, blob: KVec<u8>) {
+        let ptr = self.connector.load(core::sync::atomic::Ordering::Acquire);
+        // SAFETY: `connector` was stashed during probe and points to a `EvdiConnector`
+        // that lives as long as the device; null until probe completes.
+        let Some(connector) = (unsafe { ptr.as_ref() }) else {
+            return;
+        };
+        *connector.cached_edid.lock() = Some(blob);
+        dev.hotplug_event();
+    }
+
+    /// Drop the connector's cached EDID (on CONNECT disconnect) and fire a hotplug so the connector
+    /// reports disconnected again -- see [`EvdiConnector::detect`].
+    pub(crate) fn clear_edid(&self, dev: &EvdiDrmDevice) {
+        let ptr = self.connector.load(core::sync::atomic::Ordering::Acquire);
+        // SAFETY: as in `set_edid` -- `connector` was stashed during probe and outlives the device.
+        let Some(connector) = (unsafe { ptr.as_ref() }) else {
+            return;
+        };
+        *connector.cached_edid.lock() = None;
+        dev.hotplug_event();
+    }
+}
+
+/// GEM object inner data. Empty: the shmem-backed object wires
+/// `drm_gem_shmem_dumb_create`, so `DRM_IOCTL_MODE_CREATE_DUMB` works and the GRABPIX
+/// ioctl can `vmap` the resulting framebuffer to copy pixels to userspace.
+#[pin_data]
+pub(crate) struct EvdiObject {}
+
+impl drm::gem::DriverObject for EvdiObject {
+    type Driver = EvdiDrmDriver;
+    type Args = ();
+
+    fn new<Ctx: drm::DeviceContext>(
+        _dev: &drm::Device<EvdiDrmDriver, Ctx>,
+        _size: usize,
+        _args: (),
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(EvdiObject {})
+    }
+}
+
+/// Per-open DRM client state. Empty of data, but its lifetime pins the module for the
+/// duration of an open DRM file (the DLM daemon holds `/dev/dri/cardN` open across the
+/// whole session; the Rust DRM `file_operations` are built with `owner = NULL`, so
+/// without this an `rmmod` while DLM is running would free the fops under the open fd).
+#[pin_data(PinnedDrop)]
+pub(crate) struct EvdiDrmFile {
+    /// The owning device, so file close can reach the event channel to disconnect.
+    dev: ARef<EvdiDrmDevice>,
+    /// Whether this file issued CONNECT and is thus the event receiver. Set by the CONNECT ioctl;
+    /// on close a connected file clears the channel so no event is ever sent to a closed file.
+    pub(crate) connected: core::sync::atomic::AtomicBool,
+}
+
+impl drm::file::DriverFile for EvdiDrmFile {
+    type Driver = EvdiDrmDriver;
+
+    fn open(dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
+        let file = KBox::try_pin_init(
+            try_pin_init!(Self {
+                dev: dev.into(),
+                connected: core::sync::atomic::AtomicBool::new(false),
+            }),
+            GFP_KERNEL,
+        )?;
+        // SAFETY: executing inside this module's own DRM `open` callback, so the module
+        // is live; the reference is released 1:1 in `PinnedDrop`.
+        unsafe { kernel::bindings::__module_get(crate::THIS_MODULE.as_ptr()) };
+        Ok(file)
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for EvdiDrmFile {
+    fn drop(self: Pin<&mut Self>) {
+        // If this file was the connected event receiver, clear the channel so nothing is ever
+        // delivered to it after close (the receiver pointer must not outlive the file).
+        if self.connected.load(core::sync::atomic::Ordering::Acquire) {
+            self.dev.events.disconnect();
+        }
+        // Release the module reference taken in `open`.
+        // SAFETY: balances the `__module_get` in `open`.
+        unsafe { kernel::bindings::module_put(crate::THIS_MODULE.as_ptr()) };
+    }
+}
+
+#[vtable]
+impl drm::Driver for EvdiDrmDriver {
+    type Data = EvdiDrmData;
+    type File = EvdiDrmFile;
+    type Object<Ctx: drm::DeviceContext> = drm::gem::shmem::Object<EvdiObject, Ctx>;
+    type ParentDevice<Ctx: kernel::device::DeviceContext> = kernel::platform::Device<Ctx>;
+    type RegistrationData = ForLt!(());
+    type Kms = Self;
+
+    const INFO: drm::DriverInfo = INFO;
+
+    kernel::declare_drm_ioctls_ext! {
+        (EVDI_CONNECT, crate::uapi::DrmEvdiConnect,
+            crate::uapi::DRM_IOCTL_EVDI_CONNECT, 0, crate::ioctl::connect),
+        (EVDI_REQUEST_UPDATE, crate::uapi::DrmEvdiRequestUpdate,
+            crate::uapi::DRM_IOCTL_EVDI_REQUEST_UPDATE, 0, crate::ioctl::request_update),
+        (EVDI_GRABPIX, crate::uapi::DrmEvdiGrabpix,
+            crate::uapi::DRM_IOCTL_EVDI_GRABPIX, 0, crate::ioctl::grabpix),
+        (EVDI_DDCCI_RESPONSE, crate::uapi::DrmEvdiDdcciResponse,
+            crate::uapi::DRM_IOCTL_EVDI_DDCCI_RESPONSE, 0, crate::ioctl::ddcci_response),
+        (EVDI_ENABLE_CURSOR_EVENTS, crate::uapi::DrmEvdiEnableCursorEvents,
+            crate::uapi::DRM_IOCTL_EVDI_ENABLE_CURSOR_EVENTS, 0, crate::ioctl::enable_cursor_events),
+    }
+}
+
+#[vtable]
+impl KmsDriver for EvdiDrmDriver {
+    type Connector = EvdiConnector;
+    type Plane = EvdiPlane;
+    type Crtc = EvdiCrtc;
+    type Encoder = EvdiEncoder;
+
+    fn mode_config_info(_dev: &drm::Device<Self, drm::Uninit>) -> Result<ModeConfigInfo> {
+        Ok(ModeConfigInfo {
+            min_resolution: (0, 0),
+            max_resolution: (8192, 8192),
+            max_cursor: (64, 64),
+            preferred_depth: 32,
+            preferred_fourcc: Some(DRM_FORMAT_XRGB8888),
+        })
+    }
+
+    fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> Result {
+        let primary = plane::UnregisteredPlane::<EvdiPlane>::new(
+            dev,
+            1,
+            &PRIMARY_FORMATS,
+            None,
+            plane::Type::Primary,
+            None,
+            false,
+        )?;
+        // Advertise FB_DAMAGE_CLIPS so the compositor reports which region it changed each frame.
+        // Without it `damage_merged` always returns the whole plane, so GRABPIX reports a full-frame
+        // rect and DLM re-transmits the entire 2560x1440 buffer every update (jerky).
+        // SAFETY: `primary` is a valid, not-yet-registered plane; the property is added before
+        // registration (in the `Probing` phase).
+        unsafe {
+            kernel::bindings::drm_plane_enable_fb_damage_clips(plane::AsRawPlane::as_raw(primary))
+        };
+        // Hardware cursor plane: cursor movement is then forwarded to the DLM client as CURSOR_MOVE
+        // events (the daemon composites the cursor itself) instead of forcing a primary-plane
+        // repaint + full grab. `max_cursor` (mode_config_info) bounds the size the compositor will
+        // put here; larger cursors (e.g. KDE's shake-to-locate) fall back to a software cursor
+        // composited into the framebuffer, which the primary path grabs normally.
+        let cursor = plane::UnregisteredPlane::<EvdiPlane>::new(
+            dev,
+            1,
+            &CURSOR_FORMATS,
+            None,
+            plane::Type::Cursor,
+            None,
+            true,
+        )?;
+        let crtc_obj =
+            crtc::UnregisteredCrtc::<EvdiCrtc>::new(dev, primary, Some(&cursor), None, ())?;
+        let enc = encoder::UnregisteredEncoder::<EvdiEncoder>::new(
+            dev,
+            encoder::Type::Virtual,
+            crtc_obj.mask(),
+            0,
+            None,
+            (),
+        )?;
+        // Use DVI-I (matching the C evdi) rather than Virtual: `__drm_connector_init` skips
+        // `drm_connector_attach_edid_property()` for VIRTUAL/WRITEBACK connectors, and without that
+        // property `drm_edid_connector_update()` can't populate `edid_blob_ptr`, so
+        // `drm_edid_connector_add_modes()` would return 0 modes for a perfectly valid EDID.
+        let conn =
+            connector::UnregisteredConnector::<EvdiConnector>::new(dev, connector::Type::DviI, ())?;
+        conn.attach_encoder(&*enc)?;
+        let data: &EvdiDrmData = dev;
+        data.connector.store(
+            &**conn as *const EvdiConnector as *mut EvdiConnector,
+            core::sync::atomic::Ordering::Release,
+        );
+        Ok(())
+    }
+}
+
+// ---- CRTC -------------------------------------------------------------------
+
+/// A software vblank source: an hrtimer that fires once per frame and drives
+/// `drm_crtc_handle_vblank()`, so the atomic helpers pace page-flips against a real vblank
+/// (via `drm_crtc_arm_vblank_event()` in [`EvdiCrtc::atomic_flush`]) instead of completing them
+/// immediately with a fake vblank -- which is what makes updates smooth rather than bursty.
+///
+/// The timer free-runs once started (re-arming every tick); `enabled` gates whether it actually
+/// delivers vblanks, so DPMS off/on is a cheap flag flip rather than a start/stop. It is cancelled
+/// when the owning [`EvdiCrtc`] (and thus the [`ArcHrTimerHandle`]) is dropped at teardown, before
+/// the `drm_crtc` it points at is freed.
+#[pin_data]
+pub(crate) struct VblankTimer {
+    #[pin]
+    timer: HrTimer<Self>,
+    /// The `drm_crtc` to deliver vblanks to (set when vblank is first enabled).
+    crtc: AtomicPtr<bindings::drm_crtc>,
+    /// One scanout frame in nanoseconds (from the mode's `framedur_ns`).
+    interval_ns: AtomicI64,
+    /// Whether vblanks should currently be delivered (toggled by enable/disable_vblank).
+    enabled: AtomicBool,
+    /// Whether the free-running timer has been started yet.
+    started: AtomicBool,
+}
+
+impl VblankTimer {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(VblankTimer {
+            timer <- HrTimer::new(),
+            crtc: AtomicPtr::new(core::ptr::null_mut()),
+            interval_ns: AtomicI64::new(16_666_666), // ~60 Hz until a mode sets it
+            enabled: AtomicBool::new(false),
+            started: AtomicBool::new(false),
+        })
+    }
+}
+
+impl HrTimerCallback for VblankTimer {
+    type Pointer<'a> = Arc<Self>;
+
+    fn run(this: ArcBorrow<'_, Self>, mut ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+        let crtc = this.crtc.load(Ordering::Relaxed);
+        if !crtc.is_null() && this.enabled.load(Ordering::Relaxed) {
+            // SAFETY: `crtc` is the `drm_crtc` stored in `enable_vblank` while the device is live;
+            // the timer is cancelled (its handle dropped) before the crtc is freed at teardown.
+            unsafe { bindings::drm_crtc_handle_vblank(crtc) };
+        }
+        let interval = this.interval_ns.load(Ordering::Relaxed).max(1_000_000);
+        ctx.forward_now(Delta::from_nanos(interval));
+        HrTimerRestart::Restart
+    }
+}
+
+impl_has_hr_timer! {
+    impl HasHrTimer<Self> for VblankTimer {
+        mode: RelativeMode<Monotonic>, field: self.timer
+    }
+}
+
+#[pin_data]
+pub(crate) struct EvdiCrtc {
+    /// The software vblank source for this CRTC.
+    vblank: Arc<VblankTimer>,
+    /// Keeps the timer running; dropping it (at CRTC teardown) cancels the timer.
+    #[pin]
+    vblank_handle: SpinLock<Option<ArcHrTimerHandle<VblankTimer>>>,
+}
+
+#[derive(Clone, Default)]
+pub(crate) struct EvdiCrtcState;
+
+impl crtc::DriverCrtcState for EvdiCrtcState {
+    type Crtc = EvdiCrtc;
+}
+
+#[vtable]
+impl crtc::DriverCrtc for EvdiCrtc {
+    type Args = ();
+    type Driver = EvdiDrmDriver;
+    type State = EvdiCrtcState;
+    type VblankImpl = Self;
+
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        _args: &(),
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(EvdiCrtc {
+            vblank: Arc::pin_init(VblankTimer::new(), GFP_KERNEL)?,
+            vblank_handle <- new_spinlock!(None),
+        })
+    }
+
+    /// Display turning on: enable vblank delivery, then tell the DLM client DPMS-on + the mode.
+    fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
+        let crtc = commit.crtc();
+        crtc.vblank_on();
+        let dev = crtc.drm_dev();
+        let data: &EvdiDrmData = dev;
+        let new = commit.take_new_state();
+        let mode = new.mode();
+        crate::painter::notify_dpms(data, dev, crate::painter::DPMS_ON);
+        crate::painter::notify_mode_changed(
+            data,
+            dev,
+            mode.hdisplay() as i32,
+            mode.vdisplay() as i32,
+            mode.vrefresh(),
+            32,
+            DRM_FORMAT_XRGB8888,
+        );
+    }
+
+    /// Display turning off: stop vblank delivery and tell the DLM client DPMS-off.
+    fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
+        let crtc = commit.crtc();
+        crtc.vblank_off();
+        let dev = crtc.drm_dev();
+        let data: &EvdiDrmData = dev;
+        crate::painter::notify_dpms(data, dev, crate::painter::DPMS_OFF);
+    }
+
+    /// Arm the page-flip completion event to be sent by the next vblank tick, so userspace is paced
+    /// to the refresh rate rather than signalled immediately.
+    fn atomic_flush(commit: CrtcAtomicCommit<'_, Self>) {
+        let crtc = commit.crtc();
+        let mut new = commit.take_new_state();
+        if let Some(pending) = new.get_pending_vblank_event() {
+            match crtc.vblank_get() {
+                Ok(vbl_ref) => pending.arm(vbl_ref),
+                // Vblank couldn't be enabled (e.g. mid-teardown): fall back to sending now.
+                Err(_) => pending.send(),
+            }
+        }
+    }
+}
+
+impl VblankSupport for EvdiCrtc {
+    type Crtc = EvdiCrtc;
+
+    fn enable_vblank(
+        crtc: &crtc::Crtc<Self::Crtc>,
+        vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        _irq: &LocalInterruptDisabled,
+    ) -> Result {
+        let data: &EvdiCrtc = crtc;
+        // Track the mode's real frame duration so the tick matches the negotiated refresh rate.
+        let fd = vblank_guard.frame_duration();
+        if fd > 0 {
+            data.vblank.interval_ns.store(fd as i64, Ordering::Relaxed);
+        }
+        data.vblank.crtc.store(crtc.as_raw(), Ordering::Relaxed);
+        data.vblank.enabled.store(true, Ordering::Relaxed);
+        // Start the free-running timer the first time vblank is enabled.
+        if !data.vblank.started.swap(true, Ordering::Relaxed) {
+            let interval = data.vblank.interval_ns.load(Ordering::Relaxed);
+            let handle = data.vblank.clone().start(Delta::from_nanos(interval));
+            *data.vblank_handle.lock() = Some(handle);
+        }
+        Ok(())
+    }
+
+    fn disable_vblank(
+        crtc: &crtc::Crtc<Self::Crtc>,
+        _vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        _irq: &LocalInterruptDisabled,
+    ) {
+        let data: &EvdiCrtc = crtc;
+        data.vblank.enabled.store(false, Ordering::Relaxed);
+    }
+
+    fn get_vblank_timestamp(
+        _crtc: &crtc::Crtc<Self::Crtc>,
+        _in_vblank_irq: bool,
+    ) -> Option<VblankTimestamp> {
+        // Let DRM estimate the timestamp from the mode timings.
+        None
+    }
+}
+
+// ---- Planes (primary + cursor) ----------------------------------------------
+//
+// The safe KMS layer allows a single `DriverPlane` type per driver, so one `EvdiPlane` type serves
+// both the primary and cursor planes, told apart by `is_cursor` (set from the plane's `Args`).
+
+#[pin_data]
+pub(crate) struct EvdiPlane {
+    /// Whether this is the cursor plane (vs. the primary scanout plane).
+    is_cursor: bool,
+}
+
+#[derive(Clone, Default)]
+pub(crate) struct EvdiPlaneState;
+
+impl plane::DriverPlaneState for EvdiPlaneState {
+    type Plane = EvdiPlane;
+}
+
+#[vtable]
+impl plane::DriverPlane for EvdiPlane {
+    type Args = bool;
+    type Driver = EvdiDrmDriver;
+    type State = EvdiPlaneState;
+
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        is_cursor: bool,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(EvdiPlane { is_cursor })
+    }
+
+    /// A new framebuffer was flipped in.
+    ///
+    /// For the primary plane, EVDI records the new scanout buffer and signals the DLM client to
+    /// grab it (UPDATE_READY). For the cursor plane it forwards the cursor position (CURSOR_MOVE)
+    /// and, when the bitmap changes, its geometry + a GEM handle the client can map (CURSOR_SET) --
+    /// the DisplayLink daemon composites the cursor itself.
+    fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
+        let plane = commit.plane();
+        let dev = plane.drm_dev();
+        let data: &EvdiDrmData = dev;
+
+        if !plane.is_cursor {
+            // Primary: record the new scanout buffer plus each region the compositor changed
+            // (`for_each_damage_clip`, relative to the old state), accumulate them for GRABPIX, and
+            // signal the client. UPDATE_READY fires on every real flip so updates propagate; the
+            // busy-loop is avoided by *not* re-signalling from REQUEST_UPDATE. Reporting the exact
+            // changed rectangles lets DLM transmit small deltas instead of the whole 2560x1440 frame.
+            let (old, new) = commit.take_old_new_state();
+            let fb = new.framebuffer::<EvdiDrmDriver>();
+            data.set_scanout(fb);
+            if fb.is_some() {
+                {
+                    let mut p = data.painter.lock();
+                    new.for_each_damage_clip(old, |r| p.damage.push((r.x1, r.y1, r.x2, r.y2)));
+                    p.frame_dirty = true;
+                }
+                crate::painter::notify_update_ready(data, dev);
+            }
+            return;
+        }
+
+        // Cursor: only forward events if the client asked for them.
+        let new = commit.take_new_state();
+        if !data.painter.lock().cursor_events_enabled {
+            return;
+        }
+        crate::painter::notify_cursor_move(data, dev, new.crtc_x(), new.crtc_y());
+        match new.framebuffer::<EvdiDrmDriver>() {
+            Some(fb) => {
+                // Create a handle to the cursor bitmap in the connected client's file so the daemon
+                // can map it (may sleep; runs under the event channel's receiver mutex).
+                let handle = match data
+                    .events
+                    .with_receiver::<EvdiDrmFile, _>(|file| fb.create_handle(file))
+                {
+                    Some(Ok(h)) => h,
+                    _ => 0,
+                };
+                crate::painter::notify_cursor_set(
+                    data,
+                    dev,
+                    new.hotspot_x(),
+                    new.hotspot_y(),
+                    fb.width(),
+                    fb.height(),
+                    handle != 0,
+                    handle,
+                    fb.height() * fb.pitch(0),
+                    fb.format(),
+                    fb.pitch(0),
+                );
+            }
+            // Cursor disabled (no framebuffer): tell the client to hide it.
+            None => crate::painter::notify_cursor_set(data, dev, 0, 0, 0, 0, false, 0, 0, 0, 0),
+        }
+    }
+}
+
+// ---- Encoder ----------------------------------------------------------------
+
+#[pin_data]
+pub(crate) struct EvdiEncoder;
+
+#[vtable]
+impl encoder::DriverEncoder for EvdiEncoder {
+    type Driver = EvdiDrmDriver;
+    type Args = ();
+
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        _args: (),
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(EvdiEncoder {})
+    }
+}
+
+// ---- Connector --------------------------------------------------------------
+
+#[pin_data]
+pub(crate) struct EvdiConnector {
+    /// EDID delivered by the DLM client through CONNECT (`None` until connected).
+    #[pin]
+    pub(crate) cached_edid: Mutex<Option<KVec<u8>>>,
+}
+
+#[derive(Clone, Default)]
+pub(crate) struct EvdiConnectorState;
+
+impl connector::DriverConnectorState for EvdiConnectorState {
+    type Connector = EvdiConnector;
+}
+
+#[vtable]
+impl connector::DriverConnector for EvdiConnector {
+    type Args = ();
+    type Driver = EvdiDrmDriver;
+    type State = EvdiConnectorState;
+
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        _args: (),
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(EvdiConnector {
+            cached_edid <- new_mutex!(Option::<KVec<u8>>::None),
+        })
+    }
+
+    /// Install the DLM-provided EDID when present, else advertise a fallback mode list so
+    /// the connector stays usable before CONNECT.
+    fn get_modes<'a>(
+        connector: ConnectorGuard<'a, Self>,
+        guard: &ModeConfigGuard<'a, Self::Driver>,
+    ) -> i32 {
+        if let Some(blob) = connector.cached_edid.lock().as_ref() {
+            let n = connector.add_edid_modes(blob);
+            if n > 0 {
+                return n;
+            }
+        }
+        let _ = guard;
+        let n = connector.add_modes_noedid((FALLBACK_W, FALLBACK_H));
+        connector.set_preferred_mode((FALLBACK_W, FALLBACK_H));
+        n
+    }
+
+    /// Report the display as connected only once the DLM client has delivered an EDID (via CONNECT).
+    /// Advertising the fallback mode as "connected" before the real EDID arrives makes the
+    /// compositor configure the output at the wrong resolution and then reconfigure/disable it when
+    /// the EDID (and native modes) show up -- which manifested as the dock output freezing on its
+    /// first frame. This mirrors the C evdi's disconnected-until-EDID hotplug sequencing.
+    fn detect(connector: &connector::Connector<Self>, _force: bool) -> connector::Status {
+        if connector.cached_edid.lock().is_some() {
+            connector::Status::Connected
+        } else {
+            connector::Status::Disconnected
+        }
+    }
+}
diff --git a/drivers/gpu/drm/evdi/painter.rs b/drivers/gpu/drm/evdi/painter.rs
new file mode 100644
index 000000000000..33208cd51a1c
--- /dev/null
+++ b/drivers/gpu/drm/evdi/painter.rs
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// The EVDI "painter": the per-device connection + event-delivery bookkeeping that
+// bridges the KMS callbacks (and ioctls) to the DisplayLinkManager userspace client.
+//
+// Events are delivered through the DRM-core `drm_event` mechanism (the safe
+// `kernel::drm::event::EventChannel` binding), which serializes delivery against file
+// close under `event_lock` — so an event can never be sent to a client that has just
+// disconnected.
+
+use kernel::drm::event::EventPayload;
+
+use crate::kms::{EvdiDrmData, EvdiDrmDevice};
+use crate::uapi;
+
+/// DPMS mode codes as understood by the DLM client (matching `DRM_MODE_DPMS_*`).
+pub(crate) const DPMS_ON: i32 = 0;
+pub(crate) const DPMS_OFF: i32 = 3;
+
+/// Mutable per-device painter state, guarded by a mutex in [`EvdiDrmData`].
+///
+/// The connected client's EDID is the connector's `cached_edid` (the source of truth for the mode
+/// list), so it is not duplicated here.
+pub(crate) struct PainterState {
+    /// Whether a DLM client has issued CONNECT.
+    pub(crate) connected: bool,
+    /// Whether the client asked to receive cursor events.
+    pub(crate) cursor_events_enabled: bool,
+    /// A frame has been flipped in but not yet grabbed (the C evdi's `num_dirts > 0`). Lets
+    /// REQUEST_UPDATE answer "grab now" (ioctl returns 1) when fresh pixels are already waiting,
+    /// instead of self-triggering an UPDATE_READY event (which busy-loops the client).
+    pub(crate) frame_dirty: bool,
+    /// The individual regions changed since the last GRABPIX, accumulated across flips. GRABPIX
+    /// reports and copies exactly these rectangles (so DLM transmits just the deltas rather than the
+    /// whole 2560x1440 frame), then clears them.
+    pub(crate) damage: Damage,
+}
+
+/// Maximum number of distinct damage rectangles tracked between grabs (mirrors the C evdi's
+/// `MAX_DIRTS`); on overflow they collapse into a single bounding box.
+pub(crate) const MAX_DAMAGE_RECTS: usize = 16;
+
+/// Accumulated frame damage: up to [`MAX_DAMAGE_RECTS`] changed rectangles `(x1, y1, x2, y2)` since
+/// the last GRABPIX. `count == 0` means nothing was recorded (GRABPIX falls back to a full frame).
+#[derive(Copy, Clone)]
+pub(crate) struct Damage {
+    pub(crate) rects: [(i32, i32, i32, i32); MAX_DAMAGE_RECTS],
+    pub(crate) count: usize,
+}
+
+impl Damage {
+    pub(crate) const fn new() -> Self {
+        Self {
+            rects: [(0, 0, 0, 0); MAX_DAMAGE_RECTS],
+            count: 0,
+        }
+    }
+
+    /// Record a changed rectangle. When the list is full, collapse everything (including `r`) into a
+    /// single bounding box so a burst of damage never drops updates -- it just gets coarser.
+    pub(crate) fn push(&mut self, r: (i32, i32, i32, i32)) {
+        if self.count < MAX_DAMAGE_RECTS {
+            self.rects[self.count] = r;
+            self.count += 1;
+            return;
+        }
+        let mut bb = r;
+        for i in 0..self.count {
+            let (x1, y1, x2, y2) = self.rects[i];
+            bb = (bb.0.min(x1), bb.1.min(y1), bb.2.max(x2), bb.3.max(y2));
+        }
+        self.rects[0] = bb;
+        self.count = 1;
+    }
+
+    pub(crate) fn clear(&mut self) {
+        self.count = 0;
+    }
+}
+
+impl PainterState {
+    pub(crate) fn new() -> Self {
+        Self {
+            connected: false,
+            cursor_events_enabled: false,
+            frame_dirty: false,
+            damage: Damage::new(),
+        }
+    }
+}
+
+// SAFETY: each of these event structs is `#[repr(C)]` with a `drm_event`-layout header
+// (`uapi::DrmEvent`, identical to `bindings::drm_event`) as its first field, is `Copy`
+// plain-old-data, and is copied verbatim to userspace. See `uapi.rs`.
+unsafe impl EventPayload for uapi::DrmEvdiEventUpdateReady {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_UPDATE_READY;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventDpms {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_DPMS;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventModeChanged {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_MODE_CHANGED;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventCrtcState {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_CRTC_STATE;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventCursorSet {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_CURSOR_SET;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventCursorMove {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_CURSOR_MOVE;
+}
+// SAFETY: See above.
+unsafe impl EventPayload for uapi::DrmEvdiEventDdcciData {
+    const TYPE: u32 = uapi::DRM_EVDI_EVENT_DDCCI_DATA;
+}
+
+/// Zeroed `drm_event` header; [`EventChannel::send`] overwrites `type`/`length`.
+const fn hdr() -> uapi::DrmEvent {
+    uapi::DrmEvent {
+        type_: 0,
+        length: 0,
+    }
+}
+
+/// Tell the DLM client a fresh frame is ready to be grabbed (`UPDATE_READY`).
+pub(crate) fn notify_update_ready(data: &EvdiDrmData, dev: &EvdiDrmDevice) {
+    let ev = uapi::DrmEvdiEventUpdateReady { base: hdr() };
+    let _ = data.events.send(dev, ev);
+}
+
+/// Tell the DLM client the display's DPMS power state changed.
+pub(crate) fn notify_dpms(data: &EvdiDrmData, dev: &EvdiDrmDevice, mode: i32) {
+    let ev = uapi::DrmEvdiEventDpms { base: hdr(), mode };
+    let _ = data.events.send(dev, ev);
+}
+
+/// Tell the DLM client the cursor moved to `(x, y)`.
+pub(crate) fn notify_cursor_move(data: &EvdiDrmData, dev: &EvdiDrmDevice, x: i32, y: i32) {
+    let ev = uapi::DrmEvdiEventCursorMove { base: hdr(), x, y };
+    let _ = data.events.send(dev, ev);
+}
+
+/// Tell the DLM client the cursor bitmap/geometry changed. `buffer_handle` is a GEM handle to the
+/// cursor bitmap in the client's file (0 = no bitmap / cursor hidden).
+#[allow(clippy::too_many_arguments)]
+pub(crate) fn notify_cursor_set(
+    data: &EvdiDrmData,
+    dev: &EvdiDrmDevice,
+    hot_x: i32,
+    hot_y: i32,
+    width: u32,
+    height: u32,
+    enabled: bool,
+    buffer_handle: u32,
+    buffer_length: u32,
+    pixel_format: u32,
+    stride: u32,
+) {
+    let ev = uapi::DrmEvdiEventCursorSet {
+        base: hdr(),
+        hot_x,
+        hot_y,
+        width,
+        height,
+        enabled: enabled as u8,
+        buffer_handle,
+        buffer_length,
+        pixel_format,
+        stride,
+    };
+    let _ = data.events.send(dev, ev);
+}
+
+/// Tell the DLM client the negotiated mode changed.
+pub(crate) fn notify_mode_changed(
+    data: &EvdiDrmData,
+    dev: &EvdiDrmDevice,
+    hdisplay: i32,
+    vdisplay: i32,
+    vrefresh: i32,
+    bits_per_pixel: i32,
+    pixel_format: u32,
+) {
+    let ev = uapi::DrmEvdiEventModeChanged {
+        base: hdr(),
+        hdisplay,
+        vdisplay,
+        vrefresh,
+        bits_per_pixel,
+        pixel_format,
+    };
+    let _ = data.events.send(dev, ev);
+}
diff --git a/drivers/gpu/drm/evdi/uapi.rs b/drivers/gpu/drm/evdi/uapi.rs
new file mode 100644
index 000000000000..75b245f20d9b
--- /dev/null
+++ b/drivers/gpu/drm/evdi/uapi.rs
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Userspace ABI for the EVDI DRM driver.
+//
+// This is a byte-for-byte Rust mirror of the C uAPI header
+// `evdi/module/evdi_drm.h` (DisplayLink (UK) Ltd.). It is reproduced here rather
+// than pulled from `kernel::uapi` because EVDI is an out-of-tree driver with its
+// own private ioctl range; the struct layouts and ioctl numbers MUST stay
+// identical to the C module so existing userspace (libevdi / DisplayLinkManager)
+// keeps working unchanged.
+//
+// Every structure is `#[repr(C)]`; user pointers are represented as `usize` so the
+// native (LP64/ILP32) ABI width matches the C `T __user *` exactly. Compile-time
+// assertions at the bottom pin each `size_of` to the value the C ABI produces.
+
+#![allow(dead_code)]
+
+use kernel::drm::ioctl::{IO, IOWR};
+
+/// DRM driver-private ioctl base (`DRM_COMMAND_BASE`).
+pub(crate) const DRM_COMMAND_BASE: u32 = 0x40;
+
+// --- Output event type codes (driver -> libevdi), `drm_event::type` values. ---
+pub(crate) const DRM_EVDI_EVENT_UPDATE_READY: u32 = 0x8000_0000;
+pub(crate) const DRM_EVDI_EVENT_DPMS: u32 = 0x8000_0001;
+pub(crate) const DRM_EVDI_EVENT_MODE_CHANGED: u32 = 0x8000_0002;
+pub(crate) const DRM_EVDI_EVENT_CRTC_STATE: u32 = 0x8000_0003;
+pub(crate) const DRM_EVDI_EVENT_CURSOR_SET: u32 = 0x8000_0004;
+pub(crate) const DRM_EVDI_EVENT_CURSOR_MOVE: u32 = 0x8000_0005;
+pub(crate) const DRM_EVDI_EVENT_DDCCI_DATA: u32 = 0x8000_0006;
+
+/// Fixed DDC/CI payload size carried by [`DrmEvdiEventDdcciData`].
+pub(crate) const DDCCI_BUFFER_SIZE: usize = 64;
+
+/// `struct drm_event` — the common header every DRM event starts with.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvent {
+    pub type_: u32,
+    pub length: u32,
+}
+
+/// `struct drm_evdi_event_update_ready`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventUpdateReady {
+    pub base: DrmEvent,
+}
+
+/// `struct drm_evdi_event_dpms`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventDpms {
+    pub base: DrmEvent,
+    pub mode: i32,
+}
+
+/// `struct drm_evdi_event_mode_changed`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventModeChanged {
+    pub base: DrmEvent,
+    pub hdisplay: i32,
+    pub vdisplay: i32,
+    pub vrefresh: i32,
+    pub bits_per_pixel: i32,
+    pub pixel_format: u32,
+}
+
+/// `struct drm_evdi_event_crtc_state`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventCrtcState {
+    pub base: DrmEvent,
+    pub state: i32,
+}
+
+/// `struct drm_evdi_event_cursor_set`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventCursorSet {
+    pub base: DrmEvent,
+    pub hot_x: i32,
+    pub hot_y: i32,
+    pub width: u32,
+    pub height: u32,
+    pub enabled: u8,
+    pub buffer_handle: u32,
+    pub buffer_length: u32,
+    pub pixel_format: u32,
+    pub stride: u32,
+}
+
+/// `struct drm_evdi_event_cursor_move`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventCursorMove {
+    pub base: DrmEvent,
+    pub x: i32,
+    pub y: i32,
+}
+
+/// `struct drm_evdi_event_ddcci_data`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEventDdcciData {
+    pub base: DrmEvent,
+    pub buffer: [u8; DDCCI_BUFFER_SIZE],
+    pub buffer_length: u32,
+    pub flags: u16,
+    pub address: u16,
+}
+
+// --- Input ioctl argument structures (libevdi -> driver). ---
+
+/// `struct drm_evdi_connect`. `edid` is a `const unsigned char __user *`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiConnect {
+    pub connected: i32,
+    pub dev_index: i32,
+    pub edid: usize,
+    pub edid_length: u32,
+    pub pixel_area_limit: u32,
+    pub pixel_per_second_limit: u32,
+}
+
+/// `struct drm_evdi_request_update`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiRequestUpdate {
+    pub reserved: i32,
+}
+
+/// `enum drm_evdi_grabpix_mode` (C `int`).
+pub(crate) const EVDI_GRABPIX_MODE_RECTS: i32 = 0;
+pub(crate) const EVDI_GRABPIX_MODE_DIRTY: i32 = 1;
+
+/// `struct drm_evdi_grabpix`. `buffer` and `rects` are `__user` pointers.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiGrabpix {
+    pub mode: i32,
+    pub buf_width: i32,
+    pub buf_height: i32,
+    pub buf_byte_stride: i32,
+    pub buffer: usize,
+    pub num_rects: i32,
+    pub rects: usize,
+}
+
+/// `struct drm_evdi_ddcci_response`. `buffer` is a `const unsigned char __user *`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiDdcciResponse {
+    pub buffer: usize,
+    pub buffer_length: u32,
+    pub result: u8,
+}
+
+/// `struct drm_evdi_enable_cursor_events`.
+#[repr(C)]
+#[derive(Copy, Clone)]
+pub(crate) struct DrmEvdiEnableCursorEvents {
+    pub base: DrmEvent,
+    pub enable: u8,
+}
+
+// --- Input ioctl command numbers (`DRM_IOCTL_EVDI_*`). ---
+pub(crate) const DRM_EVDI_CONNECT: u32 = 0x00;
+pub(crate) const DRM_EVDI_REQUEST_UPDATE: u32 = 0x01;
+pub(crate) const DRM_EVDI_GRABPIX: u32 = 0x02;
+pub(crate) const DRM_EVDI_DDCCI_RESPONSE: u32 = 0x03;
+pub(crate) const DRM_EVDI_ENABLE_CURSOR_EVENTS: u32 = 0x04;
+
+/// `DRM_IOCTL_EVDI_CONNECT`.
+pub(crate) const DRM_IOCTL_EVDI_CONNECT: u32 =
+    IOWR::<DrmEvdiConnect>(DRM_COMMAND_BASE + DRM_EVDI_CONNECT);
+/// `DRM_IOCTL_EVDI_REQUEST_UPDATE`.
+pub(crate) const DRM_IOCTL_EVDI_REQUEST_UPDATE: u32 =
+    IOWR::<DrmEvdiRequestUpdate>(DRM_COMMAND_BASE + DRM_EVDI_REQUEST_UPDATE);
+/// `DRM_IOCTL_EVDI_GRABPIX`.
+pub(crate) const DRM_IOCTL_EVDI_GRABPIX: u32 =
+    IOWR::<DrmEvdiGrabpix>(DRM_COMMAND_BASE + DRM_EVDI_GRABPIX);
+/// `DRM_IOCTL_EVDI_DDCCI_RESPONSE`.
+pub(crate) const DRM_IOCTL_EVDI_DDCCI_RESPONSE: u32 =
+    IOWR::<DrmEvdiDdcciResponse>(DRM_COMMAND_BASE + DRM_EVDI_DDCCI_RESPONSE);
+/// `DRM_IOCTL_EVDI_ENABLE_CURSOR_EVENTS`.
+pub(crate) const DRM_IOCTL_EVDI_ENABLE_CURSOR_EVENTS: u32 =
+    IOWR::<DrmEvdiEnableCursorEvents>(DRM_COMMAND_BASE + DRM_EVDI_ENABLE_CURSOR_EVENTS);
+
+// Silence unused-import warnings until the no-arg `IO` helper is needed.
+const _: fn(u32) -> u32 = IO;
+
+// --- ABI size assertions: these must match the C `sizeof` on LP64. ---
+const _: () = {
+    assert!(core::mem::size_of::<DrmEvent>() == 8);
+    assert!(core::mem::size_of::<DrmEvdiEventUpdateReady>() == 8);
+    assert!(core::mem::size_of::<DrmEvdiEventDpms>() == 12);
+    assert!(core::mem::size_of::<DrmEvdiEventModeChanged>() == 28);
+    assert!(core::mem::size_of::<DrmEvdiEventCrtcState>() == 12);
+    assert!(core::mem::size_of::<DrmEvdiEventCursorSet>() == 44);
+    assert!(core::mem::size_of::<DrmEvdiEventCursorMove>() == 16);
+    assert!(core::mem::size_of::<DrmEvdiEventDdcciData>() == 80);
+    assert!(core::mem::size_of::<DrmEvdiConnect>() == 32);
+    assert!(core::mem::size_of::<DrmEvdiRequestUpdate>() == 4);
+    assert!(core::mem::size_of::<DrmEvdiGrabpix>() == 40);
+    assert!(core::mem::size_of::<DrmEvdiDdcciResponse>() == 16);
+    assert!(core::mem::size_of::<DrmEvdiEnableCursorEvents>() == 12);
+};
-- 
2.55.0

