Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426B1F531D9
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D34A10E545;
	Mon, 13 Apr 2026 22:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="OAcoUvCG";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AEC010E124
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119515; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XQow1hV0/sZOPxgHYm3eB+bdMJr0gGse0FhmhRi0aAxuL0+jn5cFH/ueVq4dbCbDR+CRWerRMkcBp+36yCbkWa+87KC2ZTlyTVdFunQNS2WC9bk/1Uo8Qs1HN2ulJ7QoZ9twiZPA51tFHXeoa4iqkqCLFttxYtLk+c+dBAC+bIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119515;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VXDFGS98Tc4lDYbE888SjtHArlQzwAEr30/idT3TFd4=; 
 b=ky6t3lAPVldAvzf/PVd5/K6SoveoK7/xPhmFrgAI2b4T5fl27JBkGrPZQihgX4cwTGw+Vd0Z7CZ216ORS/jtMMm/K2e+pqpCybPzuDWCaMrAupCoI0LvPbKTQMbxnpmww84BOQRauXAAo5dh+vCi8sJG1Hjf0SxphzLvqRpu5v0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119515; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=VXDFGS98Tc4lDYbE888SjtHArlQzwAEr30/idT3TFd4=;
 b=OAcoUvCGww4T66Ae+ZlIG+dndoxHrWO1V7luhYGyUy/4UowWvQ3/M9CZrqB640at
 qA6gwIaATab1saIYb8ryeU6BNKIGu1B+vJLRBjplj7SxGXDw1mCuHTMzStYLyohHbcb
 RsMl7U9OxX98moV4cAtsxvX32FCJYzLnAcUybZ3E=
Received: by mx.zohomail.com with SMTPS id 177611951377042.46367496896971;
 Mon, 13 Apr 2026 15:31:53 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:37 -0700
Subject: [PATCH v3 02/13] drm/tyr: select required dependencies in Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-2-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=kedRnGAjTEAxNymKdPnucngrkvI5gPskFo8gwuQEDjk=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3867Wc/v22SuuMv55anNrbWLlbZn4Mw83PNUUcerIv
 LUro+ZlRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABOZtpmRYZVNqELI/7iM/1ma
 HdKfL3AvqE+cs6+J/3ho+J823ac7shn+Z7b9UVo3w2hzx17+suYuaaed7NpHtsnkLnNYo3lnxe+
 5zAA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Tyr depends on DRM_GPUVM, RUST_DRM_GEM_SHMEM_HELPER, MMU, IOMMU_SUPPORT,
and IOMMU_IO_PGTABLE_LPAE. Select or depend on these symbols in Kconfig so
the required infrastructure is enabled when Tyr is built.

Introduce DRM_TYR_STATIC_DEPS to keep the built-in DRM dependencies
selected even when Tyr is built as a module.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
index e933e6478027..443ce988b570 100644
--- a/drivers/gpu/drm/tyr/Kconfig
+++ b/drivers/gpu/drm/tyr/Kconfig
@@ -1,5 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0 or MIT
 
+config DRM_TYR_STATIC_DEPS
+	bool
+	select DRM_GPUVM
+	help
+	  Ensure required DRM infrastructure is built-in when enabling Tyr
+	  even if Tyr is =m
+
 config DRM_TYR
 	tristate "Tyr (Rust DRM support for ARM Mali CSF-based GPUs)"
 	depends on DRM=y
@@ -7,6 +14,11 @@ config DRM_TYR
 	depends on ARM || ARM64 || COMPILE_TEST
 	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
 	depends on COMMON_CLK
+	depends on MMU
+	select DRM_TYR_STATIC_DEPS
+	select IOMMU_IO_PGTABLE_LPAE
+	select RUST_DRM_GEM_SHMEM_HELPER
+	depends on IOMMU_SUPPORT
 	default n
 	help
 	  Rust DRM driver for ARM Mali CSF-based GPUs.
@@ -16,5 +28,5 @@ config DRM_TYR
 	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
 	  be supported with the panfrost driver as they are not CSF GPUs.
 
-	  if M is selected, the module will be called tyr. This driver is work
+	  If M is selected, the module will be called tyr. This driver is work
 	  in progress and may not be functional.

-- 
2.53.0

