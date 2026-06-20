Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF1CD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831F910E153;
	Sat, 20 Jun 2026 00:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mBLt16+P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCB410E157
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 930CA601E3;
 Sat, 20 Jun 2026 00:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400E51F00A3A;
 Sat, 20 Jun 2026 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917190;
 bh=nb95b2mU5Ycavg5y1EHbRzPGUT2j36KtAv/8J6khfJc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mBLt16+PANIsTvmFLUj8G+2KHxP6e+9XsL5oerxIS1PfLe4WdXpkqCu8UYTqQ9hVZ
 tz2t77+/hFwr+f/tOONhHNR5zMf8DLUrm/NCAdmnTi1bb0QH3iUfCtJZO4pDU5/J35
 BFfhB0qXh7t5fZl7SufuUwS3hGYSsVsTxyWWVUeCHgvIz6sWiJxaw6U4qDJ8efyq9i
 sj2GJJ1yiby7d/Ied9QoL4Zh45LLF6SxIMxaE6knUgRPNYxLbtK1waeTIJdsjew3cG
 ZhCT+5MmRtqtkr5Tor4CJ6M37r7Q69DTNWqWPs2Sz8ABEht2TUQwLUiWGkF3XbZIrA
 uoC71iqb63C1Q==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 11/13] rust: drm: Wrap ioctl dispatch in RegistrationGuard
Date: Sat, 20 Jun 2026 02:51:23 +0200
Message-ID: <20260620005431.1562115-12-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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

Run every ioctl handler inside a drm_dev_enter/exit critical section via
RegistrationGuard. If the device has been unplugged, the ioctl returns
ENODEV without calling the handler.

A never-called closure anchors the driver type for the compiler by tying
dev's type to the handler's first parameter, which the compiler cannot
infer through method resolution and associated-type projections alone.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..c6a03be018e6 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -87,7 +87,10 @@ pub mod internal {
 ///        file: &kernel::drm::File<Self::File>,
 /// ) -> Result<u32>
 /// ```
-/// where `Self` is the drm::drv::Driver implementation these ioctls are being declared within.
+/// where `Self` is the `drm::Driver` implementation these ioctls are being declared within.
+///
+/// The ioctl runs inside a `drm_dev_enter/exit` critical section. If the device has been
+/// unplugged, the ioctl returns `ENODEV` without calling the handler.
 ///
 /// # Examples
 ///
@@ -135,6 +138,16 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev = $crate::drm::device::Device::from_raw(raw_dev);
+
+                            // Type-inference anchor: the closure is never called but ties `dev`'s
+                            // type to `$func`'s first parameter, which the compiler cannot infer
+                            // through method resolution and associated-type projections alone.
+                            #[allow(unreachable_code)]
+                            let _ = || $func(dev, unreachable!(), unreachable!());
+
+                            let Some(_guard) = dev.registration_guard() else {
+                                return $crate::error::code::ENODEV.to_errno();
+                            };
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
-- 
2.54.0

