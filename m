Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6177BCD8C93
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08A910EA70;
	Sun,  7 Jun 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="jMNxZZJ8";
	dkim-atps=neutral
X-Greylist: delayed 467 seconds by postgrey-1.36 at gabe;
 Sun, 07 Jun 2026 14:18:29 UTC
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E44510EA63
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1780841436; x=1781100636;
 bh=mc1aXwPRhTXQPWkVJ8hArrkVguP6GNBxem9Kvh7S47s=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jMNxZZJ8hAgsyF7tfgG9l7dZL/OiPa2MBEoa3wFOGEWBhMGJ3VIZXdXxbEv4DQFpW
 69QRb2hjug9gqi+n7piemnq4n/T888Gqk746HLdaoRJp+rELWenpzU3pixz+3LzOIc
 rfpKRaGHQkEyXboTUTXxlML8VvjbMp3C+fy58qeEQ1fKz9xGikaKDusrUMl5xEi4W5
 Is95AJZa+2tTPVkgqO0jbdMWBoggqfMlspEDefH17ILLV6Y05KZBc1E4kTYRX7nV2O
 3DaQ+ykdXZTXtpH0efZ32T86tFUPJsrpOH5nXwApMcWuqYdp4YVTbIQnpm+GwrvqJY
 OZ8Hb+7EQEtfQ==
Date: Sun, 07 Jun 2026 14:10:31 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
From: Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: Antonin Malzieu Ridolfi <dev@nanonej.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into gsp
 module
Message-ID: <20260607140949.152575-1-dev@nanonej.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: c1bd045279544bff563024835e5344ac2b622d52
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------cec3ca5dd3a0d2685dc7873493a86b0ca20e61251caf7f4286c56d28b7bc4f44";
 charset=utf-8
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------cec3ca5dd3a0d2685dc7873493a86b0ca20e61251caf7f4286c56d28b7bc4f44
Content-Type: multipart/mixed;
 boundary=72b63b1e0f5d8280d91a0d3de0d4a5e642de8ded7ac7b4e95dc7d84557cc
From: Antonin Malzieu Ridolfi <dev@nanonej.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Antonin Malzieu Ridolfi <dev@nanonej.com>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition into gsp module
Date: Sun,  7 Jun 2026 16:09:40 +0200
Message-ID: <20260607140949.152575-1-dev@nanonej.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--72b63b1e0f5d8280d91a0d3de0d4a5e642de8ded7ac7b4e95dc7d84557cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split the gsp register definitions grouped in nova root
register file to the gsp module which actually use them.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>
---
 drivers/gpu/nova-core/gsp.rs      |  1 +
 drivers/gpu/nova-core/gsp/cmdq.rs |  3 ++-
 drivers/gpu/nova-core/gsp/regs.rs | 11 +++++++++++
 drivers/gpu/nova-core/regs.rs     |  8 --------
 4 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/regs.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 69175ca3315c..385b4c09582b 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -22,6 +22,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod regs;
 mod sequencer;

 pub(crate) use fw::{
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 0bc5a
95a9cd7..495d07d65c39 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -51,10 +51,11 @@
         GSP_PAGE_SIZE, //
     },
     num,
-    regs,
     sbuffer::SBufferIter, //
 };

+use super::regs;
+
 /// Marker type representing the absence of a reply for a command. Commands using this as their
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
diff --git a/drivers/gpu/nova-core/gsp/regs.rs b/drivers/gpu/nova-core/gsp/regs.rs
new file mode 100644
index 000000000000..a76dea3c3ab0
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/regs.rs
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::io::register;
+
+// PGSP
+
+register! {
+    pub(super) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
+        31:0    address;
+    }
+}
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 0f49c1ab83ad..73339a0cff99 100644
--- a/drivers/gpu/nova-core/reg
s.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -227,14 +227,6 @@ pub(crate) fn is_wpr2_set(self) -> bool {
     }
 }

-// PGSP
-
-register! {
-    pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
-        31:0    address;
-    }
-}
-
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except
--
2.54.0


--72b63b1e0f5d8280d91a0d3de0d4a5e642de8ded7ac7b4e95dc7d84557cc
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - dev@nanonej.com -
 0x8FBDF600.asc"; name="publickey - dev@nanonej.com - 0x8FBDF600.asc"
Content-Type: application/pgp-keys; filename="publickey - dev@nanonej.com -
 0x8FBDF600.asc"; name="publickey - dev@nanonej.com - 0x8FBDF600.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FWUVOcThSWUpLd1lCQkFIYVJ3
OEJBUWRBaE9ncm5ac3lDYUlXRXFUTmc2MzRGcldMS1l0N0lubEExVjBNCkkzS28zYUhOSVdSbGRr
QnVZVzV2Ym1WcUxtTnZiU0E4WkdWMlFHNWhibTl1WldvdVkyOXRQc0tQQkJBV0NnQWcKQlFKZ1Ey
cnhCZ3NKQndnREFnUVZDQW9DQkJZQ0FRQUNHUUVDR3dNQ0hnRUFJUWtRVXFiTkt5N3F3UEFXSVFT
UAp2ZllBeVl3RnV6S0J5ZEZTcHMwckx1ckE4Rnc5QVFEMWFENXBqS3llT3UybHpFb05CUC93VUZ1
K3g5UGFWYjBFCjNTaFJGY3V6ZWdFQTJVSEtOdkk0WERNM2NDL0UveVM5ZmdlS29ITmMySHFvOVBq
a2o5cjFlQXZPT0FSZ1EycngKRWdvckJnRUVBWmRWQVFVQkFRZEFPYW1xZmltdGliaE5LQ1d3QjFW
dzZVNVo4ajdWQ1V4TTFDeHBlc3k3WG1jRApBUWdId25nRUdCWUlBQWtGQW1CRGF2RUNHd3dBSVFr
UVVxYk5LeTdxd1BBV0lRU1B2ZllBeVl3RnV6S0J5ZEZTCnBzMHJMdXJBOEVMeEFRQ2xYRkFFR0lM
cGsvT010T2hVSS9SN2hKa3h2WnZGR1pLRTZ1L09XZ211N0FFQTRzVTUKOWdIS0t0a1JIcWtKMTlN
Rnk5Qmt1Ykw2ZUZQTjQyNTVTbFZDUEFrPQo9U1NJMwotLS0tLUVORCBQR1AgUFVCTElDIEtFWSBC
TE9DSy0tLS0t
--72b63b1e0f5d8280d91a0d3de0d4a5e642de8ded7ac7b4e95dc7d84557cc--

--------cec3ca5dd3a0d2685dc7873493a86b0ca20e61251caf7f4286c56d28b7bc4f44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgmole9YJEFKmzSsu6sDwNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdyH9mspuLHYRkCZEtwtHebFiEEj732AMmMBbsy
gcnRUqbNKy7qwPAAADRhAQCUUxFAfyguUT6BtKlUgCmzcAJnB0cVfz0GGBwb
Zr+RXwD/dRrAUlO7x/dUVe9vfH6oGA/iRejYuU/doTwOh7PfoQs=
=bQyb
-----END PGP SIGNATURE-----


--------cec3ca5dd3a0d2685dc7873493a86b0ca20e61251caf7f4286c56d28b7bc4f44--

