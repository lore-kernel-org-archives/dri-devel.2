Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05052606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDVj9iRd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0A6112A08;
	Fri, 20 Nov 2026 12:58:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2C11129F2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:57:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA85460E12;
 Fri, 20 Nov 2026 12:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2601F000C0;
 Fri, 20 Nov 2026 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179442;
 bh=dKXVMckNemj8P578XSHmli1vccAYVwrj0jHEBCLIVxU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mDVj9iRdbARL9+EI9piz9BBt1WXtnuI1y0PQ9BJZhPJ/wZ+brugVa9laJygAsCG2b
 cTDpM06hEnR4Om9PNsCJlFKj50SsbT4eCpVG4/icnp3I2+sx345z6t7Rn9jLAwS+Ea
 2/cbCszrWqHOzKCVq7QXSwzLwf9WEiuMy6HuMHUSELkA0FK1ARbuZV54NiIdtKvg/O
 sJDDZVi9/YQ85pwFjxja9SHG7D3lA+ZSUeymr8v+9QnYRys7cKeAzQmU4iFXE5LrH2
 14Ffz31VEh99y1QNisam9B/G/Kcz+nsWGgjDlt+6M4ceWd8YpNTd11te9OQ/fHMgx1
 EjWWZ63BoTLSQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:27 +0100
Subject: [PATCH v9 35/42] drm/tidss: plane: Implement hardware state
 readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-35-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9658; i=mripard@kernel.org;
 h=from:subject:message-id; bh=x2z9SqhbECHER4k4/cyS033AIJp78YHMaoYzefWV6Iw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzkYPmdW27338+cEBF7mNUX/2/JrgLXZG1fup1UqNu
 d4Ld3lpdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJNP5lbHhxdhVHKEexgqJO
 QkjdvdT7ddMPpwkkdwZLGR5gfWS26ouUb/j6uxvK1+5qYgz5Fn1oP2PD9joBYatEYV/9Q7vtdqa
 ybc6Wbnq8eM4fwwkLz79aVh3z4AfnwTwbh/zrC5devTgrmY8TAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the firmware leaves a video port running, the planes feeding it
have to be read out too, otherwise the first commit sees them as
disabled and has to reprogram the whole pipeline.

Implement the atomic_sro_readout_state hook for the tidss planes. A
plane is read out as disabled if its VID pipeline isn't enabled, if
it isn't routed to an overlay layer, or if its CRTC is inactive. The
latter two matter because tidss_crtc_atomic_disable() and a disabled
video port leave the VID pipeline of their planes enabled.

Otherwise, the CRTC, source and destination rectangles, zpos, alpha and
blend mode are read from the registers. The zpos is the index of the
overlay layer the plane is routed to, which is the normalized zpos it
was committed with. The alpha is the 8-bit global alpha replicated in
both bytes of the 16-bit property, the only inverse that maps full
opacity back to 0xffff.

The framebuffer is reconstructed from the format, picture size and
increments. It has no GEM object since the firmware allocated the
buffer, which drm_gem_plane_helper_prepare_fb() and
drm_fb_dma_get_scanout_buffer() cope with. It can only be rebuilt when
the planes aren't YUV, aren't multiplanar and don't use horizontal
decimation, and the readout fails otherwise so that the core falls back
to the regular initialization. The offset into the buffer, and thus the
source origin, isn't recovered yet.

Use drm_atomic_helper_plane_compare_state() to compare the readout
state with the committed one.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_plane.c | 224 ++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index b0d5d6959b88..88f415b5439f 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -4,16 +4,19 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_panic_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_dispc.h"
 #include "tidss_drv.h"
@@ -174,15 +177,236 @@ static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
 	.atomic_enable = tidss_plane_atomic_enable,
 	.atomic_disable = tidss_plane_atomic_disable,
 	.get_scanout_buffer = drm_fb_dma_get_scanout_buffer,
 };
 
+static const struct drm_framebuffer_funcs tidss_plane_readout_fb_funcs = {
+	.destroy	= drm_gem_fb_destroy,
+};
+
+static struct drm_framebuffer *tidss_plane_readout_fb(struct drm_plane *plane)
+{
+	struct drm_device *ddev = plane->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	const struct drm_format_info *info;
+	struct drm_framebuffer *fb;
+	int ret;
+
+	fb = kzalloc_obj(*fb);
+	if (!fb)
+		return ERR_PTR(-ENOMEM);
+
+	fb->dev = plane->dev;
+
+	info = dispc_plane_get_current_format(dispc, tplane->hw_plane_id);
+	if (IS_ERR(info)) {
+		ret = PTR_ERR(info);
+		goto err_free_fb;
+	}
+
+	// TODO: Figure out YUV and multiplanar formats, along with
+	// the color encoding and range
+	if (info->is_yuv) {
+		ret = -EINVAL;
+		goto err_free_fb;
+	}
+
+	fb->format = info;
+
+	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &fb->width,
+				     &fb->height);
+
+	/*
+	 * A pixel increment of 1 means that the DMA engine fetches every
+	 * pixel of the source buffer. Any other value means that
+	 * horizontal decimation is enabled, and the buffer geometry
+	 * cannot be reconstructed from the registers.
+	 */
+	if (dispc_plane_get_pixel_inc(dispc, tplane->hw_plane_id) != 1) {
+		ret = -EINVAL;
+		goto err_free_fb;
+	}
+
+	/*
+	 * The row increment register holds the extra bytes between the
+	 * end of a row of the picture and the beginning of the next one,
+	 * which includes any padding the firmware might have programmed.
+	 */
+	fb->pitches[0] = fb->width * (drm_format_info_bpp(info, 0) / 8) +
+			 dispc_plane_get_row_inc(dispc, tplane->hw_plane_id) - 1;
+
+	/*
+	 * TODO: The DMA base address has the offsets baked in, and there
+	 * is no backing buffer to recover them from.
+	 */
+	fb->offsets[0] = 0;
+
+	ret = drm_framebuffer_init(plane->dev, fb, &tidss_plane_readout_fb_funcs);
+	if (ret) {
+		kfree(fb);
+		return ERR_PTR(ret);
+	}
+
+	return fb;
+
+err_free_fb:
+	kfree(fb);
+	return ERR_PTR(ret);
+}
+
+static struct drm_crtc *tidss_plane_readout_crtc(struct drm_plane *plane,
+						 int *crtc_x, int *crtc_y,
+						 u32 *normalized_zpos)
+{
+	struct drm_device *dev = plane->dev;
+	struct tidss_device *tidss = to_tidss(dev);
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	struct drm_crtc *crtc;
+	u32 hw_videoport, layer;
+	int ret;
+
+	ret = dispc_ovr_get_plane(tidss->dispc, tplane->hw_plane_id,
+				  &hw_videoport, crtc_x, crtc_y, &layer);
+	if (ret)
+		return ERR_PTR(ret);
+
+	*normalized_zpos = layer;
+
+	drm_for_each_crtc(crtc, dev) {
+		if (to_tidss_crtc(crtc)->hw_videoport == hw_videoport)
+			return crtc;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int tidss_plane_atomic_readout_state(struct drm_plane *plane,
+					    struct drm_atomic_sro_state *state,
+					    struct drm_plane_state *plane_state)
+{
+	struct drm_device *ddev = plane->dev;
+	struct tidss_device *tidss = to_tidss(ddev);
+	struct dispc_device *dispc = tidss->dispc;
+	struct tidss_plane *tplane = to_tidss_plane(plane);
+	struct drm_crtc_state *crtc_state;
+	struct drm_framebuffer *fb;
+	struct drm_crtc *crtc;
+	unsigned int in_w, in_h;
+	int crtc_x, crtc_y;
+	u32 normalized_zpos;
+	int ret;
+
+	ret = tidss_runtime_get(tidss);
+	if (ret < 0)
+		return ret;
+
+	if (!dispc_plane_is_enabled(dispc, tplane->hw_plane_id))
+		goto out;
+
+	crtc = tidss_plane_readout_crtc(plane, &crtc_x, &crtc_y,
+					&normalized_zpos);
+	if (IS_ERR(crtc)) {
+		ret = PTR_ERR(crtc);
+
+		/*
+		 * tidss_crtc_atomic_disable() disables the overlay layers of
+		 * the video port, but the planes on a CRTC being disabled
+		 * aren't disabled in the VID pipeline. A plane that isn't
+		 * routed to any layer is thus disabled.
+		 */
+		if (ret == -ENODEV)
+			goto out;
+
+		goto err_runtime_pm;
+	}
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state) {
+		ret = -ENODEV;
+		goto err_runtime_pm;
+	}
+
+	/*
+	 * K2G has no overlay manager to tell us whether the plane is
+	 * routed, and the planes of a disabled video port are left
+	 * enabled: a plane on an inactive CRTC isn't scanned out.
+	 */
+	if (!crtc_state->active)
+		goto out;
+
+	fb = tidss_plane_readout_fb(plane);
+	if (IS_ERR(fb)) {
+		ret = PTR_ERR(fb);
+		goto err_runtime_pm;
+	}
+
+	plane_state->fb = fb;
+	plane_state->crtc = crtc;
+	plane_state->visible = true;
+
+	dispc_plane_get_picture_size(dispc, tplane->hw_plane_id, &in_w, &in_h);
+	plane_state->src_w = in_w << 16;
+	plane_state->src_h = in_h << 16;
+
+	dispc_plane_get_size(dispc, tplane->hw_plane_id, &plane_state->crtc_w,
+			     &plane_state->crtc_h);
+
+	plane_state->crtc_x = crtc_x;
+	plane_state->crtc_y = crtc_y;
+
+	/*
+	 * The overlay layer index a plane is routed to is its
+	 * normalized zpos, as that is what the atomic update uses as
+	 * the layer index. The raw zpos property userspace set
+	 * cannot be recovered from the hardware.
+	 */
+	plane_state->normalized_zpos = normalized_zpos;
+	plane_state->zpos = normalized_zpos;
+
+	// TODO: Handle src_x/src_y, see DISPC_VID_BA_0
+
+	plane_state->src.x1 = 0;
+	plane_state->src.x2 = plane_state->src_w;
+	plane_state->src.y1 = 0;
+	plane_state->src.y2 = plane_state->src_h;
+	plane_state->dst.x1 = crtc_x;
+	plane_state->dst.x2 = crtc_x + plane_state->crtc_w;
+	plane_state->dst.y1 = crtc_y;
+	plane_state->dst.y2 = crtc_y + plane_state->crtc_h;
+
+	/*
+	 * The global alpha register is 8 bits wide and is programmed
+	 * from the high byte of the 16 bits alpha property.
+	 * Replicating the byte is the only inverse that preserves the
+	 * fraction of full opacity (0x00 -> 0x0000, 0xff -> 0xffff)
+	 * and round-trips through a program-then-readout cycle.
+	 */
+	plane_state->alpha =
+		dispc_plane_get_global_alpha(dispc, tplane->hw_plane_id) * 0x0101;
+	plane_state->pixel_blend_mode =
+		dispc_plane_get_blend_mode(dispc, tplane->hw_plane_id);
+
+	crtc_state->plane_mask |= drm_plane_mask(plane);
+
+out:
+	tidss_runtime_put(tidss);
+	return 0;
+
+err_runtime_pm:
+	tidss_runtime_put(tidss);
+	return ret;
+}
+
 static const struct drm_plane_funcs tidss_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_destroy,
 	.atomic_create_state = drm_atomic_helper_plane_create_state,
+	.atomic_sro_readout_state = tidss_plane_atomic_readout_state,
+	.atomic_sro_compare_state = drm_atomic_helper_plane_compare_state,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 	DRM_PANIC_PLANE_FUNCS,
 };
 

-- 
2.56.1

