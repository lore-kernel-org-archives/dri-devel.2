Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B6A105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762BB10EC14;
	Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X9EG3PLv";
	dkim-atps=neutral
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4B810EC19
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:27 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-466f00535cfso1535173b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408267; x=1774013067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=X9EG3PLvOe4GO64DveDUusZaefG20nQmIx3gGO4NHIwYcvWr26WpSomapCWxT6EVqq
 YeWRXjaywzLzXnRPCzk/3ZSiWyApWO37gJapytOWvSy66FVPToDM9ZJSmEHyX65D7LOK
 s57ihHYk4BgXdVA1CMG6XtTO8qsBsG21QsQYCgbeo7Der2ttxLhSJ/GTGFjhOkxuFJU4
 4Gm9uS4Gx/oymRJvb1fuExvzkDbB3R3OgI/KmNw6KoKeePoPHuNT4/a5f3k5pw0+gbzf
 /+yAsgRaLXH0gld50QK+S9otnKExufEP8NnQYHQW7qLVZV7hVWTn0rb/Smz7KU1dJJTM
 9qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408267; x=1774013067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QuXW2pVB+6BOeyoEL7PCyteLSTsnkRNE1etSyCy+RQQ=;
 b=X1wNTGcj84Q71nmojrTzjpFewhCK3b0tgu8Azv8AHJ3JCrUQm9+au+e4YyIvAcJe30
 RI5IEDLWls0/nS008hoX3HSFdIlGoIDXQUiUZWeZbPsS2tEF/S8bp5R0l/36QtlTem3X
 e2+azzeBQFYlfUoy+xWVJeZUe7LBvzwmpY3sMlissCBNXfBUPCLnYJ15qV+ERi0Hqns0
 2RI1+2ZdGOIEhPvwQFCGyUbvGtI21jFT+8vVk57EewGzpFnGqDSyYsjcM1sUe4l0C9BS
 qFaAIMshay3B+INX19+dCH9Wa2s18Qplc6MWrrTcwjPcC/U0H9LdqBGbZrP+K6G5Vsw9
 V3Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIzAB4WZl4jCvYMaD7FFwmm8IylNff2lFXXYIjzzeMT7p3jloPbSKv1tTm/yTi0TJYDHUZtDmfq+I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPzFEUL3DU28F/OrqejAoCaXZ0TSFnwrlE3OtIOuF6yvLJe5BE
 MDJ8a8GVZmlkZvaGlV7eAXYESldB04DrnacPeZohchpKmEm//PJHppOZ
X-Gm-Gg: ATEYQzwkRtbKB4wUDg6dy+AfL22JE2LC2VC2pdya1RSVQp9lv8fbi7q51Ui8rx+XJ4a
 YUb7k3UhgUZTlwd8BIGnaw026+jW3/RNBBUkyFXg4BL0/ZaDKdvVpmK5IQvWPQN0RHNB1vAQWIP
 7yaz03yRl4xv0Sl3u8jaTOiVVGX55236fkLBdlosU/WlBfr3WljTdqwZ5wk4bqHKbtI5wE6xhtr
 gEZaUueR2LHhZ0moYkkC95Qyr96fcAob2XYLRdmvI8uZpiZZuUFgYOvUpqLXYImbQF8VilW+CRE
 L9cKLEoKS5LD9lMyCLsQDoXazXRC5zxGeBw43BALMkGKfWx5EinhuTT2012B/VJY4g7t6HzQG9z
 7e1cdE3CecdxR8i/8x0DRScVPbuCbxW5BwtHE+yfJGNAE1mfrDyZR+1QqsZQBLs0fnshmDU1Lnf
 SmSyHxsWgIB6EGL6+Y403UYRa7CcVSH0yLpkd3BWDpS7HfxR02
X-Received: by 2002:a05:6808:2392:b0:467:d75:702e with SMTP id
 5614622812f47-467570a0d7fmr1650516b6e.6.1773408267013; 
 Fri, 13 Mar 2026 06:24:27 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 42/65] drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
Date: Fri, 13 Mar 2026 07:20:07 -0600
Message-ID: <20260313132103.2529746-43-jim.cromie@gmail.com>
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
 drivers/gpu/drm/display/drm_dp_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index a697cc227e28..308083e244d4 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -45,17 +45,7 @@
 
 #include "drm_dp_helper_internal.h"
 
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
 
 struct dp_aux_backlight {
 	struct backlight_device *base;
-- 
2.53.0

