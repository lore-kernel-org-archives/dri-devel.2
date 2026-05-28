Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDCFCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 21:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5387410F635;
	Thu, 28 May 2026 21:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Shx1BFN4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17BA610F635
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780004057; x=1811540057;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ky5EUiaq12t17sPUvXECyVEwWKfJnzRQRNLdRRUteR0=;
 b=Shx1BFN4cK0oQy6qOtS0KakPPYiynP/ctFFPnUR2Ob6uc1ycjDaOEVzn
 FbN97vImVw8BqIkOcQxDA8thU9sEZtaZTL+/jpFUkYBe6bxhPHMoXofO8
 g/hDWjL0njq5/oj5VWQ1L2SgObduWYtpPpl9DyusqIzDj58QkOP5kchZW
 YoB93ShGczAZdueURgqft1b+TMpLAQxv/aLrZNVlHtRY3thVssXW2vprT
 wq5ZdatoTi5PPfRTDAFb+YS68p+egNczKLwm7F2RN5PX1EVh0K78/y/H3
 V5Vz7XD4KKqUA4QyOj93VNYH5MMUxP1zr2YgPGxz4Qwfh0tONVnLZ6MEt A==;
X-CSE-ConnectionGUID: SZvJFiYlQtWmphWGSzFysA==
X-CSE-MsgGUID: q+X1DlJmT3mpaP15n8yPfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106307909"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="106307909"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 14:34:17 -0700
X-CSE-ConnectionGUID: vQ18+o3wSEaFWvL160Wnfg==
X-CSE-MsgGUID: rbOmCoF0SXGZqAhwoulw6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; d="scan'208";a="242819401"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 14:34:15 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 gustavo.sousa@intel.com
Subject: [PATCH] drm/xe/rtp: Check hwe before calling match_func
Date: Fri, 29 May 2026 05:34:12 +0800
Message-ID: <20260528213412.3709399-1-jonathan.cavitt@intel.com>
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

XE_RTP_MATCH_FUNC may attempt to dereference the target xe_hw_engine.
Ensure the hwe is not NULL before calling the function, matching
XE_RTP_MATCH_ENGINE_CLASS, for example.

This covers a static analysis issue.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
---
 drivers/gpu/drm/xe/xe_rtp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_rtp.c b/drivers/gpu/drm/xe/xe_rtp.c
index dec9d94e6fb0..2cd26db113d9 100644
--- a/drivers/gpu/drm/xe/xe_rtp.c
+++ b/drivers/gpu/drm/xe/xe_rtp.c
@@ -129,6 +129,9 @@ static bool rule_match_item(struct rule_match_ctx *match_ctx)
 
 		return hwe->class != r->engine_class;
 	case XE_RTP_MATCH_FUNC:
+		if (drm_WARN_ON(&xe->drm, !hwe))
+			return false;
+
 		return r->match_func(xe, gt, hwe);
 	default:
 		drm_warn(&xe->drm, "Invalid RTP match %u\n",
-- 
2.53.0

