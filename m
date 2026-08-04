Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9593C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F77F10E650;
	Tue,  4 Aug 2026 05:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n95Le/gA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31DDB10E646;
 Tue,  4 Aug 2026 05:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785822497; x=1817358497;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HknZWx6FOZ/U38YVg0Q5Ggwg1PFNlmWpXzdr96jpyys=;
 b=n95Le/gAWtqHDtUwYiqG8njvCqt4MjVkuzGvVxs9hsl40sExjS5jeaDB
 LTe5KW3drD5tI8hEOFGLzFR8CfEPxc9EpjgCX/DXUQiyeSlzrfJPLgwUl
 CzG7hPepzK5VaJvlB+WC5OgfkkHB7dqApz9P1TaRUag9oc+mRIRv93vhi
 1H2lBg3XsIJO9tiQFyf7Dcp5R/BzFU5x7E4zMIOJGvbcesBe+ChvDlnKK
 LwI849tGrX7/cNsy2VvtPzhk9/r2uhY/lCMYBEruIQMzZW5Lg1//U0REG
 KDYkCPE2bs/K70HPLK1ydLH2dMdLzinYKF0v6J9D8AmBfWSBFydmPJtw0 w==;
X-CSE-ConnectionGUID: pjnNC9sUQ/O87RsF2QXKHQ==
X-CSE-MsgGUID: JQb8Xt2OTEuyAkqr9dZCBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86399060"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="86399060"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 22:48:15 -0700
X-CSE-ConnectionGUID: NjsAq4usSDCbujpJO3xr3Q==
X-CSE-MsgGUID: F1SEpU1tQumqQdQ6xIKgBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; d="scan'208";a="261479075"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa007.jf.intel.com with ESMTP; 03 Aug 2026 22:48:13 -0700
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: ankit.k.nautiyal@intel.com, jani.nikula@intel.com,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH] drm/dp: Add EDP_20 rev definition
Date: Tue,  4 Aug 2026 11:18:06 +0530
Message-Id: <20260804054806.1110078-1-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Add EDP_20 DPCD revision definition.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 include/drm/display/drm_dp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
index 8b0ca36083dd..e63c7f075f54 100644
--- a/include/drm/display/drm_dp.h
+++ b/include/drm/display/drm_dp.h
@@ -1035,6 +1035,7 @@
 # define DP_EDP_14a                         0x04    /* eDP 1.4a */
 # define DP_EDP_14b                         0x05    /* eDP 1.4b */
 # define DP_EDP_15			    0x06    /* eDP 1.5 */
+# define DP_EDP_20			    0x07    /* eDP 2.0 */
 
 #define DP_EDP_GENERAL_CAP_1		    0x701
 # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
-- 
2.34.1

