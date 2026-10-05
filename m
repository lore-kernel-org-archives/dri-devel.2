Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCAECA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BECD10F1F6;
	Tue,  6 Oct 2026 07:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BGzERCUr";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CB910E08F;
 Mon,  5 Oct 2026 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=T7
 WnC7MBfk9TVgPXsg1udDhs31Wk8ItwE10by3LqXXA=; b=BGzERCUrvKHFVstUXY
 y/FK2XIlYse/f9RfEXejb2HJxB6ZyYau+lTX2wNoO392aAN9Er/NCQJ9xXsmKuA6
 kKgXHlZPG2GwtAqyo4NkZ+gRSNKH/dMkJBn2dGlMqVq3Alye0sh9pFs/D0DIGPY8
 R9FOcHHBXCLQuz7y1AnXyYHZY=
Received: from 163.com (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgBnX6_tesNql_rOCg--.32055S3;
 Mon, 05 Oct 2026 18:24:47 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, ankit.k.nautiyal@intel.com, stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/i915/dp: Reserve AS SDP guardband even when VRR is
 off
Date: Mon,  5 Oct 2026 18:24:43 +0800
Message-ID: <20261005102445.12710-2-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005102445.12710-1-xizheTang2005@163.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
 <20261005102445.12710-1-xizheTang2005@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgBnX6_tesNql_rOCg--.32055S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDWr1rZryxGF43CFyfJFb_yoW5JF1Upw
 4xWFyUKF1rJa4Sgry7JF1IyFy5W39Yk345Gwn8C3sIvayDZr98Jr9Yyay2gFyDursxAw1r
 ArnrJrs0kw4qqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn18PUUUUU=
X-Originating-IP: [2001:250:20f:1:a533:cf01:13a0:45f8]
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6hBmvWrDevAJTQAA3G
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

intel_vrr_compute_optimized_guardband() calls
intel_dp_sdp_min_guardband(crtc_state, true) so that enabling an SDP
later does not have to grow crtc_vblank_start and trigger a full
modeset.

The Adaptive-Sync clause ignores assume_all_enabled and only looks at
infoframes.enable. Toggling vrr.enable therefore changes the
guardband, which is why sending AS SDP cannot currently follow
vrr.enable.

Reserve the AS SDP lines whenever assume_all_enabled is set on a
HAS_AS_SDP platform, same as the other SDP types in this function.
The next patch can then gate transmission on vrr.enable without
moving vblank.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
Tested-by: Xizhe Tang <xizheTang2005@163.com> # 7.2.8 xe.ko and drm-tip, PTL eDP; Never<->Always stays a fastset
---
Changes in v3:
- New patch. Addresses Ville's review of v2: needs_as_sdp is also
  how the optimized guardband is sized, so the send predicate must
  not be tied to vrr.enable until this reservation is independent.
- Hunks retargeted to drm-tip line numbers.

 drivers/gpu/drm/i915/display/intel_dp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d93..7bfe796 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7500,6 +7500,7 @@ int intel_dp_get_lines_for_sdp(const struct intel_crtc_state *crtc_state, u32 ty
 int intel_dp_sdp_min_guardband(const struct intel_crtc_state *crtc_state,
 			       bool assume_all_enabled)
 {
+	struct intel_display *display = to_intel_display(crtc_state);
 	int sdp_guardband = 0;
 
 	if (assume_all_enabled ||
@@ -7514,7 +7515,9 @@ int intel_dp_sdp_min_guardband(const struct intel_crtc_state *crtc_state,
 		sdp_guardband = max(sdp_guardband,
 				    intel_dp_get_lines_for_sdp(crtc_state, DP_SDP_PPS));
 
-	if (crtc_state->infoframes.enable &
+	/* Keep the VRR guardband independent of vrr.enable. */
+	if ((assume_all_enabled && HAS_AS_SDP(display)) ||
+	    crtc_state->infoframes.enable &
 	    intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC))
 		sdp_guardband = max(sdp_guardband,
 				    intel_dp_get_lines_for_sdp(crtc_state, DP_SDP_ADAPTIVE_SYNC));
-- 
2.55.0

