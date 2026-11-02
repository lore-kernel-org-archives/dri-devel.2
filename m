Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F467606A336
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VXht3yQo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F5610E61F;
	Mon,  2 Nov 2026 12:23:02 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E431710E61F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 12:22:56 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso12903115e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 04:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793622175; x=1794226975; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=abibISRiUwSvMFecqGaDadoCAJ+Fmjo80Pp9RI6LfO8=;
 b=VXht3yQoq8vNUFmKMCfBK9ehv01lIr8dgbrFBeh/FTaDislQLpp+Ll2avJiEncDQT9
 fUrcU8FyNe09Z6aDMd4PG0pwQ3qcAXpynXHqkZuDBXDrME04kkFqlvHT24ClWoCC3mhN
 TWjlMm34V3qseQ8OWXvGS0vEq0pszptHdkfeO8EFuNUo1bnRfJOaoYZES7DCKBMj+ryj
 wsaljG2tplZSoC0+pwyG1PmAPLuX3AB9uDu9LWUYp1tery8UOlD6/ZMVNG+gK+ATuGSb
 7CXbyF55MPasi5krQCj4yEWGT9sTtj2SB6XwOAon2xfj/hfAA/eJEsk9eIRojVN6vuuk
 6fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622175; x=1794226975;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=abibISRiUwSvMFecqGaDadoCAJ+Fmjo80Pp9RI6LfO8=;
 b=mMWci+qn9AceTGwSuw44p5YZV/IwApH/jAV/mQDFiAaKrpcfmbPYJMOvKejvuNYe/v
 yIy8IcPcjTz5vBUvIlM9tGxpbrp3g3QAbCxZt+Zp3lrMkI8KG4lgT/D3XpIIiJqa+Bmq
 iHe6FoT92kVkpdD9Fc8e0YluO5HaobjkDpvgHS03fLZhEl/5D+EcofKCjqzz21HI5MPv
 1BuK60KlFF4ZW8Ae1MJwZ7uMqXgim5SJYQSjpzCiFJblhif0pJyfd3L9yjZbSbYLzvE4
 A6uw5OWGQ5JXjvhJuHdZWFMbr5lQVoImr2WURX8ufWUhibIAk3QvqVsmTRlVyb2nfG8h
 BVow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx8TH8DIoDjdHv1NOuErvrb6ozOW10H+AMwTNI+FBJ9hLVDD3PW2O9Le0F6fFb8eiFdWStKl5X0X4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL9VYuAk+oAlPyfdcWAL7Kjci+Tq5pFBkAtNH9fGtUnepcCqJ2p
 xA+vCNfsvLgTeIyrdoxgW9y0iEPOrFIegYmPiqVERgjtR39aMajMBPXc
X-Gm-Gg: AYBFou27v9j9SQOzcHACzKIFmf2uf/i9HOCksFkqU33y3Lw8Vt2w/zKmf4y0pUZCXhU
 930JMfh2nCZMh6mOJOagRuEGc4vv3YvGjzwH9RWIxlY8S0Y/s2/T/9v79RiymdLxSDW5v3jLAWF
 J7K82NNK/Cp03rrwfs46j5qFrR1ggWyy/nAOAmuIpgsLYIDVxIG0YZIIinJ0Ujj9MnXVKTLWd7i
 EV1wn+crV1inL8nrwO619/RGdj+iZ+5R/7KIkgJxdGV4GLC7sMLw0QTXlKfCe9cZSLyu80Xye5q
 Qdpjck9Kr95i8sLRy2o+qb51R8Avazf2QvpaSdi5ZkJcYIJXdopZMVFehM409yw+XH+MoXTbAnS
 5H/bv+/SPrWNB/nIaDUFyMV5w4wKo3vSFCpMJAsU6WhQaSi4KfoouuyRWfIU7L3b9q7Iz114s1D
 RGY8YfRF/69nyOQWCNXTmvez6w+DwhoDPIEBUGLAN+Pyq4ILRFSmn5Pf4c77HZmf6oWyc5SJTxf
 V+lD0wzsJVAReoCKEzUZ1YTpPEddVFXGiN3JgONnNTjfRHcrEmI9kaqd9vgFbWyXFTUkl1JZQZP
 mPdpqPrDA5KvsdPbFTmgukaV/NShbMzfoLmTij3Z1mzl7Fxh5M6JpB2AUcEXE91ZH4i5VCknQXA
 banLLWXeTyjTD7YokHPQKq+d5+5eHuIwju1Uj6kw2rJibdQFjakKr
X-Received: by 2002:a05:600c:46c8:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4ac16acfde1mr240738005e9.6.1793622175008; 
 Mon, 02 Nov 2026 04:22:55 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b79059sm20361252f8f.30.2026.11.02.04.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:22:54 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 02 Nov 2026 13:22:51 +0100
Subject: [PATCH] drm/etnaviv: Cycle through the MMUv1 address space again
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-etna-mmuv1-iova-cycle-v1-1-1148f02da254@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNphg5eRRxKTTWgVVotinh3i
 +Mb/n8gS1LJ0DUPJCmadYsVpm3Azy5OgjpWAxNbY4hRjuhwXc9iULfi0N9+EeTgSSwTBWehtnu
 SoNf/7Yf3/QBCPcBNZwAAAA==
X-Change-ID: 20261102-etna-mmuv1-iova-cycle-2fc0e6200fa6
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

On MMUv1, all clients share one address space and the allocator
always picks the lowest free IOVA. When a process frees a range,
it can immediately be reused by another process.

The GL.FLUSH_MMU write before the next submit does not reliably
invalidate stale TLB entries for that range. The GPU may therefore
continue translating accesses to the old pages. Writes through
these stale entries are lost for the new owner and may corrupt
memory that has already been freed.

The vendor driver works around this in a similar way. It does not
return freed MMUv1 ranges to its free list until the address space
is exhausted.

Restore the address space cycling for MMUv1 that was previously
removed as no longer needed. Start searching after the last
allocation and only wrap around to the beginning before trying
to evict existing mappings. This keeps freed ranges in the
allocator but delays their reuse until the search wraps around.

MMUv2 has a proper TLB flush and keeps the current behavior.

Fixes: ccae45928fc4 ("drm/etnaviv: remove cycling through MMU address space")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
index e3572461b599..c4e4dd3d4235 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
@@ -141,10 +141,20 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 {
 	struct etnaviv_vram_mapping *free = NULL;
 	enum drm_mm_insert_mode mode = DRM_MM_INSERT_LOW;
+	u64 start = 0;
 	int ret;
 
 	lockdep_assert_held(&context->lock);
 
+	/*
+	 * MMUv1 does not reliably drop stale TLB entries on a flush, so a
+	 * freed IOVA that is handed out again right away can still be
+	 * translated to the old pages. Cycle through the address space so
+	 * recently freed IOVAs are only reused once the search wraps around.
+	 */
+	if (context->global->version == ETNAVIV_IOMMU_V1)
+		start = context->last_iova;
+
 	while (1) {
 		struct etnaviv_vram_mapping *m, *n;
 		struct drm_mm_scan scan;
@@ -152,10 +162,16 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 		bool found;
 
 		ret = drm_mm_insert_node_in_range(&context->mm, node,
-						  size, 0, 0, 0, U64_MAX, mode);
+						  size, 0, 0, start, U64_MAX, mode);
 		if (ret != -ENOSPC)
 			break;
 
+		/* Retry from the start of the address space before evicting. */
+		if (start) {
+			start = 0;
+			continue;
+		}
+
 		/* Try to retire some entries */
 		drm_mm_scan_init(&scan, &context->mm, size, 0, 0, mode);
 
@@ -215,6 +231,9 @@ static int etnaviv_iommu_find_iova(struct etnaviv_iommu_context *context,
 		 */
 	}
 
+	if (!ret && context->global->version == ETNAVIV_IOMMU_V1)
+		context->last_iova = node->start + node->size;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
index 7f8ac0178547..7fa6e3ab427a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.h
@@ -75,6 +75,7 @@ struct etnaviv_iommu_context {
 	struct list_head mappings;
 	struct drm_mm mm;
 	unsigned int flush_seq;
+	u64 last_iova;
 
 	/* Not part of the context, but needs to have the same lifetime */
 	struct etnaviv_vram_mapping cmdbuf_mapping;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-etna-mmuv1-iova-cycle-2fc0e6200fa6

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

