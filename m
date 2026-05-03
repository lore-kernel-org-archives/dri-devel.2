Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C8FFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A6D10E984;
	Tue,  5 May 2026 07:12:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A4fD7zzJ";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEFB10E0A4
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 04:43:35 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3651fa24c6bso380070a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 21:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777783415; x=1778388215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrHQKdnz194dJR6cw9s2lksjM+dXghqleIL2qZmETl8=;
 b=A4fD7zzJLbGAXgyYzKUz8+GxtuohTUfEQnRD8y+iPLyexnEc8wKVj0cpFTj4HYlvxH
 2RCU6wD698WWO6OgsFrui1o9i0apuHSxgO89hLVWBbCQjQTOkUOc2u3jko6f5tmvMJwV
 ZJBHVM5w/DfCMQ6bJpPybzfZy7sHcX2meibi+/fgNWL8ZC5hbzGFEnYHRF8nHUeAZdyO
 8yhjRSzFgtqWZ9D5lYG2JkuKlhxd1+WkILGFO9S2En4aj6jnZRBNB1urVXeWrM2RbB72
 qotAVBlHDghLR1hca989wttdk+HGBCmA5U1hEtgs9b6wqnrcLt0hHLgAo6wkkGPpZbeB
 dLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777783415; x=1778388215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrHQKdnz194dJR6cw9s2lksjM+dXghqleIL2qZmETl8=;
 b=HV4jkEobUQfCa9NmFcWBiOXUFPhbcnKj5p7GFPLqD0uNvjc7Z5wPJY3voVmJvvmnrr
 YO+V+uc0caVGxNXOF0zvgHVF2VWrB+KNq8fyiwbM4cXf3JDRKRxbigjE37izTWu7RDin
 ApwwNvCa8sfXegUFSK8iAPuMlejYQ+ihTfegy7slEdyRepDcJi+hw+EJrytbPKI6RMT9
 0jPekq5fmbmC1doyjSaLfrXadV1LGDUE7oiORXLCohrcy8+vGOaBfJWvyeDndOQYGXH7
 5L91CcHAuAhQo9KFOG5ae01zG4K9qdR6SrThVJ9OqcQADlmMID8zm2yaT1WOlNrpcfRX
 igvw==
X-Gm-Message-State: AOJu0YyZ+3jIC0f7eQGh1mJawGZk/fsQJetrPpG/hcxnokVydvb5laqt
 e60G8Ogporgj5udMi1hhricUoQVdN5BL2f7wnh6j9TP8yDw/1sqWbIaQ
X-Gm-Gg: AeBDiesNz21s+yl3XbrDGfCyCTd9VR9i96UVSpfgnHbaign725w18UtLdQadjNrJpa8
 ynA6KqV+MAKWpqJji4hv8Svc4F+AjEGt8+QM9Hq0dcnBLkJIZdWMvyE4JdZqPaOWLy7j2JsuD+o
 OUn+qJZXZDqBULese872ziT1F3vT8AbZ7iT//pmCSD5feZuplVE/NlpUkotz186tCXwvbSQBF5R
 vN40I5m65OhmK4Mn7RXA96Euosld+pRqA2TYjSZ4f8CozRaTbAZeQZN5B0UiPlX8yD9TiRwhkCH
 4RSNOc/ZRLKF/qOcMyiP1IUlByd0PSKsvq94egewJspP1E8YgInJhs0mgV/UapF/XC1bKHQJB2F
 GUwio6VZKbaFZ+Thbld4CFl3wZUfVXW0vr5zfZn2pfNzrRn3aXRajaGLI1bPH9/D5FiKs8BegL9
 gtADqWDowzZMQ7/Cm12gWeb1r0FRU70lSNLDiiI6M=
X-Received: by 2002:a17:903:2f4f:b0:2ae:504c:ae8a with SMTP id
 d9443c01a7336-2b9f25886e9mr47829725ad.16.1777783414557; 
 Sat, 02 May 2026 21:43:34 -0700 (PDT)
Received: from vini ([2401:4900:8fcb:edbd:7155:edb6:dac:107e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaf0e5sm64532745ad.18.2026.05.02.21.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 21:43:34 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] drm/amdxdna: fix pinned_vm accounting and error handling in
 user buffer pinning
Date: Sun,  3 May 2026 10:10:30 +0530
Message-ID: <20260503044321.633137-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Additionally, the RLIMIT_MEMLOCK check was performed after pinning,
and error handling for partial pinning could lead to inconsistent
cleanup.

Fix this by:
  - checking RLIMIT_MEMLOCK before attempting to pin pages
  - ensuring partially pinned pages are properly tracked and released
  - accounting mm->pinned_vm only after successful pinning
  - removing incorrect error-path accounting and double-subtraction

The RLIMIT_MEMLOCK check is performed conservatively against the
requested number of pages to prevent excessive pinning attempts.

This ensures mm->pinned_vm remains consistent and aligns the driver
with expected GUP and memory accounting semantics.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>

Changes in v2:
- Move RLIMIT_MEMLOCK check before pinning
- Fix partial pin handling and cleanup paths
- Remove incorrect pinned_vm accounting in error paths
- Ensure symmetric accounting between pin and release
- Drop unused pinned_total variable

---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index fb999aa25318..571708f78cfe 100644
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
@@ -222,8 +223,6 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
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

