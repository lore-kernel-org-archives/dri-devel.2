Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC1C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898C310E9F0;
	Tue,  4 Aug 2026 12:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jHbVk6QC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9802B10E9ED
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785845159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
 b=jHbVk6QCKqKNCl+D2UdriymNdAm6vI+PJsfob7uHdarOfY7B7zUd3Y05n6n01gAUPeW0fS
 ToDe2bQdKAsaRsJSojbkklFHfzj7yL3cMAmR6wHsDM7pHdUEDd9mtv+wGxE6TAYD3u2K5B
 YqpKDLCSMRK7qKOi0tefEBREilSMjXs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-rk02zOgwOE-jIwGtu1L1cA-1; Tue, 04 Aug 2026 08:05:53 -0400
X-MC-Unique: rk02zOgwOE-jIwGtu1L1cA-1
X-Mimecast-MFC-AGG-ID: rk02zOgwOE-jIwGtu1L1cA_1785845152
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso28411055e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785845152; x=1786449952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6MKpfy5ngorVqbj+qf8v5CmiQT/j6dhAeNWojtcyJWQ=;
 b=NnoAcQyE5peVXezYKxp/FJB1JsaLm9vlRyrIdzSJrHV5QSthA6gN+HCzZXxhTWxBHE
 ytWCZZRF9N7hTjMhWeR33S1z6ct3AcEVeLstlv0+9v7WR5jNJRWaPl7boe1DvZgBzgDR
 /dqyMAdkJy2eCfeTSuW66pghjwjAaHGPV42PvQqPsf4oL7nHjNm7UhD/BvS7aqKPR+XU
 Sku/6aUrzhat4AQLW/edm2+IkVYFmNWXzx59/+qHm8ojkxj+QnHDTfKqBOmA2tzZRy4M
 SYn8LWSIwRKy6blgx3kHPYYP7Ky+YJXEmB1ofreKTSy904QYIVwIGk9SaOzXH5eD+sbf
 VObw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBNYvzoCrPAbDo8MQ2gm7UzxID2q7KmozKULWiojyCAD8DrNYDm2m1hYYJnhqTDsW2ynKo0YLBunU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGsYU+iDEbKCI+JWHKFLC9geErLzttKZpAS540z0i4+pUwF2cI
 IUNvdCFfJLr7EeyevwNvkAex+atBjNnJAMCYgtALvpHfiXFTl1KNXBV6tP1UPqfmbC1Py1LGSir
 0hVpWWdnSkES1pFaXaKmu7yfwm+mffObV/UE5sfPsw7bPVSxDxH2sK/Iss6BL3rTyCCK2q59s8f
 Ui5w==
X-Gm-Gg: AR+sD13Ql8gfv6ASK2sGA4uYveOXZRdRCQdZZUMU44SqUUH2qmh7m+tX1+EhygKeO1s
 vddKHv4udGA4p4vzcIFVZWMpilOVPJQnQ+X1Q6LTZXeCGQg/+oABw/ydro1yWpPSAD79Oha9lOQ
 nIudB6dn9pLy8z2W1tvmpiS/x1nywpICAPqe5rbtJkSv0rXB7Z4DlYEJEKrpoHfDQVfEeprxxn2
 t2I8NqoBfKXogYshQduV3CmGQG2xMUTtbvHg2GKMzioJA/I+OLrsr5AcNJlsVArG15voYJhw9dp
 G7/J/a+vkKsqai9EoJy/VPY3ZxSr3dNs3LDTPd/UJmYrQZhI4rQzjU/qv4R61nQMtVdTjJ5IPsd
 T/JfrmOfmf1vSn4qYumJzzLVtzDnE1bVHp8mrznL41/wIXbyXsT63kMAzNVJd+3YZb6so/9X+p3
 KreIA=
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id
 5b1f17b1804b1-4980c60705amr298312195e9.0.1785845151887; 
 Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:493:c42e:5be0 with SMTP id
 5b1f17b1804b1-4980c60705amr298311535e9.0.1785845151462; 
 Tue, 04 Aug 2026 05:05:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fd8df5sm88354535e9.9.2026.08.04.05.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 05:05:50 -0700 (PDT)
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
Subject: [PATCH v2 6/6] kvm: return -EFAULT for writes to !VM_WRITE IO mappings
Date: Tue,  4 Aug 2026 14:05:28 +0200
Message-ID: <20260804120529.1730187-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5wPWbk7uYAIIS1Z4fsZsaMKCMaxK6E5XkK731H5b5Ec_1785845152
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

KVM's behavior when the guest writes to a non-writable VMA is inconsistent.
For regular, page-backed mappings it returns KVM_PFN_ERR_FAULT and thus
returns -EFAULT to userspace (which is ABI, and relied upon by tests);
for VM_IO/VM_PFNMAP mappings instead it returns KVM_PFN_ERR_RO_FAULT
and thus exits to userspace with KVM_EXIT_MMIO.

This behavior for VM_{IO,PFNMAP} was added by commit bd2fae8da794 ("KVM:
do not assume PTE is writable after follow_pfn"), and even if it has been
in place for five years it is unlikely that it is relied upon by userspace,
since it is inconsistent with KVM itself.  Change hva_to_pfn() to return
KVM_PFN_ERR_FAULT for all non-writable VMAs, and restrict KVM_EXIT_MMIO
to the case of an explicitly read-only memslot.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b7c21a48a45c..da5b0bb62590 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2999,15 +2999,10 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
 	 * or the page might be absent.
 	 */
 
-	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
+	if (vma == NULL ||
+	    unlikely(!(vma->vm_flags & VM_READ)) ||
+	    ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE)))) {
 		pfn = KVM_PFN_ERR_FAULT;
-	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
-		/*
-		 * Exit to userspace for PROT_READ mappings in a writable
-		 * memslot, as this is part of the API.
-		 */
-		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
-			KVM_PFN_ERR_FAULT;
 	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
 		r = hva_to_pfn_remapped(vma, kfp, &pfn);
 		if (r == -EAGAIN)
-- 
2.55.0

