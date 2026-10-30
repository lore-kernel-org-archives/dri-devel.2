Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FC606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PjCVPXp9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8DB110E8F1;
	Fri, 30 Oct 2026 20:44:19 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D7210E8F1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:44:14 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-351788121cfso5077139eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793393053; x=1793997853;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:date:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DSlnmf5Y/dE13YqistFiwJnejRPeyo3JQxaBXnk1KRU=;
 b=PjCVPXp9r7uolmpTZi8lrWTT8QkI53RPqHPV+zADXxMRV0cCvoioA2sKXI8PLiFJzn
 c84lHsob6sFo3CXLE1z8u4GZoN+hSmwJGL+nrlf9U2KF34VbdgLxG3p5D1y0dQrlqpJ2
 XL8TDJHge97UjsN7nyVegqX5tHnA/VTbxSSgpCRlY2wNYXUW8VsRoXa12tGyu6OGMDBM
 DDl6Ctiwhqtnz89AkfIP3iYvCjBLj/7J2alOd0yYABcSF9+VUBU+87pUxsIdjs4AVSJk
 R/pi3vVf/G1C4mFflT/Ix4eiakBYq2CMrMCgHfY4CTfnS01U1XdLrMwhAO7CEIuPc6/E
 TaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793393053; x=1793997853;
 h=content-type:cc:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DSlnmf5Y/dE13YqistFiwJnejRPeyo3JQxaBXnk1KRU=;
 b=y9H8Qq1g3XP3X2Aq+P8ocSVXaL3NnTJBP0HxL4InuH6HPQq6B6aEZoIwRRf1Ht0WQC
 Nq4i/VjRDU1byYZHC99dUdBRx+TdUkvD5yryo0xgWOfqMjpy3Qbr/WkvhZqwbldlXDj1
 eUwgQxfBIcV7FU/x2aQTDe2WzPQIDls9uXoiPlBn+fDxO+Vm/4ieqxTvw8YI6DufdmQa
 zSPtyqOmql8vY+JdWOkgMYIVijV0qA22o+T72tur77yuN9Bq8zwka9b/a5zkFmrHD/xU
 8gUSqURwXQ73NtkKB0Ydeb5g1yOZiXUXm4PrBxIgubdLyxDy/hzF10q3FSUGA7zMEsdI
 jdvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBytsirGpQcaoZFKlGxBDwTSvUa4Mem4fOqjrIba5BJx63a87g/Fn3t4b5GnfQTOPsZAOaJgzxB6ihM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLftwX5s0dYpo4Ig45B4czNsuI/UxJPerdcwnTDu6CdnW46z4Gi
 vAJ7iuESTOKDZif7NiSheNzwBG+uWmFfqjvvR/pW62saN6BZH7p1Dkbz8jCuFzge/JX6PQqeBdD
 7+4avwFDV4Tm0jqGfoKHSzjA5B5sIUw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: from dyaz18-n1.prod.google.com
 ([2002:a05:693c:6392:10b0:36a:15cf:f589])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:88cb:20b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-36a423e8150mr4993140eec.26.1793393052930; 
 Fri, 30 Oct 2026 13:44:12 -0700 (PDT)
Date: Fri, 30 Oct 2026 20:44:12 GMT
Message-ID: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
Subject: [PATCH] dma-buf: system_heap: Reject private mappings in
 system_heap_mmap()
From: Chris Wiseman <chriswiseman@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 "T.J. Mercier" <tjmercier@google.com>, John Stultz <jstultz@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
use sgtables instead of pagelists") stopped using heap_helpers.c and
added a custom system_heap_mmap(), the check rejecting private mappings
was dropped.

Other exporters and buffer allocators reject private or copy-on-write
mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).

However, system_heap_mmap() omits this check and calls remap_pfn_range()
even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
fault into do_wp_page() -> wp_page_copy(), silently allocating private
anonymous copy-on-write pages whose writes never reach the underlying
system heap buffer pages.

Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
cma_heap_mmap() and mmap_udmabuf().

Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use sgtables instead of pagelists")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wiseman <chriswiseman@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 1ef1bb3acbf1..f668dc8cb54a 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -235,6 +235,9 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	pgprot_t prot;
 	int i, ret;
 
+	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+		return -EINVAL;
+
 	prot = vma->vm_page_prot;
 	if (cc_shared_buffer(buffer))
 		prot = pgprot_decrypted(prot);
-- 
2.56.0.317.g454f8302e1-goog
