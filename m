Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA46C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1FC10E9E4;
	Tue,  4 Aug 2026 12:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gjis9SLo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 532E910E9E4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
 b=gjis9SLoH1fiQgEanEAggz1ENEdMKyQDnXcBZFRWaepx6vEWeiDfuUAhwk3JLCHG8R5DYU
 CYK3ZbiInEC9oAGWfNdK/JjlDwsEf+5jtglqH1KD3derxjD2uKHdz6wS1X2xpe5L6QWRpK
 Czv5a51RgUUps93S9Vcam/ei0l3uSwA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-lQw1ukyXOxuPjPnaCtGEhg-1; Tue, 04 Aug 2026 08:05:47 -0400
X-MC-Unique: lQw1ukyXOxuPjPnaCtGEhg-1
X-Mimecast-MFC-AGG-ID: lQw1ukyXOxuPjPnaCtGEhg_1785845146
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so4464882f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845146; x=1786449946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7VbhR/EeseCGUhv0h0yNN2Py/m+SxPzo7FfzMk4g7pY=;
 b=AMdI75CDHhulGQWpQvCeUtFSkZndd5oQl65Tnb/1vCI/42IsDtDgEn6vhtrTpOHsVe
 5pS96cAqf7ZUG11dUXNuySzP+Uox5+aW5cGi11A84qRSmZVauoVSCBo2L3vac22t7Kl1
 QynfTIbjcSQTspF/PaEeE17J99dPt0iZLM0L5afbbp49Mr6rB0qyRRIXb4Utkqp7RbOD
 o2++vmXt71TgGCaZa5xk27CAkJFFbd9A+tiBzFd7cf1cgskwQieFbSuhX5u+Nv2Ackrc
 aidtdXKfsY4nITFJpLr4HiLoc1KgurQ98tzYTy/78SI3udb3EtYKJUOF4grdGucAGeY4
 QDpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbQc9BdQWjXPkVMZlc0G64wTLE2duAke2ovxHFHqva4jLuNpkd3v5eYN8DbskA5Fhm2kjtFnLnSrU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+Y16zLCqJjvtL+0wOvuKrRNdXyjsf5tX3eoHjkPehkMW2+D8z
 3T8eqaHh4WbBg/XGwi1m6acfuyvJElR37JpsXjPbhMjIaLJ3C8Sy3zf4cXfPez5oC+F7KfB/0L9
 cj8q1OWTrxFmnE0xtBQPGui3gAJ3be2PQ6rbuY5Oa7ddEb2pGVNybocWBk/j5mpDWXN7nyA==
X-Gm-Gg: AR+sD13hah8t80Kab5ikv1kb7GoyDGRUqwcT0rgw1iAjm6+U+Xd1dhor1i1WRTF/O9W
 qW3ovdKlSx3/5r4r9rScyDrofzWpqT3NO/z1Q7fV/AfswQ19iuipR0HMJgD+29rrA6IlcaPwn84
 LOcVuf+ECQ2rvXSSxmoDA2yTPfIFAib90pTtBbkHrznKIhngE8gBd29Zt4gvCzHMPqUjlsbsRwC
 q0tp8n/F+4G1xciolovp7tAqiqofWHVQ9v5wnpvgShaKDtO4gshPaRRgUjoSw+uBIWwJTpAglAz
 pFEB2GGy3Jv4DDNCDOZRrb7miXxDvzCYuRxTZdw7Aset47u9a5RicoHs/Pl3RONqmTIcQ+xavv1
 UdTz2WUd5CJO+31TN5G83MOKsQv76SamPA2qG3DvnafxsSxOKSoJsWignNpvhrxAjcxsJ3DC2IC
 mnI54=
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id
 ffacd0b85a97d-47fd72a8e68mr29813779f8f.9.1785845146057; 
 Tue, 04 Aug 2026 05:05:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2989:20b0:47f:7154:9dfc with SMTP id
 ffacd0b85a97d-47fd72a8e68mr29813677f8f.9.1785845145601; 
 Tue, 04 Aug 2026 05:05:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562667sm45367660f8f.24.2026.08.04.05.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:43 -0700 (PDT)
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
Subject: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
Date: Tue,  4 Aug 2026 14:05:26 +0200
Message-ID: <20260804120529.1730187-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OBq4wseImlSN17OkUSiu-qusCgbQUDxBi-BPwP_p3qY_1785845146
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

The VM_READ and VM_WRITE flags are checked only at the very end of
hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
mappings, this adds unnecessary cases and inconsistent error behavior.

For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
detect this situation.  This is fragile because hva_to_pfn_remapped()
returns different error codes for a !VM_WRITE VMA depending on whether
the PTE happens to be mapped:

* if the PTE is present, follow_pfnmap_start() sets args.writable to
  false and KVM_PFN_ERR_RO_FAULT is returned;

* if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
  -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
  up returning KVM_PFN_ERR_FAULT.

With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
pte_present()[1] when the guest attempted to read it; with the patch
instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
avoids these special cases and also sidesteps the issue pointed out at
https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.

For regular mappings a PROT_READ VMA, if placed in a writable memslot,
would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
the guest writes to it.  This would cause a -EFAULT exit to userspace,
instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
however it should be considered part of the KVM API because mmu_stress_test
relies on it.

Still, even with this snag about the returned pfn error code, pull the
vm_flags checks in front so that they are done for all VMAs and the
above inconsistency goes away for the VM_IO|VM_PFNMAP case.

[1] on x86, for example, such a page would have _PAGE_PRESENT clear
  but _PAGE_PROTNONE set

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..576bcb21be3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 	return npages;
 }
 
-static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
-{
-	if (unlikely(!(vma->vm_flags & VM_READ)))
-		return false;
-
-	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
-		return false;
-
-	return true;
-}
-
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
@@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 retry:
 	vma = vma_lookup(current->mm, kfp->hva);
 
-	if (vma == NULL)
+	/*
+	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
+	 * or the page might be absent.
+	 */
+
+	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
+	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
+		/*
+		 * Exit to userspace for PROT_READ mappings in a writable
+		 * memslot, as this is part of the API.
+		 */
+		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
+			KVM_PFN_ERR_FAULT;
+	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
 			goto retry;
 		if (r < 0)
 			pfn = KVM_PFN_ERR_FAULT;
 	} else {
-		if ((kfp->flags & FOLL_NOWAIT) &&
-		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
-			pfn = KVM_PFN_ERR_NEEDS_IO;
-		else
-			pfn = KVM_PFN_ERR_FAULT;
+		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
+			KVM_PFN_ERR_FAULT;
 	}
 	mmap_read_unlock(current->mm);
 	return pfn;
-- 
2.55.0

