Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496BEC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2ED10F352;
	Fri, 31 Jul 2026 16:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="foMy23FL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A59610F351
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785516235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKIuXVAQxBinLsqe2l2r/I0mxnjKp1xskcVhmjIrGQo=;
 b=foMy23FLN3S3WNljfDweWwCDlQpq63XwsEWlWvM/MF8TeXFj2lbxATv9+in/TVHWPeX6N3
 WTJKpgvPlBIsvj+nanUlYvpMTDJRwolGTWK2PLWRPzfQjScaOzoZYzFWpDU3fFQUzAINT4
 9bhUBrkYowjywVrN5W/Tsehoq3qiYPc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-DYNI0ukePXqleTUjaHVc-w-1; Fri, 31 Jul 2026 12:43:53 -0400
X-MC-Unique: DYNI0ukePXqleTUjaHVc-w-1
X-Mimecast-MFC-AGG-ID: DYNI0ukePXqleTUjaHVc-w_1785516232
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-698a99b6140so1372180a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516232; x=1786121032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rKIuXVAQxBinLsqe2l2r/I0mxnjKp1xskcVhmjIrGQo=;
 b=JrXuZ3HlRQi3WsTj11W8aEdl/xo7qmfHfvcDI1lxEbs+uSA0cKt/bV7380tq787Oee
 sqDetnv7txG3+Zdm2G79YEspB3C0P3nknxw0gt9wv9qF4tZMG9kguHLJ3gimt7TmKHqf
 2Lhbpv3tZfY7UmTG1iYLlBY+PzYVvpDz+6r7+RociKzoltg4PIiuM5Do9vN8c3Pd8lEI
 sran6JfLOkWz7UxJjPaJ3u1LvYYEPbdC31l4/V5Zhy7VvFC6J+RcNq0bdXOvorAIpO8c
 WOUrfcJ22wKLEO/3juM9LGZ/nBaIFikA+WYkGAwpr25fra7hnzXx2ufFfhrQU+pZU7uv
 fITQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqZDF6Z5ZgjHICnPmUYgdhJoyC08rVhKsQSWP+hOE/t0Ae/tbtX38UFfojgVXhUcZF1x4N63eN9Rw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0OIkkQlzAnqU0POnwzT37+HbvgM15fgNzZ15g2i8cROIQ+cg2
 f/tHOnycQYkh2uI5h/Ll996jFJnAMr0Sl0B26LA1Gp31+qgUcdaY++Qa9OgSqLQmVj+DYt3LQod
 mXXSEyvWJL6uJscLdUpofurDpj71X1sz4m8xrBSreDHPIVL/naqCNZ+WyQOiz9D2i+1H91JXjma
 bqgw==
X-Gm-Gg: AR+sD10ORthJaHIjQKx8kVPrNvkGbUFuLEqJkpvFKwQ7SlJN7PKEfBsJSIP3wFzyOG0
 Ee7ACQTxmJQjeSfrqwVtdfBg2M6TBviZSRd/+tu1h2ANO5Muq1rzIfiZY93EUpqHoQq8hIw8m40
 cirqE3eOYas6MgInqaMTZtqxsURu0oTTCiDAZLBPl/CMWdtxXV4YWZEIsFy9I6HR+cA8JxaA4s3
 YRUwuodeH4t9ukxv8CrjzSqbq688EvjnlLi5hrbvZT11twfXMTqbjkO9A2/hb9fP27+ihyNJqIe
 bhYucjFLZ5EJUqPXaXFsYa8INmtnrbyjyu4J5C4admsj7Xj8F9Kkp1fRFgTk5uHAF2meVmToOgJ
 AG1kdgZyvRtoBgPcpXyh5pPTUKR0KK0y2aA8pgYJGyZTDSB18q/JqnXBvF/KXPwpdX+LcwxOExI
 CQXUc=
X-Received: by 2002:a05:6402:548a:b0:6a0:923a:cfe7 with SMTP id
 4fb4d7f45d1cf-6a0a7cf5cf6mr192234a12.37.1785516232526; 
 Fri, 31 Jul 2026 09:43:52 -0700 (PDT)
X-Received: by 2002:a05:6402:548a:b0:6a0:923a:cfe7 with SMTP id
 4fb4d7f45d1cf-6a0a7cf5cf6mr192219a12.37.1785516232159; 
 Fri, 31 Jul 2026 09:43:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c5a0556sm2582577a12.5.2026.07.31.09.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:43:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH RFT 3/3] drm/ttm,
 drm/vmwgfx: directly create writable PTEs when mkwrite is in use
Date: Fri, 31 Jul 2026 18:43:41 +0200
Message-ID: <20260731164341.1109827-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BCmadSbh0D8EPwsigSZZxDyBP3BS3_miWBD3nXYOLeQ_1785516232
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 42 ++++++++++++----------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..ef27a2d7afc0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -263,7 +263,8 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
-		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		ret = __vmf_insert_pfn_prot(vma, address, pfn, prot,
+					    i == 0 && !!(vmf->flags & FAULT_FLAG_WRITE));
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..2cc490e7d758 100644
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

