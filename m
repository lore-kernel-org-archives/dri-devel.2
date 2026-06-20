Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0930ACD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C9410E14F;
	Sat, 20 Jun 2026 00:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iqJEeNUq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAF110E14F
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1436E601E3;
 Sat, 20 Jun 2026 00:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62D61F000E9;
 Sat, 20 Jun 2026 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917176;
 bh=AqEc8Skog6vIUTw0jxfNwWfNAkCPrlqbkNpROZYy0V0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iqJEeNUq03PKUkUUgju2SBLSTmijw1AyLdRY/vRBxOxLlZfO00WazbyS3X2hIBqGn
 hlkJ7g9c71axynHBMIIO20F0S8YYn6Lrno4CHqi9bfcwey98M0TGmxOMfyyTolDjbk
 J7V4C8xhZrNciHmWfEUGHKD4r8Ssb1gv0fP3BX7wVzUrDTPtWW9EEElFaaXClChfdA
 RqLVTOrxhXYJgSPvcehZdLiBtYcjZgTOn/vPcQx9nFFCvbabbOKIN4DEYPfxp0jt7V
 fP8sMNL+No78sOpHMr9TEIbuwiA1R3gJgPHJh/MTiUZDac8bQWNit+6vvhloC7QCJr
 fwlw4zVVjhWfg==
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
Subject: [PATCH v3 08/13] rust: drm: add AsRef<ParentDevice<Bound>> for
 Device<Registered>
Date: Sat, 20 Jun 2026 02:51:20 +0200
Message-ID: <20260620005431.1562115-9-dakr@kernel.org>
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

Implement AsRef<T::ParentDevice<Bound>> for Device<T, Registered>,
providing access to the bound parent bus device for registered DRM
devices.

Since a Device<T, Registered> guarantees that the parent bus device is
bound, the conversion to T::ParentDevice<Bound> is safe.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 6fdd9fb1ae7f..885077e270eb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -371,6 +371,19 @@ fn as_ref(&self) -> &T::ParentDevice<device::Normal> {
     }
 }
 
+impl<T: drm::Driver> AsRef<T::ParentDevice<device::Bound>> for Device<T, Registered> {
+    fn as_ref(&self) -> &T::ParentDevice<device::Bound> {
+        let dev = (**self).as_ref().as_ref();
+
+        // SAFETY: A `Device<T, Registered>` guarantees that the parent device is bound.
+        let dev = unsafe { dev.as_bound() };
+
+        // SAFETY: By the type invariant of `Device`, the parent device is embedded in
+        // `T::ParentDevice`.
+        unsafe { device::AsBusDevice::from_device(dev) }
+    }
+}
+
 // SAFETY: A `drm::Device` can be released from any thread.
 unsafe impl<T: drm::Driver, C: DeviceContext> Send for Device<T, C> {}
 
-- 
2.54.0

