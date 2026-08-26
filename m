Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3FCC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4313C10ED76;
	Wed, 26 Aug 2026 16:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="LrPhfn3r";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B6C10ED75
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:39:25 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so9434885e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762364; x=1788367164;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hrrOZsL3vYXF2u2Kt3CVUDHix7QRzLNfidL/nKYVB/c=;
 b=LrPhfn3ruZESj+GY2PnnoZIlLfv9lnkcmQAFESGaQBU8vrqs2rDnKS/HFy4iKP/wTq
 NH8BWho4tFrcTALAozxGCOGbnaZaE47OVPMpT0DgoQP5nS9RLjfFLh1CRhZYYnKiTqm1
 eCJwzdEQRLhy9gINZ6Sp9mvN/h/aRezX0RC8kIL3ftwJS/w9c/49bAvoLuvQh1tgBja8
 EXbOH7n37P7PJJCpW8zmcwDqJRog4bCMLLmigwZ7nHfA+4pg4zPW0ZnaU44XX5+tJ5pz
 GgndwyKErqnyP6+JJuICbseM5Q34O4IXLtudOkgtepd8rOeB7ErhheLOn6OQwlKaylve
 0F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762364; x=1788367164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hrrOZsL3vYXF2u2Kt3CVUDHix7QRzLNfidL/nKYVB/c=;
 b=tDtIk73oY9RJ2fgynQ+caToWkgFa20ju7ua4svO4oSb6GKgxbe81EQYgbt+U7dbh6k
 cTIZd4Ugq0lRbzHlVyVFgcOz520zAU6iXxDqWdqTrzuKDf6ZSJ6/DSfJn1PnVWslo8s1
 TZTx8T27eaGR/65FfpUZ8sb/4DQsKGl2kEKa2ASeDUvOQ4eXmprMEBzfAXqRrfkOhAzs
 8pO0lz48vMs6lpxMBzJaZ55k7Io+cSVsG8b1p2+yf6jPr7GPbSteg75EOC10sldQc78v
 sJbXchUbKPpDGatwN9hVxgVKSA7iXaEqKGDwt3oRju7vH1dh7xFBTSGYB2jBGYYMj1bM
 HlaQ==
X-Gm-Message-State: AFuF++lDLJ5T5v75p5+ul36JuvjWyX1pfjpkZ/RUUAJ3kGcUXORPLj6k
 pArJ2EfGLwz0Y3MiqJs8BFgQ3jbiValyQrHx86jslGyKZAVH92CH1Z0nBzvL59sP5e8sTbExwAq
 UyRyN3T0f
X-Gm-Gg: AR+sD10J8EGL6JDURx8x8h1Iv5oOsrSSPsCqYyWqtcrEtDHdg27//gJhfnTFooXS6dN
 sPI6YXrigisvbTMacRAiqHZ8WHuhUqKLI9pt1ueqHsY2OfpKEvE+78u8C9BpBdctmLldPoB9//e
 wOQWSM3YDyNuwiEXiAIe/fXiqYaTWtSNqmh/gyYZJvcHJDUC1mkst4e62Bfsqz+9Sw4Tf1NMrzT
 LN1gm7M2IVqPWqd8YVlTHnNmAV9lG5xXnyynCHEENWYzRb6logyC8wLQ0sHcB6fAAvtPe9/pcsD
 adv9XtHlf+Qw7Q3P+pt53vvFI0Byv7fwSs3HZY4Xv1bLhoKpMF09uwCOGljAVUJGuBn1H4yXUYb
 Y/hFIzN4nVS7OGcMwEbBNlg7bYPa0+urvz8lcFq0t3WKRwGH6WmTRca/vWtUUWU7CUPusDdZ1fu
 zq5fIgeHQeBtUo1FKiN+dL/Lp6vvxGJ1T1FY/7Wr/Er7543xqkuyyp1PPi3WnDhRM/XYtkE0MDD
 HUigVoL9waqjLSdTTBxwaaaTdRlRpda7+E+
X-Received: by 2002:a05:600c:3144:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-499dc72548dmr77127255e9.10.1787762364021; 
 Wed, 26 Aug 2026 09:39:24 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm21769715e9.4.2026.08.26.09.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:39:22 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/13] drm/vino: add the DL3 wire framing
Date: Wed, 26 Aug 2026 17:37:26 +0100
Message-ID: <20260826163913.7052-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163913.7052-1-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
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

Every message a DisplayLink DL3 dock exchanges, plaintext or sealed, sits
inside the same envelope: a length, an identifier, an auxiliary word and a
payload. The identifier is not a free-standing opcode -- on several replies
it doubles as the payload's length -- so decoding it wrongly matches a
reply by luck rather than by meaning.

Add the framing on its own, with no I/O and no crypto, so the layers above
can be read against a capture without carrying the envelope's rules.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/vino/proto.rs | 71 +++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/proto.rs

diff --git a/drivers/gpu/drm/vino/proto.rs b/drivers/gpu/drm/vino/proto.rs
new file mode 100644
index 000000000000..f9a70b605135
--- /dev/null
+++ b/drivers/gpu/drm/vino/proto.rs
@@ -0,0 +1,71 @@
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
+/// HDCP OUT messages carry fixed `sub_len_dw` values that are *not*
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
+/// `init_25` body (sec 4).
+///
+/// The `sub_len_dw` field is the fixed value zero rather than `body.len() / 4`; the dock rejects
+/// the derived value.
+pub(super) const INIT_25: [u8; 16] = [0x05, 0, 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
+/// `init_4` (Part A) body (sec 4), also framed with `sub_len_dw=0`.
+pub(super) const INIT_4: [u8; 16] = [0x04, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
+/// The HDCP-channel probe body in the second part of [`init_4_probe`].
+/// The dock only ACKs once this framed probe arrives.
+pub(super) const PROBE_BODY: [u8; 32] = {
+    let mut p = [0u8; 32];
+    p[0] = 0x14;
+    p[2] = 0x90;
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
