Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F0FD5F92
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C6E10E579;
	Wed,  8 Apr 2026 08:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hLlifKEI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40F110E56F;
 Wed,  8 Apr 2026 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775636542; x=1807172542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4XqkLUqsPHURs40NnsQ9++Lt/2ymwhNbeUyatge12O4=;
 b=hLlifKEI+j9qTO339MkW87qxMByUbu3XumwGU0LFNP7uuY8rdouPUwap
 pGEsKJl7/cIEaoYz1JvartQiSL6Q1iath5+a8n1HH4tBiX501Ij5jt/BZ
 t9Oj8TC0kdKVz95sIL1lwjzTc7Jb4PbkTIpHHZU6FubQbMHU8OhY9spH1
 mpvkHUkWiDtguQlEsd1IpEqTsNbDUyiQTcFiuT3nJDhuXD1pGQlbYBwRv
 QB8Q7w2F2GStGYIrxEik1EP1QFMtHh2TxDomDhTe2RyaLGny9uv02Mmgj
 fgOMe6+QmrzzhdjMxqmNaMLNvoYDS2cbfIQNBujZPklQUEMRhDgAtAWUl A==;
X-CSE-ConnectionGUID: DV4p87++SzSd6f7W7EAN+Q==
X-CSE-MsgGUID: ptJRx68cT6CBSzlWKcqSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="88068056"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="88068056"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:22:22 -0700
X-CSE-ConnectionGUID: D5fUjobRQc6FXpHfNErIbA==
X-CSE-MsgGUID: 4IMlqeSYRqCrcTH28Te/3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="224115711"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:22:20 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	jani.nikula@intel.com
Subject: [PATCH 2/2] drm/bridge: prefer drm_printf_indent() over inline \t
Date: Wed,  8 Apr 2026 11:22:11 +0300
Message-ID: <20260408082211.3040194-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408082211.3040194-1-jani.nikula@intel.com>
References: <20260408082211.3040194-1-jani.nikula@intel.com>
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

We have a helper drm_printf_indent() for tab indenting the prints. It
makes the actual strings more readable, and highlights the indented
parts better in source.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_bridge.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d6f512b73389..bac1aae497e0 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1613,18 +1613,17 @@ static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
 
 	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
 
-	drm_printf(p, "\trefcount: %u%s\n", refcount,
-		   lingering ? " [lingering]" : "");
+	drm_printf_indent(p, 1, "refcount: %u%s\n", refcount,
+			  lingering ? " [lingering]" : "");
 
-	drm_printf(p, "\ttype: [%d] %s\n",
-		   bridge->type,
-		   drm_get_connector_type_name(bridge->type));
+	drm_printf_indent(p, 1, "type: [%d] %s\n", bridge->type,
+			  drm_get_connector_type_name(bridge->type));
 
 	/* The OF node could be freed after drm_bridge_remove() */
 	if (bridge->of_node && !lingering)
-		drm_printf(p, "\tOF: %pOFfc\n", bridge->of_node);
+		drm_printf_indent(p, 1, "OF: %pOFfc\n", bridge->of_node);
 
-	drm_printf(p, "\tops: [0x%x]", bridge->ops);
+	drm_printf_indent(p, 1, "ops: [0x%x]", bridge->ops);
 	if (bridge->ops & DRM_BRIDGE_OP_DETECT)
 		drm_puts(p, " detect");
 	if (bridge->ops & DRM_BRIDGE_OP_EDID)
-- 
2.47.3

