Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9122C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B88E10F604;
	Fri,  3 Jul 2026 03:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="VNhvvWHm";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099CD10F604
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:58 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-475417f010dso40518f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047716; x=1783652516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQKoTdpL3C59oAuYFMvqcsWz7tbnOArYDM8BYFAHWQk=;
 b=VNhvvWHmS+ZBQakspQy6fQOMLKO4tzcoZYpaYT0n8rhGq8snS7eFzMr4cK7x3+s7qC
 ZHCGilpqTBrRmV/5+M/xwMGMNnwdFwpAjlY8SSiznD3JZRpW44LcobNff4bugjIO4cFl
 hSPyKxnHhzn4Bzo56Od+DTIOppMKDjYAx56ydx9GsZ1vC8WGxBMypC2/NIt2iobYWRW9
 EQHd1gCXGxekUaOmD5pKucQlQHfW1Dnd5n1z0YQeu8NI0dghl06AtyfX/oJnfixuyTUQ
 A3Xqn+3sFxLQufR95R4B21mlqoi5k8BwLDW1FeuMkQOVRuNL6UvoshT7uP347sKKN19W
 ludQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047716; x=1783652516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aQKoTdpL3C59oAuYFMvqcsWz7tbnOArYDM8BYFAHWQk=;
 b=kZmtzie2rCiv1Au5ipUl24eOjjWUndXhCEhHEOwGt/VeDWU9xqty1GBUbrLBjR2IsI
 9kV5NvUdSxJmiJoa4mr6IPwMSquwG84VBuSKqPmc1BG6bHarPPzEv5OJVngLr/6xA2S7
 k4er+hRUivkBGi9lkmG7/FwJ0MGW5bk9k0G0ikp9IDm9hJwGj81wu7ZCfk8PI0lFP4up
 xOaD2PpHE/Hf7CT2+l1+H9KeKkMDurhaYTBdh3Jx4+jou6JPrzu38DVj3ZEQhJOvnmQL
 gvNFlS6baAhrgCACUpD6DyoYyvrS7e4SRiOXjjxJQVZ7f8DcLK9caVmoA//EuyOAccot
 r5ng==
X-Gm-Message-State: AOJu0YyAh/XNVEmBoJcEGRVniUXAZeTOXS92GEUIMI5vmYOCVzEoQGZD
 wkpjMvSKoj09Juhlf0eBU6zcC0PaduL2WiKujBaNVAk6LM+nIYy/BOjS7Jqboi//FQ==
X-Gm-Gg: AfdE7cmrPMixmSNQ9tjyVBXP/d5dpLs17poWKqrzSzmR53nW9WHwldCP6zez7RKg0cz
 F0XqQOKjH0QTCY90R9gJWhx0WIe4sYQQ8ejGzEjAAcvVKnLerTmuI6y4p/Q2YSzwmqwDnd65sAr
 O60UynVjyMLgaWDzkQFUJFFEB10+ACSEjhNfEI0Dhe4MVTIfS1iu0IeAambFNX+xfZuNckgUYpo
 UZS73FZ0Sx6K9uGd8qfG70TDGxDiXABmKGPyAEsD4iRuuZIDAgt3C8MTe/G1C7IEPWM33yL2KR9
 iWSt9U5mc+nz7EzHU8DU7W9yVn+KPeIFQS5EanFAFJ7GbV6RUSCiKxfhXwFf2Fz54wvkJq5gTbS
 gmD43oZ8vwBgcf/E00AP5FOr2d1c3TaSCWOophEDCffdJufHpd7FeLIIExALwub/v5IEXNeupFC
 aUnVrb3og/fk7Kvaeks1xSAdsPRIXNdy4TgL19C2jTbHltUJVk4IIPKYV9
X-Received: by 2002:a05:6000:604:b0:476:504f:788 with SMTP id
 ffacd0b85a97d-4775a4e3e69mr12347740f8f.61.1783047716282; 
 Thu, 02 Jul 2026 20:01:56 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/18] rust: drm: allow drivers to declare ioctls from
 their own uAPI module
Date: Fri,  3 Jul 2026 04:00:57 +0100
Message-ID: <20260703030123.2814-11-mike@fireburn.co.uk>
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

declare_drm_ioctls! resolves each ioctl's argument_type and DRM_IOCTL_* number
from the in-tree kernel::uapi crate. An out-of-tree driver with its own private
DRM ioctl range (e.g. DisplayLink's evdi) cannot extend kernel::uapi, so it
cannot use the macro at all.

Add declare_drm_ioctls_ext!, which takes the argument type and the fully-formed
ioctl number directly per entry:

    (handler_name, argument_type, ioctl_number, flags, user_callback)

so a driver can keep its own #[repr(C)] uAPI mirror in its own crate and pass
crate::uapi::Foo / crate::uapi::DRM_IOCTL_FOO. The callback prototype, the
compile-time argument-size assertion against the ioctl number, and the
drm_dev_enter/exit critical section are identical to declare_drm_ioctls!, which
is left untouched (a caller-provided :path module cannot be glued to ::* / ::Ty
in a macro transcriber, so the two macros do not share an implementation).

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/ioctl.rs | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 181918303f2f..78169798bbbc 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -176,3 +176,89 @@ macro_rules! declare_drm_ioctls {
         };
     };
 }
+
+/// Declare the DRM ioctls for a driver whose uAPI lives outside `kernel::uapi`.
+///
+/// [`declare_drm_ioctls!`] resolves each `argument_type` and `DRM_IOCTL_*` number from the
+/// in-tree `kernel::uapi` crate, which an out-of-tree driver with its own private ioctl range
+/// cannot extend. This variant takes, per entry, the argument **type** and the fully-formed ioctl
+/// **number** directly, so the driver can keep its own `#[repr(C)]` uAPI mirror inside its own
+/// crate. Each entry is:
+///
+/// `(handler_name, argument_type, ioctl_number, flags, user_callback)`
+///
+/// `handler_name` is any identifier (used to name the generated trampoline and as the debug name);
+/// `argument_type` is the `#[repr(C)]` argument struct (any path, e.g. `crate::uapi::Foo`);
+/// `ioctl_number` is the full command number (e.g. `crate::uapi::DRM_IOCTL_FOO`, typically built
+/// with [`IOWR`]/[`IOR`]/[`IOW`]/[`IO`]). `user_callback` has the exact same prototype as for
+/// [`declare_drm_ioctls!`], and the handler still runs inside a `drm_dev_enter/exit` critical
+/// section (returning `ENODEV` if the device has been unplugged).
+///
+/// The ioctl array is indexed by the DRM core as `number - DRM_COMMAND_BASE`, so entries must be
+/// listed in ascending, contiguous order starting at the driver's command base.
+///
+/// # Examples
+///
+/// ```ignore
+/// kernel::declare_drm_ioctls_ext! {
+///     (EVDI_CONNECT, crate::uapi::DrmEvdiConnect, crate::uapi::DRM_IOCTL_EVDI_CONNECT,
+///         0, evdi_connect_ioctl),
+/// }
+/// ```
+#[macro_export]
+macro_rules! declare_drm_ioctls_ext {
+    ( $(($cmd:ident, $arg_ty:ty, $num:expr, $flags:expr, $func:expr)),* $(,)? ) => {
+        const IOCTLS: &'static [$crate::drm::ioctl::DrmIoctlDescriptor] = {
+            const _:() = {
+                // The argument struct size must match what the ioctl number encodes, so the DRM
+                // core copies exactly `size_of::<argument_type>()` bytes to/from userspace.
+                $(
+                    ::core::assert!(::core::mem::size_of::<$arg_ty>() ==
+                                    $crate::ioctl::_IOC_SIZE($num));
+                )*
+            };
+
+            let ioctls = &[$(
+                $crate::drm::ioctl::internal::drm_ioctl_desc {
+                    cmd: $num as u32,
+                    func: {
+                        #[allow(non_snake_case)]
+                        unsafe extern "C" fn $cmd(
+                                raw_dev: *mut $crate::drm::ioctl::internal::drm_device,
+                                raw_data: *mut ::core::ffi::c_void,
+                                raw_file: *mut $crate::drm::ioctl::internal::drm_file,
+                        ) -> core::ffi::c_int {
+                            // SAFETY: The DRM core keeps the device alive across the callback and
+                            // only dispatches here on a registered device.
+                            let dev = unsafe {
+                                $crate::drm::device::Device::from_raw(raw_dev)
+                            };
+                            let guard = match $crate::drm::device::unbind_guard(dev) {
+                                Some(g) => g,
+                                None => return $crate::error::code::ENODEV.to_errno(),
+                            };
+                            // SAFETY: The ioctl argument has size `_IOC_SIZE($num)`, asserted above
+                            // to match `size_of::<$arg_ty>()`; `drm_ioctl()` guarantees the buffer
+                            // is valid and exclusively owned for the duration of this call.
+                            let data = unsafe { &mut *(raw_data.cast::<$arg_ty>()) };
+                            // SAFETY: This is just the DRM file structure.
+                            let file = unsafe { $crate::drm::File::from_raw(raw_file) };
+
+                            match $func(dev, &*guard, guard.registration_data(), data, file) {
+                                Err(e) => e.to_errno(),
+                                Ok(i) => i.try_into()
+                                            .unwrap_or($crate::error::code::ERANGE.to_errno()),
+                            }
+                        }
+                        Some($cmd)
+                    },
+                    flags: $flags,
+                    name: $crate::str::as_char_ptr_in_const_context(
+                        $crate::c_str!(::core::stringify!($cmd)),
+                    ),
+                }
+            ),*];
+            ioctls
+        };
+    };
+}
-- 
2.55.0

