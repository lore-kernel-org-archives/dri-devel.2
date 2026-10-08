Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB978CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2912810FF02;
	Fri,  9 Oct 2026 07:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sXL90drQ";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29E310ECFC
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 15:50:46 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7c1ecff2b1fso996703137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791474645; x=1792079445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z605x3oSurFK9+1Jj7NngNX+hXuD5vIj60PGN3GhQpM=;
 b=sXL90drQze1pmCR5+MsihqU8a5hOU1GZINfLjAMntg5RL07xCAkf5MmYWPE/glDt0E
 9P1uHmb9GwwVJRyyjwWq9SIXKZj/GSaP0kalqPaLqEPPMufhjg6ls6dRNaFH5vp3IBwz
 /i+ZMAVi/7RaTxre87Q4BgOvtHEx2bm1Hj5vg42nS9Gd/maRlzoFJFQqstHfZ29CDhJ+
 +gZ3qrWb+YQ+pTw+3BlqsUnq8GffbQb7mrlPzFIvnWFyKkb34QjIJ+x6ndqBLfY73fg9
 SFgQMBd8I+jnNIL4jQIIIIHOxKYUWN05IKaZ6+ssw7wSlmDcHlWTxhAj79UKqb5py4Lo
 TiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791474645; x=1792079445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z605x3oSurFK9+1Jj7NngNX+hXuD5vIj60PGN3GhQpM=;
 b=RUDXBnWB0FLQnAUrySnc2clscmnfRsGDaGHPuiVPK26e3YqqQPDS+Nqb+/XWmR7dvn
 g4ZmXE+p7iCCXaFl12qZL3Edz8WZn7nA9eWvHAs3cQ6HZKtgCLqKw49XwSbfnUybkcHN
 hlRqKsRMxWqfntPPzwr2dn48Bf6Dn8JSuuMyfpDdiXsKPZOLCGKAzbS3O+AINlKvHSa8
 Cd0FYvlLZYddTRlAK9VF0vkN5em5Ntny3LqBBHoRvqc3APeIBGnUtANLhv1TgaWAsphT
 p9VraocC0ksX6FC2/FhG9tK69VKue3322nkOCup7UJcTYQbBFYRb8HbFpbQ/R5gL5Ts2
 KyCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyaWbbkDLAv6gIjPrpMJIIONfAi3Y/ywqOamCVrgWKTXeErMZPiqtWSl12U4JFy3+D1CfAQcsnoks=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL12lD5ztWIDjAY2eP6J/OIw5XIWAOMI62I8vJGyRqvTUsoVJJM
 QTCcKkQFDnkOGAVOcN2GwhbNicsbOd3ZSVQCfUPk2GbXga+m+srRiepq
X-Gm-Gg: AYBFou2G/gIpp7pODLy6iJlyfDIIAGlEvVRv5hT2zNQiQiooRSVfl/U8uQsaEP5nLC9
 dblp3KNAPckFAJpTaTc0avA4wRThPsd7sW+HnmhBebP011gTYjacHSo8BWTOfZqe77231E8KdRc
 0k7DVjb4akqPHNUBLsdO7AicRoMUdWMartK+VtqJM6DjS7hHIbHBnscuRDYXJVRzVvVkg/4Ek8X
 93OGy2xxNtMfVZM3zkMGeXXbE8O20vlQyiek5I2GyjpWgVA8lC40fePeNf4AZ7Z7wh0cqStx734
 EybgGl+w+1ZEbrIikM6kco6jPNUJQ6P67coO7BF4n1ovEgA2827wvfMItDdFv7+62noSUqt5wOe
 /wiXr9QHU2Bro/S3dhUm+VDp1Dj3S8UhRFDYMLA0ePEhzN6b2/upIZ5Nwm2zu8BKqaxpVVYt2hb
 kjAY6ba4vcRPQZrHQK4lazrL2LCE29Udw/aF0lteV+5MV1jKM=
X-Received: by 2002:a05:6102:4426:b0:7b2:508e:3d57 with SMTP id
 ada2fe7eead31-7ca36e40c71mr1688635137.4.1791474645346; 
 Thu, 08 Oct 2026 08:50:45 -0700 (PDT)
Received: from fedora ([2804:14c:3b83:954b::e289])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-98e39adb533sm4293125241.2.2026.10.08.08.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 08:50:43 -0700 (PDT)
From: Julio Faracco <jcfaracco@gmail.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/qxl: Fix out-of-bounds read in client monitors head
 access
Date: Thu,  8 Oct 2026 12:50:34 -0300
Message-ID: <20261008155034.55688-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

qxl_update_offset_props() dereferences
qdev->client_monitors_config->heads[output->index] for every connector.
The connector list holds qxl_num_crtc entries (default 4), but heads[] is
only allocated for client_monitors_config->count entries. When the client
reports fewer monitors than qxl_num_crtc (e.g. a guest started with
heads=1), output->index exceeds count and the read runs off the end:

    BUG: KASAN: slab-out-of-bounds in
         qxl_display_read_client_monitors_config+0x61e/0x6f0 [qxl]
    Read of size 4 ... located 16 bytes to the right of
    allocated 32-byte region

Factor the index-vs-count check already open-coded in
qxl_add_monitors_config_modes() and qxl_conn_detect() into a
qxl_output_get_client_head() helper that returns the head or NULL when the
config is absent or does not cover the output's index, and use it in all
four places, including qxl_conn_get_modes() which had the same unchecked
heads[output->index] access reachable from the mode probe path.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
v2:
- Also convert qxl_conn_get_modes(), same unchecked access
  (from Sashiko AI review).

 drivers/gpu/drm/qxl/qxl_display.c | 40 ++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..35440ee71b83 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -148,6 +148,21 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
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
@@ -158,7 +173,9 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		output = drm_connector_to_qxl_output(connector);
 
-		head = &qdev->client_monitors_config->heads[output->index];
+		head = qxl_output_get_client_head(output);
+		if (!head)
+			continue;
 
 		drm_object_property_set_value(&connector->base,
 			dev->mode_config.suggested_x_property, head->x);
@@ -263,12 +280,11 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
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
@@ -1054,11 +1070,11 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	unsigned int pwidth = 1024;
 	unsigned int pheight = 768;
+	struct qxl_head *head;
 	int ret = 0;
 
-	if (qdev->client_monitors_config) {
-		struct qxl_head *head;
-		head = &qdev->client_monitors_config->heads[output->index];
+	head = qxl_output_get_client_head(output);
+	if (head) {
 		if (head->width)
 			pwidth = head->width;
 		if (head->height)
@@ -1111,15 +1127,17 @@ static enum drm_connector_status qxl_conn_detect(
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

