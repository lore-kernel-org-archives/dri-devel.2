Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E79CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8149810EBC6;
	Thu, 18 Jun 2026 03:48:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Pt0xR7Z9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494AB10EBCB
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781754491; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e8XJdbebNb5ZqyLSgzsuJ5kUpz5BTTGNsTCyMxEIrLmYyyZPeK12AeUBDRtQo5egC8O+YB+UA3XgjM1t8WaXeIE1jrTFJf97ulB3D9FlWtEhVKlMyxT/lIe4o5DGlQaUCrflyZ/+92yUh9FoqqmRW9O747SMK+uk1BC/fjtR3+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781754491;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B+7IWRo1JL0H3u9ZN7rfcBGr3kSsxqV+wwvQWMVfHts=; 
 b=X6qnfqbMQZZl+Lzf/oejQHA+ukw8KbphpXUUaerYwOBkgc1KC38bRwFo4Zz1/NJ8aunDPWiiEm21Q3NjWi3XeILb+6ggVk2rVqgpZnWxvrRuINMs6gTiR19dAJyv1diprTNxfaOg9GnljKHXZ/nfGRt/jOeNMUKDWsMPj4oPufA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781754491; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=B+7IWRo1JL0H3u9ZN7rfcBGr3kSsxqV+wwvQWMVfHts=;
 b=Pt0xR7Z9nRyDeIqOYI3KNR+9uauRv/jfznC6PmnoaX1VPH7XnLMQczfTn7xAnyMr
 BIx4JUFTj9cAUu7Gn73TNejalfhPT3b6Q0gMqFGGD7GT2qJBeoZVFiogoYZR7YjYZzg
 Pobi5Hbuw+tSgae/hiE0/TdOxl8Jd9V7sdwfchXs=
Received: by mx.zohomail.com with SMTPS id 1781754488942419.2252700043547;
 Wed, 17 Jun 2026 20:48:08 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 18 Jun 2026 00:46:36 -0300
Subject: [PATCH v4 2/3] rust: clk: add devres-managed clks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-clk-type-state-v4-2-8be082786080@collabora.com>
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
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

The clk API allows fine-grained control, but some drivers might be
more interested in a "set and forget" API.

Expand the current API to support this. The clock will automatically be
disabled, unprepared and freed when the device is unbound from the bus
without further intervention by the driver.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index a62e4c7e252e..692ee88ca772 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -95,6 +95,49 @@ impl Sealed for super::Prepared {}
         impl Sealed for super::Enabled {}
     }
 
+    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound device.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    pub fn devm_enable(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call [`devm_clk_get_enabled`] with a valid
+        // device pointer.
+        from_err_ptr(unsafe { bindings::devm_clk_get_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Obtains and enables a [`devres`]-managed [`Clk`] for a bound device.
+    ///
+    /// This does not print any error messages if the clock is not found.
+    ///
+    /// [`devres`]: crate::devres::Devres
+    pub fn devm_enable_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call [`devm_clk_get_optional_enabled`] with a
+        // valid device pointer.
+        from_err_ptr(unsafe { bindings::devm_clk_get_optional_enabled(dev.as_raw(), name) })?;
+        Ok(())
+    }
+
+    /// Same as [`devm_enable_optional`], but also sets the rate.
+    pub fn devm_enable_optional_with_rate(
+        dev: &Device<Bound>,
+        name: Option<&CStr>,
+        rate: Hertz,
+    ) -> Result {
+        let name = name.map_or(ptr::null(), |n| n.as_char_ptr());
+
+        // SAFETY: It is safe to call
+        // [`devm_clk_get_optional_enabled_with_rate`] with a valid device
+        // pointer.
+        from_err_ptr(unsafe {
+            bindings::devm_clk_get_optional_enabled_with_rate(dev.as_raw(), name, rate.as_hz())
+        })?;
+        Ok(())
+    }
+
     /// A trait representing the different states that a [`Clk`] can be in.
     pub trait ClkState: private::Sealed {
         /// Whether the clock should be disabled when dropped.

-- 
2.54.0

