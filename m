Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65675CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C392610E7CE;
	Wed, 30 Sep 2026 12:43:18 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF70F10E7CE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:43:16 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772154tebdb32ff
X-QQ-Originating-IP: Ry8Wrc7Eku6qSgGmputUvT4cojOVWJV0pQ6IgT2uFgQ=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11209306070385417255
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:50 +0800
Subject: [PATCH 06/13] drm/msm/dp: Report stream enable failures through
 link status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-6-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6146; i=sophon@radxa.com;
 h=from:subject:message-id; bh=3xPg6CRSwpm7rmSrOT8d0MRVksemxHmGHP5aWT1H2Qk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZdJXbZp4L0Tp7VwdcasW7tbrJ2uyH5dXjb12KGti
 5bUrOs53VHKwiDGxSArpsiiEM8wl70y99pTsVI9mDmsTCBDGLg4BWAievsZGbZ3fjRxDSl+zcvP
 w/hib12WRsfVO06tXOeE3x3+uFlscxgjw0a3Y7euzrhSF/Tb5LtIxKeDcaER2ct+z+Nwujlhmtv
 +dE4A
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhOKvsv6t0fk1GePWG79psjSenANu0ODvPvWrWWJOPAkAcziRveoOocp
 9sHZKfl2RRhAnaFaTt5gO9PRiIT4D8JoFh5eMYd5tX4grGiyKtOr33P6b7Sg2D69WgvtUe8
 HDmlYQzxJ/MawXYPHC8TC135Jyzyo+Tjv5F6+ExCWREUkNXovuy3pNXhAbPAfOR0dqiaNNV
 wjZ9oRizPUkmSHHlk6HJNvMn9w2VOiyiBaDIHNKRCRQF+to/juim+UK6DIb3gSKvz1IUc3q
 s+cr2sdWSokruHlvOzJr+QEJrsvbEHsAMO6P645LjrfoiBRgllddEqc3R7zazTriAQdpPNq
 PNngGudl/HSKiAyYrV8+q4nRqqz10qgC7CM7btpF5igDqrFR7Lk6VVk3/u30pNAA3My42Om
 AN+rSCvTH2v93nvFd/UBpW+yl/+kd1xz49PxMxxyb302+WneiR/qwtu+TdAQb0WJf7/ljOd
 O5+/BuD6OfrscVGqD4ClX/KPWpoQJhhE1urxte0mxOTRIoOociZuLTeHSXXLjpFt4qQ7Q9s
 Qn7N3Z+O2LtXpKQXg1yuBapddBbilt9zxpzYj6Ii94HJ1bkGisND5gfCtUERjsvxAno3Ud3
 5FO1jfuEAQpOLBUXmfdP/1YI2TaCLPTVRgkdbRXLOIRQ6j2whmgeZpZqNyvgkUayNn75imB
 K0gGau5LeXZA9IQMuoyftEmMDIQqesAl1Ouv9+5f0CjGt3AJwvI3yDFrmRnA2xKJRI5QCbA
 xOU+TZOF/PFPGtsMPV4qNHE1b9p1A+nFCrCiRq3kK5qgHB4s7qshyGRAIOnTZAWIgotpg5j
 c8IDOL3Co5dxXVuPX0LPKuuL2H0wpyzIk0jX8D0yMuMKVt1ewRxI20Y4zqtCHeiQQzAeXJt
 Pxm9iRWD9RmVafMAgU2FqKUbOCYNPcapVExNTD0M6KlvFAH0XqP/DsTUKhsWgQ6TbPuP+Ml
 KjmVxukQJCA3/Opwlm8Ex/akTHKhjX4aMa1LNbZmTwp3i3CUbuT1Gw7ctjms3B9jtDq0JQn
 QSbPB+3Gx/yPTmyjOoZA8mnGp21F+oeBrTLTKPNXPmN/6eXPnZdpAUI56V6O0K49Kj+UkOB
 VzgXJTELOtC
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
the failed enable. Send one connector hotplug notification per failure
episode: fbdev can synchronously retry the modeset from the
notification, so notifying on every failure would create an unbounded
retry loop. Subsequent failures still restore BAD after a retry has
set the property to GOOD.

Allow notifications again after a successful enable or an external
sink connection change. Do not reset the notification latch during
eDP's internal plug and unplug handling, which runs on every retry.
Ignore queued work superseded by recovery or an external unplug.
Serialize the failure state with plugged_lock and update link-status
under the connection mutex before notifying clients with both locks
released.

Initialize the work at probe and cancel it before unbinding the
display.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 63 +++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index ae967ca652c9..1bfa6696d904 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -12,9 +12,12 @@
 #include <linux/phy/phy.h>
 #include <linux/delay.h>
 #include <linux/string_choices.h>
+#include <linux/workqueue.h>
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_modeset_lock.h>
+#include <drm/drm_probe_helper.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
@@ -54,9 +57,13 @@ struct msm_dp_display_private {
 	bool audio_supported;
 	bool stream_pm_active;
 	bool stream_link_attempted;
+	struct work_struct link_status_work;
 
 	struct mutex plugged_lock;
 	bool plugged;
+	/* Protected by plugged_lock, including accesses from link_status_work. */
+	bool link_failed;
+	bool link_status_notified;
 
 	struct drm_device *drm_dev;
 
@@ -204,6 +211,39 @@ void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display)
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
+	struct drm_device *dev = connector->dev;
+	bool notify = false;
+
+	/* Match atomic check's connection_mutex -> plugged_lock ordering. */
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
+	scoped_guard(mutex, &dp->plugged_lock) {
+		/* A successful enable or unplug may have superseded this work. */
+		if (dp->link_failed) {
+			connector->state->link_status = DRM_MODE_LINK_STATUS_BAD;
+			notify = !dp->link_status_notified;
+			dp->link_status_notified = true;
+		}
+	}
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	/* fbdev can retry the modeset synchronously from this notification. */
+	if (notify)
+		drm_kms_helper_connector_hotplug_event(connector);
+}
+
 static int msm_dp_display_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -234,6 +274,7 @@ static void msm_dp_display_unbind(struct device *dev, struct device *master,
 	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 
+	cancel_work_sync(&dp->link_status_work);
 	of_dp_aux_depopulate_bus(dp->aux);
 
 	msm_dp_aux_unregister(dp->aux);
@@ -417,6 +458,10 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
+	/* eDP calls this for every enable, including automatic retries. */
+	if (!dp->msm_dp_display.is_edp && !dp->plugged)
+		msm_dp_display_reset_link_status(dp);
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -463,6 +508,9 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	guard(mutex)(&dp->plugged_lock);
 
+	if (!dp->msm_dp_display.is_edp)
+		msm_dp_display_reset_link_status(dp);
+
 	dp->panel->video_test = false;
 
 	msm_dp_aux_enable_xfers(dp->aux, false);
@@ -524,10 +572,12 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
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
@@ -1246,6 +1296,7 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 	dp->hpd_isr_status = 0;
 
 	mutex_init(&dp->plugged_lock);
+	INIT_WORK(&dp->link_status_work, msm_dp_display_link_status_work);
 
 	rc = msm_dp_display_get_io(dp);
 	if (rc)
@@ -1534,11 +1585,19 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 		goto err;
 	}
 
+	scoped_guard(mutex, &dp->plugged_lock)
+		msm_dp_display_reset_link_status(dp);
+
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 	return;
 
 err:
 	msm_dp_display_abort_enable(dp);
+	scoped_guard(mutex, &dp->plugged_lock) {
+		dp->link_failed = true;
+		/* Keep reporting BAD, but notify only once until recovery. */
+		schedule_work(&dp->link_status_work);
+	}
 }
 
 void msm_dp_display_atomic_disable(struct msm_dp *dp)

-- 
2.55.0

