Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B557C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E018510E5F5;
	Thu, 10 Sep 2026 14:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJIrPei4";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B7610E5F5
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:36:51 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso1093317366b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789051010; x=1789655810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=orC8VUg8M5+c5rSP9eN2LigrAsxa02qw3fBkTWfZG5o=;
 b=PJIrPei4pgI/YJ7yRMOW5QqFuKIlXfxINUEvUlL5J8AN3gNfsB86pbfwgtwa4OX5QF
 2lhmPp/1BevYd0alwp43fbsO1CSQlOl2hW6qwWuL/QIHSw8UxwVEQb7+H7thHhHxfj39
 nFm65uapChxh7fbegTARXNNBd0hstgYaFNgdWCWMFqAB87FnxKXwWWjL9WQeFisOv7g2
 yMsBIhHr5j1fgWKpVEUgwgvBBg8Okitzjlgr0v/xFpNveVb40KYdLomrAWhCPz5D4RBc
 f+c78bcif3QybhiPxhM2zbPQ+JLbrjAdAls+eUWWY9INdwS30sQ06l6jak4e7WoKs1KH
 Q6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789051010; x=1789655810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=orC8VUg8M5+c5rSP9eN2LigrAsxa02qw3fBkTWfZG5o=;
 b=P0nACguoAVBz68eiiSn1AWZS2S7s0JBQuJMgY792gzC2xZeI/bVkk/5w9H5D/9xy1R
 LC6sgCTIf4hasNE1FKDAVbJH1rBY/c6CaWhRX0iR7Hjm0DlnN8ALn9G+LIq1GmhPSG6N
 yQaQpHaBH6RnQXwY1pfPNo0dL9TVQeYUpOGjzNr/+6EUDyspMypFFK0r8VGD+VRQoN8q
 xFq4NwiUikkgXrHWk8sc0y/3bTfy6qoCi6bgYX/Qk8I601HJrD6UQNJRDXaSs6F/wy/g
 w33+C+8XXczAhlXaQDmT7cKPImPoCiNL1wVhJko1GDzNJxae1dHSVrMzIAq4RnrGvIK9
 7K/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmeBGAG5q/ueJJXKzrG8hTZ71L2IrLzF+sKe4rsRkCqJFFcTFSDtJ3cXbPvExfXavZgOzpjfussjw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lK/0q7EXkbRhtsGPfaGT5q5GxwtG6AB88eU4tkiKAoCJDoHgvq
 QF4TPol+wQnJbVA+1AH0p1ZK2TVVC5mlsjsS8Ww9H81m9QUDA8x1SU0A
X-Gm-Gg: AYBFou3l5DIt/z9FFQ2DkqApdGYGLzvmvNeouQIOu2xpR52nzCTY84CFMYOnniWBRcf
 Cuka2Z4y9O73Dy/UZJKaQV/O2DkNzbuaBH8lOZScsDfY5xeEB/K7W0aOU3ugoY7qgR75SYK8ZlT
 f/lOjiRlyrN3wmVQV4e8xI/A6RwCIAAui8IKmTAIlKSRnEteD8eJlVIKK2GaxHK4YemUQDEsfuP
 MsXlJXCSaNW8OgJ3cYKVKjt/ouGk5q8lxD8G9sbjJWey/zbQNrw3D8I8nnZ8UnddVtHiM0BCWoh
 A98WWZbfXFuazDScYYenpPt02rD36mjsbvKu8/hH0//UuTkLMjOdrBUd9CKoL9zkSfPr0wxON1l
 mUF+Ro0iFfF/6z51CGROFtZdmGit2oLC/JIhrI5Vnx5OrQMv5ojnfZOW0rsT50qXB3FYGywNCFw
 FeCdzHqej+/Rj2tR2gYbZG6YqKyceQJ/b5kf+tLYatAneIpsncjo2Pu7Mii77TnKcDQS+YPL0MC
 3mYGAM=
X-Received: by 2002:a17:906:ee88:b0:c29:3711:626f with SMTP id
 a640c23a62f3a-c2937116522mr422684566b.24.1789051009715; 
 Thu, 10 Sep 2026 07:36:49 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2945d5ea60sm135441466b.29.2026.09.10.07.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:36:49 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: christian.koenig@amd.com,
	thomas.hellstrom@linux.intel.com
Cc: ray.huang@amd.com, matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com,
 bernardomagri21@gmail.com, Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH] drm/ttm: apply the swapout bulk_move fix to the intended
 condition
Date: Thu, 10 Sep 2026 17:34:51 +0300
Message-ID: <20260910143451.65853-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
References: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
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

Commit 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving
their bulk_move range") landed in drm-misc-fixes with its one-line
change applied to the wrong "if": the "if (ret)" after
ttm_resource_try_charge() in ttm_bo_alloc_at_place() became
"if (ret > 0)", while the "if (!ret)" after ttm_tt_swapout() in
ttm_bo_swapout_cb() that the patch targeted was left untouched.

ttm_resource_try_charge() returns 0 or a negative error code, so with
"ret > 0" a failed dmem cgroup charge no longer fails the allocation.
Restore that check and apply the intended change: ttm_tt_swapout()
returns the number of pages swapped out on success, so the bulk_move
removal must run for ret > 0.

Fixes: 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving their bulk_move range")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
---
Christian, the commit in drm-misc-fixes (3db7d7d58341) ended up with the
change applied to the try_charge condition at line 532 instead of the
swapout one at line 1434; the resulting tree still has "if (!ret)" in
ttm_bo_swapout_cb(). This is a fix-up on top of 3db7d7d58341 since
drm-misc-fixes does not rebase. Sorry for the noise.

 drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a12af5b..9b85b5f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -532,7 +532,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
 		ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
 					      force_space ? &alloc_state->limit_pool
 							  : NULL);
-		if (ret > 0) {
+		if (ret) {
 			/*
 			 * -EAGAIN means the charge failed, which we treat
 			 * like an allocation failure. Therefore, return an
@@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
-- 
2.53.0

