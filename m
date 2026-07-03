Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379B9C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDCF10F60C;
	Fri,  3 Jul 2026 03:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="EcUzfb5H";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF8310F60C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:25 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso493805e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047744; x=1783652544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTiNa+jNO/J0asM7nu8zy4yxLpKOaf8IK3J1xe9aBJI=;
 b=EcUzfb5HSPQn8eHIojLFWsEEkyj3hrZGpfziZtiATdhfDXku964KgO39NBGc6gxYvU
 rOd9GRtO+fR34Y+ZvgxCfvtX1jP+XmjcWvo5SAUhKTfAhAL6fsQA6toTaddixLAS4d8E
 NyfzFRvbrh2Sn1r1x77GQhz8ScSklAsihIgbjWSbNBW3LgHivX3nnmOqsDBs3zVrFI6o
 V2libEjaTY58ni14TC4CvYj1pzAL0nVu2R5+Zg/QJwXS5wLbEEF0JYLc2n0lcqTwFKJJ
 hFvx2vtDxttqKn397SQJsmowFxsJldi9ke3SJw5L+fiGlzaNA1JlRRsH+0TIB8t6rJ0u
 4wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047744; x=1783652544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TTiNa+jNO/J0asM7nu8zy4yxLpKOaf8IK3J1xe9aBJI=;
 b=P1P0lCFdvnPJgGn0IjMNVVtGojGIjipd6hKdQEIof9Bpu/BZ7yW0imduWfs/NTMroB
 lAcWxuZPmd7mLi8VLDe4QLUbRhpefExp3tOJFPco68aru6roZuyf6H0oePTEKa6YsX2u
 8DONxs9kBtG9d+IdswyPjwx2enMmI6qMurxh6Yr4sdhYbJartH8fYlYQriVPPEuJ56g+
 AXtZQl/+ss+z7OQ14ykHQnj04Y02UPpIsdAF3WJk/7/kSBMYRp5xOtvZCxzpeFEBlpLK
 U31NY+L6lcmKHodAlJdwpXS63W4qcSo6t5HpF2nkC2jLVqtH6KhRtSC4BODACypt2mAK
 9j6Q==
X-Gm-Message-State: AOJu0YwD1ju3QtCwmzEHgJ6EExjyTWiLKU8TJbN57XxeWID6dx0B4xEW
 hdPfPOLDO0zoc9VK7ti+Ja0COLrcPz3yHx5vCktlqaNGuHUHt8lpLZF+3U4BC2hE6w==
X-Gm-Gg: AfdE7cn3np3AHENR2AiFm2ZiYRdgSUfWTfDocuhT6axL8Ece6oJ7gL9/PlCmcWpHGPL
 jDKrsFCRIv9sgyNel2KVTaA/Lwlczm41iUoQZw3bOx7nZKabVqA8zsSM4YoK16Lst2K3iRSiZjq
 WRCpW57OpYbjuJZEIHb5IKuZrkmB5H+Qzo/CePa5ZmoM3FQ3u0zI+lEaInFH7K3J04B+JrfaZ4M
 HJRX3DEJ06TsdFEbZHTnZXlayA8vjBON5+p0mcf9SzDXxmRXTIzd3PQC/Qxvi1AHQ8z/HJX2sUH
 dW3+81/Oj3t+iFSOwPDFM9lcYvnTvZ3A25z4D+INc9lrJ16wwf4OQ6ePWxXckh48bY5C2tKybol
 oFeRDIA5K0j2/aO3osQ4cQmymq9GAsgrYfWtiszlWe2/2gdl+hQftyv0Z4yxbwrkctCSL/FMrOe
 xKKC++/IKvN8WcbSSdslWFjq6NPGmL8UhRtmo6MgLh50Jih385bgDCIhYUb6fpbr08B9I=
X-Received: by 2002:a05:600c:1554:b0:493:a435:d870 with SMTP id
 5b1f17b1804b1-493c2b902bdmr122406295e9.27.1783047744028; 
 Thu, 02 Jul 2026 20:02:24 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:23 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 01/10] drm/vino: add DisplayLink DL3 dock skeleton and
 protocol framing
Date: Fri,  3 Jul 2026 04:02:06 +0100
Message-ID: <20260703030217.2886-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030217.2886-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
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

New drm/vino driver for DisplayLink DL3 USB docks (Dell D6000,
17e9:6006), replacing the out-of-tree EVDI module plus the
DisplayLinkManager userspace daemon.

This patch adds the module skeleton (Kconfig/Makefile, registered in
drivers/gpu/drm/{Kconfig,Makefile}) and two small standalone pieces:
proto.rs (the DL3 USB wire framing this driver builds every message on
top of) and rng.rs (a thin wrapper over the kernel RNG for HDCP nonces).
Neither depends on anything else added by later patches in this series.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 drivers/gpu/drm/Kconfig       |  1 +
 drivers/gpu/drm/Makefile      |  1 +
 drivers/gpu/drm/vino/Kconfig  | 20 ++++++++++
 drivers/gpu/drm/vino/Makefile |  2 +
 drivers/gpu/drm/vino/proto.rs | 73 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vino/rng.rs   | 12 ++++++
 6 files changed, 109 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/Kconfig
 create mode 100644 drivers/gpu/drm/vino/Makefile
 create mode 100644 drivers/gpu/drm/vino/proto.rs
 create mode 100644 drivers/gpu/drm/vino/rng.rs

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..8fb9c9f787ba 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -361,6 +361,7 @@ source "drivers/gpu/drm/vgem/Kconfig"
 source "drivers/gpu/drm/virtio/Kconfig"
 source "drivers/gpu/drm/vkms/Kconfig"
 source "drivers/gpu/drm/vmwgfx/Kconfig"
+source "drivers/gpu/drm/vino/Kconfig"
 source "drivers/gpu/drm/xe/Kconfig"
 source "drivers/gpu/drm/xen/Kconfig"
 source "drivers/gpu/drm/xlnx/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..42a04359cc63 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_DRM_VC4)  += vc4/
 obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VGEM)	+= vgem/
 obj-$(CONFIG_DRM_VKMS)	+= vkms/
+obj-$(CONFIG_DRM_VINO)	+= vino/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
 obj-$(CONFIG_DRM_NOVA) += nova/
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
diff --git a/drivers/gpu/drm/vino/Kconfig b/drivers/gpu/drm/vino/Kconfig
new file mode 100644
index 000000000000..f5fe6670a488
--- /dev/null
+++ b/drivers/gpu/drm/vino/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_VINO
+	tristate "DisplayLink DL3 (Vino) open driver"
+	depends on USB
+	depends on DRM
+	depends on RUST
+	select DRM_KMS_HELPER
+	select RUST_DRM_GEM_SHMEM_HELPER
+	select CRYPTO_LIB_RSA
+	help
+	  Open in-kernel Rust driver for DisplayLink DL3 USB docks (Dell
+	  Universal Dock D6000 and relatives).
+
+	  It binds the dock over USB, runs the HDCP 2.2 control plane, mode-set
+	  and the Vino codec, and registers a DRM/KMS sink that scans out to the
+	  dock's video endpoints.
+
+	  To compile this as a module, choose M here: the module is called vino.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/drm/vino/Makefile b/drivers/gpu/drm/vino/Makefile
new file mode 100644
index 000000000000..6e39668040f3
--- /dev/null
+++ b/drivers/gpu/drm/vino/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_DRM_VINO) += vino.o
diff --git a/drivers/gpu/drm/vino/proto.rs b/drivers/gpu/drm/vino/proto.rs
new file mode 100644
index 000000000000..cae6eae46b7a
--- /dev/null
+++ b/drivers/gpu/drm/vino/proto.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The DL3 "universal" wire framing and the plaintext session-init messages (sec 3/sec 4).
+
+use super::*;
+
+/// Append a sec 3-framed message to `out` with an explicit `sub_len_dw`: a 16-byte
+/// little-endian header (`pad(2) | size(2)=total-4 | type(4) | sub_id(2) |
+/// sub_len_dw(2) | seq(4)`) followed by `body`.
+///
+/// HDCP OUT messages (sec 5.1) carry DLM-fixed `sub_len_dw` values that are *not*
+/// `body.len() / 4`, so the framer cannot derive it -- the caller passes it.
+pub(super) fn push_frame_with(
+    out: &mut KVec<u8>,
+    msg_type: u32,
+    sub_id: u16,
+    sub_len_dw: u16,
+    seq: u32,
+    body: &[u8],
+) -> Result {
+    let size = ((16 + body.len()) - 4) as u16;
+    out.extend_from_slice(&[0, 0], GFP_KERNEL)?;
+    out.extend_from_slice(&size.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&msg_type.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&sub_id.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&sub_len_dw.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&seq.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(body, GFP_KERNEL)?;
+    Ok(())
+}
+
+/// `init_25` body (sec 4, verified 2026-05-27). Framed with `sub_len_dw=0` -- the
+/// DLM-fixed value, NOT `body.len()/4` (the dock ignores/rejects otherwise).
+pub(super) const INIT_25: [u8; 16] =
+    [0x05, 0, 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
+/// `init_4` (Part A) body (sec 4), also framed with `sub_len_dw=0`.
+pub(super) const INIT_4: [u8; 16] =
+    [0x04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
+/// The first HDCP-channel probe **body** (Part B of the init_4+probe transfer,
+/// sec 4): a 32-byte body leading with `14 00 76 00`, the rest zero. It is wrapped
+/// in its own type=4 sub=0x04 frame (`sub_len_dw=0x0a`) -- see [`init_4_probe`].
+/// The dock only ACKs once this framed probe arrives.
+pub(super) const PROBE_BODY: [u8; 32] = {
+    let mut p = [0u8; 32];
+    p[0] = 0x14;
+    p[2] = 0x76;
+    p
+};
+
+/// `init_0`: 16-byte framing header only, empty body (sec 4).
+pub(super) fn init_0() -> Result<KVec<u8>> {
+    let mut buf = KVec::with_capacity(16, GFP_KERNEL)?;
+    push_frame_with(&mut buf, 0x01, 0x00, 0, 0, &[])?;
+    Ok(buf)
+}
+
+/// `init_25`: type=2 sub=0x25, `sub_len_dw=0`, 32 bytes total (sec 4).
+pub(super) fn init_25() -> Result<KVec<u8>> {
+    let mut buf = KVec::with_capacity(32, GFP_KERNEL)?;
+    push_frame_with(&mut buf, 0x02, 0x25, 0, 0, &INIT_25)?;
+    Ok(buf)
+}
+
+/// `init_4` + HDCP probe as one 80-byte transfer (sec 4): Part A (type=2 sub=0x04,
+/// `sub_len_dw=0`, 32 B) concatenated with Part B -- the probe framed as type=4
+/// sub=0x04 with `sub_len_dw=0x0a` over the 32-byte [`PROBE_BODY`] (48 B). This
+/// is the message the dock ACKs.
+pub(super) fn init_4_probe() -> Result<KVec<u8>> {
+    let mut buf = KVec::with_capacity(80, GFP_KERNEL)?;
+    push_frame_with(&mut buf, 0x02, 0x04, 0, 0, &INIT_4)?; // Part A
+    push_frame_with(&mut buf, 0x04, 0x04, 0x0a, 0, &PROBE_BODY)?; // Part B (framed probe)
+    Ok(buf)
+}
diff --git a/drivers/gpu/drm/vino/rng.rs b/drivers/gpu/drm/vino/rng.rs
new file mode 100644
index 000000000000..8720d55174ae
--- /dev/null
+++ b/drivers/gpu/drm/vino/rng.rs
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Cryptographically-secure randomness for the per-session HDCP nonces/keys
+//! (`rtx`, `km`, `rn`, `ks`, `riv`, the OAEP seed).
+#![allow(dead_code)] // RNG helpers; some are reached only on the post-engagement CP path
+
+/// Fills `buf` with random bytes from the kernel CSPRNG (`get_random_bytes`).
+pub(super) fn fill(buf: &mut [u8]) {
+    // SAFETY: `buf` is valid for writes of `buf.len()` bytes; `get_random_bytes`
+    // writes exactly that many and never sleeps/faults on a kernel buffer.
+    unsafe { kernel::bindings::get_random_bytes(buf.as_mut_ptr().cast(), buf.len()) };
+}
-- 
2.55.0

