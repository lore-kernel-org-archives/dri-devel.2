Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A034CD37AC
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AEA810F29D;
	Thu,  7 May 2026 21:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QU6sbjjY";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D1210F289
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778190604; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aOKDn5aCdfjabMj5SaqiJk2zQ9YnN2jahS3YrykoXbrFLAF6A+nhKzbyJrsufRNEMrFzDjhZ0qeVSu5bijlrbLedUD1dfuoEVKnFfo2cX78BboLw64UFtqMNEW3OelBNUwxv7xKJcXuQqV9f06s9OjMKGmaXDf4UZ+xCbJjUPHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778190604;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pPkjyQ7Aco3dEdYJdTItQJYvI7c1hnPfmf9scHUrQh8=; 
 b=K8fPVyEXAK4AmSePAng4xk6hUEIoUI39IW4IgXWTPSiuH4sdmL35uEKWk4UoHvolyTZ99gddaEwZlT15yRAHXasOIBXbCTgEC1BdP7Q87kZzMUOdYxiTFqY0kutCJVN7wZsIkhN1/xo6pKmxVemnXp/ung8hUS3IHlwNqBP2PoI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778190603; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pPkjyQ7Aco3dEdYJdTItQJYvI7c1hnPfmf9scHUrQh8=;
 b=QU6sbjjY4uVnhdtQhRVon8WJkqhmWUxKD8qGb/lxmIJtdb5uv3Owts7R2ve1vQpr
 GawSK1Qko40YEufiA0q3ROqRbHPJr4nb7vTjNCX7bRzH6jkxWuR9leg0wfOgpAx74RM
 6ucDwUPokPdy/Qy4UAY8Znp0kVGR64wf/DVVdvKo=
Received: by mx.zohomail.com with SMTPS id 1778190603106499.29029932971673;
 Thu, 7 May 2026 14:50:03 -0700 (PDT)
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
Subject: [PATCH v11 4/6] drm/panthor: Remove unused operation context field
Date: Thu,  7 May 2026 22:49:05 +0100
Message-ID: <20260507214939.2852489-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
References: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
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

