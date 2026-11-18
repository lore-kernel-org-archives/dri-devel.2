Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14471606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ev3De79Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B777C112063;
	Wed, 18 Nov 2026 21:47:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20471112059
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038430; x=1826574430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=92wBFKxoEBsVppYwDkeMq089FqzVB+htTNUJjvh+OsA=;
 b=Ev3De79Z2RrzDbs6PVgCTwZdxl38txOQ1UplEDKdYmbeIUlA0K6TfXLQ
 Ptf9rwQd2JhglgStt7P6jpRCov/hKsekFwB/paEDBuoxOWRMlTXmgBfKF
 UHWiAN5ItT9wVtxWsixgTP6WdkBjFj8ZY0ELpIlwR9kzZO95twWVUkz/i
 EKJ9XtHD0K7iyaKlMbt/JvWT5tp868Jo41pGWM8polmeZ2+He+H+kcgCA
 zzlMZBhvvob0zNirfn4VWZz/fBjk1rTj9ZlHGX31i7E/LhXkAcePjpy5G
 AiDGZyRZmr2JKmOPFmoeSnGNgwqgnZjCjLM2INGMnRrqIy6bIwt6JiuTK g==;
X-CSE-ConnectionGUID: N3v29F0RThq6QZBE9Vq7Ww==
X-CSE-MsgGUID: ZwCTVEskRQewwA/Gu6gIuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3763829"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3763829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:47:09 -0800
X-CSE-ConnectionGUID: iIYF2PdyToyRzvPP/gbi6A==
X-CSE-MsgGUID: 7KGfucU8SUafr/3x8NrfDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10142877"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:47:07 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 20/20] drm/rcar-du: Allow VSP and writeback build with
 COMPILE_TEST=y
Date: Wed, 18 Nov 2026 23:45:17 +0200
Message-ID: <20261118214518.29317-21-ville.syrjala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Make DRM_RCAR_VSP selectable with COMPILE_TEST=y, and enable the hidden
DRM_RCAR_WRITEBACK option by default, so the VSP and writeback code gets
built for greater coverage. Builds fine on x86, x86_64, arm and arm64 at
least.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/renesas/rcar-du/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
index 80bd770ae0f6..5394f131c58f 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
@@ -76,7 +76,7 @@ config DRM_RCAR_MIPI_DSI
 	select RESET_CONTROLLER
 
 config DRM_RCAR_VSP
-	bool "R-Car DU VSP Compositor Support" if ARM
+	bool "R-Car DU VSP Compositor Support" if ARM || COMPILE_TEST
 	default y if ARM64
 	depends on DRM_RCAR_DU
 	depends on VIDEO_RENESAS_VSP1=y || (VIDEO_RENESAS_VSP1 && DRM_RCAR_DU=m)
@@ -85,5 +85,5 @@ config DRM_RCAR_VSP
 
 config DRM_RCAR_WRITEBACK
 	bool
-	default y if ARM64
+	default y if ARM64 || COMPILE_TEST
 	depends on DRM_RCAR_DU
-- 
2.56.0

