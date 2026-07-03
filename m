Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8A8C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3352210F60E;
	Fri,  3 Jul 2026 03:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="UZROHVUR";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5436710F60D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so433805e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047746; x=1783652546;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zPTrGagSiuVYU7I9JgOECqU8/VU0U08xkF/eFNmS0A=;
 b=UZROHVURgRMx4rY31TZcv2QaF0NpO54+nTQENsuoeRMCXc/rdZ8wKKhfzw1UId4mvw
 ENJwVlDS43DVvx0kRbtjEzbRmlVPxZb4c8ApijsZ2zlrP1NxvNKfIqa6tG4vwMvcSBJ/
 cQRhtcfuYdu4jEa69PipOEE2Thnj2jJxu1JAy3FSELOZ35rrKvI6JSnxOGpqSEL0Bjgf
 Nm48tavZR64q8AIYFASkHatW/jpr3TuPwo8M8VCETDEeg60aVQRDoLpXcoOO9HgrdVUi
 Wzyhrhxx3tMy1XIN35/bBmZkn8tvWkTNyGbxOGAB8JzHyIs+Sy/ArBzMXdwweKAYmr+7
 XmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047746; x=1783652546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zPTrGagSiuVYU7I9JgOECqU8/VU0U08xkF/eFNmS0A=;
 b=Xym5J9Sf3uzlmPaLcgcNYutOU7SoYewfi/PFu1btiCeoQjQCFjswbLi24n1EAEkuzz
 W3NvnR5hmcgnProlmGkYLspQbHhadSN8oAuNS8xhZrPIOCyW+HzBEjis1nWtYCbacFXN
 oph7yl9rh/FKaOHIvSIkbxlfycJTP1G8ff2EbbSqFWQEjtTCx5OQ0gTuyYts7t8xnoGq
 xekXOR7aeOEaztxjURKCpygyDP0w4cJ4RAwQuhOwz1KrFb2fKIQ41WmBr+EfCNFlAXv9
 UzCpyY/yzlQ2QXWC3PaUAflSeyQWa1H2Dsu94Fe00kt7Dx5oadHktAq0zLHeE7eqB7CE
 4dkQ==
X-Gm-Message-State: AOJu0YxVSUoW0RZSA4a4d2rypFhlkze3yxyPoLt0fdNom1ptuRhraJvq
 tCRGpK2kyqfuZEiggRqvNP+YTqRV4YJ7Mkf5lKctuq/e4bBaJamgRS17mlKAkEbTWg==
X-Gm-Gg: AfdE7cm4W6IqaAnYforVuz41UJiTTHaGfriUR3OoJaXv4+58L90ctEO9hEcDlA/zyAm
 wAg2cohbuHO4IcCrIFqsZllL8ogJPuYdon3jORG7ybSmPd3fFP8fqc3WFkw6k/+LeSEGhWJeOIv
 cQEsuqvJnVT6Gek41yRHb4T0BFH+I7M1/wLCt+B8qYkqV6QpWT1Ji2TQpedPckKmQuE0ifCNDU3
 W5SRqvdEts6lrcz5tnitQxpMdDI9wMvRi/4OAz+7zwUAUd1e5AD8AHUjk6aB2TeXvb/ZVtqwNeB
 +AIr0lgqDn9PJE6RpGpHBylNjBDebLxkNlyYj9XUC39gXZLODV3G/PJsWwn8sWrWv9o/ZFP+Z1l
 eVtmhQ0iQc9tdpdSnyvxq7ukVeRsXh1ODd9rBraPevDUw8UsFBmP0CrjIOlQhvjzlHBO9P80yqO
 bOJllRNuC0CXLHpXa1cVhUgqNFhUm/eSFjTKPOvjpfxGpxFx5Cmrpa2RVR
X-Received: by 2002:a05:600d:844f:20b0:492:5bb6:6d4b with SMTP id
 5b1f17b1804b1-493c3df77eamr86100765e9.34.1783047745537; 
 Thu, 02 Jul 2026 20:02:25 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:24 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/10] drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE
 handshake
Date: Fri,  3 Jul 2026 04:02:07 +0100
Message-ID: <20260703030217.2886-3-mike@fireburn.co.uk>
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

crypto.rs wraps the crypto bindings (AES-128, AES-CMAC) for the KDF this
driver needs; hdcp.rs holds the HDCP 2.2 message-ID constants and wire
structs (reusing <drm/display/drm_hdcp.h> where it overlaps); ake.rs
builds/parses the AKE_Init/AKE_Send_Cert/AKE_No_Stored_km/
AKE_Send_H_prime/AKE_Send_Pairing_Info, LC_Init/LC_Send_L_prime and
SKE_Send_Eks messages plus the RepeaterAuth exchange, all verified
byte-exact against the reference daemon's wire traffic; golden.rs holds
a small captured plaintext capability-announce skeleton the handshake
fills with live session values.

This is a clean-room implementation of the standard HDCP 2.2 AKE from
the published spec and the driver's own captured wire traffic -- no
daemon code or binary content is reused.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 drivers/gpu/drm/vino/ake.rs    | 173 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vino/crypto.rs |  48 +++++++++
 drivers/gpu/drm/vino/golden.rs |  69 +++++++++++++
 drivers/gpu/drm/vino/hdcp.rs   | 167 +++++++++++++++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/ake.rs
 create mode 100644 drivers/gpu/drm/vino/crypto.rs
 create mode 100644 drivers/gpu/drm/vino/golden.rs
 create mode 100644 drivers/gpu/drm/vino/hdcp.rs

diff --git a/drivers/gpu/drm/vino/ake.rs b/drivers/gpu/drm/vino/ake.rs
new file mode 100644
index 000000000000..38919624cb2f
--- /dev/null
+++ b/drivers/gpu/drm/vino/ake.rs
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! HDCP 2.2 AKE wire layer (sec 5.1 OUT framing, sec 5.2 IN parsing) -- the byte-exact
+//! message builders the AKE state machine drives, mirroring the verified userspace
+//! oracle (`vino-driver::hdcp_msgs`). DLM hardcodes per-message `sub_size` /
+//! `sub_len_dw` values the dock validates, so they are reproduced verbatim rather
+//! than derived.
+//!
+//! OUT body layout (sec 5.1), after the 16-byte sec 3 transport header:
+//! ```text
+//!   body[0..2]   u16 sub_size      (DLM-fixed per message)
+//!   body[2..4]   u16 = 0x0010
+//!   body[4..8]   u32 hdcp_seq      increments 1..7 across the AKE OUT messages
+//!   body[8..22]  14 zero bytes
+//!   body[22..26] u32 = 0x00000030  marker
+//!   body[26]     u8  = 0x00        flag
+//!   body[27]     u8  = msg_id
+//!   body[28..]   HDCP payload (zero-padded to the fixed body length)
+//! ```
+#![allow(dead_code)] // AKE message builders; response handlers run only after CP engagement
+
+use super::*;
+
+/// HDCP 2.2 message IDs (sec 5.3). `pub(crate)` so the AKE state machine
+/// ([`super::VinoDriver::run_ake`]) can match on the response IDs too.
+pub(crate) mod id {
+    use kernel::bindings;
+
+    // Standard HDCP 2.2 message IDs: reuse the canonical values from
+    // `<drm/display/drm_hdcp.h>` rather than redefining them, so vino stays in
+    // lockstep with the kernel's HDCP definitions. Only the transport framing
+    // around these (the DisplayLink type/sub/ctr header) is vino-specific.
+    pub(crate) const AKE_INIT: u8 = bindings::HDCP_2_2_AKE_INIT as u8;
+    pub(crate) const AKE_SEND_CERT: u8 = bindings::HDCP_2_2_AKE_SEND_CERT as u8;
+    pub(crate) const AKE_NO_STORED_KM: u8 = bindings::HDCP_2_2_AKE_NO_STORED_KM as u8;
+    pub(crate) const AKE_SEND_H_PRIME: u8 = bindings::HDCP_2_2_AKE_SEND_HPRIME as u8;
+    pub(crate) const AKE_SEND_PAIRING_INFO: u8 = bindings::HDCP_2_2_AKE_SEND_PAIRING_INFO as u8;
+    pub(crate) const LC_INIT: u8 = bindings::HDCP_2_2_LC_INIT as u8;
+    pub(crate) const LC_SEND_L_PRIME: u8 = bindings::HDCP_2_2_LC_SEND_LPRIME as u8;
+    pub(crate) const SKE_SEND_EKS: u8 = bindings::HDCP_2_2_SKE_SEND_EKS as u8;
+    pub(crate) const REPEATERAUTH_SEND_RECEIVERID_LIST: u8 =
+        bindings::HDCP_2_2_REP_SEND_RECVID_LIST as u8;
+    pub(crate) const REPEATERAUTH_SEND_ACK: u8 = bindings::HDCP_2_2_REP_SEND_ACK as u8;
+    pub(crate) const REPEATERAUTH_STREAM_MANAGE: u8 = bindings::HDCP_2_2_REP_STREAM_MANAGE as u8;
+    pub(crate) const REPEATERAUTH_STREAM_READY: u8 = bindings::HDCP_2_2_REP_STREAM_READY as u8;
+
+    // DisplayLink-specific message IDs with no `<drm/display/drm_hdcp.h>` equivalent
+    // (the AKE_Send_rrx split and the transmitter/receiver-info + auth-status messages
+    // the DL3 dock uses), kept as literals.
+    pub(crate) const AKE_SEND_RRX: u8 = 0x06;
+    pub(crate) const RECEIVER_AUTH_STATUS: u8 = 0x12;
+    pub(crate) const AKE_TRANSMITTER_INFO: u8 = 0x13;
+    pub(crate) const AKE_RECEIVER_INFO: u8 = 0x14;
+}
+
+/// transport `sub_id` for HDCP OUT messages (type=4 sub=0x04, sec 5.1).
+const SUB_HDCP: u16 = 0x04;
+
+/// Allocate a `body_len`-byte zeroed body with the sec 5.1 header filled in
+/// (`sub_size`, the `0x0010` marker, `hdcp_seq`, the `0x30` marker and `msg_id`).
+/// The caller writes the payload into `body[28..]`.
+fn body(body_len: usize, sub_size: u16, hdcp_seq: u32, msg_id: u8) -> Result<KVec<u8>> {
+    let mut b = KVec::from_elem(0u8, body_len, GFP_KERNEL)?;
+    b[0..2].copy_from_slice(&sub_size.to_le_bytes());
+    b[2..4].copy_from_slice(&0x0010u16.to_le_bytes());
+    b[4..8].copy_from_slice(&hdcp_seq.to_le_bytes());
+    b[22..26].copy_from_slice(&0x0000_0030u32.to_le_bytes());
+    b[27] = msg_id;
+    Ok(b)
+}
+
+/// Wrap a finished HDCP body in the sec 3 transport header (type=4 sub=0x04) with
+/// the DLM-fixed `sub_len_dw` and the transport `seq`.
+fn wrap(sub_len_dw: u16, seq: u32, body: &[u8]) -> Result<KVec<u8>> {
+    let mut frame = KVec::with_capacity(16 + body.len(), GFP_KERNEL)?;
+    proto::push_frame_with(&mut frame, 0x04, SUB_HDCP, sub_len_dw, seq, body)?;
+    Ok(frame)
+}
+
+/// `AKE_Init` (msg_id 0x02): `rtx[8] || TxCaps[3]`, padded to a 48-byte body
+/// (`sub_size=0x22`, `sub_len_dw=0x0c` -- guide sec 5.4 table).
+pub(super) fn ake_init(
+    hdcp_seq: u32,
+    seq: u32,
+    rtx: &[u8; 8],
+    tx_caps: &[u8; 3],
+) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x0022, hdcp_seq, id::AKE_INIT)?;
+    b[28..36].copy_from_slice(rtx);
+    b[36..39].copy_from_slice(tx_caps);
+    wrap(0x000c, seq, &b)
+}
+
+/// `AKE_Transmitter_Info` (msg_id 0x13): byte-exact DLM framing
+/// (`sub_size=0x1f`, `sub_len_dw=0x0f`), payload `00 06 02 00 02`.
+pub(super) fn ake_transmitter_info(hdcp_seq: u32, seq: u32) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x001f, hdcp_seq, id::AKE_TRANSMITTER_INFO)?;
+    b[28..33].copy_from_slice(&[0x00, 0x06, 0x02, 0x00, 0x02]);
+    wrap(0x000f, seq, &b)
+}
+
+/// `AKE_No_Stored_km` (msg_id 0x04): the 128-byte RSA-OAEP-SHA256 `Ekpub(km)`
+/// in a 160-byte body (`sub_size=0x9a`, `sub_len_dw=0x04` -- guide sec 5.4 table).
+pub(super) fn ake_no_stored_km(
+    hdcp_seq: u32,
+    seq: u32,
+    ekpub_km: &[u8; 128],
+) -> Result<KVec<u8>> {
+    let mut b = body(160, 0x009a, hdcp_seq, id::AKE_NO_STORED_KM)?;
+    b[28..156].copy_from_slice(ekpub_km);
+    wrap(0x0004, seq, &b)
+}
+
+/// `LC_Init` (msg_id 0x09): `rn[8]` in a 48-byte body
+/// (`sub_size=0x22`, `sub_len_dw=0x0c`).
+pub(super) fn lc_init(hdcp_seq: u32, seq: u32, rn: &[u8; 8]) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x0022, hdcp_seq, id::LC_INIT)?;
+    b[28..36].copy_from_slice(rn);
+    wrap(0x000c, seq, &b)
+}
+
+/// `SKE_Send_Eks` (msg_id 0x0b): `Edkey(ks)[16] || riv[8]` in a 64-byte body
+/// (`sub_size=0x32`, `sub_len_dw=0x0c`).
+pub(super) fn ske_send_eks(
+    hdcp_seq: u32,
+    seq: u32,
+    edkey_ks: &[u8; 16],
+    riv: &[u8; 8],
+) -> Result<KVec<u8>> {
+    let mut b = body(64, 0x0032, hdcp_seq, id::SKE_SEND_EKS)?;
+    b[28..44].copy_from_slice(edkey_ks);
+    b[44..52].copy_from_slice(riv);
+    wrap(0x000c, seq, &b)
+}
+
+/// `RepeaterAuth_Send_ACK` (msg_id 0x0f): the full `V[16]` in a 48-byte body
+/// (`sub_size=0x2a`, `sub_len_dw=0x04`).
+pub(super) fn repeater_auth_send_ack(
+    hdcp_seq: u32,
+    seq: u32,
+    v: &[u8; 16],
+) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x002a, hdcp_seq, id::REPEATERAUTH_SEND_ACK)?;
+    b[28..44].copy_from_slice(v);
+    wrap(0x0004, seq, &b)
+}
+
+/// `RepeaterAuth_Stream_Manage` SM2 (msg_id 0x10): byte-exact DLM replica sent
+/// after Send_ACK -- `k=2` (LE), `StreamID_Type[0]=4` (LE), `body[43]=0x05`
+/// (`sub_size=0x2d`, `sub_len_dw=0x01`). See guide sec 5.4 and sec 8.2.
+///
+/// `type0` (CP_STREAM_TYPE0 experiment, 2026-06-23): zero the two DL3 stream-type bytes
+/// (0x04/0x05 -> 0x00) so the dock is asked for a single Type-0 (unrestricted) stream
+/// instead of the replicated DLM stream set. Default DLM-exact (`type0 == false`); the M
+/// computation in `wait_cap_complete` zeroes the matching `m_data` bytes under the same flag.
+pub(super) fn repeater_auth_stream_manage(hdcp_seq: u32, seq: u32, type0: bool) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x002d, hdcp_seq, id::REPEATERAUTH_STREAM_MANAGE)?;
+    b[32..36].copy_from_slice(&[0x02, 0, 0, 0]); // k = 2 (LE)
+    let (s0, s1) = if type0 { (0x00, 0x00) } else { (0x04, 0x05) };
+    b[36..40].copy_from_slice(&[s0, 0, 0, 0]); // StreamID_Type[0]
+    b[43] = s1; // StreamID_Type[1]
+    wrap(0x0001, seq, &b)
+}
+
+/// Parse an IN HDCP message body (sec 5.2): `body[8]` marker, `body[9]` msg_id,
+/// `body[10..]` payload (for `AKE_Send_Cert`, `body[10]` is a version flag).
+/// Returns `(msg_id, payload)`.
+pub(super) fn parse_in(body: &[u8]) -> Option<(u8, &[u8])> {
+    if body.len() < 10 {
+        return None;
+    }
+    Some((body[9], &body[10..]))
+}
diff --git a/drivers/gpu/drm/vino/crypto.rs b/drivers/gpu/drm/vino/crypto.rs
new file mode 100644
index 000000000000..83e988ded726
--- /dev/null
+++ b/drivers/gpu/drm/vino/crypto.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Thin adapters onto the shared [`kernel::crypto`] library-crypto bindings, so the
+//! protocol code keeps its `crypto::aes128_ecb` / `crypto::hmac_sha256` call sites.
+#![allow(dead_code)] // exercised by the AES-CTR seal + HDCP AKE
+
+use super::*;
+
+/// An AES-128 key prepared once for single-block encryption; re-exported so the
+/// AES-CTR keystream loops in [`cp`](super::cp) can expand the key once and reuse
+/// it across every block (rather than re-expanding per block).
+pub(super) use kernel::crypto::Aes128;
+
+/// `AES_ECB(key, block)` -- one 16-byte AES-128 block. Convenience one-shot for
+/// callers that encrypt a single block (e.g. HDCP dKey derivation); the AES-CTR
+/// paths build an [`Aes128`] once and call [`Aes128::encrypt_block`] in a loop.
+pub(super) fn aes128_ecb(key: &[u8; 16], block: &[u8; 16]) -> Result<[u8; 16]> {
+    Ok(Aes128::new(key)?.encrypt_block(block))
+}
+
+/// `HMAC-SHA256(key, data)`.
+pub(super) fn hmac_sha256(key: &[u8], data: &[u8]) -> [u8; 32] {
+    kernel::crypto::hmac_sha256(key, data)
+}
+
+/// `AES-CMAC-128(key, data)` (RFC 4493) via the in-tree AES-CMAC library.
+/// This is DisplayLink's "Dl3Cmac" core -- the CP per-message integrity tag is
+/// `AES_CMAC(ks, nonce8 || BE64(counter) || content)` (see `cp::dl3cmac_tag`);
+/// verified byte-exact against live DLM data (canonical guide sec 8.6.7).
+pub(super) fn aes_cmac(key: &[u8; 16], data: &[u8]) -> [u8; 16] {
+    kernel::crypto::aes_cmac(key, data)
+}
+
+/// `SHA256(data)`.
+pub(super) fn sha256(data: &[u8]) -> [u8; 32] {
+    kernel::crypto::sha256(data)
+}
+
+/// Raw RSA public-key op `out = input^exponent mod modulus`, big-endian,
+/// `out` written fixed-width (caller applies OAEP padding to `input`).
+pub(super) fn rsa_pubkey_encrypt(
+    modulus: &[u8],
+    exponent: &[u8],
+    input: &[u8],
+    out: &mut [u8],
+) -> Result {
+    kernel::crypto::rsa_pubkey_encrypt(modulus, exponent, input, out)
+}
diff --git a/drivers/gpu/drm/vino/golden.rs b/drivers/gpu/drm/vino/golden.rs
new file mode 100644
index 000000000000..e379e888c9c8
--- /dev/null
+++ b/drivers/gpu/drm/vino/golden.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Captured DisplayLink control-plane protocol templates.
+//!
+//! These are NOT replay dumps of an encrypted session. They are the
+//! session-invariant *plaintext skeletons* of two control-plane bursts captured
+//! from the proprietary DisplayLinkManager (DLM). The driver overwrites the
+//! session-specific fields with THIS session's live values and then seals the
+//! result under the live `ks`, so the bytes that reach the wire are this
+//! session's own, never the capture's. They remain inline here because the
+//! field-by-field live builders that would replace them are not yet written --
+//! see the "help wanted" note at the top of the file.
+
+/// Plaintext capability-announce skeleton: the seven `sub=0x10`, ctr 1..7
+/// frames that restate the AKE OUT messages. `build_cap_announce` walks this
+/// and overwrites each frame's payload with this session's live AKE value
+/// (rtx / Ekpub / rn / Edkey+riv / V). 590 bytes.
+pub(super) const CAP_PLAIN_1080P: &[u8] = &[
+    0x40, 0x00, 0x00, 0x00, 0x3c, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00,
+    0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x22, 0x00, 0x10, 0x00, 0x01, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x02, 0x1f, 0xe7,
+    0x18, 0x56, 0x6e, 0x1f, 0xc0, 0x54, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x3c, 0x00,
+    0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x0f, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x1f, 0x00, 0x10, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00,
+    0x00, 0x00, 0x00, 0x13, 0x00, 0x06, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0xb0, 0x00, 0x00, 0x00, 0xac, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00,
+    0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x9a, 0x00, 0x10, 0x00, 0x03, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x04, 0x0e, 0xd9,
+    0x2f, 0x05, 0xee, 0x3e, 0xca, 0x40, 0x7e, 0x14, 0x9f, 0x9d, 0x12, 0x6c,
+    0xca, 0x1a, 0x70, 0x27, 0x55, 0x02, 0x22, 0x0c, 0xde, 0x7d, 0x79, 0x6b,
+    0x13, 0x14, 0x32, 0x62, 0xef, 0x62, 0xc0, 0xf2, 0xb6, 0x3d, 0x41, 0x21,
+    0xcf, 0xbd, 0x2a, 0x40, 0xf9, 0xe8, 0x42, 0xc7, 0xbb, 0xa7, 0xcd, 0x8c,
+    0x53, 0xab, 0x56, 0x4e, 0x5b, 0xf8, 0x55, 0x0a, 0x05, 0x96, 0x09, 0x28,
+    0xbb, 0xf9, 0xbe, 0xc9, 0xe8, 0x81, 0x32, 0xaa, 0xc8, 0x49, 0x27, 0x3c,
+    0x80, 0x5c, 0x7c, 0xb8, 0x23, 0x54, 0xb6, 0xe0, 0x38, 0x71, 0x3c, 0xdd,
+    0xa6, 0x77, 0x91, 0x16, 0x3f, 0xd4, 0xec, 0xfd, 0xdd, 0x56, 0xf7, 0x01,
+    0xe1, 0x6c, 0x03, 0x50, 0xdf, 0x80, 0xd5, 0x93, 0x66, 0x55, 0xe1, 0xd7,
+    0x3b, 0x55, 0x7e, 0x9c, 0xb7, 0x71, 0xfe, 0x0b, 0x7d, 0x1c, 0x0d, 0x6b,
+    0x18, 0xda, 0xdb, 0xbe, 0x79, 0x75, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00,
+    0x00, 0x00, 0x3c, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x0c, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x22, 0x00, 0x10, 0x00, 0x04, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x09, 0xf4, 0xc4, 0x61, 0x0d,
+    0xe0, 0x75, 0x99, 0xf5, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00, 0x4c, 0x00, 0x04, 0x00,
+    0x00, 0x00, 0x04, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x32, 0x00,
+    0x10, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00,
+    0x00, 0x0b, 0xb2, 0xd9, 0xbd, 0x87, 0x94, 0x1b, 0xf0, 0xec, 0x59, 0x40,
+    0xf2, 0xba, 0xd5, 0x6d, 0x24, 0xab, 0x56, 0xfe, 0x0c, 0xff, 0xbc, 0x3a,
+    0x9d, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x3c, 0x00, 0x04, 0x00, 0x00, 0x00,
+    0x04, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2a, 0x00, 0x10, 0x00,
+    0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x00, 0x00, 0x00, 0x00, 0x0f,
+    0x38, 0x08, 0x3b, 0x1f, 0x39, 0x61, 0xb4, 0x9b, 0x3a, 0x2e, 0x9a, 0x1c,
+    0xbd, 0x64, 0x78, 0x85, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00,
+    0x3c, 0x00, 0x04, 0x00, 0x00, 0x00, 0x04, 0x00, 0x01, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x2d, 0x00, 0x10, 0x00, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x30, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
+    0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00,
+    0x00, 0x00,
+];
diff --git a/drivers/gpu/drm/vino/hdcp.rs b/drivers/gpu/drm/vino/hdcp.rs
new file mode 100644
index 000000000000..c22d58b624ab
--- /dev/null
+++ b/drivers/gpu/drm/vino/hdcp.rs
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! HDCP 2.2 key derivation and verifier computation (sec 5.6), built on [`crypto`].
+//! Lets the driver run a clean-room AKE without DisplayLink's binary; the byte-exact
+//! formulas are verified against the live dock in the guide.
+#![allow(dead_code)] // some HDCP builders/handlers are reached only after CP engagement
+
+use super::*;
+
+/// `dkey_n = AES_ECB(km with low-8-bytes XOR rn, rtx || (rrx with byte15 XOR n))`
+/// (HDCP 2.2 IIA sec 2.7, sec 5.6). The counter `n` XORs into byte 15 (LSB of the rrx
+/// half) of the IV; `rn` XORs into the low 8 bytes (km[8..16]) of the key -- zero
+/// for the `kd` derivation, the SKE nonce for `dkey_2`.
+fn derive_dkey(
+    km: &[u8; 16],
+    rn: &[u8; 8],
+    rtx: &[u8; 8],
+    rrx: &[u8; 8],
+    n: u8,
+) -> Result<[u8; 16]> {
+    let mut iv = [0u8; 16];
+    iv[..8].copy_from_slice(rtx);
+    iv[8..].copy_from_slice(rrx);
+    iv[15] ^= n;
+    let mut key = *km;
+    for i in 0..8 {
+        key[8 + i] ^= rn[i];
+    }
+    crypto::aes128_ecb(&key, &iv)
+}
+
+/// `kd = dkey_0 || dkey_1` with `rn = 0` (sec 5.6) -- the 256-bit derived key.
+pub(super) fn derive_kd(km: &[u8; 16], rtx: &[u8; 8], rrx: &[u8; 8]) -> Result<[u8; 32]> {
+    let rn = [0u8; 8];
+    let dkey0 = derive_dkey(km, &rn, rtx, rrx, 0)?;
+    let dkey1 = derive_dkey(km, &rn, rtx, rrx, 1)?;
+    let mut kd = [0u8; 32];
+    kd[..16].copy_from_slice(&dkey0);
+    kd[16..].copy_from_slice(&dkey1);
+    Ok(kd)
+}
+
+/// `H' = HMAC-SHA256(kd, rtx with byte7 ^= repeater)` (sec 5.6).
+pub(super) fn compute_h(kd: &[u8; 32], rtx: &[u8; 8], repeater: bool) -> [u8; 32] {
+    let mut msg = *rtx;
+    msg[7] ^= repeater as u8;
+    crypto::hmac_sha256(kd, &msg)
+}
+
+/// `L' = HMAC-SHA256(kd with low-8-bytes XOR rrx, rn)` (sec 5.6).
+///
+/// "low-8-bytes" is the *least-significant* 64 bits of the 256-bit `kd`, i.e.
+/// `kd[24..32]` -- verified byte-exact against the live dock by the userspace
+/// oracle (`vino-hdcp::kdf::compute_l`). XOR-ing into `kd[0..8]` does not verify.
+pub(super) fn compute_l(kd: &[u8; 32], rrx: &[u8; 8], rn: &[u8; 8]) -> [u8; 32] {
+    let mut key = *kd;
+    for i in 0..8 {
+        key[24 + i] ^= rrx[i];
+    }
+    crypto::hmac_sha256(&key, rn)
+}
+
+/// Full `V = HMAC-SHA256(kd, list_header)` (256 bits) for RepeaterAuth (sec 2.3).
+/// The **MSB-128** (`[..16]`) is `V'` -- verified against the repeater's
+/// `RepeaterAuth_Send_ReceiverID_List` trailer. The **LSB-128** (`[16..]`) is the
+/// value the transmitter returns in `RepeaterAuth_Send_Ack`. vino had been sending
+/// the MSB (i.e. echoing the dock's own `V'`) as the Ack -- so the dock rejected the
+/// repeater authentication, never acknowledged Stream_Manage, and never engaged CP
+/// (proven 2026-06-11: vino's ctr6 == the dock's `id=0x21` list trailer; DLM's ctr6
+/// is a computed value present in no dock push). H'/L'/V' still pass because V'
+/// verification uses the MSB.
+pub(super) fn compute_v_full(kd: &[u8; 32], list_header: &[u8]) -> [u8; 32] {
+    crypto::hmac_sha256(kd, list_header)
+}
+
+/// MGF1 mask generation (RFC 8017 sec B.2.1) with SHA-256: returns `mask_len`
+/// bytes of `T = SHA256(seed || I2OSP(0,4)) || SHA256(seed || I2OSP(1,4)) || ...`.
+fn mgf1_sha256(seed: &[u8], mask_len: usize) -> Result<KVec<u8>> {
+    let mut mask = KVec::with_capacity(mask_len, GFP_KERNEL)?;
+    let mut counter: u32 = 0;
+    let mut block = KVec::with_capacity(seed.len() + 4, GFP_KERNEL)?;
+    while mask.len() < mask_len {
+        block.clear();
+        block.extend_from_slice(seed, GFP_KERNEL)?;
+        block.extend_from_slice(&counter.to_be_bytes(), GFP_KERNEL)?;
+        let digest = crypto::sha256(&block);
+        let take = core::cmp::min(digest.len(), mask_len - mask.len());
+        mask.extend_from_slice(&digest[..take], GFP_KERNEL)?;
+        counter += 1;
+    }
+    Ok(mask)
+}
+
+/// EME-OAEP encode (RFC 8017 sec 7.1.1) with SHA-256 and an empty label, for a
+/// `k`-byte modulus. Returns the `k`-byte encoded message `EM` ready for the
+/// raw RSA op. `seed` is `hLen` (32) random bytes. HDCP 2.2 uses SHA-256 here
+/// (SHA-1 makes the dock stop responding -- guide sec 5.4).
+fn eme_oaep_encode(k: usize, msg: &[u8], seed: &[u8; 32]) -> Result<KVec<u8>> {
+    const HLEN: usize = 32;
+    // DB = lHash || PS(zeros) || 0x01 || M, length k - hLen - 1.
+    let l_hash = crypto::sha256(&[]);
+    let db_len = k - HLEN - 1;
+    let mut db = KVec::with_capacity(db_len, GFP_KERNEL)?;
+    db.extend_from_slice(&l_hash, GFP_KERNEL)?;
+    let ps_len = db_len - HLEN - 1 - msg.len(); // k - mLen - 2*hLen - 2
+    for _ in 0..ps_len {
+        db.push(0, GFP_KERNEL)?;
+    }
+    db.push(0x01, GFP_KERNEL)?;
+    db.extend_from_slice(msg, GFP_KERNEL)?;
+    // maskedDB = DB ^ MGF1(seed, db_len).
+    let db_mask = mgf1_sha256(seed, db_len)?;
+    for i in 0..db_len {
+        db[i] ^= db_mask[i];
+    }
+    // maskedSeed = seed ^ MGF1(maskedDB, hLen).
+    let seed_mask = mgf1_sha256(&db, HLEN)?;
+    let mut masked_seed = [0u8; HLEN];
+    for i in 0..HLEN {
+        masked_seed[i] = seed[i] ^ seed_mask[i];
+    }
+    // EM = 0x00 || maskedSeed || maskedDB.
+    let mut em = KVec::with_capacity(k, GFP_KERNEL)?;
+    em.push(0x00, GFP_KERNEL)?;
+    em.extend_from_slice(&masked_seed, GFP_KERNEL)?;
+    em.extend_from_slice(&db, GFP_KERNEL)?;
+    Ok(em)
+}
+
+/// RSA-OAEP-SHA256 encrypt the 16-byte master key `km` under the dock's
+/// RSA-1024 public key (`modulus[128]`, `exponent`), giving the 128-byte
+/// `Ekpub(km)` for `AKE_No_Stored_km` (sec 5.4). Generates a fresh OAEP seed.
+pub(super) fn oaep_encrypt_km(
+    modulus: &[u8; 128],
+    exponent: &[u8],
+    km: &[u8; 16],
+) -> Result<[u8; 128]> {
+    let mut seed = [0u8; 32];
+    super::rng::fill(&mut seed);
+    let em = eme_oaep_encode(128, km, &seed)?;
+    let mut out = [0u8; 128];
+    crypto::rsa_pubkey_encrypt(modulus, exponent, &em, &mut out)?;
+    Ok(out)
+}
+
+/// SKE: `Edkey(ks) = ks XOR (dkey_2 with low-8-bytes XOR rrx)` (sec 5.6).
+///
+/// `dkey_2` is derived with the SKE nonce `rn` mixed into the key; `rrx` then
+/// XORs into the low 8 bytes (`dkey_2[8..16]`) of the mask. The result is the
+/// 16-byte `Edkey_ks` carried by `SKE_Send_Eks` (msg_id 0x0b).
+pub(super) fn compute_eks(
+    km: &[u8; 16],
+    rtx: &[u8; 8],
+    rrx: &[u8; 8],
+    rn: &[u8; 8],
+    ks: &[u8; 16],
+) -> Result<[u8; 16]> {
+    let mut mask = derive_dkey(km, rn, rtx, rrx, 2)?;
+    for i in 0..8 {
+        mask[8 + i] ^= rrx[i];
+    }
+    let mut edkey_ks = [0u8; 16];
+    for i in 0..16 {
+        edkey_ks[i] = ks[i] ^ mask[i];
+    }
+    Ok(edkey_ks)
+}
-- 
2.55.0

