Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333D10AB807
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B57510EC11;
	Thu, 26 Mar 2026 18:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dWXrGn4C";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68ACB10EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:08 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-4094b31a037so992672fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551368; x=1775156168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRlPoGa7+iUNjeM7pxa7WPegOcsigZPqzY0YzlOOctI=;
 b=dWXrGn4CdyHwZe36ORUcenyNT/PfYW0BtBDSBhycZvEz9R1BLsWFAW3zzu6I/HcIOF
 sZm4wZVk91lMabf8MlEO7eOTOu9SInbflgjyBRdgCIf4IDyC9GGe0wjixfgBJrpSKVRV
 70idqofDDxSbdPvHqJfo0jE+69L8mBUj7jetGFB3z7hagGgJnbeR9iJKvVMA19KzpE7W
 0CKIMhdfHgFEfsrsHkgN/OmoNxi/nkfN+hGP8yp9xR099LuNXgbqOlUZReKaYczashLf
 Zsc4lr1adWPXdEs28eRo/DxKiAeW/4hWs38wFJT4lFQGVTGWrmw84xFXDrBLLPH4VH4b
 9yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551368; x=1775156168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NRlPoGa7+iUNjeM7pxa7WPegOcsigZPqzY0YzlOOctI=;
 b=GVf5yjfATl+VgW7NVucy5A3txH9K9ruaNkOiZl9oKqNJiUdqQA2Wzkbsc2I8s0tDli
 TsXPN3QBiIDGMFlGj05z3oLGB3ehJXJxprX45bwiH0KPwUM6u/ljAtm64WbqkjOcdaPz
 9YViJdF6ZIOum0NWWp3HTw/gYXkyGziNpNzNvYyYv+PvP04BaZI6UNJw4uTvYCmWcFQ+
 MW2et1wesFtT9774sio7TJLTPsAmCxuUT37p6a9OHrt+89VZMlCUU3mIXDzEOrIL+brR
 4CW3jRfOFahyqnYSEfWJoENzxl3dhU0DgjzZEPos5mkftL/2u067x6wjwrSgDzMvHzs4
 oeBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzlvQe4qNUoLIg6VGgmW5SK7ezEMksKP4CphnT41028mUpbiMuPbaMNjoepHTF1yEN+gHQFuiU25o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp7PelB/+QTNrsz2camI089Ow4Cqn0Z1wCwghY24l9uPer4TBj
 iBSCg7Hgd15isI43YNl9mzh2IGaNT2e8AFJHHKNrC3D3gEHNugBZ1ad+
X-Gm-Gg: ATEYQzzSiwo6YpabNPgDKNReuYGNvFNFuD3IT2i7u1ttEKI+2TgZx2c0xKWKLlRFVb8
 to/jE5cBPhaf+KKygldALemC9Xs8V52XAbdk1XV4d/wqYKZXJeVVvCMzUpDWOBEc0RkTEyK75ij
 ebWB1IJ1HClwQ/1zNAiAx+Za/e2H8uTKGqzyMPWmlmj8L9Oe2aJ/XUkILVdBS0kt1zW2C4MJsr1
 ZUTMax7JL3NBGBe5r3Jj6ljiiJzEZuRZWSVWd1Jc3qqhRingi+sitXRPwsWfBEyNmBYkBEHuOUS
 WM3tFazAWRzoNVQCsU4EioU2D9Eulp31ouaMCTYuMZUlbetIRr4gHSuGJcPmHlePGIi+xjuoXHG
 5I0VhOTSmO1MtL5XO/AXdRpuzLv5YVo+p9j0AokAk1Ad9AwELpkF4X2UlMDRbmQbRU/Yz696+Q5
 BJ0vwY0ZmhFAsLXkM8mSy/6Yrh9jRRtVd4qnUJHzDexaI9bZFP/K/9JvfOfGE=
X-Received: by 2002:a05:6870:b493:b0:409:6227:d313 with SMTP id
 586e51a60fabf-41ca70d655bmr4566906fac.35.1774551367549; 
 Thu, 26 Mar 2026 11:56:07 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:07 -0700 (PDT)
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
Subject: [PATCH v12 63/69] drm-dyndbg: add DRM_CLASSMAP_USE to the
 drm_gem_shmem_helper driver
Date: Thu, 26 Mar 2026 12:54:07 -0600
Message-ID: <20260326185413.1205870-64-jim.cromie@gmail.com>
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

The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
dyndbg that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7b5a49935ae4..bcc2c870d304 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -26,6 +26,7 @@
 #include <drm/drm_print.h>
 
 MODULE_IMPORT_NS("DMA_BUF");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.53.0

