Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A1ACC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CCA10E87B;
	Tue, 13 Oct 2026 17:09:11 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11BF10E917
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791911342; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nUb2gW+xFqgpMAwl8+TMG1uhCxTOLhe7buueIvF8WWdpyW+lc5w/juslXnMLbNTuedbIojlqQ6j3VvzCHzHzjzYgqSjKGmCU8E+yxF+lV5JimBX9ppYAGovfnEnPO7gz+3wlbgnuhrHVXGsHlUH+NqymriEZ110PvnIp3Uy/4v0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791911342;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Lyc1dDQ9Iy8yCVUiIeNJJ20m7/W1KAudCcRvkhlLRBI=; 
 b=WMNsm6VdMcUUidCdo8cipj9A/fKkIOd8lIMS2GJsPFz3L6GVyGJ9MdnbyOpapQ+d1IC3efyu3XAXkikQS7hwbBphez1l0mGHc3x++R49lidYz6L98hjcNWhC8Tc8n3j5mqkWRYcqi3O3m+p9brL1lxC7jHWqUcj5CdOz+9wmqsE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911342; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Lyc1dDQ9Iy8yCVUiIeNJJ20m7/W1KAudCcRvkhlLRBI=;
 b=GHgDEjJfBJgpG41vjA8swMigsWRcM/jDsU/mVMstGmV/kylWu4HaH9kt75oHOpQO
 xGHUq8dJYxTaWcpTOCRz3Mgx3DHRwAPx0HW5teZWPU3F3WXjvwxDnOautFY65TuB6KH
 osg6ak5FCo4mKXipv/WnHOu6xovMdVhtVPwOpTOA=
Received: by smtp.zohomail.com with SMTPS id 1791911341251740.8870883036564;
 Tue, 13 Oct 2026 10:09:01 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:46 -0300
Subject: [PATCH v6 7/7] pwm: th1520: Lock clock rate with
 clk_rate_exclusive_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-7-a5e9977b3509@collabora.com>
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

From: Maurice Hieronymus <mhi@mailbox.org>

The driver derives period and duty cycle from the clock rate read at
probe, so a later rate change would silently miscompute waveforms.
Switch to the new ExclusiveClk wrapper to hold the rate for the lifetime
of the driver data and drop the corresponding TODO.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
[ Adapted to ExclusiveClk<Enabled> and ExclusiveClk::new(), and rebased
  onto the vertical imports and DevresIoMem conversion. - Daniel ]
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/pwm/pwm_th1520.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 5180b912efad..9be0a7f210b9 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -23,7 +23,8 @@
 use kernel::{
     clk::{
         Clk,
-        Enabled, //
+        Enabled,
+        ExclusiveClk, //
     },
     device::{
         Bound,
@@ -94,7 +95,7 @@ struct Th1520WfHw {
 struct Th1520PwmDriverData {
     #[pin]
     iomem: DevresIoMem<TH1520_PWM_REG_SIZE>,
-    clk: Clk<Enabled>,
+    clk: ExclusiveClk<Enabled>,
 }
 
 impl pwm::PwmOps for Th1520PwmDriverData {
@@ -318,10 +319,8 @@ fn probe<'bound>(
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
         let clk = Clk::<Enabled>::get(dev, None)?;
+        let clk = ExclusiveClk::new(clk)?;
 
-        // TODO: Get exclusive ownership of the clock to prevent rate changes.
-        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
-        // This should be updated once it is implemented.
         let rate_hz = clk.rate().as_hz();
         if rate_hz == 0 {
             dev_err!(dev, "Clock rate is zero\n");

-- 
2.56.0

