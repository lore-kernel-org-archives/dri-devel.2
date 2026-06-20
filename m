Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10939CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E69610E260;
	Sat, 20 Jun 2026 18:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ByBhZ6dp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5615010E25F
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E24640BF0;
 Sat, 20 Jun 2026 18:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134831F00A3A;
 Sat, 20 Jun 2026 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981435;
 bh=KFJ9mabhkd7kILJb6BTUl2kHITK1D6P5rN1TZpv75Us=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ByBhZ6dpqUTglBuEc9vlyV4gEiMkr5+pwsAaWM1pOitCzCmqtwSSWEQ9myXCqewLR
 U8wlMJEBhTwN6Zd1V+L9iJ0SmWzk3k587XfFv4WgFbbtYo0lPTSDLjgiJD0Pp0m41y
 0/IzAteYtMbCA9iepQ8+BnKVoRZSEMIxzDPBC0r8ALzu1Zi/F2UEGxSgIqbzYQjTHE
 uS6kOn4fOQlY3xxPTS4Ww5uiECDxJX21Dp6LX/9QW0oWIx6HQwl1o7T/wxgFBvFyoG
 Ygzue0y/322EG/pNomBGERfDuDDyjCLmMgoxuSj6FSD/AcprvoyAAGakbmxnYMllsG
 gAppsLuRC9Rxg==
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
Subject: [PATCH v4 13/16] rust: drm: add AsRef<ParentDevice<Bound>> for
 Device<Registered>
Date: Sat, 20 Jun 2026 20:48:06 +0200
Message-ID: <20260620184924.2247517-14-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620184924.2247517-1-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
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
index 45bacd7b227f..8f63276c9b62 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -462,6 +462,19 @@ fn as_ref(&self) -> &T::ParentDevice<device::Normal> {
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

