Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3318910AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF6410EBFB;
	Thu, 26 Mar 2026 18:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZGFHpC5P";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0EEF10EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:50 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-41c5a81d4b1so1626437fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551350; x=1775156150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=ZGFHpC5P6ieMf35qmrOTX2d4Nikb0EE9UecxqPPXXJY/vptIUmW5/83/STpdTi1g1q
 /LJIuVinTZfoFUg0uQXFxeAKAy9Iz2hKKO3B8uDuNzDymDWkD9vL1aJdKg88aJbOkjlx
 bB6wb/BWCl/UCTqNAhAkDeS4XoBCf9MZcwvfUsv6gmktzqXm+l2vy+TIaA7/wCN5lTwE
 DD+6LpdaPJtgEfxXE2AUVYnbN7wuAH5GzcsMv6s34z7Te5j1l7S72SeseM5rGGEy6VJq
 gZsJSffqmsW37knv5mjGktREoSaMMbihA0MXTk9evsjjDtvYPvtLmbrW+3SG3zSlQt7I
 FUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551350; x=1775156150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCYC336WoUNdVp8/EmNZcTjPfopk7zVSApVc86osLdY=;
 b=E+4d8VFvoPvsgpAZ9xplkfqP/rnUdL1Mn/fcZlXkCgPn/8UXf/3JSC4BzJzZQCwSA4
 x6sJNNyoAyGie38ziEcwZXfbS/X1MQICMPipnhc/rPkAiAWylf3etpdEhWOWWTSOlO/1
 MkjjinCcwOWU+PpwY1JzJDa5iMWvizWOAWMLFeTrLTvEmFli91iZQSZXhphQLMtPwLQC
 fqyDgN/3z2Kq2YPbYvZx+Knieqodv0BJSbnSmleQGb3meGMg3n+hpW4zwhXhYuZQJEcF
 97H3uTgfL6YZkH03eWvOIEdnw0YI0TF7vb0DDYM55NWHftuNqrCA3EJ9jCdvh3KuwxDT
 J2aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUs2Eadm1Xg57eP7noyRmr9wU5b/Z3zd/ewyDFIYnOFwqxi7hiqH2btOmML9JKcr195qYsoPTXNQw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEx1uDMnrwDUfLxMcIHXec4TAwIXltadwrJi86CoAOLegFWl2s
 nBYG1AZ+1/L+wpW3H5JMJSMBFKVGtpViDKgRep+3++3cJuqjRyHFhw47
X-Gm-Gg: ATEYQzzTd0m+iwNiiXNDYuiNZ/E10eSA31o5hcPSn9v0VBM2G/U1RnA6D9GVfgMR8ZR
 B4HIkrCsKUaFiO7ESg46OszpEU5LU81A7b5WZuu4ziz4HhH/m0CT/BOQA3Zlo9p6eTfBmotDxrT
 Tjw2lIUw/vARkjcSQ2CHAKQfSJe5cmtE827vXSfCvA3gS/SmGCSyA2BH/DhGfCAaSkPMavk9euP
 qQRmKMLr8nypT77Ygh3ZVHQDy74CEv4we66cddhQRzylDRbLbUBOwbOJgjzEdr+y3UIsVQBU0gh
 Ycd8TbdYAjP78ggc/ha+Gq9yasx+Z+bb4d0L6jPonppYtM9HsUocEvix2c/P63FS3cvAyAn2sKy
 NuJYW3jI7IkuJnpzxVQEuwTHbS063z9I2APjCSMLyqrh3HpWd0j6D4pmo9h+M3oiVd/b0xQgJqv
 UdTlxMzbGqJXYneQNuHb5w9o7M0tfcJRKJWLU4ggApf3Ke+tli
X-Received: by 2002:a05:6870:8992:b0:417:43c8:a58e with SMTP id
 586e51a60fabf-41cd7a6c632mr1282299fac.3.1774551350152; 
 Thu, 26 Mar 2026 11:55:50 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:49 -0700 (PDT)
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
Subject: [PATCH v12 51/69] drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
Date: Thu, 26 Mar 2026 12:53:55 -0600
Message-ID: <20260326185413.1205870-52-jim.cromie@gmail.com>
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

virtio_gpu has 10 DRM_UT_CORE debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..aea4c117b006 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -49,6 +49,8 @@ static const struct drm_driver driver;
 
 static int virtio_gpu_modeset = -1;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, virtio_gpu_modeset, int, 0400);
 
-- 
2.53.0

