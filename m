Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ED7CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC5810E284;
	Mon,  5 Oct 2026 19:18:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TP4Ghyoa";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF0B10E284
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 19:18:58 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1146297a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791227938; x=1791832738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bn5bbgyZyDecjZPI18WaWxFgg4DefMuMpoggO6iLfzw=;
 b=TP4Ghyoani9nKjKXIaCLKRHpOG6BzTw8voRZA3DLVNrFCEodpWELG7Yn0DspphFhKO
 +hjdAlc2KVDQXmrDInvbWF666g7nDemfvIOeCVA/bhH19I1Rwr0BzDUwOtMnuOrKtUcp
 Ygzib9Rs64aU/3sd9fyLrWBRpOWGk4KGEscKx1POhaP7Le+aoRMnF+sNULska5xlCUpx
 cxvdpmnEBk8KETWoSEWy3X64Xfni8nycuLDukdJm0Kx3ZCrbCHs3XvmQmgruMS8W+kTT
 O510ACjvZIatNWSXtluXrs4JgqDXwbX0B+GRAX+5wP8cpxXZKd/JOP9oDe4/nZyz1Odn
 /8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791227938; x=1791832738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bn5bbgyZyDecjZPI18WaWxFgg4DefMuMpoggO6iLfzw=;
 b=tcAqnnY6hh3I/Q1ht9STE4beLyeNkKA2ZlUNd6iwuf2mv9MU48sW3R5hDeVGcjeu3M
 p8r452WAxhMaF93V6H4PJyHfdAfBjb1SQpyIh3yWgjsNrSKDR03WJv+T4JCtWacpdEGN
 n2BRc6rjJYvDaZqwsSKWA/VEPkNqP7NXIquq+znoIZu1kIkQRRpdrhTXWZVAlriAi7HO
 Qa5ZqEdg0SRrxJC6xs7uVO/MrO16LWb8IkrjciiM0xs/3rgo+KYHUIvwVy0sBnaLyJZE
 iB0lnOUc42Ujs52jp9nvT+YjDdnrHsR5y70Nbak5klbs3x4Yy0x3Q6MplSJ6364v+Xy4
 zQ2A==
X-Gm-Message-State: AFq9FYIsNrfAP8Med5X91/wh36pw+qdRidrerD9UInDiMjubvlKG5739
 KMb+1Ql3orA+ScYI2WQEaRuvs/cly5BBMBZixlEEvSxek3OR5G/X2zy8zKVD4gowSYY=
X-Gm-Gg: AYBFou14DOJGqI7CDGBA4Qnd14VQkgjhhbwWcYqqoCpRsanJCMpXN4ZlJ+XvTJv/qg6
 pgx57v44AQi6hn8qQYJiS1uY7Qu589MrM4OhxHTWVxXKKjD1i+BYuPoRk86BratbGih4zxVLoSC
 XScapwKHDTIvGe8kQ5uiKJL8akDK9HX1A0pvcqiJbsSZGhsxkGUOpEEDi5XOBPrrlyxQ1qDC/j8
 IvU1vsUFcWPgDrfJWmKn5RENp8ivj2fDMkOt4eUPQjRHbYAw5dluEhQZDxjg9UifsCm0IV6iKJm
 6MK8/HJyObUbpe1NK9yan7tV6Cyc5NuBriB39qmG0GZPK+QKjGlMHgMnTKa8zDCixH3gTXt3LBf
 boKYAXYmRlOBOiu+QQEAvVJiQqxtkozDdz4oz6LF7M+86/NMJ99T0JV5o7pcecyrGGQujzdp/Nw
 YxXg9ITdCAHDCsSrIw1EChJZNoe7UJSdkdoR5qupzcQVcuFTCRq+3rLAemTL13OjDgzwCF4c1kO
 V/tRFqPzxa4vm98PJP1Ox4RJId8cnQbFRlDXr83/kswi9IImocHBMffKtx7LIVhvUvx0ZRoK1Qq
 y8M7KVtJk/7pyalYHbJyybFb7JnIFPIZpEYrJzPT8Ej2EdE+
X-Received: by 2002:a17:90b:3843:b0:3a4:fa1a:2b1d with SMTP id
 98e67ed59e1d1-3a6ce983720mr9469973a91.62.1791227938253; 
 Mon, 05 Oct 2026 12:18:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a85436a39dsm806267a91.9.2026.10.05.12.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 12:18:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v2] drm: property: use kzalloc_flex
Date: Mon,  5 Oct 2026 12:18:56 -0700
Message-ID: <20261005191856.90267-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Store the property values as a flexible array member instead of a
separately allocated array. This removes an allocation and its error
handling.

Add __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

struct drm_property now ends in a flexible array, so move it to the end
of struct drm_damage_mock in the damage helper KUnit test to avoid
-Wflex-array-member-not-at-end.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: move test struct member
 drivers/gpu/drm/drm_property.c                 | 14 ++------------
 drivers/gpu/drm/tests/drm_damage_helper_test.c |  2 +-
 include/drm/drm_property.h                     | 16 ++++++++--------
 3 files changed, 11 insertions(+), 21 deletions(-)

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
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index 0df2e1a54b0d..c0da8dc591a9 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -17,10 +17,10 @@ struct drm_damage_mock {
 	struct drm_device device;
 	struct drm_object_properties obj_props;
 	struct drm_plane plane;
-	struct drm_property prop;
 	struct drm_framebuffer fb;
 	struct drm_plane_state state;
 	struct drm_plane_state old_state;
+	struct drm_property prop;	/* has a flexible array, must be last */
 };
 
 static int drm_damage_helper_init(struct kunit *test)
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
2.56.0

