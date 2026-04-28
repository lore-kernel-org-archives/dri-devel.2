Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1706CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF9E10EA7E;
	Tue, 28 Apr 2026 07:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BJju8wCB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B248B10EA7B;
 Tue, 28 Apr 2026 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363194; x=1808899194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XC/s1inXAOBUY3FpCAj7gLMcLQ0mNdSW1WC9IuFeZmg=;
 b=BJju8wCBY4FySn+XjEpI5hemtXwV6MrPiRpfsdnCT5iaMaHbAlJKYXbL
 72XG7RMP5Ulul75jZMGL0OM18e/c4GraxpsloPTXwI9sm7zb05KN1py5S
 MbFxA9guVh2Jdn1HyO3BAUY5Ntc/ePC50NUPbZTP6oUo8UdFp7OnWUS2p
 4ss5+M+r0T+w6IuRJbzO+wSrCiunUVJahsCF6RTc2yC/liKD1Hkb+phcy
 gdTjPKvQSf559cbvwUE7H7F+cgYKmmZmnrNcQI9RkCI+uIJ1fSvNLH6Mu
 y4QWmJWI97y9M1R2oIWo2lYgzNsNm6U/wg1PEbLWlbMzMna5bId9weXtv Q==;
X-CSE-ConnectionGUID: 4RBrj6FfQ3qHX82fnMuk9g==
X-CSE-MsgGUID: a2aGM0YdTHyiWdRo1MHILg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82115917"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82115917"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:54 -0700
X-CSE-ConnectionGUID: 9JfWhFBxQ6K+fYDXJ0Hyow==
X-CSE-MsgGUID: o+dJUK7VQZespkEjcWxkoQ==
X-ExtLoop1: 1
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:59:52 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 8/9] drm/dp: Add target_rr_divider field in AS SDP logging
Date: Tue, 28 Apr 2026 13:14:56 +0530
Message-ID: <20260428074457.3566918-9-ankit.k.nautiyal@intel.com>
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

The field target_rr_divider is missing from the AS SDP logging.
Add it and print the divider value (1.001 or 1.000) as per the DP 2.1 spec.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 654be04431ad..fc550b48fd85 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3540,6 +3540,8 @@ void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp
 	drm_printf(p, "    duration increase ms: %d\n", as_sdp->duration_incr_ms);
 	drm_printf(p, "    duration decrease ms: %d\n", as_sdp->duration_decr_ms);
 	drm_printf(p, "    operation mode: %d\n", as_sdp->mode);
+	drm_printf(p, "    target rr divider: %s\n",
+		   as_sdp->target_rr_divider ? "1.001" : "1.000");
 	drm_printf(p, "    coasting vtotal: %d\n", as_sdp->coasting_vtotal);
 }
 EXPORT_SYMBOL(drm_dp_as_sdp_log);
-- 
2.45.2

