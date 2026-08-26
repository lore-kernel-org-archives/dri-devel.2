Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E78C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB91610E325;
	Wed, 26 Aug 2026 16:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="WhReDWXK";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B772510E317
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:13 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so5601155e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762112; x=1788366912;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fib2m4ECpynx9J+amS0YrKz2SnFl+TEiiRaglDGDZis=;
 b=WhReDWXK39Dz1sFJBQjVDKJB2PjNYAFz4aIichJOx+RZToo/exUkWZpBKzCCPR0wXN
 E2SJ7B8A2+AMv8ljPjQ4dxUmn7HiJ/WjaXQcB3LnYaJSIvLD6VmUv2Re2A64hdP44guz
 Odih2EtK0UVb2/fQXMh80u6B2E3Ut7Yi5KX8MRV/87YmiqEnLLx4QxeDDyvONlJg82ZU
 mU96DhbbOgTT67V1yw5uvpi+0jU5+zAgPCUGWEuM+1a+zZhcF87/SJLJcqVJfzY/ZVHn
 zTX+am0k8n0elqpXUyhHMimzVT7bquAjxpM9ydMoo2LLFDKbULMcqOaJlM/D61eJ8PrP
 Fs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762112; x=1788366912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fib2m4ECpynx9J+amS0YrKz2SnFl+TEiiRaglDGDZis=;
 b=RypcCAYqaruhl1f2oBvgiRo/8pb4ZfXCYmIjiP1IdlFICXFNmGecrm8ZC6GXEWZaI5
 k8gkpPGRbgmbZbz4M+pv+83RlyEf8/RZ3d3k4rWuYDQjM/wOsmdeXK7gdgi/iA2XXXcV
 Jh3JhByIFEHG49sWTFquDmIKw3VwkC20powd8AzxBIBJjQK2t1iPSiyybXcQiZ5tnJGC
 0AJwJOZnNEFGJWlXNjLyDKew2AY3+nBJrzyPlZ7ZF/3Ma7xo7bdb6IriLKkl4g7l9vxg
 B+LTBOJFb8w8s+t3F3tg4MwzJ9KD+7OpWwQihUd8cy2z/wbjyO/3RspSyTvifdzDag4j
 EtlA==
X-Gm-Message-State: AFuF++mvwxAmd1KL3TT9nnyiUGixLu2vcQK786LHSz4fwbActTyn8osh
 kcI47Z1+6Zs0qi3s2Y4SCe2/cafQ9SCYixYDPNGkApdlgOzGxy1aeiSXkMyP53SgWIZxDLv8Vzg
 MgIOLJ1fT
X-Gm-Gg: AR+sD11cek8K3RQOTCCAdY9i5FMwGvG7rqw+zl+A6WEb97pYcUESATp0lLvcIkulP6m
 JPLC2C4BoMqh/nr6uvKSy3pgpf8p6X7wtQwLStvghMVFkzfbfzLHmPvvtMmbQ0diyW42ha4kJh9
 YkkvbGr2DUvXdTkSDz1xbUh013NzLi/Al5s3IPFidqZ1FtLTt8ycxrYgORTqmSi2Xl2qn350GCl
 S00Ee4AlbCYgUaK3Apdj0zGfss90divQMZm58B93zHF4YGAEoCic7W+HPRHaziQZn8ebBGj+8cP
 J9x3ucsYbBh7m+UxGdM/cBFE4NXIrl3ZvsFi1a3XBpUIxGa2QlUmXOm3zvyocxp0xtsBbEiYbFO
 ecI5QlV9jweOQJCtsC9FuzNZZixIsEQnD8uzziC8HykiOSGUEB4mUlNHqKiLf/cRzDLM1koYSfX
 HVxE3Y3ppz14cdoQPeiPL522f4UlyqqdF1KsYhTH43nUBjeZkvju4XsbU8mJ70K0JdCb2CvLClK
 dYXvfh4vJygeqR0iAtudzXZ2X/Hfpb2Xnpg
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499dc723fadmr86510025e9.9.1787762112006; 
 Wed, 26 Aug 2026 09:35:12 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:11 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 6/23] rust: drm: expose HDCP 2.2 message identifiers
Date: Wed, 26 Aug 2026 17:31:37 +0100
Message-ID: <20260826163359.4998-7-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163359.4998-1-mike@fireburn.co.uk>
References: <20260826163359.4998-1-mike@fireburn.co.uk>
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

Add a DRM display module with typed identifiers for the standard
HDCP 2.2 protocol messages. Transport drivers can use the canonical
drm_hdcp.h values without reaching into generated bindings.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/drm/display.rs      |  5 +++
 rust/kernel/drm/display/hdcp.rs | 77 +++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs          |  1 +
 4 files changed, 84 insertions(+)
 create mode 100644 rust/kernel/drm/display.rs
 create mode 100644 rust/kernel/drm/display/hdcp.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8db7fe00fa1b..ae3017539767 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -34,6 +34,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <drm/display/drm_hdcp.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/clients/drm_client_setup.h>
diff --git a/rust/kernel/drm/display.rs b/rust/kernel/drm/display.rs
new file mode 100644
index 000000000000..007ed284c551
--- /dev/null
+++ b/rust/kernel/drm/display.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! DRM display-helper abstractions.
+
+pub mod hdcp;
diff --git a/rust/kernel/drm/display/hdcp.rs b/rust/kernel/drm/display/hdcp.rs
new file mode 100644
index 000000000000..966fb67c6f31
--- /dev/null
+++ b/rust/kernel/drm/display/hdcp.rs
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+//! High-bandwidth Digital Content Protection definitions.
+//!
+//! C header: [`include/drm/display/drm_hdcp.h`](srctree/include/drm/display/drm_hdcp.h)
+
+use crate::bindings;
+
+/// Transmitter nonce length.
+pub const RTX_LEN: usize = bindings::HDCP_2_2_RTX_LEN as usize;
+/// Receiver nonce length.
+pub const RRX_LEN: usize = bindings::HDCP_2_2_RRX_LEN as usize;
+/// Receiver RSA modulus length.
+pub const RSA_MODULUS_LEN: usize = bindings::HDCP_2_2_K_PUB_RX_MOD_N_LEN as usize;
+/// Receiver RSA public exponent length.
+pub const RSA_EXPONENT_LEN: usize = bindings::HDCP_2_2_K_PUB_RX_EXP_E_LEN as usize;
+/// Encrypted master-key length.
+pub const ENCRYPTED_MASTER_KEY_LEN: usize = bindings::HDCP_2_2_E_KPUB_KM_LEN as usize;
+/// H-prime verifier length.
+pub const H_PRIME_LEN: usize = bindings::HDCP_2_2_H_PRIME_LEN as usize;
+/// Locality-check nonce length.
+pub const RN_LEN: usize = bindings::HDCP_2_2_RN_LEN as usize;
+/// L-prime verifier length.
+pub const L_PRIME_LEN: usize = bindings::HDCP_2_2_L_PRIME_LEN as usize;
+/// Encrypted session-key length.
+pub const ENCRYPTED_SESSION_KEY_LEN: usize = bindings::HDCP_2_2_E_DKEY_KS_LEN as usize;
+/// Session-key nonce length.
+pub const RIV_LEN: usize = bindings::HDCP_2_2_RIV_LEN as usize;
+/// One half of the repeater V-prime verifier.
+pub const V_PRIME_HALF_LEN: usize = bindings::HDCP_2_2_V_PRIME_HALF_LEN as usize;
+
+/// An HDCP 2.2 protocol message identifier.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub struct MessageId(u8);
+
+impl MessageId {
+    /// No message.
+    pub const NULL: Self = Self(bindings::HDCP_2_2_NULL_MSG as u8);
+    /// Authentication and Key Exchange initialization.
+    pub const AKE_INIT: Self = Self(bindings::HDCP_2_2_AKE_INIT as u8);
+    /// Receiver certificate.
+    pub const AKE_SEND_CERT: Self = Self(bindings::HDCP_2_2_AKE_SEND_CERT as u8);
+    /// Encrypted master key for a receiver without stored pairing information.
+    pub const AKE_NO_STORED_KM: Self = Self(bindings::HDCP_2_2_AKE_NO_STORED_KM as u8);
+    /// Encrypted master key and pairing nonce for a paired receiver.
+    pub const AKE_STORED_KM: Self = Self(bindings::HDCP_2_2_AKE_STORED_KM as u8);
+    /// Receiver's H-prime authentication value.
+    pub const AKE_SEND_H_PRIME: Self = Self(bindings::HDCP_2_2_AKE_SEND_HPRIME as u8);
+    /// Receiver pairing information.
+    pub const AKE_SEND_PAIRING_INFO: Self = Self(bindings::HDCP_2_2_AKE_SEND_PAIRING_INFO as u8);
+    /// Locality-check initialization.
+    pub const LC_INIT: Self = Self(bindings::HDCP_2_2_LC_INIT as u8);
+    /// Receiver's L-prime locality-check value.
+    pub const LC_SEND_L_PRIME: Self = Self(bindings::HDCP_2_2_LC_SEND_LPRIME as u8);
+    /// Session-key exchange.
+    pub const SKE_SEND_EKS: Self = Self(bindings::HDCP_2_2_SKE_SEND_EKS as u8);
+    /// Repeater receiver-ID list.
+    pub const REPEATERAUTH_SEND_RECEIVERID_LIST: Self =
+        Self(bindings::HDCP_2_2_REP_SEND_RECVID_LIST as u8);
+    /// Repeater receiver-ID-list acknowledgment.
+    pub const REPEATERAUTH_SEND_ACK: Self = Self(bindings::HDCP_2_2_REP_SEND_ACK as u8);
+    /// Repeater stream-management request.
+    pub const REPEATERAUTH_STREAM_MANAGE: Self = Self(bindings::HDCP_2_2_REP_STREAM_MANAGE as u8);
+    /// Repeater stream-ready response.
+    pub const REPEATERAUTH_STREAM_READY: Self = Self(bindings::HDCP_2_2_REP_STREAM_READY as u8);
+
+    /// Return the wire value.
+    pub const fn as_u8(self) -> u8 {
+        self.0
+    }
+}
+
+impl From<MessageId> for u8 {
+    fn from(value: MessageId) -> Self {
+        value.as_u8()
+    }
+}
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index 786cd9c1ec07..4576d66a6bb6 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -3,6 +3,7 @@
 //! DRM subsystem abstractions.
 
 pub mod device;
+pub mod display;
 pub mod driver;
 pub mod file;
 pub mod fourcc;
