Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F09FC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D1F10E8A0;
	Mon, 21 Sep 2026 15:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DOswmEm0";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 452AE10E8A0;
 Mon, 21 Sep 2026 15:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005935; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OBVv96TUXdoXic0cqDd4x0l2klxzddq8NcTlmTRkDBPHPkwClnotLGwcJiHoZo6yb2uygiJBPSJF9nDHwWxVQZe+GehSaR6NCxgxvP1wbb+15HI/pU7WFSmD3T3vYqwVdKAvr1BlINBqVTJSGuP1F57Enstg9oqCSo88ZmfLXDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005935;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JuZK847Y5757sJEnhMHU8hTY28zMxad07CW44p71Yy0=; 
 b=MALTOISkOWJDGYoqcjLU+uLFaPLt9FIREdkWFykcGokRsVk4ACqnNnaCeLHHZXNsFaBOILT4a0hG7/ImpRK/qCDs4oqNQqlKwb5e4rB3d2CrFoUMy24gjWAwSgSw4NVJYzkM7i4PQNLnJqA2d5qAhax1/COYA1hMi0vzZ1NIGf0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005935; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=JuZK847Y5757sJEnhMHU8hTY28zMxad07CW44p71Yy0=;
 b=DOswmEm0LaguHnu3Q1ydRg1tcenDett7H52lBaFXY6HfGU28JSHcJxMpljDVAISg
 MMzHrQrD9IJyMbS1IEGDvZa9MhKFQrPp1yVtg1QpuRAdg6cQZND1uBOOefVfYCHdu1v
 KlXZTya6E5CVDpYu/axoP7Ys5MXV7nqk84QkuD/M=
Received: by smtp.zohomail.com with SMTPS id 1790005932561371.5890654858862;
 Mon, 21 Sep 2026 08:52:12 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:28 +0200
Subject: [PATCH RFC 02/25] drm: Add VRR state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-2-2fcd7d011646@collabora.com>
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

Add preliminary state tracking for VRR, and VRR state validation. This
will be used for generating VTEM infoframes in order to support variable
refresh rate functionality.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 227 ++++++++++++++++++++++++
 include/drm/drm_crtc.h                          |  11 ++
 2 files changed, 238 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..d55548399687 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -887,6 +887,229 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
 	return 0;
 }
 
+/**
+ * cmp_fraction - compares two fractional numbers
+ * @a: numerator of the first fraction
+ * @b: denominator of the first fraction
+ * @c: numerator of the second fraction
+ * @d: denominator of the second fraction
+ *
+ * Compare fractional expression given by @a divided by @b with fractional
+ * expression given by @c divided by @d, without running into rounding issues.
+ *
+ * Neither @b nor @d should be 0.
+ *
+ * Returns:
+ *  - %1 if @a / @b > @c / @d
+ *  - %-1 if @a / @b < @c / @d
+ *  - %0 if @a / @b == @c / @d
+ *  - %-EDOM if @b is zero or @d is zero.
+ */
+static int cmp_fraction(u32 a, u32 b, u32 c, u32 d)
+{
+	u64 a_d = mul_u32_u32(a, d);
+	u64 b_c = mul_u32_u32(b, c);
+
+	if (WARN_ON(!b || !d))
+		return -EDOM;
+
+	/* a/b > c/d */
+	if (a_d > b_c)
+		return 1;
+
+	/* a/b < c/d */
+	if (a_d < b_c)
+		return -1;
+
+	/* a/b == c/d */
+	return 0;
+}
+
+static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
+				 u32 rate_n, u32 rate_d, u16 *out_vtotal,
+				 u32 *out_denom, u32 *out_frame_err)
+{
+	u32 denom, result, err;
+	u64 numerator;
+
+	/*
+	 * We perform VRR based rate limiting by adjusting the vertical front
+	 * porch. We do that by picking a new Vtotal to pass to the hardware,
+	 * which extends the display period. Since we can change no other
+	 * timings, this rarely results in a perfect integer match to the
+	 * target framerate. However, we would like to correct for this error
+	 * using only integer math.
+	 *
+	 * For a given refresh rate:
+	 *
+	 * Vtotal =              clock
+	 *          ----------------------------------
+	 *               Htotal * target_refresh
+	 *
+	 * We specify target_refresh as a ratio, because the possible target
+	 * framerates include rates like 23.97... that are actually 24 / 1.001,
+	 * or 24000 / 1001.
+	 *
+	 *                        clock
+	 * Vtotal = ----------------------------------
+	 *            Htotal * target_n / target_d
+	 *
+	 * Some algebra brings us to:
+	 *
+	 *                clock * target_n
+	 * Vtotal = ----------------------------------
+	 *                Htotal * rate_n
+	 *
+	 * The amount of timing error we accumulate every frame will be
+	 * the remainder of that division.
+	 *
+	 * We store the remainder for later. Every frame we add the remainder
+	 * to an accumulator, and when the accumulator exceeds the denominator,
+	 * one Htotal worth of error has accumulated.
+	 *
+	 * In practice, as soon as the accumulated error exceeds half the
+	 * denominator, it is dithered across frames by temporarily extending
+	 * Vtotal by a single row on that frame.
+	 */
+
+	if (check_mul_overflow(mode->crtc_htotal, rate_n, &denom))
+		return -ERANGE;
+
+	if (check_mul_overflow(mode->crtc_clock * 1000ULL, rate_d, &numerator))
+		return -ERANGE;
+
+	result = div_u64_rem(numerator, denom, &err);
+	if (result > U16_MAX)
+		return -ERANGE;
+
+	if (out_vtotal)
+		*out_vtotal = result;
+	if (out_denom)
+		*out_denom = denom;
+	if (out_frame_err)
+		*out_frame_err = err;
+
+	return 0;
+}
+
+static int hdmi_validate_vrr(struct drm_connector *connector,
+			     struct drm_atomic_commit *state)
+{
+	struct drm_connector_state *new_conn_state =
+		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_crtc_state *new_crtc_state =
+		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
+	struct drm_crtc_state *old_crtc_state =
+		drm_atomic_get_old_crtc_state(state, new_conn_state->crtc);
+	struct drm_crtc_vrr_state *vrr_state =
+		&new_crtc_state->vrr_state;
+	struct drm_crtc_vrr_state *old_vrr_state =
+		&old_crtc_state->vrr_state;
+	struct drm_display_info *info = &connector->display_info;
+	const struct drm_display_mode *mode = &new_crtc_state->mode;
+	struct drm_device *dev = connector->dev;
+	int mode_refresh, vfront, ret;
+	u32 min_vfreq_n = info->monitor_range.min_vfreq;
+	u32 min_vfreq_d = 1;
+	u32 max_vfreq_n = info->monitor_range.max_vfreq;
+	u32 max_vfreq_d = 1;
+
+	/* Save on the expensive vic lookup, if nothing else. */
+	if (!new_crtc_state->mode_changed &&
+	    old_crtc_state->vrr_enabled &&
+	    old_vrr_state->vrr_min_n == vrr_state->vrr_min_n &&
+	    old_vrr_state->vrr_min_d == vrr_state->vrr_min_d &&
+	    old_vrr_state->vrr_max_n == vrr_state->vrr_max_n &&
+	    old_vrr_state->vrr_max_d == vrr_state->vrr_max_d &&
+	    info->hdmi.vrr_capable) {
+		memcpy(vrr_state, old_vrr_state, sizeof(*vrr_state));
+		vrr_state->dynamic = false;
+		return 0;
+	}
+
+	if (!new_crtc_state->vrr_enabled)
+		return 0;
+
+	if (!info->hdmi.vrr_capable)
+		return -EOPNOTSUPP;
+
+	mode_refresh = drm_mode_vrefresh(mode);
+
+	/* HDMI uses 10 bits to signal the base refresh. */
+	if (mode_refresh < 0 || mode_refresh > 1023) {
+		drm_dbg_kms(dev, "Mode's refresh of %dHz > HDMI VRR maximum (1023)\n",
+			    mode_refresh);
+		return -EINVAL;
+	}
+
+	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
+		max_vfreq_n = mode_refresh;
+
+	if (!min_vfreq_n) {
+		drm_dbg_kms(dev, "Could not get minimum VRR rate from sink\n");
+		return -EINVAL;
+	}
+
+	vfront = mode->crtc_vsync_start - mode->crtc_vdisplay;
+	if (vfront < 0 || vfront > U8_MAX) {
+		drm_dbg_kms(dev, "Vfront of %d would not fit in VTEM packet\n", vfront);
+		return -EINVAL;
+	}
+
+	vrr_state->vic = drm_match_cea_mode(mode);
+
+	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0) {
+		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
+			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
+		return -EINVAL;
+	}
+
+	ret = hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
+				    &vrr_state->base_vtotal, NULL, NULL);
+	if (ret) {
+		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	/*
+	 * Even at its fastest, it can't go faster than the mode, so
+	 * clamp to avoid imprecisely rounded mode_refresh values we
+	 * can't do anything about from ruining our day.
+	 */
+	vrr_state->base_vtotal = max(vrr_state->base_vtotal, mode->crtc_vtotal);
+
+	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >= 0) {
+		/* refresh <= VRR min, don't do VRR vtotal adjustment */
+		vrr_state->max_vtotal = mode->crtc_vtotal;
+	} else {
+		/*
+		 * Allow additional front porch until effective rate == VRR min
+		 * In essence, this is mode->vtotal * mode_refresh / min_vfreq
+		 * but the relevant factors factored out from drm_mode_vrefresh()
+		 * to avoid working with rounded values, as well as using the
+		 * hardware adjusted crtc_* values instead.
+		 */
+		ret = hdmi_calculate_vtotal(mode, min_vfreq_n, min_vfreq_d,
+					    &vrr_state->max_vtotal, NULL, NULL);
+		if (ret) {
+			drm_dbg_kms(dev, "Couldn't calculate max_vtotal: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+
+		if (vrr_state->max_vtotal < mode->crtc_vtotal) {
+			drm_dbg_kms(dev, "max_vtotal=%u < crtc_vtotal=%u\n",
+				    vrr_state->max_vtotal, mode->crtc_vtotal);
+			return -EINVAL;
+		}
+	}
+
+	drm_dbg_kms(dev, "VRR has base_vtotal=%u max_vtotal=%u from %u/%uHz <= rate <= %u/%uHz\n",
+		    vrr_state->base_vtotal, vrr_state->max_vtotal, min_vfreq_n,
+		    min_vfreq_d, max_vfreq_n, max_vfreq_d);
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
  * @connector: DRM Connector
@@ -919,6 +1142,10 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 
 	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
 
+	ret = hdmi_validate_vrr(connector, state);
+	if (ret)
+		return ret;
+
 	ret = hdmi_generate_infoframes(connector, new_conn_state);
 	if (ret)
 		return ret;
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index be5dca538d87..9d58158af459 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -63,6 +63,14 @@ struct drm_atomic_commit;
 struct drm_crtc_helper_funcs;
 struct drm_plane_helper_funcs;
 
+struct drm_crtc_vrr_state {
+	u8 vic;
+	u16 cur_vtotal;
+	u16 max_vtotal;
+	u16 base_vtotal;
+	bool dynamic;
+};
+
 /**
  * struct drm_crtc_state - mutable CRTC state
  *
@@ -397,6 +405,9 @@ struct drm_crtc_state {
 	 */
 	struct drm_pending_vblank_event *event;
 
+	/** @vrr_state: State related to variable refresh rate. */
+	struct drm_crtc_vrr_state vrr_state;
+
 	/**
 	 * @commit:
 	 *

-- 
2.55.0

