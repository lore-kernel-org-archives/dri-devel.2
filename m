Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A8CD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228F7112AE3;
	Sun, 31 May 2026 11:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VL+LXXyv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885DC112AE1;
 Sun, 31 May 2026 11:49:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31ECF4456E;
 Sun, 31 May 2026 11:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09301F00898;
 Sun, 31 May 2026 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228156;
 bh=llV6/OzX1c//DkiowHxie2fzB9cbWHYDsc1iY8I5uZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VL+LXXyvKk9Zl9OnCSYuy/glgTuzmKo16cUiLlMiScsbBoHrzu82dfok75sBY/l+j
 2CEvuX+Ogpa7ulg/utuSaG7wpkKPgeev3TBWsAmrl+xi5s/0Q33RcKYhq8m/MYiQBs
 7WtgQjyoQy6DxKwjfxVMBWdgZYNleaLQsJzXSrESlqJYXjLV8YDArN1sVwDwiFvlVG
 XEkbeDySruGeQLU91jSoqQ0cJLN4rkwsUwlwit9eIIkF2g/Jjo77pNvB6/UpI30X7C
 0Ml/2eN7YJeCUmzNBErguL77kM0Uv89nL9jax6RM7A3KYhjfFxvWBMFRaiZqk7cVtU
 TQgIETNjTKN1A==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 01/11] Revert "backlight: Remove notifier"
Date: Sun, 31 May 2026 06:48:58 -0500
Message-ID: <20260531114908.1693426-2-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531114908.1693426-1-superm1@kernel.org>
References: <20260531114908.1693426-1-superm1@kernel.org>
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

This reverts commit 5461f3fd74a89757f95f351eb0bc26aafc2a2e91.
The backlight notifier support is needed in order to add backlight
control support into DRM connectors.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/video/backlight/backlight.c | 42 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 20 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index a22d0bbb6e63..ff2c2084c73a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -65,6 +65,7 @@
 
 static struct list_head backlight_dev_list;
 static struct mutex backlight_dev_list_mutex;
+static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
 	[BACKLIGHT_RAW] = "raw",
@@ -415,6 +416,9 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_REGISTERED, new_bd);
+
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
@@ -484,6 +488,9 @@ void backlight_device_unregister(struct backlight_device *bd)
 	mutex_unlock(&pmac_backlight_mutex);
 #endif
 
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_UNREGISTERED, bd);
+
 	mutex_lock(&bd->ops_lock);
 	bd->ops = NULL;
 	mutex_unlock(&bd->ops_lock);
@@ -507,6 +514,40 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
+/**
+ * backlight_register_notifier - get notified of backlight (un)registration
+ * @nb: notifier block with the notifier to call on backlight (un)registration
+ *
+ * Register a notifier to get notified when backlight devices get registered
+ * or unregistered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
+ */
+int backlight_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_register_notifier);
+
+/**
+ * backlight_unregister_notifier - unregister a backlight notifier
+ * @nb: notifier block to unregister
+ *
+ * Register a notifier to get notified when backlight devices get registered
+ * or unregistered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
+ */
+int backlight_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_unregister_notifier);
+
 /**
  * devm_backlight_device_register - register a new backlight device
  * @dev: the device to register
@@ -674,6 +715,7 @@ static int __init backlight_class_init(void)
 
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
+	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
 	return 0;
 }
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index f29a9ef1052e..d905173c7f73 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -64,6 +64,24 @@ enum backlight_type {
 	BACKLIGHT_TYPE_MAX,
 };
 
+/**
+ * enum backlight_notification - the type of notification
+ *
+ * The notifications that is used for notification sent to the receiver
+ * that registered notifications using backlight_register_notifier().
+ */
+enum backlight_notification {
+	/**
+	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
+	 */
+	BACKLIGHT_REGISTERED,
+
+	/**
+	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
+	 */
+	BACKLIGHT_UNREGISTERED,
+};
+
 /** enum backlight_scale - the type of scale used for brightness values
  *
  * The type of scale used for brightness values.
@@ -388,6 +406,8 @@ void devm_backlight_device_unregister(struct device *dev,
 				      struct backlight_device *bd);
 void backlight_force_update(struct backlight_device *bd,
 			    enum backlight_update_reason reason);
+int backlight_register_notifier(struct notifier_block *nb);
+int backlight_unregister_notifier(struct notifier_block *nb);
 struct backlight_device *backlight_device_get_by_name(const char *name);
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
 int backlight_device_set_brightness(struct backlight_device *bd,
-- 
2.54.0

