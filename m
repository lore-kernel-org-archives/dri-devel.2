Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8E606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g2ypRfzY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EF210F2F5;
	Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1166B10E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:19:02 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2e934c6c20aso12631465ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792401541; x=1793006341; darn=lists.freedesktop.org;
 h=message-id:date:content-type:mime-version:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cjm8HPHvrXyPPBS+nroTNzx3a8I1halzi3A1ZZi9lgA=;
 b=g2ypRfzYOD0g1TE6Bfaq9LjmCgknHG+Wa613ulPSW8U8IS9+SM5j+spD9oTAb+NKd0
 MlwE6Vl8hlHRRz5vuTyjjtw1QA4nEmpElHrXpjqDIcFLXgtU/zFl1azS81dgs4STHRVU
 wV6J31va9MDF3wo9tuZJnW6u43iYZmwOxGZhhQnKF+2ZVzluxACxSry4ez8ljB0FKhwN
 RgBvQdSt3t2MtWcAFLjAFbIUBsiqW7dnQfIZVXuTHkzzp9TUz3YoKMCyQVqznzRUqjeP
 NyaIpFeTIioKssqcU8T6WW3Jg8dQMsBxI28paUvwKUuH6EXrBhKTBGj5YlXA77xDcQ5a
 /QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401541; x=1793006341;
 h=message-id:date:content-type:mime-version:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cjm8HPHvrXyPPBS+nroTNzx3a8I1halzi3A1ZZi9lgA=;
 b=gsnsH4RHRLPDBSgdyOLWg2BxldTceCY4+bOMtaFBzF3YmSjtAflVJAbXyPB1Q6Od0T
 BB8zP0Zu+TNrxyVOSFn/IWL3bH4AYL1jvZY7twb9AH6RqoSegIFcMJQ1OXWp0QVObqS8
 W7VKQvGZL4r1jKo4CTsemJ1nd03JntMbrVQIZE+RIsRh9owXNsgrRp8zJfbkDLygpgkh
 tG21vrciX/G4EPJ1lNXlyfFnyfp0woTU9X9rm67w9gt9SilZdSwhd5sZc9odNpXQ4RFm
 NXx2R2oAsMSmaWzd11Bjb6NSPALLGcGnHdroArMH8Ea5zKsfEazSFNCb63d95dOvXIhq
 iS6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ0ojErRhZkBIBL3du8T1UrfpusBXRsB3pxMJ5eqsvZ5LkNtfcyeVQiYBy7a3BTqpQGvfMSp8bNFs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFmg9LVy05T0qpemMC/2duqqbcBuS8MXlyEUg3QrR87iSA1QVU
 5tZlgDv2agasnTbjF3ekKJWZTm5V964M/alVFSRbO9l12oMoBxuPkw/1tttGbD0W3Es=
X-Gm-Gg: AYBFou1RDIdLIFNmKkpYlHBXr1jpmtnAR4tj0d2L8gVnmhvGY5SmbIkZc4DGn2BxYaK
 nyAOZFcaXaljoHHNj3FjqQ1aXh910wVb9afh2mgNLpUefzA3+1oG08wSBHP8aiM8HhhQ5yHpFqY
 +Zi3STGkRZ+kc8v7Izo2oGA5pCCeguxbw8V9GcyIEiiBG7ZSNgigeCR0ORPSqLdbxTytt/0bUHG
 MKFwN5TRWvRyMiHJVMlr6YvLMf7N4sq/BLUh2jM/yRswdOVt3KpNqlgRyDLmNioOD7J08Ttpg5m
 xcVjaN5bfMbrH4sUQHunHAHaKdjRjZK1ro+kftXLbn5LyRiF3pa1IplzGMI9KI3j71ASdezG84E
 O8z+kcI5EZWyRDpPeV8Ll07xZr0Y9WvZ9M1nyAK1qT2ez8gl3WBfyr/+FUFxKeGBiVVZzYz8GyT
 H3huoik/5Y7zb1xbaB/CJx10YFeC8moaPUImJRrfAIXdNyJKXucG4JUrQe3QCkQQSNsDjhLpcL6
 qQDVZCDULHfz+k=
X-Received: by 2002:a05:6a21:3a84:b0:3e2:257a:a61d with SMTP id
 adf61e73a8af0-3e226070095mr5725834637.41.1792401541517; 
 Mon, 19 Oct 2026 02:19:01 -0700 (PDT)
Received: from [192.168.43.2] ([119.234.41.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549c7034sm3571425a12.16.2026.10.19.02.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:19:00 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/qxl: validate relocation destination offsets
In-Reply-To: <6acafc03.6b76d992.279a8.b343@mx.google.com>
References: <6acafc03.6b76d992.279a8.b343@mx.google.com>
 <sashiko-outbox-166994@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Mon, 19 Oct 2026 17:19:01 +0800
Message-ID: <179240154188.24976.18308245375219473922@gmail.com>
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The QXL execbuffer ioctl lets userspace request relocations into a
destination buffer object at an arbitrary offset.  The offset is never
validated against the size of that object, and the relocation is applied
with a plain pointer write into the object's io-mapping window:

  apply_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint64_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = ...;

  apply_surf_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint32_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = id;

so a user supplied dst_offset turns into an out-of-bounds kernel write of
8 (or 4) bytes.  As the offset is additionally truncated into a 32bit
member and handed on as "int page_offset" to qxl_bo_kmap_atomic_page(),
the write can even be placed before the object (sign extension).

Validate the offset plus the access size against the destination object
size, require the offset to be aligned to the access size so the write
can never straddle a page boundary, and make the offset/parameter types
wide enough that the check is not defeated by truncation or sign
extension.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
v3:
 - require dst_offset to be aligned to reloc_size so the write can never
   straddle a page boundary inside the kmap window (addresses Sashiko's
   alignment finding).

v2:
 - use a real-name Signed-off-by (noted by Willy Tarreau).
 - the reproducer and full report were sent to the maintainers on 2026-10-06;
   the reproducer can be shared on request.
 drivers/gpu/drm/qxl/qxl_ioctl.c  | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_object.c |  2 +-
 drivers/gpu/drm/qxl/qxl_object.h |  2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026..9a031bb 100755
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -73,7 +73,7 @@ int qxl_map_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv
 struct qxl_reloc_info {
 	int type;
 	struct qxl_bo *dst_bo;
-	uint32_t dst_offset;
+	uint64_t dst_offset;
 	struct qxl_bo *src_bo;
 	int src_offset;
 };
@@ -149,6 +149,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	void *fb_cmd;
 	int i, ret;
 	int unwritten;
+	u32 reloc_size;
 
 	switch (cmd->type) {
 	case QXL_CMD_DRAW:
@@ -231,6 +232,26 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		/*
+		 * The relocation is applied with a plain write into the memory
+		 * window of the destination object, so the user supplied offset
+		 * must be validated against the object size.  Otherwise userspace
+		 * can write anywhere in the mapping window set up by
+		 * qxl_bo_kmap_atomic_page(), i.e. outside of the object.  The
+		 * offset must also be aligned to the access size so the write
+		 * cannot straddle a page boundary inside the window.
+		 */
+		reloc_size = (reloc.reloc_type == QXL_RELOC_TYPE_BO) ?
+			     sizeof(uint64_t) : sizeof(uint32_t);
+		if (!IS_ALIGNED(reloc_info[i].dst_offset, reloc_size) ||
+		    reloc_info[i].dst_offset > reloc_info[i].dst_bo->tbo.base.size ||
+		    reloc_size > reloc_info[i].dst_bo->tbo.base.size -
+				 reloc_info[i].dst_offset) {
+			DRM_DEBUG("reloc dst offset out of bounds\n");
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 313f6c3..0df4814 100755
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -204,7 +204,7 @@ int qxl_bo_pin_and_vmap(struct qxl_bo *bo, struct iosys_map *map)
 }
 
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
-			      struct qxl_bo *bo, int page_offset)
+			      struct qxl_bo *bo, unsigned long page_offset)
 {
 	unsigned long offset;
 	void *rptr;
diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 875f632..a4aed9d 100755
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -63,7 +63,7 @@ int qxl_bo_pin_and_vmap(struct qxl_bo *bo, struct iosys_map *map);
 int qxl_bo_vmap_locked(struct qxl_bo *bo, struct iosys_map *map);
 int qxl_bo_vunmap_and_unpin(struct qxl_bo *bo);
 void qxl_bo_vunmap_locked(struct qxl_bo *bo);
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
+void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, unsigned long page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
 extern void qxl_bo_unref(struct qxl_bo **bo);
