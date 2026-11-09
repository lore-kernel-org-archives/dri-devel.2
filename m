Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8A606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyrpRDum
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F6C10E337;
	Mon,  9 Nov 2026 00:37:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F48B10E43E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DF1361EE4;
 Mon,  9 Nov 2026 00:37:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184625;
 b=MXqXjV5dxiz2VNpW6fngmB2JvYVm4X0mLy4bhnwTLI65N6IER4irCOyM6uwTcLeGJB5N
 2GIeWmZxVzY2G4ym+DkeMWkccMxsdOziQh5oUzJLc86Ne/olEVgea7bGzh6uhWblGhhAi
 +J4xv4gufiCq0bydXT6H5lGDxwpppQgw8RdePf71DjVIftC6fktFMEXH0SBdre5bX0XZv
 hfNbig2kBhVydkqw0eW0NrfOnCH9smEZ9oOpKLJPcNHMwJMOr85b8Z6t1VmgtMZZVOGQF
 MpnKVnOTZlmK/YL0+pppGYDPTQGSKuijmb4aHSOV1VpXUn8Gwl+fMWn/m0ChR2THEhg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184625;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=+VunOW8apSr7yIsryRx75d0Wg1VjgAKZRdL/2W/A7qI=;
 b=IP9u3f26ElG8ECi8lwIt8IGLnBQ9RkeGBbV0k9Up24N5y+Cqmy/vraR3cbihHEscXk9y
 JzLL/ThTKgmkWYQj6RfEhqtIfrXb8Inyce16CDFsIVSMxy0QpnUfd+hGiz/odXSLsFdL0
 G9aQ6i7hJnu+4JILi6aVC/6FKoesh9qtG77ddDbaA21N8M3Lvql7yOjqT/6YCHbUL96y7
 IhnO96P0cL7yn4N/kh4klYxVnto8Tbz3upnelQQyRea5PVbUCyRuCyawYWfQt2nTU9FJ2
 FfPlzEAei8ADtItaIH0dJ5uijiGviiD2k8keqS9unPFvphkkLyY4zULmt4kAjdBdEoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 371CB1F008AB;
 Mon,  9 Nov 2026 00:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184625;
 bh=+VunOW8apSr7yIsryRx75d0Wg1VjgAKZRdL/2W/A7qI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=GyrpRDumK9ojsisvWXUm+6fknn7WLbRsoIaH/7tMYYauPfkEPHjl9JzaDSubF59z7
 +Xm5sThoqEV9aWfk4MYO8z4fkHzim4vATR09yk8WYgXRJE5xUv6hr7LcEVCX1k3Yyw
 akPnCJ3yYVXThUeBaaAlxBRiDQ9pxQkcOkwCgUueJbo5zq4d8MnhL5WTfTd+6c3R18
 rAVmH7KHKZjCHMv2UfLLuhkjTnYMogM7sISB2TO5mnvl0xb4lC7SOKVSYHx7EJxALY
 A8Cf++07pdQgsAdN8aOT4Ah+ndOR/EgrDuGqGzNJceqQdcrff2srthTFxepCVj6wmP
 Kspdjw5454yeA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8B775481C1;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 08:36:51 +0800
Subject: [PATCH v6 08/10] rust: device: expose the device DMA attribute
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-tyr-ioctls-v6-8-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
In-Reply-To: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=2065;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=KscORanvQ0VZef2aYPEycjX8LK9CDe570yZ9DPQhtQk=;
 b=p/fazEev6d7nnTlJDgNhn09Xi7loDcvwOz7D8Hd2NAetnnuf7Zhp5dWEZqB+uQB3JCNzMcAL8
 2/OxSdh97ezCz5YHhQN9ucvMR8lZ35z8Vt0aZ4k3TwvtIM6oxLOd+/v
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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


