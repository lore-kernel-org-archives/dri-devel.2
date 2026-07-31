Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAABC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B6010F354;
	Fri, 31 Jul 2026 16:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CudZjlOA";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3749110F354
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785516314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBHFLJxPt4apj6AE6jTX9tz6JkNc6fSnqMXU7ny6bKM=;
 b=CudZjlOAUzwxZpXPOu1b3aFJTIVFqZ+iKmgkcq4GJh/pDerjplXGEgppqb3PnFMTRgiQ9/
 G4T/gZoeCt0KRDS+rQ9Oz6jwH2qqgMLMB+OwcXGBgZLtlsBHZRlWtm2QbXXpILKcEkWqO3
 Bhkw8GA1yUS+pb5/RkLAoBalBj913do=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-SE8aBufkPWabNn1GWd4LJA-1; Fri, 31 Jul 2026 12:44:38 -0400
X-MC-Unique: SE8aBufkPWabNn1GWd4LJA-1
X-Mimecast-MFC-AGG-ID: SE8aBufkPWabNn1GWd4LJA_1785516257
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-69841da1946so1257607a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516227; x=1786121027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBHFLJxPt4apj6AE6jTX9tz6JkNc6fSnqMXU7ny6bKM=;
 b=PMTohg3sZe3fxONAjrMwYeshbhZ4CIujK8UnH5djaqIx9QeHdk0DTWCi8AyMNi0ZQy
 OqrGXhEvlYNOvngAXOjnhZf0H4tOrrm339r0Tvq/8epnUUDdL50APxWhQhnQCx+rCFTS
 OgcaOWy9rAY+F/GT0u/RhscxVRP5dNVMqd+Lr3kJRXfzenmYffiLsUvArSitctavDrRk
 L3mOIA6fYkraibJAhYn2lrO59/0Ca4ztxBxdFM1+MQNyyPHG2fQSAjF/AUR3eaB61vzV
 /Sf7jjzylj6v9Wnm0pmm9FVcHQv1rxj+UrD09WJsFdeSgK1fBp3df6KDgn29024fOnz2
 TrFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqqs7LxHiwCcLhMWTPhhGAtBuYF+qKPJucllmIYyTihDGI0bK6qeAZ/IU1EHysDEOUWtU5NRggySpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFK4PX32NBQXjNBVTFQEO4kOeZ940255volznFJt67zquIwt5/
 JEuIU59MYVug3jA2dfwYqiYzaKFhyYvMHgc0o7N+P+rnDJkks+Bqeq7tnSC+FwXzfG465RHVJ0F
 DFNLCjcMrWPMvp1caot//oCISPIJ1LaNUwc+7LSlTKASZjPfiU3qW0ZfiGnH8lCxexE8Edw==
X-Gm-Gg: AR+sD12kUikjncOpYCSL8Hyzd1teOqNytEA85NBSlQLShwjmQkV370n87LhRnqe8pEx
 TMtwWlJQfAwYjiup8W4o2gXS5iXyS3RLx2mvTXyBlvH7HkFwksOSugotrG6pCT6UBBPXblw3kGm
 oqjBZN1hvmJXr4twrjI6RdhYyzeWIRtI3UQVXTqR29lweuCFIlIEPMMkPuTIqcyoO7IjvkkFryY
 RDaQUdfLwSoUqU5InchqT+x6OYNd2CVd/JF6KNJ2Ii4XnUwOE3TFi4Q/8xNFzM1fbQmIiOhsnRz
 naPkh2UC927YXgCAYR6MZ4yncZaw8O5p4WcUCRJL6fCmPNbTpCkqxO2mxUO+eK/B/Uw83Mjx+Ar
 d1IlBk62a6MgtRnr3DYnJfaGj7z6hi/pic2Pxr902QfbbgKxmETQB07cT4isme3+49vi5ot2aEm
 +wUQk=
X-Received: by 2002:a05:6402:4491:b0:6a0:47:71a3 with SMTP id
 4fb4d7f45d1cf-6a0a7d09735mr241956a12.20.1785516226685; 
 Fri, 31 Jul 2026 09:43:46 -0700 (PDT)
X-Received: by 2002:a05:6402:4491:b0:6a0:47:71a3 with SMTP id
 4fb4d7f45d1cf-6a0a7d09735mr241946a12.20.1785516226373; 
 Fri, 31 Jul 2026 09:43:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c655626sm2907232a12.22.2026.07.31.09.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:43:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH RFT 1/3] mm: export variants of vmf_insert_pfn* for use with
 pfn_mkwrite()
Date: Fri, 31 Jul 2026 18:43:39 +0200
Message-ID: <20260731164341.1109827-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rYAUxc39RZTJkNDVaLljKjqllVbdv3VQM8XGvWXda7c_1785516257
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
vmf_insert_pfn_pmd().  Adjust mm/memory.c to export two more
functions: vmf_insert_pfn_mkwrite() for the common case where
vma->vm_page_prot is okay, and __vmf_insert_pfn_prot() when
really all parameters are needed.  This makes it possible
to fix drivers that use .pfn_mkwrite together with
vmf_insert_pfn() and vmf_insert_pfn_prot().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/mm.h |  4 +++
 mm/huge_memory.c   |  2 +-
 mm/memory.c        | 75 +++++++++++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34c79b5fcb9b..33c7de36b214 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4551,6 +4551,10 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, bool write);
+vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot, bool mkwrite);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
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
index 40997a26846f..7b950be8f511 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2718,6 +2718,34 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	return VM_FAULT_NOPAGE;
 }
 
+vm_fault_t __vmf_insert_pfn_prot(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long pfn, pgprot_t pgprot,
+			bool mkwrite)
+{
+	/*
+	 * Technically, architectures with pte_special can avoid all these
+	 * restrictions (same for remap_pfn_range).  However we would like
+	 * consistency in testing and feature parity among all, so we should
+	 * try to keep these invariants in place for everybody.
+	 */
+	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
+	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
+						(VM_PFNMAP|VM_MIXEDMAP));
+	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
+	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
+
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	if (!pfn_modify_allowed(pfn, pgprot))
+		return VM_FAULT_SIGBUS;
+
+	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
+
+	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+}
+EXPORT_SYMBOL(__vmf_insert_pfn_prot);
+
 /**
  * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
@@ -2754,27 +2782,7 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
-	/*
-	 * Technically, architectures with pte_special can avoid all these
-	 * restrictions (same for remap_pfn_range).  However we would like
-	 * consistency in testing and feature parity among all, so we should
-	 * try to keep these invariants in place for everybody.
-	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
-	BUG_ON((vma->vm_flags & VM_MIXEDMAP) && pfn_valid(pfn));
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	if (!pfn_modify_allowed(pfn, pgprot))
-		return VM_FAULT_SIGBUS;
-
-	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
-
-	return insert_pfn(vma, addr, pfn, pgprot, false);
+	return __vmf_insert_pfn_prot(vma, addr, pfn, pgprot, false);
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -2805,6 +2813,31 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn);
 
+/**
+ * vmf_insert_pfn_mkwrite - insert single pfn into user vma, possibly writable
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @write: whether the PTE should be installed writable
+ *
+ * Like vmf_insert_pfn(), except that @write allows installing a writable
+ * PTE even when @vma is under write notification, i.e. when it has a
+ * .page_mkwrite() or .pfn_mkwrite() callback and vma_set_page_prot() has
+ * therefore cleared the write bit from @vma->vm_page_prot.
+ *
+ * Note that neither of these callbacks is invoked, so the caller must
+ * itself do whatever they would have done if @write is true.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, bool write)
+{
+	return __vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot, write);
+}
+EXPORT_SYMBOL(vmf_insert_pfn_mkwrite);
+
 static bool vm_mixed_ok(struct vm_area_struct *vma, unsigned long pfn,
 			bool mkwrite)
 {
-- 
2.55.0

