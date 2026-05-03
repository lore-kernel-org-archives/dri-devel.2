Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEB4FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261E410E993;
	Tue,  5 May 2026 07:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dcYcQkVE";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5276710E05D
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 05:53:13 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ab232cc803so13216015ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777787593; x=1778392393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vr7la8q5ouMrDK8fN2eCNj+o3R1myO7B1gFJhcPxQqk=;
 b=dcYcQkVEYXSLWLq/0DUmjfia513a94xwCIG14XgbtaqOlqhHVvohgUxS+Ph+niGYpM
 HI9507wJoyqSq3VNIFVMtNsnCjoC8h72sNOhttKbFd7b7KLSeX87Zm51QRjgGXgSCJk2
 y2LhSkPFUBt3Y1nL8gcu+rhi6UAz8aFH8fl8x9zBb0swSraZfyrdeVBWcgoRPYxZmeow
 JQbJJYOtJNr9spaiWZ+uJ3PCFhYyMyj8OAQJIuFFO25y6ma+4E31G/SzvXBAFCv4Kbnm
 Ia0fJPng2uOTP7gjl1nZ3wwL1GOY694bZoVVZEcmzMKOO+b3D4ikyKgflhbEn3/u115X
 nAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777787593; x=1778392393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vr7la8q5ouMrDK8fN2eCNj+o3R1myO7B1gFJhcPxQqk=;
 b=faDOfwcmuy6yxGODWGcyys1NbYsdTD+Ytm20K8oz+Qux/1ce7PwFXnz/AyPphj/ZOD
 0DK0QpUomWSbIar5jxuU1z3ut3HvIw1dLpCoFGKrStTGUOun9Uaof4VD8+VZciUrhjx5
 2VC+CfGdAS+iu5VTbt0YryzGBeCbspvL0lSV0gw6/uR9o1pWP8LOFPKHFm69/VKBn9Xa
 LmjzRmxLzQQFKzjdkyBMykJPPtLXklIcDp3AXR2JXGLfmCOmPfIfp4Sf+nOcaGgaONfJ
 yNXbL6oePZRsjGciYPck1xvBy3kXxfRqqGpqVW5IL4ElchXUtQ7Bc4p3NL1N4AnNDP7d
 uSZA==
X-Gm-Message-State: AOJu0YyvV2I3mS8ytofhqEv//84wNfKS7YWjOgi0RTegbXIsC3/I0wnB
 QR9KH/PyGpQVd0JOf4kpB0OZxjljgd72Z6HZvvuQg0SmOWS/wmz0+Hoy
X-Gm-Gg: AeBDieuxZM2qofTZqhKxmRlUJTTp4qvg2nlYtEj83bU3mhx/YNGYwOWTE+ZzgVsoInn
 vIw7c1zaJ7EtEZrUKu2Cy33BPh0UR2ZKKgmdHeR9lzH3OfBMd1n5UoEjST7yrEGjPJLqf7/QHK3
 u2m1VaYV2V02m02PGVoeMKSejdgSmHKxJ7yUJn/BzJgqP5h8PAj6jqLkdPJDlqn4FYrQBHrtsWb
 pVqTnwinxILPCAf4+MWzN4dqycT8nPkgsDelS44CaAynVhFiw30XyfkKinwWshNl/0tCfl5yOC2
 NncWVvGYFag6v4aKwxRaqDpmGZ3e8b2P8pRQsAQtBWim5Ykp7MlBmMFSFGzFZuLISML87CI1+3/
 OWECS0jxlg6eQfwmQdK8IqYSJs3yMEYGNi9xqmCaHialdxlCG1rq5feWCbO6lqVBW7scik2fISv
 YhQNn1QaKr6lU6tVv0+5k/9fS6i3bW9isqEimJU3s=
X-Received: by 2002:a17:903:37d0:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2b9f252f85emr49013585ad.5.1777787592888; 
 Sat, 02 May 2026 22:53:12 -0700 (PDT)
Received: from vini ([2401:4900:8fcb:edbd:7155:edb6:dac:107e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae58906sm64894705ad.74.2026.05.02.22.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 22:53:12 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH v3] drm/amdxdna: fix pinned_vm accounting and error handling
 in user buffer pinning
Date: Sun,  3 May 2026 11:20:24 +0530
Message-ID: <20260503055258.643546-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502031746.621606-1-agarwal.vineet2006@gmail.com>
References: <20260502031746.621606-1-agarwal.vineet2006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

amdxdna_get_ubuf() incorrectly accounted mm->pinned_vm using the
requested number of pages before pin_user_pages_fast() completed.

Since pin_user_pages_fast() can return partial success, this could
lead to incorrect accounting and inconsistent cleanup on failure.

Additionally, the RLIMIT_MEMLOCK check was performed after pinning,
allowing excessive pin attempts before validation.

Fix this by:
  - checking RLIMIT_MEMLOCK before attempting to pin pages
  - handling partial pinning correctly and ensuring proper cleanup
  - updating mm->pinned_vm only after all pages are successfully pinned
  - removing incorrect error-path accounting and double-subtraction

Also fix missing rollback when dma_buf_export() fails, which could
leave mm->pinned_vm incremented without a corresponding release.

This ensures correct pinned memory accounting and consistent error
handling aligned with other subsystems using GUP.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>

Changes in v3:
- Fix missing pinned_vm rollback when dma_buf_export() fails
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index fb999aa25318..efce6b94fb0c 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -129,7 +129,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 				 u32 num_entries, void __user *va_entries)
 {
 	struct amdxdna_dev *xdna = to_xdna_dev(dev);
-	unsigned long lock_limit, new_pinned;
+	unsigned long lock_limit;
 	struct amdxdna_drm_va_entry *va_ent;
 	struct amdxdna_ubuf_priv *ubuf;
 	u32 npages, start = 0;
@@ -176,18 +176,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
-	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-		XDNA_DBG(xdna, "New pin %ld, limit %ld, cap %d",
-			 new_pinned, lock_limit, capable(CAP_IPC_LOCK));
+
+	if (ubuf->nr_pages + atomic64_read(&ubuf->mm->pinned_vm) > lock_limit &&
+		!capable(CAP_IPC_LOCK)) {
 		ret = -ENOMEM;
-		goto sub_pin_cnt;
+		goto free_ent;
 	}
 
 	ubuf->pages = kvmalloc_objs(*ubuf->pages, ubuf->nr_pages);
 	if (!ubuf->pages) {
 		ret = -ENOMEM;
-		goto sub_pin_cnt;
+		goto free_ent;
 	}
 
 	for (i = 0; i < num_entries; i++) {
@@ -196,15 +195,17 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 		ret = pin_user_pages_fast(va_ent[i].vaddr, npages,
 					  FOLL_WRITE | FOLL_LONGTERM,
 					  &ubuf->pages[start]);
-		if (ret < 0 || ret != npages) {
+		if (ret < 0)
+			goto destroy_pages;
+		start += ret;
+		if (ret != npages) {
 			ret = -ENOMEM;
-			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
 			goto destroy_pages;
 		}
-
-		start += ret;
 	}
 
+	atomic64_add(ubuf->nr_pages, &ubuf->mm->pinned_vm);
+
 	exp_info.ops = &amdxdna_ubuf_dmabuf_ops;
 	exp_info.priv = ubuf;
 	exp_info.flags = O_RDWR | O_CLOEXEC;
@@ -212,6 +213,7 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	dbuf = dma_buf_export(&exp_info);
 	if (IS_ERR(dbuf)) {
 		ret = PTR_ERR(dbuf);
+		atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
 		goto destroy_pages;
 	}
 	kvfree(va_ent);
@@ -222,8 +224,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	if (start)
 		unpin_user_pages(ubuf->pages, start);
 	kvfree(ubuf->pages);
-sub_pin_cnt:
-	atomic64_sub(ubuf->nr_pages, &ubuf->mm->pinned_vm);
 free_ent:
 	kvfree(va_ent);
 free_ubuf:
-- 
2.54.0

