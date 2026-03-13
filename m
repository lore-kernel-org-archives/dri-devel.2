Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF14105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4149A10EC16;
	Fri, 13 Mar 2026 13:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCmzpJZm";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F01510EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:54 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-46726528f1cso1547056b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408293; x=1774013093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=HCmzpJZmxi9a7DnbKerMWSIhWQF7UXL8eGUb0SvcU8745rmGSlCC+CebuJCvRAqoE0
 FGclb8dhe87X6biLkNTv9cM7kjRRuO3t6Yki9GIOdu+K5yWdNbSjFUloo5LjgUuaz43T
 I8ps2fvs5GlWL9VKA7/9LdrrJjLKZo4Ixje+TC7PfDx43yHVcAiVwfyI0L/Ytjm/6ZZv
 SrszsoFVXunk2Hoisx1ShBrMJVoIr7PG33/wgllyV9CTjhc9vwOIzExeHFsYKYaT82fL
 /6Lq2PyMIs6hsTcyrUVJxK7+BDDLHAf1Zc1qGaDDrRY4nmpBfn24R4f18jcmnyii09D5
 V8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408293; x=1774013093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=Rrpjl+HzqQQp1KXRg2NKFJZ53BMnGrHM7UA6ZuOENcDqYXCaD5YWOdlb9GcaNtkIPJ
 j8/cDZiv3vJ7hqmKtLSQSNV8eRCDp1wgR41YJQ7FmFhrkQqVn2JlLFY9YcNWo7ZfPA65
 mjjN5iwVyEwMvseQ+wV2LE78virjRaUTcCYoqq1Oy/s2YoU+v294bRHcKrYb5GSTCjs1
 RivshfweU+FkHc0aP7nY/s4hWRz4JJrPuaX5GYIZIu+Dfbtyae0QFpT+JzcIDVrWTJY7
 TfoAf5aODnbbWZeqV59xJZuZZsb//SbUa6autC0U1yfiQREMBDW4F/A3ig3wqGka7a7d
 dOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe8wcbloINfKq/ZpetfAzx3IE5IdCNTirCMjns6oa9WHmHgJLARxpQ/tWvrWH7YP3rcPb0FFQZUEI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAUTTTd3uskvKBydM6/iKlXixlj+JLcH3BKfoPhjCcLtfFTVMX
 W7eKrEYXGyDu1rvkGHIDVLiFiHC7V7iSaa/LdmF+dTjL8Zwrh2aHeXuT
X-Gm-Gg: ATEYQzxfhqUn528rIv7GTkF4CV+/Lp3NUqU1z/KXfPH6g/GXLZ8x1kAPPDyV0/CYvzN
 LLmgv/+FmEvEOLaRnTqzUF705N9EHVy1R3oAVd786MF7YxR8bJqbMPZDM9mjMnyIB7Ig3HZ0Rz6
 8mYSzzKxODM6Qs4aYOur2hckjDt8JJ8Eq3iCstobNALRBQsKkYClsf96KOz/tWQcgG5gjWuHeJd
 LZNYWQkeLyjZQQ7awXfFhzgFu3oHzt6dhe9gSptXrb9iVJqakQjenakn9vE6ibjCMqj1jn+2l0f
 0tTh3Oe0O42/uXjw3CDba5J0I6/kM59fZHqg+JG6ycYOlFJ25IewGNud70hbqllh4RqTur4Sk58
 MlUv6BFU+t329oh4D1yK+YQxrhr0vV30z9P6KHC2fA3/khC2agMhpz8L9Op0CCDsbQv9un+Ad7x
 wU8znutd7DvC11c3Aqk06uz90MUMwxpWCQXg/sTWnqb83khogc
X-Received: by 2002:a05:6808:1b10:b0:467:254:b90 with SMTP id
 5614622812f47-4675704a335mr1612471b6e.10.1773408293451; 
 Fri, 13 Mar 2026 06:24:53 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 56/65] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Fri, 13 Mar 2026 07:20:21 -0600
Message-ID: <20260313132103.2529746-57-jim.cromie@gmail.com>
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

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..73998bb331d9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -67,6 +67,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.53.0

