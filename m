Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33C7C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3889110E1D4;
	Tue, 15 Sep 2026 06:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1LNalmi";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC2210E5AA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:42:30 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-381b831d535so7380978a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789454550; x=1790059350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCSTuPUQ/GLR9/B7uIQrcZbxwMxzx1bd+YZe2GK5X6k=;
 b=V1LNalmipf2mXOoGVzaVUKYT0QltEBi+vXUsK0XY/FoqfLZh6YP7oNLn3p6mwj2/mn
 lOaixee+XP6qMImSQIWSEdwNegB44iQAuIJY7AjEvJhXS1RgpuDPjdNifHL4/H3ElKgA
 EpdRydNpzzyox4rzOSc0BrcMCSb5nIkDwhFL2Q8O7a3nroBrbvfyk6ABb1ONPGNrAloH
 +e1ujlHSTvUwM3P6Kh2KilwLX5BemPTtf2VOlr7Eb17yASFIbVDwcifjuWzJadKXfck0
 LWPsO9zJeSdszeawI8w+oVmccriQSoJYLOczmwkUchVV19rdKv/v3wEmqv6ZMOgLeh8a
 9NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789454550; x=1790059350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wCSTuPUQ/GLR9/B7uIQrcZbxwMxzx1bd+YZe2GK5X6k=;
 b=bW7g6JGcuWqT8NuIeJtxqb7KjSoizc/P8sm+f6R11gQEvWdyrM4g1yZgIMwFttLIsD
 ilpQyqkiYwN91dWTtvQ4WeF9Fr2GgcXeX6QGgprUH4iXEikTTUf3C9mPZH205CZM7VCS
 BuQquAAA/OFPNHcFhfi+uGqN4IZxD6lQk4SF4P7c/iS8m8QKkkOicOc4A2HDuK9vkxHM
 iCmkDAtPc/Jkel2YkVeECFs4XMo4PNIQgaMdlRxLcxQML7gz3UDNrVebFaT6m0i8U22y
 gvyeoV7AyE6OeLm1cY3yKwv6RqeNzRYdfQPUFIxAKid2AUHbpsB8lKe0rAL5A6gHWA1z
 kH+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwumBuXKArNpUCKphXhfOuwmZ9+YwXCZip6MRQbT9wVdyk3u78XUh3DBeKK3DnPr5FGoNGO1SVUM/E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMNnftKl5ak9JnDVhjN6jorKzsEgT3htqCJf2doAQMmOe/mjGu
 MJykXFYge4Nma3yhQBObGa2NjLxoXID8DBw4CD0g91ctu+KMQNecL8xy
X-Gm-Gg: AYBFou1GDt8GC5irmehP0IKbAEgDrlVQZgOvIeDuSulzY42C93U3xDwoqYCMk3/BgzW
 KCXMPSnGVnZTxF7xHCQerVC58F3/LV/pMb5jluUlPXHaUUiR1g4wrZ7Ek1U4igtc1GVjIY1Uu3Z
 jLlwiJge0mdNrVE4uvmbHThPcdR1DYK3Z1WQ3/9T2ceseb1KQ8NWGRiA8YtlIdnJ737OtwrmMYn
 MHiJVtv0jREv/+gF7FrQYTyL/TOumjUO4F7E4Cry2vVYOk7CSXmh/T/UaR9HY/BCX1x/lsKF4xK
 rp44i7lRgOrHVFWb0ObLeg7tZrE998/iD+y399p/BV7ZhkYE6LVa3W+xd0yGE6WfY43MdoU/+7x
 Tf1nS4LRgDiz9kOz3Vdxgf0a8Ifv0a533wUYjIE8lA+JRZo1L4ckZZR3xJsRvjMLoodZ2SZbmoa
 CZpk5opSjiUic78KoFQAWoDIosF4ZsuZsD5XclPxbX73dqYGxqwjHEf7dgVDkpqHdoXueeAUx7x
 Jr2+THBFOx3nfaqgVUlZjOxMLpoyglYhQlaeJYbvOi19gmIJiOP
X-Received: by 2002:a17:90b:568b:b0:39e:d2a:e2dc with SMTP id
 98e67ed59e1d1-39e0d2aeeb9mr114032a91.12.1789454550214; 
 Mon, 14 Sep 2026 23:42:30 -0700 (PDT)
Received: from alpine.my.domain ([218.188.146.2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdcb54d8sm3240016a91.6.2026.09.14.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:42:29 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andrew Zhou <zhoulol888@gmail.com>
Subject: [PATCH v2] drm/xe/display: Remove invalid initial plane PTE check for
 iGPU
Date: Tue, 15 Sep 2026 06:42:00 +0000
Message-ID: <20260915064200.23171-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260905142500.17666-1-zhoulol888@gmail.com>
References: <20260905142500.17666-1-zhoulol888@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Pantherlake integrated graphics can have the XE_GGTT_PTEDM bit set in
the BIOS-initialised framebuffer PTE. The validation rejects this and
fails to create the initial framebuffer, resulting in static.

Remove the too-strict validation. Since this was the only caller of
need_pte_local() outside the DGFX path, the helper is now
unconditionally true there; fold the check and drop the dead
need_pte_local() and has_lmembar() helpers.

Signed-off-by: Andrew Zhou <zhoulol888@gmail.com>
Tested-by: Andrew Zhou <zhoulol888@gmail.com>
Tested-on: Intel Core Ultra X7 358H, integrated graphics, B0 stepping
---
v1 -> v2:
- Drop need_pte_local() and has_lmembar(), now dead after removing the
  iGPU validation (sashiko)
---
 drivers/gpu/drm/xe/display/xe_initial_plane.c | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
index 0f86b7303..3484b3033 100644
--- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
+++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
@@ -27,16 +27,6 @@ static bool is_pte_local(u64 pte)
 	return pte & XE_GGTT_PTE_DM;
 }
 
-static bool has_lmembar(struct xe_device *xe)
-{
-	return GRAPHICS_VERx100(xe) >= 1270;
-}
-
-static bool need_pte_local(struct xe_device *xe)
-{
-	return IS_DGFX(xe) || has_lmembar(xe);
-}
-
 static struct xe_bo *
 initial_plane_bo(struct xe_device *xe,
 		 struct intel_initial_plane_config *plane_config)
@@ -60,7 +50,7 @@ initial_plane_bo(struct xe_device *xe,
 	if (IS_DGFX(xe)) {
 		u64 pte = xe_ggtt_read_pte(tile0->mem.ggtt, base);
 
-		if (is_pte_local(pte) != need_pte_local(xe)) {
+		if (!is_pte_local(pte)) {
 			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
 			return NULL;
 		}
@@ -85,7 +75,6 @@ initial_plane_bo(struct xe_device *xe,
 			    &phys_base);
 	} else {
 		struct ttm_resource_manager *stolen;
-		u64 pte;
 
 		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
 		if (!stolen) {
@@ -93,13 +82,6 @@ initial_plane_bo(struct xe_device *xe,
 			return NULL;
 		}
 
-		pte = xe_ggtt_read_pte(tile0->mem.ggtt, base);
-
-		if (is_pte_local(pte) != need_pte_local(xe)) {
-			drm_err(&xe->drm, "Initial plane PTE has bad local memory bit\n");
-			return NULL;
-		}
-
 		phys_base = base;
 		flags |= XE_BO_FLAG_STOLEN;
 
-- 
2.54.0

