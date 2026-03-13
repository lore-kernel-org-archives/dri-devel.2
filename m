Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA264105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC45C10EC2A;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ewo/WpHF";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A3710EC1F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:47 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4670676ba03so829945b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408286; x=1774013086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5CIU7Xv1sd29xtDEeVm5EwbYfV92LBvg9qr7+GGg2w=;
 b=Ewo/WpHFfm09kx5VmoNF8fezqzX7lZXSL9w261wvhsvP/Vmj0XQqLxSDCJMb3crqcS
 ciOSFuGZZBwRsTScKZ3f4h9qqUeM2/pyxok7xJO1x/A0HOuWMXPPBWCqysO8qXVm8qVW
 BOoMV0KqYp94hvNyx5RUqjwTjVyc6pC27hMUaB0Va99EIjpVDlw0GNN1CpF05TDfnKvC
 aIrlEsuLB7mNcgWWzOv1aNVgdzoo+30kwkSa7S8n+U5ZkUWyCpCi54cWaOvc9MzfmVS7
 2M22QOwxQh7bEApSPzIYqYrBKOQrJnKk8tm4or5jlHaizuefCY0m4rn0SE+8FsQqhhnu
 8Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408286; x=1774013086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z5CIU7Xv1sd29xtDEeVm5EwbYfV92LBvg9qr7+GGg2w=;
 b=OWGoG/KvOBA4rla4lf8s977NdVJYGGYhUqLt2qn0M+kZPvFBED2if7lqShXHeaTml9
 gKQ0rA2NuUsq+XrAYqc3fdsaqKvyfgDOLWUT/IMeAQD8T4/Wwb+C1nzBTanIgpyKNEfW
 bpVnsnuyxw6K4ix8YGRsezoMaRHgveHQjJMUDNGlZ0hWiMoANr5gv4HfVzOFg03VWFOV
 kLcs91bKxqUZRYcHKrGk6IkgKVM3Cio7O3z5d3goNAtEBiG9niYGlc38k9qMfbdjAqWV
 sTuYgidUw1Jb/lNhbxIyryGimPSahIMj7HzbgZ9sNdO0JDnLeN3caXhzcV1Y54nR+UPM
 F+7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJOh8vZA8JSqd1XsrRIo6sBAXRoVf/9oe0lzLXAvJu40hwoYlDZUcOwVpSY2eq7u9JgIO6wCTrROc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDx9k+TwYfk4r+uZw9ZOSALCDYGZ+fmRT5tUvIE9DqQZ4CWl/W
 qLZOzUdrgtAYsOI2XolPV07wICS3k5UCZJUfDHzulunvsBEQGzzdqhO2
X-Gm-Gg: ATEYQzwASKrKdWqjw6AHZ/yMVW6UgCyNE+VorfAgT4vyMvY8m9tMSYyJaM8TJVOD6hh
 B/NMHM6bCo0cf3RG8u+GdEZqwkOc72AFmUufxtegmcPyrAp95NZnx1EkLaJSJpPCQAZw6lrt/1k
 cuPsDSbK4pyvPiAuLri9chxZQ1XpQJG1isAPHSTh7/kMQnljpNCwy/15ZLzL6vmC/tQuTNVSOF9
 Mavnx8Y1YF/eyx/D2ShyJCP37+wNZr2KoSZ/6hQb8H6vjG3Y+0fj0vaZ4Z1gMW1ZhEmTQfQApps
 YlpGvE12hyNIbc4S8Eot+SPi/Lz7mk/mO2Sz58xrWrHdHXIw+2mAe9/VEfip52Pn6wXAMk8TPxF
 FJqeQ2svCwxVamIJSTgTmzYhKgFI8grQTmysUEBPuQIeZT6O+sAcN4pvq5+X2Ja8feI4f72gpTw
 XqIHJjeqfX78UhqYBi6NWFAJv1qQ/r3fEwmuvgBd4EMQcQy4y4
X-Received: by 2002:a05:6808:1302:b0:467:e7b:6fc4 with SMTP id
 5614622812f47-467575dca9dmr1665945b6e.45.1773408286169; 
 Fri, 13 Mar 2026 06:24:46 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:45 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 52/65] drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
Date: Fri, 13 Mar 2026 07:20:17 -0600
Message-ID: <20260313132103.2529746-53-jim.cromie@gmail.com>
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

The vkms driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 95020765c4c2..e22c15f045d1 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -40,6 +40,8 @@
 
 static struct vkms_config *default_config;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
-- 
2.53.0

