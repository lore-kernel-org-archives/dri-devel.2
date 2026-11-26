Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=KxLaj4sJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A6C10E989;
	Thu, 26 Nov 2026 11:11:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8385710E989
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=jJ1tq71DpD3RX2IBJ7zvIFQs67UcDAT39C7AfDJhYaE=; t=1795691491; x=2111051491; 
 b=KxLaj4sJZyREy4mkyuUTbwNuUBrxYRiesUyyfEFaCWEumD6iGuiQhf2iKmF+4vbhwikLL1GUGEO
 en9gIHlb5+sJ6rYQIkagN9gYifgO74aFyutbBtZKUFMLv4+88ZvWX4mjt+B77gcNBU939PXXTekzs
 alwHDg+YpScxYZbBIol5ZyR9+f3tkrAsOf5eB2r3mZqggKxdmAMluL7nDZi7RjlxuFQRzMi+M5hTp
 8k8UjNtunla9T8aqbccXuT77oq8ARNvfkeIizs5WOB1Q4tO2pQ+2uYXVD/WdNDjnb+z1ZFzVoUZaN
 TpsYES814ymm0HrI+yjI7dHnOCObvCD815+w==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXNx-00000004MPl-43S2; Thu, 26 Nov 2026 12:11:30 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/7] drm/syncobj: Use vmemdup_array_user in
 drm_syncobj_array_find
Date: Thu, 26 Nov 2026 11:11:11 +0000
Message-ID: <20261126111117.67342-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Using a helper shrinks the code and separating the user and kernel slabs
is more secure.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_syncobj.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 6cc654641183..663d6cb8dbf8 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1252,15 +1252,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
 	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
 		return -EINVAL;
 
-	handles = kvmalloc_objs(*handles, count_handles);
-	if (handles == NULL)
-		return -ENOMEM;
-
-	if (copy_from_user(handles, user_handles,
-			   sizeof(uint32_t) * count_handles)) {
-		ret = -EFAULT;
-		goto err_free_handles;
-	}
+	handles = vmemdup_array_user(user_handles, count_handles,
+				     sizeof(*handles));
+	if (IS_ERR(handles))
+		return PTR_ERR(handles);
 
 	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
 	if (syncobjs == NULL) {
-- 
2.56.0

