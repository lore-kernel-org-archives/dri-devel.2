Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75CECA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6BB10EAFB;
	Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nlp4mLGF";
	dkim-atps=neutral
Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com
 [74.125.229.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A6B10E989
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 22:21:52 +0000 (UTC)
Received: by mail-dl2-f40.google.com with SMTP id
 a92af1059eb24-14f7ea9bcb2so19014c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791066112; x=1791670912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ld3yvAlH1ePbXKo85z4Wex4dRCKbfnZa0FcQVmSfj/w=;
 b=Nlp4mLGFQuWHTcSY1OHTRNsvW+PaKSpzs2ciIUSff0L8Dly0JeELRR80p+SJfDCaRP
 WKRHxzJVOdNaj+gLcDV01DMeFx1q2hnTwdlve4lEI4Ko031nuEDuizJ3IlXjexcOeO7z
 4EbWhC/ITITt1DgykVkCz0TBN3seJpZ0nf+tiXvpU2xiK24mZylBhKhyV3iZrzR09StN
 Fh5x9qaYbMr0KREwF8Q/zqg/KLxFw6l15EPPbAqo1VBDfwrMkhEknqBnN0xm+DQfO50R
 yfzLq2GatmO00IJ7wGNVbNKWf/tpYt8fFchqfcJ8VlU2qaN3ua//N0ihA4ZhON33BK4s
 HTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791066112; x=1791670912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ld3yvAlH1ePbXKo85z4Wex4dRCKbfnZa0FcQVmSfj/w=;
 b=Cd73xcVezqLwWbLC7YCPGwO6nxYUKb1HjPJTcbs22yHXeeJn3KOtH9BBAfcfLLMF7G
 fTr3FVvrPiFtWAtD3Pi5cTfP4iL74xpVB1OdgIQsu4CVkPiMEo6ngXJR5qYcrIFhpU4E
 v1ztiJxPpLzHQRmY44kpqt1mMYlnk8K7l1IVdkciSZfXOAFWfZUZhtMWr1Sdj22x0jJc
 THzkIXi/lFXgmVuOZFiHOqxKExG+5AafaamEWwMcpbnopD3YJ8XWjcTK9tPX/0I8Gut+
 HiuyyGClGEBcSFEA87MiFuBteTWQROHTz2SvsbF3yk/NB5AJiBK+K+enu/+rjgmP/Ldu
 vM4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPxnQntUPNN5ywZsvO7XaT4Yxb5iK8Kf+0bYF5uwztZzmtsj7G8EMSxg2oL9/kT4JzhKx7FBh1v6A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m35ZKvQpnUgdb+IIdBjsPx5ZSgK1QBRUwgamJmIZ5O3S0P3cO6
 7sknadNLzqq00CEZrII9xNZPTILRsIwaFzhNXRS00c/oMxUxpVzhgY7a
X-Gm-Gg: AYBFou1OyaEOr5P/0TgM92zGv8LNMvjnWtGRUl9FaiUbKYfe6GHDJS/e0FI5fEyCHut
 cq0Yu8SNnD0sxZi3/rTOkG19Btykkf47qH5KwpE9E9VrcDjQk7RuA03YFmi8+Ck8zyNsfHafLHM
 dGStXozOHzxrMz3yFuZtvbXvxq8fcmp+db3YUW6jhHJYZ7ZnegYQx6mg1Xf/h9dvPyAD5WcHa8u
 DcltCejGC86CjwrX+TECmZNW1eFwS3QcNZqTOaQHxnCnW2FmSgptRJslLhzc11wa1RGbHOQ6zar
 /LLjMuEBQVr2kT26W3qGRn+dvp4NvzOqBxLAvNQCe38cAqnumMt8kmySmnvOgbSsZNQA+GOw5Ya
 GAeT9x/B+PM6Y0K0GD1eyzOy1VDauv959Fg6vW+qP0pMHy65J5jg5Mr1oYtFQXVdW6MSqy1CJjE
 ykoE1v/OniQRstAV0zFvWMB+ax44INGlfv5Qsml74LTwcX7Aof6HNux6p5R0Q4aGOW1TCjZikp+
 G02va3YXaaDwD3fN9owqSm7dUiv73PpYqxmFlsAaOCwJeFbMXjSv3EEIDZuDy5guoWd4g+B1qdX
 PqG8ddZ3HoXrTO2UANA=
X-Received: by 2002:a05:701b:4281:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-14f56160499mr12982269c88.0.1791066111712; 
 Sat, 03 Oct 2026 15:21:51 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc87346bsm18452135c88.8.2026.10.03.15.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 15:21:51 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe: Map Wa_22016122933 buffers WC on the CPU side
Date: Sun,  4 Oct 2026 03:51:45 +0530
Message-ID: <20261003222145.67240-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

xe implements Wa_22016122933 by mapping the media GT's GuC-shared
buffers uncached on the CPU side. i915 maps the same buffers WC on the
CPU and UC on the GPU.

CPU writes through the uncached mapping are slow, and xe clears and
refills the ADS on every GuC load, so probe and every resume pay for
it. On ARL-H, xe probe takes 3.1 s with UC and 0.35 s with WC, the same
as without the workaround.

Keep XE_BO_FLAG_NEEDS_UC, which also selects XE_CACHE_NONE for the GGTT
PTEs, and add XE_BO_FLAG_FORCE_WC, which now makes the CPU mapping
write-combined when both flags are set.

Fixes: d5b0bf3f37f1 ("drm/xe: Implement Wa_22016122933")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Tested on ARL-H 7d51 with this backported to 7.2.8. Probe time is dmesg
"GT0: Using GuC firmware" to "Initialized xe": 3.10 and 3.15 s with UC,
0.35-0.37 s with WC (3 boots), 0.35 s on stock Arch 7.2.8, which lacks
the workaround.

20 min of VAAPI decode with C-states 2/3 disabled (the reproducer from
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678): no TLB
invalidation timeouts and no late acks, same as with UC.

 drivers/gpu/drm/xe/xe_bo.c  | 7 ++++++-
 drivers/gpu/drm/xe/xe_guc.c | 6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6921b696733..763172b252f 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -533,7 +533,12 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 		 * which cpu_caching is never initialized.
 		 */
 		xe_assert(xe, bo->cpu_caching == 0);
-		caching = ttm_uncached;
+		/*
+		 * With FORCE_WC also set, map WC on the CPU side. The GGTT PTEs
+		 * stay XE_CACHE_NONE because they key off NEEDS_UC alone.
+		 */
+		caching = bo->flags & XE_BO_FLAG_FORCE_WC ? ttm_write_combined :
+							    ttm_uncached;
 	}
 
 	if (ttm_bo->type != ttm_bo_type_sg)
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 3ab4cb9e496..a39a42bfd0b 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1476,13 +1476,15 @@ int xe_guc_suspend(struct xe_guc *guc)
  * Wa_22016122933: on the standalone media GT, memory shared between the
  * CPU and the GuC must not be mapped cached on the CPU side, otherwise
  * the CPU can read stale data written by the GuC (e.g. G2H CTB writes)
- * for multiple seconds.
+ * for multiple seconds. Map it WC on the CPU side and UC on the GPU side,
+ * as i915 does.
  *
  * Return: additional XE_BO_FLAG_* to use when allocating GuC-shared memory
  */
 u32 xe_guc_bo_wa_flags(struct xe_gt *gt)
 {
-	return XE_GT_WA(gt, 22016122933) ? XE_BO_FLAG_NEEDS_UC : 0;
+	return XE_GT_WA(gt, 22016122933) ?
+	       XE_BO_FLAG_NEEDS_UC | XE_BO_FLAG_FORCE_WC : 0;
 }
 
 void xe_guc_notify(struct xe_guc *guc)
-- 
2.56.0

