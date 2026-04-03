Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B312E85385
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D700A10E13D;
	Fri,  3 Apr 2026 17:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="MuzZ0ng1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40B110E13D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 17:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775236952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ux1MSI7RO7z6+MayDfZvQZ1+dODRAiXFP7GDbx/bSEV2HfZy/jy5BR9JRxeIsNhM0JcX3PObC21cVLRkSEPltuIck2R8j3iBeLW5/vbBTQFr5xSRpIYFjtGvwrlsD0ccPkMStYsAdM2238i0njp60BkJmRpG1GX9mRpdmOeh4es=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775236952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vRUsC1H5z3NiCu+ghOqmz9h78BmqCxGb07TwGXEbdFE=; 
 b=gyQ2JctFRcIWRj1QyzveOcBJRI8SKfetUTxTMo6lepc4mjGaN1wsw3ZtFnX5kpfX0NM3Uz3FqviY+OrBrtd5WyC9mDuJWkZ5KWslTWd7uSwWvOK/S1EY4klzbyMRGyUh50DmgSIK1UlgIA9IkWHlURvcj9G9RubxWQ0XS9LEffM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775236952; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vRUsC1H5z3NiCu+ghOqmz9h78BmqCxGb07TwGXEbdFE=;
 b=MuzZ0ng1wGK7/fIYKq0r3p3v4gs8t8ZA58wB1Pozz/adTZg36fuz7gQa2wM0o3bY
 aiyLM6zrWVMSs5hw9paBEIGastd1bh417Qap5kpTt5kQwOBMLVdfWKknWg+ScHD3h/L
 AP7LGtIkxjp0mOkmUKmzkLbDVKT/glPLKduyqXLA=
Received: by mx.zohomail.com with SMTPS id 1775236950108268.1638942039027;
 Fri, 3 Apr 2026 10:22:30 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/2] drm/panthor: Extend VM locked region for remap case to be
 a superset
Date: Fri,  3 Apr 2026 18:21:11 +0100
Message-ID: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
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

In the event of an sm_step_remap() that leads to a partial unmap of a
transparent huge page, the new locked region required by an extended unmap
might not be a superset of the original one. Then, if it leaves a portion
of the initially requested one out, the ensuing map will trigger a warning.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fa8b31df85c9..2b96359d3b94 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1709,6 +1709,19 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	    start + size <= vm->locked_region.start + vm->locked_region.size)
 		return 0;
 
+	/* sm_step_remap() may need a locked region that isn't a strict superset
+	 * of the original one because of having to extend unmap boundaries beyond
+	 * it to deal with partial unmaps of transparent huge pages. What we want
+	 * in those cases is to lock the union of both regions.
+	 */
+	if (vm->locked_region.size) {
+		u64 end = start + size;
+
+		start = min(start, vm->locked_region.start);
+		size = max(vm->locked_region.start +
+			   vm->locked_region.size, end) - start;
+	}
+
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */

base-commit: fb42964e2a76f68a5fb581d382b5d2be2d5bda9b
-- 
2.53.0

