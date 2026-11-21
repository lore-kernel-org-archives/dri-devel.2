Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22E606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GRf6h5v5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2092610E0B6;
	Sat, 21 Nov 2026 07:18:48 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130E810E0B6;
 Sat, 21 Nov 2026 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kO
 LdrxtlbkJl5si7RCYhsrq7KDo3r3G+vXC21EW5Oac=; b=GRf6h5v53/wts6PEIH
 lqwmV1URlwiSzQbXS8wprJg2TJ3n3644hxzqnRJAHTwHwaCjOcZPvekcCRtC7uPZ
 7BPgcNi9Gv2QlVjvNQv7SE93joTY8vCybwx3nmLfAveYXEMF/Q6gBabvKP2jdFof
 diWd2qF5Byhs/Lr1vxUtK76zE=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgAHVaSsRQFrb83YHA--.29041S2;
 Sat, 21 Nov 2026 15:18:06 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andi.shyti@kernel.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v2] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
Date: Sat, 21 Nov 2026 15:17:13 +0800
Message-Id: <20261121071713.335337-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgAHVaSsRQFrb83YHA--.29041S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy7Cw17Xw4xJw4kCFWruFg_yoWDZFc_CF
 yjy34jgrWUAryq9Fy5CFs3ZFy0y3WkZrs7XF1xt3s3JFyUCr4Du3s3WryrXw4xCF4qqFZF
 q3Z7XFnxZr97KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM8nYUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Q6XBmsBRa7SEgAA3z
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

The memory allocated by i915_vma_work() is not freed if
i915_gem_object_get_moving_fence() fails. Change the
goto label to do so.

Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-intel-gt-next")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
Changes in v2:
 - Modify the commit message. Thanks, Andi!
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

