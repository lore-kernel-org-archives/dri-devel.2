Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB5606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OpGBphzK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EEE10ECC5;
	Fri, 13 Nov 2026 20:26:42 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE651127C0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:35 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8b360828905so15069327b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601594; x=1795206394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iH6aHrdiDKiMGilH/eCtID885/IDJ1NZMInrM6rVnhU=;
 b=OpGBphzK780zpJybMM8UhKZJLQqgs2WrANsQPdP+cQQOSZz/hWbFIYbMwVU64sS+C0
 +AXyE+X0Phr+GIdRlr6IKIBnc9tfxEcQDsi4XBD3wlwyF0FPK3JjSuvvhNUGAaQLAmpM
 wJlAYzgSxPSRAmriilORfS0Xobkjfa2y0OzouL4IOGiXuSuvbtYNd03pxNb+meRGgEY6
 rTahxS3oT76osVBCBMAqXxbTDfFnTYNBj26Be9ctFbj/TfG7R2/fUldMbg99vdvMrJTN
 OAcV/oBXYV845t5bEIVPbILNK0qClQxF/rEp05Bi7FHpAVmTACzv6vF5/Bbib6hNG/n9
 kqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601594; x=1795206394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iH6aHrdiDKiMGilH/eCtID885/IDJ1NZMInrM6rVnhU=;
 b=rQ2mNaqhCKOVz1fPwLa0ewNFtWgnrdkOLqOQfdzOABYl/liSQ97Qg37mQKIc2MJBdH
 sok4qFEow8DJBF/pZGzUpdoq+achqN45a3SzksbSDBIfdwjmEPR4bPTX7yFX5WnR7sUo
 w6NLD2A+U+Rqv7rBJR2uHHKbjNJ+jveN330vh+rMsLIcWdz+Xh6ynZLfpLzIcTcOCRt/
 ruhCkENYyBLDUcQqwqnvIkFkhIgHiTuglzptZojSV190MZhpjMFcEH0KTMX8GbrpBFGm
 Tmwl2RmHzVbM56mgos3Z9XTELGDrE/eE/nx78bBu0RWGLKAMwJhaG49lKA3uE4OlfIZV
 LDCA==
X-Gm-Message-State: APuU4Z8txegjxP8Z9WwoCk4tYWG13DldDv2CHkcZPse0cNEY4aEYdyMn
 b4GpqbFbfh2ljbTq9KC3Rm5MgjKWDNa7HhAgWCs9WgphDtfqJKQjgljv/2U11Cr8xZ8=
X-Gm-Gg: AYBFou2UbN2WTYNk3GkvwWjPzkDsL3AOCZH/U4bnnIbDfNZFR58y1cHyRmgJUNYV9iU
 vC9TjdRMYSCR/1GSvny1egYFsCmu0nKeCJNYtJsbMbJvfrNvv/B7ggiIdvLcMO+AcN4uyskzttg
 DehmyEfK6ZOgm0NZftcoW/u53HkonVEDRuy26RXRmwirce0dF/Sl68TpZdm55ZDh4S01hhQMt6V
 TsI4TuPOpZFCyTcFV7kqiHu9KjFc23wkI9DQek10CjNEaqDTQ3D2vn8aMtSd6Xu+D39V0dWMUkQ
 nFqh7wvSDDhX3XC7PlxKbFFPFXJNkgSABi3SmUrwdzdZjLo0mIieyvdCyXz+G0PETZMd4TZJzAa
 HzQZz/JEFMqGFvD0g11n0elkA7kqoN322MgV1/O0zaJdGDasGFQdYahbvidB0jvu23oEnq5oskh
 7HotoxscNAMaWQ5ec0hYUWzIgSSC2bzoVxG41FhKPfITm6nca7kR19gzIl26cxWDEnWvS6h7gGR
 DIl3KMNQ4r4EaKQKp1uDMP+ZEoXfHoRYJgCHZL9QYKc+bSx3XQH53yqJkdz5k5R7D1tpcFyV3ju
 pvd5MCLguGeLugHCE00g1KHxAjADHvc7lkzQqlg6anFF1DXicxkvyq+4aubDioUME6s=
X-Received: by 2002:a05:690c:e0d2:10b0:8a9:cdd:faa with SMTP id
 00721157ae682-8b4aa2f0601mr13939497b3.93.1794601594441; 
 Fri, 13 Nov 2026 12:26:34 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa7f1a0dsm29234887b3.1.2026.11.13.12.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:34 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 7/10] drm/gma500: skip absent mappings during MMU removal
Date: Fri, 13 Nov 2026 17:26:29 -0300
Message-ID: <20261113202629.15601-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Removing an unmapped range must not allocate page tables or decrement
the count of an already invalid PTE. Look up existing tables and count
only valid entries being removed. This also protects the unload path
when its old mismatched range did not contain stolen mappings.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 6815b48f00d3b1bacf4a1bb492a5205cdc58e7e8..76c05f5a260c9ca305e7ef9a12ffdc1f61c56482 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -544,18 +544,19 @@
 
 	do {
 		next = psb_pd_addr_end(addr, end);
-		pt = psb_mmu_pt_alloc_map_lock(pd, addr);
+		pt = psb_mmu_pt_map_lock(pd, addr);
 		if (!pt)
-			goto out;
+			continue;
 		do {
-			psb_mmu_invalidate_pte(pt, addr);
-			--pt->count;
+			if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+				psb_mmu_invalidate_pte(pt, addr);
+				--pt->count;
+			}
 		} while (addr += PAGE_SIZE, addr < next);
 		psb_mmu_pt_unmap_unlock(pt);
 
 	} while (addr = next, next != end);
 
-out:
 	if (pd->hw_context != -1)
 		psb_mmu_flush_ptes(pd, f_address, num_pages, 1, 1);
 
@@ -607,8 +608,10 @@
 			if (!pt)
 				continue;
 			do {
-				psb_mmu_invalidate_pte(pt, addr);
-				--pt->count;
+				if (pt->v[psb_mmu_pt_index(addr)] != pd->invalid_pte) {
+					psb_mmu_invalidate_pte(pt, addr);
+					--pt->count;
+				}
 
 			} while (addr += PAGE_SIZE, addr < next);
 			psb_mmu_pt_unmap_unlock(pt);
