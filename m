Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6AE1061B21
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D489810EA1D;
	Tue, 31 Mar 2026 10:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OoUjbDYI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3971210EA09
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:00:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEAE260123;
 Tue, 31 Mar 2026 10:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE4C2BCB3;
 Tue, 31 Mar 2026 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774951230;
 bh=FW0dQAbf77gP2JI3DUHh/5HKOkFfWCP2QQfOOyILTUY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OoUjbDYIQaQ3VSdGFwz8NRODvH9y/n3Kkmc5lP4aaipNKjSHtzPw5pFG8oZBl2/gI
 5mK06fcq0AcR6L/LGS4bToqUCyKZUejqaLW7JzoKZlbCefXVWzV45V9IpFIlfqucWl
 6nsG2TRceTEHqy6fbfjhcfWv90GPOEt027/3adzAiymJ6u8qygO+SCe2Xpzv4OtN77
 QRFrJ/2Ex/myw6Zu3odAvIdWHW4MEE/uPKHyHmWn1IFAStzHxyVvrvqN7PoNpIGwgY
 OnEKmBZU/HrGi4Vpb1ux4jkASJ8SYex354JGDwvITT1XtE85z3C8XOXtu6fwXR8FEn
 AAHytpNI+yrjQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 31 Mar 2026 12:00:12 +0200
Subject: [PATCH v4 3/8] dma: contiguous: Make dma_contiguous_default_area
 static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-dma-buf-heaps-as-modules-v4-3-e18fda504419@kernel.org>
References: <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
In-Reply-To: <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FW0dQAbf77gP2JI3DUHh/5HKOkFfWCP2QQfOOyILTUY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJmnZ+s/e/ZI4PqR9yY/Xv2e9P7GTx+Hqt23ZZsm/t3/8
 m7MtzMvkzqmsjAIczLIiimyPJEJO728fXGVg/3KHzBzWJlAhjBwcQrARK5xMtb7e4p+fx8c3r9n
 ecNvh6Ritgs5Ik+WW3MbPvTVv72DR1/owof492YHrXdNEOpep3SVlYOxTl/UReeju8LsBc7JSjd
 Vp3o+v/dEV6GB+ckzZz7BWqd/l3UkL1xIyn4UvvJHes76jRlKAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Now that dev_get_cma_area() is no longer inline, we don't have any user
of dma_contiguous_default_area() outside of contiguous.c so we can make
it static.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/linux/dma-map-ops.h | 2 --
 kernel/dma/contiguous.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 8604106c0c01b6a9dadc45263f3b1d9ecfacd4aa..bef279ebeae7de59dd504e631f47c64d7e223736 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -89,12 +89,10 @@ static inline void set_dma_ops(struct device *dev,
 {
 }
 #endif /* CONFIG_ARCH_HAS_DMA_OPS */
 
 #ifdef CONFIG_DMA_CMA
-extern struct cma *dma_contiguous_default_area;
-
 struct cma *dev_get_cma_area(struct device *dev);
 struct cma *dma_contiguous_get_area_by_idx(unsigned int idx);
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 40a0ead24979cfdf25e4779545536a5438e26356..fd8d3518a2323f0a631fb185ef92a24c35f8d25d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -81,11 +81,11 @@ struct cma *dma_contiguous_get_area_by_idx(unsigned int idx)
 
 	return dma_contiguous_areas[idx];
 }
 EXPORT_SYMBOL_GPL(dma_contiguous_get_area_by_idx);
 
-struct cma *dma_contiguous_default_area;
+static struct cma *dma_contiguous_default_area;
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
  * This is useful mainly for distro maintainers to create a kernel
  * that works correctly for most supported systems.

-- 
2.53.0

