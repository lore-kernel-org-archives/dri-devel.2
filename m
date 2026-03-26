Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66DB10AB803
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5C410EBED;
	Thu, 26 Mar 2026 18:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRkNoAg8";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3523110EBE6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:39 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-40f1a1f77a6so940023fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551338; x=1775156138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4VPaN2JxzLfP79BRo4ZYIGptPdGN0vKlLM6mj5G4BY=;
 b=IRkNoAg8SByesDEF+uk8nhT05MlMq48mRLLLsGblUY5GKiiWnp4Ol6/A2wsG2m9hQj
 5XzqXhjE4yCXmQwIFQAsKqZdne46cjgZth38hj8DST2t0YXaWmFE4DkkOAc9bj+leXBf
 DVei8oAFE7P05Douo3mdX+ffyiLmduHq2+B8PQylqQssryBQRCzF3E5wFY3PO7K/+Q6H
 RDjpvbzZ3YOgMzdgar5ohcx5RGO5RI9HJGSPAbaJ+BkNi1yOkce1bbfZG/V40gySLxBf
 EyR4FuGy9LSnv5jP8fYhg+1GLeMKqZAS4BS6ekWX0i3kT6fBEKm10SMboq29yXe+aMJI
 oAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551338; x=1775156138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b4VPaN2JxzLfP79BRo4ZYIGptPdGN0vKlLM6mj5G4BY=;
 b=HogxuIL46ytmTUqFB2ixoIAeG9S+iqLca5/wY9u8AzUuPulN/fsKzffFIsjKltTvCd
 W5Fy+Pak6WJgJOejgfKpKGDRsVs+aTFbAjmXgedL/NW/8LyJGeXHo57mDGYYFvgqNUeJ
 hZpVdX0L/CSdm9l5yoNVisvXT2Nppw/qQs1Avl4PUA4v6gvVVkxvevOAQddvN+RuSy44
 2f7dCI//Tr4IqCse3+zQe2QH/c+ln2J+561fPCs/kTpaQhD4R8aFkWs9on6H7RqOSSSm
 1GhFHC0ncfuxtNOthEyxJ5WN+9ltNeyDH5nElminFwLhnytlfGOs09GEPehXQc64ag1B
 sXrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8PkN70NWZ0q6cTSo1KnPL8ZQWNffVjvnMEdI5RiJgcZQxWLB7ZMvBFU+gIlP/oXzgAqBCyGC4iGw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKpfPTwPB+S92hG1PW5IRam59+fMlmwicNdrN8sUtDfSet/LEg
 JXyX1PkEFHBFooB+fOEExQOZNQPJFSyqO6zaX4NCPGGsk3BSJnAYZseV
X-Gm-Gg: ATEYQzwgZljIImx/gg7nW7pwKEqP9R5Q64ZcYL4L7/kvKel29kxcT70TxZn2MXYLXX1
 tx8fx+xsq1MFPvc6WQPorQM5rNLCGaurfGyw22c8AhBe4Zg3V2p85MMASRbKitEjo6qgwHw98i5
 joSy9w5N1/3EDm6QK3LLxq0ZF+PUUOU/WRhNdvLlM3pKGRP/dXtW0spjcqS+fFp/WNt98dd+JsN
 tDM5Owu9e9C8H/qw/mg3YlX3+TSe/oZeENBoS+pQxH3ioTvBSm0OnTHFm5O419xe/wFgShUF4Ad
 ds3V8Orc6YY0JXa9zoPRroBsgTo0+XmV1L/u8mefHwocMCvIT3rwgvn+zqmwKvSB2qHnPv9/Y3v
 HUv16aDjf10Xas6PcGCvxk4Yh1n7lvyjH670QgTxRdYJmBEr5+eo9IiNVAeVlNb/KkvL786VE+q
 0JQVhV0GO4SnQe49PFIsf4j6oglamxLSNz+X3irdAY9WI3z9YP
X-Received: by 2002:a05:6871:4604:b0:409:95c6:f2dd with SMTP id
 586e51a60fabf-41ca6e9ff1emr4767565fac.22.1774551338399; 
 Thu, 26 Mar 2026 11:55:38 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 43/69] drm-dyndbg: adapt DRM to invoke
 DYNAMIC_DEBUG_CLASSMAP_PARAM
Date: Thu, 26 Mar 2026 12:53:47 -0600
Message-ID: <20260326185413.1205870-44-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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
index c0ec866f31dd..9cdc547e3f85 100644
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

