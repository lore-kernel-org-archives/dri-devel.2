Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77669CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3049F10F1F8;
	Tue,  6 Oct 2026 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="G3P4tk8l";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D88310E08F;
 Mon,  5 Oct 2026 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L/
 8dJDe/+jfXtDt9j5QUe4zcu97XzaFmLUHIy422Cjg=; b=G3P4tk8lnLdTrCDP8C
 XmkG8emaDuXA+yn+ao1dcNQTlZTrImpsOtTg721FvS8Qz14NDxiG8qYzOZ/DEQPz
 Eq5+IB9JYSfXx0MgdsTHP0m2Lp3c74xAgdHNBJUF/KDFX/TPKvrQeQfgezavAbUi
 dY33SHrLs9RXQFHaEA/u1Da1E=
Received: from 163.com (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgBnX6_tesNql_rOCg--.32055S5;
 Mon, 05 Oct 2026 18:24:49 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, ankit.k.nautiyal@intel.com
Subject: [PATCH v3 3/3] drm/i915/ddi: Program AS SDP before enabling the
 transcoder
Date: Mon,  5 Oct 2026 18:24:45 +0800
Message-ID: <20261005102445.12710-4-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005102445.12710-1-xizheTang2005@163.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
 <20261005102445.12710-1-xizheTang2005@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgBnX6_tesNql_rOCg--.32055S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWkCrWkCFykAFWrCr45KFg_yoWxXw4DpF
 48XFy5JFs8ZF1I9ryxJF4jyFy5Ww4kAa43GrZxG3s3Z3Z8J3WYqr40ya4jgFyDuFZxWw1S
 yr1DJrWqg3WjgrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdpnQUUUUU=
X-Originating-IP: [2001:250:20f:1:a533:cf01:13a0:45f8]
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6hFmvWrDevEJWQAA3S
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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

intel_vrr_set_transcoder_timings() already programs TRANS_VRR_VSYNC
and EMP_AS_SDP_TL after TRANS_DDI_FUNC_CTL and before TRANS_CONF.
The Adaptive-Sync SDP itself is still written from
intel_dp_set_infoframes() in intel_ddi_enable_dp(), after
intel_enable_transcoder().

On this Panther Lake eDP, Adaptive Sync = Always still streaks on
lid s2idle resume after the previous two patches. That path sends
AVT_DYNAMIC_VTOTAL (operation mode 0), not the fixed-RR mode-1
packet. The same policy is clean when userspace toggles Adaptive
Sync on an already-lit panel, so the sink can handle the SDP once
the pipe is up.

Write the SDP from intel_ddi_enable() immediately after
intel_vrr_transcoder_enable(), before intel_enable_transcoder().
intel_ddi_enable_dp() runs after TRANS_CONF and must not rewrite
it: keep intel_dp_set_infoframes() from clearing VIDEO_DIP_ENABLE_AS_ADL
on enable, and stop writing AS SDP from there.

Fastset still goes through intel_ddi_update_pipe_dp() on a live
pipe. Call intel_dp_set_as_sdp() there so a VRR toggle can keep
the stock fastset path: intel_crtc_check_fastset() will still
clear mode_changed when only the AS enable bit differs. When the
packet is not needed, the helper clears VIDEO_DIP_ENABLE_AS_ADL
instead of leaving a stale transmission.

The send path does not OR VIDEO_DIP_ENABLE_AS_ADL in the helper:
intel_write_dp_sdp() calls write_infoframe (hsw_write_infoframe on this
eDP), which sets the DIP enable bit after the payload, same as VSC.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
Tested-by: Xizhe Tang <xizheTang2005@163.com> # 7.2.8 xe.ko and drm-tip, PTL eDP, Adaptive Sync=Always lid resume
---
Changes in v3:
- New. Needed on this panel for Always + s2idle; 1+2 alone are not
  enough there. Optional if you only want the Never/Automatic fix.
- Do not touch intel_pipe_config_compare(). Forcing as_sdp onto the
  fastset compare, or switching the AS enable-bit exclude from || to
  &&, turns a runtime Adaptive Sync toggle into a full modeset.
  Keep intel_ddi_update_pipe_dp() writing or clearing the packet.
- Comment that hsw_write_infoframe() sets VIDEO_DIP_ENABLE_AS_ADL
  after the payload; do not OR the HW bit again in the helper.
- Hunks retargeted to drm-tip line numbers.

 drivers/gpu/drm/i915/display/intel_ddi.c |  4 ++++
 drivers/gpu/drm/i915/display/intel_dp.c  | 27 ++++++++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_dp.h  |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d..c80e246 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3555,6 +3555,9 @@ static void intel_ddi_enable(struct intel_atomic_state *state,
 
 	intel_vrr_transcoder_enable(crtc_state);
 
+	if (!is_hdmi)
+		intel_dp_set_as_sdp(encoder, crtc_state);
+
 	/* 128b/132b SST */
 	if (!is_hdmi && intel_dp_is_uhbr(crtc_state)) {
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
@@ -3651,6 +3654,7 @@ static void intel_ddi_update_pipe_dp(struct intel_atomic_state *state,
 	intel_ddi_set_dp_msa(crtc_state, conn_state);
 
 	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
+	intel_dp_set_as_sdp(encoder, crtc_state);
 
 	intel_backlight_update(state, encoder, crtc_state, conn_state);
 	drm_connector_update_privacy_screen(conn_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 95efc99..a8d1958 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5403,6 +5403,30 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
 	dig_port->write_infoframe(encoder, crtc_state, type, &sdp, len);
 }
 
+void intel_dp_set_as_sdp(struct intel_encoder *encoder,
+			 const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	intel_reg_t reg = HSW_TVIDEO_DIP_CTL(display, crtc_state->cpu_transcoder);
+
+	if (crtc_state->infoframes.enable &
+	    intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC)) {
+		/*
+		 * hsw_write_infoframe() sets VIDEO_DIP_ENABLE_AS_ADL
+		 * after the payload.
+		 */
+		intel_write_dp_sdp(encoder, crtc_state, DP_SDP_ADAPTIVE_SYNC);
+		return;
+	}
+
+	if (!HAS_AS_SDP(display))
+		return;
+
+	intel_de_write(display, reg,
+		       intel_de_read(display, reg) & ~VIDEO_DIP_ENABLE_AS_ADL);
+	intel_de_posting_read(display, reg);
+}
+
 void intel_dp_set_infoframes(struct intel_encoder *encoder,
 			     bool enable,
 			     const struct intel_crtc_state *crtc_state,
@@ -5414,7 +5438,7 @@ void intel_dp_set_infoframes(struct intel_encoder *encoder,
 			 VIDEO_DIP_ENABLE_VS_HSW | VIDEO_DIP_ENABLE_GMP_HSW |
 			 VIDEO_DIP_ENABLE_SPD_HSW | VIDEO_DIP_ENABLE_DRM_GLK;
 
-	if (HAS_AS_SDP(display))
+	if (!enable && HAS_AS_SDP(display))
 		dip_enable |= VIDEO_DIP_ENABLE_AS_ADL;
 
 	u32 val = intel_de_read(display, reg) & ~dip_enable;
@@ -5437,7 +5461,6 @@ void intel_dp_set_infoframes(struct intel_encoder *encoder,
 		return;
 
 	intel_write_dp_sdp(encoder, crtc_state, DP_SDP_VSC);
-	intel_write_dp_sdp(encoder, crtc_state, DP_SDP_ADAPTIVE_SYNC);
 
 	intel_write_dp_sdp(encoder, crtc_state, HDMI_PACKET_TYPE_GAMUT_METADATA);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 04fae20..342ed75 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -133,6 +133,8 @@ bool intel_dp_needs_vsc_colorimetry(const struct intel_crtc_state *crtc_state,
 void intel_dp_set_infoframes(struct intel_encoder *encoder, bool enable,
 			     const struct intel_crtc_state *crtc_state,
 			     const struct drm_connector_state *conn_state);
+void intel_dp_set_as_sdp(struct intel_encoder *encoder,
+			 const struct intel_crtc_state *crtc_state);
 void intel_read_dp_sdp(struct intel_encoder *encoder,
 		       struct intel_crtc_state *crtc_state,
 		       unsigned int type);
-- 
2.55.0

