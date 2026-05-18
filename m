Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58BFCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D8910E753;
	Mon, 18 May 2026 09:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gKsrS/OJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A1810E081;
 Mon, 18 May 2026 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779096588; x=1810632588;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=v7aIise6kKRjDSd8NM2/Lj6jBi0Ve32R4dteKxhdnDg=;
 b=gKsrS/OJYeKBBqjwt/v3wXCwfYfx5qzVvyyHWVSWUzJ3t+zZ9EJbc+sH
 e47nO0VskTrOq7IVaGqLs7dRnvVB3aqvhlvKlMlex4fOYLhUbRfqLmE0m
 I9/cJMLtKtTLnwSEGPz+NGT/Rmy/MPLXRA1ywX/1sot8UJOFcQQaTTF4x
 /hJ+vA8zjZHGuCojwrn5uKP9doMNP8kN4cGDN3xgsOZzZrhN0cOwL/Vs/
 /FFoolPx52tCnsdM/1SQ+a9W3Hp8SgEidzDLKP7HkzXCIQZNFcNW9wkOt
 yE7RG9PHuh2NKzpoJgxsms8NCR4tMjxInXRejfdXj98kek3pUiuLcYUdx g==;
X-CSE-ConnectionGUID: FEJT/FqHRIi28amBjqVL4w==
X-CSE-MsgGUID: kmbebqlTQDmRasap8o7TiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79797422"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="79797422"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 02:29:48 -0700
X-CSE-ConnectionGUID: xK+N1HQITFyvbd5DAebZSQ==
X-CSE-MsgGUID: 6n0xegqDSpuD6+8LKpKscQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="277468778"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 02:29:46 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v2] Revert "i915: don't use a vma that didn't match the
 context VM"
Date: Mon, 18 May 2026 12:29:41 +0300
Message-ID: <20260518092941.47247-1-joonas.lahtinen@linux.intel.com>
X-Mailer: git-send-email 2.54.0
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

This reverts commit 5401b9adebc9e5f68df58226f51493ef0e6ceb4d.

Superseded by a13edf9b92fc ("drm/i915/gem: Drop check for changed
VM in EXECBUF").

Link: https://lore.kernel.org/intel-gfx/CAHk-=whfUM8y3PoFfT21+guKWK-mJmAE=8uLzOT+7HGv5NtqSw@mail.gmail.com/
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 05997e8bbb29..1f303d4eaa4d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -898,8 +898,6 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
 		if (likely(vma))
 			vma = i915_vma_tryget(vma);
-		else
-			vma = NULL;
 		rcu_read_unlock();
 		if (likely(vma))
 			return vma;
-- 
2.54.0

