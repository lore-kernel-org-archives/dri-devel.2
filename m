Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7FAC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BA210F34A;
	Fri, 31 Jul 2026 16:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gFydYpc3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EA610F34A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785516233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ltyqZW5ZfqrwkkeZqLpjTnozgkU+0DHxMfwj6ZzMkA=;
 b=gFydYpc33KMeyUtlZ+wdcpd9Zrkj6hRQc2DMyip7OeGEAgTP1wPYbdtO2cC171wrOE+Q1c
 Y6tGGnA2G5Lrf5fxxeHOzusu3c/wqMOlrWIrrtUewfiTLruV/oNjIrYhwexWMal0m9KJLU
 7H7YR+YgC2JOU3mJpdlRg2ClAPE8xnA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-xM4ioFRUN_GWOYcJJ0Cmzw-1; Fri, 31 Jul 2026 12:43:52 -0400
X-MC-Unique: xM4ioFRUN_GWOYcJJ0Cmzw-1
X-Mimecast-MFC-AGG-ID: xM4ioFRUN_GWOYcJJ0Cmzw_1785516230
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15d4224f9dso96562066b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516230; x=1786121030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ltyqZW5ZfqrwkkeZqLpjTnozgkU+0DHxMfwj6ZzMkA=;
 b=YtrAtaaqIRyJKY3/2LdhzIs3eTPmvGa/jxnziww5sS71xtE8w9DipZY7gIxnwRWfmD
 fQyDURY4S7/u618ZZ/3tFAfg9FtN1aRo9/EoIi1fN6T4drp/MkvMyjlJLkPGjzUbdmkH
 G2Mh91rJCEurYd6oWz+YKMIK5SiE8DjPDkvqemhkZAvW9lJqCuf4s1loQpgERXdrUcHP
 a8xQY6Hca4zE6ZWIWieoPHbdVKh6Ijfd76xdLoDIscJ2SEhmLdzBp/iFYVN4Scnnjjj6
 2CUH8aQwCtlsfue7ZgjKcKWaH4dR3KOX9DAbArGgm41AbJBE6gIbtD7WSanOcRTadGtS
 hwyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOrkxFJ+n65gn0zMoQcZhybTibXnS1OE4bV58xZGZzfXNLgkelslb1k8gnmK7DRycJUXJ6KBWo8N0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMvz26Kgg5rnSUnxoy7zgn4KYP+05bcdGRjumX1xeYY5H/K+5Q
 C5ni54wfz/0W1tlbfuJ+MAgmcJhUh2Oc9Hnab7kRwu1C9Gs5+sS8NSlqUXP18JbFNO3mIrHK5u/
 oRWZYrpQ3TCH695sZweTAHdzOG9Az0YnriP8Dm6VENtXx+K3z8hqEHDgaj17f1L3oTnDCYA==
X-Gm-Gg: AR+sD11Zar58XYjGI91N6g30PSOH+gP7r5iFfxhc3jndSxzojPRRG/AE03rqrUGiy09
 N7EuSSIG9UfTzU1f74cQObSsTn+wIUP33x8q9EfLZ80NykD0ShQNXn/XGxZcGnRzsCrT9xFlD2L
 ZWLdWQp3Er2S95m0r3/hLB6BjAuDUnerfXFgghLOKSMH3s0SQTweHQZh4P5RjLqlnH3bK/Sbr5I
 Ajbvk+BjsrI28y2k4Iv/5h1pGImPzw4BP0rDMxwRHCseiWtSvqzfNf32W8Fq5SAb0swp+zzsuoA
 tUdMDEuWxMizl3HJsED5R581V5B/7n8dq+V/dE49205WhV9VIgBKoTjmLm20uAVEWTw83k0QTFM
 Q6/2m5EsgTy4XjHSuFhPGxe5XilscE9C4Jj2Rv92qiBXHtC2o1OUNAGwMB98Xmk3VsWm2kllLff
 gNg50=
X-Received: by 2002:a17:907:d1f:b0:c1f:17f6:2a74 with SMTP id
 a640c23a62f3a-c1fe7fc540fmr36349066b.9.1785516229935; 
 Fri, 31 Jul 2026 09:43:49 -0700 (PDT)
X-Received: by 2002:a17:907:d1f:b0:c1f:17f6:2a74 with SMTP id
 a640c23a62f3a-c1fe7fc540fmr36346066b.9.1785516229473; 
 Fri, 31 Jul 2026 09:43:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4537761sm215223766b.52.2026.07.31.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:43:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH RFT 2/3] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Date: Fri, 31 Jul 2026 18:43:40 +0200
Message-ID: <20260731164341.1109827-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731164341.1109827-1-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KBwYWLV9cZeYV3_WGscgyihCMe_Jnb5n1wop8u30G70_1785516230
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
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index c989459eb215..33a14f558276 100644
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

