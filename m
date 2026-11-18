Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309E606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ca7enL61
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FFF10FFAE;
	Wed, 18 Nov 2026 19:16:02 +0000 (UTC)
Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA1110FFA4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 19:15:45 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=fmcXfnQxb0qtqIl21TRZlE6o9ga9GKgYl2RPp4Wr9Aw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795029343; v=1; x=1795634143;
 b=Ca7enL613jQBDwC9oQyOIGSyAqMAE6wuFXL9oJ7zbFgab2j+GwegYyGJeiCTQNUXgb3qaF/4
 FF+CD8cAo7Z3qCSbfAlWlw/fkQd3cKsFiJejhMDcePLPAH3Edk407M7uDAbbe+OFLSRjkoeM84x
 sX2fa6UkiRhf13RvA0Pxt6Eo=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id d39edd8d2b425d4b;
 Wed, 18 Nov 2026 19:15:43 +0000
X-Mizu-Trace-ID: d39edd8d2b425d4b
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: uma.shankar@intel.com, chaitanya.kumar.borah@intel.com,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Suraj Kandpal <suraj.kandpal@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] drm/i915/color: load the 3D LUT in the order the
 hardware indexes it
Date: Wed, 18 Nov 2026 11:15:13 -0800
Message-ID: <20261118191514.2931270-3-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118191514.2931270-1-matthew.schwartz@linux.dev>
References: <20261118191514.2931270-1-matthew.schwartz@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 3D LUT colorop blob is laid out with red as the fastest axis,
index = R + n * (G + n * B). glk_load_lut_3d() writes the blob to
LUT_3D_DATA front to back, but the hardware walks its table with blue as
the fastest axis and red as the slowest. Every entry whose red and blue
coordinates differ lands at the node with the two exchanged.

Measured on Lunar Lake by programming the pipe-bound LUT through
LUT_3D_INDEX and LUT_3D_DATA directly and decoding the pipe CRC of solid
color frames. A table holding each node's own stream position reads back
position B + 17 * G + 289 * R, and an identity table written in that
order reproduces all of 70 sampled colors exactly.

Write the table in hardware order.

Fixes: 65db7a1f9cf7 ("drm/i915/color: Add 3D LUT to color pipeline")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/gpu/drm/i915/display/intel_color.c     | 18 +++++++++++++++---
 drivers/gpu/drm/i915/display/intel_color.h     |  2 ++
 .../drm/i915/display/intel_color_pipeline.c    |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 742ae471540d..ea4e6c9f0309 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -4112,8 +4112,8 @@ static void glk_load_lut_3d(struct intel_dsb *dsb,
 {
 	struct intel_display *display = to_intel_display(crtc->base.dev);
 	const struct drm_color_lut32 *lut = blob->data;
-	int i, lut_size = drm_color_lut32_size(blob);
 	enum pipe pipe = crtc->pipe;
+	int r, g, b;
 
 	if (!dsb && intel_de_read(display, LUT_3D_CTL(pipe)) & LUT_3D_READY) {
 		drm_err(display->drm, "[CRTC:%d:%s] 3D LUT not ready, not loading LUTs\n",
@@ -4121,9 +4121,21 @@ static void glk_load_lut_3d(struct intel_dsb *dsb,
 		return;
 	}
 
+	/*
+	 * The hardware walks the table with blue as the fastest axis, the
+	 * colorop blob with red.
+	 */
 	intel_de_write_dsb(display, dsb, LUT_3D_INDEX(pipe), LUT_3D_AUTO_INCREMENT);
-	for (i = 0; i < lut_size; i++)
-		intel_de_write_dsb(display, dsb, LUT_3D_DATA(pipe), glk_3dlut_10(&lut[i]));
+	for (r = 0; r < LUT_3D_SIZE; r++) {
+		for (g = 0; g < LUT_3D_SIZE; g++) {
+			for (b = 0; b < LUT_3D_SIZE; b++) {
+				int i = r + LUT_3D_SIZE * (g + LUT_3D_SIZE * b);
+
+				intel_de_write_dsb(display, dsb, LUT_3D_DATA(pipe),
+						   glk_3dlut_10(&lut[i]));
+			}
+		}
+	}
 	intel_de_write_dsb(display, dsb, LUT_3D_INDEX(pipe), 0);
 }
 
diff --git a/drivers/gpu/drm/i915/display/intel_color.h b/drivers/gpu/drm/i915/display/intel_color.h
index 9d11741423ef..02ef30390558 100644
--- a/drivers/gpu/drm/i915/display/intel_color.h
+++ b/drivers/gpu/drm/i915/display/intel_color.h
@@ -18,6 +18,8 @@ struct drm_property_blob;
 enum pipe;
 enum plane_id;
 
+#define LUT_3D_SIZE 17
+
 void intel_color_init_hooks(struct intel_display *display);
 int intel_color_init(struct intel_display *display);
 void intel_color_crtc_init(struct intel_crtc *crtc);
diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 77f65182e3e3..0c73072819fb 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -88,7 +88,7 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 		break;
 	case INTEL_PLANE_CB_3DLUT:
 		ret = drm_plane_colorop_3dlut_init(dev, &colorop->base, plane,
-						   &intel_colorop_funcs, 17,
+						   &intel_colorop_funcs, LUT_3D_SIZE,
 						   DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
 						   true);
 		break;
-- 
2.56.1

