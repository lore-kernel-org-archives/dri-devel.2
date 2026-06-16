Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A08CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C078D10EE3F;
	Wed, 17 Jun 2026 07:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ejWpcK9Z";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF9E10ECE6
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:20:07 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-37c8e7c8137so165841a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781634007; x=1782238807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UwpVureg07QbjRnL27mIYEGwVaOJw7DuUq/siGYlqU4=;
 b=ejWpcK9Z0FP37z7UhCAhYEoZVXGF+dRsL7KzbOUy8DrmpEnubmQ0ittMRg3GielWJj
 sWyVYoYe1D+tLSk+wxJiai9tHCSTr9mD94cNBHpSpj2o8rMVgcwnIx66AQAJpo/0LfJF
 UE2xe5AyI586Q9dxxJ5vDTsx4z5HqIwD64IdwJl6xYbZKJY/uO05L8Ee+1IP6guFaMFe
 u5z4caJmKQUF2nFqcB2tLdIagiIcFgcjUBv30hlq63gktPAERPk/giyrbph3E/MsCp0Y
 MGh1lQnjm9TKoCYWk3pXUULa6wR3wf35pLI+iPhUf9z/aQKwCQzCdFZ6X/xeMzHNcnpy
 E5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781634007; x=1782238807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwpVureg07QbjRnL27mIYEGwVaOJw7DuUq/siGYlqU4=;
 b=oIFQix+I+ybaNxmbboSvoINMVwPrzqTZ4n2PGkGgQkOqyyqQfTJkxkbSkTz4eCVosN
 EMlrw6tBlCHnaXXMIWa4twwNmeIVUQLHaQcht94GKMIgKGF2L17T5P9uqG0/tkQpr/aC
 sKuT3o4VSDwzFZzu2RCzn4YCGbac73XTd4QATmYYo7yzlRxZsJ/SbJrUrboL5x5l5E0b
 r4qgDSCXoYj2iUfgIvAsRNPSfBFq25uLFcQrEaIdUZvGzGrE1qbiQKtv0Jnu4eEj56ru
 AcSdO78NzIYMK6qc1+4jhOD1CQy4njOEfrYwlagMUCox+emqKb+WLL3pvFselmY4VjEY
 0TrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xg/DUysmmk7OGFa7SDze/bTI2nRxC5EEe8ITkXzIHpkkfJc1Nv9CJrVn8aLE+pBWIYEVyMA7dWTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGa5ELIcvJ/qrOg9WK3NLPp2BTMEBiC1m2y+nxU/E0YD/olbCD
 0RH16RCYnvF3/N9DD3CVASjpt9MwKWEJIGk7GksrrdZwOYl998AqaH3hTZx+MVHt
X-Gm-Gg: AfdE7cntCvDMSv6eksJSxEctjTr8jEBSEtrwhVk02lJsyQkyhKsmMzCuidRWt8LcnEP
 PVHocIQ3elc5iNRydxYVrcZsukBRd1OptP2M95zP4b/9koQJk2Kw4vmqNLT1ZYoPnaBZvPAHdOZ
 LtdT9O/ciQplKpGVijcs2MfbY0sHgCtguXc5+nNMP5MRo77ugrZfmTAuiyPYdBTddhaWrUrClsY
 i1Va4kBML2cCPK3yZxCCJ5YDsX58O7qiQ8hMclo0V7O2ogNPVQUuHbtAyQP6+1glQrDIqAnv4xL
 eiv68A5Dj9LJAPPUlgIn76pYOixKFtKmaI1BSD7sUn1GCb0sdFtMYFuWJ3s7M/Pa6AlUHeyqcz5
 24dWqalplhX9j7jcB7RSAwAfMeescZ50hR/adEyVR8stVoFX9fS9GGxYbO+YVrBh3FcxuutNduZ
 mJBCiajcqUzDcLVNybr+M0htvl5B7eeF+3UNb5mTfsfZyxSmquG37GLjlrNbSgnhE=
X-Received: by 2002:a17:90b:4ac7:b0:36b:7c2a:263e with SMTP id
 98e67ed59e1d1-37c9e9d408dmr178965a91.20.1781634007158; 
 Tue, 16 Jun 2026 11:20:07 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ef803sm3605560a91.11.2026.06.16.11.20.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 11:20:06 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH] drm/gem: modernize locks to use scoped_guard()
Date: Tue, 16 Jun 2026 23:49:57 +0530
Message-ID: <20260616181956.61476-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

Several GEM core functions manually managed mutex_lock() and
mutex_unlock() over single scopes or error paths. This adds boilerplate
and carries the risk of lock leaks if error paths are refactored.

Modernize these locks by deploying the <linux/cleanup.h> scoped_guard()
macro. This ensures that the locks are reliably dropped when the block
exits, cleanly removing goto out_unlock paths and tightening the
lifecycle.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Compiled locally, but requires IGT validation by the DRM CI.
---
 drivers/gpu/drm/drm_gem.c | 66 ++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 891c3bff5ae0..d3a061d42ba7 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -346,13 +346,13 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 	 * we checked for a name.
 	 */
 
-	mutex_lock(&dev->object_name_lock);
-	if (--obj->handle_count == 0) {
-		drm_gem_object_handle_free(obj);
-		drm_gem_object_exported_dma_buf_free(obj);
-		final = true;
+	scoped_guard(mutex, &dev->object_name_lock) {
+		if (--obj->handle_count == 0) {
+			drm_gem_object_handle_free(obj);
+			drm_gem_object_exported_dma_buf_free(obj);
+			final = true;
+		}
 	}
-	mutex_unlock(&dev->object_name_lock);
 
 	if (final)
 		drm_gem_object_put(obj);
@@ -374,11 +374,8 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
-	mutex_lock(&file_priv->prime.lock);
-
-	drm_prime_remove_buf_handle(&file_priv->prime, id);
-
-	mutex_unlock(&file_priv->prime.lock);
+	scoped_guard(mutex, &file_priv->prime.lock)
+		drm_prime_remove_buf_handle(&file_priv->prime, id);
 
 	drm_vma_node_revoke(&obj->vma_node, file_priv);
 
@@ -1021,37 +1018,34 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		goto out;
 	}
 
-	mutex_lock(&file_priv->prime.lock);
+	scoped_guard(mutex, &file_priv->prime.lock) {
+		spin_lock(&file_priv->table_lock);
+		ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
+				GFP_NOWAIT);
+		spin_unlock(&file_priv->table_lock);
 
-	spin_lock(&file_priv->table_lock);
-	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
-			GFP_NOWAIT);
-	spin_unlock(&file_priv->table_lock);
+		if (ret < 0)
+			break;
 
-	if (ret < 0)
-		goto out_unlock;
+		if (obj->dma_buf) {
+			ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
+						       handle);
+			if (ret < 0) {
+				spin_lock(&file_priv->table_lock);
+				idr_remove(&file_priv->object_idr, handle);
+				spin_unlock(&file_priv->table_lock);
+				break;
+			}
 
-	if (obj->dma_buf) {
-		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
-					       handle);
-		if (ret < 0) {
-			spin_lock(&file_priv->table_lock);
-			idr_remove(&file_priv->object_idr, handle);
-			spin_unlock(&file_priv->table_lock);
-			goto out_unlock;
+			drm_prime_remove_buf_handle(&file_priv->prime, args->handle);
 		}
 
-		drm_prime_remove_buf_handle(&file_priv->prime, args->handle);
-	}
-
-	ret = 0;
-
-	spin_lock(&file_priv->table_lock);
-	idr_remove(&file_priv->object_idr, args->handle);
-	spin_unlock(&file_priv->table_lock);
+		ret = 0;
 
-out_unlock:
-	mutex_unlock(&file_priv->prime.lock);
+		spin_lock(&file_priv->table_lock);
+		idr_remove(&file_priv->object_idr, args->handle);
+		spin_unlock(&file_priv->table_lock);
+	}
 out:
 	drm_gem_object_put(obj);
 

base-commit: 72c25183cac9bc584c9de21797a5883af44bcc7a
-- 
2.50.1 (Apple Git-155)

