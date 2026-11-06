Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C35606A32F
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WpWTbD5O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ADC510E633;
	Sat,  7 Nov 2026 14:27:51 +0000 (UTC)
X-Greylist: delayed 545 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 10:07:01 UTC
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id D2FF7112BC0
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=WpWTbD5O+I1qBhYxRhUoMwr1RkpnWbPp8QK3mp15S6j5u5W9JrH61xHYTQ/62/f7bX8/zwpYXkPR8
 /whB4ZNaXWb0dRbCdwgBtc9OYRUH8k57P7iTI7rbtLzjOwXxFyjpUUv0tfkLeQGWomy8uHRRojfx2X
 R4+l3kVYvrgHB/v0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeda49dfc8-7d9e6;
 Fri, 06 Nov 2026 17:57:49 +0800 (CST)
X-RM-TRANSID: 2ee66aeda49dfc8-7d9e6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[10.55.1.72])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeda49bbde-1be40;
 Fri, 06 Nov 2026 17:57:48 +0800 (CST)
X-RM-TRANSID: 2ee76aeda49bbde-1be40
From: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
Cc: tongzhiwei@cmss.chinamobile.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/syncobj: Fix fence and syncobj leak on
 dma_fence_chain_alloc failure
Date: Fri,  6 Nov 2026 17:57:20 +0800
Message-ID: <20261106095730.166-1-tongzhiwei@cmss.chinamobile.com>
X-Mailer: git-send-email 2.45.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NOTE: this commit is worked by llm completely

In drm_syncobj_import_sync_file_fence(), when point is non-zero and
dma_fence_chain_alloc() returns NULL, the function returns -ENOMEM
without releasing the fence reference (obtained via sync_file_get_fence)
or the syncobj reference (obtained via drm_syncobj_find).  Both
references are permanently leaked.

Add dma_fence_put(fence) and drm_syncobj_put(syncobj) before returning
-ENOMEM on the allocation failure path.

Assisted-by: LLM
Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
---
 drivers/gpu/drm/drm_syncobj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index f1d4da168545..1825055e9b54 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -743,8 +743,11 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
-		if (!chain)
+		if (!chain) {
+			dma_fence_put(fence);
+			drm_syncobj_put(syncobj);
 			return -ENOMEM;
+		}
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
-- 
2.43.0



