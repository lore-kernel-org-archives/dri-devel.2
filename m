Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C4CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DA510E5CC;
	Fri,  8 May 2026 11:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HxngspJk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592010E5CC
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778238749; x=1809774749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3/7UIV/Sx3T2qV9l6MEdINXMJRNSTqKhuZrnjDGTZX4=;
 b=HxngspJkgl2zHMuqbtzkDiyN7MHoOdLjRkM1xZl2w3J+RuSXd5QWOb3U
 gJu2n6ZpV/Brc1KwbG+U/RHzoaLQd32HqOqWuaQDjFqPTRfPd3Uzj72a2
 2ZuZE6ONSoBNbvafkvazfh5ZK2mDn+nyXYMV4eXWBP5oji/ZLauGIOl0l
 2FfIH9mi50Bw0+9SpXmNUjmlBz42438FpMtiuild4k4aMQrJOOUV72Cak
 fv4ocJAPZctT0o3y7iEw9LTEYKOZmhvHFL5i+zXjBnJQmsZyTuxKa0jH+
 CuI5wC+El7GakV4v97k3Tj8ULSnzNaBjr8vDn0lYhF3LAnkg8ZDE0BMO9 A==;
X-CSE-ConnectionGUID: zceZUBuQSei1j7lVjiceDg==
X-CSE-MsgGUID: u9GwFC2BSqKcdheyfC+jgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79311830"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79311830"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 04:12:28 -0700
X-CSE-ConnectionGUID: sKaLa5uoQPq24hP9UNn1dQ==
X-CSE-MsgGUID: Q4wev2XgTN+MFIBVfe61OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="236867171"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.40])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 04:12:27 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [PATCH 3/3] Documentation/gpu/rfc: fix toctree
Date: Fri,  8 May 2026 14:12:09 +0300
Message-ID: <c9678a78749a71cf86941f37116232dbc7c23b5f.1778238671.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778238671.git.jani.nikula@intel.com>
References: <cover.1778238671.git.jani.nikula@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

Just one toctree is enough. The .rst suffixes are superfluous in the
toctree. Fix indent. Add missing newline at the end of the file.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 Documentation/gpu/rfc/index.rst | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/Documentation/gpu/rfc/index.rst b/Documentation/gpu/rfc/index.rst
index ef19b0ba2a3e..26a7ebe6fb44 100644
--- a/Documentation/gpu/rfc/index.rst
+++ b/Documentation/gpu/rfc/index.rst
@@ -18,23 +18,9 @@ host such documentation:
 
 .. toctree::
 
-    gpusvm.rst
-
-.. toctree::
-
-    i915_gem_lmem.rst
-
-.. toctree::
-
-    i915_scheduler.rst
-
-.. toctree::
-
-    i915_small_bar.rst
-
-.. toctree::
-
-    i915_vm_bind.rst
-
-.. toctree::
-    color_pipeline.rst
\ No newline at end of file
+   gpusvm
+   i915_gem_lmem
+   i915_scheduler
+   i915_small_bar
+   i915_vm_bind
+   color_pipeline
-- 
2.47.3

