Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC67606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I6gVCoBN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F770112124;
	Thu, 26 Nov 2026 08:11:04 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C8A10E166
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:53:17 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2f0621eec70so45486235ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661597; x=1796266397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HTpYziNr2PAVPjcMV9h6mD6LtVNtvdaTWVXPJB6QgmI=;
 b=I6gVCoBNsHfQCYK+bHZ8yObpHvugZm7tym5G3y+RS5fQwEXRCBmWQD/oCUsGqVBJ4d
 IAwlJ3GFb6SZcUouj9S0AAiM2bb+u2s7EtHoyRYZbQ66HyuHUCnwrAebQ80UAgjco9nu
 XeOatHEUz/irtiSg2WHmNsOZ3DDbkPmaDMoXEm/nRF0wn6p67gEquE7lM49E4iypvk02
 abhPUz7OQDj97wGywoFcCRGiqlosv0aT9RKaEW34kDYE9NY/M643bzACSara5G35k+PP
 MaT26chLglPqA199pQK7QvmhOqr3I2BRxZzK2Ed3Zz3IYJEUBQpYSfx2ovVQO7XK3kDG
 GuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661597; x=1796266397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HTpYziNr2PAVPjcMV9h6mD6LtVNtvdaTWVXPJB6QgmI=;
 b=zPrNX4UBgojzpDlxlJ2MHvUrJ803hycPejNTnWXrSUJ6sJzd0Xp08960/42btQL5dT
 FA4PaVHZtatHZagCyzST5SbPc99M/LCpXBUcYSC3BdIWgY1jfRJuK92S5cuYo3bXnpzv
 hgOA+cusEvYuthpfDf73MShvMMJMaWzC6/vhXnMz5Rbs2BI8m8n7Q4+KOoicsqANh4xP
 raORN32AsadaBJU+eOc0VSVEkxW8xKcgCqAyHlqKCr7IImu9bCgnFGe9YWyENsOyj7x1
 fGZs2pjIXGtbhxRqlI1mhRluIm+TudE9vrl1TT1KdeiazIUwPUPKGeryN26cA0CQQfdb
 VF1A==
X-Forwarded-Encrypted: i=1;
 AL+hErHED6vVXRA5LyzlYTqyMq+kdZLuXpGg7RB9K49EtRYVblARwSPxffkR6FHawHQ/aUff10UvNUXdXF4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8/+jtBgGG4kbn1WM/FvLbCssPgKXPnFZ+Opkgxv789GCIINbKj
 7ix6MVbxFOAh3xZe7l4meabOhE72gaHYxebT2vLZgdDIvao6H20UVmtY
X-Gm-Gg: AZFdTZeXLlAG3VaYjWm1v3SoLid19zefqijQRCBe4UPmSLDgWGoVcNcHWjInyzDJ2w0
 j9jpmt7XSE9WTfMeBT/hVkCBsD43D7EiVnAJNmIPTzjKfOuDmfhCfwWHjvnSLaARwm2gF7WL+Lb
 pjHZV9CN08SA45UWu5QmLGfDsJnlQyXMdHBjtRm1tnid270FvKkuFLQaXLRFmfwr6ZhtDODgrNV
 0LDQu7AToYJHILLeLoMo6peBH4wRtWf1l5+1ClsjgLW/3H6qOIfRsS8TSkoBBYefTVhMNM+22gB
 mhPFPodTJMA21DascHdkQmBMn6n0QWGe6OwY5iHDXbXKoqccfR9h0uX70XbZULh+MFjjCMpxhk5
 j7I7HimfburxEmvKJ2EoF+hulD+2ZKsW7dIdQ5vsQUfKxXE0mw4B7u/ZnXvVC7836OriRHj33xj
 ryvTptvFzU/+ycD7yqB5f3jiSlkUmRd3XinckvNugULrr+jDb5qzGr6tuTUHRysclM4EyWrSFqT
 zo2tXVHzpfU2PQPV6Uzhu9vOIUQf21A5Dw0lA73KWwj5mKPtyrrUb/VP4EI6DqZ7wk4M1KBC/TF
 PxqrJc2/Y+4ak80zNg3xM736M/gCJcL7/cjtCFyrXRZmp0nfEBC7g7hDt52ND2rfJYM+2Q/183D
 0JMl1zmI06i5iCHTF82GoHOXt0HiHG/c=
X-Received: by 2002:a17:90b:2e49:b0:3a4:b0f3:6597 with SMTP id
 98e67ed59e1d1-3b41c58ae4dmr18404220a91.0.1795661596519; 
 Wed, 25 Nov 2026 18:53:16 -0800 (PST)
Received: from DESKTOP-TPPBPA1 (36-226-201-204.dynamic-ip.hinet.net.
 [36.226.201.204]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b50234fb25sm1768700a91.2.2026.11.25.18.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:53:16 -0800 (PST)
From: Roy <rongh7426@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel --confirm=neverMaintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Roy <rongh7426@gmail.com>
Subject: [PATCH] drm/vc4: hdmi: Reject modes that don't fit the BCM2711 timing
 registers
Date: Thu, 26 Nov 2026 10:53:11 +0800
Message-ID: <20261126025311.640543-1-rongh7426@gmail.com>
X-Mailer: git-send-email 2.51.1.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vc5_hdmi_set_timings() packs the mode timings into register fields that
are much narrower than the values a mode can carry (for example 11 bits
for the horizontal back porch and 9 bits for the vertical back porch),
but nothing checks that a mode fits before it gets there. Such a mode
passes the atomic check, VC4_SET_FIELD() warns once for every field
that overflows, and the truncated timings are written to the hardware.

The igt test kms_invalid_mode, subtest overflow-vrefresh, hits this on a
Raspberry Pi 5: it sets a mode with htotal = vtotal = 32768, the commit
succeeds and four warnings are printed:

  WARNING: CPU: 0 PID: 64500 at vc4_hdmi.c:1282 vc5_hdmi_set_timings+0x970/0xed8 [vc4]
  WARNING: CPU: 0 PID: 64500 at vc4_hdmi.c:1284 vc5_hdmi_set_timings+0x980/0xed8 [vc4]
  WARNING: CPU: 0 PID: 64500 at vc4_hdmi.c:1288 vc5_hdmi_set_timings+0x994/0xed8 [vc4]
  WARNING: CPU: 0 PID: 64500 at vc4_hdmi.c:1311 vc5_hdmi_set_timings+0xbb4/0xed8 [vc4]

Add a timings_valid() variant hook, implemented for the BCM2711 and
BCM2712 controllers, that computes the same values as
vc5_hdmi_set_timings() and checks each one against its field, and call
it from the encoder's mode_valid(). Modes that don't fit are now
rejected at atomic check time, and dropped from the probed mode list.

The BCM2835 controller (vc4_hdmi_set_timings()) has the same kind of
narrow fields but is left alone here, as I have no hardware to test it.

Tested on a Raspberry Pi 5 (Raspberry Pi OS kernel 6.18.39, with this
change applied to its vc4 driver):
- kms_invalid_mode: 12 pass / 1 fail, 4 warnings -> 13 pass / 0 fail,
  no warnings
- all 12 modes from the monitor's EDID (including 1920x1080i and
  720x480) are still listed, and none is reported as rejected

The failure was found with igt-gpu-tools. The fix and this changelog
were written with the help of an AI coding assistant (Claude); the
testing above was done on real hardware.

Fixes: 8323989140f3 ("drm/vc4: hdmi: Support the BCM2711 HDMI controllers")
Signed-off-by: Roy <rongh7426@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 50 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h |  6 ++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f3ec65d..4e10cde 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1254,6 +1254,44 @@ static void vc5_hdmi_set_timings(struct vc4_hdmi *vc4_hdmi,
 	drm_dev_exit(idx);
 }
 
+/*
+ * Check that every value vc5_hdmi_set_timings() writes fits in its
+ * register field. Such a mode would otherwise be programmed with
+ * truncated timings, and VC4_SET_FIELD() would warn about it on every
+ * modeset.
+ */
+static enum drm_mode_status
+vc5_hdmi_timings_valid(const struct drm_display_mode *mode)
+{
+	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+	u32 pixel_rep = (mode->flags & DRM_MODE_FLAG_DBLCLK) ? 2 : 1;
+	struct drm_display_mode m;
+
+	drm_mode_init(&m, mode);
+	drm_mode_set_crtcinfo(&m, CRTC_INTERLACE_HALVE_V);
+
+	if (!FIELD_FIT(VC5_HDMI_HORZA_HAP_MASK, m.hdisplay * pixel_rep) ||
+	    !FIELD_FIT(VC5_HDMI_HORZA_HFP_MASK,
+		       (m.hsync_start - m.hdisplay) * pixel_rep) ||
+	    !FIELD_FIT(VC5_HDMI_HORZB_HBP_MASK,
+		       (m.htotal - m.hsync_end) * pixel_rep) ||
+	    !FIELD_FIT(VC5_HDMI_HORZB_HSP_MASK,
+		       (m.hsync_end - m.hsync_start) * pixel_rep) ||
+	    !FIELD_FIT(VC5_HDMI_VERTB_VSPO_MASK, m.htotal >> (2 - pixel_rep)))
+		return MODE_H_ILLEGAL;
+
+	if (!FIELD_FIT(VC5_HDMI_VERTA_VSP_MASK,
+		       m.crtc_vsync_end - m.crtc_vsync_start) ||
+	    !FIELD_FIT(VC5_HDMI_VERTA_VFP_MASK,
+		       m.crtc_vsync_start - m.crtc_vdisplay) ||
+	    !FIELD_FIT(VC5_HDMI_VERTA_VAL_MASK, m.crtc_vdisplay) ||
+	    !FIELD_FIT(VC4_HDMI_VERTB_VBP_MASK,
+		       m.crtc_vtotal - m.crtc_vsync_end + interlaced))
+		return MODE_V_ILLEGAL;
+
+	return MODE_OK;
+}
+
 static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
 {
 	struct drm_device *drm = vc4_hdmi->connector.dev;
@@ -1656,6 +1694,14 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 
+	if (vc4_hdmi->variant->timings_valid) {
+		enum drm_mode_status status;
+
+		status = vc4_hdmi->variant->timings_valid(mode);
+		if (status != MODE_OK)
+			return status;
+	}
+
 	if (vc4_hdmi->variant->unsupported_odd_h_timings &&
 	    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
 	    ((mode->hdisplay % 2) || (mode->hsync_start % 2) ||
@@ -3233,6 +3279,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi0_variant = {
 	.csc_setup		= vc5_hdmi_csc_setup,
 	.reset			= vc5_hdmi_reset,
 	.set_timings		= vc5_hdmi_set_timings,
+	.timings_valid		= vc5_hdmi_timings_valid,
 	.phy_init		= vc5_hdmi_phy_init,
 	.phy_disable		= vc5_hdmi_phy_disable,
 	.phy_rng_enable		= vc5_hdmi_phy_rng_enable,
@@ -3261,6 +3308,7 @@ static const struct vc4_hdmi_variant bcm2711_hdmi1_variant = {
 	.csc_setup		= vc5_hdmi_csc_setup,
 	.reset			= vc5_hdmi_reset,
 	.set_timings		= vc5_hdmi_set_timings,
+	.timings_valid		= vc5_hdmi_timings_valid,
 	.phy_init		= vc5_hdmi_phy_init,
 	.phy_disable		= vc5_hdmi_phy_disable,
 	.phy_rng_enable		= vc5_hdmi_phy_rng_enable,
@@ -3289,6 +3337,7 @@ static const struct vc4_hdmi_variant bcm2712_hdmi0_variant = {
 	.csc_setup		= vc5_hdmi_csc_setup,
 	.reset			= vc5_hdmi_reset,
 	.set_timings		= vc5_hdmi_set_timings,
+	.timings_valid		= vc5_hdmi_timings_valid,
 	.phy_init		= vc6_hdmi_phy_init,
 	.phy_disable		= vc6_hdmi_phy_disable,
 	.channel_map		= vc5_hdmi_channel_map,
@@ -3315,6 +3364,7 @@ static const struct vc4_hdmi_variant bcm2712_hdmi1_variant = {
 	.csc_setup		= vc5_hdmi_csc_setup,
 	.reset			= vc5_hdmi_reset,
 	.set_timings		= vc5_hdmi_set_timings,
+	.timings_valid		= vc5_hdmi_timings_valid,
 	.phy_init		= vc6_hdmi_phy_init,
 	.phy_disable		= vc6_hdmi_phy_disable,
 	.channel_map		= vc5_hdmi_channel_map,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index b1f41d5..397ebaf 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -71,6 +71,12 @@ struct vc4_hdmi_variant {
 			    struct drm_connector_state *state,
 			    const struct drm_display_mode *mode);
 
+	/*
+	 * Callback to check that the video timings of a mode fit in the
+	 * timing registers of the HDMI block. Optional.
+	 */
+	enum drm_mode_status (*timings_valid)(const struct drm_display_mode *mode);
+
 	/* Callback to initialize the PHY according to the connector state */
 	void (*phy_init)(struct vc4_hdmi *vc4_hdmi,
 			 struct drm_connector_state *conn_state);
-- 
2.51.1.windows.1

