Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E4105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9655110EC19;
	Fri, 13 Mar 2026 13:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RHqeQIaI";
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA66410EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:23 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-46704177508so1465806b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408263; x=1774013063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=RHqeQIaIWe1JqhhrXvX8ug6w/Q2CufFrX51kU/fBLeqBBLuoNvzOxaSgHBvxew6cB/
 K5IyIEGOvQ5TYToxsDutQ9L4kbWKfFFf2AklK2dC5vnk2JW9tY1DOda0rpYQ1+Fq6pvX
 6uerzeDB3YQhrLt/8481YkSWN55ufMzep9BnAm2bK0AcSFVm5kgthW+grT6jSAaMux0J
 fxSY93WxXVuJEi8HbiFXrFmqO6W/ZZXewt2BcCkdzATnRRmioD2uvWfNipyY3ZaaSvvd
 KFCzY6+VO9MM2DE2AQVvINmcKRUTCgHOa1sauKKZ6MZG64kNiOfpbGdJiPyKOb4OoLLq
 ypSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408263; x=1774013063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=irTrrnawNz+DXC6VSfC9mZGBC+I85t9C/e5XGxZ5eAQ=;
 b=f69RBFj904wUVQYXjvjh5+AKNtBKwmTmiPvkxZFMYvbh4/55ak7EwNAvsgzXXUy90h
 EyptFvTW2wHuOeGWqEaCzsolGCwOMGgDxLdta3oT2H20LF0tabhz2zZlxltbmOzLgNEc
 ZjYuIXCJ/QrPkYMfgX+Dmya2Mke7pk8/bYNAsblFJjR+XtIyO4mujOSaYzpKYtad0Aen
 5U4PS8uKs+ZdnRq1A7pGDIA/TzrOxSboq3zb4mHaxrs4Qo3XT5thJ1WTQKq0S936+nKr
 r5XaBh1bE6ifdXD4jGG1lJWKztHCCjWh9vbJbOVxYhMUgyMkbh6XFCMGB2mW/rp9dyS0
 f3NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWprLYcIAOMGR/eqyh7eLSwCwq4GQ6M19j6jiknnXrGOfD/+c8UK6I6fS+eAv3+HPSu3PNKab2IwTQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywctj7/amNoDAh+pibunNKaR0pdi+9uU29W+zbExzhcxXFm4zmx
 MiY/L/jHCbiJHEL9Tuy4Svw6S3W+i/ta9tFk/3V1HwuDjvJ5dGsxszsM
X-Gm-Gg: ATEYQzzgEolm56NfrPf9d4+iinHsuUCr8yA976+1fc7wRI8jPonbh6IM1n+diwUuxXu
 tdgxUoYMCen1I4OFL5EoyNiQOJjYRFYr4v7HDlT/nZFKbtdTyvECMGXLluknSxZhx5D8/qlvTjy
 94N6NLr5EXOA1HThJpk8VLLWCSgBoZ7XFc730mWejIVGpQi/d+0l35Dzn0UB+K5bVgi6MPv6pbE
 fnxrm3k1k2z7tF9jBJ6kIqJh1y/EwBp4OvgjtixYDrqHdfTILMKDbilrjIr35wqrFa3hgktp7CT
 BfSFYGc08267okik+OgDmyZr/baWm4jUd3FvVVglD6bsQQWIMAcvsM1xX4k27Mh4uHHi6JIkteI
 Lb9R/2toOsuYAD0Opw5JSHamG1NPD/YCoF0wq3TGScbwQus8yom179AiYHdK6REIolaCJkGXD+J
 iXMCQQCgkNxoHfUbcDT6n6jXXXIa4ivIF4t+nl0zcAaOJO10Q3
X-Received: by 2002:a05:6808:302c:b0:467:4a7:e3f6 with SMTP id
 5614622812f47-467570efaf8mr1550885b6e.2.1773408262974; 
 Fri, 13 Mar 2026 06:24:22 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Jim Cromie <jim.cromie@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 40/65] drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
Date: Fri, 13 Mar 2026 07:20:05 -0600
Message-ID: <20260313132103.2529746-41-jim.cromie@gmail.com>
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/i915/i915_params.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 34ed82bb1b1a..40c5e0014686 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,17 +29,7 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
-- 
2.53.0

