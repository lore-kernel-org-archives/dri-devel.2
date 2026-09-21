Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5EDC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0FF10EA49;
	Mon, 21 Sep 2026 15:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="I2ERqQNv";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6924A10EA49;
 Mon, 21 Sep 2026 15:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790006001; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N7vVbuDej8VgLQ0DPVwNy3IK5WoD21dk+inFRdNbFD7BqFslISshLYyfchcjIatQsMl/bqHx0OCyBVQOrduuW3/jCuZXrhdo2JYAC0gvimhb5rOFS0jCyKC9xrJaGprCy4oFpLxEuu7XJ64YfU3KkHzdng1vR+usDjqyuD1/HvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790006001;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2340rAUPh+cjIYbPiCBSqhKVXnIH+nymunIe5WSMkVg=; 
 b=ZiWc8eitpYdEBN2y5Po87aQK+D2baoB5LfseFiKOiL0JGjMTxPVhCFVb/DCYcTC0SgQgIq8CgqnCl/GbzdS99sVtIx6Ygp9xsYB5DucByzGjOvSNdqlrPDXrl0pcKmKfLaRgAxYYy56yHq4V1cSGv5a3qM7elZtJtxSCkxVpQb0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006001; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=2340rAUPh+cjIYbPiCBSqhKVXnIH+nymunIe5WSMkVg=;
 b=I2ERqQNvVfm9A861OCq83Nz52IWUOpUIRkcyMwvJYfrdpGStzz+z690BUerdYOrB
 /EybheP/knZ22rMkIekvoh3p7dVokjwuF0wNx1kwJpElTYgNRPDO/qsHlItch6lVikV
 1MtT8VUhLAFsTHeFKb+hyS/ETXLvi/R7zfmO7jeE=
Received: by smtp.zohomail.com with SMTPS id 1790006000937510.4944678062657;
 Mon, 21 Sep 2026 08:53:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:40 +0200
Subject: [PATCH RFC 14/25] drm: Implement VRR rate limiting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-14-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Currently, VRR is allowed to use the entire range advertised by the
sink's EDID. Userspace may find it desirable, however, to limit this
range, or set a fixed target rate entirely. The latter is mainly useful
for multimedia playback applications, where judder can be avoided by
matching the content's frame rate precisely.

With the new VRR target frame rate properties, the necessary
infrastructure is in place to allow implementing this.

Add the necessary logic to hdmi_validate_vrr, as well as the VRR
helpers. Since not every target rate can be reached precisely, the
per-frame error is calculated, and dithered one row at a time across
subsequent frames. This means some frames are one vtotal larger than
others, so that averaged over the frames, the desired target rate is
achieved. Such dithering is explicitly permitted by HDMI, and is still
considered a constant target frame rate.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 108 ++++++++++++++++++++----
 drivers/gpu/drm/drm_crtc_helper.c               |  34 +++++++-
 include/drm/drm_crtc.h                          |   3 +
 include/drm/drm_crtc_helper.h                   |   2 +
 4 files changed, 130 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 33d0c9491643..7dbd678cf061 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
@@ -1046,6 +1047,39 @@ static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
 	return 0;
 }
 
+static int hdmi_validate_vrr_limits(struct drm_crtc_state *crtc_state, u16 vrr_min)
+{
+	struct drm_crtc_vrr_state *vrr_state = &crtc_state->vrr_state;
+	const struct drm_display_mode *mode = &crtc_state->mode;
+	u32 limit_d;
+	int ret;
+
+	/* No limiter, don't need to validate, but reset the error */
+	if (!drm_crtc_helper_vrr_is_fixed_rate(vrr_state)) {
+		vrr_state->per_frame_err = 0;
+		return 0;
+	}
+
+	/* Don't allow rates equal to or below the minimum VRR rate / 1.001 */
+	if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
+			 vrr_min * 1000, 1001) < 0)
+		return -EINVAL;
+
+	if (check_mul_overflow(mode->crtc_htotal, vrr_state->vrr_min_n, &limit_d))
+		return -ERANGE;
+
+	ret = hdmi_calculate_vtotal(&crtc_state->mode, vrr_state->vrr_min_n,
+				    vrr_state->vrr_min_d, &vrr_state->base_vtotal,
+				    &vrr_state->denom, &vrr_state->per_frame_err);
+	if (ret)
+		return ret;
+
+	if (vrr_state->base_vtotal < mode->crtc_vtotal)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int hdmi_validate_vrr(struct drm_connector *connector,
 			     struct drm_atomic_commit *state)
 {
@@ -1067,6 +1101,7 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 	u32 min_vfreq_d = 1;
 	u32 max_vfreq_n = info->monitor_range.max_vfreq;
 	u32 max_vfreq_d = 1;
+	bool is_fixed;
 
 	/* Save on the expensive vic lookup, if nothing else. */
 	if (!new_crtc_state->mode_changed &&
@@ -1099,6 +1134,10 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
 		max_vfreq_n = mode_refresh;
 
+	is_fixed = drm_crtc_helper_vrr_is_fixed_rate(vrr_state);
+	if (is_fixed && info->hdmi.cinema_vrr)
+		min_vfreq_n = 24;
+
 	if (!min_vfreq_n) {
 		drm_dbg_kms(dev, "Could not get minimum VRR rate from sink\n");
 		return -EINVAL;
@@ -1112,25 +1151,64 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 
 	vrr_state->vic = drm_match_cea_mode(mode);
 
-	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
-		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
-			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
-		return -EINVAL;
-	}
-
-	ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
-				    &vrr_state->base_vtotal, NULL, NULL);
+	ret = hdmi_validate_vrr_limits(new_crtc_state, min_vfreq_n);
 	if (ret) {
-		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
+		drm_dbg_kms(dev, "Invalid VRR fixed target rate: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
-	/*
-	 * Even at its fastest, it can't go faster than the mode, so
-	 * clamp to avoid imprecisely rounded mode_refresh values we
-	 * can't do anything about from ruining our day.
-	 */
-	vrr_state->base_vtotal = max(vrr_state->base_vtotal, mode->crtc_vtotal);
+	if (!is_fixed) {
+		vrr_state->dynamic = true;
+
+		if (vrr_state->vrr_min_n) {
+			if (!vrr_state->vrr_min_d)
+				return -EINVAL;
+
+			if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
+					 min_vfreq_n * 1000, 1001) < 0) {
+				drm_dbg_kms(dev, "Target min (%u/%u) < supported min (%u/%u)\n",
+					    vrr_state->vrr_min_n, vrr_state->vrr_min_d,
+					    min_vfreq_n, min_vfreq_d);
+				return -EINVAL;
+			}
+			min_vfreq_n = vrr_state->vrr_min_n;
+			min_vfreq_d = vrr_state->vrr_min_d;
+		}
+		if (vrr_state->vrr_max_n) {
+			if (!vrr_state->vrr_max_d)
+				return -EINVAL;
+
+			if (cmp_fraction(vrr_state->vrr_max_n, vrr_state->vrr_max_d,
+					 max_vfreq_n, max_vfreq_d) > 0) {
+				drm_dbg_kms(dev, "Target max (%u/%u) > supported max (%u/%u)\n",
+					    vrr_state->vrr_max_n, vrr_state->vrr_max_d,
+					    max_vfreq_n, max_vfreq_d);
+				return -EINVAL;
+			}
+			max_vfreq_n = vrr_state->vrr_max_n;
+			max_vfreq_d = vrr_state->vrr_max_d;
+		}
+		if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
+			drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
+				    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
+			return -EINVAL;
+		}
+
+		ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
+					    &vrr_state->base_vtotal, NULL, NULL);
+		if (ret) {
+			drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+
+		/*
+		 * Even at its fastest, it can't go faster than the mode, so
+		 * clamp to avoid imprecisely rounded mode_refresh values we
+		 * can't do anything about from ruining our day.
+		 */
+		vrr_state->base_vtotal = max(vrr_state->base_vtotal,
+					     mode->crtc_vtotal);
+	}
 
 	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >= 0) {
 		/* refresh <= VRR min, don't do VRR vtotal adjustment */
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 4ffb3b0b7878..c46de778df30 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -838,6 +838,22 @@ int drm_crtc_helper_set_config(struct drm_mode_set *set,
 }
 EXPORT_SYMBOL(drm_crtc_helper_set_config);
 
+bool drm_crtc_helper_vrr_is_fixed_rate(const struct drm_crtc_vrr_state *vrr)
+{
+	if (!vrr->vrr_min_n)
+		return false;
+
+	if (!vrr->vrr_min_d || !vrr->vrr_max_d)
+		return false;
+
+	if (mul_u32_u32(vrr->vrr_min_n, vrr->vrr_max_d) ==
+	    mul_u32_u32(vrr->vrr_min_d, vrr->vrr_max_n))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(drm_crtc_helper_vrr_is_fixed_rate);
+
 /**
  * drm_crtc_helper_vrr_flush - Update VRR state on frame ready
  * @crtc_state: pointer to &struct drm_crtc_state of CRTC that has a new frame ready
@@ -864,6 +880,9 @@ bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
 		return false;
 	}
 
+	if (drm_crtc_helper_vrr_is_fixed_rate(vrr))
+		return false;
+
 	if (vrr->cur_vtotal == vrr->base_vtotal)
 		return false;
 
@@ -889,10 +908,21 @@ bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
 	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
 	u16 old_vtotal = vrr->cur_vtotal;
 
-	if (!crtc_state->vrr_enabled)
+	if (!crtc_state->vrr_enabled) {
 		vrr->cur_vtotal = 0;
-	else
+		vrr->cur_err = 0;
+	} else if (drm_crtc_helper_vrr_is_fixed_rate(vrr)) {
+		if (vrr->cur_err * 2 >= vrr->denom) {
+			vrr->cur_err -= vrr->denom;
+			vrr->cur_vtotal = vrr->base_vtotal + 1;
+		} else {
+			vrr->cur_vtotal = vrr->base_vtotal;
+		}
+
+		vrr->cur_err += vrr->per_frame_err;
+	} else {
 		vrr->cur_vtotal = vrr->max_vtotal;
+	}
 
 	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
 		vrr->dynamic = true;
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index df37f4ebb58e..00e9df02f3d5 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -71,6 +71,9 @@ struct drm_crtc_vrr_state {
 	u32 vrr_min_d;
 	u32 vrr_max_n;
 	u32 vrr_max_d;
+	u32 denom;
+	u32 per_frame_err;
+	int cur_err;
 	u16 base_vtotal;
 	bool dynamic;
 };
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index 0c8c11ea36dd..7d7b75045bd9 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -45,6 +45,7 @@ struct drm_framebuffer;
 struct drm_mode_set;
 struct drm_modeset_acquire_ctx;
 struct drm_crtc_state;
+struct drm_crtc_vrr_state;
 
 void drm_helper_disable_unused_functions(struct drm_device *dev);
 int drm_crtc_helper_set_config(struct drm_mode_set *set,
@@ -63,6 +64,7 @@ int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
 void drm_helper_resume_force_mode(struct drm_device *dev);
 int drm_helper_force_disable_all(struct drm_device *dev);
 
+bool drm_crtc_helper_vrr_is_fixed_rate(const struct drm_crtc_vrr_state *vrr);
 bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state);
 bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state);
 

-- 
2.55.0

