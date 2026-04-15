Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5EEF42100
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD6110E74C;
	Wed, 15 Apr 2026 18:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Fl8roNM0";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F85410E73A;
 Wed, 15 Apr 2026 18:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776276010; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eEt+Y2K1ueU8liDeOfdoYz+iiq2ngj+JzQQj/PpRKsMEmOG6/sfyvFnOTxP8pWSxf7Gc7QwuAsa+mIO4tIFw7vRNXFvTFZf7FJGAqrjq6uBKnsfp/wp61IELY+UxB1s55aNb+3jL8LZTTX9QuLChsTcF98LoAnOJy8KKlJAHf8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776276010;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IdcPwzm8ONcc+M8gR9eizacihnA4BnZBM3/FGNqzBko=; 
 b=aHWIbOT0lhhYApBGajwz3tuBrduR33pz1uKdoBVtlcDLlpBLeI7W7aYwfCsavMP+7aSttB/+yCUm5gjMinMo77uHmQOwNwaWn9F/O4k2hzxI8X/2TDVsYhKa1n98Ivq7wh0UB2AeqPXyfabF9jUljt2SPvWUp7S7A0iwQ1lBE1c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776276010; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=IdcPwzm8ONcc+M8gR9eizacihnA4BnZBM3/FGNqzBko=;
 b=Fl8roNM0tWk5eFzdXu46oWE+FEM9IhGP9MLFp1IgSXflsUG9N2VUaOq7JKzCIc3k
 vzfD0eeEy3O7BA0VaJbdnraf7GXYeM+2tzNyVpX36p3iBztDu8ws1yEp+3ogT0+hsNA
 lCFZvDi9aQh4I2rxCKw3oOefuFjifY0vYu0fjEdI=
Received: by mx.zohomail.com with SMTPS id 1776276009203817.5967290824977;
 Wed, 15 Apr 2026 11:00:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 15 Apr 2026 19:59:40 +0200
Subject: [PATCH RESEND v7 2/2] drm: Send per-connector hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-hot-plug-passup-v7-2-9a27ef5e2428@collabora.com>
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

Use the new pending_hp member of drm_connector to always send
per-connector hotplug events for those connectors that need it, rather
than sending a global event, or only an event for one connector.

On the HPD (Hot Plug Detect) path this change notifies all connectors,
rather than just first changed connector.

The polling path is changed to no longer send a connector-less hotplug
event, but similarly send a hotplug event for each changed connector.

Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index f8cbd6713960..5c39f27ada1d 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -860,8 +860,14 @@ static void output_poll_execute(struct work_struct *work)
 	mutex_unlock(&dev->mode_config.mutex);
 
 out:
-	if (changed)
-		drm_kms_helper_hotplug_event(dev);
+	if (changed) {
+		drm_connector_list_iter_begin(dev, &conn_iter);
+		drm_for_each_connector_iter(connector, &conn_iter) {
+			if (connector->pending_hp)
+				drm_kms_helper_connector_hotplug_event(connector);
+		}
+		drm_connector_list_iter_end(&conn_iter);
+	}
 
 	if (repoll)
 		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
@@ -1124,10 +1130,16 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
 	drm_connector_list_iter_end(&conn_iter);
 	mutex_unlock(&dev->mode_config.mutex);
 
-	if (changed == 1)
+	if (changed == 1) {
 		drm_kms_helper_connector_hotplug_event(first_changed_connector);
-	else if (changed > 0)
-		drm_kms_helper_hotplug_event(dev);
+	} else if (changed > 0) {
+		drm_connector_list_iter_begin(dev, &conn_iter);
+		drm_for_each_connector_iter(connector, &conn_iter) {
+			if (connector->pending_hp)
+				drm_kms_helper_connector_hotplug_event(connector);
+		}
+		drm_connector_list_iter_end(&conn_iter);
+	}
 
 	if (first_changed_connector)
 		drm_connector_put(first_changed_connector);

-- 
2.53.0

