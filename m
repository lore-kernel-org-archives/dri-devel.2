Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73A2C98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8AB10E2C1;
	Sat, 26 Sep 2026 12:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FkMm3UP2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA7810E1FD
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 12:44:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91FE4602CC;
 Sat, 26 Sep 2026 12:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D02F1F00899;
 Sat, 26 Sep 2026 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790426655;
 bh=RXjOx3Yo0VabsQshmzOiJUEXnOwSJ51eecom/f/ueKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FkMm3UP2PR2kOT8MnReVQiyvoSfGKoIUFDml5vRRVYkqN/aNo4HMA87GUXXrHWpi+
 rnlT/RPF+4MvHP3fuDoiXiEokb6yUGEUGvHKOk1ujzhy05JOE6y4N4sseecj+tI5yy
 9Svc5TvBZlWdKyX9yEa+MO77xOfQpH+KnKrTDfOAEr8qULyKhnKgKzNCBy2e0nesyu
 GK0xn5iXaJF/yOn0T4Sksu/wbM9VIg333FXs3jt9CInvF8xjtCFJnEQGEYHiun5+Bf
 NbrSEcT6aWxFac/Fq9ezcjksmebvCuBPwavWqsJgEX0IDVo7fHs/axjVDfaF+aFBxQ
 AYQ1i62oZQQrw==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] gpu: nova-core: mm: fix lifetime name in BarUser
Date: Sat, 26 Sep 2026 14:43:27 +0200
Message-ID: <20260926124405.604707-5-dakr@kernel.org>
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

BarUser should not use 'gpu as a name for its lifetime; stick to a
generic 'a until we need pin-init selfref for this struct.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 855244f06983..dbf6445fa9ce 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -35,20 +35,20 @@
 ///
 /// Owns the [`Vmm`] for the BAR1 address space.
 #[pin_data]
-pub(crate) struct BarUser<'gpu> {
+pub(crate) struct BarUser<'a> {
     #[pin]
     vmm: Mutex<Vmm>,
-    bar1: Bar1<'gpu>,
+    bar1: Bar1<'a>,
 }
 
-impl<'gpu> BarUser<'gpu> {
+impl<'a> BarUser<'a> {
     /// Create a pin-initializer for [`BarUser`].
     pub(crate) fn new(
         pdb_addr: VramAddress,
         chipset: Chipset,
         va_size: u64,
-        bar1: Bar1<'gpu>,
-    ) -> impl PinInit<Self, Error> + 'gpu {
+        bar1: Bar1<'a>,
+    ) -> impl PinInit<Self, Error> + 'a {
         try_pin_init!(Self {
             vmm <- new_mutex!(
                 Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?,
-- 
2.55.0

