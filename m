Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E40CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF7210E3CA;
	Mon, 25 May 2026 20:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSgKPNc+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5940310E3CA
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:29:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1256641727;
 Mon, 25 May 2026 20:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E81F00A3A;
 Mon, 25 May 2026 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779740978;
 bh=f29QOiLOmTtepPqGTyUIO0rU++hJKbjbxryGjGLUDYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QSgKPNc+JoRjxcpaHyht4zv1jP+wZg3OUncC/d7JZRePkLU6NHmtZSEMDQb/QPWct
 GC9fW/BK9+kX9xOJtJ8M5dqXJYz9pte2/JD4eyCF16z9U3H13hkrsyqNN5dwmuG1f8
 TmSVS0dtRu1Hzt2fUn6Ibro2kAlCFH4xfrxqSTmnRwkHxL2qvzJmEl4oLgc3/CGBwA
 DxDk4mTWDwYVGItXOj8QDkK6pN+snuv1e9ECsoWqGa8SXd5mTfBXhBO3xMV+kcHwdD
 PLwi7aMRYda8UA46SspnWMp2Z9WMz2eLc+2BHNjOcsNmA4vj6p6j6qfaH1V44+RmQn
 VvuK2ddEc9WhQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR resource
 names
Date: Mon, 25 May 2026 22:20:48 +0200
Message-ID: <20260525202921.124698-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

pci_request_region() stores the name pointer directly in struct
resource; use &'static CStr to ensure the pointer remains valid even if
the Bar is leaked.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kernel.org/
Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate file")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci/io.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..3ce21482b079 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -153,7 +153,7 @@ pub struct Bar<const SIZE: usize = 0> {
 }
 
 impl<const SIZE: usize> Bar<SIZE> {
-    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+    pub(super) fn new(pdev: &Device, num: u32, name: &'static CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -252,7 +252,7 @@ impl Device<device::Bound> {
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
         Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
     }
@@ -261,7 +261,7 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
     pub fn iomap_region<'a>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
+        name: &'static CStr,
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
-- 
2.54.0

