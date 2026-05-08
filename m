Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD0CCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB67910E359;
	Fri,  8 May 2026 13:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="X5FI9wu9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B95F10E32F
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778248708; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IPkVqwZkd1ryaSUt/z+juUjuCHm5Wb37ApVCkxi656tPIIANmW3d5xBRShRddoL/44sUQHaxYE7eR0RVKe/tk+ZPppbMuPp8/dkJ1eYIbouc61/5AEMXIcB3kYNrwKe0n7tulkz74+Y0U3P+RmTDXpWb+/3CBcZHIHv/V/RTOc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778248708;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SJGDvSb9dZoNLLiqkreOHP1A/3ruC524HYHDnJCIz7M=; 
 b=nE3N9VlOxftLrsGeXTcptK8zmmFa0N6DMAMDONdD2QxXnwcopy66xE5T135UlY89daYdvl51nmI8Oj3+ppF3/1S8Q22+yquMlz/5Eh0JzzMSQNRRS65r9TmCQIA4HEJRKTDAQEWaeKGIF3A72ZBvYVTZMWoBw94m2PdmiZs4K6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778248708; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SJGDvSb9dZoNLLiqkreOHP1A/3ruC524HYHDnJCIz7M=;
 b=X5FI9wu9upIc2OxDzi5BHvwiEgyoE0jfNGfTpIvzcwCIN0nmYhardonAaHNbUTq/
 Xj3mAKAC2ZmoaexQrO9c9nkLNwVmBet98WodXM2Ic372ESoUUmSUcjN6mSTAxjz8Bdr
 yvbmv2/G3jt/9mqTW/7FCDPCPQer20pHu9huDvec=
Received: by mx.zohomail.com with SMTPS id 1778248706093393.9854452727409;
 Fri, 8 May 2026 06:58:26 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/gpuvm: Remove dead code
Date: Fri,  8 May 2026 14:58:07 +0100
Message-ID: <20260508135814.3296874-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drm_gpuva_find_next() has no consumers.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 22 ----------------------
 include/drm/drm_gpuvm.h     |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index f56719e9f435..f4eb23e2e8d3 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2248,28 +2248,6 @@ drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start)
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_find_prev);
 
-/**
- * drm_gpuva_find_next() - find the &drm_gpuva after the given address
- * @gpuvm: the &drm_gpuvm to search in
- * @end: the given GPU VA's end address
- *
- * Find the adjacent &drm_gpuva after the GPU VA with given &end address.
- *
- * Note that if there is any free space between the GPU VA mappings no mapping
- * is returned.
- *
- * Returns: a pointer to the found &drm_gpuva or NULL if none was found
- */
-struct drm_gpuva *
-drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end)
-{
-	if (!drm_gpuvm_range_valid(gpuvm, end, 1))
-		return NULL;
-
-	return drm_gpuva_it_iter_first(&gpuvm->rb.tree, end, end + 1);
-}
-EXPORT_SYMBOL_GPL(drm_gpuva_find_next);
-
 /**
  * drm_gpuvm_interval_empty() - indicate whether a given interval of the VA space
  * is empty
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 655bd9104ffb..625958fce7fd 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -160,7 +160,6 @@ struct drm_gpuva *drm_gpuva_find(struct drm_gpuvm *gpuvm,
 struct drm_gpuva *drm_gpuva_find_first(struct drm_gpuvm *gpuvm,
 				       u64 addr, u64 range);
 struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start);
-struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);
 
 /**
  * drm_gpuva_invalidate() - sets whether the backing GEM of this &drm_gpuva is

base-commit: c2738d88b624a977e42a1734fad4b15993ac354a
-- 
2.53.0

