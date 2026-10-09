Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C337ACA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0321010FE3E;
	Fri,  9 Oct 2026 03:22:32 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBB710FE3A;
 Fri,  9 Oct 2026 03:22:30 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515862t41d55fdb
X-QQ-Originating-IP: 78gJAcIGUVSr0IWztGV4pGd7LvEMa0gC7Diilw8quLk=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7530361477103805638
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:16:02 +0800
Subject: [PATCH v2 10/20] drm/msm/dp: Report stream enable failures through
 link status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-10-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
In-Reply-To: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6880; i=sophon@radxa.com;
 h=from:subject:message-id; bh=5ucLmD84+B3JGHJEDlBaULUVYEj81Nym/HMWEBfcJAg=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZeivUsOv2vx/zYC8YDm9s6JW9t3GCoN6/EYFMG0
 6R5+6bt7yhlYRDjYpAVU2RRiGeYy16Ze+2pWKkezBxWJpAhDFycAjCRHV8Y/in15hR7/RG6orVn
 han5289CDGKVqoY3FgQfSzfcc3ju/XaGfwo8R29fLZgZ9enGMzUPL21BsaWr9Jt3T829X3l2u8U
 EUU4A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NuvczPgZuLZZSnaOn+sMQWqJuKSpfTm4ZiBSd89ZhVPWtYKqWRxi+KMK
 1n7vUTEJtI9BH/D07gDryDCwhKeUG5bDIPFVk6RFNtL/RIF6fjnUFBRHF1KKhmXGYgnmkkX
 tvIOIEACDBwtsI8qOr4NUQQo3pKHUoWlRCZ3ZtMDQJ52eQcD8AvMABdwrBopQHUE+/WbRZH
 UNw5ngxZpvlgx18aWjndOu9bG7iNt6DzqK/KYP0tS6kPXIpNbrWvyM78l8eYy5dO+oLl/FA
 nBVv/GRBpNQTzZ+8VoZJAc5La7xqwYBiq+QHyQD5UVEX281PpUm3c9NYmQcK/taK22PkXTq
 lnrfm7M/hdI/w7fz8ZQjSY0wwxJim58EibfcpuRw0xoO77p7rw3eLSDAmAD78reeDRasItA
 WELUSi9hLVZmmsXxZ7d7Ke+0b/O/6P77NWwvoBEht7GJk8jt3x6hME1mB4ObShEEXST9Pcs
 pCIvUuiUXSwvHrR3FRQOyovcmYV/GPC95VRjdzQedsaZxiRDvUsbluRR9T6fr83xLD6KXlx
 HYqp4UUpcCnFVz3hszEhEFaVZNr7zrfEWzzb9tSz2XuYUk5MAvnQJDxUgODLj7IbKgNWV31
 kD0UCMOSlTSOadcK6JHGgcRSAHHdmdkOjS1IAlgGaBG4kl540BuCqEfERs8APmc6ODOrDae
 ATx27pvVOuizVdAPlapvJyahUdY+Nlz6WTI3QepzXfRXTU/Nalbn8lPix1mJioc8K8iopJo
 KGyEJFnpWiT6b1mwUH1MX6m/hVyQpWTA6fMBEXYynMCR9/ItLV3SKa/RCg79yy1EedTuT8k
 KNNQg/GGioUxfKOu3IAHM6lofeeTBtr9cs3oBWnwtChueI3bd3rFb9Q1e35r3Qz9nB3tuH/
 IlF6X1+j2f+0Kr+y+6yoxH6blHoxIILSWkKMV+Hw6X8+DenJ1RQUbOASJ06xyx4o3mj5DmP
 0FaGOtYdaNM7AtyZJWhT+L7HhtsLhDjo44P2V3UJKINxTDUTgtQYtw215106aNy7eIk87YQ
 euywsf1Wa6wGp0gBDZhD4CXfm2fGTwgZiiC29uTH0Xc2Y41dRNyI/wvLmVl+Vn+kfH+Y2wr
 kWoQO54bPxj
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

Atomic bridge enable callbacks cannot return an error to userspace.
After a failed enable, leaving link-status unchanged gives userspace
no indication that it needs to retry the configuration.

Mark the connector link status bad from a work item after unwinding
the failed enable.

Send one connector hotplug notification per failure episode. The
notification also invokes the fbdev hotplug handler, which can retry
the modeset synchronously. Since atomic enable callbacks cannot
return errors, another stream enable failure can requeue this work
without reporting a failed commit to fbdev. Notifying on every
failure could therefore cause an unbounded retry loop.

Subsequent failures still restore BAD after a retry sets link-status
to GOOD, but suppress further notifications until a successful enable
or an external sink connection change. Do not reset the notification
latch during eDP's internal plug and unplug handling, which runs on
every retry.

Skip failures superseded by recovery or an external unplug before the
worker checks the failure state. Protect the failure state with
plugged_lock, then release it before calling
drm_connector_set_link_status_property(). The helper takes the
connection mutex, which precedes plugged_lock in atomic check's lock
order. Send the notification after the helper releases the mutex.
Recovery concurrent with the property update can cause an extra retry.

Initialize the work at probe and cancel it before unbinding the
display.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 61 +++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b076d44b5118..816f2dc11aea 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -12,9 +12,11 @@
 #include <linux/phy/phy.h>
 #include <linux/delay.h>
 #include <linux/string_choices.h>
+#include <linux/workqueue.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_probe_helper.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
@@ -54,10 +56,14 @@ struct msm_dp_display_private {
 	bool audio_supported;
 	bool stream_pm_active;
 	bool stream_link_attempted;
+	struct work_struct link_status_work;
 
 	/* Serializes HPD, stream and PSR operations while runtime active. */
 	struct mutex plugged_lock;
 	bool plugged;
+	/* Protected by plugged_lock, including accesses from link_status_work. */
+	bool link_failed;
+	bool link_status_notified;
 
 	struct drm_device *drm_dev;
 
@@ -205,6 +211,39 @@ void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display)
 	complete_all(&dp->audio_comp);
 }
 
+static void msm_dp_display_reset_link_status(struct msm_dp_display_private *dp)
+{
+	lockdep_assert_held(&dp->plugged_lock);
+
+	dp->link_failed = false;
+	dp->link_status_notified = false;
+}
+
+static void msm_dp_display_link_status_work(struct work_struct *work)
+{
+	struct msm_dp_display_private *dp = container_of(work,
+			struct msm_dp_display_private, link_status_work);
+	struct drm_connector *connector = dp->msm_dp_display.connector;
+	bool notify;
+
+	scoped_guard(mutex, &dp->plugged_lock) {
+		/* Skip failures superseded before this work starts. */
+		if (!dp->link_failed)
+			return;
+
+		notify = !dp->link_status_notified;
+		dp->link_status_notified = true;
+	}
+
+	/* The helper takes connection_mutex, so drop plugged_lock first. */
+	drm_connector_set_link_status_property(connector,
+					       DRM_MODE_LINK_STATUS_BAD);
+
+	/* fbdev can retry the modeset synchronously from this notification. */
+	if (notify)
+		drm_kms_helper_connector_hotplug_event(connector);
+}
+
 static int msm_dp_display_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -235,6 +274,7 @@ static void msm_dp_display_unbind(struct device *dev, struct device *master,
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 
+	cancel_work_sync(&dp->link_status_work);
 	of_dp_aux_depopulate_bus(dp->aux);
 
 	msm_dp_aux_unregister(dp->aux);
@@ -424,6 +464,10 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	mutex_lock(&dp->plugged_lock);
 
+	/* eDP calls this for every enable, including automatic retries. */
+	if (!dp->msm_dp_display.is_edp && !dp->plugged)
+		msm_dp_display_reset_link_status(dp);
+
 	msm_dp_aux_enable_xfers(dp->aux, true);
 
 	ret = msm_dp_display_host_phy_init(dp);
@@ -466,6 +510,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	mutex_lock(&dp->plugged_lock);
 
+	if (!dp->msm_dp_display.is_edp)
+		msm_dp_display_reset_link_status(dp);
+
 	dp->panel->video_test = false;
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
@@ -529,10 +576,12 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	if (!rc) {
 		sink_request = dp->link->sink_request;
 		drm_dbg_dp(dp->drm_dev, "sink_request=%d\n", sink_request);
-		if (sink_request & DS_PORT_STATUS_CHANGED)
+		if (sink_request & DS_PORT_STATUS_CHANGED) {
+			msm_dp_display_reset_link_status(dp);
 			rc = msm_dp_display_process_hpd_high(dp);
-		else
+		} else {
 			rc = msm_dp_display_handle_irq_hpd(dp);
+		}
 	}
 
 	drm_dbg_dp(dp->drm_dev, "After, type=%d, sink_count=%d\n",
@@ -682,7 +731,6 @@ static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
 	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
 		return rc;
 	}
 
@@ -1278,6 +1326,7 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 	dp->hpd_isr_status = 0;
 
 	mutex_init(&dp->plugged_lock);
+	INIT_WORK(&dp->link_status_work, msm_dp_display_link_status_work);
 
 	rc = msm_dp_display_get_io(dp);
 	if (rc)
@@ -1571,6 +1620,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 		goto err;
 	}
 
+	msm_dp_display_reset_link_status(dp);
 	mutex_unlock(&dp->plugged_lock);
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1583,6 +1633,11 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_unplug_handle(dp);
 	msm_dp_display_unprepare(dp);
+	scoped_guard(mutex, &dp->plugged_lock) {
+		dp->link_failed = true;
+		/* Keep reporting BAD, but notify only once until recovery. */
+		schedule_work(&dp->link_status_work);
+	}
 }
 
 void msm_dp_display_atomic_disable(struct msm_dp *dp)

-- 
2.56.0

