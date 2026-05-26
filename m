Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A0DCD5BD5
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 22:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED2810E54E;
	Tue, 26 May 2026 22:33:35 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA1310E54E
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 22:33:34 +0000 (UTC)
Received: from abreu (ip5f5af0d1.dynamic.kabel-deutschland.de [95.90.240.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6A3B84C2C37F04;
 Wed, 27 May 2026 00:33:08 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/probe-helper: Honour connector->force in
 drm_helper_probe_detect()
Date: Wed, 27 May 2026 00:32:03 +0200
Message-ID: <20260526223203.42982-2-pmenzel@molgen.mpg.de>
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

With `video=DP-2:d drm.debug=0x04` the connectors are correctly forced off
at init time:

    [9.742468] [drm] forcing DP-2 connector off

but intel_dp_detect() is still called immediately after:

    [9.908738] [drm:intel_dp_detect] [CONNECTOR:130:DP-2]
    [9.912982] [drm:intel_hotplug_detect_connector] [CONNECTOR:130:DP-2] status updated from unknown to unknown (epoch counter 0->1)

drm_helper_probe_single_connector_modes() already short-circuits when
connector->force is set, returning the forced status without calling any
detect callbacks.  drm_helper_probe_detect() however has no such guard, so
callers that go through it directly – such as i915’s
intel_hotplug_detect_connector() – still run the full hardware probe (AUX
DPCD read, GMBus DDC transaction, ...) even when the user has forced a
connector off via the `video=` command-line parameter.

Add the same connector->force check for forced off connectors at the top of
drm_helper_probe_detect(), so that the hardware probe is skipped regardless
of the entry point.  This makes video=<connector>:d effective at boot time,
not just for userspace GETCONNECTOR ioctls.

DRM_FORCE_ON and DRM_FORCE_ON_DIGITAL are intentionally not short-
circuited here: for those cases the detect callback must still run to
initialise sink capabilities such as DPCD link rate and lane count.

Tested on a Dell XPS 13 9360 (Intel Kaby Lake-U GT2 [HD Graphics 620]
[8086:5916]). With `video=DP-2:d drm.debug=0x04, Linux logs:

    [   11.701243] [drm] forcing DP-2 connector off
    [...]
    [   12.102009] i915 0000:00:02.0: [drm:drm_helper_probe_detect [drm_kms_helper]] [CONNECTOR:130:DP-2] forced off, skipping detect

v2: Do not return early for DRM_FORCE_ON and DRM_FORCE_ON_DIGITAL (Jani,
gemini/gemini-3.1-pro-preview)

v3: Correct if condition

Assisted-by: Claude Sonnet 4.6
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/drm_probe_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index d4dc8cb45bce..1e15cb42d50b 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -401,6 +401,12 @@ drm_helper_probe_detect(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	int ret;
 
+	if (connector->force == DRM_FORCE_OFF) {
+		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] forced off, skipping detect\n",
+			    connector->base.id, connector->name);
+		return connector_status_disconnected;
+	}
+
 	if (!ctx)
 		return drm_helper_probe_detect_ctx(connector, force);
 
-- 
2.53.0

