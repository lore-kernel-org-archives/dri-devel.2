Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B55606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nPh3L66s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB8710FDDB;
	Wed, 18 Nov 2026 15:32:46 +0000 (UTC)
X-Greylist: delayed 3913 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 15:32:40 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5982110E544
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0d
 SYoc96Z/CKs/r/Hn8wki19v98dUkiWQeKXaHKJfGQ=; b=nPh3L66sjVuGjpLnf+
 sW5qZB5D7KoIYOpyL6mQ5J9rXBDVgidjbO5p1d9JhhaxvnNdipJlplPziJF9j4GV
 qUNKJcs0xGjEWC/ROMBdSeL9WKGj3gi7FjhgWYfNf9ZDYK+P0TN3apz9iGoY7vOG
 jsnmWEGmeVKWsA5SAbNeBEA3o=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wDXvxH1xP1qgAB1Hw--.27589S2; 
 Wed, 18 Nov 2026 23:32:07 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
Date: Wed, 18 Nov 2026 23:32:05 +0800
Message-Id: <20261118153205.2432736-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXvxH1xP1qgAB1Hw--.27589S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWkZr1UAry8GryUWw47XFb_yoWDtrc_CF
 y0vrWxWryjyrWqvFy5CFs3ZFy0ywnYqrWxAw1ft3s3tryUCr4Du3sxWryrXr4xCa1DtFZI
 qas7XFn8Ar97KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNiiSDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7ReI9mr9xPdgsQAA3x
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i915_vma_pin_ww() allocates bind work before retrieving the object's
moving fence. If the lookup fails, it jumps to err_rpm, bypassing the
fence commit at err_fence and leaking the work allocation.

Jump to err_fence instead so the fence callbacks can release the work.

Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-intel-gt-next")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 16782d8579a8..4ba1c9ea5ecb 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1470,7 +1470,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 
 		err = i915_gem_object_get_moving_fence(vma->obj, &moving);
 		if (err)
-			goto err_rpm;
+			goto err_fence;
 
 		dma_fence_work_chain(&work->base, moving);
 
-- 
2.25.1

