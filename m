Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9360CCA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D2710EC70;
	Mon, 12 Oct 2026 04:16:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CBE10EB97;
 Mon, 12 Oct 2026 04:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778554; x=1823314554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mkenn1cmg3FQZzKnZ0c3ej6KNpXHiptHn7OmJG6sOqg=;
 b=eHrfBc1fCTib0nurANynlJTCqktnnnxt4BPQFllIav9ECgkLJW6PjGtt
 zAWC34hTl9RjQz1lvFUPpnk9R0PSMdmVH9f6CidlvzZ6Q4D5o1GKFDHMW
 fNwb/quRjzvbpjbGv/1cw7Tbas3QLFEVz+o1x2PHBZDMtPsWan7E0SVUd
 oHcpI5MmvkuxgdIutncZN8lNrNglIHq6fFbRRVXi+i+JfebPFmwOe32+w
 MFoh58NcMLI37J0SNAjoAbqXDe/pgLGhWFDPS7a/Kfn7opLUs+QYGDvVN
 LVtBfc7QrenotzkEfTReH2nkGuRP6pFsoRcIPqluV6qkRtN12FXpAkW0n g==;
X-CSE-ConnectionGUID: qP7RkZS6SzuhtJnoJOBbZw==
X-CSE-MsgGUID: qyCoKuYATf+yN/dNtWZaXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380943"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380943"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:54 -0700
X-CSE-ConnectionGUID: 5HaJJjgOT2iRHWpMQyMUzw==
X-CSE-MsgGUID: AO2fzs5STZyQrmGsB9BR6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256696"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:52 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 44/56] drm/i915/hdmi_frl_dfm: Write and read back FRL Link
 M/N
Date: Mon, 12 Oct 2026 09:27:53 +0530
Message-ID: <20261012035806.3361439-45-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Program the computed FRL Link M/N into the transcoder PIPE_LINK_M1/N1
registers along with the other FRL DFM registers, just before enabling
the transcoder.

Read it back in the FRL DFM readout for the state checker.

v2: Read full 31 bits from LINK_M/N for HDMI FRL.

Bspec: 68848
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
index 8062baed63db..384e92d89e29 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
@@ -725,6 +725,26 @@ bool intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
 	return true;
 }
 
+static void frl_set_m_n(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+
+	intel_de_write(display, PIPE_LINK_M1(display, cpu_transcoder),
+		       crtc_state->frl.link_m);
+	intel_de_write(display, PIPE_LINK_N1(display, cpu_transcoder),
+		       crtc_state->frl.link_n);
+}
+
+static void frl_get_m_n(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+
+	crtc_state->frl.link_m = intel_de_read(display, PIPE_LINK_M1(display, cpu_transcoder));
+	crtc_state->frl.link_n = intel_de_read(display, PIPE_LINK_N1(display, cpu_transcoder));
+}
+
 void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
@@ -735,6 +755,8 @@ void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
 	if (!crtc_state->frl.enable)
 		return;
 
+	frl_set_m_n(crtc_state);
+
 	reg = TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans);
 	val = TB_ACTUAL_OFFSET(crtc_state->frl.tb_actual);
 	intel_de_rmw(display, reg, TB_ACTUAL_OFFSET_MASK, val);
@@ -753,6 +775,8 @@ void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state)
 	if (!crtc_state->frl.enable)
 		return;
 
+	frl_get_m_n(crtc_state);
+
 	val = intel_de_read(display, TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans));
 	crtc_state->frl.tb_actual =
 		REG_FIELD_GET(TB_ACTUAL_OFFSET_MASK, val);
-- 
2.50.1

