Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367EAC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5FD10E142;
	Tue,  4 Aug 2026 12:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XmMG09Vn";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C2710E142
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnnVy48ydCXauSW+w5ZraHIy4YMvaYkPwdBxROmLWeM=;
 b=XmMG09Vnt7SEGSTTo+/JgXhA4iGU51CvVAYN4qeM3lRSbmvxpK2cs0Ccedxm2IWefGBSPI
 Jcr+7OxtHlRawn8nnIjYyPcj3Iq8N8jOBaacsi7IaQuNHIa/Y+p117bwmfZ8rUW5SxKU/W
 z3w+2VJlb6pzaIle/rCIDoyLV10FcxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-F1UsL1K9Mly2FsmCyEnVyg-1; Tue, 04 Aug 2026 08:05:36 -0400
X-MC-Unique: F1UsL1K9Mly2FsmCyEnVyg-1
X-Mimecast-MFC-AGG-ID: F1UsL1K9Mly2FsmCyEnVyg_1785845135
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4954dcd6131so33952465e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845135; x=1786449935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VnnVy48ydCXauSW+w5ZraHIy4YMvaYkPwdBxROmLWeM=;
 b=DKNMvJQjDfFqtF2ylleXfhgRh109GIdBpbkNrw6e93R7l+zzf1wscho9qoC3HzVLu7
 EBqsfoCZEsfEEd5sYa1eS4gwULnfjlafspFOp8Md3oCHuP9YrCeXRYviNNrIRBMe2ov0
 Zatlh9ifWfZuIzqvXeH7vzvuRQPvcARePZVZs3offT8KPUrWbHJ/es8FCvhSr5MvRD9d
 kbLAL/7SEP90gzzV4T2qsOK1Pcs4sx5yA5/MM79iqvwap5nXWs1pe5jqiHpom5atSLtC
 7b/EpO9t6EOF2AI4wUF+rUcp+iCsPvjH7D03kklGRjYZrFxmuffJcNe+uR0r5tkZIIlv
 LneQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpODx7H7ugDHe0KavSwepjwD6NC5AnT452MpVhhlHCTVBx678rvjHj0Ps9Rx9m8T7SIWnjCZD/xEys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywg/qhd0GX69wLBK/OLiui9o+3rKoQZ/BTvRQkp9e53u9Ue8OLW
 E4RxgdXF1FXtmleI2Jix5PUNTDgtI7DMUA2TAdaGHwunFyKhi9EFrD/HY1Xj++y8vb5fSwHbW74
 hY/NEuHEySi9QC8+6XXyv21Mi/M04E00crBStjrYenk66G4l9XaB22It5yGkAmD7cKuNk4g==
X-Gm-Gg: AR+sD12vXKtJwZ2UJitXAg3/QU19PSMHe46sX7DdO6URPQf9c95ybpadwWv9UwNEFt4
 8o2ePTJJLDpoC/Asss249SVQ6uB82YwDAWmwUrd6TJwkuLSKhklhINA7e4FJcco9yxT6NmRQUya
 x1Y3MUYDuBN+o/D0iQOExjUKakhSKTgURxlNYNRNM2fraLKcegDJV6nnp4bjPfUwhxFyQn47EVR
 +O0bkTnb50I9VSmS7B5gzZb77puyB2n1cN72TEablDqlYAZ53hI4zk0Ljp7wNHgBtP18k4qeP57
 X4l8PeWXqJfmOdY7Dhe4hlfQ7kStc/yjbHK/yyh3qY3z6fP8pnM+fxt2ySjfea4eBLEt3j565Sg
 Q6tdmfAJS/f1TauuYioLEDVhRILVcwjpnQa1BdUZE4pnY8QrUvj6b6lcwzd82zAlGvM/W4FqEBF
 O8MAw=
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-4980c6747fdmr217894895e9.15.1785845135182; 
 Tue, 04 Aug 2026 05:05:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-4980c6747fdmr217893395e9.15.1785845134667; 
 Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949f66168sm92311515e9.0.2026.08.04.05.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
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
Subject: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(),
 change variants to inline
Date: Tue,  4 Aug 2026 14:05:23 +0200
Message-ID: <20260804120529.1730187-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YJu82xePgdx7MQdjGyElWxEdNetvpQhN9FbnU2SvnX4_1785845135
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

Right now, users of .pfn_mkwrite() have no way to create a PTE
that has gone through maybe_mkwrite().  Because vma_set_page_prot()
will have cleared the writable PTE bit, users of fixup_user_fault()
will see a read-only PTE and have no clue that the page needs
a *second* fault to reach its final status.

Handling this in fixup_user_fault() is problematic: the information
about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
which is an opaque pgprot_t, therefore only follow_pfnmap_start()
knows how to retrieve it.

There are actually some preexisting functions that suggest how this
is supposed to be handled, namely vmf_insert_page_mkwrite() and
vmf_insert_pfn_pmd().  Fixing the drivers requires similar variants
of vm_insert_pfn(), namely vmf_insert_pfn_mkwrite() for the common
case where vma->vm_page_prot is okay, and vmf_insert_pfn_prot_mkwrite()
when really all parameters are needed.  This makes it possible
to fix drivers that use .pfn_mkwrite together with
vmf_insert_pfn() and vmf_insert_pfn_prot().

Since vmf_insert_pfn_prot_mkwrite() is the most general variant
and all the others are just special cases, turn them into inline
functions in the header.

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/mm.h | 81 +++++++++++++++++++++++++++++++++++++++++---
 mm/huge_memory.c   |  2 +-
 mm/memory.c        | 84 ++++++++++++++++++++--------------------------
 3 files changed, 114 insertions(+), 53 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..01184a4bdd6f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4544,16 +4544,89 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
 vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 			bool write);
-vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn);
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot, bool mkwrite);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 
+
+/**
+ * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vmf_insert_pfn(), except that it allows drivers
+ * to override pgprot on a per-page basis.  For more information,
+ * see vmf_insert_pfn_prot_mkwrite().
+ *
+ * This only makes sense for IO mappings, and it makes no sense for
+ * COW mappings.  In general, using multiple vmas is preferable;
+ * vmf_insert_pfn_prot should only be used if using multiple VMAs is
+ * impractical.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot)
+{
+	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, pgprot, false);
+}
+
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, possibly writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @write: whether the PTE should be installed writable
+ *
+ * Like vmf_insert_pfn(), except that @write allows installing a writable
+ * PTE even when @vma is under write notification.  For more information,
+ * see vmf_insert_pfn_prot_mkwrite().
+ *
+ * Note that neither .pfn_mkwrite() nor .page_mkwrite() is invoked, so the
+ * caller must itself do whatever they would have done if @write is true.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, bool write)
+{
+	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, vma->vm_page_prot, write);
+}
+
+/**
+ * vmf_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_insert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return the result of this function.
+ *
+ * vma cannot be a COW mapping.
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+static inline vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn)
+{
+	return vmf_insert_pfn_mkwrite(vma, addr, pfn, false);
+}
+
 static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 				unsigned long addr, struct page *page)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..2f4dcaa819b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1615,7 +1615,7 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
  * @pfn: pfn to insert
  * @write: whether it's a write fault
  *
- * Insert a pmd size pfn. See vmf_insert_pfn() for additional info.
+ * Insert a pmd size pfn. See vmf_insert_pfn_mkwrite() for additional info.
  *
  * Return: vm_fault_t value.
  */
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..b5555217b121 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2719,40 +2719,55 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
- * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * vmf_insert_pfn_prot_mkwrite - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
  * @addr: target user address of this page
  * @pfn: source kernel pfn
  * @pgprot: pgprot flags for the inserted page
+ * @mkwrite: whether to make the page writable.
  *
- * This is exactly like vmf_insert_pfn(), except that it allows drivers
- * to override pgprot on a per-page basis.
+ * This is the function underlying all the others in the vmf_insert_pfn()
+ * family.  It is the most flexible, as it allows drivers to override pgprot
+ * on a per-page basis, as well as to insert the pfn as if it already had
+ * a write fault.  vmf_insert_pfn() is usually sufficient, however.
+ *
+ * These functions should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return the result of these functions.
  *
  * This only makes sense for IO mappings, and it makes no sense for
- * COW mappings.  In general, using multiple vmas is preferable;
- * vmf_insert_pfn_prot should only be used if using multiple VMAs is
- * impractical.
+ * COW mappings.
  *
- * pgprot typically only differs from @vma->vm_page_prot when drivers set
- * caching- and encryption bits different than those of @vma->vm_page_prot,
- * because the caching- or encryption mode may not be known at mmap() time.
+ * For vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite(), the
+ * @mkwrite argument allows installing a writable PTE even when @vma is
+ * under write notification, i.e. when it has a .pfn_mkwrite() callback.
+ * In this case, vma_set_page_prot() has cleared the write bit from
+ * @vma->vm_page_prot.  This lets the fault() callback install a writable
+ * PTE in response to write faults; note that .pfn_mkwrite() is not called,
+ * and therefore the caller has to do by itself whatever the callback would
+ * have done.
  *
- * This is ok as long as @vma->vm_page_prot is not used by the core vm
+ * For vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_prot(),
+ * pgprot can differ from @vma->vm_page_prot.  This typically happens only
+ * for caching and encryption bits, which may not be known at mmap() time;
+ * it is ok as long as @vma->vm_page_prot is not used by the core vm
  * to set caching and encryption bits for those vmas (except for COW pages).
- * This is ensured by core vm only modifying these page table entries using
- * functions that don't touch caching- or encryption bits, using pte_modify()
- * if needed. (See for example mprotect()).
+ * This is ensured in two ways:
  *
- * Also when new page-table entries are created, this is only done using the
- * fault() callback, and never using the value of vma->vm_page_prot,
- * except for page-table entries that point to anonymous pages as the result
- * of COW.
+ * - core vm only modifies these page table entries using functions that don't
+ *   touch caching- or encryption bits, using pte_modify() if needed. (See
+ *   for example mprotect()).
+ *
+ * - when new page-table entries are created, this is only done using the
+ *   fault() callback, and never using the value of vma->vm_page_prot,
+ *   except for page-table entries that point to anonymous pages as the result
+ *   of COW.
  *
  * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot)
+vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+			bool mkwrite)
 {
 	/*
 	 * Technically, architectures with pte_special can avoid all these
@@ -2774,36 +2789,9 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 }
-EXPORT_SYMBOL(vmf_insert_pfn_prot);
-
-/**
- * vmf_insert_pfn - insert single pfn into user vma
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- *
- * Similar to vm_insert_page, this allows drivers to insert individual pages
- * they've allocated into a user vma. Same comments apply.
- *
- * This function should only be called from a vm_ops->fault handler, and
- * in that case the handler should return the result of this function.
- *
- * vma cannot be a COW mapping.
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- *
- * Context: Process context.  May allocate using %GFP_KERNEL.
- * Return: vm_fault_t value.
- */
-vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn)
-{
-	return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
-}
-EXPORT_SYMBOL(vmf_insert_pfn);
+EXPORT_SYMBOL(vmf_insert_pfn_prot_mkwrite);
 
 static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
 			bool mkwrite)
-- 
2.55.0

