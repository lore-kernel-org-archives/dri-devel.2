Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA7C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F6E10ED42;
	Wed,  5 Aug 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKA4HVIE";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1221310E65B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 14:04:26 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso41288461fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785852264; x=1786457064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0SIB9ZNDGWSkbhYbrVPXtpZTZPzNmn29odQM0RAb0dw=;
 b=mKA4HVIEMdlZbebc35h4WeMjQvpWoy8LruHDDsle0DfWo//vAAFytBabq911FeTRKD
 CyHTGaqK2vdvUtc1qZZPobLsHY/9XmOo0PS4MIbFjJXKsSBj+yINH1h8iHlpij5npwQU
 nSR4JE8qC6AV4e/amipauTHnvjeN80YwftFNUGZSqBlZQ751RWmS+CiDDXHYDj9IDsm7
 wwCVnR4Oc4YBzukv3kbDLh0C/YvEpXN1oX26H1lC2x1pHCgFKAVTypEHYX5vPG/3tdGH
 /ARWhO+ne1UcVB034E0gjWfuwnG2Gc8Kwc2Jl19vdnJqGKof75HE2/vAnHvTHAnwxtZm
 HE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852264; x=1786457064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0SIB9ZNDGWSkbhYbrVPXtpZTZPzNmn29odQM0RAb0dw=;
 b=g5xC3B66CUNe6xmCI5r1Zrit3MDMXK1sJ91Tu/vNEvemHGxtEQNBYKKA7ytKxl++CD
 q9xVeT9FOqtuZoFAT6Qn5xbzrVEUFnrIutBm8d25r5DNQOim0aY0M6eSLsMXnOzAwL9B
 BlfyqmBdS0WLtyRhQ5o5bPde0d/aq/AJv262+f1Uo+H8Mn2WNYZla1Ct92bnhNU76yWs
 wKWChLT2JWY0Xwr2xJLRmoLKdkP9Fxiuns3NbjO4BH0qZWNIOP/OxGWA5I7UDLK9HVX4
 i1BW2W5Zofw14DcJAosThjvGnsGuXGRNPzd8xNTAJVH0aOAtJuJR7X50WKo9GWWcXi9R
 MWJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpenVyYIkTW2Izx3MSzPoK89BmxO0NhEz2VEL9KxpFwAGa/qp9y39eht420DABifIe1AQxTw39WphA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmefe/BpwjboXolWJTP/i31KfJRsX8LbZLnBcIZOgpWz3qcGFR
 MxubiEhkH4L6zK7F+Xq4OoDrwoH1cZ/Y9yBhspBLrC6X+P7S8Omv9HcA
X-Gm-Gg: AR+sD11Pn2QZ69roqZgxvYemSe9TrNAKKNQGEbRvCPlUz+QQpVZ7V6XnEKWawM3NS78
 nkm3Z5zs+MrcoqO3Hi5NqrE0mlTZ5trFqQSAeMqSBtg8iokO7fzyAAKCw1gdR7IQ5RDg/v6wtLU
 SHxvNlIrlmbk0BHZoVsrhvL/4i4aZxT1N81+QsPuz7EF/c6LfcR8HaawYDTd7THX7cFK8VFUvg7
 j04G8iHWMRsTKhWSytqKP7+2Unckzcilt8UpQaRnkRAnPfDiwZobhQWcISy3k7YMpspQFyFfgnb
 GAb1NmKAbceqQOMa7ciGG0DV1/TjJE75kGyiy1UkB9LDrfm5IzTkkjAIBvfRdeMvJegrT1zdRNd
 f8jcjp3aHkd3n+L2hpCY/Vhw3uRruneD8lkqV6H9/Pc3JAsbhrkKv6FBDfO7+IxEJB3oumRo/Cf
 E8ncGOuslD0aeoVx/GMxR0TQ9z2nJzp1EboslsvV1yNPJ02YERtaiz8R4nLmaDTiBmIgyhNhJkz
 oq7F5P9L6tII0Y3z8YCNoXii+UMMh3c7G/9qD9w
X-Received: by 2002:a05:6512:39c3:b0:5b2:a396:1793 with SMTP id
 2adb3069b0e04-5b2e4f76abemr2965624e87.37.1785852263358; 
 Tue, 04 Aug 2026 07:04:23 -0700 (PDT)
Received: from kfastov-mac ([91.217.3.226]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e245536dsm2669672e87.67.2026.08.04.07.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 07:04:22 -0700 (PDT)
From: Konstantin Fastov <kfastov@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Konstantin Fastov <kfastov@gmail.com>
Subject: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
Date: Tue,  4 Aug 2026 17:04:03 +0300
Message-ID: <20260804140403.16337-1-kfastov@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
.pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
so vma_set_page_prot() removes the write bit from vm_page_prot of
shared mappings, and the vmf_insert_pfn() call in the fault handler now
installs read-only PTEs even when serving a write fault.

For regular CPU accesses this is transparent: the retried access faults
again on the present read-only PTE, goes through wp_pfn_shared() into
.pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
resolve faults through fixup_user_fault() + follow_pfnmap_start()
perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
after "successfully" handling a write fault, finds a present read-only
PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
mapping virtio-gpu blob resources die with EFAULT on first GPU access.
The traced failing sequence:

  follow_pfnmap_start()        -> -EINVAL   (no PTE yet)
  fixup_user_fault(WRITE)
    drm_gem_shmem_fault()
      vmf_insert_pfn()         -> NOPAGE    (read-only PTE installed)
  fixup_user_fault()           -> 0         (fault "handled")
  follow_pfnmap_start()        -> 0, !writable
  hva_to_pfn()                 -> KVM_PFN_ERR_RO_FAULT

Fix it the same way commit cb2a2a5b37ad ("drm/shmem_helper: Make sure
PMD entries get the writeable upgrade") did for the PMD path: when the
fault is a write fault, install a writable entry directly and record
the write for dirty tracking, instead of relying on a refault that not
every fault-resolution path performs.

To do that at PTE level, add vmf_insert_pfn_mkwrite(), the VM_PFNMAP
counterpart of vmf_insert_mixed_mkwrite(): insert_pfn() already
implements the mkwrite semantics, there was just no wrapper exposing it
for pfn inserts with the default pgprot.

Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Cc: stable@vger.kernel.org
Closes: https://github.com/AsahiLinux/linux/issues/560
Assisted-by: Claude:claude-fable-5
Signed-off-by: Konstantin Fastov <kfastov@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 20 +++++++++++++-
 include/linux/mm.h                     |  2 ++
 mm/memory.c                            | 36 +++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..37662f6f6ed9 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -573,7 +573,25 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 				 unsigned long pfn)
 {
 	if (!order) {
-		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		vm_fault_t ret;
+
+		/* .pfn_mkwrite enables write-notify, so vm_page_prot lacks
+		 * the write bit and a plain vmf_insert_pfn() would install
+		 * a read-only PTE even for a write fault.  Not every fault
+		 * resolver refaults into .pfn_mkwrite() to upgrade it (KVM
+		 * doesn't), so install a writable PTE and record the write
+		 * directly, like the PMD path below.
+		 */
+		if (vmf->flags & FAULT_FLAG_WRITE) {
+			ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address,
+						     pfn);
+			if (ret == VM_FAULT_NOPAGE)
+				drm_gem_shmem_record_mkwrite(vmf);
+		} else {
+			ret = vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+		}
+
+		return ret;
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80fce2515930..7b76a281bdd1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4551,6 +4551,8 @@ vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
 			bool write);
 vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 86a973119bd4..6562a0d8bb68 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2751,8 +2751,9 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
  * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
-vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn, pgprot_t pgprot)
+static vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+		bool mkwrite)
 {
 	/*
 	 * Technically, architectures with pte_special can avoid all these
@@ -2774,10 +2775,39 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+}
+
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, making it writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vmf_insert_pfn(), but the inserted PTE is made young, dirty and
+ * writable (subject to the VMA's write permission).  For use by fault
+ * handlers of write-notify VMAs (where vma->vm_page_prot has the write bit
+ * removed) that serve a write fault and do their own dirty accounting, so
+ * that a "handled" write fault always results in a writable PTE.  The
+ * VM_PFNMAP counterpart of vmf_insert_mixed_mkwrite().
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot, true);
+}
+EXPORT_SYMBOL(vmf_insert_pfn_mkwrite);
+
 /**
  * vmf_insert_pfn - insert single pfn into user vma
  * @vma: user vma to map to
-- 
2.55.0

