Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B645F42100
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2681D10E72E;
	Wed, 15 Apr 2026 18:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="dL02vGEU";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9D110E72E;
 Wed, 15 Apr 2026 18:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776276006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=isSt4nV2sbA24BLpgxx8aP50mpocM7khHu8gtlwOU1e72MbAH8deM3nsgr+G00xY/M4uGnvyDBQYb/Pg43TxlINBYYQ8GWHw0KiO0R1IEuCe0uEwSGhlewpxi0ugbVshkMz1hjSvljCCTv43lpFyqZm6EgQ3DKzX0tarhAW/vgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776276006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CJ9S9SYweRejpCw9A46ovCcBNk/A0W+USSJumRpgMy4=; 
 b=EdIV9KLXIMIcDLKa5LadDDzRJ6LWaakNR9cExDI+TKRCi+Pc1a+vkPNagLFdkI+JvPzSU8byaSSy2AFUVffxb+7pxfBq7tR2xgT6qZu4sXKPEbVV79XF+bOadEn9pjH6Pb2DQsjTtDc4xvpyAuEqn1hwyZcOH/n+lMIxrm80zvE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776276006; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=CJ9S9SYweRejpCw9A46ovCcBNk/A0W+USSJumRpgMy4=;
 b=dL02vGEU8p4jD64v4rpPuLCe5jLaP5fRZ1sFqdK2qp+GXeWV+rS1pjkPkMwFoJdA
 IS/8orBl/HmNAJ1e74W1GfJDoEenddV4TE+n413/PWTkpkW2uB7qXvLY9hTmXiJfvtc
 CYeDDLk24KFt5jAr9XUJZQ6/zDoBdbsI2/KsFhBc=
Received: by mx.zohomail.com with SMTPS id 1776276004760751.849826698265;
 Wed, 15 Apr 2026 11:00:04 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 15 Apr 2026 19:59:39 +0200
Subject: [PATCH RESEND v7 1/2] drm: Introduce pending_hp to drm_connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-hot-plug-passup-v7-1-9a27ef5e2428@collabora.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
In-Reply-To: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
To: =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
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

From: Marius Vlad <marius.vlad@collabora.com>

Introduce a new boolean variable used to track whether a connector has
changed its status since the last hotplug event for it was sent to
userspace. It is used by both the polling and HPD path.

A subsequent change will make use of this new member to propagate
per-connector udev hotplug events to userspace, rather than sending a
global hotplug event.

Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_connector.c    |  1 +
 drivers/gpu/drm/drm_probe_helper.c | 17 +++++++++++++++++
 drivers/gpu/drm/drm_sysfs.c        |  2 ++
 include/drm/drm_connector.h        |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3fa4d2082cd7..b1abdef6778a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -274,6 +274,7 @@ static int drm_connector_init_only(struct drm_device *dev,
 
 	/* provide ddc symlink in sysfs */
 	connector->ddc = ddc;
+	connector->pending_hp = false;
 
 	INIT_LIST_HEAD(&connector->head);
 	INIT_LIST_HEAD(&connector->global_connector_list_entry);
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index d4dc8cb45bce..f8cbd6713960 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -732,6 +732,17 @@ EXPORT_SYMBOL(drm_helper_probe_single_connector_modes);
  */
 void drm_kms_helper_hotplug_event(struct drm_device *dev)
 {
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	mutex_lock(&dev->mode_config.mutex);
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		connector->pending_hp = false;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+	mutex_unlock(&dev->mode_config.mutex);
+
 	drm_sysfs_hotplug_event(dev);
 	drm_client_dev_hotplug(dev);
 }
@@ -748,6 +759,10 @@ void drm_kms_helper_connector_hotplug_event(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
 
+	mutex_lock(&dev->mode_config.mutex);
+	connector->pending_hp = false;
+	mutex_unlock(&dev->mode_config.mutex);
+
 	drm_sysfs_connector_hotplug_event(connector);
 	drm_client_dev_hotplug(dev);
 }
@@ -837,6 +852,7 @@ static void output_poll_execute(struct work_struct *work)
 				    old_epoch_counter, connector->epoch_counter);
 
 			changed = true;
+			connector->pending_hp = true;
 		}
 	}
 	drm_connector_list_iter_end(&conn_iter);
@@ -1101,6 +1117,7 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
 				first_changed_connector = connector;
 			}
 
+			connector->pending_hp = true;
 			changed++;
 		}
 	}
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a8728..47a6b322e873 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -216,6 +216,8 @@ static ssize_t status_store(struct device *device,
 			    connector->base.id, connector->name,
 			    old_force, connector->force);
 
+		connector->pending_hp = true;
+
 		connector->funcs->fill_modes(connector,
 					     dev->mode_config.max_width,
 					     dev->mode_config.max_height);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3e422a4f2e72..70a740301089 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2251,6 +2251,9 @@ struct drm_connector {
 	/** @force: a DRM_FORCE_<foo> state for forced mode sets */
 	enum drm_connector_force force;
 
+	/** @pending_hp: true if connector changed since last hotplug event */
+	bool pending_hp;
+
 	/**
 	 * @edid_override: Override EDID set via debugfs.
 	 *

-- 
2.53.0

