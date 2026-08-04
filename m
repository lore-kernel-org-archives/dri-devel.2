Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5953C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AE610E9ED;
	Tue,  4 Aug 2026 12:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gj0YtXRz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC2610E9ED
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j37JFINyTYCydy6a1WRFKL3cyTkOscZBfjMnbKqhj70=;
 b=gj0YtXRzS7i1Wa102zgt7SuzZEre+LKsg8J4CwUsJhg7GV8HIqW9W4AJJabNt/cBPnrV9o
 7PclEPLKtbFwt+gE7CzjhDGhU1qz/8SDW5jG5EGBESQNFqf45N2Kh6DTA8XG+mhghiN+QD
 /PMcA/l30+Vf1spN42ANunDavqvoCCU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-YdMM3-PDM0-q2cLZmbNd_w-1; Tue, 04 Aug 2026 08:05:50 -0400
X-MC-Unique: YdMM3-PDM0-q2cLZmbNd_w-1
X-Mimecast-MFC-AGG-ID: YdMM3-PDM0-q2cLZmbNd_w_1785845150
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f810c8aebso2754942f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845149; x=1786449949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j37JFINyTYCydy6a1WRFKL3cyTkOscZBfjMnbKqhj70=;
 b=V8ono9F47WIvqMJDDUo8n0nsB8vY8zM9WSLvv43txArEiXSP01W+NW5AsdiM4sJgWK
 FpsWkMRxolM2lYYkA0vsM2mUw+G62GYvW4Jx7miv29NiJnKzrUygxUqtODcUpVE0a67t
 I7eaRPiIaLHrrhQx2Jc688j4gBZW/9IoiLK/Arm8ym/++akO9z3GrSGi87H6ESWSy6uv
 twANCVsrFyPIm5iKg7HlTYWYFvQHdhFEdoNsM6QKGtekCecPKZA3QIKZ9vOaDCohGfma
 /cnTwwT0Ugn9gTHmMdSiJvPSYPUOT9gpGCedKsZI75RNhpiAYtC6rcC4zTIz1836pKHJ
 /pcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+QRE2fxb6EXA1TDWqd3WEqgQuOi7Jj7j67MV+aXZotCYPufZZWPBoJIyR5eb7I/BF3wjVKqoHqKs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yymxe5IdBi8ta+zJ0RtTJ7qpfec1bCPq8SCF8pcBIS6/iergmOb
 dQ5wJ2oKVdglVeNuPVzbA9q7E+8fHSZQgG7hDd9Fov4PFrrQvE4hwmKzxMFmC7qSLUT2D47TC+t
 SWu/oPsblPtL/KvmicH9wEvgq38XdvduolXIZsS7N254TmeAf8BJPSjNJEb2uc1dKurtzxQ==
X-Gm-Gg: AR+sD11qrbnJEVMApjk4rV/padmwYlLnSNg1vomHmfnQybMfx6X2r8UtXPphAGFFaS7
 pWZvGGhwADGIklCZ0yKz1qHnAyJ5YdL4KZs0eNA3WN1bEd1blBkNRnO92recQHniaK28B2EOh9R
 8ToxX9HiTWMLm/0hD2gBNQ0A/CqPEihqrSAiZIGQCNqoqVivU2P2LrGw0H5Vf8+Mf0Brf9EX6zZ
 5Rg4Axe38dwEVMNFV1nQiIxFNai/QLLUe0KhQ4BQiAdp+RoXmp+5CSWSWHniFTGA6iSWy6+Q7kS
 FSAeJeqlUl84SAXnv+A3xG25YnaOuqYApAp7K2Ah/Hn36anKC/3JygneXDtov7CNSgFtdOzVfpn
 c4BTV9Hf657ruOSkgr3kznfXIrA7ymZg0YN7vNnixZqHUFpBciRx3MPb2/vpYEPfDy/neRhO6PQ
 XyKF0=
X-Received: by 2002:adf:eb8f:0:b0:47f:97f6:d39a with SMTP id
 ffacd0b85a97d-47fd72c7121mr27900822f8f.17.1785845149417; 
 Tue, 04 Aug 2026 05:05:49 -0700 (PDT)
X-Received: by 2002:adf:eb8f:0:b0:47f:97f6:d39a with SMTP id
 ffacd0b85a97d-47fd72c7121mr27900691f8f.17.1785845148854; 
 Tue, 04 Aug 2026 05:05:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1756sm41086159f8f.4.2026.08.04.05.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:47 -0700 (PDT)
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
Subject: [PATCH v2 5/6] mm: pull writability check to follow_pfnmap_start()
Date: Tue,  4 Aug 2026 14:05:27 +0200
Message-ID: <20260804120529.1730187-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gDKaensDt5e_xydlwtebAcJ7_cGJ_FXLtCvH8xKYpIw_1785845150
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

All callers of follow_pfnmap_start() except s390_pci_mmio_write()
are following it, if they are doing a write, with a check that
args.writable is true; for s390_pci_mmio_write() that's a bug.
Also, most of them return -EFAULT if it is not.  Pull the check
directly into follow_pfnmap_start() through another input parameter
args.write_fault, to eliminate the need to do it in the caller.

This also fixes an issue where follow_pfnmap_start() would return
0 for a PFN that is mapped read-only, and the caller would not
attempt to call fixup_user_fault() on it; this can happen with
vm_ops that set .pfn_mkwrite(), for example.  Instead, now the
caller (for example hva_to_pfn_remapped()) sees an error,
does attempt to fix it, and only returns -EFAULT if the
fixup was fruitless.

Reported-by: Sergio Lopez <slp@redhat.com>
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/s390/pci/pci_mmio.c        |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 17 +++++----
 drivers/virt/acrn/mm.c          | 10 +-----
 include/linux/mm.h              |  3 ++
 mm/memory.c                     | 62 ++++++++++++++++++++-------------
 virt/kvm/kvm_main.c             | 15 ++++----
 6 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..d9d5b3318cbc 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -180,6 +180,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	args.address = mmio_addr;
 	args.vma = vma;
+	args.write = true;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
@@ -332,6 +333,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 
 	args.vma = vma;
 	args.address = mmio_addr;
+	args.write = false;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..e6d3a2311a99 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -541,7 +541,11 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			    unsigned long vaddr, unsigned long *pfn,
 			    unsigned long *addr_mask, bool write_fault)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = vaddr,
+		.write = write_fault,
+	};
 	int ret;
 
 	ret = follow_pfnmap_start(&args);
@@ -563,15 +567,10 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			return ret;
 	}
 
-	if (write_fault && !args.writable) {
-		ret = -EFAULT;
-	} else {
-		*pfn = args.pfn;
-		*addr_mask = args.addr_mask;
-	}
-
+	*pfn = args.pfn;
+	*addr_mask = args.addr_mask;
 	follow_pfnmap_end(&args);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 5bca500a83e0..2f9808399f19 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -177,7 +177,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
 		unsigned long start_pfn, cur_pfn;
-		bool writable;
 
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
@@ -188,6 +187,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			struct follow_pfnmap_args args = {
 				.vma = vma,
 				.address = memmap->vma_base + i * PAGE_SIZE,
+				.write = !!(memmap->attr & ACRN_MEM_ACCESS_WRITE),
 			};
 
 			ret = follow_pfnmap_start(&args);
@@ -197,16 +197,8 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			cur_pfn = args.pfn;
 			if (i == 0)
 				start_pfn = cur_pfn;
-			writable = args.writable;
 			follow_pfnmap_end(&args);
 
-			/* Disallow write access if the PTE is not writable. */
-			if (!writable &&
-			    (memmap->attr & ACRN_MEM_ACCESS_WRITE)) {
-				ret = -EFAULT;
-				break;
-			}
-
 			/* Disallow refcounted pages. */
 			if (pfn_valid(cur_pfn) &&
 			    !PageReserved(pfn_to_page(cur_pfn))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01184a4bdd6f..1659cb8f42fd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
 	 * Inputs:
 	 * @vma: Pointer to @vm_area_struct struct
 	 * @address: the virtual address to walk
+	 * @write: if true, fail with -EFAULT unless the mapping is
+	 * writable
 	 */
 	struct vm_area_struct *vma;
 	unsigned long address;
+	bool write;
 	/**
 	 * Internals:
 	 *
diff --git a/mm/memory.c b/mm/memory.c
index b5555217b121..27f5dcc319c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6774,12 +6774,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
-				     spinlock_t *lock, pte_t *ptep,
-				     pgprot_t pgprot, unsigned long pfn_base,
-				     unsigned long addr_mask, bool writable,
-				     bool special)
+static inline int pfnmap_args_setup(struct follow_pfnmap_args *args,
+				    spinlock_t *lock, pte_t *ptep,
+				    pgprot_t pgprot, unsigned long pfn_base,
+				    unsigned long addr_mask, bool writable,
+				    bool special)
 {
+	if (!writable && args->write)
+		return -EFAULT;
+
 	args->lock = lock;
 	args->ptep = ptep;
 	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
@@ -6787,6 +6790,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 	args->pgprot = pgprot;
 	args->writable = writable;
 	args->special = special;
+	return 0;
 }
 
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
@@ -6808,8 +6812,9 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  * @args: Pointer to struct @follow_pfnmap_args
  *
  * The caller needs to setup args->vma and args->address to point to the
- * virtual address as the target of such lookup.  On a successful return,
- * the results will be put into other output fields.
+ * virtual address as the target of such lookup, and optionally set
+ * args->write to require a writable mapping.  On a successful
+ * return, the results will be put into other output fields.
  *
  * After the caller finished using the fields, the caller must invoke
  * another follow_pfnmap_end() to proper releases the locks and resources
@@ -6832,7 +6837,8 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  *
  * This function must not be used to modify PTE content.
  *
- * Return: zero on success, negative otherwise.
+ * Return: zero on success, -EFAULT if @args->write was set but the
+ * mapping is not writable, -EINVAL if there is no mapping at all.
  */
 int follow_pfnmap_start(struct follow_pfnmap_args *args)
 {
@@ -6845,6 +6851,7 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
+	int r = -EINVAL;
 
 	pfnmap_lockdep_assert(vma);
 
@@ -6878,10 +6885,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
-				  pud_pfn(pud), PUD_MASK, pud_write(pud),
-				  pud_special(pud));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
+				      pud_pfn(pud), PUD_MASK, pud_write(pud),
+				      pud_special(pud));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	pmdp = pmd_offset(pudp, address);
@@ -6899,10 +6908,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
-				  pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
-				  pmd_special(pmd));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
+				      pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
+				      pmd_special(pmd));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, address, &lock);
@@ -6911,14 +6922,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto unlock;
-	pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
-			  pte_pfn(pte), PAGE_MASK, pte_write(pte),
-			  pte_special(pte));
+	r = pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
+			      pte_pfn(pte), PAGE_MASK, pte_write(pte),
+			      pte_special(pte));
+	if (r)
+		goto unlock;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, lock);
 out:
-	return -EINVAL;
+	return r;
 }
 EXPORT_SYMBOL_GPL(follow_pfnmap_start);
 
@@ -6960,7 +6973,11 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
-	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = addr,
+		.write = !!(write & FOLL_WRITE)
+	};
 
 retry:
 	if (follow_pfnmap_start(&args))
@@ -6970,9 +6987,6 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	writable = args.writable;
 	follow_pfnmap_end(&args);
 
-	if ((write & FOLL_WRITE) && !writable)
-		return -EINVAL;
-
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 576bcb21be3a..b7c21a48a45c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2928,8 +2928,11 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = kfp->hva };
-	bool write_fault = kfp->flags & FOLL_WRITE;
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = kfp->hva,
+		.write = !!(kfp->flags & FOLL_WRITE),
+	};
 	int r;
 
 	/*
@@ -2948,7 +2951,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 */
 		bool unlocked = false;
 		r = fixup_user_fault(current->mm, kfp->hva,
-				     (write_fault ? FAULT_FLAG_WRITE : 0),
+				     (args.write ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
 			return -EAGAIN;
@@ -2960,13 +2963,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			return r;
 	}
 
-	if (write_fault && !args.writable) {
-		*p_pfn = KVM_PFN_ERR_RO_FAULT;
-		goto out;
-	}
-
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-out:
 	follow_pfnmap_end(&args);
 	return r;
 }
-- 
2.55.0

