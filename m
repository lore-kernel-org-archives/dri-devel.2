Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89290C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7694010E3DE;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tCVDNob5";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6450210E461
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:29:19 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so3250634b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458559; x=1787063359; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mwCkWoypVWX0DUrD2GWalLqHhPmC5gYTzx+dm4HNg9s=;
 b=tCVDNob5kmWLVR3TuRwUsyWdIR+7S/wY2jsp9YYlpezX03u+tosQJhsisdAPAChDi6
 yKkuuWoj007g53xI27CX5ry3ETrY70CVHjSBdB0v85ClKpR1In0lUTxoA9O+eiyqjjij
 2ssodFsmNtRmfcjZCpvSrY9bDDTv4Bbe9AlQcldXaZUxNdPBDbz0Vngr/av5t7oPTAc8
 xrxmpFiSWmPgkv6todEZCqpNlt0UgFc9qE+Y7ANrCnslPlUxO3tbglQaSodgCDa2ktXB
 7hDX1qJ+nEYMS9XoHshlACUTwvoqI5jCJOi6+euLsrSSiWmla/Dv8V2RJpHXkrAzMYg5
 lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458559; x=1787063359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mwCkWoypVWX0DUrD2GWalLqHhPmC5gYTzx+dm4HNg9s=;
 b=L4/eqC4F5zKuuINRp0nbPZcLpdw1Ey0/wBuR1b98BlybyWQkyRc+/0yQ0UJKQ0e2E1
 2dJ4zjNlgNeyo2aCzAtQ+3xbuQXgFPTVbHTY9fdsvQKg6Ec1qQh39ktT00LJvg233gZm
 RMaVaZNLts7d5dvkb2DHyTm2PNfQl1V5rQo3cDib+iET+sxZkev6wLfRwKO5YYXcypc9
 coTnUNqaqHHlX0oNwsBFFlPPSJb8xH6rwPJaW2pWTL+zZwRA0xD+EyPYe1KDjpUXR5bQ
 1A8LsrmWPJFC9Ss6eaoW3hwZyJZVNRh3Ee1ahvw7q5VtZJ2rqgaegwigTOsNqiqP5Yyf
 IHqw==
X-Gm-Message-State: AOJu0Yx176ZHHcPxKZdN3OmveoDqk4EC/gGw7+vvrKaXF58oKLzpGDvC
 BBKOj+WgYeF+JZHXGoHhSo7N9GjIsBAzGqAsr58sd3fqVq8TOxrR2Yoo
X-Gm-Gg: AR+sD11Iw+M7PYRfSpD7iYIqeSdJsjj6mC+/JM7narhMBCNUioiL0ZNSbqJyCi9wCT4
 8KqA20wdRvfDb5eehQKdbdVwTrLTu9OWQDcgzH3vrTTjnBOxiA9dlAuAz8uGlRQ8NitsbRp8Qnv
 neTAuUxlsqEOTqZWz1kveaD9rMfIgWQW4Rc+DGW5LXtMs70c2UxAcTBaDp9NCVuliBMgLrlWxhx
 WyU74OIzoURqojf2kcKbwcIK8BYSRg15O1eAw/rS9qNW38uImmt8legi+KVaB4WTCTJsAHuc+tZ
 SvuyZVhF8ahR8+s2uubo4tYcObl+hii8TuSMtZt6rU+QD+d4ouKtKB7M3zcXeWTKw/T4T3/4xtd
 KH/QvStTpU3ncMZhZgRy59zL883qSPqRQVlHtwS13owvkVurVwm44tphX15ZDh1Q0UD0lP8Ju32
 DZ9BG51TyXYpgJrpdVVz3N9/kucSC2zOCF6oIop2JMDIK2eW8itBwzqAIN5Z8=
X-Received: by 2002:a05:6a00:848:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-84fa86aa6f8mr3656519b3a.10.1786458558584; 
 Tue, 11 Aug 2026 07:29:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fa954fc8asm890209b3a.50.2026.08.11.07.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:29:18 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 22:28:51 +0800
Subject: [PATCH 2/2] drm/nouveau/dmem: fix callocated underflow on large
 folio split
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786458544; l=2343;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=25RfUnYCCAn500NPErkFHuNL6+Q3MhhwJRPB178c5V4=;
 b=KuT7Vz44ftGEbyMSNmyMs8gTFuhkVAnAk7FcqfCULSkaKx7+Tre0AqjyKJ+yRD05IFx+yF++P
 mhFHY/fO+knCTMRcui6xM+5LBLSBox31ZOFlheXXru87VbNIRBncJX0
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

nouveau_dmem_folio_free() drops chunk->callocated once per freed folio,
while a large (compound) device-private folio is only counted once when
it is allocated.  When such a folio is split, the mm core invokes
->folio_split() (nouveau_dmem_folio_split()) once for each new
sub-folio, but the hook only fixes up the sub-folio metadata and leaves
chunk->callocated unchanged.

Each resulting sub-folio is later freed separately, so after a split
the single allocation (+1) is met by N frees (-N), leaving
chunk->callocated short by N-1.  On the first split/free cycle it
underflows: WARN_ON(!chunk->callocated) fires, the unsigned counter
wraps and never returns to zero, so the chunk can no longer be
reclaimed (nouveau_dmem_fini() also warns on the leaked count).

Account for the new sub-folio in the split hook, under the same lock as
nouveau_dmem_folio_free(), so the count stays balanced.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index d2abee3efb9a..ad4570c50be7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -279,11 +279,25 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 
 static void nouveau_dmem_folio_split(struct folio *head, struct folio *tail)
 {
+	struct nouveau_dmem_chunk *chunk;
+	struct nouveau_dmem *dmem;
+
 	if (tail == NULL)
 		return;
 	tail->pgmap = head->pgmap;
 	tail->mapping = head->mapping;
 	folio_set_zone_device_data(tail, folio_zone_device_data(head));
+
+	/*
+	 * The split hands out a new independently-freeable folio that will
+	 * later be released via nouveau_dmem_folio_free(); account for it so
+	 * chunk->callocated stays balanced.
+	 */
+	chunk = nouveau_page_to_chunk(&head->page);
+	dmem = chunk->drm->dmem;
+	spin_lock(&dmem->lock);
+	chunk->callocated++;
+	spin_unlock(&dmem->lock);
 }
 
 static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops = {

-- 
2.34.1

