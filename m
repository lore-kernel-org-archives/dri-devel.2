Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EEBCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F5510FEFC;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UcXcUNbG";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4B510E827
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 12:43:32 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5cfa94cce1dso531623e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791463412; x=1792068212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YZ/V9Z4SvvYEKRHXDwdb1N1cFPl5NmC2hXDXe08e+q0=;
 b=UcXcUNbGxfpT35x3ACixEQQCAYI10P8LrD4I0iF48WF2TzT9s/0w6LMqgZkDnOos4k
 uip7vTbZSHR62oJVc8bd0QdQk0m7Lz9dzrOGVcJFknfkVXgA5NQsqe82ThM2o3GMPjRK
 d75ISc1gWIceB0RVN7RxMaLoqbZ0frX3E2+AXpHoYeB8ODsTVx3cirR5HuBuuBq4t1S9
 AM1kJuY+YEL5ggughQ4SdlR4JG3Hc4Ityn3+xQgNalDpTAdBnLGMQtEqh1BxSlE38B1S
 AVRjsFQnEiRCIA7O+jpCC1NLu3c9UXsb8aZq9hW/6ijJBLM8e5FHc8T6ABNtwiGbzmPk
 RHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463412; x=1792068212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YZ/V9Z4SvvYEKRHXDwdb1N1cFPl5NmC2hXDXe08e+q0=;
 b=RuuuVU4lLfng84fX2cLygaRF+geQHiRUsrCBlXVMZqWF/t0NZkRqPL+2jknWlejnNV
 rLy93Zwdpjet4Xv4BF0JJnRdJJRKODkEDetb+LElEBnRCR8S4OXQT5ra9jU4sCcPrS4M
 qcBfOPCL4FEE5PZKFlm9eewu88Jd5jj4hRmh4DNgnDqyuu6V43AMdHDngtyIdY7g7FG2
 6lvKEey29LpLROMD6+H41iwd/5zBglNtMXO9dYbs0Eq4/gPsaMryXxVfhzrzykh7QHIP
 Zwx9sETPQoy5QfErvy8JWhEYbhAb9Vwn2FRYH7JorLtbaaXiuF32KsZpVMcr+8N6NJqb
 H54A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2pUGS5p5KKoed1tD0OXG8obC244ael5aAYIPwhxKuIDuZRqz5cfcaeUc9edd5BHX4OilBrmvhDqY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKM9oIsToYIXiDfhskRP8wBXfW/UKf3nqOKYhHebiH8ughufIf
 ebzgDD3S0t9Z7Jm6Lp2nR5WI/frpuDkjgomz2pg9nIJcP/poy8pmxkbR
X-Gm-Gg: AYBFou1JQxa7mWfB6nogZ4+YmcHV3fweTmMCEZCsxvefi5fsVoUqITq3tGatuTLDYbL
 VrEVh8L/eV9tW3KlkPeqX//ZYaUCH7yFWjYAAzVfsW3pcCB4qOMx2X8YGOR/77LnOOhzxFsYnUe
 EwccPjMbek26M/ZEcTYF4BrvlvPwa++gR7W44wMofXvx6G0BQ2ROhLSZ0zHVJk+Wa70IOC/h0eX
 PXZ9CgogcOLGdJ+NgU5BhCJykX5c7gf4WXenXi+GWZ8eDFORYzm6LGSxyqY3bkdUImP6FczmV/y
 yV2vvb9sMY6MVw+hG242Tq5X6/DItRhizFfT3YQeVtYKTAwk3uFXCr1VZrqD5HeoOVrN6T4nlJX
 omT8Vwo9nqqe+Fp+phUoMrKi/69Wuzb21tBz0IJyoYPtTl9u7HqqxUtKyWaln3Bj7tjZIerzIGl
 I4l67fM7VwmAH7QKB2GW6TuR8gKlCmrkSFjeAgQsLZxIctXbXb
X-Received: by 2002:a05:6102:370c:b0:7c3:66db:a66c with SMTP id
 ada2fe7eead31-7ca38b522ebmr1122494137.20.1791463411637; 
 Thu, 08 Oct 2026 05:43:31 -0700 (PDT)
Received: from fedora ([2804:14c:3b83:954b::e289])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-98e39c39cd4sm3821051241.7.2026.10.08.05.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:43:27 -0700 (PDT)
From: Julio Faracco <jcfaracco@gmail.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: Fix out-of-bounds read in qxl_update_offset_props()
Date: Thu,  8 Oct 2026 09:43:17 -0300
Message-ID: <20261008124317.32199-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:38 +0000
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

Function qxl_update_offset_props() dereferences
qdev->client_monitors_config->heads[output->index] for every connector.
The connector list holds qxl_num_crtc entries (default 4), but heads[] is
only allocated for client_monitors_config->count entries. When the client
reports fewer monitors than qxl_num_crtc (e.g. a guest started with
heads=1), output->index exceeds count and the read runs off the end:

    BUG: KASAN: slab-out-of-bounds in
         qxl_display_read_client_monitors_config+0x61e/0x6f0 [qxl]
    Read of size 4 ... located 16 bytes to the right of allocated
    32-byte region

Factor the index-vs-count check already open-coded in
qxl_add_monitors_config_modes() and qxl_conn_detect() into a
qxl_output_get_client_head() helper that returns the head or NULL when
the config is absent or does not cover the output's index, and use it
in all three places.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 34 +++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 75d47e6b9142..92cc240dc9c2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -147,6 +147,21 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	return status;
 }
 
+/*
+ * Return the client monitors config head for @output, or NULL when the
+ * client monitors config is absent or does not cover this output's index.
+ */
+static struct qxl_head *qxl_output_get_client_head(struct qxl_output *output)
+{
+	struct qxl_device *qdev = to_qxl(output->base.dev);
+	struct qxl_monitors_config *cfg = qdev->client_monitors_config;
+
+	if (!cfg || output->index >= cfg->count)
+		return NULL;
+
+	return &cfg->heads[output->index];
+}
+
 static void qxl_update_offset_props(struct qxl_device *qdev)
 {
 	struct drm_device *dev = &qdev->ddev;
@@ -157,7 +172,9 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		output = drm_connector_to_qxl_output(connector);
 
-		head = &qdev->client_monitors_config->heads[output->index];
+		head = qxl_output_get_client_head(output);
+		if (!head)
+			continue;
 
 		drm_object_property_set_value(&connector->base,
 			dev->mode_config.suggested_x_property, head->x);
@@ -262,12 +279,11 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 		return 0;
 	if (h >= qxl_num_crtc)
 		return 0;
-	if (!qdev->client_monitors_config)
-		return 0;
-	if (h >= qdev->client_monitors_config->count)
+
+	head = qxl_output_get_client_head(output);
+	if (!head)
 		return 0;
 
-	head = &qdev->client_monitors_config->heads[h];
 	DRM_DEBUG_KMS("head %d is %dx%d\n", h, head->width, head->height);
 
 	return qxl_add_mode(connector, head->width, head->height, true);
@@ -1103,15 +1119,17 @@ static enum drm_connector_status qxl_conn_detect(
 		drm_connector_to_qxl_output(connector);
 	struct drm_device *ddev = connector->dev;
 	struct qxl_device *qdev = to_qxl(ddev);
+	struct qxl_head *head;
 	bool connected = false;
 
 	/* The first monitor is always connected */
 	if (!qdev->client_monitors_config) {
 		if (output->index == 0)
 			connected = true;
-	} else
-		connected = qdev->client_monitors_config->count > output->index &&
-		     qxl_head_enabled(&qdev->client_monitors_config->heads[output->index]);
+	} else {
+		head = qxl_output_get_client_head(output);
+		connected = head && qxl_head_enabled(head);
+	}
 
 	DRM_DEBUG("#%d connected: %d\n", output->index, connected);
 
-- 
2.55.0

