Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C996A105F7B0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AF010EC10;
	Fri, 13 Mar 2026 13:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bbdlu3v7";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF4210EC09
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:15 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-464bba3a9easo1493809b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408254; x=1774013054; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYpsGA69YUPtgoC1KVPx5M4LxWSwSB6685GdZ08v/j8=;
 b=Bbdlu3v7dBaNu3JMakwuR3cyckp0f8rpJCpbGnSsLTwFBbZ3G+fr5XhZ+3Fae+13jn
 k8ON19LvtUQvx+lCarhI1cagUgnJ5VoPRhg5bgKVdbS4WYPYiQ9u3AK60mYSgjhM2sh3
 HC0T2QPdc9xTNtU5c4q4J3UR4cFboBfgrArPJ365JQ8CuDTrbzOkkxoENzZlPfovdI87
 4e3SWBEXJGcWkcFJ3fgnvPMI4Uy0UM3tZd48zKyM6dLD4wxRHldpqXG7R3WUdq5lEXWE
 1mUZfHN/dV73GkaFlymB80i4xTwOmOaHZAbcQIf3lga61FEgSTuWU0iKlw/996o4OuFc
 bULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408254; x=1774013054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eYpsGA69YUPtgoC1KVPx5M4LxWSwSB6685GdZ08v/j8=;
 b=UXoXBbyt70B9aQCOEQ9fKTRn6nbIwxf/LrWnjvknf2tuJOLqq9hTWXHqD1OXLOkcfC
 zvMcf0EpwCwRAb5v/OpPjNUnHGsTWo0tMKJ2YY3Nee2tVX6/mFGXe53xG3diZE006Wu3
 NK56dj7RWwDbq2V61jL+NIBJgl5aK2WWh5MUzaRmI5A4byviObU2GF+UzeDM9D5A8cpd
 sMYFLz5iNr27pt+qpl0qO/LZO9uwyimmJqioCkL99ygg1IswWICWdzGx09Lgak5ZfWg1
 gfBsRA25tZmZF71tIuNO15GISjFuwFcvua/iwZWnnYSU4ZcZBBEDRk9ylIFzA659harJ
 kdXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHnucpptqksgPc9vCYVICKu8JztecPKN7o0/DXvMTBBgVQf/aS4/ygZDbf+0W4kUjSdA/DKFXzQPA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDIcytq9iu0A9UnQK+qsC2hZKCXOW4FeTqKPSmYbBmKqhN0Psc
 alc6HSuQFaxwZJ0zllek8T87Fh+jHD1uW2mr1orRD0ZJ1I8ikyRzO2qE
X-Gm-Gg: ATEYQzyw9Pxck87rD9ORXp9OwLcebjxgcsMe3S7iI85SqRlVVmh2hYZuNjjN/eNthfv
 1wiK7uaKyVaCm7X/sqSRtYr7ZA56c6kkzxmXLLfu+Y3tYSG7QxL4xnTTHqY+QGMiet++g1JE6pC
 nLn67sthH51ExUoVpfBGFTtx2havCZDNU2KW6WyilKpBwbp1lWHfW/O7NzuE8qXRDW/b9LZBsoo
 KCfeL9yTFt5BvdOsihx0pGBCsETC+EpferI2LIC6WBxM3KGz9OpcrZ5HdHmWt0RCpR9K2dfd156
 /kVUHlAWdyp3lP6HXhnIYODvx5l2hTQKmu/0oKG8/ht9oT68UiQX7NleOOU8jNNsUHaG1Ax8EIY
 yH7VvBiz3aF7kUefE4j/R8wWFzhcKRAIXelmTGY1NKEHkvcZQn8EEEOUNfh47jxwU6FphO4avS7
 sF4tO3s9RPVnhQeQcyRZT9uRC3DIOFHqKErVMAd6ONdtQWtdtv
X-Received: by 2002:a05:6808:191d:b0:467:32c1:ad08 with SMTP id
 5614622812f47-467575feaa3mr1733147b6e.56.1773408254397; 
 Fri, 13 Mar 2026 06:24:14 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 36/65] drm-dyndbg: adapt DRM to invoke
 DYNAMIC_DEBUG_CLASSMAP_PARAM
Date: Fri, 13 Mar 2026 07:20:01 -0600
Message-ID: <20260313132103.2529746-37-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

Invoke DYNAMIC_DEBUG_CLASSMAP_PARAM to hook drm.debug (__drm_debug) to the
DRM_UT_* classmap, replacing the ad-hoc wiring previously doing it.

Add DRM_CLASSMAP_* adapter macros to selectively use
DYNAMIC_DEBUG_CLASSMAP_* when DRM_USE_DYNAMIC_DEBUG=y is configured.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_print.c | 8 ++------
 include/drm/drm_print.h     | 4 ++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index d07e7953c9fc..93dd714d4533 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -70,12 +70,8 @@ DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
 		    "DRM_UT_DP",
 		    "DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
-	.bits = &__drm_debug,
-	.flags = "p",
-	.map = &drm_debug_classes,
-};
-module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+DRM_CLASSMAP_PARAM_REF(debug, __drm_debug, drm_debug_classes, p);
+
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index b743ee3f8f5e..94064ec6c229 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -147,9 +147,13 @@ enum drm_debug_category {
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
 #define DRM_CLASSMAP_DEFINE(...)    DYNAMIC_DEBUG_CLASSMAP_DEFINE(__VA_ARGS__)
 #define DRM_CLASSMAP_USE(name)      DYNAMIC_DEBUG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...) DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(__VA_ARGS__)
+#define DRM_CLASSMAP_PARAM(...)     DYNAMIC_DEBUG_CLASSMAP_PARAM(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
+#define DRM_CLASSMAP_PARAM(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
-- 
2.53.0

