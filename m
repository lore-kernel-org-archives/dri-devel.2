Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C90CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B4B10EC5F;
	Thu, 28 May 2026 05:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RwknuATx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF0010EC56
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E2AD60126;
 Thu, 28 May 2026 05:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08A71F00A3A;
 Thu, 28 May 2026 05:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947405;
 bh=s6VzFioN/lAeYUjWxS15gAqLDzgLLRmijtzXmzJy6pU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RwknuATxTSDCuabyVXoc8iNxRG7LyLPCTL4lx0ehf9aFklze5jBQyKi7bBufh8JUu
 Mi7zDp1gtCh3C1jWunVDgXlQVh/pO4CP14wExD1nTRJFDzA5HRqp0Xs0pqKpRYYyyE
 f7AXLBOVrvstaLl9DI/U3Czt36yrufPcxJzqz2U8dHfdf+i2bq0463WaJkacsr4zaq
 5jqNwpCx89K1TZSzqEMmDBpKRFG95ZD9Zc0JMT5odl9F2t9jKJfz39yprA70LzGlMh
 7tI7/JzZMRmSJqtogKXwvv7hJ8SUfCQos+l4w5Kv2eieWT1d5RgM79UvR/aaB3+IKQ
 AeTVi7SQIog2Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>
Subject: [PATCH v4 2/9] backlight: add kernel-internal backlight API
Date: Thu, 28 May 2026 00:49:04 -0500
Message-ID: <20260528054911.1513208-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

So far backlights have only been controlled via sysfs. However, sysfs is
not a proper user-space API for runtime modifications, and never was
intended to provide such. The DRM drivers are now prepared to provide
such a backlight link so user-space can control backlight via DRM
connector properties. This allows us to employ the same access-management
we use for mode-setting.

This patch adds few kernel-internal backlight helpers so we can modify
backlights from within DRM.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

V2: Marta Lofstedt <marta.lofstedt@intel.com>
- rebase
- minor edit for checkpatch warning

Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>

V3: Mario Limonciello (AMD) <superm1@kernel.org>
 - rebase
 - Use guard(mutex)

V4: Mario Limonciello (AMD) <superm1@kernel.org>
 - Adjust return type for backlight_set_brightness() to return errors
 - Stop clamping in backlight_set_brightness()
 - Drop backlight_device_lookup()

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/video/backlight/backlight.c | 33 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 15 +++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index ff2c2084c73a..661243afc877 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -514,6 +514,39 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
+/**
+ * backlight_set_brightness - set brightness on a backlight device
+ * @bd: backlight device to operate on
+ * @value: brightness value to set on the device
+ * @reason: backlight-change reason to use for notifications
+ *
+ * This is the in-kernel API equivalent of writing into the 'brightness' sysfs
+ * file. It calls into the underlying backlight driver to change the brightness
+ * value.
+ * A uevent notification is sent with the reason set to @reason.
+ * Return: 0 if successfully notified, -EINVAL for invalid values
+ */
+int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason)
+{
+	int rc = 0;
+
+	guard(mutex)(&bd->ops_lock);
+	if (bd->ops) {
+		if (value > bd->props.max_brightness)
+			return -EINVAL;
+
+		dev_dbg(&bd->dev, "set brightness to %u\n", value);
+		bd->props.brightness = value;
+		rc = backlight_update_status(bd);
+	}
+	if (rc == 0)
+		backlight_generate_event(bd, reason);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(backlight_set_brightness);
+
 /**
  * backlight_register_notifier - get notified of backlight (un)registration
  * @nb: notifier block with the notifier to call on backlight (un)registration
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index d905173c7f73..204eea9256fd 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -429,6 +429,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
 { }
 #endif
 
+int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason);
+
+static inline void backlight_device_ref(struct backlight_device *bd)
+{
+	if (bd)
+		get_device(&bd->dev);
+}
+
+static inline void backlight_device_unref(struct backlight_device *bd)
+{
+	if (bd)
+		put_device(&bd->dev);
+}
+
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
 /**
-- 
2.54.0

