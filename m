Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514BFCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B556910F123;
	Wed, 29 Apr 2026 18:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="OC8vdAUM";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B9310F11F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 18:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777487597; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=minTfq6218M4jrlKwkjxj6ZVjOkCAe1BRnA7kXmbVbDYNKooT2god5ewdgVMg+4+rvcLmBmjKf/BpXuMI8IqtPEghwPtEL355xjg2RGPTdcSgyUzsuxO+oh5421vPSnAWPcYxoJ6C6yCilazN8GH0ukjFKgcdVLxdjZcDMrpmZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777487597;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pPkjyQ7Aco3dEdYJdTItQJYvI7c1hnPfmf9scHUrQh8=; 
 b=jimnSGcqtKJJtJ3qzGJYjhSADaJXIhHY6TU/6we9iSOInYetMDb57j9dN1u2NWJ82kZYc7cUwv3DgbyfBZam8WhdDr2tAogO7x2mAMztP+LVeGMsUW5SmHtVYPV2+qsIfJi8dqXIvCUsBnqk/9soAvIygUq/aAM0o+GcUauFdhQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777487597; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pPkjyQ7Aco3dEdYJdTItQJYvI7c1hnPfmf9scHUrQh8=;
 b=OC8vdAUMjfltEZCsRrzyxK9XBytnIwG/y3D50liKlUN8L5Y6gjg2inkO73xip+Wv
 u8dOaKdPXwhNjYR1H3ORCzR8sxkKmW3Z8RgiRiFN2RyBb3WQvdyXFfrAibQrqTmCDnl
 jO06sihRwlOKEnGZWGIEUjnsA8M5s2H1hh5ZlqGk=
Received: by mx.zohomail.com with SMTPS id 1777487594979536.0346258571494;
 Wed, 29 Apr 2026 11:33:14 -0700 (PDT)
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
Subject: [PATCH v10 4/6] drm/panthor: Remove unused operation context field
Date: Wed, 29 Apr 2026 19:32:16 +0100
Message-ID: <20260429183253.66422-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429183253.66422-1-adrian.larumbe@collabora.com>
References: <20260429183253.66422-1-adrian.larumbe@collabora.com>
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

A Panthor BO's sgtable is now retrieved from its dmap field.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d35e65cab2b1..f54a60cd0ec4 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -195,14 +195,6 @@ struct panthor_vm_op_ctx {
 		/** @map.bo_offset: Offset in the buffer object. */
 		u64 bo_offset;
 
-		/**
-		 * @map.sgt: sg-table pointing to pages backing the GEM object.
-		 *
-		 * This is gathered at job creation time, such that we don't have
-		 * to allocate in ::run_job().
-		 */
-		struct sg_table *sgt;
-
 		/** @map.bo: the BO being mapped. */
 		struct panthor_gem_object *bo;
 	} map;
-- 
2.53.0

