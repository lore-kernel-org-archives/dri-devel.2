Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14229CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E03510E54B;
	Tue, 13 Oct 2026 17:08:27 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7942C10E54B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791911297; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LCDAZshFs9QieBawKJLTiEZ04vnvyc3jjuj6TIj2kXSSccaEYlrXyepR3YL+J+zlJuFymqXBVmduxyJQ7QozZ5W/B7kqMuoHv8f6yaRV4WowKk5qo1QidePDpQ3qCJ7X1lBQVp5bCVZ3mgW1ZkCAGmD7+WNZ8SN9Ww9EG2X4s5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791911297;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dl02gomnqfiM20wyvBMjwA2Z00g8ChZY513BoOmAVuU=; 
 b=P5JLmwvKEIo3HqWJromlvdPMhvOvHVW5qE1c5w29PPGb8t3q6JWzfpUzofKtz3fpmAXJ4GpM+5lo1dku9f798yQCBRNTNPWo1NAaK27sUwTA1IUChO0jSnwQMwKSMrwz0ZnZ0XKoqwAQdMo5LqlISKnExjZmS73xWVKMDmUe+hg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911297; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=dl02gomnqfiM20wyvBMjwA2Z00g8ChZY513BoOmAVuU=;
 b=KiapTGFzcW9BMa5iEWRzL4ywGVomeQ2dCpA4fUivCmVeDKn30aV5KJBW/25XNi1G
 mJuBdVZkKoyx5DaqbA33jQoE4TNhUwSbjItC81Hh5T3P6hka743Dqv1KA8koG7csbHi
 djZv5th67bTQuW6WcTDLW2ktFf4miBL/FM+xcJ2k=
Received: by smtp.zohomail.com with SMTPS id 1791911295666526.175192816721;
 Tue, 13 Oct 2026 10:08:15 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:40 -0300
Subject: [PATCH v6 1/7] rust: clk: use 'kernel vertical style' for imports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-clk-type-state-v6-1-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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

Convert all imports to use the new import style. This will make it easier
to land new changes in the future. Drop the `Result` import, which the
prelude already provides.

No change of functionality implied.

Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index f04f5c4a03d6..c73fe7c57251 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -96,11 +96,17 @@ mod common_clk {
     use super::Hertz;
     use crate::{
         device::Device,
-        error::{from_err_ptr, to_result, Result},
-        prelude::*,
+        error::{
+            from_err_ptr,
+            to_result, //
+        },
+        prelude::*, //
     };
 
-    use core::{ops::Deref, ptr};
+    use core::{
+        ops::Deref,
+        ptr, //
+    };
 
     /// A reference-counted clock.
     ///
@@ -119,9 +125,11 @@ mod common_clk {
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::clk::{Clk, Hertz};
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Hertz,
+    /// };
     /// use kernel::device::Device;
-    /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
     ///     let clk = Clk::get(dev, Some(c"apb_clk"))?;
@@ -293,9 +301,11 @@ fn drop(&mut self) {
     /// device. The code functions correctly whether or not the clock is available.
     ///
     /// ```
-    /// use kernel::clk::{OptionalClk, Hertz};
+    /// use kernel::clk::{
+    ///     Hertz,
+    ///     OptionalClk,
+    /// };
     /// use kernel::device::Device;
-    /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
     ///     let clk = OptionalClk::get(dev, Some(c"apb_clk"))?;

-- 
2.56.0

