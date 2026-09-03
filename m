Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF26C79F87
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C64610F60B;
	Thu,  3 Sep 2026 13:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DdnSCylg";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B779F10F5F2
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:44:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so22676625e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788443058; x=1789047858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=DdnSCylg9eTFE2c5jxYDlss2J0RHV0XNNIG+fzDSyP7AoNUrosWqLtWkM0t5xP+U7W
 9URTyYhT5ywmk/nkE5Wd/1QXNAc8oeaPKjqv2hBOoq7iYWDsTDTYEoLwHs78Vk4JgxXB
 mb5ggDS9lXvruosgCXPZZywkMy3hcbLxiMP1fVK1RqbfUwe1NWdKemhpLROjP8rutK9/
 +oHtfArhYrLENDXgB7eTpGuKm28s6fdRQsdBa26otN3f7ucnEuF2PuAhT1iE/R+NvObF
 zzhytlMvNYyZ1EEOygvi3w8NTXZkOD7QwT5vDrrcw+yda0gw7EBYIKcmTglYr2mpO6MO
 9S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443058; x=1789047858;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3CHxWs/Md4mrbf4xKUbJKKgRpO4/sfgLi1L7Ppk/eX4=;
 b=OPbEFoDxVkgg1TnLy2kcSpmTCkzeLSMMsvaKL6HkmebVJn2nF0KPdGxBu/WDWU7AEq
 405pA/IOoYKLVcPeZYEsLoSc3Spjr9TVxb/yO3FaJcknCp3C02g9GCZqx76v90t+BL3H
 5fySvPy9omP+mIUOoksGMufh76OMBBXaVcTPdS3qSa/B88rgVaZQMOj6pE2pDzuQq91t
 xS7ZyUY5K1DY8lZ2HQeJoQLZAzoUyiGyZD6BnNsKt+tyEsDod5P14y8Ewy+nToz6DcNF
 AdcvGoqgD2KY/aMznnWdcCn7aEjg6zlNvaNJOb273HSKzVTbfpRMw4c459Vrpf0BbztO
 5ByA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVjCe18BWzaKUDEI636zbCSLaoiMzkop62VGUiVS+c1vs8/iXvKoWN0z6G7pzRHXRts7f8x5SqV+Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQIf0pCN3/7e3GgLnGUY8vopdIndOBPiKhF0r0MgivBo/3eGnC
 aUK4F2Bgl5t31um2LJS6E870LFHVu/8fjL9o0jrgG6b279nvosppPwB6
X-Gm-Gg: AYBFou0IoVM6WEvQN+rs/cDqQxkULyTygh3ekmcKgjXY9x45nKfNqk9ClYpbt83tFCi
 SWNz1GPuw2aiK22vC1I5b1hoBh6iSBBSpYHncVrK/oUwHldUkh5N44HXJJhoTAS0YKWgViH8G+U
 gZ/xzgg/yqSXyLhwZV2H6SUJxSDVcoOPpMWRpDcTXj6+GWnzc6Yemuq8snXNqkqIxnplbsVVDQS
 IbvOqmu840zFRlGbxd3mSll6e4oCemlSOekN7uks2K5sB6PNjk7b72mMtAsOXP+jMvdfanMGT4M
 7OqrKRx87YJlC4zfu1kay0fjp6i36SPf4yTMzcHRJmulHV2s6uQdCIjCqh/Z5EgX5Dsb8BDT/rg
 zFk1dsH01akRW6XdYfmcuDJXJVQTs4tJ0VroV5+CdVhWGwC2WJI3DmmFmMqcQCA0R5Cwkh6EPo4
 PCShoDp8JSKnlaEvFTxjpwWpmJkesurugv4C1cwV/cPT9o4KkUhd65DSj3I3uRUAWzHMhUAMh74
 w==
X-Received: by 2002:a05:600c:530d:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49cf5b6cabfmr2599565e9.6.1788443058021; 
 Thu, 03 Sep 2026 06:44:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:4700:e712:9f38:603a:54e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e736a6sm13597080f8f.5.2026.09.03.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/11] drm/xe: Use dma_resv_alloc for lockdep annotation
Date: Thu,  3 Sep 2026 15:28:02 +0200
Message-ID: <20260903134408.105317-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903134408.105317-1-christian.koenig@amd.com>
References: <20260903134408.105317-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Replace the stack-allocated dma_resv in xe_pm_runtime_lockdep_prime()
with a dynamically allocated one using dma_resv_alloc(). This aligns
with the move away from embedded dma_resv structures and towards
reference-counted dynamic allocation.

The lockdep priming function is used to establish lock ordering
dependencies between runtime PM and dma_resv locks. The resv is only
used temporarily for lockdep annotation and is immediately freed after
use with dma_resv_put().

If allocation fails, we silently return since this is optional lockdep
annotation that only affects dependency checking, not functional
behavior.

Signed-off-by: Christian König <christian.koenig@amd.com>
Assisted-by: Claude:Sonnet 4
---
 drivers/gpu/drm/xe/xe_pm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 99562f691080..33b19bcb6f71 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -762,15 +762,20 @@ static void xe_rpm_might_enter_cb(const struct xe_device *xe)
  */
 static void xe_pm_runtime_lockdep_prime(void)
 {
-	struct dma_resv lockdep_resv;
+	struct dma_resv *lockdep_resv;
+
+	lockdep_resv = dma_resv_alloc();
+	if (!lockdep_resv)
+		return;
 
-	dma_resv_init(&lockdep_resv);
 	lock_map_acquire(&xe_pm_runtime_d3cold_map);
 	/* D3Cold takes the dma_resv locks to evict bos */
-	dma_resv_lock(&lockdep_resv, NULL);
-	dma_resv_unlock(&lockdep_resv);
+	dma_resv_lock(lockdep_resv, NULL);
+	dma_resv_unlock(lockdep_resv);
 	lock_map_release(&xe_pm_runtime_d3cold_map);
 
+	dma_resv_put(lockdep_resv);
+
 	/* Shrinkers might like to wake up the device under reclaim. */
 	fs_reclaim_acquire(GFP_KERNEL);
 	lock_map_acquire(&xe_pm_runtime_nod3cold_map);
-- 
2.43.0

