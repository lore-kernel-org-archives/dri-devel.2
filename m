Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA36075A6A
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a/9qpVb7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7E710E514;
	Mon,  2 Nov 2026 16:00:54 +0000 (UTC)
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637DE10E514
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:00:49 +0000 (UTC)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3849212eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793635249; x=1794240049;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:date:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qdDzCJX2QhExG4+G0pbTNThq0KYMMur6UF4zTamumCc=;
 b=a/9qpVb777687rYMb2lEIb9UhFCD0ZMqmffB2gBMW3/JzTvKnWep00d9SlgiL5VNQk
 KevCZGwnRC19fhK6v9FK557HIzX/JpX0bT5IHxzOs+Nx2e92JplKQZouKwHp7vsBNx5q
 gbT2M8QfL0/Mpxg/4mGowLCH+ynT2HqtXfTB2i1QOt9ufvZ5C6+SW91YziJduZ9/W2VN
 iJdhjUrmj4eoo3hSTdMi4xaSG9n5+KbSmxjXPf1vM6bqa8XsybLK2EwP30x3xkBc/yuX
 zi8Vkyrsisa6p7zByVHYqzRiekFJZU/p1eGCpCEILKkHewdqmGnN0m8brvctW36zPoWf
 iOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635249; x=1794240049;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:date:mime-version:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qdDzCJX2QhExG4+G0pbTNThq0KYMMur6UF4zTamumCc=;
 b=yu1fJZPCjS9IWwbqxNms0oBS7s/8H5k/Sul6DXjy+bS73WyScI2zc8em0G9mPZ2kFD
 v2PbZ3g5W7ujZ9w2Elo1fZlrnK4XInwhn/qVxhzxFKyltlR2lvsgUWWVt/83MOo1LbBQ
 KckppczL9vQqGys6NguFZ59iOLVMCsZQtaXlBTCVy8twxKUc9b3FUPeUh4ZDkxaX0b4v
 SB55eC0CL371cTk5NR+drt4zz8QzWYxAhqbGNB9SWqOprl32T8YW36HH6+AMx+aSaRTN
 Sz6J/onLkafAan4HjJfaH/PfM1qijM8Y9G0Yt2wqpvogs1Oe3slw/2hpmJ3mWdbAPkzu
 RB6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ4M3UMsPed5VN83RsRoQUVS9TkLqTzFBwY1DzCRa1i8iCC9bUzul/jKYpvtusa4FWwN+hPN9fvFE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jsUjVQfrZflmYPaq2Yd3rxiPqgxmbWPSxUzFIM924pl16h5yV
 /o9arJiUcMUxtEnUZDv/UdufVHwc8bymCfLsS/P9UVbWj4DurvHkGamqieid2CTWkVUrCItZ1vZ
 T/NLZ3bDSNTFw8JaX+nBLLySpQoGwUA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: from dyhb15.prod.google.com ([2002:a05:7300:148f:b0:368:927a:cdaf])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:3a95:b0:36a:12c4:8bdd with SMTP id
 5a478bee46e88-36a42389979mr18350254eec.21.1793635248187; 
 Mon, 02 Nov 2026 08:00:48 -0800 (PST)
Date: Mon, 02 Nov 2026 16:00:47 GMT
Message-ID: <18e445c150434665.3137322e32332e3235332e313736.109a67.0000sendgmr@google.com>
Subject: [PATCH] dma-buf: Reject private mappings in dma_buf_mmap_internal()
 and dma_buf_mmap()
From: Chris Wiseman <chriswiseman@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "T.J. Mercier" <tjmercier@google.com>, John Stultz <jstultz@google.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DMA-BUF mappings do not support copy-on-write.  Mapping a dma-buf with
MAP_PRIVATE and PROT_WRITE faults into do_wp_page() -> wp_page_copy()
and allocates private anonymous pages whose writes never reach the
underlying buffer.

Individual exporters like cma_heap_mmap(), system_heap_mmap(), and
mmap_udmabuf() already require (VM_SHARED | VM_MAYSHARE), and DRM
helpers like ttm_bo_mmap_obj() and drm_gem_shmem_object_mmap() reject
vma_is_cow_mapping(vma).  However, dma_buf_mmap_internal() and
dma_buf_mmap() do not check for this and pass MAP_PRIVATE mappings
straight through to dmabuf->ops->mmap().

Reject mappings with -EINVAL in both dma_buf_mmap_internal() and
dma_buf_mmap() when neither VM_SHARED nor VM_MAYSHARE is set.  Checking
both flags still allows read-only MAP_SHARED mappings, where do_mmap()
clears VM_SHARED and leaves VM_MAYSHARE set.

Suggested-by: T.J. Mercier <tjmercier@google.com>
Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
Note: For the prior discussion Christian mentioned, commit f91142c62161
("drm/ttm: nuke VM_MIXEDMAP on BO mappings v3") added the
vma_is_cow_mapping() check in TTM, and commit fa5239f2af98
("drm/amdgpu: workaround failed COW checks for Thunk VMAs") worked
around a legacy ROCm KFD Thunk PROT_NONE, MAP_PRIVATE mapping on native
amdgpu GEM nodes.

Tested in ARM64 QEMU (Linux 7.3.0+) across /dev/dma_heap/system:

  BASE:
    [CASE 1: MAP_SHARED O_RDWR]     ret=3D0   buf[0]=3D0x00000000cafebabe
    [CASE 2: MAP_SHARED O_RDONLY]   ret=3D0
    [CASE 3: MAP_PRIVATE PROT_RDWR] ret=3D0   underlying_buf[0]=3D0x0000000=
0cafebabe
    [CASE 4: MAP_PRIVATE PROT_READ] ret=3D0
    [CASE 5: MAP_PRIVATE PROT_NONE] ret=3D0

  PATCHED:
    [CASE 1: MAP_SHARED O_RDWR]     ret=3D0   buf[0]=3D0x00000000cafebabe
    [CASE 2: MAP_SHARED O_RDONLY]   ret=3D0
    [CASE 3: MAP_PRIVATE PROT_RDWR] ret=3D-22 (-EINVAL)
    [CASE 4: MAP_PRIVATE PROT_READ] ret=3D-22 (-EINVAL)
    [CASE 5: MAP_PRIVATE PROT_NONE] ret=3D-22 (-EINVAL)

 drivers/dma-buf/dma-buf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 1ccaffabbdbe..51e9a4dc56be 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -235,6 +235,10 @@ static int dma_buf_mmap_internal(struct file *file, st=
ruct vm_area_struct *vma)
 	if (!dmabuf->ops->mmap)
 		return -EINVAL;
=20
+	/* check for private mappings */
+	if (!(vma->vm_flags & (VM_SHARED | VM_MAYSHARE)))
+		return -EINVAL;
+
 	/* check for overflowing the buffer's size */
 	if (vma->vm_pgoff + vma_pages(vma) >
 	    dmabuf->size >> PAGE_SHIFT)
@@ -1610,6 +1614,10 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_a=
rea_struct *vma,
 	if (!dmabuf->ops->mmap)
 		return -EINVAL;
=20
+	/* check for private mappings */
+	if (!(vma->vm_flags & (VM_SHARED | VM_MAYSHARE)))
+		return -EINVAL;
+
 	/* check for offset overflow */
 	if (pgoff + vma_pages(vma) < pgoff)
 		return -EOVERFLOW;
--=20
2.51.0
