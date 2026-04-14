Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C63F9D0F1
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 19:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484F10E665;
	Tue, 14 Apr 2026 19:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EU5BmEND";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF8210E129;
 Tue, 14 Apr 2026 19:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776196736; x=1807732736;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XaM2zkmBYautoXcAaKWiQ0eTKFIykp5jjemzzjIVZ8I=;
 b=EU5BmEND2Tzk6Oa0MewpaTUvVRyTC4ZhT9fKl/goDokGhfEZbumeGEyu
 +MttzaMyUZ/uwlKs8fgrcL/0X6ar6KgqQWU79yIdw8NBeam7yCySY75Jc
 YQSnHowCA74Jg5qJit+VyaWfJ75tzCCCH6cJWwMSHU/q3/APAyT3Zz8D/
 grepi47MGRagkaGQunRxO4vqRTR0LQ+waRTNpNz1RSqHdGWsg7Hn9Ts8z
 XQsB7dCY8vS9nxXqpjccVQT5mVCx8byo/oP7SsIodIpCL0ltlt/HriiPx
 EMKNiMjUQgv+FgtW8DP7231xQicu7nMzZ/yCUdTCZU+vznT1LIJdyoOkF Q==;
X-CSE-ConnectionGUID: cw7LtYeRQv+yY04rOPp4IQ==
X-CSE-MsgGUID: fk/R7xw5TqyHXXeKA7AKXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="64706886"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="64706886"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 12:58:55 -0700
X-CSE-ConnectionGUID: q8CYEYziRuerMug008xOWg==
X-CSE-MsgGUID: sQtSAz0GRXWvgcJX/FmVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="225484492"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.244])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2026 12:58:52 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Simona Vetter <simona@ffwll.ch>,
 Chris Wilson <chris.p.wilson@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] drm/i915: Fix VMA UAF in execbuf setup
Date: Tue, 14 Apr 2026 21:57:47 +0200
Message-ID: <20260414195834.115460-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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

We now depend on RCU protection when looking up VMAs associated with GEM
objects of an execbuf task in a radix tree based lookup table of a user
GEM context for that execbuf.  That's not sufficient.  While the radix
tree itself, as well as GEM objects, freed by RCU, are safe, VMA items are
not, and memory they occupy can be freed concurrently if another thread is
doing a cleanup.

[550.183466] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP PTI
[550.183490] CPU: 6 UID: 0 PID: 18815 Comm: gem_reloc_race Tainted: G S   U       L   N  7.0.0-CI_DRM_18329-g4e3f5ea9aacc+ #1 PREEMPT(lazy)
[550.183508] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER, [L]=SOFTLOCKUP, [N]=TEST
[550.183517] Hardware name: Dell Inc. XPS 8300  /0Y2MRG, BIOS A06 10/17/2011
[550.183527] RIP: 0010:eb_lookup_vma+0x89/0x770 [i915]
[550.183909] Code: 00 00 00 49 8b 44 24 38 4c 89 f6 48 8d b8 20 02 00 00 e8 1a 65 c2 e1 48 89 c3 48 85 c0 0f 84 c8 00 00 00 48 8b b8 c0 00 00 00 <8b> 17 85 d2 0f 84 b7 00 00 00 8d 4a 01 89 d0 f0 0f b1 0f 0f 85 53
[550.183928] RSP: 0018:ffffc90001aeb7e8 EFLAGS: 00010282
[550.183938] RAX: ffff888175b4cb40 RBX: ffff888175b4cb40 RCX: 0000000000000000
[550.183948] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6b6b
[550.183957] RBP: ffffc90001aeb848 R08: 0000000000000000 R09: 0000000000000000
[550.183966] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90001aeb8b8
[550.183975] R13: 0000000000000003 R14: 0000000000000003 R15: ffffffffa0ced6f2
[550.183984] FS:  00007a83cce026c0(0000) GS:ffff8882a3997000(0000) knlGS:0000000000000000
[550.183995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[550.184004] CR2: 00007b5f1317e428 CR3: 0000000179690003 CR4: 00000000000626f0
[550.184016] Call Trace:
[550.184021]  <TASK>
[550.184031]  i915_gem_do_execbuffer+0xc84/0x36e0 [i915]
[550.184362]  ? lock_release+0xd0/0x2b0
[550.184376]  ? is_bpf_text_address+0x74/0x140
[550.184387]  ? kernel_text_address+0x139/0x150
[550.184398]  ? unwind_get_return_address+0x25/0x50
[550.184410]  ? __lock_acquire+0x43e/0x2790
[550.184421]  ? stack_depot_save_flags+0x28/0x960
[550.184435]  ? __lock_acquire+0x43e/0x2790
[550.184446]  ? find_held_lock+0x31/0x90
[550.184455]  ? __create_object+0x68/0xc0
[550.184470]  ? lock_acquire+0xc4/0x2f0
[550.184479]  ? find_held_lock+0x31/0x90
[550.184489]  ? __might_fault+0x53/0xb0
[550.184505]  i915_gem_execbuffer2_ioctl+0x169/0x320 [i915]

Protect a VMA item retrieved from the context lookup table with a mutex
associated with that table while taking a reference to an underlying GEM
object.

Fixes: f7ce8639f6ff7 ("drm/i915/gem: Split the context's obj:vma lut into its own mutex")
Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 65ce54b20ec29..d79e3f2d1cbb4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -894,6 +894,7 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 		struct i915_vma *vma;
 		int err;
 
+		mutex_lock(&eb->gem_context->lut_mutex);
 		rcu_read_lock();
 		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
 		if (likely(vma))
@@ -901,6 +902,7 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 		else
 			vma = NULL;
 		rcu_read_unlock();
+		mutex_unlock(&eb->gem_context->lut_mutex);
 		if (likely(vma))
 			return vma;
 
-- 
2.53.0

