Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0D606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kkYN3x3s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD46B10EF70;
	Mon, 16 Nov 2026 11:27:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1877610EF70
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:26:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D251A25;
 Mon, 16 Nov 2026 03:26:49 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474393F632;
 Mon, 16 Nov 2026 03:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828412; bh=M61mPJfzDj7AKWDhpO/ALFj0TxdAcS7D354FdC4/4SE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kkYN3x3sDEtDoLH0emOX5YaK9vM/JhFhM9GVoBmnXrfvcg5sXgnNT/ruiJPoThPk7
 hMXhBkEeeHYtJSoXn/fSWypxcM72ZH8A5Ld0nABTh4mjYA7lBzeofmMo/gY5RXh7wH
 JJCOKcmW/nExuXg0TIbEjzq/gFjN0yIsU14csYz4=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v5 08/13] drm/panthor: Refactor GEM usage flags assignment
Date: Mon, 16 Nov 2026 12:25:56 +0100
Message-ID: <20261116112601.3483649-9-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116112601.3483649-1-ketil.johnsen@arm.com>
References: <20261116112601.3483649-1-ketil.johnsen@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Boris Brezillon <boris.brezillon@collabora.com>

Changes panthor_gem_debugfs_set_usage_flags() to
panthor_gem_debugfs_add_usage_flags(). This will come in handy in a
later change when we split panthor_kernel_bo_create() to also handle
protected memory.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v5:
- Minor formating fixes.

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_gem.c | 13 +++++++------
 drivers/gpu/drm/panthor/panthor_gem.h |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 22b57ab6f9291..5d0eb31746164 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -74,14 +74,14 @@ static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo)
 	mutex_unlock(&ptdev->gems.lock);
 }
 
-static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
+static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo, u32 usage_flags)
 {
-	bo->debugfs.flags = usage_flags;
-	panthor_gem_debugfs_bo_add(bo);
+	atomic_or(usage_flags, &bo->debugfs.flags);
 }
 #else
+static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo) {}
 static void panthor_gem_debugfs_bo_rm(struct panthor_gem_object *bo) {}
-static void panthor_gem_debugfs_set_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {}
+static void panthor_gem_debugfs_add_usage_flags(struct panthor_gem_object *bo, u32 usage_flags) {}
 static void panthor_gem_debugfs_bo_init(struct panthor_gem_object *bo) {}
 #endif
 
@@ -1034,7 +1034,8 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 		bo->base.resv = bo->exclusive_vm_root_gem->resv;
 	}
 
-	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
+	panthor_gem_debugfs_add_usage_flags(bo, usage_flags);
+	panthor_gem_debugfs_bo_add(bo);
 	return bo;
 
 err_put:
@@ -1647,9 +1648,9 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 	enum panthor_gem_reclaim_state reclaim_state = bo->reclaim_state;
 	unsigned int refcount = kref_read(&bo->base.refcount);
 	int reclaimed_count = atomic_read(&bo->reclaimed_count);
+	u32 gem_usage_flags = atomic_read(&bo->debugfs.flags);
 	char creator_info[32] = {};
 	size_t resident_size;
-	u32 gem_usage_flags = bo->debugfs.flags;
 	u32 gem_state_flags = 0;
 
 	/* Skip BOs being destroyed. */
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 5ae37d0d3646f..4da3f59693ce4 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -62,7 +62,7 @@ struct panthor_gem_debugfs {
 	} creator;
 
 	/** @flags: Combination of panthor_debugfs_gem_usage_flags flags */
-	u32 flags;
+	atomic_t flags;
 };
 
 /**
-- 
2.43.0

