Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03321CD98E3
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67ACB10E50D;
	Mon, 15 Jun 2026 15:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gQRUH/Fh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8874410E50D
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781537433; x=1813073433;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ct3JzO6uCcAqlIAJk0gvE3VcYD1iFW+dQuk31sqNrG4=;
 b=gQRUH/FhZxuQnTStZeMmsYGyAKn0rHucrGUKXY2+ql7W0oqpDX+8skfv
 q16oN3/JU+uIx+SP+kfbTRhTBlJVuRV23ekU4AoXLBStHE2f8RfRlXlwW
 ux2WIaIjLFNwsIw4yWHLwrjwtBZo9IHEbePKQLt6wex09LPsieZaG15bk
 fVntb+ixlae96TZ9QY6PPIFtBGboW8UIO8pHOV7LUCLNg+w9d2UNATpru
 EL/Pi5c08ODXgxLsgaL9giLqW4IDtURjz3q9DjYzCfnev+B4fkyGaDYup
 N/c18YKXXBGR2jAkAMWTf9QfqIxxR2LYBMlMq1sSiDRBdlrKqrhNVXImY A==;
X-CSE-ConnectionGUID: +pgqCim5Q+2J9oP2bN/A8g==
X-CSE-MsgGUID: 2qbaQ641SOink9PW5OurCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82018807"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="82018807"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:30:32 -0700
X-CSE-ConnectionGUID: DIg973CVQSiIOvI9CDtU7Q==
X-CSE-MsgGUID: ftG0jduiRkGHzeSGiJbbxQ==
X-ExtLoop1: 1
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.28])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 08:30:31 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH] drm/dp: fix kernel-doc for struct drm_dp_vsc_sdp
Date: Mon, 15 Jun 2026 18:30:27 +0300
Message-ID: <20260615153027.1899784-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
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

Add the missing coasting_vtotal kernel-doc member documentation for
struct drm_dp_vsc_sdp.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/drm/display/drm_dp_helper.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 8c2d77a032f0..ab16c1be3900 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -115,6 +115,7 @@ struct drm_dp_vsc_sdp {
  * @duration_decr_ms: Successive frame duration decrease
  * @target_rr_divider: Target refresh rate divider
  * @mode: Adaptive Sync Operation Mode
+ * @coasting_vtotal: Coasting vtotal
  */
 struct drm_dp_as_sdp {
 	unsigned char sdp_type;
-- 
2.47.3

