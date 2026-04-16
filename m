Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CEEF8DFC9
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFAA710E938;
	Thu, 16 Apr 2026 21:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="W7sr93jU";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9295A10E936
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776375919; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ot8NdGwJNJJ/sepm5/GFtJp0OnRGPZcUEDARdcf39tTag+lw3pFE0nj7eSrdfJ4l7DtpyhxxMEEkTD+g7UjVVz4TB1S7Wq0cYVojEphcTFLZV6DX1lcD8EkS2rc+3yFA3gvOU14xOHhxT5COU/AG9tRLQUtaEZtJnZtOcKT34sk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776375919;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9lPuiNVrA0LM3ChHC/dFLUGUojgCyRrTYEEtP7kfHY4=; 
 b=TsjjzlYQVEMpXg13Woo0fcfMcU6hfsrcarp1KKSn/2wXuRxOrrD4nmSawd8zE6XfkYH/rpnfDEUipUWce7pfYX1rqbfS1fp4Z2Lt/o8fbaK2IGvP4Qcn0kOfLWcpKgA6eGYe+KZy0/FhcP5L54ZmKr//Fy8mvecTAsi5wW0yhEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776375919; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9lPuiNVrA0LM3ChHC/dFLUGUojgCyRrTYEEtP7kfHY4=;
 b=W7sr93jUCJmAS1wmg57Zu3DaJ1qy6WZhbPnY1rHv6dp8IWicDFkigAtRgIxfDbjX
 oTgde+C/Xl9J1UoD6b9PQqcVY2KVYh8xssYFXGMS85Ao9AZFw6PD5t0JyMknwv69fd8
 z9+MOiRvuCJDQHX3oYQ8DsyfcUvjlACMHJcZgWb8=
Received: by mx.zohomail.com with SMTPS id 1776375917204577.4266839588224;
 Thu, 16 Apr 2026 14:45:17 -0700 (PDT)
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
Subject: [PATCH v8 4/6] drm/panthor: Remove unused operation context field
Date: Thu, 16 Apr 2026 22:43:50 +0100
Message-ID: <20260416214453.112332-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416214453.112332-1-adrian.larumbe@collabora.com>
References: <20260416214453.112332-1-adrian.larumbe@collabora.com>
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
index 400e9652cd3b..54f7f7a8d44f 100644
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

