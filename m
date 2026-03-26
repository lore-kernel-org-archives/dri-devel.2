Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C60A10AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648F310EBFD;
	Thu, 26 Mar 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PDmb2Jfr";
	dkim-atps=neutral
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EF110EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:48 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-466f00535cfso786291b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551347; x=1775156147; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biXThcx+6w3P/qlWl1X8ZrrgjPyfHSHs7iDi6/iglY8=;
 b=PDmb2JfraHW9Il9HUg3usmcYqcvgTW/H3L5S6xblDzgyrM1QLJEeBL6L+G7I52tCzT
 Duey8e14omD7DO4upl9FUjsBc8H4Hww4lXPL0aDzFckBOvDa80Hflbwv7qKIKVO4TeqH
 dRaEWq1wu50sAyQt+A+YuAtBQ3QrpepwYftpibSFMz74MbRCKqzl6M+QFMWlHMflZ9kC
 wNZpPVjsgJstWhgP3lKIetbrtqNX2tgqlQbl12+gU7WUUtdRDnXy3eyTlmRdzdM1rE9S
 TWIYv2zUmtvvbm7LeEGrLmboT966CApc5L+XDf6oAVfW6n4tolH6BbG7RuadWTGFalGz
 ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551347; x=1775156147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=biXThcx+6w3P/qlWl1X8ZrrgjPyfHSHs7iDi6/iglY8=;
 b=TLpf+5hR0akByDCiWiIWD4pDKHWUw1gCKF4QanDzDDLrXzvcWSjKLDxLXJMQTA8p9M
 ABwjXBpUiEHrgWhW1J/Q1rmQaCtKx8aXa6L7sBfnVqc8yhMyqJ6bgVsve9KlbfnvqGee
 ZsPneU0bmb6tfC/yOXaO6zc1sQ/0oB5joSokpcnrwwEH2YTgrJye7mgIIkApTuygBAuM
 N7yE8/GbhlhHXuwZ8ye+3NQjd6zbo9dsZO633EuolexTjVvJ5RyBCcfvRrrewC5k2Ksu
 7PpWyYQc3DYCb6moHkn4z96luTilcCn+PinFhecwx7aaSTcM8eIU/1HreMVX5tCvwTjn
 UrVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Yy9rv2w6fdxGM0Bk9/tzzxm7g6xu7ERapcVG+X1yquuAeqU54hI8snr9xZ27JJ5UysZuSI+mRcQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw284Iz6p0gQppT0svWeWHWiyb7fs4YNMlIJLI2yXlEPewmMyN6
 vSlt3jxHMuSXF4ap2xbapnOJ7JRoNRcZkXF82Ro7RTGzmMU8AxzXK75Q
X-Gm-Gg: ATEYQzzX9JMx3itXR3OUS/ZQUq9vIm0X5gK7t90CyJQQoIcKSDYSZpTRZpregay2Tiy
 CjHgR00YV7bWI4EC3z2RWuiJSfM6PRh2Zomu06Tgla9anHwynvtHepQ6w5Oee+0W2Yn6WyJZfh5
 75w8Udkl2xTT4t00OU645ZObW3M5P44wNXsmmN6S1fg/VVQQ7HGBTeGIfGYGhEEUykkIdWBQYAQ
 5TaIlI43/jeNpe96zv9GPM7k9g27zMKQyfQ4r6deG8ihdKKAGfb3RYlA8kt0uTermuUB3YeF2mG
 2Wx39PvRZCRn48fXKOiQOnFf52NnPAm7ApKTsWhmVXiSyi8aGdFMVNviI6Htn+wot0nIU7RBL7x
 4OQzvEgoMtlN75Wr+oBv06h4aEoa/oi+Ap2zmF0s/GgEQnaDK7ypEnP4q4hw9QyHkwZWXoFEWeZ
 SKm6ywEEfcMP2C897YPFrvebT/Y4uooW2fEQ2Q3Gn8bHHCXs7eGuFbLP3lrOs=
X-Received: by 2002:a05:6808:6714:b0:467:58e:5d6e with SMTP id
 5614622812f47-46a5c71bc54mr3926380b6e.30.1774551347410; 
 Thu, 26 Mar 2026 11:55:47 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:46 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Lyude Paul <lyude@redhat.com>
Subject: [PATCH v12 49/69] drm-dyndbg: DRM_CLASSMAP_USE in nouveau
Date: Thu, 26 Mar 2026 12:53:53 -0600
Message-ID: <20260326185413.1205870-50-jim.cromie@gmail.com>
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 915f73279302..7f7c0cc1da64 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -74,17 +74,7 @@
 #include "nouveau_uvmm.h"
 #include "nouveau_sched.h"
 
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
 
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
-- 
2.53.0

