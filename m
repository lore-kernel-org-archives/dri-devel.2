Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA993CA9EDC
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D54710EC6E;
	Mon, 12 Oct 2026 04:16:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FA010E614;
 Mon, 12 Oct 2026 04:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778559; x=1823314559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PlIuh7j4LatzXrG1HrxUaXhmSr/3oTkwSv27IgfUGG4=;
 b=mVWzFnoHk45TMKRWcJ68/81lsaf/q6UKmE9NsEdzVAcXs8owrZBSvOiI
 EgToIL/OgfGjfS3LCpM9tTjcsT5Fc3y2yu60vGicrZBQvOJp2FKXRK6/r
 sWieiXGHYXYfTKk82xfw84Lp/tDHD5D6OUrls3dFJ9hp9NTuQogqFfkrh
 jMeImWkVoVTAq3gCugMdN6eqveXsxiQHP54ZY86cvPCsbYtvMUxdZxhoC
 3Vm3D25hjXticZzlhTwkoGetUUtU73pezvjh1dsrtx2+o3v1eWa0O+m6P
 qqfz959ruv+9cCEnCKIzZqtleE0atECzSDd+PqX7tdw/HDJahP7wz4FF2 Q==;
X-CSE-ConnectionGUID: tKxmYbSPR6adx8kVBDIpIg==
X-CSE-MsgGUID: Kf71Dlo0RZCC7kf0ZfG0sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380946"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380946"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:59 -0700
X-CSE-ConnectionGUID: urr1Fwp4RiSrp4JeuaEhxQ==
X-CSE-MsgGUID: TVHRBYd2Qp6q02Mal0umgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256720"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:57 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 46/56] drm/i915/display: Add FRL members to the state
 checker
Date: Mon, 12 Oct 2026 09:27:55 +0530
Message-ID: <20261012035806.3361439-47-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
 drivers/gpu/drm/i915/display/intel_display.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index d5d4453f283b..f9233b5f5b6a 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5626,6 +5626,14 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 
 	PIPE_CONF_CHECK_I(set_context_latency);
 
+	PIPE_CONF_CHECK_BOOL(frl.enable);
+	PIPE_CONF_CHECK_BOOL(frl.rsrc_sched_en);
+	PIPE_CONF_CHECK_I(frl.required_lanes);
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

