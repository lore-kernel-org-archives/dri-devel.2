Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF69606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=j8bwl2aY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECF510E5CF;
	Sun, 22 Nov 2026 13:03:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D13C10E59A
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4461745018;
 Sun, 22 Nov 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795352574;
 b=l0ILuEfYSXHDjcs/XHN412R4okajkYl3/iozlgTqz0YCsjc/2MynZcESDPduPm3B9ZTe
 NHuu1vdYo7a8w+cXPtU4sO76o+m+hLSWDznbsvzJ49u6sGfqapv5y2iez6/xZ+JWbeHTc
 gOLdjB/uoEV3+1EwF4WHeBLHrWoo0aobmL/xw+Xr68zMQIflk3q8TD81EmtH1SO6UQ/4X
 880ITAhZaPDgGT6PrfrIUrmrKYRnhFRd3Q2DsKAQgR4ytulB00VqCqK1IhHqaI69YXVix
 Ycoo3iuFIFhTBj3Z11nP+5C0SvDkobLlY6szj5n1Pcv/DtY1B4GXDIktLIuXkenjxyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795352574;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
 bh=+VunOW8apSr7yIsryRx75d0Wg1VjgAKZRdL/2W/A7qI=;
 b=aemNWWQ7VxdsggkTW8A5Nz5TGt0QjR9sYS9cEMVR9b6Thf+UtD80W4uXKaLe55VkVr9P
 23SClAu/IdLb7KnkGJsMBFpdzqQFhlVnDeTUH62MW4Oovt43Sgbk1F5SaZgVye+5698z0
 L5UgB63qLRPCnHH8hDcoBVm/0MljOvRUS0FWe02kqHavAniFM4QpUOt0TKFiHjaOiG82s
 vskafyH/2BuPdzNVIWtISHJDNgH60lIQJHUrH4HoazIKFVo02qFe4TMJxJKkAvvkKVgPy
 NCuo0fVHSSzd+pqybwGixXQfqb91ABzm/dx2fTGln5nGoue1b9F5FN+CCRCSSOCEi8A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D11991F000EB;
 Sun, 22 Nov 2026 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
 t=1795352574; bh=+VunOW8apSr7yIsryRx75d0Wg1VjgAKZRdL/2W/A7qI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j8bwl2aYHXGx/fp8BxCyroRZoD4J4wLIJBZDrcC2lRINnfHsccvk3Zl+5QlXMIjRe
 Df4UftG7zUlIKG0mFn461d2V8eLnmW2gCKT5FawkFcgCQKM6d4e43kIuoZXcOlhxaM
 x5TMJGnfUb6QiMWoYy4G6t6dgZaYO3IzVSHdnWI0=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 83E634C06B;
 Sun, 22 Nov 2026 13:02:34 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sun, 22 Nov 2026 20:50:27 +0800
Subject: [PATCH v7 08/10] rust: device: expose the device DMA attribute
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tyr-ioctls-v7-8-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
In-Reply-To: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795352551; l=2065;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=KscORanvQ0VZef2aYPEycjX8LK9CDe570yZ9DPQhtQk=;
 b=1mwtUwK8KRgY2r1xCv65FA9DeLlUC9wYJdBSFNfSUJmtbEnnzKjFFYGEkr8C4VhPE4DJlgn8M
 KYj4TY2QcfHDezk6XXyXpjQnxqJYBYrXEODlGvONxI2bRyLCQvY0037
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

A driver may need to know whether its device is DMA-coherent, but
rust/kernel exposes no accessor for the attribute today.

Add a transparent DmaAttr wrapper around device_get_dma_attr(), with
the three attribute values (unset, non-coherent, coherent) exposed as
constants, so drivers can compare against the exact attribute they
care about.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/device.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..c6381d47f51e8 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -260,6 +260,33 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
     }
 }
 
+/// The DMA attribute of a device, as reported by firmware. A transparent
+/// wrapper around the kernel's `enum dev_dma_attr`, covering all its states.
+#[repr(transparent)]
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct DmaAttr(bindings::dev_dma_attr);
+
+impl DmaAttr {
+    /// The device has no reported DMA attributes.
+    pub const NOT_SUPPORTED: Self = Self(bindings::dev_dma_attr_DEV_DMA_NOT_SUPPORTED);
+
+    /// The device is not DMA-coherent.
+    pub const NON_COHERENT: Self = Self(bindings::dev_dma_attr_DEV_DMA_NON_COHERENT);
+
+    /// The device is DMA-coherent.
+    pub const COHERENT: Self = Self(bindings::dev_dma_attr_DEV_DMA_COHERENT);
+}
+
+impl Device<Bound> {
+    /// Returns the DMA attribute of the device as reported by firmware.
+    #[inline]
+    pub fn dma_attr(&self) -> DmaAttr {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer
+        // to a `struct device`.
+        unsafe { DmaAttr(bindings::device_get_dma_attr(self.as_raw())) }
+    }
+}
+
 impl<Ctx: DeviceContext> Device<Ctx> {
     /// Obtain the raw `struct device *`.
     pub(crate) fn as_raw(&self) -> *mut bindings::device {

-- 
2.43.0


