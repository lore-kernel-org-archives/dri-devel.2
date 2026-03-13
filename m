Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A50105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFC710EC2D;
	Fri, 13 Mar 2026 13:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2oR8TKY";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C408610EC2E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:07 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4672076355aso1531415b6e.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408307; x=1774013107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9IAEzSkGuy9vSx6TA0Y4hBOc80UNfiz/9RCZw4zMCM=;
 b=i2oR8TKY/R2X6sLI27lCBt1nqczzoCDssX0XKuFs1L+odyHeZqlq8uiDjqQi1VlaH9
 O3c4PGZYVANroQt754gwle7io1ECS6HgB85bBFWIqQdBW92Nc0JXhmxhce2PtwOBaxT/
 GO1AO0QngBsPzeqygAnJGO2+GT4rPmX8vrxHEdwcy0+9RBmL8YQy7kh7XYpCbYPr/qOw
 syKeUTMql/i0ZwKHOXl4WzZ5A3mU8/gXe26VZ+tsuaT2lC3Y57bIPrrlBtSTAJ+oM4mc
 k2jvBjXkV8+HZFminrknsPEV+YWXcxydmmHvq2YONxkGfP5da34nKTfExrekcsjTzHf4
 NzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408307; x=1774013107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p9IAEzSkGuy9vSx6TA0Y4hBOc80UNfiz/9RCZw4zMCM=;
 b=ODBu6Hd45sB/cjMKcPO5myRkp96OQ/ifvcaVyb4NSn1oAE5A9GomFGLk8c6d3c8MoB
 tHERqvefPrJpM4yswNla3i+fC1ktxbmtVQrYv/MbcFDA7WNoBwA/9FOsOFr7zrUk/PQe
 R2qfSO5NdrDgvB1E+/0VoYrlDTI148tGGvXVFtaUTPlhfxfA7yFlfmKiW7NrxXeU56s2
 n44p4aBriNc+j/uRBbadQzechV9nSU2GzR6v6uFWAYicroVOEXLi1uHSsSHmCmgjKtS4
 K+PGbTB/OJvq9afx+TZG43qogpFiIhUxwCJJKk774NoIrAmkhFSJN8OVRqu62W/sd8rv
 Byug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfiDC3oYuIi3RQGEHHQjY0pwFMHdVpbW9Gt+dLKqHBNdCRIH/XBq36qkPOhI65ypSPl19kyfXtxwk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3aHUAoZK2fOekbuVYIpMBzGbsu+Nix9dVvqtfXYEpbJXit5BQ
 x5KrjxTThIh3kXB8D2lJmCbnqOySaGjA7mcHJPKkwfJqLzuUYNhhikRO
X-Gm-Gg: ATEYQzztzOOApFfOrjRqWFWod5gMFuMXITdKWO4fbW5NvWz7Xeizqv782+aL2Hnm4DG
 EXqcsLJDJy+miByYbLIU49LZf6IpPYdfmO6t5uKBUVtAa/iZOniqhLDGwcCrF1P7ReRkfhBjHrt
 nfjwp/i1xLuM8P8rSeaGqrXmHvppNdjMnCgSwWY1dPEJcVBY72Mq0GrngE4DetS8aloWEnMpnNQ
 O2WG5yxrhMoVERzhD7uiZbjd5WM8sNIXzoeOTzJs30vjroaGL0t0FciyZtN0xImr6uxWpOUBPpk
 wQCvrt2uJlRw6bhq84vrJvSZBPHEEsWD5kVFUlevEMa9Z87Kp8XjGtz0A2RqmPRFHA3f/0Fh/7p
 PbE7zeFvpkm3gGhs5BZq7pYIn2BCnKheXxAwZYoi/sJ1rLc2jQj/hfC00mlVRGXPfaBc3XxlEaZ
 lJ4DO1jEd0DOlQILAr28laoBo5WfHQdaura2rjFVtceZ+nMawM
X-Received: by 2002:a05:6808:1912:b0:467:4a4e:5a80 with SMTP id
 5614622812f47-467575aef9cmr1688429b6e.45.1773408306845; 
 Fri, 13 Mar 2026 06:25:06 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:06 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 63/65] drm_buddy: fix 64-bit truncation in power-of-2
 rounding
Date: Fri, 13 Mar 2026 07:20:28 -0600
Message-ID: <20260313132103.2529746-64-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

drm_test_buddy_alloc_exceeds_max_order() uses the on a u64 value,
where they silently truncate the 10GB allocation, giving unexpected
success in DRM-CI.  (see below the snip).

Fix this by replacing the standard macros with safe 64-bit
power-of-two calculations using ilog2().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

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
 drivers/gpu/buddy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 52686672e99f..ed4d33a30687 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1091,7 +1091,7 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 	u64 modify_size;
 	int err;
 
-	modify_size = rounddown_pow_of_two(size);
+	modify_size = 1ULL << ilog2(size);
 	pages = modify_size >> ilog2(mm->chunk_size);
 	order = fls(pages) - 1;
 	if (order == 0)
@@ -1318,7 +1318,7 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
 
 	/* Roundup the size to power of 2 */
 	if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
-		size = roundup_pow_of_two(size);
+		size = 1ULL << (ilog2(size - 1) + 1);
 		min_block_size = size;
 		/*
 		 * Normalize the requested size to min_block_size for regular allocations.
-- 
2.53.0

