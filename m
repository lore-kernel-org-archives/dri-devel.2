Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8880C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DC110F0DF;
	Wed, 12 Aug 2026 19:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wBwRcEru";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="izth+783";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A28A10F0DF
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:53:07 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKzgP6CVqzKw21;
 Wed, 12 Aug 2026 21:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786564385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZHA54cdQJXUjeXWtjp31S+ctx/OQCZQTCDq5l2X/Kc=;
 b=wBwRcEruQaVFSRA1baX5KSOS1rXn0rlKKrzSscJgCR7zyCOuBI9hM/gbpbDVIuuECMYRPy
 p7KztIItKnk86X6uOZOztIn8QY0WU3+RiDJIaZifxomjY/qjbaHGY2T1FutgzmaipH9CDr
 hOyjcJX6lJkiWi3+OdNnZx0ZOJHQh+MKsX0nfqcm4pHg8G+AImES8iEx+qs4NJ0F/8wkqa
 doB8JqbYsDu5dBqJzFO1R/X3NBH6f9cjvk6YoLzZqL90TrAI7N25J4P/bKUFG7Lz6Nbcnr
 2JCZNjzsVuVihAcrlYSsZ6y68cSNS/NHJBD3DJqAR2VG13k/7AGG2fAGH7/ILw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=izth+783;
 spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786564384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZHA54cdQJXUjeXWtjp31S+ctx/OQCZQTCDq5l2X/Kc=;
 b=izth+7830+uza4uzGGB7+jTvwdT1CPZAt4MUYlMJC6e+LxkHxKtdQ+Q+qrSjKgZyazg308
 6p1q0eB2YfaZQuvj3Jf2W3tLXC5Ztb0EP5gco17bhezI26VJG+MP198/1sVocoLx2kgCmP
 2llbq3RW6vJGzYBPdiGcUrtOnOgYN9fP206T43bxG1GDi8YM/c8O7Biws409IYABr1hqUV
 viGGImILnjWxXgCcipYR7OD8ILZo1ymZwGNvMtRnGUrr2Cs66r+6ScJfio35SeJhhcnQlA
 F8YrRoknlNYTG/Sqf8BwJTR3ATsK3bklhrUwjlNAYSfJOL4mSNkLAPCBKZ0+Tw==
Date: Wed, 12 Aug 2026 21:52:37 +0200
Subject: [PATCH v3 3/5] rust: pci: make Vendor::from_raw() public
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786564358; l=1768;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=tVp41pARDQTrd5p+nu2KEb+o0rIimyub9Ff96tbhd3A=;
 b=SMWrZA117CCWnksPLtAQDkgM3baLke1SfODAL1kT20tt3MNF9qHO6ZCb38yCkjsVUrsD8sOxC
 P7bkQLBIJgRAFyrlzSSaW7ik/ozoqmdHMjc70ZhIQNI7OSNBp2mKcvN
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: 9oo4zaw7zumrk83gfg86gtuq9rjj7fwd
X-MBO-RS-ID: ea5f89fe8d5fac0c87e
X-Rspamd-Queue-Id: 4hKzgP6CVqzKw21
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

`Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
obtained through the named constants generated from the
`PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
cannot match a device whose vendor ID has no symbolic name.

Such devices exist. QEMU's "edu" educational device and the legacy
qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
`pci_ids.h`. Per the policy stated at the top of that header, IDs are
only added there when shared between multiple drivers; a single-driver
ID is expected to be open-coded in the driver instead. C drivers already
do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
".vendor = 0x1234".

The Rust abstraction has no equivalent escape hatch: there is no public
way to express an unregistered vendor. Make `Vendor::from_raw()` public
(and const, so it can be used in the const device-ID tables built by
`pci_device_table!`) so that drivers can construct a Vendor from a raw
ID, matching what C drivers can already do.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci/id.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..fe3b0047179b 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -156,7 +156,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 impl Vendor {
     /// Create a Vendor from a raw 16-bit vendor ID.
     #[inline]
-    pub(super) fn from_raw(vendor_id: u16) -> Self {
+    pub const fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
     }
 

-- 
2.54.0

