Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873B4CD98E4
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEC510E6A7;
	Mon, 15 Jun 2026 20:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="D++8sIpY";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C802F10E625;
 Mon, 15 Jun 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1781554728;
 bh=D4AQFB9QtHL9JKfvLIusZbKcqEccrNoj87W28bbggd4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D++8sIpYzZ4q+fiujgSk7JQUpMYnJDK8+Jio3yAl16rIYCQA9SPss4eh9GaSRd2De
 mQ1uksWxm6RtFpMIggUe7C60Dnvcf6fhybAc2ZW+OEobOeSPhBaodcxZXWyQyUEp+v
 q+Oaplh9lfcW1LLo4OPTgw4ALXoPc5yY6mz538VNDeJifjiGsJQWuL2jOajORYSTkc
 NAaIJ1K9TBxc2e+0cRw3k4+LUS+vfXvkjoAO72CeptlJ3uLs67LPOo57RjqWoZbPEf
 gOnFtU+1Z0uBR0Y4D5F8mnpygUoolKbhj+lsFqGH6X6MEsxfu5j7+seIZiv7OsiJTU
 6RiUnti56qLrA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Alexander B Slota <alexander.b.slota@intel.com>
Subject: [PATCH v8 26/27] drm/xe/display: Always use system memory on
 PREEMPT_RT for DPT.
Date: Mon, 15 Jun 2026 22:18:44 +0200
Message-ID: <20260615201846.307297-27-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615201846.307297-1-dev@lankhorst.se>
References: <20260615201846.307297-1-dev@lankhorst.se>
MIME-Version: 1.0
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

We were using stolen memory because it was unused memory, but
on recent platforms this adds extra latency when waking from
RC6, because memory accesses go through the media IP.

Reported-by: Alexander B Slota <alexander.b.slota@intel.com>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index f93c98bec5b5f..c4e23926cd06e 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -173,14 +173,6 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
 						   XE_BO_FLAG_PAGETABLE,
 						   pin_params->alignment, false);
 	else
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_STOLEN |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   pin_params->alignment, false);
-	if (IS_ERR(dpt))
 		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
 						   dpt_size,  ~0ull,
 						   ttm_bo_type_kernel,
-- 
2.53.0

