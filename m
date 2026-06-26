Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC2C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E4BE10E391;
	Fri, 26 Jun 2026 14:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nfraprado@collabora.com header.b="gjuVN2pA";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A0410E391;
 Fri, 26 Jun 2026 14:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782483606; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=amMJ57mcMYX52UjAj+HszuIE2Wpn6141jOUIQiNz6hWeEZHyTUZACdnt1b2kqzs1GQS8mJ9uIZMYA5vM7iWVR+iovc3YnKxzeWgKcECk7pHpSa+mlpWtaQ+v6j1MZmlxfpPKG3jSdZacMB+Mb4GCY/Su73MJPDWHBpOD0XhqHOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782483606;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cQyjiVRTcXnC6EW1WnK2c+p4P+ZHsMUWyzuRTT8Dx98=; 
 b=YF+ruGfeObIm2RzRLnhhKl9Eal3cDF0dRad497sqPARzXVoYEPfihlbhGiq/LM4HtQgjAlZPcQ0AFvyZXe6at0t9n0EcptHbNKwS3cGe2Wp1LC56QyLic+jbGPw91Z+ctvbRLsvZi8P+qYgMsMOrMLIEz2UnApXedeTcyt/qDPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nfraprado@collabora.com;
 dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782483606; 
 s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=cQyjiVRTcXnC6EW1WnK2c+p4P+ZHsMUWyzuRTT8Dx98=;
 b=gjuVN2pAzQSyvU1/0pyfP3dLYWgXBEcA8X/m9z1jTh9S3okyDwG8gf3EFsjQxMLj
 6g5VpyeKOeAF8ccF3wir1WYDcWKRAjBLRBRWWJ66NPJbNY4t565z09N5dTomFZRN5Nw
 nfOZKEBNPdM1SfLlvzHHKuikJ/ttlcsVhsx6Owio=
Received: by mx.zohomail.com with SMTPS id 1782483604203501.78261578975673;
 Fri, 26 Jun 2026 07:20:04 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 26 Jun 2026 10:18:06 -0400
Subject: [PATCH] drm/amd/display: Always notify the HDA driver on connector
 disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-amdgpu-dm-always-eld-notify-on-disconnect-v1-1-40ce473cd724@collabora.com>
X-B4-Tracking: v=1; b=H4sIAB2KPmoC/x3NywqEMAxA0V+RrCegBTuPXxlmUZrUCWgqjfMQ8
 d8tLs/m3g2Mi7DBo9mg8FdMslZ0lwbiO+jAKFQNrnW+9a7HMNEwf5AmDOMvrIY8EmpeJK2YFUk
 sZlWOC977jv01Bb4xQe3NhZP8z9fzte8HAUqwbHsAAAA=
X-Change-ID: 20260625-amdgpu-dm-always-eld-notify-on-disconnect-951e67fae8ed
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
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

amdgpu_dm_audio_eld_notify() is currently only called in atomic commits.
This results in the state of the HDA driver never getting updated when
an audio sink is removed and an atomic commit never comes. (eg the HDMI
audio jack switch in ALSA stays 'on' after the HDMI cable is
disconnected if no other display is connected to cause the compositor to
submit an atomic commit)

Call amdgpu_dm_audio_eld_notify() in
amdgpu_dm_update_connector_after_detect() when a sink is no longer
available to ensure that the HDA driver always gets notified on
disconnect regardless of atomic commits.

Assisted-by: Copilot:claude-sonnet-4.6
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c     | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h     | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 13c9a9d145ba..c9da19335eac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -168,7 +168,7 @@ void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_audio_fini);
 
-STATIC_IFN_KUNIT void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
+void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 {
 	struct drm_audio_component *acomp = adev->dm.audio_component;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
index 7acfc5ef69b3..d0361fd95f60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
@@ -40,6 +40,7 @@ void amdgpu_dm_commit_audio(struct drm_device *dev,
 void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
 		     const struct drm_connector *drm_connector,
 		     const struct dc_sink *dc_sink);
+void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 struct device;
@@ -48,7 +49,6 @@ int amdgpu_dm_audio_component_bind(struct device *kdev,
 				   struct device *hda_kdev, void *data);
 void amdgpu_dm_audio_component_unbind(struct device *kdev,
 				      struct device *hda_kdev, void *data);
-void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin);
 int amdgpu_dm_audio_get_param(void);
 void amdgpu_dm_audio_set_param(int val);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 300ee26f26ff..9286f86a20cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -464,6 +464,8 @@ void amdgpu_dm_update_connector_after_detect(
 	struct drm_connector *connector = &aconnector->base;
 	struct dc_sink *sink __free(sink_release) = NULL;
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int inst;
 
 	/* MST handled by drm_mst framework */
 	if (aconnector->mst_mgr.mst_state == true)
@@ -601,6 +603,13 @@ void amdgpu_dm_update_connector_after_detect(
 		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again on hotplug */
 		if (connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
 			connector->state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
+
+		mutex_lock(&adev->dm.audio_lock);
+		inst = aconnector->audio_inst;
+		aconnector->audio_inst = -1;
+		mutex_unlock(&adev->dm.audio_lock);
+		if (inst != -1)
+			amdgpu_dm_audio_eld_notify(adev, inst);
 	}
 
 	update_subconnector_property(aconnector);

---
base-commit: 30ffa8de54e5cc80d93fd211ca134d1764a7011f
change-id: 20260625-amdgpu-dm-always-eld-notify-on-disconnect-951e67fae8ed

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>

