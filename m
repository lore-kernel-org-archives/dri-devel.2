Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF98FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4185B10E98A;
	Tue,  5 May 2026 07:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTWf5Hh8";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED6410E0A4
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 04:49:49 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so18260105ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777783789; x=1778388589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrHQKdnz194dJR6cw9s2lksjM+dXghqleIL2qZmETl8=;
 b=gTWf5Hh8boWVtbnL7+xD+pdn+SzW7xhH50znjbeCX9+t9hbkgk5AoLLc65fJCpPpo1
 wg/NXRU3Z/XWEY63vAlpZ/cAVGTyyB7LO2SeFzfxamOplV9ti7lzrbtDwdHh+FnZiXHC
 P7RXMvKK/knz0b6kXI98pGL699poW3shA6OQ/GAbFaGZrdNdA5MXpLGCkS1x0ej4D/J6
 EXvq+rGgaEAaU6X/nnyFktUMX78WVu6jrqWKNQ+rQJT6jNC/UHrzjgMooX0pSDYUSghU
 HB1aPFePtydEANPyEB5Dh1RdCEQBgTukjEd83lk/EJtLpFsZ/cZogpp5DzgXn3677OlT
 IgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777783789; x=1778388589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZrHQKdnz194dJR6cw9s2lksjM+dXghqleIL2qZmETl8=;
 b=Tp1WYvtIsnSpoJEf0guDuHy56deNqQ5YD3siA374GJakvjOKuRUEhx25KE8qwGN1Xh
 FSlssw7wpsK6pZyPqhjm8AMqNnayZrxHpwLjAuvZm64A4WqhzNstmCMn6FmIIk2THjSS
 LQmr43ETH1Lt2/tpsr/xg7J2bLjlT6glNKhstmGBAJ331oEZ7XZ63v/L0ihozFPonnY7
 e+giaa871obxEDDp40cqQuRhG66gOEcV2yUnAighn0CkNSJ/2Z9CPPYZ/qOw4hi1jyx1
 DY/ku/gHHWvG3jycM9uN1AEbQW76H2rlyGFEZOxsPqu5CqOz0lhsIb/4zQIzMjR4827S
 d00Q==
X-Gm-Message-State: AOJu0Yzii1L/b1DfFbgGMIo58RdyIMG34aqmtnbRIJyAGtVf1+5TP8/x
 pbfl7GvSfc6gonKSABLuNtwp+zSSnIdZOeouVrSCzvjKtP5C+v5tfQVf
X-Gm-Gg: AeBDietY+3O+66EQTJNvbHJ0bZPMp8TlqifBHj8NFId3cs+oxkpLorhwdUnJ12QLLSL
 cL6j2HfNoWtxrBYgFXNaDG2Djvq2iybsS8K7O0YwIZZUWZBiD6cRBTxMIGw7uc19WiqDZr2o+zJ
 d0fHTP7yCJmio9ASxHlksJ5ffCrccbgLN3jp+ePG5fJV6xBWZL/QC+HB9YBVN2bMDjMXZZCW3ui
 l4DaXvwMv3wVvlWmjbWHa6KnRemqUf2qZ7fxu3jL25eIXkGPR+xxGpBLFEEx2IDkoYS4aJEY9/7
 nKiAT/bj5ZxLxLWlT8NMlJzjeeSn31PMvoicfHcGbZM9bU4htLgQINWgUaWFJ9c8vDhofwDFD3h
 +x37I1LQZKk1JSOyu00Ho5qT4rm+BNmZd2wG9JfWOXy5ZwhOtIFP8hYA2S2/wlOme/9qEQvhvga
 Fo41AcWC1Q8ZuiI45NfEum4l6F6iWceKF9ROyk+ZjuuJHKaLLL8A==
X-Received: by 2002:a05:6a21:e098:b0:398:b346:b13 with SMTP id
 adf61e73a8af0-3a7f1a71ce3mr4874859637.16.1777783788697; 
 Sat, 02 May 2026 21:49:48 -0700 (PDT)
Received: from vini ([2401:4900:8fcb:edbd:7155:edb6:dac:107e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b00b28sm7011337b3a.42.2026.05.02.21.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 21:49:48 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] drm/amdxdna: fix pinned_vm accounting and error handling in
 user buffer pinning
Date: Sun,  3 May 2026 10:19:27 +0530
Message-ID: <20260503044931.634219-1-agarwal.vineet2006@gmail.com>
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

