Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5765BCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B30C10EC21;
	Wed, 20 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Px8owTUf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C14310E8C7
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779282342; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AwaEp24+s2sftsmDatkzZJ0XlJTFBidl+uCSKFJvGfW4Ts0It/VCgH8XpTI+U/jgYqNqNxCgqKtUn1s8AwINirUzyklFN2hCNqqnCRJV+hDCLwSlk408nJu0svOpy50TSDhrFvYUzOZnSuvXG0HI3DjLCZuGI8RG7scdAfn+4Hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779282342;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vHYtuJkTlxfXJH+yWdY0F9pjJfmE67NG5NiI6sZ1UjQ=; 
 b=Zj+vSz+iMiSxw1CvPWoXuhNaFOun8eVub7qRDlE45eqej5ls373U9hntXDzRIDyLZA54gm2jAO0RwD2HupooWNRryfV3FqG4DKZW/ZqWWeoxZVrevjl6h/4bQSFirf0T4QgXT7rkbCslll2WgDxFvNjskApfJLn/6An2H+L3GO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779282342; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=vHYtuJkTlxfXJH+yWdY0F9pjJfmE67NG5NiI6sZ1UjQ=;
 b=Px8owTUf45qVTT8GQ4htdnJjAWopss4+ATsPahtUmwuHqIF8dLGuhzMISrju7YtV
 SkS78ZQ9b6y5VCSryTOHP9TtbZaevl2xJ664raJMFvt7qzBrFc4UW3b5+mFkffNvErj
 bu/hJxO2hFiSnxTgkKp5oNRQm6pfBcTH03sJDtfw=
Received: by mx.zohomail.com with SMTPS id 1779282340165991.2067256608152;
 Wed, 20 May 2026 06:05:40 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 20 May 2026 15:04:50 +0200
Subject: [PATCH v4 3/3] drm/panthor: Reduce padding in gems debugfs for
 refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-panthor-bo-reclaim-observability-v4-3-a47ab61cb80d@collabora.com>
References: <20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com>
In-Reply-To: <20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-doc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

The "gems" debugfs file is getting a little too wide for comfort. While
a lot of this is unavoidable due to the theoretical upper limits of
numbers here (e.g. size needs to be 16 chars because 2**48-1 in decimal
is 15 digits, plus one space for separation), the refcount column has a
decent 5 characters to be saved, as it can only ever contain a 10-digit
decimal number.

Reduce the refcount column's width to 11, which fulfils this requirement
with an additional space for separation.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 068aa935c8fc..dfdcda3d0189 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1644,7 +1644,7 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 
 	snprintf(creator_info, sizeof(creator_info),
 		 "%s/%d", bo->debugfs.creator.process_name, bo->debugfs.creator.tgid);
-	seq_printf(m, "%-32s%-16d%-16d%-11d%-16zd%-16zd0x%-16lx",
+	seq_printf(m, "%-32s%-16d%-11d%-11d%-16zd%-16zd0x%-16lx",
 		   creator_info,
 		   bo->base.name,
 		   refcount,
@@ -1681,8 +1681,8 @@ static void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
 
 	panthor_gem_debugfs_print_flag_names(m);
 
-	seq_puts(m, "created-by                      global-name     refcount        evictions  size            resident-size   file-offset       state      usage       label\n");
-	seq_puts(m, "---------------------------------------------------------------------------------------------------------------------------------------------------------\n");
+	seq_puts(m, "created-by                      global-name     refcount   evictions  size            resident-size   file-offset       state      usage       label\n");
+	seq_puts(m, "----------------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	scoped_guard(mutex, &ptdev->gems.lock) {
 		list_for_each_entry(bo, &ptdev->gems.node, debugfs.node) {
@@ -1690,7 +1690,7 @@ static void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
 		}
 	}
 
-	seq_puts(m, "=========================================================================================================================================================\n");
+	seq_puts(m, "====================================================================================================================================================\n");
 	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable: %zd\n",
 		   totals.size, totals.resident, totals.reclaimable);
 }

-- 
2.54.0

