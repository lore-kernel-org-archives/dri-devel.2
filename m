Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767A2F9EDC5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4530910E9E9;
	Wed, 22 Apr 2026 12:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CP40XUx7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C295610E9E2;
 Wed, 22 Apr 2026 12:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776861363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ErCs+MbgrTZZb+tXO8mBt5/vLSDq+7Ty0aoV94LXOb2jAoVMTEpp1hIuftB52CFqd5dSdHW2BPxNHdPlx/Guppunl0bP7RGB7CQdpo9QaxmILj5fxuiEAxkm/XRg2/1KejFd0Aj5z8I9UD6mdrC+Bmu2hUVMqBDakeldaf5u5Sw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776861363;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Oom1DKVQqo8VlxUkPHegZ7GCL71D6HX629O2qxbqAwo=; 
 b=LUXCtUX+Wbt1ZUUAWES7UE9CBxk8I/xuAJZja4gwWxvUfDmfgvPVP6uiOkiK7Q4nfBuimKP5a4ZHq2FZSq32l9OYhJGmsL77NEuELFB0uabkAa+W8HqwXDhan5+hg9FzD177I4rTirIdeaQ6ebj2pjRWDzDaBIgdDY2Ok9ecUTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776861363; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Oom1DKVQqo8VlxUkPHegZ7GCL71D6HX629O2qxbqAwo=;
 b=CP40XUx7TkT+vP2/Jo2A2P2qsmhC8D0/NWF7kfvuB1Ut8G8iJ+kQRUykFW4ZsAGi
 eZYn/cSeidz8C4trtSYo5dughh2dYC9vgPq+pJVYzzWu97UFqUzj8qPyjuadX0H8Udc
 oKbl3zhw1T6QLOt8wK4SL+c495CrRljPxFHpEKNU=
Received: by mx.zohomail.com with SMTPS id 1776861362560154.676040955713;
 Wed, 22 Apr 2026 05:36:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 22 Apr 2026 14:35:32 +0200
Subject: [PATCH v8 2/2] drm: Send per-connector hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-hot-plug-passup-v8-2-5cfae6ba4119@collabora.com>
References: <20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com>
In-Reply-To: <20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com>
To: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Daniel Stone <daniel.stone@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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
mutex to avoid a deadlock, pointers to all the changed connectors are
stored in a newly allocated array.

The "changed" boolean in output_poll_execute now only serves to signal
that a non-connector-specific hotplug event needs to be sent from a
prior event that was delayed. So, rename it from "changed" to
"delayed_hp" to avoid any confusion.

Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 68 ++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index d4dc8cb45bce..3beed8aa32fe 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -757,17 +757,19 @@ static void output_poll_execute(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
 	struct drm_device *dev = container_of(delayed_work, struct drm_device, mode_config.output_poll_work);
+	struct drm_connector **changed_conns;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	enum drm_connector_status old_status;
-	bool repoll = false, changed;
+	unsigned int num_changed = 0, i;
+	bool repoll = false, delayed_hp;
 	u64 old_epoch_counter;
 
 	if (!dev->mode_config.poll_enabled)
 		return;
 
 	/* Pick up any changes detected by the probe functions. */
-	changed = dev->mode_config.delayed_event;
+	delayed_hp = dev->mode_config.delayed_event;
 	dev->mode_config.delayed_event = false;
 
 	if (!drm_kms_helper_poll) {
@@ -783,6 +785,13 @@ static void output_poll_execute(struct work_struct *work)
 		goto out;
 	}
 
+	changed_conns = kmalloc_array(dev->mode_config.num_connector,
+				sizeof(*changed_conns), GFP_KERNEL);
+	if (!changed_conns) {
+		repoll = true;
+		goto out;
+	}
+
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
 		/* Ignore forced connectors. */
@@ -836,15 +845,23 @@ static void output_poll_execute(struct work_struct *work)
 				    connector->base.id, connector->name,
 				    old_epoch_counter, connector->epoch_counter);
 
-			changed = true;
+			drm_connector_get(connector);
+			changed_conns[num_changed++] = connector;
 		}
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
 	mutex_unlock(&dev->mode_config.mutex);
 
+	for (i = 0; i < num_changed; i++) {
+		drm_kms_helper_connector_hotplug_event(changed_conns[i]);
+		drm_connector_put(changed_conns[i]);
+	}
+
+	kfree(changed_conns);
+
 out:
-	if (changed)
+	if (delayed_hp)
 		drm_kms_helper_hotplug_event(dev);
 
 	if (repoll)
@@ -1081,39 +1098,40 @@ EXPORT_SYMBOL(drm_connector_helper_hpd_irq_event);
  */
 bool drm_helper_hpd_irq_event(struct drm_device *dev)
 {
-	struct drm_connector *connector, *first_changed_connector = NULL;
 	struct drm_connector_list_iter conn_iter;
-	int changed = 0;
+	struct drm_connector **changed_conns;
+	struct drm_connector *connector;
+	unsigned int changed = 0, i;
 
 	if (!dev->mode_config.poll_enabled)
 		return false;
 
-	mutex_lock(&dev->mode_config.mutex);
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		/* Only handle HPD capable connectors. */
-		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
-			continue;
+	scoped_guard(mutex, &dev->mode_config.mutex) {
+		changed_conns = kmalloc_array(dev->mode_config.num_connector,
+					sizeof(*changed_conns), GFP_KERNEL);
+		if (!changed_conns)
+			return false;
 
-		if (check_connector_changed(connector)) {
-			if (!first_changed_connector) {
+		drm_connector_list_iter_begin(dev, &conn_iter);
+		drm_for_each_connector_iter(connector, &conn_iter) {
+			/* Only handle HPD capable connectors. */
+			if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
+				continue;
+
+			if (check_connector_changed(connector)) {
 				drm_connector_get(connector);
-				first_changed_connector = connector;
+				changed_conns[changed++] = connector;
 			}
-
-			changed++;
 		}
+		drm_connector_list_iter_end(&conn_iter);
 	}
-	drm_connector_list_iter_end(&conn_iter);
-	mutex_unlock(&dev->mode_config.mutex);
 
-	if (changed == 1)
-		drm_kms_helper_connector_hotplug_event(first_changed_connector);
-	else if (changed > 0)
-		drm_kms_helper_hotplug_event(dev);
+	for (i = 0; i < changed; i++) {
+		drm_kms_helper_connector_hotplug_event(changed_conns[i]);
+		drm_connector_put(changed_conns[i]);
+	}
 
-	if (first_changed_connector)
-		drm_connector_put(first_changed_connector);
+	kfree(changed_conns);
 
 	return changed;
 }

-- 
2.53.0

