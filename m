Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71D7C44534
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706DE10E67E;
	Mon, 20 Jul 2026 05:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d5vEHJfd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A307D10E674;
 Mon, 20 Jul 2026 05:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524547; x=1816060547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nkd2O1E3fX+r/k7Iw4fqWBOCJhWDIMnCqcv57IslaRY=;
 b=d5vEHJfd3IDhgHXOoEPuu9syYvX7ITypIl+75M+u4cfkhxa8Vrh7fvA4
 mWlVfcMXFVruL8QcC5OleKNMplXceYpV28AlaEzCMgn3f+LH+Wxz93t+l
 q5deNznvDkkSYMrr8d+Mw5H9uJzyBuEdcymWJQVNiH7yZ2sMqvhcskD+5
 zNrKoM2TPwgiHycMPc6iGGkyTUzZHrKoBgzCIAm8IfFGlBDzdo3qAltpd
 hgYU6WTsU+YmXJ8+tJ78Ni0geTiTl8jwYXc3MwH6G/UGuln+SKOGFkTY5
 sNXDNd4mwk54kbcdxLE/pIWemv2WEQB6JKtdzpU4qLbKS9CMtZ0bOpF4/ Q==;
X-CSE-ConnectionGUID: SO+LP70oRZS/zWfdcJgnPg==
X-CSE-MsgGUID: toIf5ROLRISVTYBu7iER8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133414"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133414"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:47 -0700
X-CSE-ConnectionGUID: cO53Zs/fSKK3EtxOrmDkOQ==
X-CSE-MsgGUID: g3sq63BVQ+ec72bli3sftw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419810"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:47 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 08/14] drm/i915/color: Add YUV range correction to SDR plane
 pipeline
Date: Mon, 20 Jul 2026 10:21:25 +0530
Message-Id: <20260720045131.971650-9-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
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

Insert the INTEL_PLANE_CB_YUV_RANGE_CORRECT color block into the SDR
plane color pipeline. This enables YCbCr limited-to-full range expansion
ahead of the CSC block that expects full range pixel data. With this,
the pipeline can accept limited range framebuffers.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 7d25f4fbfa9b..7457fa51cb97 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -44,6 +44,7 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 };
 
 static const enum intel_color_block sdr_plane_pipeline[] = {
+	INTEL_PLANE_CB_YUV_RANGE_CORRECT,
 	INTEL_PLANE_CB_CSC_FF,
 };
 
-- 
2.25.1

