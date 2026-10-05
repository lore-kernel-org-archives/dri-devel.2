Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0350CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0F010E246;
	Tue,  6 Oct 2026 07:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="IxYQ2ipS";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16AA10E0D2;
 Mon,  5 Oct 2026 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RQ
 7NmRkBfVM2cjbOkbAgB/nrxbWaowRzjlFi+WR5ddw=; b=IxYQ2ipSaPUl59+OdZ
 nFCi2hI2bL0mCVJCJ4UrPxp+NoCpfLkBd/TzDG2cp1wXC5Glh9nXGcZClyGD399k
 Wg/9ZltXMSuXR7f5l2veUErVfJEMh6+xmfAt3k0TgYxscMXTs9UOj8T/vU2U524b
 c/fZhL+Yz5/XwU+o2iPDrxYrs=
Received: from 163.com (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgBnX6_tesNql_rOCg--.32055S4;
 Mon, 05 Oct 2026 18:24:49 +0800 (CST)
From: Xizhe Tang <xizheTang2005@163.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, ankit.k.nautiyal@intel.com, stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/i915/dp: Send AS SDP only when VRR or CMRR is
 enabled
Date: Mon,  5 Oct 2026 18:24:44 +0800
Message-ID: <20261005102445.12710-3-xizheTang2005@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005102445.12710-1-xizheTang2005@163.com>
References: <20260923195200.21362-1-xizheTang2005@163.com>
 <20261005102445.12710-1-xizheTang2005@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgBnX6_tesNql_rOCg--.32055S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW5Jw1xAFy8uw4DuryfZwb_yoW5JFWfpw
 1xWFyFvF4fJF92gFWxJ3WI9Fy5u39rtayrG3W5J3yfZ3WDAa43Jr40va4jkF9rur4fuw15
 trZ5XFyj9w4xZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnEf5UUUUU=
X-Originating-IP: [2001:250:20f:1:a533:cf01:13a0:45f8]
X-CM-SenderInfo: x0l2xvpwdqwjqqqvqiywtou0bp/xtbC6RFmvWrDevHH5wAA3h
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

intel_vrr_possible() is crtc_state->vrr.flipline != 0.
intel_vrr_compute_fixed_rr_timings() programs flipline even when VRR
is off, so commit 6a1712052859 sends an Adaptive-Sync SDP with
DP_AS_SDP_AVT_FIXED_VTOTAL on a constant refresh.

On a Panther Lake eDP that only advertises VRR in EDID, that packet
vertically streaks the first modeset (boot and s2idle resume) when
Adaptive Sync is Never or Automatic.

Send the SDP only while VRR or CMRR is actually enabled. Keep the
Panel Replay aux-less-ALPM early return from the same commit. The
previous patch already reserves the AS SDP guardband when
assume_all_enabled is set, so this does not move crtc_vblank_start
when userspace toggles Adaptive Sync.

vrr.in_range is not a substitute here: this panel's EDID range is
30-120 Hz, so 60 Hz and 120 Hz stay in_range with VRR off and still
get AVT_FIXED_VTOTAL.

This does not fix Adaptive Sync = Always. That path already has
vrr.enable set and is handled by the next patch.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9252
Fixes: 6a1712052859 ("drm/i915/dp: Enable AS SDP whenever VRR is possible or PR !async")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: Xizhe Tang <xizheTang2005@163.com>
Tested-by: Xizhe Tang <xizheTang2005@163.com> # 7.2.8 xe.ko and drm-tip, PTL eDP, Adaptive Sync=Never/Automatic
---
Changes in v3:
- Guardband reservation moved to 1/3 so this no longer changes
  crtc_vblank_start when vrr.enable toggles (Ville).
- Commit message rewritten around why, not the code path (Jani).
- Record that vrr.in_range still sends on this 30-120 Hz panel.
- Use vrr.cmrr.enable (nested under vrr on drm-tip). v2 used the
  older sibling cmrr.enable.

 drivers/gpu/drm/i915/display/intel_dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7bfe796..95efc99 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3113,7 +3113,8 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	    !intel_psr_pr_async_video_timing_supported(intel_dp))
 		return true;
 
-	return intel_vrr_possible(crtc_state);
+	/* intel_vrr_possible() is also true for fixed RR. */
+	return crtc_state->vrr.enable || crtc_state->vrr.cmrr.enable;
 }
 
 static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
-- 
2.55.0

