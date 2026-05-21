Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAD8CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 01:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 299C110F19F;
	Thu, 21 May 2026 01:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="i49xUYTh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12B210F1A3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779327877; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TTPQh4nVBKQh9+ZMONRjYTMcoOy31y5nxGsV3q1glngGYZaBZe+PuCaSI9J5oGNNYC+PekbNSZsyAUJ9TWABI9p6ZVr0v+30M4zzL60FNFzk4TCL+Crp6fATG9NlMZY4/Zct2poACoYUowAAtmjL6qQ1Npf/oAiE5tv3WMLd3jw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779327877;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nWqrbHP+2Nsd9KkgwB6fZ0/LTOiEdw/wgbwod8voBuY=; 
 b=awb9z1Mn6I/1DwjOqA9QQ8gEqmjKatPyGOZPNABT91kJb6WPZTzNTvU6ONbz+NJrO4CerAnX2/0VxCY2cVkWs9DkeLxztqbXYoL5NXXjxiY98Ogtl5DPF64hf42RBhL3f9byNJydZM0VbI+guoMrfpLvPj3B4UCPqK2Qsy6w3lw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779327877; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nWqrbHP+2Nsd9KkgwB6fZ0/LTOiEdw/wgbwod8voBuY=;
 b=i49xUYThntR6XNzDMjmNveN6T4Z4IFY+O8aFYgpPhniM5aJPDlFpJBG94tr2sdMY
 IuF7mcFJ9FWMFV3WVWGXQGxbTPqOsqVJYaf8l1h+FlPoXoAZETLGhR/CX3onG/VyU2U
 6271ysb8K/pbZv+pM5byky/7Y8iwW8zmfk5tK1lw=
Received: by mx.zohomail.com with SMTPS id 1779327876709312.29893362813334;
 Wed, 20 May 2026 18:44:36 -0700 (PDT)
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
Subject: [PATCH v12 4/6] drm/panthor: Remove unused operation context field
Date: Thu, 21 May 2026 02:43:11 +0100
Message-ID: <20260521014359.2011484-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
References: <20260521014359.2011484-1-adrian.larumbe@collabora.com>
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
index f1afe4a3e296..ca78267d43e9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -199,14 +199,6 @@ struct panthor_vm_op_ctx {
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

