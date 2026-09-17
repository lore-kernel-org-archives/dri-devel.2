Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A601CC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B462310EB1D;
	Thu, 17 Sep 2026 08:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lM6gn3+y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3B010E478
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789632232; x=1821168232;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3E3PCUBGowSRP32kX8x0o8CntI84wtehDsyDfzZN2rs=;
 b=lM6gn3+yxlCRvMsVkDt98+iRP6Bk6jmmoyTnvIY7f/trEm7vEeb4mkdu
 WcJ6JRQgekXRbF7kvCL09F9zXlPuZdTOvwetcBQ9rhDt2CUW/Yq0H8QeH
 ZZxNZ5SOYl/gjnXR3wkvWPeISoGTFQJt6ZjnXJ4gdQa4yd5aUQboFfdOX
 X3/YSiJ4OKlgRJiF0/2gijrOgZOdTZOQ67dkG2J+2K6X8BJPinaYAKeks
 Rd+yV0FPBOKW+o14A3T2j9wAKcXJhWzIaMYwx90Fi5NjcTdOR+Cl7EM4b
 GJ6Yvulh/4l3AOXoRXiu2AIQc7BejRaqNI2ivmOzCZznxhRuBeyD1LHgo g==;
X-CSE-ConnectionGUID: 1QYIfVI1T/eroU6FHSUD/A==
X-CSE-MsgGUID: YcTxRCQxRIW96GHVzAbk6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88964083"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88964083"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 01:03:51 -0700
X-CSE-ConnectionGUID: zq2X5Jm6RpmQpD12i2dq4A==
X-CSE-MsgGUID: 9u85yq21Q5GHvJVbowgd4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298727681"
Received: from xiaolu.sh.intel.com ([10.239.146.103])
 by fmviesa001.fm.intel.com with ESMTP; 17 Sep 2026 01:03:50 -0700
From: Xiao Lu <xiaolu.xie@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com, David.Francis@amd.com, jani.nikula@linux.intel.com,
 Xiao Lu <xiaolu.xie@intel.com>
Subject: [PATCH] drm/dp/mst: skip connector creation for unplugged downstream
 ports
Date: Thu, 17 Sep 2026 16:01:26 +0800
Message-ID: <20260917080126.1729898-1-xiaolu.xie@intel.com>
X-Mailer: git-send-email 2.43.0
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

When an MST branch device is enumerated, drm_dp_mst_port_add_connector()
is called for every output port regardless of whether a device is actually
connected (ddps=0). This causes the driver's add_connector callback to
probe DSC capabilities via REMOTE_DPCD_READ transactions on empty ports,
which the hub NAKs with DPCD_FAIL.

These spurious sideband messages are wasteful and generate unnecessary
error log noise. More importantly, they occur repeatedly on every topology
re-enumeration triggered by CSN handling.

Skip connector creation for output ports that have no device plugged in
(ddps=0). When a device is later connected, the hub sends a Connection
Status Notification (CSN) which updates ddps=1 and triggers connector
creation through the normal hot-plug path, ensuring correct behavior
for runtime plug events.

Tested with a Parade PS8650 MST hub having unplugged downstream ports:
REMOTE_DPCD_READ NAK messages are eliminated while hot-plug and
display functionality on active ports remain unaffected.

Signed-off-by: Xiao Lu <xiaolu.xie@intel.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 7ce9e2127..14a84a838 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2448,7 +2448,7 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
 
 	if (port->connector)
 		drm_modeset_unlock(&mgr->base.lock);
-	else if (!port->input)
+	else if (!port->input && port->ddps)
 		drm_dp_mst_port_add_connector(mstb, port);
 
 	if (send_link_addr && port->mstb) {
-- 
2.43.0

