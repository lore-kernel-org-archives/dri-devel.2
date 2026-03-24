Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5ACE9A762
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068BD10E667;
	Tue, 24 Mar 2026 11:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KDo01YoK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A5A10E65B;
 Tue, 24 Mar 2026 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vat7zC7phELYUYvBR1axFTaM6oJzyj5ktijrTrVZG4E=; b=KDo01YoKWyEyy0jp+mRNKC7R1A
 eB0Y6WpguSkeyQ26BEqGT98K5ju+BDaGfuHmaGg10yB1msnXyrOdViXr39egLUThnA7E+DIeTTWGN
 2a/j5XdM3mJZkticjh7igVmusbsukmxjYrJ8cNDNU3VGMLTAnS73ME9HGEeBd4YznqVGgH/stikoq
 /GA/WYHlvhMHYhlzEXHk419i12HIBDGyLsG31xH7mziO8Gzi9qjF04z5BBF4m+Pc4vhQ0ZDZnu3w/
 TnokTsnoqdciunnuOLozj92fCPdmpwh+0XIQaVXpMwWjanLMC/0Iq1WkvWBJOpt2jBzi+kbcjlMar
 kA3miFHw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w4zeR-005J6J-Pn; Tue, 24 Mar 2026 12:10:23 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Himanshu Girotra <himanshu.girotra@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH] drm/syncobj: Fix xa_alloc allocation flags
Date: Tue, 24 Mar 2026 11:10:19 +0000
Message-ID: <20260324111019.22467-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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

The xarray conversion blindly and wrongly replaced idr_alloc with xa_alloc
and kept the GFP_NOWAIT. It should have been GFP_KERNEL to account for
idr_preload it removed. Fix it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: fec2c3c01f1c ("drm/syncobj: Convert syncobj idr to xarray")
Reported-by: Himanshu Girotra <himanshu.girotra@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/drm_syncobj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 250734dee928..8d9fd1917c6e 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -602,7 +602,7 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
 	drm_syncobj_get(syncobj);
 
 	ret = xa_alloc(&file_private->syncobj_xa, handle, syncobj, xa_limit_32b,
-		       GFP_NOWAIT);
+		       GFP_KERNEL);
 	if (ret)
 		drm_syncobj_put(syncobj);
 
@@ -716,7 +716,7 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 	drm_syncobj_get(syncobj);
 
 	ret = xa_alloc(&file_private->syncobj_xa, handle, syncobj, xa_limit_32b,
-		       GFP_NOWAIT);
+		       GFP_KERNEL);
 	if (ret)
 		drm_syncobj_put(syncobj);
 
-- 
2.52.0

