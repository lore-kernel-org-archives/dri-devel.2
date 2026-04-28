Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665BFF8870
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3F110EA5B;
	Tue, 28 Apr 2026 07:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZeLeBrKS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7776C10EA6F;
 Tue, 28 Apr 2026 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363190; x=1808899190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IRcl9VU7R+qawgM+ceXt/6RVOtbt7qgozl0eglG+ZHo=;
 b=ZeLeBrKS0+fj6Af5XKLX2+R8GD5oGIGcNsfEKReRk5FAjh4pERAYaZjF
 dQpeVP6WQFFYauI1SzeUgVUkgPrJMkU90yIGJtZW+jru9+7ctmrnyOT+G
 w/DoWTcyVI90jfTXusHT4L+A0JKD5XrQX+nkrhNfIEVkbyDkX3voN7MHe
 fFk/q9LXLLprE7YwhOtGNZY1PL1Idnmq+8ZjFbCNhAacDPqPCP2Gc+pEC
 H3zY/D2FwISYwu8B1uabSzLg2BkEV2vbbetaOk70CU0TaizNT0KjCyvCB
 mHyN4em/eAfvnLKPSbxmbMch4E9fMiUTN8R7tInCLR68Sr59WOONqEWA4 w==;
X-CSE-ConnectionGUID: QNE2iJk6S5yDHZbIQcld4Q==
X-CSE-MsgGUID: +S7xcjglSLy5kUN2YAJa9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82115914"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82115914"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:50 -0700
X-CSE-ConnectionGUID: nNxwmp0OTOKdZIr/2iJ5aA==
X-CSE-MsgGUID: UMqbvBj0QhaJSrWKu0Ls/w==
X-ExtLoop1: 1
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:48 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 6/9] drm/dp: Store coasting vtotal in struct drm_dp_as_sdp
Date: Tue, 28 Apr 2026 13:14:54 +0530
Message-ID: <20260428074457.3566918-7-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260428074457.3566918-1-ankit.k.nautiyal@intel.com>
References: <20260428074457.3566918-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add new field in struct drm_dp_as_sdp to store coasting vtotal.
This is used by the sinks that support Panel Replay and Asynchronous
timing during PR Active to derive refresh rate, when AS SDP transmission
is stopped by the source.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 1 +
 include/drm/display/drm_dp_helper.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 745559826cd9..5f523d0514a5 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3512,6 +3512,7 @@ void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp
 	drm_printf(p, "    duration increase ms: %d\n", as_sdp->duration_incr_ms);
 	drm_printf(p, "    duration decrease ms: %d\n", as_sdp->duration_decr_ms);
 	drm_printf(p, "    operation mode: %d\n", as_sdp->mode);
+	drm_printf(p, "    coasting vtotal: %d\n", as_sdp->coasting_vtotal);
 }
 EXPORT_SYMBOL(drm_dp_as_sdp_log);
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 1d0acd58f486..8c2d77a032f0 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -126,6 +126,7 @@ struct drm_dp_as_sdp {
 	int duration_decr_ms;
 	bool target_rr_divider;
 	enum operation_mode mode;
+	int coasting_vtotal;
 };
 
 void drm_dp_as_sdp_log(struct drm_printer *p,
-- 
2.45.2

