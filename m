Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847F5E98FA8
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831DF10E145;
	Thu,  9 Apr 2026 05:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aNCHxdGZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF5A10E072;
 Thu,  9 Apr 2026 05:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775712680; x=1807248680;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5DiAaL+jp8EonDGusD3PPQyIeU+jhqSIQQwNUVzDnfY=;
 b=aNCHxdGZo6TJAgjzJGLjpBBPnp962G1icpQEhR/1y+486guQPNIlDnFX
 UVmhbsldN5o4UZkBTA+xtTw9t1i6DPXVjJ9Dt0kvE9nLPBtxxUo7d/x1R
 G6eL3bJ85rplBsu5ALc6uAqeFs06YsxeH6lAWwpMSPcGP7bpn5uAFH1zu
 qW3j/jZs3/aQ35RUpPVjWZlhO/DxPvnrwNrq1dlQlphmOy9uMZU/NreAw
 fZlqHUT/KkfRcCSgQjE/Y2Fxw7ecK1cca6E2/EOiTvlWAt5mSWp6yZEjl
 zgtiMUWlEr8xT5aKf4nZr+pmArkws8JgMKa/LoMaD3Yp/KJxHv9OfxD0e A==;
X-CSE-ConnectionGUID: aeTsg0ipQhWn6DbglG6pHw==
X-CSE-MsgGUID: k42riz3KRziswe/r9vsumQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="102160399"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="102160399"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:31:19 -0700
X-CSE-ConnectionGUID: HVlv5rQATOeQJn3XHdommQ==
X-CSE-MsgGUID: ohyEheYqR+eLJudLbLcaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="227813192"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.151])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:31:17 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v4] drm/i915/gem: Drop check for changed VM in EXECBUF
Date: Thu,  9 Apr 2026 08:31:11 +0300
Message-ID: <20260409053111.8914-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.53.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Since the introduction of d4433c7600f7 ("drm/i915/gem: Use the proto-context
to handle create parameters (v5)") it has not been possible for VM to change
after context creation so the check will never fail.

Sima's analysis:

  This check was added in f7ce8639f6ff ("drm/i915/gem: Split the context's
  obj:vma lut into its own mutex") but without any hint in the commit
  message as to why. In another hunk of that commit there's a hint though in
  __eb_add_lut:

          /* user racing with ctx set-vm */

  This would mean that this bug was introduced in e0695db7298e ("drm/i915:
  Create/destroy VM (ppGTT) for use with contexts"), which allowed to change
  the gem_ctx->vm at runtime, opening up the race that was partially fixed
  in the earlier referenced commit about a year later.

  But it cannot be exploited anymore in anything remotely recent because
  with the introduction of proto-contexts we've made gem_ctx->vm invariant
  again, exactly to preemptively close all these potential issues.
  Specifically d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
  create parameters (v5)") is the vm specific part of the proto-context
  work.

v3:
- Include Sima's analysis and WARN_ON_ONCE

v4:
- Focus only on latest mainline codebase

References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index bd608cea396f..621f07a55c38 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -895,7 +895,7 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 
 		rcu_read_lock();
 		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
-		if (likely(vma && vma->vm == vm))
+		if (likely(vma))
 			vma = i915_vma_tryget(vma);
 		rcu_read_unlock();
 		if (likely(vma))
-- 
2.53.0

