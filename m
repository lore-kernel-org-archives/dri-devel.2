Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056FE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WxM242wp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0C110E97C;
	Mon, 26 Oct 2026 05:40:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204A210E978;
 Mon, 26 Oct 2026 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993250; x=1824529250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MqoPFVwAPikUyAMKDlry3546AYbNV849boOFHu7vJBI=;
 b=WxM242wpeMYjgtHqAuOviAmY5KuBa+A6HVQAo5sI4tdC+hUYiTQJB41i
 0bY/vQfvO3DcA+69Vrjs1vC/Gv23EDNAeeQWOgKOcAC+d5aZkuSE9VLY4
 zvgIrUtW+zyGlBjzFIfcbtxKiOrK0S5EVUiyvn16HW0sDYQO3NGQIWVE5
 Ok+QYfQHgG7NYAS21Cxb2QhKbmJe7gwsE3eaVNFrM12OE2pf4agzjQ2qg
 Tw9QiT5XrriwOOAY9b9O7908jc3xmKhNvhjjsbcpAl2fFoYCDbhgE4DeJ
 4AcdGVRrYnAMlgBBg0ttgSBjUGMZTe3CBl7PQWASclNHYSP5zLV8wnd7r Q==;
X-CSE-ConnectionGUID: 2Bs/Q+K1Ta27yA1g9NcMsw==
X-CSE-MsgGUID: kwf3pkhVQpilHdvr1Uwm/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550203"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550203"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:50 -0700
X-CSE-ConnectionGUID: +R54eggkQdmJrB83IRZ8tA==
X-CSE-MsgGUID: cErDmbNHTNew0teQd1/yCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001952"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:48 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 12/20] drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield for
 xe3lpd
Date: Mon, 26 Oct 2026 11:09:23 +0530
Message-ID: <20261026054001.799894-13-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LFPS_CYCLE_COUNT bitfield in PORT_ALPM_LFPS_CTL is widened from
4 bits (27:24) to 7 bits (30:24) starting from xe3lpd. Add the wider
register mask and field macro, and program the cycle count using the
appropriate macro based on the display version.

v2: Split in a separate patch. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 11 ++++++++++-
 drivers/gpu/drm/i915/display/intel_psr_regs.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 1fd528cb7fe6..f3c0884989ce 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -747,12 +747,21 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 		return;
 
 	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+		int lfps_cycle = get_lfps_cycle_count(crtc_state);
+		u32 lfps_cycle_val;
+
+		if (DISPLAY_VER(display) >= 35)
+			lfps_cycle_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_XE3LPD(lfps_cycle);
+		else
+			lfps_cycle_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(lfps_cycle);
+
 		alpm_ctl_val = PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE |
 			PORT_ALPM_CTL_MAX_PHY_SWING_SETUP(15) |
 			PORT_ALPM_CTL_MAX_PHY_SWING_HOLD(0) |
 			PORT_ALPM_CTL_SILENCE_PERIOD(
 				crtc_state->alpm_state.silence_period_sym_clocks);
-		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(get_lfps_cycle_count(crtc_state)) |
+
+		lfps_ctl_val = lfps_cycle_val |
 			PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(
 				crtc_state->alpm_state.lfps_half_cycle_num_of_syms) |
 			PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 124aa74e1dbb..aee4f2592302 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -335,8 +335,10 @@
 #define PORT_ALPM_LFPS_CTL(port)				_MMIO_PORT(port, _PORT_ALPM_LFPS_CTL_A, _PORT_ALPM_LFPS_CTL_B)
 #define  PORT_ALPM_LFPS_CTL_LFPS_START_POLARITY			REG_BIT(31)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK		REG_GENMASK(27, 24)
+#define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK_XE3LPD	REG_GENMASK(30, 24)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(val)		REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
+#define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_XE3LPD(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK_XE3LPD, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
 /*
  * The LFPS half cycle duration fields (including the first and last half
  * cycle) are zero-based, i.e. the value programmed is N_Symbol - 1.
-- 
2.43.0

