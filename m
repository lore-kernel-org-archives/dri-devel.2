Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF5FC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B35010E9E0;
	Tue,  4 Aug 2026 12:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XzmeqTLe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFDD10E9E2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjD464vOIu2Voqk/KOGceV068H0b4O8GMn0RbRgTxRU=;
 b=XzmeqTLehG99dyJBe1xS2f6XA0vmWP2O3UCM95VZSd4C9AiQgudVJk3D9IeptCa8bIUe4e
 wHsmO0/BYENKVOdXJpAXlr1Mqsm9wXhKjgAp46oLAjw1BEnMYG4iUpHkG5WDBi+1CIIxFo
 leepOMS1YHsnGLaJ7E0vonNlFoqxuUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-tQ1c8JUfNJiMIOsqWrbjxQ-1; Tue, 04 Aug 2026 08:05:44 -0400
X-MC-Unique: tQ1c8JUfNJiMIOsqWrbjxQ-1
X-Mimecast-MFC-AGG-ID: tQ1c8JUfNJiMIOsqWrbjxQ_1785845142
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4957287363bso20063675e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845142; x=1786449942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tjD464vOIu2Voqk/KOGceV068H0b4O8GMn0RbRgTxRU=;
 b=dcuhF4HoqDmi9M7IRGDo3lKXIRIJIBmMSpAxO/0S7B2Fc4QaplbM7TLYHX68q9+a78
 ArfYUbwHv3dVzPfykTtvkEUcIgotZoCStge61LCOZjc5nMGWYKNmM5NBonwEhIP1rXon
 B3JNVNNr2G134vee+WOulbvHoGkLQMB9AdCEbjKjy/5vJUmENu2Ajz1qSfF5/TTDC/rw
 LPmy8mS/BwXMRXY9+z5sgKZIlxmq7w53j6uK8/nLwrvi5efKqyfelHeUTuMIL6LpAU8Q
 jaP+3rhzLFYQh2Svn8JDO9d4Z/036MiSXppSvZNxep6R4keppSXBdogIfYk5xS8W/6Xh
 dNYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RriN1Gyo+mNNK3G5gT86nuVlvAJHkWECYppPB+NcHBhCttOGv6l9MuJIXH2MIQ2RNr1AODPaTVCjeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEUN0AqjBywIum9F6I/+22LUQHIAAcOWtpWkqOs58nC1FFxef7
 M+09maAcq10LZHpnkNOzHUswew6rwF0bOFzdsRfCdmweGkZSXbOTVFOKYLjRwv0or8wx3mGcUbl
 DPqNhwiFjyRh2J948EjRronruRAZHrYORP5Z6r2wbkk1hvFT1fKaL1glGY8E2cT9Ki7bxyg==
X-Gm-Gg: AR+sD10xpHIVG/K84iUL0w+z+SlwkoFqEi5M592AF8e/ZuFoZCmNxMoENGS/KqYP4YV
 mcHcKYT/2ZE3IQNAPj2Dq0ETSYfquT8ANnpKD+s5+RxpU9/GA6rsfcPqVzjNoQXH8NISWGx/S5T
 xsV/0I/bnM3dpusIGb67y+hlBoollpffQWwCut7zyT7pPix+s2Ues5oeDXwg9om/kH0J2tmNBzW
 sX+3M9whha7vMd4nbcpfle8J1B0JeOmGcwkQ5CZES/BxYpR/PsLZu8NSf+DswbtqYE0P1bprtCb
 k77bLn/u5+NAluIXvLACVnKZdYgPU+FMnl1akjr1t6Ze9oUAC3OUQc5/rmacGibev7XyulMe+7Q
 ctqBYKpOKeK8mvO4m0ZOlDF2nSynOf0oj5hAgl++ZCkYbWG/lYqrU1TRAcf8vl8oeJrIcDkAf/9
 PpIbY=
X-Received: by 2002:a05:600c:c8c:b0:495:4589:707 with SMTP id
 5b1f17b1804b1-4980c6452f7mr312396155e9.5.1785845142102; 
 Tue, 04 Aug 2026 05:05:42 -0700 (PDT)
X-Received: by 2002:a05:600c:c8c:b0:495:4589:707 with SMTP id
 5b1f17b1804b1-4980c6452f7mr312394755e9.5.1785845141410; 
 Tue, 04 Aug 2026 05:05:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2ff6sm79768615e9.1.2026.08.04.05.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>,
 David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org,
 Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH v2 3/6] drm/ttm,
 drm/vmwgfx: directly create writable PTEs when mkwrite is in use
Date: Tue,  4 Aug 2026 14:05:25 +0200
Message-ID: <20260804120529.1730187-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zC7b-RlkuiTL1P8l-X42SH6GCTLeSBBEepOB2dOphuU_1785845142
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This ensures that fixup_user_fault() users see a writable PTE when
they request one.  The flip side is that vmw_bo_vm_fault() now has
to record by hand the write fault, because .pfn_mkwrite() is
not invoked.

Prefaulting works as before because only the first entry comes
out writable, while the following ones still end up executing
the .pfn_mkwrite() callback.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  7 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..3ebde936ce60 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -191,6 +191,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	unsigned long pfn;
 	struct ttm_tt *ttm = NULL;
 	struct page *page;
+	bool mkwrite;
 	int err;
 	pgoff_t i;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
@@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
 	 */
+	mkwrite = !!(vmf->flags & FAULT_FLAG_WRITE);
 	for (i = 0; i < num_prefault; ++i) {
 		if (bo->resource->bus.is_iomem) {
 			pfn = ttm_bo_io_mem_pfn(bo, page_offset);
@@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
-		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		ret = vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
 
-		/* Never error on prefaulted PTEs */
+		/* Never error on prefaulted PTEs and never map them writable */
+		mkwrite = false;
 		if (unlikely((ret & VM_FAULT_ERROR))) {
 			if (i == 0)
 				return VM_FAULT_NOPAGE;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..3099558c0762 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -398,15 +398,33 @@ void vmw_bo_dirty_clear_res(struct vmw_resource *res)
 		dirty->end = res_start;
 }
 
+static vm_fault_t vmw_bo_dirty_mkwrite(struct vm_fault *vmf, struct ttm_buffer_object *bo)
+{
+	unsigned long page_offset;
+	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
+
+	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
+	if (unlikely(page_offset >= PFN_UP(bo->resource->size)))
+		return VM_FAULT_SIGBUS;
+
+	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
+	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
+		struct vmw_bo_dirty *dirty = vbo->dirty;
+
+		__set_bit(page_offset, &dirty->bitmap[0]);
+		dirty->start = min(dirty->start, page_offset);
+		dirty->end = max(dirty->end, page_offset + 1);
+	}
+	return 0;
+}
+
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	vm_fault_t ret;
-	unsigned long page_offset;
 	unsigned int save_flags;
-	struct vmw_bo *vbo = to_vmw_bo(&bo->base);
 
 	/*
 	 * mkwrite() doesn't handle the VM_FAULT_RETRY return value correctly.
@@ -419,22 +437,7 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
-	if (unlikely(page_offset >= PFN_UP(bo->resource->size))) {
-		ret = VM_FAULT_SIGBUS;
-		goto out_unlock;
-	}
-
-	if (vbo->dirty && vbo->dirty->method == VMW_BO_DIRTY_MKWRITE &&
-	    !test_bit(page_offset, &vbo->dirty->bitmap[0])) {
-		struct vmw_bo_dirty *dirty = vbo->dirty;
-
-		__set_bit(page_offset, &dirty->bitmap[0]);
-		dirty->start = min(dirty->start, page_offset);
-		dirty->end = max(dirty->end, page_offset + 1);
-	}
-
-out_unlock:
+	ret = vmw_bo_dirty_mkwrite(vmf, bo);
 	dma_resv_unlock(bo->base.resv);
 	return ret;
 }
@@ -484,6 +487,9 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 		prot = vm_get_page_prot(vma->vm_flags);
 
 	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
+	if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
+		WARN_ON_ONCE(vmw_bo_dirty_mkwrite(vmf, bo));
+
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
-- 
2.55.0

