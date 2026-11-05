Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1526606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=JRTJC/bM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55E21127CC;
	Thu,  5 Nov 2026 15:52:55 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54041127CC;
 Thu,  5 Nov 2026 15:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793893960; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KGyqzZzBdp/MVUr6Emz2v9RfWvkYSayrG3eO1mk2IFhJi8l2U5hQ6vXTseia9reI+Qo2tf8rnrrd8k8o6RkuNZVD6I1zQc5joc11fGbb1xSMz8GweacIeHCp68ZAkCppBnY34yFpPZrzz2MH6gSUB5mNkmZnQGNMFKyDSrzGhBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793893960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8yQyhPCe79CCtZXo/sw+mFhQfjfA+Kf2lu1++L8BKHg=; 
 b=FQhry/SBwETuvjClpvmkGF00D7Gg1vegtBXlOcYiuXZGpBd8a3jvOzY4J6FP30gcIPalelmtLDZEsNsLjM/lNA+07ga5NC30Djcer9vFN4pZFlSm48wSdhA4qSB5R1MDbVsPVTwbe34iHDu5YozMT4MJ+61C/AIicjiL7VdzI7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=JRTJC/bMM1HpmWBmu/2E5lTPzaZpvSoCda4yEYiUXgcya/xfeibLOY+Eeiy8JYplhusPXz2olgKhdKAzeIbqdqSnYm63/pXKQYt4S9r60sJqH6bwx8Lq2/yt0xg5BYBXAbfsZ4Y6b8g8MK5s76BPPdS6SD82JNFrELoKHnALFH8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=8yQyhPCe79CCtZXo/sw+mFhQfjfA+Kf2lu1++L8BKHg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793893958648883.6976838744795;
 Thu, 5 Nov 2026 07:52:38 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:52 +0100
Subject: [PATCH v2 01/27] drm: Add VRR state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-1-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add preliminary state tracking for VRR, and VRR state validation. This
will be used for generating VTEM infoframes in order to support variable
refresh rate functionality.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 208 ++++++++++++++++++++++++
 include/drm/drm_crtc.h                          |  10 ++
 2 files changed, 218 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c63d439382bb..eb6abfd1350d 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -887,6 +887,210 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
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
+	struct drm_crtc_vrr_state *vrr_state =
+		&new_crtc_state->vrr_state;
+	struct drm_display_info *info = &connector->display_info;
+	const struct drm_display_mode *mode = &new_crtc_state->mode;
+	struct drm_device *dev = connector->dev;
+	int mode_refresh, vfront, ret;
+	u32 min_vfreq_n = info->hdmi.vrr_cap.vrr_min;
+	u32 min_vfreq_d = 1;
+	u32 max_vfreq_n = info->hdmi.vrr_cap.vrr_max;
+	u32 max_vfreq_d = 1;
+
+	if (!new_crtc_state->vrr_enabled)
+		return 0;
+
+	if (!info->hdmi.vrr_cap.supported)
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
@@ -919,6 +1123,10 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 
 	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
 
+	ret = hdmi_validate_vrr(connector, state);
+	if (ret)
+		return ret;
+
 	ret = hdmi_generate_infoframes(connector, new_conn_state);
 	if (ret)
 		return ret;
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index be5dca538d87..bfb2b0741625 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -63,6 +63,13 @@ struct drm_atomic_commit;
 struct drm_crtc_helper_funcs;
 struct drm_plane_helper_funcs;
 
+struct drm_crtc_vrr_state {
+	u16 cur_vtotal;
+	u16 max_vtotal;
+	u16 base_vtotal;
+	bool dynamic;
+};
+
 /**
  * struct drm_crtc_state - mutable CRTC state
  *
@@ -397,6 +404,9 @@ struct drm_crtc_state {
 	 */
 	struct drm_pending_vblank_event *event;
 
+	/** @vrr_state: State related to variable refresh rate. */
+	struct drm_crtc_vrr_state vrr_state;
+
 	/**
 	 * @commit:
 	 *

-- 
2.56.0

