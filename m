Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D9C5ACAC
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E4010F3F1;
	Fri,  7 Aug 2026 04:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KTidsSae";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB8A10F3EE;
 Fri,  7 Aug 2026 04:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077194; x=1817613194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CxtgEY15QGXEStnSZixGBpjoUuEoe0HCdHT5+FeSaE0=;
 b=KTidsSaeLxWeDfQBRG4eg9Jd9fIVNkJlwgFYHi3IrRtc4ACc9hCHyRCh
 L7OVv/W+765gHjyXWa7fSIWfCPW3FYhwDfqATy8D4F90WsimDdZk6y4h/
 xrm5f6Jp/a5yLb6+H8l0ZKgC/4jgJ4rWQ/ir8YCnooVFtJB8ML1DirKTv
 /UrkCmOxe3wbmXZc+bKNGEHpE0QXecChY/WcWdIhbpi9fhUxqxZA1PGdX
 WGAgDArzGfEGK+6FkKTvMKx4MzV3qQQpv/sXv00V68IggDJOK1QKdyxq0
 W0GYT3WXDju9jqJp0Eyv1P63jrv/tMBaramsLncJsHy+nKJNvxFtCygK8 w==;
X-CSE-ConnectionGUID: PJTwYIjSQfmf25Mp1wwMUA==
X-CSE-MsgGUID: Z8GkHhqGT2OpiZBWK1ck1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619400"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:14 -0700
X-CSE-ConnectionGUID: kMhivC9WTQ6BbFtmNh6gaw==
X-CSE-MsgGUID: uLJqneh6Sk68DVLx06+BYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666602"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:11 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 42/44] drm/i915/display: Add FRL members to the state checker
Date: Fri,  7 Aug 2026 09:44:27 +0530
Message-ID: <20260807041430.229038-43-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Plug in the FRL members to the state checker.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 829d7a411dcc..ca429ea385c6 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5555,6 +5555,15 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 
 	PIPE_CONF_CHECK_I(set_context_latency);
 
+	PIPE_CONF_CHECK_BOOL(frl.enable);
+	PIPE_CONF_CHECK_BOOL(frl.rsrc_sched_en);
+	PIPE_CONF_CHECK_I(frl.required_lanes);
+	PIPE_CONF_CHECK_I(frl.tb_borrowed);
+	PIPE_CONF_CHECK_I(frl.tb_actual);
+	PIPE_CONF_CHECK_I(frl.active_char_buf_threshold);
+	PIPE_CONF_CHECK_I(frl.link_m);
+	PIPE_CONF_CHECK_I(frl.link_n);
+
 #undef PIPE_CONF_CHECK_X
 #undef PIPE_CONF_CHECK_I
 #undef PIPE_CONF_CHECK_LLI
-- 
2.50.1

