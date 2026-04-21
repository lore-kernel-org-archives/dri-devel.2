Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28F1F8925C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811B610E878;
	Tue, 21 Apr 2026 10:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AM/mJDSn";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0802310E84B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776768358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mpxwvI+TMo9e51ItJfnMe8heN5VV0K2AruyYqLF3W0H0f8isJ+ipq1ohQse6tuPx+JyY43/I2/iAKMi+IlvynBqredCtdMtfQ0qzamSuiTbdQr32BJPYLeefZO7FPS5nZ8ayZcLbf2q0d5LlMOMHKbHKBXRzVYBJiOgrawWAurw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776768358;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9ApbCGrw4JWVWeOXA1lI9/HhWh8d2pfHg6fH85Z5HVY=; 
 b=EDcUhfkn2LYk2+7eUmg1AMwjs06Fe1gMOexGPOaIwwY8xSsJ6Nt1e26c8SLryvCZyW1/MPFOSlAXyiDgDrXcZjtIAwnE7tFux//6X6RM4WnHJtFoX4q9V7EpB8lcfsGaiJj97k9noKxEQowyqgl69CrkvoGqudLi3lxlO8tkJVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776768358; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=9ApbCGrw4JWVWeOXA1lI9/HhWh8d2pfHg6fH85Z5HVY=;
 b=AM/mJDSnASIAaEH1XdWK4WKUFjlAez8tXu+hZI1dWQpvGJGQ3Op/2LPCwmCcjUf3
 +YVv8AVNKzXYpEtSavp5jZm3ggDLoOx1cCpoH/BSCEcveZmGxhf9FaW6CdUn00HVrwK
 /AVKdcP6qS38JTSVvP1U1Dz9GFhciJO4r6RFTEwk=
Received: by mx.zohomail.com with SMTPS id 1776768357845472.6439605710607;
 Tue, 21 Apr 2026 03:45:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 21 Apr 2026 12:45:15 +0200
Subject: [PATCH v2 3/3] drm/panthor: Reduce padding in gems debugfs for
 refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-panthor-bo-reclaim-observability-v2-3-c9135eedfb6f@collabora.com>
References: <20260421-panthor-bo-reclaim-observability-v2-0-c9135eedfb6f@collabora.com>
In-Reply-To: <20260421-panthor-bo-reclaim-observability-v2-0-c9135eedfb6f@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index b6fe20b7e6d0..462a9d2ce319 100644
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
2.53.0

