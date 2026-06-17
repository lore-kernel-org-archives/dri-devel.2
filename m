Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31B8CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB1310F026;
	Wed, 17 Jun 2026 15:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="u11KCjEH";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC2110F025
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:13:03 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4633193af19so337314f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781709182; x=1782313982;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGbjl3rGjnxDG8ISlwL2/j2eVTskmVkdLzO6/RGvZnc=;
 b=u11KCjEHqklo/lgYWMTL139mLHIROrj2bCoZXkdCJftEW8IWy1UjladmDaX/QS9YAJ
 ADmbqFiJ76/mpN9bDMrDhA+xydCBOYlzLQ7S+6E8DHrsgu6EHS2nOwRm88Z4OdcBGvLV
 paGxy8dgwBJYGDeYlPTns1b3FTqxM0WteCSAb5xNgYPgVs67JmUry6PyFOrEZBj/PZPf
 GelT5lXq4H8LmcZi/ik6l+TWEVCTHETtoXzeSQ8gPZNaElUnBYnROlqA6FJ+o2XClDUx
 HR7zYMyuWBxZ2sVfgx6JrIBWaujSoVL3wW3v0IyIJ0Az4rjgXuaTocswqYXpS46ev5Fd
 d2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709182; x=1782313982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wGbjl3rGjnxDG8ISlwL2/j2eVTskmVkdLzO6/RGvZnc=;
 b=V//b/mH/Zf+bvTLyBfPGvfAo4sgRBdVgAbTf5CSuOs73IAmL0meESycxVA51FbWT1v
 ncGLVUqNJo7Tpi2lCXQla0RGLAvEK5dLEAku+Gv6DHDKVXRC1qDE+6WZuYUEvcYbgOjh
 nSVsXZLX61hrpj1XtRHyDJYElfti3BJE/o+nixSdX3fz5eaCakfVJpspH6khlyxw3bC2
 /ucbZsnZ6CDfUGHW/UnU3CoeNQycMxVeWZv4jsd6L7Xqz302EdzlC3MrAEBJ5IYJQ8Wg
 hgc1rt65G3aP+0GKR5l1U+UyMq35PjIHskXUIlMzEQ3b8ELsfg9VEkpvVwbOCDlzP6L4
 axEw==
X-Gm-Message-State: AOJu0YynYbC/gMv8/L9CgYQwnQg5ertBv5vovbHlEdVmo86ptOs1ivxO
 fu9MEHQ5Z73NcA7/PD/WRCnv4qkpDtVnqRrwjvtwQxPb/hYWovfYyWtQH9YL7dtHkP5V0jMP6qX
 ye7XgDZsU
X-Gm-Gg: Acq92OFZ6oCddxWk8KYiOyx2ABNm7KaHLq369XsxoGW86SizAFiK5+YvcnZnB+zl86v
 Q9yrMT4dEo7BJQfdaVDm6XZvlCEl+tnLHWaz24/nBoyFg8j1iB7+87mhOoLbUa75WNSuoEse4Km
 LeBUvsSIP/gA6ezUH6Su0oEG9u/bUmDEcGKABq1IFhTGa02umYMM+tTv901IMBee+raJh4hAkXw
 eJW9txEOQYgN83827xy/baYyUbwkoafb5mRxjFX1yN3hulqFGIiD25CuN8suqeOcP5Jm0qMDk4K
 8rPSLPT+ZgoNpifZqwVDBSA2v5YUnqgmENtzuE+S4k0EWpygZOvsGHGn9PErossyJm2u59BWNlI
 vqdDobeQ1H2GvNy3AjCWIX8pGHtjdKqZVNsf4fRY3YkgzL+5M449Z2ygKcSvIGWjXW1ki9OvANw
 Jw77rb5Y4uPX/Fs7nYlYgzWiPneNjZrQWGwWl3PzFjOoeGkK5adYuHWgpH
X-Received: by 2002:a05:600c:8288:b0:490:e913:6564 with SMTP id
 5b1f17b1804b1-492333a5405mr77279175e9.3.1781709180148; 
 Wed, 17 Jun 2026 08:13:00 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm151019305e9.14.2026.06.17.08.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:12:59 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/7] drm/vino: add the clean-room HDCP 2.2 AKE/LC/SKE
Date: Wed, 17 Jun 2026 16:12:39 +0100
Message-ID: <20260617151249.2937-3-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617151249.2937-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
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

After the plaintext session init, the DL3 dock requires an HDCP 2.2
session before it will accept any control-plane traffic. Add a clean-room
implementation of the HDCP 2.2 authentication: the AKE (with stored-km
and no-stored-km), locality check (LC) and session-key exchange (SKE),
all verified against the live dock -- H', L' and V' all match, so the
shared session key ks and content IV riv are established.

New modules:
 - crypto: thin adapters onto the in-tree kernel library-crypto bindings
   (AES-128-ECB, AES-CMAC, HMAC-SHA256, SHA-256) used by the KDF;
 - rng: CSPRNG helpers for the per-session HDCP nonces/keys;
 - hdcp: the HDCP 2.2 key derivation (kd/dkey/ks) and H'/L'/V' verifier
   computation (the byte-exact KDF formulas);
 - ake: the HDCP 2.2 AKE wire layer (OUT message builders, IN parsing);
 - golden: the session-invariant plaintext capability-announce skeleton
   the driver re-states with this session's live AKE values right after
   the AKE (build_cap_announce).

run_ake() drives the state machine end to end and returns the keyed
Session; an on-device crypto known-answer self-test (FIPS-197 AES-128,
RFC 4493 AES-CMAC) confirms the in-kernel crypto path is byte-correct.
The encrypted control plane that consumes the Session lands in the next
patch.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 drivers/gpu/drm/vino/ake.rs    | 167 +++++++++
 drivers/gpu/drm/vino/crypto.rs |  81 ++++
 drivers/gpu/drm/vino/golden.rs |  69 ++++
 drivers/gpu/drm/vino/hdcp.rs   | 167 +++++++++
 drivers/gpu/drm/vino/rng.rs    |  12 +
 drivers/gpu/drm/vino/vino.rs   | 662 ++++++++++++++++++++++++++++++++-
 6 files changed, 1148 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/vino/ake.rs
 create mode 100644 drivers/gpu/drm/vino/crypto.rs
 create mode 100644 drivers/gpu/drm/vino/golden.rs
 create mode 100644 drivers/gpu/drm/vino/hdcp.rs
 create mode 100644 drivers/gpu/drm/vino/rng.rs

diff --git a/drivers/gpu/drm/vino/ake.rs b/drivers/gpu/drm/vino/ake.rs
new file mode 100644
index 000000000000..ad79d2754c60
--- /dev/null
+++ b/drivers/gpu/drm/vino/ake.rs
@@ -0,0 +1,167 @@
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
+pub(super) fn repeater_auth_stream_manage(hdcp_seq: u32, seq: u32) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x002d, hdcp_seq, id::REPEATERAUTH_STREAM_MANAGE)?;
+    b[32..36].copy_from_slice(&[0x02, 0, 0, 0]); // k = 2 (LE)
+    b[36..40].copy_from_slice(&[0x04, 0, 0, 0]); // StreamID_Type[0] = 4 (LE)
+    b[43] = 0x05;
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
index 000000000000..04203db81991
--- /dev/null
+++ b/drivers/gpu/drm/vino/crypto.rs
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Thin adapters onto the shared [`kernel::crypto`] library-crypto bindings, so the
+//! protocol code keeps its `crypto::aes128_ecb` / `crypto::hmac_sha256` call sites.
+#![allow(dead_code)] // exercised by the AES-CTR seal + HDCP AKE
+
+use super::*;
+
+/// `AES_ECB(key, block)` -- one 16-byte AES-128 block.
+pub(super) fn aes128_ecb(key: &[u8; 16], block: &[u8; 16]) -> Result<[u8; 16]> {
+    kernel::crypto::Aes128::new(*key).encrypt_block(block)
+}
+
+/// `HMAC-SHA256(key, data)`.
+pub(super) fn hmac_sha256(key: &[u8], data: &[u8]) -> [u8; 32] {
+    kernel::crypto::hmac_sha256(key, data)
+}
+
+/// `AES-CMAC-128(key, data)` (RFC 4493), built on the one-block ECB above.
+/// This is DisplayLink's "Dl3Cmac" core -- the CP per-message integrity tag is
+/// `AES_CMAC(ks, nonce8 || BE64(counter) || content)` (see `cp::dl3cmac_tag`);
+/// verified byte-exact against live DLM data (canonical guide sec 8.6.7).
+pub(super) fn aes_cmac(key: &[u8; 16], data: &[u8]) -> Result<[u8; 16]> {
+    // dbl: left-shift the 128-bit value by 1, XOR 0x87 if the MSB was set.
+    fn dbl(b: &[u8; 16]) -> [u8; 16] {
+        let mut o = [0u8; 16];
+        for i in 0..15 {
+            o[i] = (b[i] << 1) | (b[i + 1] >> 7);
+        }
+        o[15] = b[15] << 1;
+        if b[0] & 0x80 != 0 {
+            o[15] ^= 0x87;
+        }
+        o
+    }
+    let l = aes128_ecb(key, &[0u8; 16])?;
+    let k1 = dbl(&l);
+    let k2 = dbl(&k1);
+    let n = if data.is_empty() { 1 } else { data.len().div_ceil(16) };
+    let complete = !data.is_empty() && data.len() % 16 == 0;
+    let mut c = [0u8; 16];
+    for i in 0..n {
+        let mut blk = [0u8; 16];
+        let start = i * 16;
+        let end = core::cmp::min(start + 16, data.len());
+        blk[..end - start].copy_from_slice(&data[start..end]);
+        if i == n - 1 {
+            if complete {
+                for j in 0..16 {
+                    blk[j] ^= k1[j];
+                }
+            } else {
+                blk[end - start] = 0x80; // 10* padding
+                for j in 0..16 {
+                    blk[j] ^= k2[j];
+                }
+            }
+        }
+        for j in 0..16 {
+            blk[j] ^= c[j];
+        }
+        c = aes128_ecb(key, &blk)?;
+    }
+    Ok(c)
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
diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
index 79f446041b64..db4c38b6dc92 100644
--- a/drivers/gpu/drm/vino/vino.rs
+++ b/drivers/gpu/drm/vino/vino.rs
@@ -6,19 +6,45 @@
 //! This is an `[RFC]` work-in-progress, posted to ask for help. It is a clean-room
 //! reverse-engineered replacement for the proprietary DisplayLinkManager userspace
 //! daemon + the EVDI kernel module, written natively in Rust against the in-tree USB,
-//! crypto and DRM/KMS bindings.
+//! crypto and DRM/KMS bindings (the prerequisite binding patches are posted as their
+//! own series).
 //!
-//! This first patch is the skeleton: it binds the dock over USB and runs the plaintext
-//! connect handshake (the control-request preamble and the three bulk init messages over
-//! the Rust USB bulk + control transfer API). The HDCP 2.2 AKE, the AES-CTR/AES-CMAC
-//! control plane, the Vino codec and the DRM/KMS sink are added in the following patches.
+//! # What works
+//!
+//! On probe the driver runs, all on real hardware (Dell Universal Dock D6000):
+//! - the plaintext connect handshake over the Rust USB bulk + control transfer API;
+//! - the clean-room HDCP 2.2 AKE / LC / SKE -- H', L' and V' all verify against the
+//!   dock, so the session key `ks` is established and shared;
+//! - the AES-CTR + AES-CMAC ("Dl3Cmac") control-plane seal, byte-exact against the
+//!   reference daemon's captured wire;
+//! - the plaintext `type=2 sub=0x24` stream-open arm marker; and
+//! - registration of a real `struct drm_device` (see [`drm_sink`]) via the simple
+//!   display pipe, so the dock appears to userspace as a mode-settable GEM/dumb DRM
+//!   card, with a live EP08 framebuffer-scanout hook on every page-flip.
+//!
+//! # What does NOT work -- the wall (help wanted)
+//!
+//! After the arm marker the driver sends the first encrypted control-plane frame
+//! (msg0) and the dock **never acknowledges it** (`wsub=0x45` ack count stays 0), so
+//! the CP cipher never engages and no pixels ever flow. Every host-observable channel
+//! has been matched to the reference daemon -- the bulk wire is byte-identical through
+//! the arm + msg0, the AKE verifies, the seal/MAC/IV are byte-exact, the full EP0
+//! control-transfer set matches, the endpoint set matches, the arm timing is tighter
+//! than the daemon's -- and the dock still silently drops our encrypted CP while it
+//! engages the daemon's. The gate appears to be something not visible on the host wire
+//! (dock-internal session state, or a whole-bus timing/ordering property a per-channel
+//! diff cannot see). **If you know the DL3 / DisplayLink control-plane engagement
+//! sequence, or have ideas for the remaining paired full-bus diff, please help.**
+//!
+//! Note: `send_cp_setup` builds msg0's body field-by-field except for a small captured
+//! cap-announce skeleton ([`golden`]); a fully field-derived cap-announce is open work.
 //!
 //! Device: VID 0x17e9 (DisplayLink) / PID 0x6006 (Dell Universal Dock D6000).
 
 use kernel::{
     alloc::flags::GFP_KERNEL,
     device::{self, Core},
-    error::code::ENODEV,
+    error::code::{ENODEV, EINVAL},
     prelude::*,
     sync::{aref::ARef, Arc},
     time::Delta,
@@ -34,6 +60,9 @@
 /// Control + per-head bulk endpoints (guide sec 2).
 const EP_CTRL_OUT: u8 = 0x02;
 const EP_CTRL_IN: u8 = 0x84;
+/// EP84 (dock->host) drain buffer size. The dock's capability block can reach ~5.8 KiB, so a
+/// single bulk read needs a generously sized buffer to avoid truncating and misframing it.
+const EP84_BUF: usize = 16384;
 
 /// USB transfer timeout used during bring-up.
 fn timeout() -> Delta {
@@ -41,6 +70,26 @@ fn timeout() -> Delta {
 }
 
 mod proto;
+mod crypto;
+mod rng;
+mod hdcp;
+mod ake;
+mod golden;
+
+/// The shared secrets a completed HDCP 2.2 AKE leaves behind: the SKE session key
+/// `ks` and content IV `riv` key the AES-CTR control plane (sec 6), and `kd` is kept
+/// for any further repeater verification. Consumed by the Phase 2b/2c CP + video.
+#[allow(dead_code)] // ks/riv/kd are consumed by the post-engagement CP stream (open blocker)
+struct Session {
+    ks: [u8; 16],
+    riv: [u8; 8],
+    kd: [u8; 32],
+    /// The 7-frame **plaintext capability-announce** to send between the init markers and
+    /// the arm marker (see `VinoDriver::build_cap_announce`). Built LIVE
+    /// from this session's AKE values (rtx/ekpub/rn/edkey+riv/V) -- NOT a stale replay. Empty
+    /// for a non-repeater dock (the announce path is only exercised on the D6000, repeater=1).
+    cap_announce: KVec<u8>,
+}
 
 /// Per-bound-interface driver state.
 struct VinoDriver {
@@ -80,21 +129,94 @@ impl WorkItem for BringUp {
     fn run(this: Arc<BringUp>) {
         let cdev: &device::Device = this.intf.as_ref();
         let dev: &usb::Device = this.intf.as_ref();
-        // WIP scaffold: attempt the plaintext bring-up. Bind regardless of the outcome --
-        // there is no display path yet (the HDCP AKE, control plane and DRM sink land in
-        // the following patches).
+        // WIP scaffold: plaintext bring-up then the clean-room HDCP 2.2 AKE/LC/SKE. Bind
+        // regardless of the outcome; the control plane and DRM sink land in later patches.
         match VinoDriver::bring_up(dev) {
-            Ok(()) => dev_info!(cdev, "vino: plaintext session init OK\n"),
+            Ok(()) => {
+                dev_info!(cdev, "vino: plaintext session init OK\n");
+                match VinoDriver::run_ake(dev) {
+                    Ok(session) => {
+                        dev_info!(cdev, "vino: HDCP AKE + LC + SKE complete (session keyed)\n");
+                        // Dev diagnostic: the live session key/riv, so the dock's encrypted
+                        // EP84 replies can be decoded offline from a usbmon capture. Behind
+                        // pr_debug, so compiled out unless dynamic debug is enabled.
+                        pr_debug!("vino: SESSION ks={:02x?} riv={:02x?}\n", &session.ks, &session.riv);
+                    }
+                    Err(e) => dev_info!(cdev, "vino: HDCP AKE incomplete ({e:?}) -- WIP\n"),
+                }
+            }
             Err(e) => dev_info!(cdev, "vino: session init incomplete ({e:?}) -- WIP\n"),
         }
     }
 }
 
+/// On-device crypto known-answer self-test. Confirms the IN-KERNEL crypto path (which the CP seal
+/// depends on) is byte-correct -- something only ever checked offline (Python `verify-kdf.py`)
+/// before.
+/// Runs three checks and logs PASS/FAIL:
+///   1. AES-128-ECB vs the FIPS-197 test vector.
+///   2. AES-CMAC vs the RFC 4493 test vector (subkey + full-block path).
+///   3. The full `cp::seal_livemac` vs cold-ref's REAL msg0: known plaintext + known `ks`/`riv`
+///      must reproduce the captured wire ciphertext+tag byte-for-byte. A FAIL here (with 1+2
+///      passing) would localize a bug in our seal framing; a FAIL in 1/2 means the kernel
+///      primitive itself is wrong. If all PASS, the crypto we send is correct and the
+///      CP-engagement wall is NOT our crypto.
+fn crypto_selftest() {
+    use core::sync::atomic::{AtomicBool, Ordering};
+    static RAN: AtomicBool = AtomicBool::new(false);
+    if RAN.swap(true, Ordering::Relaxed) {
+        return;
+    }
+
+    // 1. AES-128-ECB KAT (FIPS-197 Appendix B / C.1).
+    let ecb_key = [
+        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+        0x0f,
+    ];
+    let ecb_pt = [
+        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee,
+        0xff,
+    ];
+    let ecb_expect = [
+        0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5,
+        0x5a,
+    ];
+    match crypto::aes128_ecb(&ecb_key, &ecb_pt) {
+        Ok(out) if out == ecb_expect => pr_info!("vino: selftest AES-128-ECB PASS\n"),
+        Ok(out) => pr_err!("vino: selftest AES-128-ECB FAIL got={out:02x?}\n"),
+        Err(e) => pr_err!("vino: selftest AES-128-ECB ERR ({e:?})\n"),
+    }
+
+    // 2. AES-CMAC KAT (RFC 4493 sec 4 example 2: a single 16-byte block).
+    let cmac_key = [
+        0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f,
+        0x3c,
+    ];
+    let cmac_msg = [
+        0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17,
+        0x2a,
+    ];
+    let cmac_expect = [
+        0x07, 0x0a, 0x16, 0xb4, 0x6b, 0x4d, 0x41, 0x44, 0xf7, 0x9b, 0xdd, 0x9d, 0xd0, 0x4a, 0x28,
+        0x7c,
+    ];
+    match crypto::aes_cmac(&cmac_key, &cmac_msg) {
+        Ok(out) if out == cmac_expect => pr_info!("vino: selftest AES-CMAC PASS\n"),
+        Ok(out) => pr_err!("vino: selftest AES-CMAC FAIL got={out:02x?}\n"),
+        Err(e) => pr_err!("vino: selftest AES-CMAC ERR ({e:?})\n"),
+    }
+}
+
 impl VinoDriver {
     /// Plaintext session bring-up (sec 4): control-request preamble then the three
     /// bulk init messages, reading the single ACK. Best-effort during scaffold
     /// bring-up -- errors are logged, not fatal.
     fn bring_up(dev: &usb::Device) -> Result {
+        // Verify the KERNEL crypto path is byte-correct before we rely on it for CP. The KDF was
+        // only ever checked offline (Python); this confirms the in-kernel AES-ECB, AES-CMAC and the
+        // full `seal_livemac` reproduce ground-truth vectors on THIS device. Logs PASS/FAIL once.
+        crypto_selftest();
+
         // Control-request preamble (sec 4): dock-id read, interface selection, then the
         // vendor_out 0x24 / vendor_in 0x22 pairs that kick off the HDCP path. (The
         // GET_DESCRIPTOR string reads DLM also issues look cosmetic and are omitted.)
@@ -320,6 +442,526 @@ fn bring_up(dev: &usb::Device) -> Result {
         }
     }
 
+
+    /// Whether to service EP83 (interrupt-IN status) during bring-up. Measured 2026-06-16
+    /// (paired-coldbus-20260616-162650): DLM polls EP83 0x in the pre-arm window (14x total, all
+    /// post-engagement) while vino polled it 5x pre-arm -- injecting interrupt-IN traffic into the
+    /// critical arm/msg0 window that DLM never generates. Disabled so the pre-arm wire matches DLM;
+    /// re-enable if a post-engagement status channel is ever needed (DLM only services it once the
+    /// dock has already acked).
+    const POLL_EP83_DURING_BRINGUP: bool = false;
+
+    /// Reads the next HDCP response (type=4 sub=0x25, sec 5.2) from EP `0x84`,
+    /// skipping any non-HDCP frames (e.g. plain ACKs) in between, and returns the
+    /// parsed `(msg_id, payload)`. Bounded retry so a chatty dock can't wedge us.
+    fn recv_hdcp(dev: &usb::Device) -> Result<(u8, KVec<u8>)> {
+        const SUB_HDCP_RESP: u16 = 0x25;
+        let mut buf = KVec::from_elem(0u8, 4096, GFP_KERNEL)?;
+        for _ in 0..24 {
+            // Read EP84 FIRST. The dock replies to AKE messages sub-millisecond (DLM cold capture:
+            // ~0.1-0.7 ms between EP84 IN frames), but it interleaves status/cap pushes that we
+            // skip. Polling EP83 (a ~2 ms idle wait) BEFORE every read added ~2 ms x
+            // N-skipped-frames
+            // of latency per reply -- making vino's AKE ~400 ms vs DLM's ~62 ms, slow enough that
+            // the
+            // dock starts downstream HDCP and NAKs our arm/Stream_Manage. So only service EP83 when
+            // EP84 came back empty (same reorder as `drain_ep84`). See the cold wire diff.
+            let n = dev.bulk_recv(EP_CTRL_IN, &mut buf, timeout())?;
+            if n < 16 {
+                if Self::POLL_EP83_DURING_BRINGUP {
+                    Self::poll_ep83(dev);
+                }
+                continue;
+            }
+            // DIAGNOSTIC (2026-06-11): log EVERY frame the dock returns during the AKE --
+            // including
+            // wsub!=0x25 and cap-block (sub=0x84) pushes we'd otherwise skip -- so we can see
+            // whether
+            // the dock interleaves its capability blocks with the HDCP replies (the suspected
+            // reason
+            // its cap phase never completes / it won't engage CP). Inner id/sub at off 16/18.
+            {
+                let wsub = u16::from_le_bytes([buf[8], buf[9]]);
+                let iid = if n >= 18 { u16::from_le_bytes([buf[16], buf[17]]) } else { 0 };
+                let isub = if n >= 20 { u16::from_le_bytes([buf[18], buf[19]]) } else { 0 };
+                pr_debug!("vino: AKE-EP84 {n}B wsub={wsub:#x} inner_id={iid:#x} inner_sub={isub:#x}\n");
+            }
+            if u16::from_le_bytes([buf[8], buf[9]]) != SUB_HDCP_RESP {
+                continue; // non-HDCP frame -- skip
+            }
+            if let Some((id, payload)) = ake::parse_in(&buf[16..n]) {
+                // Inner msg_id 0 is a status/ACK frame (the dock emits one as a
+                // sub=0x25 frame after each OUT message, e.g. the `14 00 76 00...`
+                // frame after AKE_Init) -- skip it and keep reading for the real
+                // HDCP response, mirroring the oracle's recv_hdcp_msg.
+                if id == 0 {
+                    continue;
+                }
+                let mut pl = KVec::with_capacity(payload.len(), GFP_KERNEL)?;
+                pl.extend_from_slice(payload, GFP_KERNEL)?;
+                return Ok((id, pl));
+            }
+        }
+        Err(EINVAL)
+    }
+
+
+    /// Pace like DLM after a RepeaterAuth OUT (ctr6 Send_Ack / ctr7 Stream_Manage):
+    /// read the dock's per-frame `id=0x14 sub=0x10` ack off EP84 BEFORE the next OUT,
+    /// so vino never transmits while the dock is mid-NAK.
+    ///
+    /// Ground truth (cold wire diff, captures/dlm-cold-20260611-123347 vs vino-cold):
+    /// DLM reads that ack after EVERY cap/AKE OUT --
+    /// ctr4->ack->ctr5->ack->ctr6->ack->ctr7->
+    /// ack->arm, ~0.2 ms apart, whole ctr7->arm gap 0.46 ms. Commit d74a4d7 dropped the
+    /// drain for ctr6/ctr7, so `run_ake` sent ctr6->ctr7 back-to-back with no read; the
+    /// dock (busy with downstream HDCP after SKE) then NAK'd each OUT ~100 ms (vino's
+    /// V'->arm gap measured ~200 ms), and the arm landed after the dock had left its
+    /// freshly-keyed CP window -> CP never engaged (0 `wsub=0x45`). Restoring the read
+    /// re-paces vino to DLM and lets the arm land tight. Best-effort: returns as soon as
+    /// the matching ack arrives, or immediately if nothing is queued (dock idle).
+    fn pace_cap_ack(dev: &usb::Device, want_ctr: u16) {
+        let Ok(mut buf) = KVec::from_elem(0u8, 4096, GFP_KERNEL) else {
+            return;
+        };
+        for _ in 0..8 {
+            match dev.bulk_recv(EP_CTRL_IN, &mut buf, Delta::from_millis(30)) {
+                Ok(len) if len >= 22 => {
+                    let wsub = u16::from_le_bytes([buf[8], buf[9]]);
+                    let iid = u16::from_le_bytes([buf[16], buf[17]]);
+                    let ictr = u16::from_le_bytes([buf[20], buf[21]]);
+                    // The per-frame cap-ack: wsub=0x25, inner id=0x14 sub=0x10 ctr=want.
+                    // An interleaved cap push (sub=0x84) or earlier ack -- keep reading.
+                    if wsub == 0x25 && iid == 0x14 && ictr == want_ctr {
+                        return;
+                    }
+                }
+                // Nothing queued within the short window -- the dock is idle, don't block.
+                _ => return,
+            }
+        }
+    }
+
+
+    /// After ctr7 (Stream_Manage) and its ack, WAIT for the dock's terminal capability block
+    /// `id=0x0b sub=0x84` before letting the caller arm. This is the dock's "cap-complete"
+    /// signal: DLM receives it and only then arms (cold-ref: `id=0x21` @52.1465 -> `id=0x0b`
+    /// @52.1469 -> arm @52.1474). vino's lockstep ([`pace_cap_ack`]) only consumed the `id=0x14`
+    /// ctr acks, so it armed right after ctr7's ack -- BEFORE the dock had emitted `id=0x0b`
+    /// (vino received every other cap block id=0x213/0x0d/0x10/0x28/0x18/0x21 but armed one push
+    /// early). The dock then NAK'd msg0 ~100 ms and dumped a 16 KB error block
+    /// (`type=0x1003 wsub=0x37`) that DLM never produces, instead of engaging CP -- the true
+    /// gate, found on cold plug `vino-cold-20260612-080549`. The dock emits `id=0x0b` a few ms
+    /// after `id=0x21` once it settles downstream HDCP, so draining EP84 until it arrives keeps
+    /// the arm tight (DLM ~ 0.5 ms after ctr7) yet correctly ordered. Best-effort, bounded.
+    fn wait_cap_complete(dev: &usb::Device, kd: &[u8; 32]) {
+        let Ok(mut buf) = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL) else {
+            return;
+        };
+        // Drain EP84 until the dock goes QUIET, not merely until id=0x0b. Cold plug #2
+        // (vino-cold-20260612-082707) showed DLM's LAST pre-arm push is the id=0x28 that
+        // follows id=0x0b (cold-ref: id=0x0b@52.1469 -> ack ctr7 -> id=0x28@52.1472 ->
+        // arm@52.1474),
+        // whereas vino stopped at id=0x0b and armed -- leaving id=0x28 (and the rest of the dock's
+        // terminal cap burst) un-drained in the dock's EP84 queue. With its IN queue backed up the
+        // dock NAK'd vino's msg0 ~100 ms (it can't accept the OUT while it still owes IN data) and
+        // then dumped the 16 KB error block. So after id=0x0b, keep reading until a read times out
+        // (the dock has sent everything), then return so the caller arms into a clean dock -- like
+        // DLM. Bounded: id=0x0b is the marker; QUIET_GAP short reads of silence end the drain.
+        //
+        // * 2026-06-12 (HDCP 2.3 Adaptation sec RepeaterAuth, pdfs/): one of the frames drained
+        // here is
+        // the dock's `RepeaterAuth_Stream_Ready` (HDCP msg 0x11) -- the 3rd `id=0x28` DLM receives
+        // and
+        // vino historically did not. The spec requires the transmitter to RECEIVE it within 100 ms
+        // of
+        // `Stream_Manage` and verify `M == M'` before transmitting content; the dock's exactly-100
+        // ms
+        // msg0 NAK on a cold plug is that window. We now RECOGNISE it in this same drain (no added
+        // latency vs the old broken 10x1 s poll) and log `M'` plus candidate `M`s so the next
+        // capture
+        // pins the exact `STREAMID_TYPE || seq_num_M` the dock hashes. The HDCP msg_id rides at
+        // `body[9]` = `buf[25]` in an EP84 reply (`ake::parse_in`); `M'[32]` follows at
+        // `buf[26..58]`.
+        // Verification is logged-only for now (the DisplayLink field offsets in `Stream_Manage` are
+        // not yet confirmed, so a wrong guess must not block the arm); the arm is gated on
+        // receiving
+        // Stream_Ready when it arrives, else on the existing id=0x0b + quiet fallback. `M` key is
+        // `SHA256(kd)`; `M = HMAC-SHA256(STREAMID_TYPE || seq_num_M, SHA256(kd))`, seq_num_M = 0.
+        let sha_kd = crypto::sha256(kd);
+        let mut saw_0b = false;
+        let mut saw_ready = false;
+        let mut quiet = 0usize;
+        const QUIET_GAP: usize = 3; // ~3 consecutive empty short reads => dock done pushing
+        const MAX_ROUNDS: usize = 48;
+        for _ in 0..MAX_ROUNDS {
+            match dev.bulk_recv(EP_CTRL_IN, &mut buf, Delta::from_millis(5)) {
+                Ok(len) if len >= 20 => {
+                    quiet = 0;
+                    let iid = u16::from_le_bytes([buf[16], buf[17]]);
+                    let isub = u16::from_le_bytes([buf[18], buf[19]]);
+                    let mid = if len >= 26 { buf[25] } else { 0 }; // HDCP msg_id (body[9])
+                    if isub == 0x84 && iid == 0x0b {
+                        saw_0b = true;
+                    }
+                    if mid == ake::id::REPEATERAUTH_STREAM_READY && len >= 58 {
+                        saw_ready = true;
+                        let mprime = &buf[26..58];
+                        pr_info!("vino: AKE: Stream_Ready (0x11) M'={mprime:02x?}\n");
+                        // M = HMAC-SHA256(SHA256(kd), data) where data is the Content Stream
+                        // Management input the dock hashes: `k` 7-byte stream entries followed by
+                        // the 3-byte `seq_num_M` (=0 on the first Stream_Manage). Cracked from the
+                        // DLM aarch64 decompile (`FUN_0057be04`: data = memcpy(streams, k*7) ||
+                        // BE16(field) || field, keyed by the 32-byte SHA256(kd) at session+0x37);
+                        // reproduces DLM's captured M' byte-exact (captures/.../FINDINGS.md).
+                        // vino's
+                        // two streams carry the same StreamID_Type bytes its Stream_Manage sends
+                        // (`repeater_auth_stream_manage`: type 0x04 and 0x05), so the dock computes
+                        // the same M. (Earlier code guessed a 5-byte STREAMID_TYPE||seq layout and
+                        // so
+                        // always mismatched -- host-side only, never gated the dock.)
+                        let m_data: [u8; 17] = [
+                            0, 0, 0, 0x04, 0, 0, 0, // stream 0: StreamID_Type[0] = 4
+                            0, 0, 0, 0x05, 0, 0, 0, // stream 1: StreamID_Type[1] = 5
+                            0, 0, 0, // seq_num_M = 0 (first Stream_Manage, big-endian)
+                        ];
+                        let m = crypto::hmac_sha256(&sha_kd, &m_data);
+                        let eq = if &m[..] == mprime { "==" } else { "!=" };
+                        pr_info!("vino: AKE:   M {} M' (CSM stream-entry layout)\n", eq);
+                    } else if mid == ake::id::RECEIVER_AUTH_STATUS && len >= 27 {
+                        pr_info!("vino: AKE: RECEIVER_AUTH_STATUS=0x{:02x}\n", buf[26]);
+                    }
+                    // * 2026-06-12: arm the INSTANT both terminal markers have arrived -- the
+                    // cap-complete
+                    // id=0x0b AND the Stream_Ready (the trailing id=0x28 / HDCP 0x11). DLM arms
+                    // 0.46 ms
+                    // after its last cap block; a cold-plug cadence diff
+                    // (vino-cold-20260612-113706) showed
+                    // vino was instead waiting QUIET_GAP x 5 ms of EMPTY reads AFTER already
+                    // seeing both
+                    // markers, landing the arm ~68 ms late -- outside the dock's freshly-keyed CP
+                    // window, so
+                    // the dock errored on the arm (27 KB type=0x1001 dump) instead of engaging.
+                    // Once both
+                    // markers are in, the terminal burst is complete; arm now, like DLM. (The
+                    // empty-read
+                    // quiet path below remains the fallback when Stream_Ready never arrives.)
+                    if saw_0b && saw_ready {
+                        pr_info!("vino: cap-complete (id=0x0b + Stream_Ready 0x11) -- arming now\n");
+                        return;
+                    }
+                }
+                // Empty/short read = a quiet window. Fallback when Stream_Ready (0x11) never
+                // arrives:
+                // once id=0x0b has arrived AND the dock has been quiet for QUIET_GAP rounds, the
+                // terminal burst is drained -- arm now.
+                _ => {
+                    if saw_0b {
+                        quiet += 1;
+                        if quiet >= QUIET_GAP {
+                            pr_info!(
+                                "vino: cap-complete drained (id=0x0b{}+ quiet) -- arming now\n",
+                                if saw_ready { ", Stream_Ready 0x11, " } else { " (no 0x11) " }
+                            );
+                            return;
+                        }
+                    }
+                }
+            }
+        }
+        pr_info!(
+            "vino: cap-complete drain budget hit (saw_0b={saw_0b} saw_ready={saw_ready}) -- arming anyway\n"
+        );
+    }
+
+
+    /// Drives a full clean-room HDCP 2.2 AKE + LC + SKE (and RepeaterAuth for a
+    /// repeater sink) over EP `0x02`/`0x84`, verifying `H'`, `L'` and `V'` against
+    /// our own KDF (sec 5). On success returns the [`Session`] keys.
+    ///
+    /// All HDCP transfers use transport `seq=0`; the `hdcp_seq` counter increments
+    /// 1..7 across the OUT messages (sec 5.1). Best-effort: any mismatch/short read
+    /// aborts with an error the caller logs.
+    fn run_ake(dev: &usb::Device) -> Result<Session> {
+        use ake::id;
+
+        // Flush any STALE EP84 frames the dock still has queued from a PRIOR session before
+        // starting a fresh AKE. On a warm rmmod/insmod re-probe the dock is not power-cycled, so
+        // its previous CP/cap replies (including a multi-KB residual block) sit in its EP84 queue;
+        // if we don't drain them, the first `recv_hdcp` picks up a stale frame and the whole AKE
+        // reply stream is shifted. Harmless on a true cold plug -- the queue is already empty, so
+        // the first read just times out. Best-effort.
+        if let Ok(mut flush) = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL) {
+            let mut flushed = 0usize;
+            for _ in 0..32 {
+                match dev.bulk_recv(EP_CTRL_IN, &mut flush, Delta::from_millis(20)) {
+                    Ok(n) if n > 0 => flushed += 1,
+                    _ => break,
+                }
+            }
+            if flushed > 0 {
+                pr_info!("vino: flushed {flushed} stale EP84 frame(s) before AKE\n");
+            }
+        }
+
+        // (1) AKE_Init -- fresh rtx, TxCaps = 00 00 00 (DLM-exact).
+        let mut rtx = [0u8; 8];
+        rng::fill(&mut rtx);
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_init(1, 0, &rtx, &[0; 3])?, timeout())?;
+
+        // (2) AKE_Send_Cert: payload = REPEATER(1) || cert_rx(522). Extract the
+        // RSA-1024 public key (modulus[5..133], exponent[133..136]).
+        let (cid, cert_msg) = Self::recv_hdcp(dev)?;
+        if cid != id::AKE_SEND_CERT || cert_msg.len() < 1 + 136 {
+            pr_err!("vino: AKE: bad AKE_Send_Cert (id={cid:#x}, {} B)\n", cert_msg.len());
+            return Err(EINVAL);
+        }
+        let repeater = cert_msg[0] != 0;
+        let cert = &cert_msg[1..];
+        let mut modulus = [0u8; 128];
+        modulus.copy_from_slice(&cert[5..133]);
+        let mut exponent = [0u8; 3];
+        exponent.copy_from_slice(&cert[133..136]);
+
+        // (3) AKE_Transmitter_Info, then (4) read AKE_Receiver_Info (RxCaps unused).
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_transmitter_info(2, 0)?, timeout())?;
+        let _ = Self::recv_hdcp(dev)?;
+
+        // (5) AKE_No_Stored_km -- fresh km, RSA-OAEP-SHA256 to Ekpub(km).
+        let mut km = [0u8; 16];
+        rng::fill(&mut km);
+        let ekpub = hdcp::oaep_encrypt_km(&modulus, &exponent, &km)?;
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_no_stored_km(3, 0, &ekpub)?, timeout())?;
+
+        // (6) AKE_Send_Rrx.
+        let (rid, rrx_pl) = Self::recv_hdcp(dev)?;
+        if rid != id::AKE_SEND_RRX || rrx_pl.len() < 8 {
+            pr_err!("vino: AKE: bad AKE_Send_Rrx (id={rid:#x})\n");
+            return Err(EINVAL);
+        }
+        let mut rrx = [0u8; 8];
+        rrx.copy_from_slice(&rrx_pl[..8]);
+
+        // (7)/(8) AKE_Send_H_prime -- verify H' = HMAC(kd, rtx^REPEATER).
+        let (hid, hp) = Self::recv_hdcp(dev)?;
+        if hid != id::AKE_SEND_H_PRIME || hp.len() < 32 {
+            pr_err!("vino: AKE: bad H' (id={hid:#x})\n");
+            return Err(EINVAL);
+        }
+        let kd = hdcp::derive_kd(&km, &rtx, &rrx)?;
+        if hdcp::compute_h(&kd, &rtx, repeater)[..] != hp[..32] {
+            pr_err!("vino: AKE: H' mismatch -- authentication failed\n");
+            return Err(EINVAL);
+        }
+        pr_info!("vino: AKE: H' verified\n");
+
+        // (9) AKE_Send_Pairing_Info (Ekh_km) -- read and discard (no-stored path).
+        let _ = Self::recv_hdcp(dev)?;
+
+        // (10) Locality Check -- LC_Init(rn) then verify L'.
+        let mut rn = [0u8; 8];
+        rng::fill(&mut rn);
+        dev.bulk_send(EP_CTRL_OUT, &ake::lc_init(4, 0, &rn)?, timeout())?;
+        let (lid, lp) = Self::recv_hdcp(dev)?;
+        if lid != id::LC_SEND_L_PRIME || lp.len() < 32 {
+            pr_err!("vino: AKE: bad L' (id={lid:#x})\n");
+            return Err(EINVAL);
+        }
+        if hdcp::compute_l(&kd, &rrx, &rn)[..] != lp[..32] {
+            pr_err!("vino: AKE: L' mismatch -- locality check failed\n");
+            return Err(EINVAL);
+        }
+        pr_info!("vino: AKE: L' verified\n");
+
+        // (11) Session Key Exchange -- send Edkey(ks) || riv. The session key and IV are
+        // fresh-random per session.
+        let mut ks = [0u8; 16];
+        let mut riv = [0u8; 8];
+        rng::fill(&mut ks);
+        rng::fill(&mut riv);
+        let edkey = hdcp::compute_eks(&km, &rtx, &rrx, &rn, &ks)?;
+        // Dev diagnostic: the full SKE secrets, so the SKE delivery can be verified OFFLINE
+        // (edkey == ks XOR derive_dkey(km,rtx,rrx,rn,2), and the dock unwrapping to the same ks).
+        // Behind pr_debug, so compiled out unless dynamic debug is enabled.
+        pr_debug!("vino: SKE-SECRETS km={km:02x?} rtx={rtx:02x?} rrx={rrx:02x?} rn={rn:02x?}\n");
+        pr_debug!("vino: SKE-SECRETS ks={ks:02x?} edkey={edkey:02x?}\n");
+        // * riv DERIVATION -- THE CP-ENGAGEMENT BUG, FIXED 2026-06-11.
+        // The SKE delivers the BASE riv (byte7 low-3 head/direction-selector bits cleared); the
+        // dock
+        // derives the per-direction CP riv from that base. GROUND TRUTH from cold-ref AND the live
+        // vino cold-plug diff (captures/dlm-cold-20260611-123347 + vino-cold-20260611-130522):
+        // delivered base byte7 = e8 -> host OUT-CP riv = ec (base | 0x04) -> dock IN-CP riv = ed
+        // (^1).
+        // vino had been sealing OUT-CP with the RAW random `riv` (byte7 e.g. f9 = base f8 | 0x01)
+        // while delivering base f8 -- so the dock, deriving its keystream from f8 (expecting
+        // host-OUT
+        // = fc), could NOT decrypt vino's CP and SILENTLY DROPPED every post-arm frame (0 sub=0x45,
+        // EP84 dead after the arm) even though ks/seal/MAC/frame-format were all byte-correct. The
+        // off-by-one-bit IV was the whole wall. Fix: deliver base, seal OUT with base | 0x04.
+        // The SKE delivers the FULL random riv as-is (DLM does NOT mask the low bits -- verified
+        // on
+        // two decrypted DLM sessions: cold-ref delivers ...e8, dl3cmac delivers ...e7). The host CP
+        // OUT riv = delivered XOR 0x04 (flip byte7 bit 2): cold-ref e8->ec, dl3cmac e7->e3.
+        // cp::in_riv
+        // then ^1 for the dock->host IN stream (ec->ed). vino had been masking the delivered riv
+        // and
+        // sealing with the raw random LSBs, so the dock (deriving its keystream as delivered^0x04)
+        // got a different keystream and silently dropped every CP frame. See the vino cold-plug
+        // diff.
+        let riv_ske = riv; // deliver the full random riv, unmasked, exactly like DLM
+        riv[7] ^= 0x04; // host OUT-CP riv = delivered ^ 0x04
+        dev.bulk_send(EP_CTRL_OUT, &ake::ske_send_eks(5, 0, &edkey, &riv_ske)?, timeout())?;
+        // Dev diagnostic: the live session key/out-riv the dock must hold to decrypt our CP.
+        pr_debug!("vino: SESSION ks={ks:02x?} out_riv={riv:02x?}\n");
+
+        // The LIVE plaintext capability-announce (`build_cap_announce`),
+        // built once V is known below. Empty unless the dock is a repeater (D6000 always is).
+        let mut cap_announce = KVec::new();
+
+        // (12) RepeaterAuth -- verify V' over the ReceiverID_List, ACK, then SM2.
+        if repeater {
+            let (vid, list) = Self::recv_hdcp(dev)?;
+            if vid != id::REPEATERAUTH_SEND_RECEIVERID_LIST || list.len() < 16 {
+                pr_err!("vino: AKE: bad ReceiverID_List (id={vid:#x})\n");
+                return Err(EINVAL);
+            }
+            let split = list.len() - 16;
+            // V = HMAC(kd, list_header): MSB-128 = V' (verify vs the list trailer);
+            // LSB-128 = the RepeaterAuth_Send_Ack value (NOT the MSB -- that was THE bug).
+            let v_full = hdcp::compute_v_full(&kd, &list[..split]);
+            let mut v_ack = [0u8; 16];
+            v_ack.copy_from_slice(&v_full[16..]);
+            if v_full[..16] != list[split..] {
+                pr_err!("vino: AKE: V' mismatch -- repeater verification failed\n");
+                return Err(EINVAL);
+            }
+            pr_info!("vino: AKE: V' verified\n");
+            dev.bulk_send(EP_CTRL_OUT, &ake::repeater_auth_send_ack(6, 0, &v_ack)?, timeout())?;
+            // Read the dock's ctr6 ack before sending ctr7 -- DLM's lockstep pacing, without
+            // which the dock NAKs the back-to-back OUTs ~100 ms each (see `pace_cap_ack`).
+            Self::pace_cap_ack(dev, 6);
+            dev.bulk_send(EP_CTRL_OUT, &ake::repeater_auth_stream_manage(7, 0)?, timeout())?;
+            // Read the dock's ctr7 ack before returning, so the caller's arm marker lands
+            // tight after ctr7 (DLM: 0.46 ms) instead of while the dock is still NAKing.
+            Self::pace_cap_ack(dev, 7);
+            // Then drain the dock's terminal cap burst -- id=0x0b (cap-complete) AND the dock's
+            // `RepeaterAuth_Stream_Ready` (HDCP 0x11, the 3rd id=0x28) -- before the caller arms.
+            // DLM arms only after this burst (cold-ref: id=0x21 -> id=0x0b -> id=0x28/0x11 ->
+            // arm);
+            // arming early makes the dock NAK msg0 ~100 ms and dump a 16 KB error block instead of
+            // engaging. `wait_cap_complete` recognises + verifies the Stream_Ready in place (HDCP
+            // 2.3 Adaptation sec RepeaterAuth). `kd` is needed to check `M == M'`.
+            Self::wait_cap_complete(dev, &kd);
+
+            // Build the LIVE capability-announce now that every field is known. This is the
+            // plaintext re-statement of the 7 AKE OUT messages the dock requires between the
+            // init markers and the arm marker (`CP_CAP_PHASE`). See `build_cap_announce`.
+            // Pass `riv_ske` (the value SKE_Send_Eks actually delivered), NOT `riv` (= session
+            // OUT-CP seal riv = riv_ske ^ 0x04). The cap-announce ctr5 frame is a byte-faithful
+            // re-statement of SKE_Send_Eks, so it must carry the IDENTICAL riv.
+            cap_announce = Self::build_cap_announce(&rtx, &ekpub, &rn, &edkey, &riv_ske, &v_ack)?;
+        }
+
+        Ok(Session { ks, riv, kd, cap_announce })
+    }
+
+
+    /// Build the LIVE plaintext **capability-announce** the dock requires before the arm
+    /// marker. Ground truth: the cold-ref raw wire
+    /// (`captures/cold-ref-20260608-200850/`, t~36.754-36.813) shows DLM, *after* the HDCP
+    /// AKE, sends 7 plaintext `type=4 wsub=0x04` frames that are a re-statement of the 7 AKE
+    /// OUT messages -- `id=0x22/0x1f/0x9a/0x22/0x32/0x2a/0x2d`, `sub=0x10`, ctr 1-7 -- each
+    /// carrying THIS session's real value: f1=rtx, f2=const TxCaps, f3=Ekpub(km)[128],
+    /// f4=rn, f5=Edkey(ks)[16]||riv_base[8], f6=V[16], f7=const Stream_Manage config. The dock
+    /// ACKs each (`id=0x14 sub=0x10 ctr=N`) and only then engages its CP cipher; skipping the
+    /// announce leaves it cipher-off (the long-standing "0 `sub=0x45` acks" symptom).
+    ///
+    /// [`golden::CAP_PLAIN_1080P`] is a byte-correct *skeleton* (headers/aux/lead bytes and the
+    /// two constant frames are session-invariant -- verified across the cold-ref and matched
+    /// sessions) but its 5 variable payloads are a STALE foreign session's values. Replaying it
+    /// verbatim delivers the dock a stale Ekpub/Edkey/riv that re-key it to a foreign `ks`
+    /// (the `cap_phase`-clobbers-`ks` bug). So we clone the skeleton and overwrite ONLY the 5
+    /// session-specific payloads. Each payload sits at frame offset 44 (16-byte wire header +
+    /// 22 inner-prefix bytes + the `30 00 00 00 00` marker + 1 lead byte = 28 inner bytes), and
+    /// frames are stored `[u16 len][frame]`. `riv` here is the SKE-*delivered* riv (`riv_ske`),
+    /// written verbatim -- frame 5 is a byte-faithful re-statement of `SKE_Send_Eks`, so it must
+    /// carry the EXACT delivered riv. (It earlier wrote `riv & 0xF8`, which equals the delivered
+    /// value only when the random riv's low 3 bits are zero -- true for cold-ref's `e8` but wrong
+    /// for 7 of 8 live sessions, so the dock saw a different riv in the announce than in SKE.
+    /// Ground truth: cold-ref ctr5 capture t=36.812413 delivers riv `...40e8` == its SKE riv.)
+    fn build_cap_announce(
+        rtx: &[u8; 8],
+        ekpub: &[u8; 128],
+        rn: &[u8; 8],
+        edkey: &[u8; 16],
+        riv: &[u8; 8],
+        v: &[u8; 16],
+    ) -> Result<KVec<u8>> {
+        let mut blob = KVec::with_capacity(golden::CAP_PLAIN_1080P.len(), GFP_KERNEL)?;
+        blob.extend_from_slice(golden::CAP_PLAIN_1080P, GFP_KERNEL)?;
+
+        // Walk the skeleton; for each frame, overwrite the payload (at frame+44) keyed by ctr.
+        let mut off = 0usize;
+        while off + 2 <= blob.len() {
+            let len = u16::from_le_bytes([blob[off], blob[off + 1]]) as usize;
+            let frame = off + 2;
+            if frame + len > blob.len() {
+                break;
+            }
+            // ctr (inner offset 4) identifies which AKE message this announce frame restates.
+            let ctr = u16::from_le_bytes([blob[frame + 16 + 4], blob[frame + 16 + 5]]);
+            let pay = frame + 44; // 16 hdr + 22 inner-prefix + 5 marker + 1 lead
+            match ctr {
+                1 => blob[pay..pay + 8].copy_from_slice(rtx), // AKE_Init
+                3 => blob[pay..pay + 128].copy_from_slice(ekpub), // AKE_No_Stored_km Ekpub
+                4 => blob[pay..pay + 8].copy_from_slice(rn), // LC_Init
+                5 => {
+                    // SKE_Send_Eks: Edkey(ks)[16] || riv[8] (the delivered riv, verbatim)
+                    blob[pay..pay + 16].copy_from_slice(edkey);
+                    blob[pay + 16..pay + 24].copy_from_slice(riv);
+                }
+                6 => blob[pay..pay + 16].copy_from_slice(v), // RepeaterAuth_Send_Ack V
+                _ => {} // ctr 2 (TxCaps) and 7 (Stream_Manage) are session-invariant
+            }
+            off = frame + len;
+        }
+        Ok(blob)
+    }
+
+
+    /// Poll EP 0x83 (interrupt-IN status endpoint). DLM submits URBs here CONTINUOUSLY and the dock
+    /// pushes 6-byte status events; the dock may gate CP/downstream-HDCP engagement on the host
+    /// servicing this endpoint (flagged in `vino-driver/src/bin/bringup.rs`). vino never polled it
+    /// --
+    /// invisible in the EP02/EP84 bulk-wire comparison. Reads up to a few events (short timeout so
+    /// a
+    /// URB is pending when the dock pushes). `usb_bulk_msg` auto-routes the interrupt endpoint.
+    fn poll_ep83(dev: &usb::Device) -> usize {
+        // EP83 (interrupt-IN) transfers need DMA-capable memory -- allocate on the HEAP.
+        // A stack array trips usb_hcd_map_urb_for_dma's "transfer buffer is on stack"
+        // WARNING (VMAP_STACK can't be DMA-mapped) and the broken submit also stalls the
+        // bring-up (poll_ep83 runs inside every drain round). Best-effort: bail on OOM.
+        let mut buf = match KVec::from_elem(0u8, 64, GFP_KERNEL) {
+            Ok(b) => b,
+            Err(_) => return 0,
+        };
+        let mut n = 0usize;
+        // Short timeout: a pending URB gives the dock a window to push, but a 30 ms block on the
+        // (normally idle) EP83 stalls the bring-up loop (see drain_ep84). 2 ms is enough to catch a
+        // ready event without serializing the handshake.
+        for _ in 0..4 {
+            match dev.interrupt_recv(0x83, &mut buf, Delta::from_millis(2)) {
+                Ok(len) if len > 0 => {
+                    n += 1;
+                    let s = &buf[..len.min(8)];
+                    pr_info!("vino: EP83 status event {len}B {s:02x?}\n");
+                }
+                _ => break,
+            }
+        }
+        n
+    }
+
 }
 
 kernel::usb_device_table!(
-- 
2.54.0

