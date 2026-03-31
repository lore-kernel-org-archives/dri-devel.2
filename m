Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E461BFF60EF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C1A10E9D2;
	Tue, 31 Mar 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vh+yNpwa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3CB10E9D2;
 Tue, 31 Mar 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774947993; x=1806483993;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=GRKsEV4/B5Affi6nJaTFORG2Q5NGDAZtsYGa2jaotpw=;
 b=Vh+yNpwav3czU4YlDXrlJzRPrQA6FZgYr7d4axtdo7dRJFioj+11oE/7
 eQptsfC1ko0YSOCw6WCeVF2k0bHeMKdHPouVwUupKp1P22zds68b7f4dQ
 S3KyrufErzvcxkHig749Q6wEArHjGWb7Bc7u3uNjJiba3v73lwJUE1HNB
 /EZnZ1rIsGTfU3GSZkjiy7W2pT9TWTUIJXiM8V4i4cPTk6IsVoazMSRw/
 oZDwXCPhKuW/mopslME40bnIzZhC4e1VRD4KwBnEM6QsvZkq5zVvdL8dP
 CkPwyQv0F0U88ejkHfzZfcV6MGqabAB3t6EvTwE4avooocLC3iY0SE4jk g==;
X-CSE-ConnectionGUID: 75diQh12RhuW+fYKmmemdA==
X-CSE-MsgGUID: vqOGxaumT8SN9feVvfradA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87420716"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87420716"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:06:33 -0700
X-CSE-ConnectionGUID: 8haADkWrQXac/T4Jq4Mx2w==
X-CSE-MsgGUID: u+kW+WMoSf6FuRwEFdpDtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226559796"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 31 Mar 2026 02:06:28 -0700
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Tue, 31 Mar 2026 14:33:58 +0530
Subject: [PATCH v11 6/7] drm/i915/display: Error codes for async flip failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-atomic-v11-6-6a1df7ec5af8@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
In-Reply-To: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, xaver.hugl@kde.org, 
 harry.wentland@amd.com, uma.shankar@intel.com, louis.chauvet@bootlin.com, 
 naveen1.kumar@intel.com, ramya.krishna.yella@intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Arun R Murthy <arun.r.murthy@intel.com>, 
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15-dev
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

For failures in async flip atomic check/commit path return user readable
error codes in struct drm_atomic_state.

v8: Replaced DRM_MODE_ATOMIC_ASYNC_NOT_SUPP_PLANE,
    DRM_MODE_ATOMIC_ASYNC_MODIFIER_NOT_SUPP with INVALUD_API_USAGE
    (Xaver)

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index ee501009a251f18c1c14b6df5c267b7f761871ab..a4cf06f6c74e79eb6429bf8c710ac21cf792c3e3 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -6053,9 +6053,10 @@ static int intel_async_flip_check_uapi(struct intel_atomic_state *state,
 	}
 
 	if (intel_crtc_needs_modeset(new_crtc_state)) {
-		drm_dbg_kms(display->drm,
-			    "[CRTC:%d:%s] modeset required\n",
-			    crtc->base.base.id, crtc->base.name);
+		drm_mode_atomic_add_error_msg(&state->base.error_code,
+					      DRM_MODE_ATOMIC_NEED_FULL_MODESET,
+					      "[CRTC:%d:%s] requires full modeset",
+					      crtc->base.base.id, crtc->base.name);
 		return -EINVAL;
 	}
 
@@ -6122,9 +6123,10 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 	}
 
 	if (intel_crtc_needs_modeset(new_crtc_state)) {
-		drm_dbg_kms(display->drm,
-			    "[CRTC:%d:%s] modeset required\n",
-			    crtc->base.base.id, crtc->base.name);
+		drm_mode_atomic_add_error_msg(&state->base.error_code,
+					      DRM_MODE_ATOMIC_NEED_FULL_MODESET,
+					      "[CRTC:%d:%s] requires full modeset",
+					      crtc->base.base.id, crtc->base.name);
 		return -EINVAL;
 	}
 
@@ -6162,11 +6164,12 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 
 		if (!intel_plane_can_async_flip(plane, new_plane_state->hw.fb->format,
 						new_plane_state->hw.fb->modifier)) {
-			drm_dbg_kms(display->drm,
-				    "[PLANE:%d:%s] pixel format %p4cc / modifier 0x%llx does not support async flip\n",
-				    plane->base.base.id, plane->base.name,
-				    &new_plane_state->hw.fb->format->format,
-				    new_plane_state->hw.fb->modifier);
+			drm_mode_atomic_add_error_msg(&state->base.error_code,
+						      DRM_MODE_ATOMIC_INVALID_API_USAGE,
+						      "[PLANE:%d:%s] pixel format %p4cc / 0x%llx modifier does not support async flip",
+						      plane->base.base.id, plane->base.name,
+						      &new_plane_state->hw.fb->format->format,
+						      new_plane_state->hw.fb->modifier);
 			return -EINVAL;
 		}
 

-- 
2.25.1

