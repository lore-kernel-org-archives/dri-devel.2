Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246ACCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 20:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B74610F326;
	Thu, 14 May 2026 20:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OmFbprTK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B5B10F326;
 Thu, 14 May 2026 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778790744; x=1810326744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hFKijvloZk0RcE+8OFwndgzquy2Z8YQPTdpjYLykXlM=;
 b=OmFbprTKQREGIFhpQ/94RRxqkrM3DyIdklGTB2nJTUQ0TOZfPbT82EHi
 QGALyzolOK8F9hfgOBRZtk2HfpsryjF0lhZ1NZNAAdmH5uGO2VeCPkCCt
 olc7//iuWZtF9wTJWyjO/EIuvZ68hOnNw6EGOc7MsFHeIWXmvkKKXkAWT
 z+OZepi2Uzepe2SfQpOgmKb5cbUDL69ItEtpQ4oh1v1C+FuPFOur9JaZ/
 ffDvzHr4FxwgJ29JSgL6mERppbZQD3O/24qtK7VIMcy2nA3qgnA/4sg6Y
 wM2rAJQcYPafIA4ZtzQ+RfKzehevOBlh8iSqbwNFr8Bco/FDw7NCd6oTN A==;
X-CSE-ConnectionGUID: vQ/tQPubReuFHQkGmJ+cSw==
X-CSE-MsgGUID: GBrAC/8vQtS0p2I1kpvahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="78880190"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="78880190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 13:32:23 -0700
X-CSE-ConnectionGUID: Vefce3OJQxCJkpPcOr4k3w==
X-CSE-MsgGUID: YzA9IrdHTEWuoaEIznFKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; d="scan'208";a="238361187"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 14 May 2026 13:32:21 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, maarten@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/3] drm/ras: Cancel and free message on get counter failure
Date: Fri, 15 May 2026 01:58:16 +0530
Message-ID: <20260514202839.1888688-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514202839.1888688-1-raag.jadav@intel.com>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
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

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..262a75f0c493 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -207,8 +207,11 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	ret = get_node_error_counter(node_id, error_id,
 				     &error_name, &value);
-	if (ret)
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
 		return ret;
+	}
 
 	ret = msg_reply_value(msg, error_id, error_name, value);
 	if (ret) {
-- 
2.43.0

