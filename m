Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E1DF41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F255910E6C5;
	Wed, 15 Apr 2026 11:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="M5xO6rAp";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3DB310E6C5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776252567; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=i8IsgFTZDanFFhW/7m9/5gfnBeKkd7YoStks7UuKf8SBbGFGZt9dxsHtgfT6p4m9Uj+IA6mdyEyozYSuHE85tEcw2Wv39g+WagepaHGwhHhORvVbROfTQZNJS9Lv3ylOuYid1RD6TK0LwgWe5QjV2TESxeWJaaNEEhHYI9mqp44=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776252567;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Wk3BeTWMJ+SCnbI5In7nJ6Bhq1v75t4HmjtHopthE0M=; 
 b=GHuBWkuOYgEKV8oZ5kLnLEjKJ97S3XqGpr+m+2ba9+a1ekDCG6C5/F9xEBIBqsnXc+xzPw0wLVgGptFjlpNFzVwRM/D3zvC5F4WG7vExJ8B5QxpjaRjl73NQRKcb9AnMtIz7IL+ePgNK6M7iYcHu/BZz7TxiVzhss83uzU+KmdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776252567; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Wk3BeTWMJ+SCnbI5In7nJ6Bhq1v75t4HmjtHopthE0M=;
 b=M5xO6rApaf0X8e7YhXfCW+lv1b/l37vp+FUGUXHr6PSAkfMPmdEkizhK5KJQ/mT4
 qQY7UXAFxeuecD9H/dR2xO0dxiARybneuUFPFZCQJ6LRalepjvVtVhoWhFik+qwWPJk
 IzYXDwhiFg/MByNjtr1M4Fjst1nDMJshqlWUGefU=
Received: by mx.zohomail.com with SMTPS id 1776252564739815.794466188156;
 Wed, 15 Apr 2026 04:29:24 -0700 (PDT)
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
Subject: [PATCH v7 4/6] drm/panthor: Remove unused operation context field
Date: Wed, 15 Apr 2026 12:28:48 +0100
Message-ID: <20260415112900.681834-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112900.681834-1-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d9e2f8afb8fb..cea78e5f0591 100644
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

