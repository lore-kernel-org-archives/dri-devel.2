Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF19C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0596210E1FD;
	Sat, 26 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fw11takW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECD710E144
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:44:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7C4B41AEA;
 Sat, 26 Sep 2026 12:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECE41F00893;
 Sat, 26 Sep 2026 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790426650;
 bh=thI5rujReTOvMtZXByG4+6AbvxaRUUyqcbEduWbPu6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fw11takWc2Suz5wORLhFnq3+N/lB/njjH52bE5Hc7lBbzMsQvw8iKH1L9UhC6zyxA
 4ezcs3zuNsjAcedh68Sy0ilcPxDo7O75wWwF+AcgKpQyAaLjXgU1r/FMSPu2lizFv2
 LXmcaiK1rE7f6FeMBUW2S8omcRn/NgRePlEaDobiKBqDaNtMnVEubFMG7zoBvtU9HP
 aOL7W+ORofvfkmgAIIl2/9Fm6ESu3nIAUgV/cQ7UallxGBUKvglj2eB082imFjDwcT
 ZhqP/Doc8WTcEtByF61UhoA0a88x9EfXgDnuOXl86zeGJO8WJxK6PGIHv3iBnqOB5K
 W/bflXnTkzcnA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] gpu: nova-core: align Bar1 alias with Bar0
Date: Sat, 26 Sep 2026 14:43:24 +0200
Message-ID: <20260926124405.604707-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926124405.604707-1-dakr@kernel.org>
References: <20260926124405.604707-1-dakr@kernel.org>
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

Make Bar1 an alias for a borrowed pci::Bar in order to match the Bar0
type alias.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs      | 4 ++--
 drivers/gpu/nova-core/gpu.rs         | 2 +-
 drivers/gpu/nova-core/mm/bar_user.rs | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 0672a0707a71..9ce70703b2ce 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -32,7 +32,7 @@ pub(crate) struct NovaCore<'bound> {
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    bar1: Bar1<'bound>,
+    bar1: pci::Bar<'bound>,
     #[allow(clippy::type_complexity)]
     _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
@@ -43,7 +43,7 @@ pub(crate) struct NovaCore<'bound> {
 
 pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
 pub(crate) type NovaRegisters = kernel::io::Region<BAR0_SIZE>;
-pub(crate) type Bar1<'a> = pci::Bar<'a>;
+pub(crate) type Bar1<'a> = &'a pci::Bar<'a>;
 
 /// Returns the Linux PCI resource index that holds BAR1 for an NVIDIA GPU.
 ///
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8f30186f10ba..1ae287c9e776 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -353,7 +353,7 @@ impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
-        bar1: &'gpu Bar1<'gpu>,
+        bar1: Bar1<'gpu>,
     ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
         let dev = pdev.as_ref();
 
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 8f4a27c1fd14..86b5d302188e 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -41,7 +41,7 @@
 pub(crate) struct BarUser<'gpu> {
     #[pin]
     vmm: Mutex<Vmm>,
-    bar1: &'gpu Bar1<'gpu>,
+    bar1: Bar1<'gpu>,
 }
 
 impl<'gpu> BarUser<'gpu> {
@@ -50,7 +50,7 @@ pub(crate) fn new(
         pdb_addr: VramAddress,
         chipset: Chipset,
         va_size: u64,
-        bar1: &'gpu Bar1<'gpu>,
+        bar1: Bar1<'gpu>,
     ) -> Result<impl PinInit<Self> + 'gpu> {
         let vmm = Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?;
         Ok(pin_init!(Self {
-- 
2.55.0

