Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D0410AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C90910EBFE;
	Thu, 26 Mar 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eq/vLxtn";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09B510EBE6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:32 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40ee9b945d5so940471fac.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551332; x=1775156132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4jWe/O/TQKg+phAG4swgxb5r2uUue/0h3/17ze4tn4=;
 b=Eq/vLxtncKNQ+ZEU+/X/bBiUdcJeQX+Y+rJ3mYIYSExKM7jeAoOhpXkc1TNq8mjCUV
 CEJ660E8nk1QvqprFC6edxAii9GDA9WcjkRejGV0xQJyDfswjS+TgJk8R/AaCsMvVIub
 WdQ2PlQx8Ng851XkUjcU0HAq+auqTJUkCJAsiONxgyhyAXENMV4LZCC+pw2cn17GrcmP
 vH8zj3PfuVjW1NJULbrRRhfW2DGV8W6ZmDJ1ibFEr0iwt/06hwHrqNWgJWyFNTgDZxcP
 JiYXKK0mrs2sNY9/IqkjiDqqKegOyo9kSzmgXd15h4OQ8JYUC8lyJXuo3swq7xAekAae
 kbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551332; x=1775156132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4jWe/O/TQKg+phAG4swgxb5r2uUue/0h3/17ze4tn4=;
 b=ng7HbYnAxmIVJskXbE7t/WoFu0GXBxv9OoEqzuPq9t56M9BQkhze19ezzAKagwKhRk
 2i7Yj4df219bbIwws2Z5q6Ci4JGZ/2pZUmDf0kbJipLPcMJPjfcFG3K/STW8O9lEEKU8
 ujXe+E/wlkRxRfIxD0vcxI8v+vHMDgFiUwEVr7wIPf23hqiJTk9cYXBpidcWizLht2Wp
 lxRhloGQlcO4zMafqs8sSBjpjZWh4S6keRIYXHgXzsAWBl92CQVCOoamE2GBBO4jcy75
 9pNADmqMuYaiLJsNsWN3O63PJKHPiabml1H2UwqnV17uSpmlu84emZ5d8sT3SwHO9N/x
 dacw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSColRvHIL+ATOfL/xGBu+3REkA5ASMXjNnaEP7YHpTf2cy3m9k3PoVxqzwpgAiO2YSeyDaLFBKhs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPECTgWu1X7oJrlTeS+v4qz9fK/TqA4REq0KWZlZfujSfXU5Zp
 FT/K0fz86UbpTYNTiuisUV5Egkeyk+iEClb0Wa9lAGkuX+fe2cMKi3X7
X-Gm-Gg: ATEYQzxqzY5c8tbBlq3W88T+RGFV41EbdewB1+l/hmQvxJuCsEg7aD2mv3THqTh7/nm
 4eu2uWWzfns/3fbV/e0i9TkSk8jmLCsOD3e3MlQH9zxu2i5QaE8FCzaYf0iewZuBVzbxBmeYCuh
 znnVuyuW4BDovtYB24Y94NAXecHMzHAkINgBhChspSenfQmAtmVxRZIq8kDR8zAqJOS0cSOoLDv
 3fV1l+nsRo1pznXgXqII9AM964zUO54vFGQjBGxnq9ywzYe0e7EiskXpeIsL3fX7OFlGxXEVHMs
 G7mCYhe/cY6PR6SsgtYUSXsqIDBRvZltZu5WEYgO5ks1Fcfl3WyEaSQZcu1Kbm8/buxlAMvUrlc
 hlTECqbFFs1XCaUsTTEzoKDoQUG32mmxR4It/ZHja61YMkFhR+3lAl+6KY3hkBCi9J/WPLAwCo1
 qjhUgV/kRSUeJkgRl15pbRo0y1y2H3IZ1Dlvl6oDj9FUUGYBQB
X-Received: by 2002:a05:6870:194b:b0:409:9a0b:b733 with SMTP id
 586e51a60fabf-41ca6d6a50emr4662736fac.10.1774551332051; 
 Thu, 26 Mar 2026 11:55:32 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 39/69] drm_buddy: fix power-of-2 rounding errs
Date: Thu, 26 Mar 2026 12:53:43 -0600
Message-ID: <20260326185413.1205870-40-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

The standard roundup_pow_of_two() and rounddown_pow_of_two() macros use
unsigned long internally, which on 32-bit architectures (like arm32) is
a 32-bit type.

drm_test_buddy_alloc_exceeds_max_order() uses these on a u64 value,
where they silently truncate the 10GB allocation, giving unexpected
success in DRM-CI.  (see below the snip).

Fix this by replacing the those macros with safe 64-bit power-of-two
calculations using ilog2().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
On DRM-CI, I encountered this kunit:arm32 failure.

[23:19:40] [PASSED] drm_test_buddy_alloc_clear
[23:19:40] [PASSED] drm_test_buddy_alloc_range_bias
[23:19:41] [PASSED] drm_test_buddy_fragmentation_performance
[23:19:41]     # drm_test_buddy_alloc_exceeds_max_order: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_buddy_test.c:889
[23:19:41]     Expected err == -22, but
[23:19:41]         err == 0 (0x0)
[23:19:41] ------------[ cut here ]------------
[23:19:41] WARNING: drivers/gpu/drm/drm_buddy.c:405 at drm_buddy_fini+0x114/0x1b8, CPU#0: kunit_try_catch/74
[23:19:41] CPU: 0 UID: 0 PID: 74 Comm: kunit_try_catch Tainted: G                 N  7.0.0-rc1-gdfb0bcedd08a #1 VOLUNTARY
[23:19:41] Tainted: [N]=TEST
[23:19:41] Hardware name: Generic DT based system
[23:19:41] Call trace:
[23:19:41]  unwind_backtrace from show_stack+0x10/0x14
[23:19:41]  show_stack from dump_stack_lvl+0x3c/0x4c
[23:19:41]  dump_stack_lvl from __warn+0xe8/0x1c4
[23:19:41]  __warn from warn_slowpath_fmt+0xa4/0xc0
[23:19:41]  warn_slowpath_fmt from drm_buddy_fini+0x114/0x1b8
[23:19:41]  drm_buddy_fini from drm_test_buddy_alloc_exceeds_max_order+0x1c8/0x36c
[23:19:41]  drm_test_buddy_alloc_exceeds_max_order from kunit_try_run_case+0x78/0x1c8
[23:19:41]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
[23:19:41]  kunit_generic_run_threadfn_adapter from kthread+0x108/0x134
[23:19:41]  kthread from ret_from_fork+0x14/0x28
[23:19:41] Exception stack(0xf0bd5fb0 to 0xf0bd5ff8)
[23:19:41] 5fa0:                                     00000000 00000000 00000000 00000000
[23:19:41] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[23:19:41] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[23:19:41] ---[ end trace 0000000000000000 ]---
[23:19:41]     # drm_test_buddy_alloc_exceeds_max_order: drivers/gpu/drm/drm_buddy.c:406: buddy_fini() root
[23:19:41] ------------[ cut here ]------------
[23:19:41] WARNING: drivers/gpu/drm/drm_buddy.c:414 at drm_buddy_fini+0x1b4/0x1b8, CPU#0: kunit_try_catch/74
[23:19:41] CPU: 0 UID: 0 PID: 74 Comm: kunit_try_catch Tainted: G        W        N  7.0.0-rc1-gdfb0bcedd08a #1 VOLUNTARY
[23:19:41] Tainted: [W]=WARN, [N]=TEST
[23:19:41] Hardware name: Generic DT based system
[23:19:41] Call trace:
[23:19:41]  unwind_backtrace from show_stack+0x10/0x14
[23:19:41]  show_stack from dump_stack_lvl+0x3c/0x4c
[23:19:41]  dump_stack_lvl from __warn+0xe8/0x1c4
[23:19:41]  __warn from warn_slowpath_fmt+0xa4/0xc0
[23:19:41]  warn_slowpath_fmt from drm_buddy_fini+0x1b4/0x1b8
[23:19:41]  drm_buddy_fini from drm_test_buddy_alloc_exceeds_max_order+0x1c8/0x36c
[23:19:41]  drm_test_buddy_alloc_exceeds_max_order from kunit_try_run_case+0x78/0x1c8
[23:19:41]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
[23:19:41]  kunit_generic_run_threadfn_adapter from kthread+0x108/0x134
[23:19:41]  kthread from ret_from_fork+0x14/0x28
[23:19:41] Exception stack(0xf0bd5fb0 to 0xf0bd5ff8)
[23:19:41] 5fa0:                                     00000000 00000000 00000000 00000000
[23:19:41] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[23:19:41] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[23:19:41] ---[ end trace 0000000000000000 ]---
[23:19:41] [FAILED] drm_test_buddy_alloc_exceeds_max_order
[23:19:41]     # drm_buddy: Testing DRM buddy manager, with random_seed=0xacce106c
[23:19:41]     # module: drm_buddy_test
[23:19:41] # drm_buddy: pass:8 fail:1 skip:0 total:9
---
 drivers/gpu/drm/drm_buddy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index dbf984f8e301..8f23fb615d47 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -919,7 +919,7 @@ static int __alloc_contig_try_harder(struct drm_buddy *mm,
 	u64 modify_size;
 	int err;
 
-	modify_size = rounddown_pow_of_two(size);
+	modify_size = 1ULL << ilog2(size);
 	pages = modify_size >> ilog2(mm->chunk_size);
 	order = fls(pages) - 1;
 	if (order == 0)
@@ -1140,7 +1140,7 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
 
 	/* Roundup the size to power of 2 */
 	if (flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) {
-		size = roundup_pow_of_two(size);
+		size = 1ULL << (ilog2(size - 1) + 1);
 		min_block_size = size;
 	/* Align size value to min_block_size */
 	} else if (!IS_ALIGNED(size, min_block_size)) {
-- 
2.53.0

