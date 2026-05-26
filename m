Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F8ECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0E910E48A;
	Tue, 26 May 2026 16:20:01 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A3F10E48A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:19:59 +0000 (UTC)
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 801AD4C19741A2;
 Tue, 26 May 2026 18:19:35 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/audio: skip ELD query for force-off connectors
Date: Tue, 26 May 2026 18:19:24 +0200
Message-ID: <20260526161925.17041-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When a connector is forced off via the `video=` command-line parameter
(`video=<connector>:d`), `intel_audio_component_get_eld()` returns -EINVAL
for that port because `find_audio_state()` finds no active encoder.  The
audio driver interprets this as an error rather than a clean “no monitor
present” reply, and, on the Dell XPS 13 9360, at `drm.debug=0x04` the
repeated calls generate the log below:

    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port C
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port C
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port C
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D
    i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D

Add `intel_audio_connector_is_forced_off()` which scans the connector list
to check whether any connector on the given port has
`force == DRM_FORCE_OFF`. When the caller finds no audio state and the
port’s connector is forced off, report `*enabled = false` and return 0 so
the audio driver sees a clean “not connected” answer and stops querying
that port.

With `video=DP-2:d drm.debug=0x04` the unneeded calls are gone (port C):

    [   90.458772] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    [   90.459649] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    [   90.460547] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port B
    [   90.461581] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D
    [   90.462509] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D
    [   90.463385] i915 0000:00:02.0: [drm:intel_audio_component_get_eld [i915]] Not valid for port D

Assisted-by: Claude Sonnet 4.6
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/i915/display/intel_audio.c | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
index 081627e0d917..7864b9a485d5 100644
--- a/drivers/gpu/drm/i915/display/intel_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_audio.c
@@ -36,6 +36,7 @@
 #include "intel_cdclk.h"
 #include "intel_crtc.h"
 #include "intel_de.h"
+#include "intel_display.h"
 #include "intel_display_types.h"
 #include "intel_display_wa.h"
 #include "intel_lpe_audio.h"
@@ -1211,6 +1212,28 @@ static int intel_audio_component_sync_audio_rate(struct device *kdev, int port,
 	return err;
 }
 
+static bool intel_audio_connector_is_forced_off(struct intel_display *display,
+						int port)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct intel_connector *connector;
+	bool forced_off = false;
+
+	drm_connector_list_iter_begin(display->drm, &conn_iter);
+	for_each_intel_connector_iter(connector, &conn_iter) {
+		struct intel_encoder *encoder = intel_attached_encoder(connector);
+
+		if (encoder && encoder->port == port &&
+		    connector->base.force == DRM_FORCE_OFF) {
+			forced_off = true;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return forced_off;
+}
+
 static int intel_audio_component_get_eld(struct device *kdev, int port,
 					 int cpu_transcoder, bool *enabled,
 					 unsigned char *buf, int max_bytes)
@@ -1223,9 +1246,13 @@ static int intel_audio_component_get_eld(struct device *kdev, int port,
 
 	audio_state = find_audio_state(display, port, cpu_transcoder);
 	if (!audio_state) {
+		mutex_unlock(&display->audio.mutex);
+		if (intel_audio_connector_is_forced_off(display, port)) {
+			*enabled = false;
+			return 0;
+		}
 		drm_dbg_kms(display->drm, "Not valid for port %c\n",
 			    port_name(port));
-		mutex_unlock(&display->audio.mutex);
 		return -EINVAL;
 	}
 
-- 
2.53.0

