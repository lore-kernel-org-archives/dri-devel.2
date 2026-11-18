Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE32606A32F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LA7u/YdS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18CC610ECA1;
	Wed, 18 Nov 2026 21:45:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7825B11201C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038350; x=1826574350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g0x1eUpRSLT7tYD76as1N+sEWuL7d7ZItGLzBsuMCxo=;
 b=LA7u/YdSM4usNHtJQzFAzOgAbmfCDS7v+twAojFEnlSKd/bmmMEhLGvy
 KlgQxf//mG5wmIt0ynTdyjMV5XHFxs/TAwzgKgcDSKrJdSySqY22iZYfS
 Pf4vxiJKHvjc4vjAhqtgftuqu2YSrm9IezO02bbju7xwae6TynGrSbx2q
 z6rJGFyJvwg0ysZznBwVdUlGUWDu9C67ppNxHvy2SWuuYWIGuut6v7Q5q
 VTfGKiRxvdSPdYzd1xdgEkAoKA05o5sEaYbrVhxDzOAEXYG8bEeziaBXz
 j+SUqeoX04G6ABJtfbaC8tdzphLg43fhm0HCL81RGp63j3d+vGZy2QFN5 w==;
X-CSE-ConnectionGUID: 41FDPQjrQJS5wttkCwGJGQ==
X-CSE-MsgGUID: 4YBg1dWlSEOfVSHueyuK2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3862560"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3862560"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:50 -0800
X-CSE-ConnectionGUID: L7AubnnqS1OMvRIi3N6fZw==
X-CSE-MsgGUID: zLwjF3SmRnu/UaPVjuSDEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10390723"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:45:47 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Kory Maincent <kory.maincent@bootlin.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 04/20] drm/tilcdc: Fix endpoint node names in the legacy
 panel overlay
Date: Wed, 18 Nov 2026 23:45:01 +0200
Message-ID: <20261118214518.29317-5-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The overlay names its two graph endpoints "endpoint@0" but gives them
no reg property, so dtc complains with W=1:

  Warning (unit_address_vs_reg): .../endpoint@0: node has a unit name,
  but no reg or ranges property

There is only one endpoint per port, and the overlay refers to the
nodes through the panel_in and lcd_0 labels, not by name. Use plain
"endpoint" for the node names, which is the usual form for a single
endpoint, and drop the bogus unit address. The remote-endpoint
phandle links between the two nodes are unchanged.

Fixes: 0ff223d99147 ("drm/tilcdc: Convert legacy panel binding via DT overlay at boot time")
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
Caveat! I really have no clue about DT, so this was pretty
much all Claude's idea how to fix the warning. I'd buy what
it's selling, but can't really judge it one way or the other.
Nor can I actually test this.

 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso b/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso
index ae71d10f5ec1..ca82f3bed15c 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso
@@ -13,7 +13,7 @@
 	tilcdc-panel-dpi {
 		compatible = "panel-dpi";
 		port {
-			panel_in: endpoint@0 {
+			panel_in: endpoint {
 				remote-endpoint = <&lcd_0>;
 			};
 		};
@@ -22,7 +22,7 @@ panel_in: endpoint@0 {
 
 &lcdc {
 	port {
-		lcd_0: endpoint@0 {
+		lcd_0: endpoint {
 			remote-endpoint = <&panel_in>;
 		};
 	};
-- 
2.56.0

