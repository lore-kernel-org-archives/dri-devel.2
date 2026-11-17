Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3790606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XUtL4rgU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614BB10EA6F;
	Tue, 17 Nov 2026 10:39:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B7910F5EE
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=jJ1tq71DpD3RX2IBJ7zvIFQs67UcDAT39C7AfDJhYaE=; t=1794911960; x=2110271960; 
 b=XUtL4rgU9YWxWEtpTUwpRj8Vhy8yNY7KtP5qk/cQ7RI9aDTlyRSOoeM3gTdCzm1N+/E/DyyrPHC
 xhb1bl7S5FJQvmi6xc0rr/PcM+A1LCk2sxR2n0HBPARGfuM2vAJMrGIOOXEywtp/KZbBiWn8S+hLS
 jcKmW0ssAcWuTbv9N98CqEG1GvWbQq1i4t/H2ePsd+RiOLkYC+34o8rIrHI8NPSfbGtXtIKXzmopa
 VxXvzxj2DM2Iroht9ihZikFqjcjHRnB2g7L8h4OFK+LbjHsUmgIILH5DkTCxsMe9DuaQ7lHPO+FJ8
 JEr8e87NpWe4t/AszSviP6VLZHGsDDMl06CA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTGas-00000000XyI-3klq; Tue, 17 Nov 2026 11:39:18 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/syncobj: Use vmemdup_array_user in
 drm_syncobj_array_find
Date: Tue, 17 Nov 2026 10:39:14 +0000
Message-ID: <20261117103916.9101-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
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

