Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACCDC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C735C10E9E3;
	Tue,  4 Aug 2026 12:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="W28lRHx/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 781FA10E9E0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
 b=W28lRHx/kD+9Y16/BesCNcgDwJyDBpeKAEMDFNYjSuFSVSgUC62M/MLnTYB5jlIfZgzklL
 Q4AjRoYBI6VD6R7cuJYH4INs+md689FhIZobEROi//C5efyjsHyl9aKL9HJkvfMIEa4cvL
 BB5QUuWGaREabn6l8zl+C22UXa65e1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PRpWSKJXP5WcMy6XA5tniw-1; Tue, 04 Aug 2026 08:05:34 -0400
X-MC-Unique: PRpWSKJXP5WcMy6XA5tniw-1
X-Mimecast-MFC-AGG-ID: PRpWSKJXP5WcMy6XA5tniw_1785845133
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so14975545e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845132; x=1786449932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AZAgqjN1G77tAGGqT1Vu5xvpE2S1pmBmpjJ+rMqalos=;
 b=ec4fPgIEdKdNR5x9bscULI2XpEURujuMvEau4X54rSOPqbVpNSMT4eosMHfHNcl/8i
 4UnFiqI29C+m6Rbveazione87qvwebRPLnm4WwkYO2B9BsvctMJYo/f2hl7FVUTvGkGR
 QQtLOA7+d3g/9G6mHYokxW+LE8J1irSsBur2OV8WNbYAoduqF7T3oRH1kBuzHaKVhgHV
 bGihqSkCvhkbwC7hZjFOuPKNG1aGg4CHKe4y3BgGeKDCRS6Cr9F4YrWNn2bAK9UXCIy+
 pdOUtMpCGTz/qheQDhJLSR5TOFGkLDa13+ai0THtjsbEPaD65n7i0uPGeincoXuZtYEH
 fONQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEKSs0UynIRObB7fxmb62WGkxdPK7wB/3Rcx/6tRJhnL47KkSPcgifCjQSlh0C/azwz7IBnDd/DAI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu+FLeid2tWJaoorgXigcbkBBgJTD+ohs/6Y/WAXz54mtsp9yy
 yEaHxbHmas1pCicDl8uQcI69+2tf6TWGU8znNf5X9KAL67SSKILSZZCFyAMmnrj6XWKxOwrL7Mj
 ezHaIYiQNif41F3M1psYJb7abBKHjdO1iNGfZzn5JzM0SGIqBGjV/c1iG6+ExcUrTYgUYBg==
X-Gm-Gg: AR+sD12PMx2Vo9spenj5cbQh2/1eMEFSNAgo9LGrt0vZClHtqPpbJTiby0hsnA1/wko
 rtJ/gT4ZwLmdeqACL4edfwZd54sjq/jnZCQBmixyqSl1StQV8KiT5OewTTUTqjfXo2xEc/AykRt
 IRIm63wbwc/bIK+VzZzFhrOT1X7HBRkdfLb1WvUFsIAWfEYIAf4u5exLX3DgZfPnn7g9Z3LMD2H
 2g8/3e2ttZ+ohzSY7CKV53bLl4sdgL+oPN+BiH7EwB2vH0ZuFRfPWezzdzt9ydV2AkFivrASbJn
 aT57QVfdW1sp+qQaL0OPulO/V9ySEoGfznY235qrT9qLUL3PxdLFpp7vjYEXOjpaQUh3WEChaxR
 0/8D0WWqX2LlokR/G2UlQqGVkpsm6d+m98lkUsEDZ6IoJkid4boLVRiQL53MDBiwZj3twGCC4M2
 UFU24=
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4980c673d61mr252270955e9.12.1785845132463; 
 Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
X-Received: by 2002:a7b:cc82:0:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4980c673d61mr252270015e9.12.1785845132021; 
 Tue, 04 Aug 2026 05:05:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fec606sm99039055e9.14.2026.08.04.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:31 -0700 (PDT)
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
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/6] mm,
 drm: fix interaction of .pfn_mkwrite() with fixup_user_fault()
Date: Tue,  4 Aug 2026 14:05:22 +0200
Message-ID: <20260804120529.1730187-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fGzL5sFmfKg6AKA6FxPxx0g62ZPfIM8lyy0n8zEGP6U_1785845133
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

This "v2" combines three series that I have previously posted separately to gather
reviews and tests:

- kvm: apply VM_READ/VM_WRITE checks to all VMA types
  https://lore.kernel.org/kvm/20260731175834.1121005-1-pbonzini@redhat.com/

- mm: pull writability check to follow_pfnmap_start()
  https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/#u

- mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
  https://lore.kernel.org/kvm/20260731164341.1109827-1-pbonzini@redhat.com/

All three, together, make it possible to write drivers that use .fault()
and .pfn_mkwrite() callbacks for VM_IO|VM_PFNMAP regions, and that also
interact correctly with users of fixup_user_fault().

The problem is that if you define .pfn_mkwrite(), vma_set_page_prot()
clears the writable PTE bit in vma->vm_page_prot, at which point
the .fault() callback has no way to create a writable PTE.  Users of
fixup_user_fault() will then see a read-only PTE and have no clue that
the page needs a *second* fault to reach its final status.

fixup_user_fault() itself does not have a good way to notice this, because
vma->vm_page_prot is an opaque pgprot_t, so the fix needs to be somewhere
else.  Other preexisting functions, namely vmf_insert_page_mkwrite()
as well as vmf_insert_pfn_pmd(), suggest that this has to be the driver.
In fact, of the five vm_ops that use .pfn_mkwrite() together with .fault(),
three are in file systems and are not buggy: all of them ultimately end
up in dax_fault_iter(), which uses vmf_insert_page_mkwrite() to correctly
insert the PTE.

The two problematic implementations instead are both in drm code.  One, in
drm_gem_shmem_helper, was reported as a KVM regression; the other, in
vmwgfx, was found by inspection of .pfn_mkwrite() implementors.
Both of these use pfn-mapped regions, but there is nothing like a
vmf_insert_pfn_mkwrite() function that they could use; the first part of
this series thus adjusts mm.h to provide two new functions for this
usecase---vmf_insert_pfn_prot_mkwrite() and vmf_insert_pfn_mkwrite()---and
then teaches drm's two users of .pfn_mkwrite() to call them.

This however leaves another case buggy where fixup_user_fault() is preceded
by follow_pfnmap_start().  Most callers of follow_pfnmap_start(), seeing
it return 0 for a PFN that is mapped read-only, would not attempt to
call fixup_user_fault() on it, and thus the PTE would not be upgraded
to writable.

This is arguably a bug in... almost all the callers of follow_pfnmap_start(),
but fixing it is much better achieved with a small improvement to the API;
if follow_pfnmap_start() is told by the caller that it needs the memory
for a write, most callers are simplified because they were doing such a check
anyway and now just see -EFAULT.  They then proceed to call fixup_user_fault()
and everyone is happy.  This is done in patch 5.

To sum up:

- patches 1-3 introduce the new MM API, and use it in the DRM .fault()
  callbacks to install writable PTEs in response to write faults

- patch 4 is a preparatory fix in KVM, eliminating inconsistencies in the
  handling of !VM_READ and !VM_WRITE VMAs; these would return different
  error codes for a !VM_WRITE VMA depending on whether the PTE happens
  to be mapped (but with wrong permissions).  This needs to be here
  because the next patch would introduce even more inconsistencies.
  
- patch 5 moves the check for writable PTEs from follow_pfnmap_start()'s
  callers to the function itself

- finally, patch 6 is a KVM addendum that will have to wait until
  the next merge window; it removes yet another inconsistency in
  KVM's handling of !VM_WRITE but is technically userspace-visible,
  and therefore it shouldn't be included in stable kernel releases
  unlike the rest.


Thanks,

Paolo


Paolo Bonzini (6):
  mm: export vmf_insert_pfn_prot_mkwrite(), change variants to inline
  drm/shmem_helper: use vmf_insert_pfn_mkwrite()
  drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is in
    use
  kvm: apply VM_READ/VM_WRITE checks to all VMA types
  mm: pull writability check to follow_pfnmap_start()
  kvm: return -EFAULT for writes to !VM_WRITE IO mappings

 arch/s390/pci/pci_mmio.c                   |   2 +
 drivers/gpu/drm/drm_gem_shmem_helper.c     |  38 +++---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  42 +++---
 drivers/vfio/vfio_iommu_type1.c            |  17 ++-
 drivers/virt/acrn/mm.c                     |  10 +-
 include/linux/mm.h                         |  84 +++++++++++-
 mm/huge_memory.c                           |   2 +-
 mm/memory.c                                | 146 +++++++++++----------
 virt/kvm/kvm_main.c                        |  44 +++----
 10 files changed, 232 insertions(+), 160 deletions(-)

-- 
2.55.0

