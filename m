Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515FACA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C49810E3ED;
	Mon, 12 Oct 2026 04:14:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE97710E3E6;
 Mon, 12 Oct 2026 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778481; x=1823314481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wka3vaZHcI1PMp3m9S7F/gBt0PM8/4AXZYKMJatdhXI=;
 b=R2pqoL63AsgV3JAIrjKbiSJBABlpgkZXGKn8nebLPV49XnuF0r1X7ghI
 7ZVBNM6rYq/sEsybKyLn71QKAMtqCVuG3nRk3L8WsuEe7lXvhBCuREzA/
 RZUiuSELOsAqyog3oC4zHb4P02DTnVrC1JbaP1C3GUK/cyFIJG9sRhOPK
 tgUyWwOClNkJaJgDLviSbC4jCmIiU+tLdFmn8W/lxVAYzjvKMIP19+v2T
 Bs1qzdkboNqQeXmf1S+A8jqCyQ/0Vp0OpoPSUzpPYBrl4J+zm7bflG/Or
 BO2vEdb8S4zGRhhvcQyzi/e2IeJtvVySRDlHs6EsmnWD6WYIS1XcmkYnN g==;
X-CSE-ConnectionGUID: NSz5dgNqSSGHCGfXzHTp+Q==
X-CSE-MsgGUID: zHej+UV+Q7Oq4JREBGHzlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380843"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380843"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:41 -0700
X-CSE-ConnectionGUID: ABhazhCdSEKooAs5NJ4fkQ==
X-CSE-MsgGUID: B9Uf1jOGRzCkBOOgWN0Uyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256379"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:40 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 12/56] drm/i915/ddi: Update HDMI modeset sequence for MTL+
Date: Mon, 12 Oct 2026 09:27:21 +0530
Message-ID: <20261012035806.3361439-13-ankit.k.nautiyal@intel.com>
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

Per BSpec, the HDMI enable sequence differs starting MTL+: the port
must be fully configured and enabled (DDI_CTL_DE) before enabling the
transcoder (TRANS_CONF), whereas pre-MTL platforms enable the
transcoder before the port (DDI_BUF_CTL).

Today the HDMI path still uses the pre-MTL ordering: when the MTL+ DDI
sequences were implemented, HDMI was left enabling the transcoder before
the port. This does not cause any visible issue with current TMDS usage,
but it needs to be corrected before FRL can be wired up.

Bspec: 49191, 54145 (pre-MTL)
Bspec: 65750, 68848 (MTL+)
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a5a5a4f37262..1e08ffe19447 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3497,7 +3497,8 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_vrr_transcoder_enable(crtc_state);
 
-	intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+	if (DISPLAY_VER(display) < 14)
+		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
 
 	if (!intel_hdmi_handle_sink_scrambling(encoder, connector,
 					       crtc_state->hdmi_high_tmds_clock_ratio,
@@ -3600,6 +3601,9 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_ddi_buf_enable(encoder, buf_ctl);
 
+	if (DISPLAY_VER(display) >= 14)
+		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
+
 	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
 }
 
-- 
2.50.1

