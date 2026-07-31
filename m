Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1651EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B06D10E224;
	Fri, 31 Jul 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Q9nXScPb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BAE10E224
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785516226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lSuYcaNlXmC2iii63pednXBAuDRAZROOC8ripxWX5Fw=;
 b=Q9nXScPbp3FqklxVoPZAiKjvAtgqi8UBlgPDfDvtGFFyN7R2QVj2JZeOR8Cesm1FSi3mr8
 /m0n+J+f3tW0F9h6l7IaTJuf4ZipxCgQtxRDoO5JMadbmO5SH14m7YZYYCCa1DXtzNFY/D
 eCmnYfsPslwbc/gAYU3K1gNRjO4XRLY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-szM2ev8XNpSNRDLZRpVCOA-1; Fri, 31 Jul 2026 12:43:45 -0400
X-MC-Unique: szM2ev8XNpSNRDLZRpVCOA-1
X-Mimecast-MFC-AGG-ID: szM2ev8XNpSNRDLZRpVCOA_1785516224
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15e6109f9aso96485366b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785516224; x=1786121024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSuYcaNlXmC2iii63pednXBAuDRAZROOC8ripxWX5Fw=;
 b=ZuIABbB5xl6nARrUHT0sudcMDxgqD763zS3Hy+jToPfgdLiDFmraVab/2JB/qDGmkN
 0eaw0kCbkan01Ku1LYZsiueKPSogOJPYt+Kz0A7Bvta7bpgFopYf+V6qTOWEg/6LvbsJ
 l2OgFblDHT+9HyPEtZ8oSh9kZfCNP/9YK76FlKDgn7ixs96LcMsQUBgaVpHfKo3JOdOl
 3CYA4jrCkvPoMN+bBo/QKdqkVex71fngI9dn9+EUycNnYZrUs4UtA1fOIJqi9L+vrvIO
 zohSIc1sSX80rts8xg/mC1MbI2bGlZBKo333DmlmVWyjELIlfKzOaHCF036cmu30P04w
 k1/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+zHFd4VIqGzjsRIPfdpKfmhTP3X4o8o5q7lvCuvR8giP27/nHXtLpkyXr3yn1/n55ipydln5SK8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRN3AdS/iFrDW3Ls4nzLoi2A0r4qWaqUwn8WD+HJX4GWj85vxF
 I5Nf2386n3N+VRUfRFOJ7yMS5SPV7LbbaeeJXGLvS6XXh9/FyLQfGvl4V2lSSl4hAAQOoBwUZyS
 sRJ3bKR0NK0eQzre11LWIYnqgFB/clPpf/o6SQ5jwoAv0kXKczFpU/nC0Q9uQnPF71bRv+w==
X-Gm-Gg: AR+sD136m/7nHQbRHk4bUpZCpfziRUhudQBDCjAMl719h/potoZyesMPvaexlAzN1P+
 UYMxh884+PoRiDRuAFPDCzzNqJawsyBA/jNc37Vfuxf7v67UbPJbNwSA59BOZFXyUypZUbd9w9i
 OT5qDFNbqKse2BJ1rIQD29VBxFGVkTaakK6x4Vgj9ONOfT6ajt0bZI5j9EcW0vw6XX5U/TwHQDX
 X6nrUQgnhUNwqjRuQJRSnRCGVHJnytMxKTEioQNHiczVfTDHEY/p+XvnlvXn2pgM4tfsrJO5+dG
 XE8XRcnUZl0cF9rQKyvRL4CRH7P+eZls629UOHjlD7BBmpTY6VOY3bzhTF6YCtFKV6meo1wOD2U
 aEsjJMH/tUQnEXb1iapa9ssds0YIjwkpYh+dAzP+kXNaYN/3AdFAdwF01ZwY52hzK4jgVhMBq2n
 cG7YU=
X-Received: by 2002:a17:907:e001:20b0:c1f:7c45:2dfa with SMTP id
 a640c23a62f3a-c1fe7ea4b7cmr19853566b.7.1785516224105; 
 Fri, 31 Jul 2026 09:43:44 -0700 (PDT)
X-Received: by 2002:a17:907:e001:20b0:c1f:7c45:2dfa with SMTP id
 a640c23a62f3a-c1fe7ea4b7cmr19852166b.7.1785516223725; 
 Fri, 31 Jul 2026 09:43:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd455ab7dsm206911266b.58.2026.07.31.09.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:43:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH RFT 0/3] mm,
 drm: ensure .fault() does not have to be followed by .pfn_mkwrite()
 for write faults
Date: Fri, 31 Jul 2026 18:43:38 +0200
Message-ID: <20260731164341.1109827-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LQgli3FSoMqTP7dxfc2dVJFlFPFQKRblMp1oQpQnehU_1785516224
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

Warning - DRM parts (i.e. most of the patches) untested; I have Cc'd
the reporter to help with testing these patches.

Right now, users of .pfn_mkwrite() have no way to create a PTE
that has gone through maybe_mkwrite().  Because vma_set_page_prot()
will have cleared the writable PTE bit, users of fixup_user_fault()
will see a read-only PTE and have no clue that the page needs
a *second* fault to reach its final status.

Handling this in fixup_user_fault() is problematic: the information
about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
which is an opaque pgprot_t, therefore only follow_pfnmap_start()
knows how to retrieve it.

There are actually some preexisting functions that suggest how
this is supposed to be handled, namely vmf_insert_page_mkwrite() and
vmf_insert_pfn_pmd().  So, this series adjusts mm/memory.c to export
two new functions vmf_insert_pfn_mkwrite() and __vmf_insert_pfn_prot(),
and then teaches drm's two users of .pfn_mkwrite() to call them.  Let
me know if I should use another name like vmf_insert_pfn_prot_mkwrite(),
instead of the "__"-prefixed one.

The drm_gem_shmem_helper case was reported as a KVM regression, while
the vmwgfx one was found by inspection of .pfn_mkwrite() implementors.

Thanks,

Paolo

Paolo Bonzini (3):
  mm: export variants of vmf_insert_pfn* for use with pfn_mkwrite()
  drm/shmem_helper: use vmf_insert_pfn_mkwrite()
  drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is
    in use

 drivers/gpu/drm/drm_gem_shmem_helper.c     | 38 +++++------
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 44 +++++++------
 include/linux/mm.h                         |  4 ++
 mm/huge_memory.c                           |  2 +-
 mm/memory.c                                | 75 ++++++++++++++++------
 6 files changed, 107 insertions(+), 59 deletions(-)

-- 
2.55.0

