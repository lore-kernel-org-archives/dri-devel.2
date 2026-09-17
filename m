Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C771C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFB510EE94;
	Thu, 17 Sep 2026 12:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="m+mXPUJ0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47CD10EE89
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789648434;
 bh=wCAbH6+evR/IyGG1vLF13wRmGIFvXzlzEuaaOwiKKf4=;
 h=From:Subject:Date:To:Cc:From;
 b=m+mXPUJ0Lb906Ck2Ci5NN+8ZLSfbIuJRRr8Bq2ctnw/L46iHraKOBk6m1MIcVH4ju
 gSDOtbVnpBEee2RPAA+yKQ+jlUfNCw8NfEWfHH4LTzlPIlkHBxoGc+p9NSZSD+0rey
 DFvKEpJ+44zeTi2ad78X0NnSf5OtvJVCcLk365M7keZUEhL0BAryodQkQ0yDvi84QJ
 bJFH5BPRcDwO3F9TSk6jykYTdlJdqAqdCYVfkmY27+22s1Fio3nz2GBeX80jYKRlcc
 dk05/+vl5r0chbnCvmNLcr5dUdWbHfNZM2M6xjg+4IQEkwYKSJqvpFNwXrX2SuAwSD
 cWIdh3OqgBa4w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E2F717E09B5;
 Thu, 17 Sep 2026 14:33:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 0/4] drm/panthor: Fix partial unmaps, again
Date: Thu, 17 Sep 2026 14:33:42 +0200
Message-Id: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QqDMAxFf0XyvEDbqUx/ZfgQtqgBV0taRRD/f
 cG3c+Dce0JmFc7QVyco75JljSb+UcFnpjgxytccggut63yLiWKZV8VRDmMtQgtu8UcJqQnuWY/
 B+1cNtk/KFt3f7+G6/jFL53lrAAAA
X-Change-ID: 20260916-panthor-fix-partial-unmap-a52034f21184
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789648434; l=1028;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=wCAbH6+evR/IyGG1vLF13wRmGIFvXzlzEuaaOwiKKf4=;
 b=CNgI8SVGSjZd40UrnVuhyhOhrZI8KjUCYB7YZ+CqDvDfODP4EEExVY0P8OiNnN6pnqIGruxba
 XRGX10CowgcD8MuqRO2InukJlHfDg5DYnL11vdVadGYfSr/quKVYLS2
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

The first patch is just a theoretical perf improvement to avoid
unnecessary unmap+map caused by false positive returned by
iova_mapped_as_huge_page(). The second patch is a fix for a real
bug when iova_mapped_as_huge_page() is called on an imported BO.
The last 2 patches are just consolidating the logic to make things
clearer.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Boris Brezillon (4):
      drm/panthor: Avoid false positives in iova_mapped_as_huge_page()
      drm/panthor: Fix iova_mapped_as_huge_page() for imported BOs
      drm/panthor: Consolidate the is-huge-page-mapping test
      drm/panthor: Actually check huge-page mapping on sparse regions

 drivers/gpu/drm/panthor/panthor_mmu.c | 100 ++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 29 deletions(-)
---
base-commit: 5535d5e61a77ad79118ea7665ce1c14f857f0f12
change-id: 20260916-panthor-fix-partial-unmap-a52034f21184

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

