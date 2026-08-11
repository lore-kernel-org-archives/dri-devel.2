Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D25C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A2610EE73;
	Wed, 12 Aug 2026 07:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YsroEjYB";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45F510E461
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:29:09 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc8so959628b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458549; x=1787063349; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QkL6quPpYZOmrSZlgR7q8t7HlM3bpCXuTHsi56o560Y=;
 b=YsroEjYBwY2TXjLfrD53ZhmNnFN81aZZohuicr3GFsxodQdZI4Fme66mgPrFKLdjys
 q8ZJ2D96rMjDVBea2AdPBMpGENCNZatL8/aOjKKcc7Dhr/C+zPZZSKh19638a6JGmT6+
 oRUTgXcW3LXZUgGBE1j/f17l0iXxVNRLunELrom2KnefB04/+JR3c7tU9HxpH4gNEzWC
 63B+yJavtU7QwPUx/idWOdN/xkHkv7mxhu4E3WnsNpAP4UBzPh7jq6ZBbF6y7qcPQIc9
 mu97LehUlVvdELkDdY7Bk7OwjMj+6cmSbNIIEnN4B+agzZAx/6Q6CZAhxhW1h9k3JYAj
 aEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458549; x=1787063349;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QkL6quPpYZOmrSZlgR7q8t7HlM3bpCXuTHsi56o560Y=;
 b=fYPWvbYGGNKmT1hi+ZZ/qexoQlD44EoG2qdlFfMW4u4kXhfXUPBW7cRSbYNnJEosFh
 bZ/sgaB4H442NZU/Vbg9lvdBdg8keclaEQdtEG9KCmv0Wrs4ZwuSp58bD7G8w7kKCQru
 QBYvXxs7hFFkN7gIoO5XFouzB2TH4L/u6Tp+fSQgcaPxNsQD3Slmcuv4PBOVN2PwJXxn
 LvxtHKjhMz2tGBVhVUfCt6j55aofsSUcqA6h+zYoovFqzlAXg9obJ0B6WIv17JtHEQRv
 94q2P/MVCMnvZXpezrmkCdPX3rgfgi6DV1hEeNnDSVlm+tx+OSUvu7/XbJNY2LkUNKcn
 ippg==
X-Gm-Message-State: AOJu0YycS4Unz5IkcdOHVcOKDNC5epAbHm5IpKw+MVenh+QoB2TI7PgK
 c431k1KNu7+rPucL6ShyyjOuwjB3LCIxMyfeJuPhSLHycUJxD1OYO0Wf
X-Gm-Gg: AR+sD12mQ2LFEyk8GZDG57fAycAW69LqAiTypFNrgVew5z9qdlPMbLo85rse4lysH17
 jQ6ErMGK5/93BzpWTQe+qAGH3LSGnj2hcKwuNt2DtmK1Din0jI3k9Oc3qD6HkbK7lflRUi3UKm2
 CwP293upVsDnPaF1qtNo/bOuyCmSmb/GD8PF6FbvpOzZT2oVmouGupRPbrniGtUSgkIhykLZbsU
 LrncievF5B+MJZBhgHX8qIqoc3PI+xuocymIcolvsBWAyqDTVJcdX1rmoCi3yo+0+CkkkO2d7J8
 KlRVOEfNOlKE3Xq66CYT1U8TE1wWiM50vtbd7KaIQ8YUoLqR4oKGtu1bn6SHkTYpe3l5Me5+sJ4
 WxDN7Mq20j930wOwD/gHpdI1nnNkBpIyKNfOY/G1st6e6q6eqn2TDgY60WU5q5HHmYjYGcnJaBV
 WBqV5RaYVs1EsVIVCaphC40hT5mh/Pv9Q4VBBc8A+wSa1SfEyU0u1U9kT0Jr4=
X-Received: by 2002:a05:6a00:138e:b0:848:8619:c149 with SMTP id
 d2e1a72fcca58-84faf42c2efmr824043b3a.2.1786458549054; 
 Tue, 11 Aug 2026 07:29:09 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:29:08 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated
 accounting for THP
Date: Tue, 11 Aug 2026 22:28:49 +0800
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKExe2oC/yXMUQqDMBCE4avIPnfBhFJCr1L6EHW2bsEoWSOCe
 Pem7ePH8M9BhqwwujcHZWxqOqcKd2moH2N6gXWoJt/6Wxuc4+7KaS4bYuFhwsTruLDoDmMEiIs
 i4oOn2i8Zv6Hmj+ffVro3+vV7SOf5AWu1zIh9AAAA
X-Change-ID: 20260811-b4-nouveau-dmem-thp-fixes-e8ef1afff282
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=1559;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=ZMKglCqVFXjvtgIXuZifnh47ei+nnVi+BRmkcnYy+sQ=;
 b=BoaoApiS8sm/+sfuksuoGEKYu0rzRHDSGrA0yNMo6P0a/eAtz2lAgOnDDCgBuQuP0XlJFp1Dp
 j8eAjUVMULPBHmIZgK5qC2TH5H0uqNmEN6oKiq7Z6bRRZADtjalkaaJ
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

Two independent, stable-worthy fixes to the device-private THP migration
path in nouveau, both introduced by commit c32287471077 ("gpu/drm/nouveau:
enable THP support for GPU memory migration") and still present in
mainline.

Patch 1 fixes two dma_unmap_page() sites that pass a literal PAGE_SIZE
instead of the mapped page_size(). For an order > 0 folio this unmaps
less than was mapped and leaks the remainder of the IOMMU/IOVA mapping.

Patch 2 accounts for large-folio splits in the ->folio_split() hook,
which previously left chunk->callocated unchanged. A folio counted once
at allocation (+1) is later freed as N sub-folios (-N), so the unsigned
counter underflows on the first split/free cycle and the chunk leaks.

Both are confined to nouveau and orthogonal to the in-flight "Remove
device private pages from the physical address space" rework, which
touches nouveau_dmem_page_addr()/nouveau_dmem_chunk_alloc()/
nouveau_dmem_fini() rather than these teardown/accounting sites; they
apply and are needed independently.

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (2):
      drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      drm/nouveau/dmem: fix callocated underflow on large folio split

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260811-b4-nouveau-dmem-thp-fixes-e8ef1afff282

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

