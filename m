Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30AECD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB65D10ED0E;
	Thu, 28 May 2026 07:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="dRe90rpu";
	dkim-atps=neutral
X-Greylist: delayed 394 seconds by postgrey-1.36 at gabe;
 Wed, 27 May 2026 09:00:34 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F3C10E674
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=px
 ZNWo9LRCPMIVUw+9c1ow02KTqS79PGb7Cne9zcVKA=; b=dRe90rpuxC7raE+xCm
 /+CorRR4fUlVbmBU/IEv+1h3wpYh+6QGxjWWYOx4aKSogilA/Q0ykCU4UAMhQXFq
 1OaUgMt+YMkeSVZJa4rxwwkFfCyUzs3fK+K7d3+sjxdbDMJhIrKTXUVXkzj2IqAu
 XQWEwWuuPt5tnqiiGSmAX7dvA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD315cLsRZqnSQMDw--.17642S2; 
 Wed, 27 May 2026 16:53:32 +0800 (CST)
From: wangdich9700@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 wangdich9700@163.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] drm/connector: add CRTC state change callback to HDMI audio
 helpers
Date: Wed, 27 May 2026 16:53:29 +0800
Message-Id: <20260527085329.124777-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD315cLsRZqnSQMDw--.17642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFy7AFW3ZFW5JFyUCFy8Krg_yoWxXr13pa
 9FyrZ3Kr4vq343CFn7AF1fGrs0kaykJFyUt34Ygw15C398Krn8Aa1kGFn5u3WDJr9xZ3W2
 yanIqw43Aa4vkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKjgshUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbC5wyP3moWsQxk5AAA37
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:17 +0000
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

From: wangdicheng <wangdicheng@kylinos.cn>

The DRM HDMI audio helper framework notifies the audio codec about
physical connection changes via drm_connector_hdmi_audio_plugged_notify(),
but has no mechanism to notify when the CRTC state changes while the
connector remains physically connected.

This is a real problem on platforms with DP/HDMI audio. When a CRTC is
disabled while the sink remains connected (e.g. user switches to
"internal display only" mode but still wants audio from the external
monitor), the audio path silently breaks because:

1. The video stream is disabled, so there are no blanking intervals
   for audio Secondary Data Packets (SDP) to be transported.

2. The audio codec still believes the jack is present because
   plugged_notify() was not called (the connector is still physically
   connected).

3. Userspace (PulseAudio/PipeWire) continues routing audio to the
   external display, but no sound is actually output.

Without a framework-level notification, vendors who need to support
"audio output to external display while CRTC is inactive" are forced
to scatter condition checks across CRTC disable, encoder disable,
suspend, and resume paths. This pattern is fragile: any change in
the display pipeline can break the audio path, and the same condition
("connector connected but CRTC inactive, and audio is in use") must
be duplicated in multiple locations.

The root cause is architectural: the audio codec has no visibility
into CRTC state changes, so there is no clean way to implement
policies like:

- Mute audio output when CRTC is disabled (instead of silent breakage)
- Keep the video stream alive for audio transport
- Switch to DP Audio Only mode (hardware-supported on some platforms,
  e.g. Intel TRANS_DP_AUDIO_ONLY, but never used in i915 driver)

The HDA HDMI silent stream / KAE mechanism partially addresses this on
Intel platforms, but it operates only on the audio codec side and does
not coordinate with the DRM side. It also cannot work on platforms
without HDA codec support (e.g. ASoC-based designs).

Add an optional callback crtc_state_change() to
drm_connector_hdmi_audio_funcs, and a corresponding notification
function drm_connector_hdmi_audio_crtc_notify(). DRM drivers should
call this when the CRTC state changes on a connector with audio
capability, allowing audio codec implementations to react to display
pipeline state changes rather than only physical connection changes.

This provides a framework-level mechanism to implement "audio without
active display" policies cleanly, instead of scattering condition
checks across the display pipeline.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 .../gpu/drm/display/drm_hdmi_audio_helper.c   | 23 +++++++++++++++++++
 include/drm/display/drm_hdmi_audio_helper.h   |  2 ++
 include/drm/drm_connector.h                   | 16 +++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
index 7d78b02c1446..3437be6ee989 100644
--- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
@@ -128,6 +128,29 @@ void drm_connector_hdmi_audio_plugged_notify(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
 
+/**
+ * drm_connector_hdmi_audio_crtc_notify - Notify the audio codec of CRTC state change
+ * @connector: A pointer to the connector
+ * @crtc_active: true if the CRTC is now active, false if disabled
+ *
+ * Notify the HDMI audio codec that the CRTC state has changed on this
+ * connector. This should be called by DRM drivers when a CRTC is
+ * enabled or disabled on a connector that has audio capability, even
+ * if the connector remains physically connected.
+ *
+ * Unlike drm_connector_hdmi_audio_plugged_notify() which signals
+ * physical connection changes, this function signals display pipeline
+ * state changes that affect the audio transport path.
+ */
+void drm_connector_hdmi_audio_crtc_notify(struct drm_connector *connector,
+					  bool crtc_active)
+{
+	if (connector->hdmi_audio.funcs->crtc_state_change)
+		connector->hdmi_audio.funcs->crtc_state_change(connector,
+							       crtc_active);
+}
+EXPORT_SYMBOL(drm_connector_hdmi_audio_crtc_notify);
+
 static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
 	.audio_startup = drm_connector_hdmi_audio_startup,
 	.prepare = drm_connector_hdmi_audio_prepare,
diff --git a/include/drm/display/drm_hdmi_audio_helper.h b/include/drm/display/drm_hdmi_audio_helper.h
index 44d910bdc72d..6b6672ae73cf 100644
--- a/include/drm/display/drm_hdmi_audio_helper.h
+++ b/include/drm/display/drm_hdmi_audio_helper.h
@@ -19,5 +19,7 @@ int drm_connector_hdmi_audio_init(struct drm_connector *connector,
 				  int sound_dai_port);
 void drm_connector_hdmi_audio_plugged_notify(struct drm_connector *connector,
 					     bool plugged);
+void drm_connector_hdmi_audio_crtc_notify(struct drm_connector *connector,
+					  bool crtc_active);
 
 #endif
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae207..54aa15d0ef45 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1256,6 +1256,22 @@ struct drm_connector_hdmi_audio_funcs {
 	 */
 	int (*mute_stream)(struct drm_connector *connector,
 			   bool enable, int direction);
+
+	/**
+	 * @crtc_state_change:
+	 *
+	 * Notify the audio codec that the CRTC state has changed on this
+	 * connector. Called when a CRTC is enabled or disabled while the
+	 * connector remains physically connected. This is important for
+	 * DP/HDMI audio because audio transport depends on the video
+	 * stream's blanking intervals. The @crtc_state_change callback
+	 * is optional.
+	 *
+	 * @connector: the connector whose CRTC state changed
+	 * @crtc_active: true if the CRTC is now active, false if disabled
+	 */
+	void (*crtc_state_change)(struct drm_connector *connector,
+				  bool crtc_active);
 };
 
 void drm_connector_cec_phys_addr_invalidate(struct drm_connector *connector);
-- 
2.25.1

