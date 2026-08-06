Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B556AC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60ED10E298;
	Thu,  6 Aug 2026 06:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xbow.com header.i=@xbow.com header.b="aozPnEvJ";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4401110E167
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 03:43:49 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso16529905ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 20:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xbow.com; s=google; t=1785987829; x=1786592629; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lB3t5AM9S8rNfa8MkksIa6QuMH30IsZNuofW0zacyos=;
 b=aozPnEvJnAEYAQCdu/ZhzgLAVbBfoeOQl0orqjwQkruIcbIQY89ubxWk1HjeQlq89C
 in1pSSsBHmM5aRnTXoZpNXsnBk9DjZk/0MtIQl6I/TXAn1RaiHNk04ThkRbOLK86zLII
 YnyjuyTIbOVHGhlX4RIklXS7lRmjYzWj43qgQSjVnXIjwP229Y2qCsjm3vpSECMFpZw7
 B+cjE5tmQkQbDHBoS35CECe2L9etV3VHkXkWCCkcsgdzyESoNEZuGtoyNoByoDpKOMK5
 ao0xwLUyPtPra9PWCNy+Qk2GAoq6+MsFfOpCt5bpfIhc4v6eZoj4UnUdstxzVZ7Mc1EZ
 QA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785987829; x=1786592629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lB3t5AM9S8rNfa8MkksIa6QuMH30IsZNuofW0zacyos=;
 b=IxW/fKmALl18LJzHhGh2mjF/nLHRUwiGzd3aLPch04nwVuqjtged/6p/GYoyPY0J1D
 XrUvLsZsF73i3crUcYfjksnhgXzyn26WyfQU17nlAC3gd0XRlR7RP9QpM1B97948Ye/N
 tiAGlU/C+RaQXfcgCj7NC9fIlRZDHZb2uvsCEKvIBc+4s7EG0iXaGGsJtoxGFgtcrQSB
 wbkMr0yB5MeJc3ySt3X/QFRSr+qzg6IVtUrKbw+GSJ71gghT/XImqPwplP0Sc8M1X6gZ
 PW+kwbtac+SdjLPVYm1k7rSLR+kp7+Gc2bXhQDwdCG8PqypayQF26YPnhHWVZD+8S4rW
 tZiA==
X-Gm-Message-State: AOJu0YwRD0lHPGJqi1tceHdFFGgC9fHrf/wTft1QtLfTkO8BD2y7pA4a
 A0/fweeg2rat5XjqohHHzXgj7LweAl7o/PdwVd6OpG6uSOD5XjsLHpq5nbH4sYV4cbM=
X-Gm-Gg: AR+sD11dFj7FkZ85lvOPUF9wP+HxbzNwVqm/XBG7ZSAI8Qqb3LslMPlhs34THNOu+Xf
 rWQHqjjpUQLmUF1hDYmZtLqxsky5LXJ5EBJz+1iiiQ1R4s7V3cQD++3Z2oxwzB7eXWPOXOEb7LC
 cMolWHTo5ik3pz/mAtNduzikxftn8jt2apMltC4bkf9H1A3RPY0AE5wKJagE2HlE+OchaBfnWLC
 ObuNwxGD1m7OEWWo4fEi7qyfHykSInEZtYoEdZW5Wq2A5PfGJheFI9e3k0Um6gfSwKcOYSfqQwG
 F/c87+8K9ZYU5RHGPhz5hnkIfrGMt6DeTwh7hu5v5ZSzm2rFw/rvD8UNVv2zRb23ziDnY1UUYV1
 PsCZU+6JKFFMSZdJ2B5OvA2dhvTuaJWVboy8g1+7KrUpoH3m8G6MwkfmkFJMEgryvzQExDxOiiF
 BYl26JBNTTQEVI+BeATsSmWH49BJxYJkJrJhUvGumxYEUsM2eNYEXJMPEeFrVfC/Wp7qaFtdi2W
 /UC628E1aNOY1fUaFwEqiKkzmHE
X-Received: by 2002:a17:902:e94c:b0:2c8:4c29:afeb with SMTP id
 d9443c01a7336-2d0ca7b5520mr151674245ad.8.1785987828619; 
 Wed, 05 Aug 2026 20:43:48 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4c911esm23899715ad.66.2026.08.05.20.43.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Aug 2026 20:43:48 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org,
 Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/gma500: bound the fbdev fault loop to the framebuffer
Date: Thu,  6 Aug 2026 12:43:43 +0900
Message-ID: <20260806034343.43629-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 06:52:41 +0000
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

psb_fbdev_vm_fault() maps as many frames as the caller asked for:

	unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
	unsigned long page_num = vma_pages(vma);

	for (i = 0; i < page_num; ++i) {
		err = vmf_insert_mixed(vma, address, pfn);
		...
		address += PAGE_SIZE;
		++pfn;
	}

The trip count is the VMA length and the pfn walks up from the
framebuffer base.  info->fix.smem_len, the extent of the framebuffer, is
not read anywhere in the handler, so a mapping longer than the
framebuffer installs present PTEs for the physical frames above it.

Nothing else on the path bounds the length.  psb_fbdev_fb_mmap() only
requires vm_pgoff to be zero, and fb_mmap() passes the length through.

On x86_64 an unprivileged process in group video mapped 4800 pages of a
600-page framebuffer; every page was present and writable, and the 4200
past the object were the frames above it in physical memory.  Nothing is
logged: the kernel installs valid PTEs and every access through them
comes from userspace.

Reject a fault whose page offset is already past the framebuffer and
clamp the loop to the frames the framebuffer owns.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 0867b42113ec ("staging: gma500: Intel GMA500 staging driver")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/gma500/fbdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbdev.c
index d1e93588234f..393a939a0c37 100644
--- a/drivers/gpu/drm/gma500/fbdev.c
+++ b/drivers/gpu/drm/gma500/fbdev.c
@@ -26,9 +26,15 @@ static vm_fault_t psb_fbdev_vm_fault(struct vm_fault *vmf)
 	unsigned long address = vmf->address - (vmf->pgoff << PAGE_SHIFT);
 	unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
 	vm_fault_t err = VM_FAULT_SIGBUS;
+	unsigned long obj_pages = info->fix.smem_len >> PAGE_SHIFT;
 	unsigned long page_num = vma_pages(vma);
 	unsigned long i;
 
+	if (vmf->pgoff >= obj_pages)
+		return VM_FAULT_SIGBUS;
+	if (page_num > obj_pages)
+		page_num = obj_pages;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	for (i = 0; i < page_num; ++i) {
-- 
2.50.1 (Apple Git-155)
