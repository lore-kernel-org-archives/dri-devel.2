Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFDEFF493D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D3210E365;
	Mon, 30 Mar 2026 04:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cDDoDOZ2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA17910E350;
 Mon, 30 Mar 2026 04:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844547; x=1806380547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SnxBZnjPqtDlmMqJUgDLCL2fzmuJX+wkD+cf/LpwmvA=;
 b=cDDoDOZ29cn7Cc1Vv10x9OwDkMvyFDDOhHBxI6hPzpGk7y9/WA+deske
 6gdz8O0uyFq3lDUgs29wYvTyskVVXlVnbta6DixartdCznUw/VtKg5IwZ
 h3GuMgnLHEbSu6OdMbmy+XUHXvFAJkz1aW+bPp0POSC+XOsuMrdXeXZ9P
 iwbLkw0L1LZyKdzEF/4tAQpMxmUiBsxtAVcHABslCfTKwLXRHD0wP9YxH
 UPnkXrB/reyNsJtnbOBFhpNDRbsS6saNBXbLeMghUoVcoZTy1Jk+J+49p
 TtDtS7dWgV/1chbKGfEko77eweAmdldyc4sR4e9k446LTIuBaeQttBoJJ w==;
X-CSE-ConnectionGUID: mDMVb4NQRhu2ex1h1urWwg==
X-CSE-MsgGUID: UYxtrHT3TpuEiOIQz2rcgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218241"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:26 -0700
X-CSE-ConnectionGUID: k747453CQByqZcd55ZjIeQ==
X-CSE-MsgGUID: na+RU1C7QgeJqnFPvBkcQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871244"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:24 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 11/19] drm/i915/dp: Include all relevant AS SDP fields in
 comparison
Date: Mon, 30 Mar 2026 09:36:48 +0530
Message-ID: <20260330040656.4116502-12-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

Add missing drm_dp_as_sdp header fields to intel_compare_dp_as_sdp()
comparison.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 57870baebfa5..a0e7ef2574b2 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -4906,11 +4906,14 @@ static bool
 intel_compare_dp_as_sdp(const struct drm_dp_as_sdp *a,
 			const struct drm_dp_as_sdp *b)
 {
-	return a->revision == b->revision &&
+	return a->sdp_type == b->sdp_type &&
+		a->revision == b->revision &&
+		a->length == b->length &&
 		a->vtotal == b->vtotal &&
 		a->target_rr == b->target_rr &&
 		a->duration_incr_ms == b->duration_incr_ms &&
 		a->duration_decr_ms == b->duration_decr_ms &&
+		a->target_rr_divider == b->target_rr_divider &&
 		a->mode == b->mode;
 }
 
-- 
2.45.2

