Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4844C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 22:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338EA10EEC7;
	Wed, 22 Jul 2026 22:56:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZPkBpSIy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EBB10EEAE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 22:56:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B38C2600AB;
 Wed, 22 Jul 2026 22:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5E81F000E9;
 Wed, 22 Jul 2026 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784760970;
 bh=nnwsPKVbi4DvaYV8nWWsvMkgYyamzu5KTWQUU7aAxNA=;
 h=Date:From:To:Cc:Subject;
 b=ZPkBpSIygpo7zwkLCFfrCkN630Q73t3unwq8Ryg3gZLQahZp2q8QHd3pusDqaWtUw
 c1Ere6dRXFMjYAvUd4fBwfDY9764WDASWOTPEnRvIKayNXrfrzyhJV+PRdNg0XLRJa
 yznM14j+ZswrRsLK/JeWZQR4glE9mIkh29df2kUcdv5H9qJAxRNPdyCpeiTFpXKY6k
 cbnzAi712V0pfeO1mVq6hGA5CfBDZcH3REZ5TLkNiN/r1Jg6mnA7p8C+MsItzOuefT
 ooMHeyX2qXK0WnmukgtbNlsbfnsKdJOmKKE5JBmOhXJGDafvFgQoVHEtRxKuOIwDJe
 PivPabZFBIrvw==
Date: Wed, 22 Jul 2026 15:56:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usama.arif@linux.dev>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 linux-next@vger.kernel.org
Subject: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
Message-ID: <20260722225605.GA1910198@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi Mark and drm and mm folks,

There is a semantic conflict between commit 04b177544a04 ("drm/pagemap:
Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION") in the
drm-misc-fixes tree and commit 0b6b1bb28482 ("mm: rename
ARCH_ENABLE_THP_MIGRATION to ARCH_HAS_PMD_SOFTLEAVES"), resulting in a
lone instance of CONFIG_ARCH_ENABLE_THP_MIGRATION with no way to define
it.

  $ git grep ARCH_ENABLE_THP_MIGRATION
  Next/merge.log:Merging drm-misc-fixes/for-linux-next-fixes (04b177544a040 drm/pagemap: Guard HPAGE_PMD_ORDER use with CONFIG_ARCH_ENABLE_THP_MIGRATION)
  drivers/gpu/drm/drm_pagemap.c:#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)

This results in an objtool warning (or error with CONFIG_OBJTOOL_WERROR)
when building with clang because NR_PAGES(order) results in 1U << -1,
which causes clang to stop generating code for
drm_pagemap_migrate_to_devmem() when encountering unconditional
undefined behavior.

  drivers/gpu/drm/drm_gpusvm_helper.o: error: objtool: drm_pagemap_migrate_to_devmem() falls through to next function drm_pagemap_zdd_alloc()

Mark, could please apply the following diff to the -mm merge to avoid
this? Obviously, there will need to be further coordination for
resolving this upstream when the time comes but it is only an issue in
-next currently.

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 4a794544b7dc..f00c27edbfb9 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -12,7 +12,7 @@
 #include <drm/drm_pagemap_util.h>
 #include <drm/drm_print.h>
 
-#if IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION)
+#if IS_ENABLED(CONFIG_ARCH_HAS_PMD_SOFTLEAVES)
 #define DRM_PAGEMAP_PMD_ORDER	HPAGE_PMD_ORDER
 #else
 #define DRM_PAGEMAP_PMD_ORDER	(-1)
-- 
Cheers,
Nathan
