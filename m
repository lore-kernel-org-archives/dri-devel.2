Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4A1CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4587610E48F;
	Thu,  1 Oct 2026 22:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="crt9Lj+q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C4810E453;
 Thu,  1 Oct 2026 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790892165; x=1822428165;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8bpfdGXSJ7xEZhAQnLU9FqlfRGlrihD4R1l1Fjm3MUE=;
 b=crt9Lj+qvwLAgMxpib0lzdXK3IgSyhB/v+e7bQFKWvxOzl27a4iEwdM2
 LuKnWf1ZfMdi58LGqYxAk+TaofcybfFPfBvZnj0614o6NGwM4KSiUcSX+
 PKsESRgZp2786eSZlpZo6SduswzpKTnSfzRP/iYeBQw5NXpCAJP+y9U5y
 wDUyaoruc33lYmV3CoVg7t+AcGLOVxFN5FvVQ9KxXn02z+kSOi6AkMMjH
 VLCISt8wI2jeFYZI0drX8xgEN7DsBNEFuAUGNT690itRZJ73V/ONvvW01
 MUKF5X4/8gc9pYJ/l8vIEhiXi8tgYIMk6Qc4L9xoP8lyTvkZ2dhWDt0f3 w==;
X-CSE-ConnectionGUID: hs6/wCNhTDC2vwSrT7ZVqg==
X-CSE-MsgGUID: Bovw3wNoTvSh+rNsUjxq5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102187277"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="102187277"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 15:02:44 -0700
X-CSE-ConnectionGUID: bGCQk+KtTsmpS3YVM0TeTA==
X-CSE-MsgGUID: wo98g8BcRmSAi+VDSoDHnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="275219291"
Received: from fvishwan-4tb.jf.intel.com ([10.54.67.207])
 by orviesa008.jf.intel.com with ESMTP; 01 Oct 2026 15:02:41 -0700
From: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
 FNU VISHWANATHA <fnu.vishwanatha@intel.com>
Subject: [PATCH 1/2] drm/mst: Fix sporadic second display not detected after
 warm boot/G3
Date: Thu,  1 Oct 2026 14:57:04 -0700
Message-Id: <20261001215705.3891147-1-fnu.vishwanatha@intel.com>
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

The intermittent detection failure of the second display over MST HUB is caused
by a race condition in MST port status detection during warm boot/G3 resume.

When a port transitions from input to output state during topology reprobe, the
driver was not forcing a re-probe of the link address. This caused ports that
were temporarily incorrectly marked as input ports to never create connectors.

Force a link address reprobe when a port transitions from input (1) to output
(0) state, giving the MST hub another chance to properly report the port status.

Signed-off-by: FNU VISHWANATHA <fnu.vishwanatha@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index be749dcad3b5..cc340e4235cc 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2377,7 +2377,11 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
                changed = true;
                created = true;
        } else if (port->input && !port_msg->input_port) {
+               /* Port transitioned from input to output (e.g., during warm boot/G3 resume)
+                * We need to force link address reprobe to get proper port info
+                */
                changed = true;
+               mstb->link_address_sent = false;
        } else if (port->connector) {
                /* We're updating a port that's exposed to userspace, so do it
                 * under lock
-- 
2.34.1
