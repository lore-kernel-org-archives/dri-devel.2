Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA47FD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63B310E578;
	Wed,  8 Apr 2026 08:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lw7xVvIr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41D110E576;
 Wed,  8 Apr 2026 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775636957; x=1807172957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3siODLB5V/yPd6lZ9g1a9Gjy3AKlFGIkt23ubmghYx4=;
 b=lw7xVvIrB8R7CEZSIwaLMz5cqVsOf4oq3aSGdamPMBROcOCSVWtrQ3kY
 G5vmlAKuPHgZnVgDpnAZYid2eny/1zUst55RkvSOz6nZ8oDd78DGxS6hU
 3aFL0951Ll2pRA46uJH8i87+JWeK8zwFNcdoTvanAc3y1X00U3SgXZZNl
 Eob6r8kxJEhEPRO4IqmYz8XYiPO0DWD/kRaEMS2S8Car28DQHc5YJMimu
 IwmmghOb/nRW+B/nQbOWsms3LYgd7zdhlmDwT+FYyqzqskqQeEkCBFZKA
 1ZfHVIPAGAZaSHiglCNnoZpzdtFl+RGietx3ew3rx17+csD9FNgCOKU/i Q==;
X-CSE-ConnectionGUID: 5BHGLG72TUKQM84x1Og5Lw==
X-CSE-MsgGUID: Qwf5Oyg0RI+PZOMv+v6odA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="88068630"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="88068630"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:29:17 -0700
X-CSE-ConnectionGUID: m6qE6bSRTFS9ZI5CfyKC8Q==
X-CSE-MsgGUID: 8QhkZyg8QpOBG6L3Wtti7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="224116556"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:29:15 -0700
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [PATCH] drm/i915/gem: Don't use VMA from wrong VM in EXECBUF
Date: Wed,  8 Apr 2026 11:28:59 +0300
Message-ID: <20260408082859.69823-1-joonas.lahtinen@linux.intel.com>
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

Do not pick VMA with non-matching VM (ppGTT) on quick path
of BO handle lookup for a given EXECBUF call. VMA from wrong VM
could be picked if same BO is repeatedly used in EXECBUF
calls on same context with alternating VMs (ppGTTs).

Also avoids returning a VMA without increasing the refcount,
which may potentially lead to UAF.

References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index bd608cea396f..7463c3262651 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -897,6 +897,8 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
 		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
 		if (likely(vma && vma->vm == vm))
 			vma = i915_vma_tryget(vma);
+		else
+			vma = NULL;
 		rcu_read_unlock();
 		if (likely(vma))
 			return vma;
-- 
2.53.0

