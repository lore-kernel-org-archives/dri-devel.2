Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B185105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DB710E14A;
	Fri, 13 Mar 2026 15:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="duBzJwq5";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC6E10E14A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414656; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=frNDPhuU3go+5oGwCGyL3tIa7ZqYelwVOnM8go7alV0RCYNihZNoziceaZF/FOao0+v6sJvlAi10C2opbvDB0haN3TSM3L83PPDdfajkysoUIVzw2rZdPgC5vOlxHRq/lOIsXB/MPJ0cB0BpUSZDAN/DydNA76/WJlXqI7kD7Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414656;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rvo8v0kzuARx/tL36EjoGulUvklp2HYMwX094Y3tEzo=; 
 b=mmW1XsT3AqBr036yUHVk4PNUhrzBuAwJBTB8xxPRJ0M+zkJLjgs4rJHLzRkgfsRyyuPOd0tfzGzvZ9pM4SRGXrfyeN8Jnsx3RP3Q5gkC5S32yUicn+o4hfhlH53xfcQfutmVUkbeRxHnQcFwg+Z74h5INU1H/CMr0w1A50jtjSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414656; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rvo8v0kzuARx/tL36EjoGulUvklp2HYMwX094Y3tEzo=;
 b=duBzJwq50bDQ8XldTRdx8573mxqH8xXRs80BfFWnEOcn7htOS1M+DdpVjTqJWe7R
 0iAPCXhwoDaXCuE3SPd2z+M+wg7hxhHbKJDM4pQJPnqIH9r5rKqAQMGpRnC2B9Bx8Oq
 O6X6/1kgA1dRudf7oNqmvyTDj9FE1G8U8CNEbMQA=
Received: by mx.zohomail.com with SMTPS id 17734146534651007.4634642976198;
 Fri, 13 Mar 2026 08:10:53 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 02/11] drm/gpuvm: Remove dead code
Date: Fri, 13 Mar 2026 15:09:39 +0000
Message-ID: <20260313150956.1618635-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
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

drm_gpuva_find_next() has no consumers.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 22 ----------------------
 include/drm/drm_gpuvm.h     |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 14469765a780..3c2b6102e818 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2245,28 +2245,6 @@ drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start)
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_find_prev);
 
-/**
- * drm_gpuva_find_next() - find the &drm_gpuva after the given address
- * @gpuvm: the &drm_gpuvm to search in
- * @end: the given GPU VA's end address
- *
- * Find the adjacent &drm_gpuva after the GPU VA with given &end address.
- *
- * Note that if there is any free space between the GPU VA mappings no mapping
- * is returned.
- *
- * Returns: a pointer to the found &drm_gpuva or NULL if none was found
- */
-struct drm_gpuva *
-drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end)
-{
-	if (!drm_gpuvm_range_valid(gpuvm, end, 1))
-		return NULL;
-
-	return drm_gpuva_it_iter_first(&gpuvm->rb.tree, end, end + 1);
-}
-EXPORT_SYMBOL_GPL(drm_gpuva_find_next);
-
 /**
  * drm_gpuvm_interval_empty() - indicate whether a given interval of the VA space
  * is empty
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 655bd9104ffb..625958fce7fd 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -160,7 +160,6 @@ struct drm_gpuva *drm_gpuva_find(struct drm_gpuvm *gpuvm,
 struct drm_gpuva *drm_gpuva_find_first(struct drm_gpuvm *gpuvm,
 				       u64 addr, u64 range);
 struct drm_gpuva *drm_gpuva_find_prev(struct drm_gpuvm *gpuvm, u64 start);
-struct drm_gpuva *drm_gpuva_find_next(struct drm_gpuvm *gpuvm, u64 end);
 
 /**
  * drm_gpuva_invalidate() - sets whether the backing GEM of this &drm_gpuva is
-- 
2.53.0

