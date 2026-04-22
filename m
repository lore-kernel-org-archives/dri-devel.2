Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438A6FA1FE1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 18:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF9110E2CC;
	Wed, 22 Apr 2026 18:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NK1qTxyF";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626C510E0D9;
 Wed, 22 Apr 2026 18:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776882278; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dTNLwfr5AhcmBC6f6skqYCvDOmTe7opvTR4pIs3g9cgPumBbd2jy+fQVk/RblQE2xicox2wopb0/+kBuTNp4MX0fJUgzKHN3CP0Bj5p620aFmGj3SgorWbIaBxAvb5BtmFKDB+XXFp65Bk7ckJDsKsX3wxTXC0oBG6AoWdvoo7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776882278;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PHT6T41t2TqVIBPQsCMXPMGDztXJ0gS62OVUZXhxw9c=; 
 b=g0czw8wiUHyuio0SMyKkAU8co0wzV8wP717JB3CGPs5JMhyP8U7Bv/7Do7t7mZ0aQFqigUwA5Yj7X1cgaqKBByKE45h0hHjr0nj+JdL7ONr4b5RAT95VAHJb3yU5Gz00DC3o57yACuVjG1X4dzwpyFYAbq8mYGUBYRGjwAMMAZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776882278; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=PHT6T41t2TqVIBPQsCMXPMGDztXJ0gS62OVUZXhxw9c=;
 b=NK1qTxyFsT2XX3Z/0eSdJFHe+V6ds0yHGYlKbvbgR6FBYkmuZvGyvuL51hfYl/+J
 1o+P9aGSQBz7hCE8P1yObyYwcpg6CVFJkOJELOJ8K8wGL9lzXD/gCI6OPi1TM5rAQXP
 8aZmWm+hWx1FLkH7+WVhEk1p8BDmnJ7h9i1STIb8=
Received: by mx.zohomail.com with SMTPS id 1776882277358176.8374044602018;
 Wed, 22 Apr 2026 11:24:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 22 Apr 2026 20:24:08 +0200
Subject: [PATCH v9 2/2] drm: Send per-connector hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
In-Reply-To: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Daniel Stone <daniel.stone@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
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

Try to send per-connector hotplug events as often as possible, rather
than connector-less global hotplug events. This does result in more
hotplug events if multiple connectors changed at the same time, but
give userspace more actionable information.

Since the hotplug event needs to be sent outside of the mode_config
mutex to avoid a deadlock, the drm_client_dev_hotplug() call is split
off from the drm_sysfs_(connector_)?hotplug_event calls.

Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index d4dc8cb45bce..2daa4242ce7e 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -760,16 +760,12 @@ static void output_poll_execute(struct work_struct *work)
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	enum drm_connector_status old_status;
-	bool repoll = false, changed;
+	bool repoll = false, changed = false;
 	u64 old_epoch_counter;
 
 	if (!dev->mode_config.poll_enabled)
 		return;
 
-	/* Pick up any changes detected by the probe functions. */
-	changed = dev->mode_config.delayed_event;
-	dev->mode_config.delayed_event = false;
-
 	if (!drm_kms_helper_poll) {
 		if (dev->mode_config.poll_running) {
 			drm_kms_helper_disable_hpd(dev);
@@ -836,6 +832,7 @@ static void output_poll_execute(struct work_struct *work)
 				    connector->base.id, connector->name,
 				    old_epoch_counter, connector->epoch_counter);
 
+			drm_sysfs_connector_hotplug_event(connector);
 			changed = true;
 		}
 	}
@@ -844,8 +841,15 @@ static void output_poll_execute(struct work_struct *work)
 	mutex_unlock(&dev->mode_config.mutex);
 
 out:
+	/* Pick up any changes detected by the probe functions. */
+	if (dev->mode_config.delayed_event) {
+		dev->mode_config.delayed_event = false;
+		changed = true;
+		drm_sysfs_hotplug_event(dev);
+	}
+
 	if (changed)
-		drm_kms_helper_hotplug_event(dev);
+		drm_client_dev_hotplug(dev);
 
 	if (repoll)
 		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
@@ -1081,9 +1085,9 @@ EXPORT_SYMBOL(drm_connector_helper_hpd_irq_event);
  */
 bool drm_helper_hpd_irq_event(struct drm_device *dev)
 {
-	struct drm_connector *connector, *first_changed_connector = NULL;
 	struct drm_connector_list_iter conn_iter;
-	int changed = 0;
+	struct drm_connector *connector;
+	bool changed = false;
 
 	if (!dev->mode_config.poll_enabled)
 		return false;
@@ -1096,24 +1100,15 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
 			continue;
 
 		if (check_connector_changed(connector)) {
-			if (!first_changed_connector) {
-				drm_connector_get(connector);
-				first_changed_connector = connector;
-			}
-
-			changed++;
+			changed = true;
+			drm_sysfs_connector_hotplug_event(connector);
 		}
 	}
 	drm_connector_list_iter_end(&conn_iter);
 	mutex_unlock(&dev->mode_config.mutex);
 
-	if (changed == 1)
-		drm_kms_helper_connector_hotplug_event(first_changed_connector);
-	else if (changed > 0)
-		drm_kms_helper_hotplug_event(dev);
-
-	if (first_changed_connector)
-		drm_connector_put(first_changed_connector);
+	if (changed)
+		drm_client_dev_hotplug(dev);
 
 	return changed;
 }

-- 
2.53.0

