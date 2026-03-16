Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38787F4643A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EB010E38D;
	Mon, 16 Mar 2026 09:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DKgvwvpU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E4210E38D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J5fVc+vwg4dCQ6xbKUSS7iEY6ykoN0Ad+dDhnR0HD48=; b=DKgvwvpUTkbUitpTibqSHDN5m6
 BmLWIzhA6CSnWYXojcO3BREmxJTnBGaMC7Eh+kidzDnB5VEZQZ58EWNDrjZkofuvisDXm8gTZyhPy
 AZeZtEzM5+Pq9JR8kP1jmCNyCyx5WJ0zKHGj3Yl2jhHIDix6wMubGnLSu1SRW+IvJpAQJbTllthAZ
 M5cIx7aOmwW+9bJvieAkatze+R7fdSNgVo50PfQjWlA61vlllSC0JMk3vqM4asvSlyPunDxsUyhx3
 ODFA3SI0UayGLiPUgcydGfAnGw+pvyTJYNJtbB4YPUrpirtVwCzL+nF41svHBtm9/b+pAu9xb0yA8
 OPtw7JMA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w24Oq-00GNjG-2R; Mon, 16 Mar 2026 10:38:12 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/gem: Improve drm_gem_objects_lookup() kerneldoc
Date: Mon, 16 Mar 2026 09:38:09 +0000
Message-ID: <20260316093809.97267-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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

Make clear that the returned array has to be free using kvfree().

While at it, fix broken reference to non-existant @objs and allow for more
error codes on failure.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/drm_gem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index fdf08cae1c5b..124cc5f3d9ff 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -821,13 +821,14 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
  * Takes an array of userspace handles and returns a newly allocated array of
  * GEM objects.
  *
+ * After a successul lookup GEM objects need to be released using
+ * drm_gem_object_put() and the array returned in @objs_out must be freed using
+ * kvfree().
+ *
  * For a single handle lookup, use drm_gem_object_lookup().
  *
- * Returns:
- * @objs filled in with GEM object pointers. Returned GEM objects need to be
- * released with drm_gem_object_put(). -ENOENT is returned on a lookup
- * failure. 0 is returned on success.
- *
+ * Return:
+ * Zero on success or a negative error code.
  */
 int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
 			   int count, struct drm_gem_object ***objs_out)
-- 
2.52.0

