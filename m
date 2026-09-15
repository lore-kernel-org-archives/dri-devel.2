Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C63C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A8D10F400;
	Tue, 15 Sep 2026 10:58:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="epit2y1k";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F3910F400
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469922;
 bh=EinmufHSmWsSZi36V8OczT/8JlbhoN6rgawaCWvpYwU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=epit2y1kZDG4wDoVwOH1kf4G68g73h1WzNpdoRTrmK+VMxm3qSe06GGbZP8lwxhlw
 j0bevHnFMTyvo2AsVht8I1WfwMk734E3U17AZZMLxuagIpfTVsW4xQ3NqGRfgVNHRV
 S0t7uh8AlHRNIE63ApdF7Bp0St5bBKZB//O4GFFUzR50rlcpvif2LD5ewwGGSoEe1M
 jlSbaUgdaUltnJgUc9P5zeq5h0t7gsajmXpGuLNuk5uGh6kpzr8nCBXxR3SBdvOfLZ
 nV2kQRDOaDPgIVxYe1HhU5c2hMSTzRwa/+LGA2kuOv99i/vQhiaWFm6KW1ktXZ6UyL
 t/y5PP59BGh6g==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CD47117E0962;
 Tue, 15 Sep 2026 12:58:41 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:34 +0200
Subject: [PATCH 1/9] drm/tyr: validate presence of CSF shared section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-1-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
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

From: Deborah Brouwer <deborah.brouwer@collabora.com>

The firmware binary must have a shared section for communicating with
the MCU. Check for this section after parsing and fail with -EINVAL if it
is missing.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index c4d0ad1d7899..8bddaa1f0aa2 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -197,6 +197,20 @@ pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {
             return Err(EINVAL);
         }
 
+        // Validate that the firmware contains the required shared memory section.
+        let has_shared_section = parsed_sections
+            .iter()
+            .any(|section| section.va.start == super::CSF_MCU_SHARED_REGION_START);
+
+        if !has_shared_section {
+            dev_err!(
+                self.cursor.dev,
+                "No shared section found at 0x{:08x} in firmware\n",
+                super::CSF_MCU_SHARED_REGION_START
+            );
+            return Err(EINVAL);
+        }
+
         Ok(parsed_sections)
     }
 

-- 
2.39.5

