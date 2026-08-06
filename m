Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A9C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E7010F0E2;
	Thu,  6 Aug 2026 06:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=xbow.com header.i=@xbow.com header.b="RYZtimry";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673D210E167
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 03:44:02 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1187325a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xbow.com; s=google; t=1785987842; x=1786592642; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2jLtToL3PwaTAhWfeLF+tyVqbdrghdAzA8d8sJ1FHuA=;
 b=RYZtimryscbkFPdXS4nE6T0oeJi1i2QLMG3jGSKOzOQlnteT6Dgtx6Weaq50otmIBH
 m9Y/ltQDKhoMkDF833YI1a3pClLd+6blttYoZ8+iITzdJYYd9x6G//ts1k3fik0Vo0nP
 Gjh47/ENoah58KC9u+KpF26J/BixzNa2K5gyVypdI8Qt9urQon21AhMbpgUGxZUk+ELE
 9wE6E2CVA+D2HgTMy8MniXFUysEmxUM/q/4hZ+av9PbK17EJ4FMkVmnP7JiPcJQs6Ist
 u+ik5RsWoBdwhG1SEWC600b6SPixxGnCo+zjJrpoo5NbOja2KEd7MNZpCrQCU46PbjXB
 kbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785987842; x=1786592642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2jLtToL3PwaTAhWfeLF+tyVqbdrghdAzA8d8sJ1FHuA=;
 b=MZaNR7xeMBG9MapIqcVLg6UpMrGzK0B4cP4p8zBxlpQw8dht2hANoxl3Tt0m4AzkPx
 b0YU8+HkHsVhtCUnmX9TI4JD8C00JxdX/Ej1YePy6UBaXkUhZZu2mt1DGcydg04j+c0O
 UU2WGDZzm6ASeWSaGGG1V+odbmjYfyJAIV34hqand35rFfJs2qxao6MBwlH2kIxAe39s
 +8OYY4TkQF5uP3jdjmI9cdv94puqAyum/n5TcOqUC08XtjcmwQekWN0VJJyBVbIxUGIc
 X37AVmcdWmmM3Fixn+33TJmpQ4iW+WbMRIv3QobVa6YBsXf4c994EEDeAKQ3wITURmzl
 0t2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpu+4Y4fu82Y7fsA4uc0/+mIcrh+wx6WhYC1ZeAtPYXX1Wqaq3Hw9lE/AJg92eAWoXdSngESb0LST4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxS5L8nVV6B1QMG2z/B+nwecCLUFZngVu3UdLTtvYmRNHlb6cZc
 sGE/O1BHr7eCDojNJUY+gcLo+VUUfs+lU/roS8UopW6qPeZjMKBWtgiJQm1EuiOrCfM=
X-Gm-Gg: AR+sD130dn8Ip+R/elwgsItywD8ZO5r5Db0eNRkyMyZtOGsaGZx+ZGVGek0tfJgxl9Y
 WoH5mcfpmTMKjWhBrvWaSm+PyC/Wfqzs5j3ExiVrR/ia6CTYHmJsq/qtaNU6OMhm+PvCXFFhfpy
 ThjVaJcFSlRHjI0TpK4Da6VGu6B847+m09jHwlDurhH4crPjlklAzaSlINnqoEq8GlA08WkWk7A
 sSgNq1j19GqKLiH/4W/8eUNpf63xlR6GHw0bbYsGJuXm3zZ2myTsqLpR53XWhhXFSwW4lbDzPay
 W4WS3gEKKQUrqwALXatXiq/2ataAPR081Y2P5V3CuHwzE7JhhITzkOFJL8IWZz97jxSEw8zw5XS
 uSRnXZnQ18maaCqwhSNtK7J9n/uDZAosK1/OsNB/x+NJsyk7/5ynemALf6c4LrF1TJR2k0tR7q9
 2iDj5rtieCh+Kg69hUrjHzGdftO7uBM46QJ7vdkQrI6A51sJSnqxcv3V19YlgTfEEastPtf9tGq
 5pLV8Z2JTeCII+387DhMUb5hLcC
X-Received: by 2002:a17:90b:2d50:b0:38f:1f8:1fa with SMTP id
 98e67ed59e1d1-3903c5ca8c2mr12349041a91.15.1785987841775; 
 Wed, 05 Aug 2026 20:44:01 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085f2c714sm569978a91.10.2026.08.05.20.43.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Aug 2026 20:44:01 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: christian.koenig@amd.com, ray.huang@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org,
 Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] drm/ttm: clamp the prefault window to the buffer object
Date: Thu,  6 Aug 2026 12:43:56 +0900
Message-ID: <20260806034356.43681-1-baul.lee@xbow.com>
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

ttm_bo_vm_fault_reserved() derives two page indices from the caller's
mmap(2) arguments and bounds only one of them:

	page_offset = ((address - vma->vm_start) >> PAGE_SHIFT) +
		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
	page_last = vma_pages(vma) + vma->vm_pgoff -
		drm_vma_node_start(&bo->base.vma_node);

	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
		return VM_FAULT_SIGBUS;

bo->base.size appears once in the function, bounding page_offset on
entry.  page_last comes straight from vma_pages(vma) and is the loop
terminator:

	if (unlikely(++page_offset >= page_last))
		break;

so the object size never bounds it.  For an object of N pages, a fault
on the last in-object page passes the entry test with page_offset
N - 1, and the prefault loop then walks N..N+14, reading
ttm->pages[page_offset] or
ttm_bo_io_mem_pfn(bo, page_offset) and installing each frame with
vmf_insert_pfn_prot().

page_last exceeds the object whenever the VMA is longer than it.
drm_gem_mmap_obj() rejects that on the DRM node, but the fbdev path
reaches the object function through drm_gem_prime_mmap(), which does
not.  It is also exceeded by a mapping no longer than the object taken
at a nonzero file offset, so the handler needs its own bound.

With a 128-page object mapped 192 pages long, one read fault at index
N - 1 leaves the fifteen frames after the object readable through the
mapping; on a fresh mapping, reading index N without first faulting
N - 1 is SIGBUS.  For a system-memory placement the page array is
over-read as well:

  BUG: KASAN: slab-out-of-bounds in ttm_bo_vm_fault_reserved+0x248/0x57c
  Read of size 8 at addr ffff0000078aac00 by task e1/219
   __asan_load8+0x84/0xb0
   ttm_bo_vm_fault_reserved+0x248/0x57c
   ttm_bo_vm_fault+0xe4/0x140
   __do_fault+0x6c/0x2f0

Clamp page_last to the object.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..14ebf6ee3c47 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -212,6 +212,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node);
 	page_last = vma_pages(vma) + vma->vm_pgoff -
 		drm_vma_node_start(&bo->base.vma_node);
+	page_last = min_t(unsigned long, page_last, PFN_UP(bo->base.size));
 
 	if (unlikely(page_offset >= PFN_UP(bo->base.size)))
 		return VM_FAULT_SIGBUS;
-- 
2.50.1 (Apple Git-155)
