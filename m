Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94CEC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4616810F192;
	Tue, 15 Sep 2026 18:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PS24Dpg+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11ED10E497;
 Tue, 15 Sep 2026 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497592; x=1821033592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DtTTtoC+biWBZ3KhMdWpDIzntMl2HethLm0VKvpGP9E=;
 b=PS24Dpg+SYCpIICrgJ7DoXDaV78/4SNvJN1N1HHtT4BotZZrqhWnsduI
 OeWVv+RpYZj7NjJq8HuFxYEV6pWumqh/BMi88awxJi5PVJ7PN4IVwmz9w
 3UwXOefDsADMSxktOgjhrJrxg9ut3iUbRNyz40ri6L5ibeNf+UE0THrUJ
 SMetqqRHthIfMj/qN5rcKJoGHjTyLt5dJlltkDHJCXkaagpQiBlx0UAri
 YFCSmUE4q0g6hw8vEyYC26BoRA5I6Hshdy0ma/eSERZn9QCV9vqH2LJUA
 xPg2G00aPxsYlWqF79piWUYWs5hmFJQVeZp5f384UYynxg7xi4CtXkO5X Q==;
X-CSE-ConnectionGUID: /c/4+F3XRd2JO2ytUrrbMQ==
X-CSE-MsgGUID: y2iyFoEkRuWlViB+i0wDeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380373"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:51 -0700
X-CSE-ConnectionGUID: Irmi1QVcR4Cby2XcWe0f+w==
X-CSE-MsgGUID: +UYF84jJT82aKvJH6ZlCnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148621"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:49 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 18/18] drm/i915/alpm: Disallow ALPM for UHBR link rate
Date: Tue, 15 Sep 2026 23:34:49 +0530
Message-Id: <20260915180449.277933-19-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

DP2.1 ALPM is not supported on UHBR (128b/132b) link rates on the NVL
platform. Reject the ALPM parameter computation for external DP running
at a UHBR rate on display version 35, so that ALPM (and the Panel Replay
and LOBF features that rely on it) is not enabled in that case. eDP is
excluded so eDP ALPM keeps working at any link rate.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 84777c8d31bb..51805a6bca86 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -453,6 +453,12 @@ bool intel_alpm_compute_params(struct intel_dp *intel_dp,
 	int precharge = intel_dp_aux_fw_sync_len(intel_dp) - preamble;
 	u8 max_wake_lines;
 
+	/* DP2.1 ALPM is not supported on UHBR (128b/132b) link rates on NVL. */
+	if (DISPLAY_VER(display) == 35 &&
+	    !intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP) &&
+	    intel_dp_is_uhbr(crtc_state))
+		return false;
+
 	io_wake_time = max(precharge, io_buffer_wake_time(crtc_state)) +
 		preamble + phy_wake + tfw_exit_latency;
 	fast_wake_time = precharge + preamble + phy_wake +
-- 
2.29.0

