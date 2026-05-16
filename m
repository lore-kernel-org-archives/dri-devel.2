Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C10FCD4F55
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE8010E6DD;
	Mon, 18 May 2026 07:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nanonej.com header.i=@nanonej.com header.b="isKO0Hmm";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752C710E1D2
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 16:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nanonej.com;
 s=protonmail2; t=1778948051; x=1779207251;
 bh=eA9tHApnDw5qnZidoKjuo7JfOLFqrjt/OrLru+PEHB4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=isKO0Hmmg3sSAZi34q/71jkCgqpA7Qv/3OA4nn1Kbsiwig8DYsXC4E2c6RF2+hIOW
 bqUfFXzau2e8VZtbJtVMfe1u3utDIdXa7tj3CJBMXpt0PMVkgfU1HuzL0tUqdn21ka
 4Wg468WHL4CJOYBy6WbOLhdhkFRTSM03Dd57YP5cVWTPUFNOB732xAsrB5FY8zxOc+
 gdiCCgoebwsgKIBQSKl0bIE9Z2C9qacyaxfY2TIvnzCqs40m/SnUbLJqCu2b6b4efp
 bLZjG3XhXqnZihGgJvLAeMqx7mQfCIRMmmrWG4j4epUcHH75d5mH0qzDodxNrIC7Zc
 /LqDafXO3I+gQ==
Date: Sat, 16 May 2026 16:14:05 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
From: Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: Antonin Malzieu Ridolfi <dev@nanonej.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH] Nova: Move register definition into module using it
Message-ID: <20260516161258.455442-1-dev@nanonej.com>
Feedback-ID: 32181229:user:proton
X-Pm-Message-ID: 717a06c289923454c87c29cb11407185f5312a6e
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------f20895d574e33fe6bec321be7996cd7e0e4b8a944eb758f650381f0b077620fa";
 charset=utf-8
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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
--------f20895d574e33fe6bec321be7996cd7e0e4b8a944eb758f650381f0b077620fa
Content-Type: multipart/mixed;
 boundary=2c8ad3e8587c5fb17a275ff723835bac27e077e79cc8c9bf05a701050062
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
Subject: [PATCH] Nova: Move register definition into module using it
Date: Sat, 16 May 2026 18:12:57 +0200
Message-ID: <20260516161258.455442-1-dev@nanonej.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0

--2c8ad3e8587c5fb17a275ff723835bac27e077e79cc8c9bf05a701050062
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First babystep to split the register definitions grouped in nova root
register file to the module which actually use them.

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
index ba5b7f990031..756b9c75dc90 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -21,6 +21,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+mod regs;
 mod sequencer;

 pub(crate) use fw::{
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
i
ndex 275da9b1ee0e..4d54350e8095 100644
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
index 6faeed73901d..d675afbb56b2 100644
--- a/drivers/gpu/nov
a-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -177,14 +177,6 @@ pub(crate) fn higher_bound(self) -> u64 {
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


--2c8ad3e8587c5fb17a275ff723835bac27e077e79cc8c9bf05a701050062
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
--2c8ad3e8587c5fb17a275ff723835bac27e077e79cc8c9bf05a701050062--

--------f20895d574e33fe6bec321be7996cd7e0e4b8a944eb758f650381f0b077620fa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmoIl80JEFKmzSsu6sDwNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmc28eUwgYmxhV5tIXChQtgmFiEEj732AMmMBbsy
gcnRUqbNKy7qwPAAAHHFAP4voH2YlNIFsLP86SwmCGgVPw0zXNRhCSwwC8Z1
+0YatQD/WexnplrjWMzOwuf7yrS2R94SkbaVGPVIJX6ch7hzXQg=
=U3Ds
-----END PGP SIGNATURE-----


--------f20895d574e33fe6bec321be7996cd7e0e4b8a944eb758f650381f0b077620fa--

