Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF6C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B128810E9DC;
	Tue,  4 Aug 2026 12:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="X0WvsIfa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D1610E9DC
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=taQNLA8VzPi8pIAuKLKHCaHnQR8Qtlo0OLpkQO4wnlM=;
 b=X0WvsIfavVdgViM1FvREfpxRqHoa3+fdfZROsNo3haflABF3PdxgTJ4pqm1ACSyk++ioav
 aD0wu0x3NJ3lb4GDDgwedfilBiUnjrN7V38V2TzNN4QMhKxXovd8rpwTsoOwExK4jc9vl1
 uR6RvQAcWg/ptbACvXLabB4EPQNvhCY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-bagFUh8pODyxVd4jwW1HIA-1; Tue, 04 Aug 2026 08:05:39 -0400
X-MC-Unique: bagFUh8pODyxVd4jwW1HIA-1
X-Mimecast-MFC-AGG-ID: bagFUh8pODyxVd4jwW1HIA_1785845138
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so1460905e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845138; x=1786449938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=taQNLA8VzPi8pIAuKLKHCaHnQR8Qtlo0OLpkQO4wnlM=;
 b=D6fd/ViBm31HmR7blbw+lZthETHtVUX6uyujpR8mluF0gWvUmgCNuBKgtW3HK8hGfc
 /1H1PJVDQpisrqTyzeRtWQAOQf0uaQR8qLRgD2/McVw/uQ+Bs34ypPRjy9UNXjxHmlOd
 yagW2XwytjbT77tlhSSR3O6dk0skf0tqVsXrc90aeL0anVxWHwKBUDc3n/lumBaP9dcK
 M0nBKJERjZKW12JvADWkAvtHLDcC7Ap43vaw4CdikUEeoQfqCp0I+luHWpFd9BsJN6uy
 pXOGy6DNBdfUm4L5sTt+V5uPk6h3gagthm/6BydvnYfmajHmVKnG5HQsbU/mk0NbyfLT
 0zoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+HFXFRQLwlWqDdVdYfpH6FeM7LsPulRk4b/umCvlRPALLhivprCGisMwwgrRwUc0sIBtz5xfx6qs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEw0jNxulKBom35Eiiv0fH/WR23RiwQAskLA1tTWqrrcLWbTLs
 cmhm/fX2JdIhhhfxHkBU9RYJOKW0sU2Irta8i+bGXift84wM8Fc+olUISkLMUSxSbMavBnhf0Nq
 UFdKgkRBA1kqZD7zrZd1XHNaz/aqMMAlWu2Xe1bMuW8vTC56gj+CuR5dSNQy4p2VCCJ7MYg==
X-Gm-Gg: AR+sD12WIbISq37k/uWkdPixaHW2kRt15ErhPsYpufC9g2AkCtjT3EP55AAMyjwgyhZ
 hOJSijA41kKtZVXHrveoBLZzWPJUzQAtTV9as6hInDdUUtto6FbA6vbd5yWaNmHv8lBxNMvM6Hn
 0MmZ0pSzLDkLk0loX9d+WYVaxZlMbMPtqLKmq2eq3il/zkS0FwxwGEqg8+14OT7BXhwN8HFQuEk
 AlgwdpfRZEKG9nx+oEIvdekST74ceifBVMNnJPPiImRBU+EPkGDG65qvyiB+npdOzFuTiHAgqVh
 LhZ2rV7K9hsThUYiy2RfWcQHnBnufHHzgPxCeC+nQmI4jhiEArYg0R0r/mq3W14/3ZYqfIs1+nY
 aw+ZDkHvztXlW88x+YtVZYw3jcyaUjHWcNyoruHVUZ+NRCTFfTRbmBTXRmYILfHV/X8FqLjrkRI
 ela5Y=
X-Received: by 2002:a05:600c:6298:b0:499:484a:7644 with SMTP id
 5b1f17b1804b1-499484a7693mr122467165e9.9.1785845137697; 
 Tue, 04 Aug 2026 05:05:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:499:484a:7644 with SMTP id
 5b1f17b1804b1-499484a7693mr122465915e9.9.1785845136990; 
 Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b8d04fsm453070475e9.3.2026.08.04.05.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
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
Subject: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Date: Tue,  4 Aug 2026 14:05:24 +0200
Message-ID: <20260804120529.1730187-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4PYzvMPu4RJ4Ait1QwyEsQR_SZd72eV2k2gtkxcXtQ_1785845138
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

This ensures that KVM or VFIO correctly see a writable PTE when
they request one.  Otherwise, a guest write to an unpopulated
PTE from a mapping backed by a DRM GEM BO triggers a VM exit
with EFAULT.

The code actually is simpler, because the same logic already
applied to the hugepage mapping case using vmf_insert_pfn_pmd().

Reported-by: Sergio Lopez <slp@redhat.com>
Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/
Tested-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..c81be3e97317 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
 	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
 }
 
+/*
+ * Because the vm_ops have a .pfn_mkwrite() callback, vma_set_page_prot()
+ * has cleared the write bit from vma->vm_page_prot.  vmf_insert_pfn()
+ * would install a read-only entry even for a write fault, relying on a
+ * second fault to reach .pfn_mkwrite() and upgrade it, but that second
+ * fault never happens for fixup_user_fault() callers that directly
+ * walk the page tables with follow_pfnmap_start().  To ensure that
+ * they don't see the read-only entry, pass FAULT_FLAG_WRITE info down
+ * to install a writable entry right away.  Because .pfn_mkwrite() is
+ * not invoked, record the write afterwards.
+ */
 static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+
 	if (!order) {
-		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
@@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 
 		if (aligned &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
-			vm_fault_t ret;
-
 			pfn &= PMD_MASK >> PAGE_SHIFT;
-
-			/* Unlike PTEs which are automatically upgraded to
-			 * writeable entries, the PMD upgrades go through
-			 * .huge_fault(). Make sure we pass the "write" info
-			 * along in that case.
-			 * This also means we have to record the write fault
-			 * here, instead of in .pfn_mkwrite().
-			 */
-			ret = vmf_insert_pfn_pmd(vmf, pfn,
-						 vmf->flags & FAULT_FLAG_WRITE);
-			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
-				drm_gem_shmem_record_mkwrite(vmf);
-
-			return ret;
+			ret = vmf_insert_pfn_pmd(vmf, pfn, write);
 		}
 #endif
 	}
-	return VM_FAULT_FALLBACK;
+
+	if (ret == VM_FAULT_NOPAGE && write)
+		drm_gem_shmem_record_mkwrite(vmf);
+	return ret;
 }
 
 static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int order)
-- 
2.55.0

