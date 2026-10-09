Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74359CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D815910FE3D;
	Fri,  9 Oct 2026 03:20:15 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD8110FE3D;
 Fri,  9 Oct 2026 03:20:14 +0000 (UTC)
X-QQ-mid: zesmtpip2t1791515850tc30037a9
X-QQ-Originating-IP: aSGd6OVV+xf3PiTsG/D4LwATaC3JbU9u/HkEDXPIHtY=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Oct 2026 11:17:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9398557567907882420
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 11:15:59 +0800
Subject: [PATCH v2 07/20] drm/msm/dp: Serialize stream operations with HPD
 processing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-msm-dp-hdr10-v2-7-1835d4966da3@radxa.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=sophon@radxa.com;
 h=from:subject:message-id; bh=y0Qxe6uEfYyWn21dpm7+XJNy2fWN1WyeLFfBAJmoLMI=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknYlZWMF5+vqL/zuyM03XtTtOrtp9YIOhhuzd4q+Wze
 F7m958MOkpZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEyko4Phr2jC5hMBzt56KSKe
 oauZThxVyWG8V7PdwDjcN1HrLoPzL4b/ETN5Cov0tgu5iW4+e9lup72H4dQpFq69qawBds++/Nj
 NAQA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MzXUDVSdxx0BlZpr5NGa2fozslBmfQtf9uMazazhzAh2r0Lj6hGfXxxt
 m64S3ku03uTbpV9WPphhc7MqoFHUQ3hAdP8AVwdm5tHvuC5KyF+Eub6vrcYNaWhPKOj5yu+
 NkG712Iy/SpZs5E0M06+IEotbHM0XtIdiXx/E7eFLYSzLvaEhA59Ypydf6l/9jJnc3QRV8t
 Z7XHJIXPgAZKZUXtUph1aVzhdTmfKMwuOprtfAkcIG61cFbGYqMW7cPFqsOhg8pRbB6WY56
 wJ39OD70Byxs0jkJxiX5I/+Yl80CzDS2Hi4djlptxjZtIfeXRrmy1FIWhsnhVdt3TBTsvFk
 ygOh4NREAWgPiA0lBvAWwPRVa2L/wIGZW2QW684oKE3iSoXU2dZtD73Tm+BX64zjFkEAkls
 VW03/Iy3F5Yedb3hlcYkwen0hpi1UI62nQ+Bh7ILY2G0FmNr5BVYh736gXLyZi+nulv2ESv
 rkC4GXlN1sJmM+Pj54TIYrIxjT+UYmW3wjTr0FRQqfe1bbNWlcZIL/n6ub8hO7qwOkXoOA/
 k2TAgOwC5FdQhKuvAi/Tpfrt2Imh2tmfC0SM2VLIKiOtr68j17pDFI6slDRzHEoY7CmHmww
 JciwjgwGbgt50Z6nhLkzDquTq19ADK2SfFVUGg38h8/P6vhc9Rroz43e6TVOBATgomJ3N4C
 Uf4bJAeZUl0JgD/+jRoVDrLi272WcJpuGoFCo7j/CGGb1/bpeEY+KSKt5bQPQIGEuApcuUA
 VcJUR9aYEJIFyAb+X9drrB2zN+kmu231ObQWtGqqxUBLMY4dMge2rrOZgZolcD/ZQ1ufgBW
 7KV6UTp5mPpY31WSw76c/3njbHI5bmJLOnK/tYVJL2kJ6at9oBK1I8iPwfpdXxSHBHgmUBp
 dgQy5BKLiUsoMmGxnuKS1KMFagxMQ4w5uZQp06b6iBmwK20J+vXyTg0By7ebxzy8IolnTfI
 1rbg6pZVwyfC+3EKFmQbATZ+pDOj1kcAMex2CvofVKbZJ8zlwjaqYnPTbwkkyT/bze9v7p2
 59wYCbFgHATGbFhkt2sHpZLUVVb53Jd1TJ6wp8t9fPfw53+fe3z1fSY9X3yQI=
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

HPD PHY test requests stop and restart the mainlink under plugged_lock,
but atomic stream enable and disable do not take that lock. Both paths
can check a resource flag before either updates it and acquire duplicate
clock or PHY references. They can also reset a link while the other path
is training it or enabling video.

Hold plugged_lock across link preparation, stream enable and post-enable,
and protect stream disable and PSR transitions with the same lock. Add
lock assertions to the internal stream helpers. Acquire the runtime PM
reference and handle the eDP plug event before entering the critical
section, and leave audio shutdown waits and runtime PM release outside.

This provides the serialization required by PHY ownership tracking and
the subsequent stream enable rollback paths.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 32a2ac89d8ed..787efbcb6c12 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -53,6 +53,7 @@ struct msm_dp_display_private {
 	bool phy_initialized;
 	bool audio_supported;
 
+	/* Serializes HPD, stream and PSR operations while runtime active. */
 	struct mutex plugged_lock;
 	bool plugged;
 
@@ -623,13 +624,10 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
+static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
-	int rc = 0;
-	bool force_link_train = false;
-
-	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
+	int rc;
 
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
@@ -640,6 +638,19 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 		return rc;
 	}
 
+	return 0;
+}
+
+static int msm_dp_display_prepare_link_locked(struct msm_dp_display_private *dp)
+{
+	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	int rc = 0;
+	bool force_link_train = false;
+
+	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
+
+	lockdep_assert_held(&dp->plugged_lock);
+
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
@@ -664,6 +675,8 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	lockdep_assert_held(&dp->plugged_lock);
+
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 	if (msm_dp_display->power_on) {
 		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
@@ -684,6 +697,8 @@ static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	lockdep_assert_held(&dp->plugged_lock);
+
 	rate = dp->link->link_params.rate;
 
 	if (dp->audio_supported) {
@@ -721,6 +736,8 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	lockdep_assert_held(&dp->plugged_lock);
+
 	if (!msm_dp_display->power_on)
 		return 0;
 
@@ -880,6 +897,8 @@ void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
 	}
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+	guard(mutex)(&dp->plugged_lock);
+
 	msm_dp_ctrl_set_psr(dp->ctrl, dp->panel, enter);
 }
 
@@ -1449,7 +1468,13 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_prepare_link(dp);
+	rc = msm_dp_display_prepare(dp);
+	if (rc)
+		return;
+
+	guard(mutex)(&dp->plugged_lock);
+
+	rc = msm_dp_display_prepare_link_locked(dp);
 	if (rc) {
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 		return;
@@ -1474,6 +1499,8 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	guard(mutex)(&msm_dp_display->plugged_lock);
+
 	/*
 	 * If .atomic_enable() bailed out - link training failure is the common
 	 * case - the mainlink was never brought up and ->power_on stayed false.
@@ -1511,7 +1538,8 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
+	scoped_guard(mutex, &msm_dp_display->plugged_lock)
+		msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.56.0

