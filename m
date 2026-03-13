Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F921103E302
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310DB10EAC5;
	Fri, 13 Mar 2026 00:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HRk3yZJk";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7915010E318
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:06:39 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35a08ce49dcso1453110a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 17:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773360398; x=1773965198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nuLpHvR1fwObt/8Xvj3rrc9Oc9+CrLWMV9LCtsBGyrI=;
 b=HRk3yZJkRh0tBK257N6NxVSqZEPSkO1tZim5cg8HnDA3Ix5YrUrsQf6X7SQDvoqCSE
 olXRlu/U5XZo1s7j9GCMby/2S1h7eCgAGQtg0k6F0WFu9Wr8eQWxhLCgFPHwJX3Y1+iN
 9NdZrsymmPzJzAcIfd4InIr8/3ahne6JSKZRXnIZ63OLYaJx8wcANkFukrEBsV6GJCgT
 WaFB76jyttddyGlnzV+AswZwhKk0BXbN6Zuna0wLiAnTTMH4yhZr7CyQyqdKYyrhUUSX
 /WYmb9+2WIcEZMDhsRtluSoGxmrsSxmZLEKFca2P32LFuX3r6N7uwJoGPPpBBUDWY6Fm
 85qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773360398; x=1773965198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuLpHvR1fwObt/8Xvj3rrc9Oc9+CrLWMV9LCtsBGyrI=;
 b=aAbTK6556PUywKpXAy2snWPDKB4VwBCGp54wxVAuebMLAj0/oeVo6uW7Opg9t/llnM
 QaRVpSgcufSq8EsgdWhllacuQ5rp01yI9MRtKfFq8t2DYri67nX0FhxnRIsGnedglXZT
 zNCPu8a9/qUTW5+oxQU7tJhruytfooY86Enj7ZaWo1C3UKPXjlcrnftSGuGgc0cMChsk
 Lm1IknCOHGG3MocpL97cupPSd94U/cSOEwQv9++ILQ9YFlmySV91g/VB8GCs1qneRs4r
 HhmzJTwviOn/RIjlprNzD7jmiFKnw3hhlp3PDurznkdHvPTXw7WLT9QU7d8BsF4tGXVS
 A4Og==
X-Gm-Message-State: AOJu0YyD0+a/5A2XU/7/kAsLs9z95s/1p7ZmXBgRYZvGltzykU+l3xMI
 ltcdCBmbVETejYl++cTF0xC0xRKEjozVuOOAKbPbBRdfpczGUAM6HENNACnoCRQS
X-Gm-Gg: ATEYQzzp99XAKM8hwhXtcVhxXdmTyeYXWIANhh51MDbWTyMLV9BMw+rKIH6ftMW7U8q
 0HYFuOm/oObKDr44oefsxCJWSkiozbFE1KBqEiepRyYqT92fYH/fIdClstVrg9DMACQeyqFTntx
 UxC21+sIjRlAH1I0Fm5r5YEtmQIzwfXd0eP0ykRE6aKh8LobbYQtwtIzRsDnz8+/nXAQFUfVfgX
 H1jph1jWmNkWEDiuWRtYt8vROY8g0sK3+kVAIx7wbbhG1tydaBlBND66JXkPvXP46AntwhgZ8+6
 +ddURNlaNc4aEzBY65FOD/dF4VFI8o6pyMpwz3luizzLKXZ7bKGy90opARMk29ls4I3W5tB02dU
 06rEOys5M73Zr6GJmYmwQ4Tw1fc9EGc3zKfGx6ShU2ZvN4n5omWvCeVho6i1qCh48xq29bGgpaf
 f3TdpUjVzqe86KHyzgaBs9+w2Swz0L4xLea9wgtUPsjDZ/vgIqGRoJyw==
X-Received: by 2002:a17:90b:3848:b0:359:f2e1:58fc with SMTP id
 98e67ed59e1d1-35a220cf0ddmr1186924a91.30.1773360398558; 
 Thu, 12 Mar 2026 17:06:38 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a07f0a365sm6192261a91.13.2026.03.12.17.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 17:06:37 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] drm: property: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:06:20 -0700
Message-ID: <20260313000620.117065-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Don't allocate values separately to simplify allocation.

Add __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/drm_property.c | 14 ++------------
 include/drm/drm_property.h     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e6..a6008e5c2b58 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -107,25 +107,18 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 	if (WARN_ON(strlen(name) >= DRM_PROP_NAME_LEN))
 		return NULL;
 
-	property = kzalloc_obj(struct drm_property);
+	property = kzalloc_flex(*property, values, num_values);
 	if (!property)
 		return NULL;
 
+	property->num_values = num_values;
 	property->dev = dev;
 
-	if (num_values) {
-		property->values = kcalloc(num_values, sizeof(uint64_t),
-					   GFP_KERNEL);
-		if (!property->values)
-			goto fail;
-	}
-
 	ret = drm_mode_object_add(dev, &property->base, DRM_MODE_OBJECT_PROPERTY);
 	if (ret)
 		goto fail;
 
 	property->flags = flags;
-	property->num_values = num_values;
 	INIT_LIST_HEAD(&property->enum_list);
 
 	strscpy_pad(property->name, name, DRM_PROP_NAME_LEN);
@@ -134,7 +127,6 @@ struct drm_property *drm_property_create(struct drm_device *dev,
 
 	return property;
 fail:
-	kfree(property->values);
 	kfree(property);
 	return NULL;
 }
@@ -447,8 +439,6 @@ void drm_property_destroy(struct drm_device *dev, struct drm_property *property)
 		kfree(prop_enum);
 	}
 
-	if (property->num_values)
-		kfree(property->values);
 	drm_mode_object_unregister(dev, &property->base);
 	list_del(&property->head);
 	kfree(property);
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index aa49b5a42bb5..8c7cef4418c4 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -175,14 +175,6 @@ struct drm_property {
 	 */
 	uint32_t num_values;
 
-	/**
-	 * @values:
-	 *
-	 * Array with limits and values for the property. The
-	 * interpretation of these limits is dependent upon the type per @flags.
-	 */
-	uint64_t *values;
-
 	/**
 	 * @dev: DRM device
 	 */
@@ -195,6 +187,14 @@ struct drm_property {
 	 * enum and bitmask values.
 	 */
 	struct list_head enum_list;
+
+	/**
+	 * @values:
+	 *
+	 * Array with limits and values for the property. The
+	 * interpretation of these limits is dependent upon the type per @flags.
+	 */
+	uint64_t values[] __counted_by(num_values);
 };
 
 /**
-- 
2.53.0

