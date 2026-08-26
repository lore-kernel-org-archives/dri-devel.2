Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA491C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B7310ED7A;
	Wed, 26 Aug 2026 16:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="klOT87Y4";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CFB10ED77
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:39:34 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso9433435e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762372; x=1788367172;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tVQl0TQaqGZPy1cFk7T2Duq6yICjnn5v/QGRI0kgw3c=;
 b=klOT87Y4CEQjqqfl4q2jecU9LfekKTJoLTzblkUIjD8cs5i/8xc3OGWijg4OfFib4q
 LfiJuWvzM5+SSM7BTCqh5bW5/hqDG6NOMNEZwuNRIlznng5fecTto1LKPpIml0vJYYdm
 B6k1us3NbEEzbw8Re3QDHswo/rKGVorVUWIe6meOGMDel697cdXTJn07B9cbqd3WSj2E
 gNjcGRcvQsrBce7eOhq+hVeFZ5lZK5nsHuw/bp76YU2UPG8EaFsl02PsJlPsZmGNMdDg
 WEzSejxDNndOTEUnhkw5cGEhIDE4Z7O7VYBDeE/eQcoznS5NFWo9/1xld1qsYIRNURlS
 dnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762372; x=1788367172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tVQl0TQaqGZPy1cFk7T2Duq6yICjnn5v/QGRI0kgw3c=;
 b=GVm5XmZz/OvPSR3Px4ToEsDTRfChLKHsR+YmS7KLT7nLW6YCsDDmfrGNFWCQYegYWE
 KtCiqCbuBEy60/U33V5GWCENo9jcPoIFqJjcIAsQOSlY7Mh6lFNbHyYwkiBBEC09akSC
 T2oaAnZQXD+u2lb9w5154D9iPDIMfv7PU2Qv77cL5EigAXCeLU0o2GFyU+5cZ4/umwTn
 sEG+ZfG0MRL8HBSkhVz8/Tnz7D8HVxe4zmoPhn2si+ITMT7TOw5MaTu9iCvI2TBbgrPc
 UcL0OIBeDsbvvAQT+Mp0fOLrcUlmS1c6MOnEeR9L+WjT4cciccx775LOnuyadGLa4EqB
 HjZQ==
X-Gm-Message-State: AFuF++nBOPwzvR+PwQCtbvvIQFCK7pm3xaYEkiHKrOvJ740YXTSZ+Pc/
 zJ/MyrXcyXsHiG44qO77vp+8RfQJSazvU1u0YfEPXXcHGToyX8T9xGCRWhzU6QNKVdRC+pdWZWZ
 Nwu6q0/4O
X-Gm-Gg: AR+sD124jQkW9uB9G+psufTloyWhRNSYhWHTQuFzdtol3NAmZPC8go/B58NPVVIgrQ7
 CIiDIg2ifWILoC7w/smBgMiudRKuahiBkdZxgPJErhdg+/uhLUph8FL1FFLe3rtezfWv9pepnA8
 T34BW2ulg7vLaEhYPtHSlMAifIg7VPdDxUaG0fb0DlvDQwL430n56PQyi8ecrwyj55BgC/74KFl
 pStVFd/hw+kX6Nc5LnIApsDnlXo6zelXT8LjTuCUDaJxW61GeWILOLahUOJmZ5EIkbu3Y2HgdZK
 LsjE37mUMkXXBvSZPtTX8g+OxfVxi9PvqZPv1vO9MontDqXTO1qgsaVLUNyfkv1Ue/sYwwYFGHj
 lgeggbRgdSwGf59nLtHZ4nb7f/gS3p6XDvCpir8DgUvoCywbdYhHxQ+bdmDNNJpNe2QOlB0afTA
 6et6gfF7N1e0s3+4P6KpdZnYIJLDjQhksgHjAeFznX+p8gx4J19w1WBDlra0EuLYnUNKQZ1gzAU
 qRVGks3MfuUGNUvMqoL6IPZ9rKRitbe8fOHKw==
X-Received: by 2002:a05:600c:698c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499dc6f5dcdmr86286165e9.5.1787762372220; 
 Wed, 26 Aug 2026 09:39:32 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm21769715e9.4.2026.08.26.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:39:28 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/13] drm/vino: add the crypto primitives and the HDCP 2.2
 AKE
Date: Wed, 26 Aug 2026 17:37:28 +0100
Message-ID: <20260826163913.7052-4-mike@fireburn.co.uk>
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

A DL3 dock authenticates as an HDCP 2.2 receiver before it will accept any
configuration, and every later control message is sealed with keys the
authentication establishes. The KDFs are the published HDCP 2.2 ones; what
is not published is that the dock whitens the session key with a fixed
device constant, and that the two nonces derived from the delivered random
IV differ by one bit each and are not interchangeable.

Add the AES, CMAC and RNG wrappers, the HDCP key hierarchy documented once
in one place, and the AKE itself, with the KUnit known-answer vectors that
pin them.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/vino/ake.rs    | 175 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vino/crypto.rs |  90 +++++++++++++++++
 drivers/gpu/drm/vino/hdcp.rs   | 146 +++++++++++++++++++++++++++
 drivers/gpu/drm/vino/rng.rs    |   9 ++
 4 files changed, 420 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/ake.rs
 create mode 100644 drivers/gpu/drm/vino/crypto.rs
 create mode 100644 drivers/gpu/drm/vino/hdcp.rs
 create mode 100644 drivers/gpu/drm/vino/rng.rs

diff --git a/drivers/gpu/drm/vino/ake.rs b/drivers/gpu/drm/vino/ake.rs
new file mode 100644
index 000000000000..54d24ca2d096
--- /dev/null
+++ b/drivers/gpu/drm/vino/ake.rs
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! HDCP 2.2 AKE wire layer: byte-exact message builders for the state machine.
+//! The dock validates fixed per-message `sub_size` and `sub_len_dw` values, so
+//! the vendor framing records those values explicitly rather than deriving them.
+//!
+//! OUT body layout (sec 5.1), after the 16-byte sec 3 transport header:
+//! ```text
+//!   body[0..2]   u16 sub_size      (fixed per message)
+//!   body[2..4]   u16 = 0x0010
+//!   body[4..8]   u32 hdcp_seq      increments 1..7 across the AKE OUT messages
+//!   body[8..22]  14 zero bytes
+//!   body[22..26] u32 = 0x00000030  marker
+//!   body[26]     u8  = 0x00        flag
+//!   body[27]     u8  = msg_id
+//!   body[28..]   HDCP payload (zero-padded to the fixed body length)
+//! ```
+
+use super::*;
+
+/// HDCP 2.2 message IDs (sec 5.3). `pub(crate)` so the AKE state machine
+/// ([`super::VinoDriver::run_ake`]) can match on the response IDs too.
+pub(crate) mod id {
+    use kernel::drm::display::hdcp::MessageId;
+
+    // Standard HDCP 2.2 message IDs: reuse the canonical values from
+    // `<drm/display/drm_hdcp.h>` rather than redefining them, so vino stays in
+    // lockstep with the kernel's HDCP definitions. Only the transport framing
+    // around these (the DisplayLink type/sub/ctr header) is vino-specific.
+    pub(crate) const AKE_INIT: u8 = MessageId::AKE_INIT.as_u8();
+    pub(crate) const AKE_SEND_CERT: u8 = MessageId::AKE_SEND_CERT.as_u8();
+    pub(crate) const AKE_NO_STORED_KM: u8 = MessageId::AKE_NO_STORED_KM.as_u8();
+    pub(crate) const AKE_SEND_H_PRIME: u8 = MessageId::AKE_SEND_H_PRIME.as_u8();
+    pub(crate) const LC_INIT: u8 = MessageId::LC_INIT.as_u8();
+    pub(crate) const LC_SEND_L_PRIME: u8 = MessageId::LC_SEND_L_PRIME.as_u8();
+    pub(crate) const SKE_SEND_EKS: u8 = MessageId::SKE_SEND_EKS.as_u8();
+    pub(crate) const REPEATERAUTH_SEND_RECEIVERID_LIST: u8 =
+        MessageId::REPEATERAUTH_SEND_RECEIVERID_LIST.as_u8();
+    pub(crate) const REPEATERAUTH_SEND_ACK: u8 = MessageId::REPEATERAUTH_SEND_ACK.as_u8();
+    pub(crate) const REPEATERAUTH_STREAM_MANAGE: u8 = MessageId::REPEATERAUTH_STREAM_MANAGE.as_u8();
+    pub(crate) const REPEATERAUTH_STREAM_READY: u8 = MessageId::REPEATERAUTH_STREAM_READY.as_u8();
+
+    // DisplayLink-specific message IDs with no `<drm/display/drm_hdcp.h>` equivalent
+    // (the AKE_Send_rrx split and the transmitter/receiver-info + auth-status messages
+    // the DL3 dock uses), kept as literals.
+    pub(crate) const AKE_SEND_RRX: u8 = 0x06;
+    pub(crate) const RECEIVER_AUTH_STATUS: u8 = 0x12;
+    pub(crate) const AKE_TRANSMITTER_INFO: u8 = 0x13;
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
+/// Wrap a finished HDCP body in the vendor transport header (type=4 sub=0x04)
+/// with the message's fixed `sub_len_dw` and transport `seq`.
+fn wrap(sub_len_dw: u16, seq: u32, body: &[u8]) -> Result<KVec<u8>> {
+    let mut frame = KVec::with_capacity(16 + body.len(), GFP_KERNEL)?;
+    proto::push_frame_with(&mut frame, 0x04, SUB_HDCP, sub_len_dw, seq, body)?;
+    Ok(frame)
+}
+
+/// `session-init ACK` (the `id=0x14 sub=0x76` frame).
+///
+/// This precedes `AKE_Init`, so AKE uses `hdcp_seq` 2..8. It is a minimal
+/// `0x14 / 0x76 / hdcp_seq` header: a 32-byte body without a message payload or the
+/// `0x0010 / 0x30 / msg_id` trailer written by [`body`], wrapped with `sub_len_dw=0x0a`. The dock
+/// echoes it as a `msg_id=0` status frame that `recv_hdcp` skips.
+pub(super) fn session_init_ack(hdcp_seq: u32, seq: u32) -> Result<KVec<u8>> {
+    let mut b = KVec::from_elem(0u8, 32, GFP_KERNEL)?;
+    b[0..2].copy_from_slice(&0x0014u16.to_le_bytes());
+    b[2..4].copy_from_slice(&0x0076u16.to_le_bytes());
+    b[4..8].copy_from_slice(&hdcp_seq.to_le_bytes());
+    wrap(0x000a, seq, &b)
+}
+
+/// `AKE_Init` (msg_id 0x02): `rtx[8] || TxCaps[3]`, padded to a 48-byte body
+/// (`sub_size=0x22`, `sub_len_dw=0x0c`).
+pub(super) fn ake_init(
+    hdcp_seq: u32,
+    seq: u32,
+    rtx: &[u8; drm_hdcp::RTX_LEN],
+    tx_caps: &[u8; 3],
+) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x0022, hdcp_seq, id::AKE_INIT)?;
+    b[28..36].copy_from_slice(rtx);
+    b[36..39].copy_from_slice(tx_caps);
+    wrap(0x000c, seq, &b)
+}
+
+/// `AKE_Transmitter_Info` (msg_id 0x13): byte-exact vendor framing
+/// (`sub_size=0x1f`, `sub_len_dw=0x0f`), payload `00 06 02 00 02`.
+pub(super) fn ake_transmitter_info(hdcp_seq: u32, seq: u32) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x001f, hdcp_seq, id::AKE_TRANSMITTER_INFO)?;
+    b[28..33].copy_from_slice(&[0x00, 0x06, 0x02, 0x00, 0x02]);
+    wrap(0x000f, seq, &b)
+}
+
+/// `AKE_No_Stored_km` (msg_id 0x04): the 128-byte RSA-OAEP-SHA256 `Ekpub(km)`
+/// in a 160-byte body (`sub_size=0x9a`, `sub_len_dw=0x04`).
+pub(super) fn ake_no_stored_km(
+    hdcp_seq: u32,
+    seq: u32,
+    ekpub_km: &[u8; drm_hdcp::ENCRYPTED_MASTER_KEY_LEN],
+) -> Result<KVec<u8>> {
+    let mut b = body(160, 0x009a, hdcp_seq, id::AKE_NO_STORED_KM)?;
+    b[28..156].copy_from_slice(ekpub_km);
+    wrap(0x0004, seq, &b)
+}
+
+/// `LC_Init` (msg_id 0x09): `rn[8]` in a 48-byte body
+/// (`sub_size=0x22`, `sub_len_dw=0x0c`).
+pub(super) fn lc_init(hdcp_seq: u32, seq: u32, rn: &[u8; drm_hdcp::RN_LEN]) -> Result<KVec<u8>> {
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
+    edkey_ks: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+    riv: &[u8; drm_hdcp::RIV_LEN],
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
+    v: &[u8; drm_hdcp::V_PRIME_HALF_LEN],
+) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x002a, hdcp_seq, id::REPEATERAUTH_SEND_ACK)?;
+    b[28..44].copy_from_slice(v);
+    wrap(0x0004, seq, &b)
+}
+
+/// `RepeaterAuth_Stream_Manage` SM2 (msg_id 0x10): `k=2`,
+/// `StreamID_Type[0]=4` and `StreamID_Type[1]=5`.
+pub(super) fn repeater_auth_stream_manage(hdcp_seq: u32, seq: u32) -> Result<KVec<u8>> {
+    let mut b = body(48, 0x002d, hdcp_seq, id::REPEATERAUTH_STREAM_MANAGE)?;
+    b[32..36].copy_from_slice(&[0x02, 0, 0, 0]); // k = 2 (LE)
+    b[36..40].copy_from_slice(&[0x04, 0, 0, 0]); // StreamID_Type[0]
+    b[43] = 0x05; // StreamID_Type[1]
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
index 000000000000..4fc14b8bd70c
--- /dev/null
+++ b/drivers/gpu/drm/vino/crypto.rs
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Thin adapters onto the shared [`kernel::crypto`] library-crypto bindings, so the
+//! protocol code keeps its `crypto::aes128_ecb` / `crypto::hmac_sha256` call sites.
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
+/// `AES_CMAC(ks, nonce8 || BE64(counter) || content)` (see `cp::dl3cmac_tag`).
+pub(super) fn aes_cmac(key: &[u8; 16], data: &[u8]) -> [u8; 16] {
+    kernel::crypto::aes_cmac(key, data)
+}
+
+/// `SHA256(data)`.
+pub(super) fn sha256(data: &[u8]) -> [u8; 32] {
+    kernel::crypto::sha256(data)
+}
+
+#[cfg(CONFIG_DRM_VINO_KUNIT_TEST)]
+#[kunit_tests(vino_crypto)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn aes128_ecb_fips197_kat() -> Result {
+        // FIPS-197 / NIST SP800-38A F.1.1 AES-128 ECB known-answer vector.
+        let key = [
+            0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf,
+            0x4f, 0x3c,
+        ];
+        let plaintext = [
+            0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93,
+            0x17, 0x2a,
+        ];
+        assert_eq!(
+            aes128_ecb(&key, &plaintext)?,
+            [
+                0x3a, 0xd7, 0x7b, 0xb4, 0x0d, 0x7a, 0x36, 0x60, 0xa8, 0x9e, 0xca, 0xf3, 0x24, 0x66,
+                0xef, 0x97,
+            ]
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn aes_cmac_rfc4493_kat() -> Result {
+        // RFC 4493 sec 4 AES-CMAC test vectors (same key as above).
+        let key = [
+            0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf,
+            0x4f, 0x3c,
+        ];
+        assert_eq!(
+            aes_cmac(&key, &[]),
+            [
+                0xbb, 0x1d, 0x69, 0x29, 0xe9, 0x59, 0x37, 0x28, 0x7f, 0xa3, 0x7d, 0x12, 0x9b, 0x75,
+                0x67, 0x46,
+            ]
+        );
+        let msg = [
+            0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93,
+            0x17, 0x2a,
+        ];
+        assert_eq!(
+            aes_cmac(&key, &msg),
+            [
+                0x07, 0x0a, 0x16, 0xb4, 0x6b, 0x4d, 0x41, 0x44, 0xf7, 0x9b, 0xdd, 0x9d, 0xd0, 0x4a,
+                0x28, 0x7c,
+            ]
+        );
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/drm/vino/hdcp.rs b/drivers/gpu/drm/vino/hdcp.rs
new file mode 100644
index 000000000000..5118c9388cc3
--- /dev/null
+++ b/drivers/gpu/drm/vino/hdcp.rs
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! HDCP 2.2 key derivation and verifier computation, built on [`crypto`].
+//!
+//! # The key hierarchy
+//!
+//! Every key below is per-session: they are established once by the AKE and SKE exchanges at
+//! bring-up and then used for the life of the link. Nothing here is per-frame. The names are the
+//! ones the HDCP 2.2 specification uses, so that a reader can follow the spec alongside the code,
+//! and this is the one place that says how they relate.
+//!
+//! ```text
+//!   km   (16 bytes, host random)        AKE master key. Sent to the dock RSA-OAEP encrypted
+//!    |                                  under its public key, so only the dock recovers it.
+//!    |
+//!    +-- dkey_0, dkey_1  (rn = 0)  -->  kd = dkey_0 || dkey_1   (32 bytes)
+//!    |                                  The derived key. Not a content key: it exists to prove
+//!    |                                  both ends hold km, via H', L' and V.
+//!    |
+//!    +-- dkey_2          (rn = SKE nonce)
+//!                                  -->  masks ks in transit:
+//!                                       edkey = ks XOR (dkey_2 with its low 8 bytes XOR rrx)
+//!
+//!   ks   (16 bytes, host random)        SKE content session key. Delivered under the mask above,
+//!    |                                  never in clear.
+//!    |
+//!    +-- XOR CP_KEY_WHITEN         -->  the control-plane seal key (see [`cp`](super::cp))
+//!
+//!   riv  (8 bytes)                      Content random IV, delivered beside ks. Nonces for the
+//!                                       control plane are derived from it by fixed byte flips.
+//! ```
+//!
+//! `kd` and `ks` are easy to confuse and are not interchangeable: `kd` is 32 bytes and
+//! authenticates, `ks` is 16 bytes and encrypts. Both come from `km`, by different derivations.
+
+use super::*;
+
+/// `dkey_n = AES_ECB(km with low-8-bytes XOR rn, rtx || (rrx with byte15 XOR n))`
+/// (HDCP 2.2 IIA sec 2.7, sec 5.6). The counter `n` XORs into byte 15 (LSB of the rrx
+/// half) of the IV; `rn` XORs into the low 8 bytes (km[8..16]) of the key -- zero
+/// for the `kd` derivation, the SKE nonce for `dkey_2`.
+fn derive_dkey(
+    km: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+    rn: &[u8; drm_hdcp::RN_LEN],
+    rtx: &[u8; drm_hdcp::RTX_LEN],
+    rrx: &[u8; drm_hdcp::RRX_LEN],
+    n: u8,
+) -> Result<kernel::crypto::Secret<{ drm_hdcp::ENCRYPTED_SESSION_KEY_LEN }>> {
+    let mut iv = [0u8; kernel::crypto::AES128_BLOCK_SIZE];
+    iv[..drm_hdcp::RTX_LEN].copy_from_slice(rtx);
+    iv[drm_hdcp::RTX_LEN..].copy_from_slice(rrx);
+    iv[kernel::crypto::AES128_BLOCK_SIZE - 1] ^= n;
+    let mut key = kernel::crypto::Secret::new(*km);
+    for i in 0..drm_hdcp::RN_LEN {
+        key[kernel::crypto::AES128_BLOCK_SIZE - drm_hdcp::RN_LEN + i] ^= rn[i];
+    }
+    Ok(kernel::crypto::Secret::new(crypto::aes128_ecb(&key, &iv)?))
+}
+
+/// `kd = dkey_0 || dkey_1` with `rn = 0` (sec 5.6) -- the 256-bit derived key.
+pub(super) fn derive_kd(
+    km: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+    rtx: &[u8; drm_hdcp::RTX_LEN],
+    rrx: &[u8; drm_hdcp::RRX_LEN],
+) -> Result<kernel::crypto::Secret<32>> {
+    let rn = [0u8; drm_hdcp::RN_LEN];
+    let dkey0 = derive_dkey(km, &rn, rtx, rrx, 0)?;
+    let dkey1 = derive_dkey(km, &rn, rtx, rrx, 1)?;
+    let mut kd = kernel::crypto::Secret::zeroed();
+    kd[..kernel::crypto::AES128_BLOCK_SIZE].copy_from_slice(&dkey0[..]);
+    kd[kernel::crypto::AES128_BLOCK_SIZE..].copy_from_slice(&dkey1[..]);
+    Ok(kd)
+}
+
+/// `H' = HMAC-SHA256(kd, rtx with byte7 ^= repeater)` (sec 5.6).
+pub(super) fn compute_h(
+    kd: &[u8; 32],
+    rtx: &[u8; drm_hdcp::RTX_LEN],
+    repeater: bool,
+) -> [u8; drm_hdcp::H_PRIME_LEN] {
+    let mut msg = *rtx;
+    msg[drm_hdcp::RTX_LEN - 1] ^= repeater as u8;
+    crypto::hmac_sha256(kd, &msg)
+}
+
+/// `L' = HMAC-SHA256(kd with low-8-bytes XOR rrx, rn)` (sec 5.6).
+///
+/// "low-8-bytes" is the *least-significant* 64 bits of the 256-bit `kd`, i.e.
+/// `kd[24..32]`.
+pub(super) fn compute_l(
+    kd: &[u8; 32],
+    rrx: &[u8; drm_hdcp::RRX_LEN],
+    rn: &[u8; drm_hdcp::RN_LEN],
+) -> [u8; drm_hdcp::L_PRIME_LEN] {
+    let mut key = kernel::crypto::Secret::new(*kd);
+    for i in 0..drm_hdcp::RRX_LEN {
+        key[32 - drm_hdcp::RRX_LEN + i] ^= rrx[i];
+    }
+    crypto::hmac_sha256(&key[..], rn)
+}
+
+/// Full `V = HMAC-SHA256(kd, list_header)` (256 bits) for RepeaterAuth (sec 2.3).
+///
+/// The MSB 128 bits (`[..16]`) are `V'` from the receiver ID list. The LSB 128 bits (`[16..]`)
+/// are sent in `RepeaterAuth_Send_Ack`; echoing `V'` there prevents the dock from completing
+/// repeater authentication.
+pub(super) fn compute_v_full(kd: &[u8; 32], list_header: &[u8]) -> [u8; 32] {
+    crypto::hmac_sha256(kd, list_header)
+}
+
+/// RSA-OAEP-SHA256 encrypt the 16-byte master key `km` under the dock's
+/// RSA-1024 public key (`modulus[128]`, `exponent`), giving the 128-byte
+/// `Ekpub(km)` for `AKE_No_Stored_km` (sec 5.4). Generates a fresh OAEP seed.
+pub(super) fn oaep_encrypt_km(
+    key: &mut kernel::crypto::akcipher::RsaPublicKey,
+    km: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+) -> Result<[u8; drm_hdcp::ENCRYPTED_MASTER_KEY_LEN]> {
+    let mut seed = kernel::crypto::Secret::zeroed();
+    super::rng::fill(&mut seed[..]);
+    let mut out = [0u8; drm_hdcp::ENCRYPTED_MASTER_KEY_LEN];
+    key.oaep_sha256_encrypt(km, &seed, &mut out, GFP_KERNEL)?;
+    Ok(out)
+}
+
+/// SKE: `Edkey(ks) = ks XOR (dkey_2 with low-8-bytes XOR rrx)` (sec 5.6).
+///
+/// `dkey_2` is derived with the SKE nonce `rn` mixed into the key; `rrx` then
+/// XORs into the low 8 bytes (`dkey_2[8..16]`) of the mask. The result is the
+/// 16-byte `Edkey_ks` carried by `SKE_Send_Eks` (msg_id 0x0b).
+pub(super) fn compute_eks(
+    km: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+    rtx: &[u8; drm_hdcp::RTX_LEN],
+    rrx: &[u8; drm_hdcp::RRX_LEN],
+    rn: &[u8; drm_hdcp::RN_LEN],
+    ks: &[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN],
+) -> Result<[u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN]> {
+    let mut mask = derive_dkey(km, rn, rtx, rrx, 2)?;
+    for i in 0..drm_hdcp::RRX_LEN {
+        mask[kernel::crypto::AES128_BLOCK_SIZE - drm_hdcp::RRX_LEN + i] ^= rrx[i];
+    }
+    let mut edkey_ks = [0u8; drm_hdcp::ENCRYPTED_SESSION_KEY_LEN];
+    for i in 0..drm_hdcp::ENCRYPTED_SESSION_KEY_LEN {
+        edkey_ks[i] = ks[i] ^ mask[i];
+    }
+    Ok(edkey_ks)
+}
diff --git a/drivers/gpu/drm/vino/rng.rs b/drivers/gpu/drm/vino/rng.rs
new file mode 100644
index 000000000000..c34766322edd
--- /dev/null
+++ b/drivers/gpu/drm/vino/rng.rs
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Cryptographically-secure randomness for the per-session HDCP nonces/keys
+//! (`rtx`, `km`, `rn`, `ks`, `riv`, the OAEP seed).
+
+/// Fills `buf` with random bytes from the kernel CSPRNG.
+pub(super) fn fill(buf: &mut [u8]) {
+    kernel::random::fill_bytes(buf);
+}
