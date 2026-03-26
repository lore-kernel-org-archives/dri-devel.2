Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168410AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C3E10EBFF;
	Thu, 26 Mar 2026 18:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PrvLVlSz";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2270B10EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:11 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-40946982a78so511897fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551370; x=1775156170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyf4ilrW4GCVGVmagWACzMec5+WgfPealp/jm9A7WHo=;
 b=PrvLVlSz6yV6Wz7KbPU8wq3qlUwveAxdzvE0PxxRnjEfA3qep1cO1j+kJPhg/69WuS
 MZHo+n6jHPFTFHkQtMwATflLMvcAW7x4dKMJbMwCyNssK7tgUwvytp1+u4sOeo3irfCO
 9am9OilhJC5Eq8ZQuziU0B61BrNw85J1O29Bpw22ZM6UWXsIxlTE6RNUy5DOebCeg5aO
 YlQbfj14UfREwBP5lMx+Pefb+cdkpMciTidIu52Kjj2SNz00Zj6iKHhE3CYSpf2+BPtk
 InET7UlJyot48FJxEzYZp8d7aS1HZbyUm/ad5apkWuoYKiHD9QFPgNuHpccj/NElqXCh
 t8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551370; x=1775156170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyf4ilrW4GCVGVmagWACzMec5+WgfPealp/jm9A7WHo=;
 b=hmTNHdnLHCKzFO3UcNSANVQVQsWKOsgpHFiKfxx0Jw+Ycobhwp21SvlG8kaQXT0azF
 TfgDeA5CqV9zFS1cURRNZX5F0IJd0mqYAk/efMlDcQkpNmb0WVOnOFhz7nQahxFn14rD
 yEv3bIRTr0YYBAlJR8IXLuaWAJH83HgFk7GaFOg6ey5bmvhvF7Kgx+IO+AgiMR66CH3O
 P+JAKrYpZO8SoJTCTCyuA58O2yZIZ7ZAHaV7hLLVdwSyCrk3ThclyvqSdwMPCuWreUS7
 MMqhChEzK21gfinSOl2ijLqgmDfElDyVdHiIdx0BlUqKd2gCYTC6LkupLa1tEcBWq97v
 RoPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwyLPZYRYf5M1K78amdWB9CoKLKEOWw0IPCJ19RCSLvNt2sLDVUID2r6TLSmkjglDXyoKRqoBZXIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ4ER1LWDvQRYs3pYAfMp8DiNGn6pyOXtWw+DxAKAmO4RpF3at
 Y9vhK71Zk6jEMJ0FFalejLX6ZAtdme8beu1HjW/ORJS2+jKDlOaZGmm3
X-Gm-Gg: ATEYQzxbN9r0K2Rw8KxAsrrKwIUUPfLBOwru6z8cjk4D7VJHAP39NeSqK1aP/QzPqHK
 cEJFxiOTfEOTzu272WgBNun9rd/o2lXcM1VYTTVMlFMDi/Bb97gSqWI6etW0NwQpPddeJMwwefs
 8PW2Nhxn2j8IZRAzBEHFSR70bN6gCQAIM/Fy7wry7+LALrW6OGuslAkc5GjAtLYCJKl7hJ/1LEz
 fNmvAvdM5bBv/r1pOpindiWTKLhsQM+gwjiK7F0LadLmsFDZy9mS2e3emS+khIF0erOiykXG+US
 FaLu7Ssjt+OERcGWosWrEx4bPp04tp8JAytDJshz1mBwvbUxTZ7OvEK9VEj6u3FZDyMKVnxtoum
 2x/88O7MRgWxmIQfBxTr1m06xcjk/cGj6PJSaTmEIP3998kHwaiBi0kpqQlmbA4d6GMA2RVzLyw
 7YENdBDwlToLxgBLA9YZCfv/Z7PRqMlxG7hDYrusspsK84rGFn
X-Received: by 2002:a05:6870:8e0d:b0:417:1bb9:c00 with SMTP id
 586e51a60fabf-41ca6e3d581mr4428868fac.20.1774551370328; 
 Thu, 26 Mar 2026 11:56:10 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:10 -0700 (PDT)
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
Subject: [PATCH v12 65/69] drm-dyndbg: set CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Date: Thu, 26 Mar 2026 12:54:09 -0600
Message-ID: <20260326185413.1205870-66-jim.cromie@gmail.com>
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

Set CONFIG_DRM_USE_DYNAMIC_DEBUG=y by default, so its easier to test
with less config fiddling.

Note that it still depends upon CONFIG_DYNAMIC_DEBUG=y, so may not be
automatic for DRM-CI.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index 6c83b1276870..6d17868b4c80 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -1,6 +1,6 @@
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.53.0

