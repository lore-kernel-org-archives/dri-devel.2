Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC73E1073C9A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 11:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB4810E610;
	Wed,  8 Apr 2026 11:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YJmSp+AZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD52A10E60F;
 Wed,  8 Apr 2026 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775646360; x=1807182360;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sDMz3ezEPPomZ/NtOObRpTT9/soXb1Vy1gowO7hQO6Q=;
 b=YJmSp+AZF7v6kKDtCCFLsbH7GuCjsyBR63JHEJ0nSJ7izdy4SEo++9I2
 f8mPLOeUDq2EVmtx+a0AjSAlcY9KGBTon/8BG3G11CoTq6IENF6ovuSfX
 ohG3sq25KOi0L7ehwOFtNVxbSr7rZnqwUV4roWMIflIrmO8muS/TZTVWO
 B+QVugPuI7VCNbJbsnFL7611Yzx8YT131R4Fy7VIRigoQIxym03TJRpvS
 v70IoBoE1BsjnRzqwrWUGCfQpOY76YXZiHWcGADPHvpQE7ep6HGOz4YaY
 JSo0/z5sdknE5D7ZeCha0q0iilbw9BBgiFMCsDGTNOYCYHPzwaamnbOZR w==;
X-CSE-ConnectionGUID: ipi9SugiR662D8o7g85UNA==
X-CSE-MsgGUID: cWpiit7jQTiY09GZ38DdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94015359"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="94015359"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 04:05:59 -0700
X-CSE-ConnectionGUID: 9tghARCrSK+7K35MQgHF1Q==
X-CSE-MsgGUID: Z7o+WjHwQRKI2GBMh3lYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="266435528"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 04:05:57 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH v3] drm/i915/gem: Don't use VMA from wrong VM in EXECBUF
Date: Wed,  8 Apr 2026 14:05:51 +0300
Message-ID: <20260408110551.84120-1-joonas.lahtinen@linux.intel.com>
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

Do not pick a VMA with non-matching VM (ppGTT) on quick path
of BO handle lookup for a given EXECBUF call. VMA from wrong VM
could be picked if same BO is repeatedly used in EXECBUF
calls on same context with alternating VMs (ppGTTs). However due
to the introduction of proto-ctx that should not be possible since
d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
 create parameters (v5)").

Also avoids returning a VMA without increasing the refcount,
which may potentially lead to UAF since f7ce8639f6ff ("drm/i915/gem:
Split the context's obj:vma lut into its own mutex") and until
d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
 create parameters (v5)").

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

  Despite that this is impossible to exploit I think it's still good to fix,
  but I think for paranoia's sake we should put a WARN_ON_ONCE(vma->vm !=
  vm) in there, since this really should be impossible.

  I don't think there's a  harm in backporting this though, since there's a
  2 year window between the introduction of the ctx->vm change and it's
  complete fix with the proto-ctx work between 2019 and 2021. It's not
  realistic to backport the latter and this here is trivial in case anyone
  is foolish enough to run such an old kernel.

v3:
- Include Sima's analysis and WARN_ON_ONCE

Fixes: f7ce8639f6ff ("drm/i915/gem: Split the context's obj:vma lut into its own mutex")
References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index bd608cea396f..16f7c2fac143 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -895,8 +895,12 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 
 		rcu_read_lock();
 		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
-		if (likely(vma && vma->vm == vm))
+		if (likely(vma && vma->vm == vm)) {
 			vma = i915_vma_tryget(vma);
+		} else {
+			WARN_ON_ONCE(vma && vma->vm != vm);
+			vma = NULL;
+		}
 		rcu_read_unlock();
 		if (likely(vma))
 			return vma;
-- 
2.53.0

