Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9257FD5F98
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB09210E5B6;
	Wed,  8 Apr 2026 08:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="edfCJZLa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6068F10E5B2;
 Wed,  8 Apr 2026 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638675; x=1807174675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uDfnAhuPeQpYybCGDkoBbLrE24EWqvm4HBK5ycB3WjE=;
 b=edfCJZLaE4duYtqcKHnhAEAplk5YfGG3vkzZwlaSeLpWEFUSuD8zfGLZ
 Sr6dXvqfgInZJsWHLmBjovZ6OKksO1O6WhE+pqhtoqGoOTLLsfvF0ZFPy
 ioEJygIZ9KXz4vo9GeKl9uJflewlF61aWFuDL6rU2f7sbAkAqkjNvC/EG
 ZYCIYQeyPem85BizqMZ6J8nXt/0YgUkZ+/21LlXZrt4rBMJ6pa26Bix5r
 Sy5Qe+xp+tw4YY19U2QpJGx1HzCSF3VqYd5eHbUFM2Pk9o8gocOArgVhI
 4UIN1IceDLqUpprnN+lE3RJZwtMJV8N4xqvRTiVMp18j4O7zDh+0HTF+0 A==;
X-CSE-ConnectionGUID: /3X57uP7SjClDrRHDbZtZg==
X-CSE-MsgGUID: e7+fePV1QW2V9cT6OiZlhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516633"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516633"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:55 -0700
X-CSE-ConnectionGUID: CqrbdsV6RECVsB4pOcZaJA==
X-CSE-MsgGUID: z00FE/wlS+63iJEXGAaIfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572511"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:57:53 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 07/26] drm/dp: Add target_rr_divider field in AS SDP logging
Date: Wed,  8 Apr 2026 14:12:19 +0530
Message-ID: <20260408084239.1295325-8-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

The field target_rr_divider is missing from the AS SDP logging.
Add it and print the divider value (1.001 or 1.000) as per the DP 2.1 spec.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 102328d9022d..c8421099a3ac 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3537,6 +3537,8 @@ void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp
 		   dp_sdp_type_get_name(as_sdp->sdp_type), as_sdp->revision, as_sdp->length);
 	drm_printf(p, "    vtotal: %d\n", as_sdp->vtotal);
 	drm_printf(p, "    target_rr: %d\n", as_sdp->target_rr);
+	drm_printf(p, "    target_rr_divider: %s\n",
+		   as_sdp->target_rr_divider ? "1.001" : "1.000");
 	drm_printf(p, "    duration_incr_ms: %d\n", as_sdp->duration_incr_ms);
 	drm_printf(p, "    duration_decr_ms: %d\n", as_sdp->duration_decr_ms);
 	drm_printf(p, "    operation_mode: %d\n", as_sdp->mode);
-- 
2.45.2

