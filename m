Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7D60A261D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDQ4lOB4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAAC10F3BF;
	Tue, 20 Oct 2026 08:26:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C38310F380
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:25:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8024447AA;
 Tue, 20 Oct 2026 08:25:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792484750;
 b=RSuHTXSzWN0sQcP5o9TJj14ZeCGDKdl7WxeKqR9nT360e2n1X26qla3qblAWVkTfnjBF
 AyrFjUNZrZF4CcRcHaXQ/ygUwgN5UEz7tLL4b39IQcq5MEKdbheF4cZGYBKVhdMazWn2M
 zXDZrMvyaArLMHnyAuyDBKMugqfMUiDnGRDUGCFRZYRDPIfkjrM9Uh8JMsGn+U9UXGj6g
 JX3+0MsEUoW23JPzBf7uL0sG1kv6c2B/iwqDIg1zeQa9u9He/Ev2Yvm1gls1PWg2MDl7i
 3NCIUbkLglebXwr6s5Wrqc2/SM5HhCvjTpUpp3Z4XvhpVlQFH8fpXIHtpAoXMMs6CGg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484750;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=eipZCh/aZVOWGyKk+tem6Pf9Se2oB9+JhA06IxGI1NU=;
 b=j4ireNCZnalx+Ak3deDrHdFV+ASseu5Mh6oIHNGMec9lhXL3dST04NWuQ9b4+bpmaoAw
 Q3HH7R0iURJ6LmsQhEOVMQW8YmrCJRL+IkX1pHEbgSUF3gHQ5xnGVIQZb1zNL5An2XDus
 +0WjcNEXRofRtmUyCknwG4lV162oSZSFgVex1lfmvtX6NRqCUk2EnrC3s0Ih8GRVCeklw
 9ePyVy9N+5lbq6adkV0rFXOUuRzJuDJX0Z8Q96KnS8zXXOqWnaHESk1huCyX4aBnlmIJi
 aSE8/OK0ZSu7Qo8nfMcDBtch3KYsWKBSQ0t7iNFnorci4dMmiIulZPYMlMkRq1+LQXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7DE641F000C7;
 Tue, 20 Oct 2026 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484750;
 bh=eipZCh/aZVOWGyKk+tem6Pf9Se2oB9+JhA06IxGI1NU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=aDQ4lOB4hjajqMG4r0KB58/c2bd0ffmQDsBuKIcBqqrz2a3xB2QsxjlRmz85Fifiu
 tmYj1B8WBaseUZIn14EJW2vmDqXunJifI53uwj2Exk+t2s9SjxuWTq6mo9O9DPuZQV
 BW58tEU00WZfkNWgghHwevjnZ1AJPaYfwFwSWIOiS4JO1Z+V2xfLHhl9CheUZgSLzC
 /OLqQ7QeEnOmQkoUT7hBapXMmKXTLG4t1yUoT2lgu4llEIFrIjHr1mB7cg9mh1SmTv
 XTcCBYZitlrjBT9sTcNdvIx5QXiFbCv/bxIhepprdPFpunMKE/gv7tY2tvcDQamSHG
 fevkbnEBxxbwg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DF14F430F4;
 Tue, 20 Oct 2026 08:25:45 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 20 Oct 2026 16:25:26 +0800
Subject: [PATCH v4 09/11] rust: device: expose the device DMA attribute
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-tyr-ioctls-v4-9-704de77da223@kylinos.cn>
References: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
In-Reply-To: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev, Ke Sun <sunke@kylinos.cn>, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792484721; l=1995;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=mEXxKt/y8TdcnvMGSXY8Zt74eqKKEsHMFWEDUBLN0a0=;
 b=rGNNKJ6DXMUQnJb0hmAg2jlqt22qnLX6QZ7JwuDJy+nw0lj1DqU61HmQ1QPLBKyQQAh3msXN9
 aWB1Ggq6SgIAzjWPDh4emO2EBENlEk9L3pzTJn9O96ZOU46+bf8S+dh
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

A driver may need to know whether its device is DMA-coherent, but
rust/kernel exposes no accessor for the attribute today.

Add a transparent DmaAttr wrapper around device_get_dma_attr(), so all
three attribute values (unset, non-coherent, coherent) are covered, and
an is_coherent() accessor for the boolean case.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[ Replace dma_coherent() with a DmaAttr wrapper covering all three
  attribute values. - Alvin ]
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/device.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849e..d5bbebdf620df 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -260,6 +260,30 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
     }
 }
 
+/// The DMA attribute of a device, as reported by firmware. A transparent
+/// wrapper around the kernel's `enum dev_dma_attr`, covering all its states.
+#[repr(transparent)]
+pub struct DmaAttr(bindings::dev_dma_attr);
+
+impl DmaAttr {
+    /// This wraps `device_get_dma_attr()` and only returns `true` for the
+    /// `DEV_DMA_COHERENT` attribute; no attribute or `DEV_DMA_NON_COHERENT` is non-coherent.
+    #[inline]
+    pub fn is_coherent(&self) -> bool {
+        self.0 == bindings::dev_dma_attr_DEV_DMA_COHERENT
+    }
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


