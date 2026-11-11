Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED324606A888
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHEjUqtG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5087B10FC11;
	Wed, 11 Nov 2026 16:19:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4434110FC11
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDF31408DD;
 Wed, 11 Nov 2026 16:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B261F00A06;
 Wed, 11 Nov 2026 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794413983;
 bh=tUXnQ0VtngXNz0hq1xaN2LIYyta6JLHGqT1ySJb9N44=;
 h=From:To:Cc:Subject:Date;
 b=aHEjUqtGFvXysk/iQGnM6oZ1C8yniiiiH3ZD0wHilkCZL9tdXjWsdg6pL9rHp8Ek8
 nH/25lKwbbu/hlGR6d8h6k6IRgdUoDzFeNsaFOR5hZVdJkdwGDdkTajhVtgESn2sUT
 FTeTy0gQre6vV9aPOSyEI3THYv6/B0oDcxFYoyViELd0Y3ssW/A5CffLhD13UzMbMV
 OMI1UJofJWv+LbBGnhGUWifDOuVv/LddlbDmM0ngXAvKvjHHwbMSEejuurgPGOXkRQ
 YL1pyVuopnlmfBTAaeP5zDy0VwmRfqO3aFd5NGHejc+TxZbw7b7xsI+ZKlDgeRc1XZ
 BmtFCz9SAnPEQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] gpu: nova-core: minor NovaCoreApi cleanup
Date: Wed, 11 Nov 2026 17:19:02 +0100
Message-ID: <20261111161935.750047-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a constructor for NovaCoreApi and use it when registering the
auxiliary device, allowing the gpu and pdev fields to become private.

While at it, rename the lifetime from 'bound to 'api to reflect the API
handle's scope; 'bound should only be used by a driver's bus device
private data.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Changes in v2: new in this revision
---
 drivers/gpu/nova-core/api.rs    | 13 +++++++++----
 drivers/gpu/nova-core/driver.rs |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index eec69aace3b2..dc877ddebe8c 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -22,12 +22,17 @@
 };
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
-pub struct NovaCoreApi<'bound> {
-    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
-    pub(crate) pdev: &'bound pci::Device<Bound>,
+pub struct NovaCoreApi<'api> {
+    gpu: Pin<&'api Gpu<'api>>,
+    pdev: &'api pci::Device<Bound>,
 }
 
-impl NovaCoreApi<'_> {
+impl<'api> NovaCoreApi<'api> {
+    /// Creates an API handle.
+    pub(crate) fn new(pdev: &'api pci::Device<Bound>, gpu: Pin<&'api Gpu<'api>>) -> Self {
+        Self { gpu, pdev }
+    }
+
     /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
     /// by nova-core.
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..2376d960eb6b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -164,7 +164,7 @@ fn probe<'bound>(
                         // never recycles IDs.
                         AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
                         crate::MODULE_NAME,
-                        NovaCoreApi { gpu, pdev },
+                        NovaCoreApi::new(pdev, gpu),
                     )?
                 }
             },

base-commit: 6e557330b874b0e1fdd03e8fe4c438f36c93eefa
-- 
2.56.0

