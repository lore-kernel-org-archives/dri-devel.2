Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05410CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37B8010E48C;
	Thu,  1 Oct 2026 22:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SR7auBFu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D3410E1B4;
 Thu,  1 Oct 2026 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892165; x=1822428165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iY1a7W5LwLmTVaPvUATQrtKDMcWFd0mro8zRw1zO3do=;
 b=SR7auBFu4QDs5V96wbusBXgg1hPqpyDyqNb6ya2HVzqSqNUAxH7V4WW1
 1IKR8mTsvNIa2O7mbGdjjRrP+7dkxiojwKUxmB9pK4acgxUxwpzQIJHhU
 lJy+C8kSe3SjXphcvXytsddw2QyPp1uF9ck12SEOEvOOazVj/+VBi9x7x
 8QmD6aRI8gtO03uLkh0Bl62UzbJOKyd7wF/bRZdf6PYVz3pIOOFgIvvf4
 FJMhj6NHvakOCPjrJzj4wEJtWMNDelBNQy1HXRUKN2DkSN2cXvVWAtSm7
 /zK/etvh/wIaKhDgoIh+SgN4lEjuF2JheA8wawnDYU+7Zml2snv72JpaR w==;
X-CSE-ConnectionGUID: QjFFQIvCRxCEceMHnCl55Q==
X-CSE-MsgGUID: sTilDQxoSIiYiJre8joNiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102187278"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="102187278"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:02:44 -0700
X-CSE-ConnectionGUID: gI2kvIGUQgSdMapJHXxtoA==
X-CSE-MsgGUID: OMjOq1YrRyu0j9Nu2y2I7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="275219314"
Received: from fvishwan-4tb.jf.intel.com ([10.54.67.207])
 by orviesa008.jf.intel.com with ESMTP; 01 Oct 2026 15:02:43 -0700
From: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
 FNU VISHWANATHA <fnu.vishwanatha@intel.com>
Subject: [PATCH 2/2] drm/i915/mst: Force link address reprobe after MST resume
Date: Thu,  1 Oct 2026 14:57:05 -0700
Message-Id: <20261001215705.3891147-2-fnu.vishwanatha@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
References: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
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

After resume from warm boot/G3, immediately force a topology link address
reprobe to ensure all MST ports are properly detected. This works around a
race condition where some MST hubs incorrectly report port status bits before
their internal state is fully initialized.

By forcing the reprobe immediately after resume, combined with the fix in
drm_dp_mst_handle_link_address_port() that detects input->output port
transitions, we ensure that all displays are reliably detected even if the
hub initially reports incorrect port status.

Signed-off-by: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 3a67990411b3..fceda523efa3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7088,6 +7088,7 @@ void intel_dp_mst_resume(struct intel_display *display)
 
        for_each_intel_encoder(display->drm, encoder) {
                struct intel_dp *intel_dp;
+               struct drm_dp_mst_branch *mstb;
                int ret;
 
                if (encoder->type != INTEL_OUTPUT_DDI)
@@ -7102,6 +7103,23 @@ void intel_dp_mst_resume(struct intel_display *display)
                if (ret) {
                        intel_dp->is_mst = false;
                        drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst.mgr, false);
+                       continue;
+               }
+
+               /* After resume, force a link address reprobe to ensure all ports
+                * are properly detected. This works around a race condition where
+                * some MST hubs incorrectly report port status bits during warm boot/G3.
+                * Ref: Sporadic second display not detected after warm boot/G3
+                */
+               if (intel_dp->is_mst) {
+                       mutex_lock(&intel_dp->mst.mgr.lock);
+                       mstb = intel_dp->mst.mgr.mst_primary;
+                       if (mstb) {
+                               drm_dp_mst_topology_get_mstb(mstb);
+                               mstb->link_address_sent = false;
+                               drm_dp_mst_topology_put_mstb(mstb);
+                       }
+                       mutex_unlock(&intel_dp->mst.mgr.lock);
                }
        }
 }
-- 
2.34.1
