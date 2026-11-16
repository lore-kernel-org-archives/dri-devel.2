Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDD60A3809
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VWY+oIno
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF30810E9D8;
	Mon, 16 Nov 2026 11:27:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 81E7910E9D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:27:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E151AED;
 Mon, 16 Nov 2026 03:26:57 -0800 (PST)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBFE73F632;
 Mon, 16 Nov 2026 03:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794828420; bh=aoiP/aQskpclp57GNpI2kNLdgoNT6EZfghKRIK1IXGQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VWY+oInotMT+SduliAf70jnuDub6YK5HNjP3oDvMATtf7avtktedUh5OyHsplOPJd
 MbrQqGd/iUinO97DnhNRT2P4tfnS6fjzI83GLBLmk0opX7pJHz1yESFcJ7G7OOXRhP
 VwAQHFjseteZRDpfF4uLh+DDtINzkm/BRWICKFmk=
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
Subject: [PATCH v5 10/13] drm/panthor: Use a copy of suspend buffer sizes
Date: Mon, 16 Nov 2026 12:25:58 +0100
Message-ID: <20261116112601.3483649-11-ketil.johnsen@arm.com>
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

Store the suspend buffer sizes (normal and protected) provided by FW
after FW start. Unsafe to read directly from FW as these will return
zero between FW load and FW start.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v5:
- First version of this patch in this patch set.
- This change was previously in a different patch in the set.
---
 drivers/gpu/drm/panthor/panthor_fw.c    | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.h    |  3 +++
 drivers/gpu/drm/panthor/panthor_sched.c |  6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index fc07796fc9ef7..b565b362f401f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -255,6 +255,12 @@ struct panthor_fw {
 	/** @iface: FW interfaces. */
 	struct panthor_fw_iface iface;
 
+	/** @suspend_size: Size of regular suspend buffer */
+	u32 suspend_size;
+
+	/** @protm_suspend_size: Size of protected suspend buffer size */
+	u32 protm_suspend_size;
+
 	/** @watchdog: Collection of fields relating to the FW watchdog. */
 	struct {
 		/** @ping_work: Delayed work used to ping the FW. */
@@ -549,6 +555,16 @@ panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size)
 					"FW suspend buffer");
 }
 
+u32 panthor_fw_suspend_size(struct panthor_device *ptdev)
+{
+	return ptdev->fw->suspend_size;
+}
+
+u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev)
+{
+	return ptdev->fw->protm_suspend_size;
+}
+
 static u32 section_vm_map_flags(const struct panthor_fw_section *section)
 {
 	u32 cache_mode = section->flags &
@@ -985,6 +1001,15 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
+	if (!csg_idx) {
+		/* We make a copy of these sizes, as csg_iface can read these
+		 * as zero during full GPU reset, between FW sections being
+		 * reloaded and FW fully booted.
+		 */
+		ptdev->fw->suspend_size = csg_iface->control->suspend_size;
+		ptdev->fw->protm_suspend_size = csg_iface->control->protm_suspend_size;
+	}
+
 	if (csg_idx > 0) {
 		struct panthor_fw_csg_iface *first_csg_iface =
 			panthor_fw_get_csg_iface(ptdev, 0);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 4eda8f8e714c1..b3bf00191a96b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -511,6 +511,9 @@ panthor_fw_alloc_queue_iface_mem(struct panthor_device *ptdev,
 struct panthor_kernel_bo *
 panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size);
 
+u32 panthor_fw_suspend_size(struct panthor_device *ptdev);
+u32 panthor_fw_protm_suspend_size(struct panthor_device *ptdev);
+
 struct panthor_vm *panthor_fw_vm(struct panthor_device *ptdev);
 
 void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ca6aa6a55661a..9c78f04d4f30a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -4058,7 +4058,7 @@ int panthor_group_create(struct drm_file *file,
 	struct panthor_scheduler *sched = ptdev->scheduler;
 	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, 0);
 	struct panthor_group *group = NULL;
-	u32 gid, i, suspend_size;
+	u32 gid, i;
 	int ret;
 
 	if (group_args->pad)
@@ -4109,8 +4109,8 @@ int panthor_group_create(struct drm_file *file,
 		goto err_put_group;
 	}
 
-	suspend_size = csg_iface->control->suspend_size;
-	group->suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
+	group->suspend_buf =
+		panthor_fw_alloc_suspend_buf_mem(ptdev, panthor_fw_suspend_size(ptdev));
 	if (IS_ERR(group->suspend_buf)) {
 		ret = PTR_ERR(group->suspend_buf);
 		group->suspend_buf = NULL;
-- 
2.43.0

