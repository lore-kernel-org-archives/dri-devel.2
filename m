Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B83106F30F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDA210EA9D;
	Thu, 26 Mar 2026 10:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5b2Y69i";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B7C10EA9A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:03:05 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso4572035ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774519385; x=1775124185;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/bl8GTjOouTlTXh8s/BuHH3L5XK1eHHd49OQHimj5A=;
 b=f5b2Y69ij3uUj9WMgxECfCQFyt6Bj1+N1YBV7lYl8dzRZzAmkStzv5jJ5Um4bjKAxW
 U7Hr8N7H89T1UDib/2h4Ahwre+Wa4O2jv9cJ2fO/b0QJItDKCkrOhpZtEU+sDKIDXpii
 Pff8o1LwLfTwBbTOQ6aES3gXeL054RX6w/PdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519385; x=1775124185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5/bl8GTjOouTlTXh8s/BuHH3L5XK1eHHd49OQHimj5A=;
 b=YtwMNulMlD0kP7oA/8g6T15dcHNUheMi63HfCH8QfQ0fYFKp+pDCQe8JzdC9HVaZ59
 V82ODOFI0BaWS++a0MJTAx70Gf95mQP5iUXOe03pcb1DmGtZDBc3/5n6Pco9CPbyGgiw
 OS4ZyU97b29IJT5Jx8RVb3kwo9J+9U3kUImPfL0qUxZgAtm7gI27HSOmig2ddyj/c31Y
 QJ0RrHmOQnyrxV9LPFP/JKc9XKlcEv1lYFK2vOxuJDDY6zO1TvjEj6H6vj/Wvs049YZf
 6khAMPGgGyfTTg4nwJMXF4TYp6IzhLjzsB5yRWjkGnimDIwRODcBb8IITunPA1aPSLOz
 ombQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn+76matFvF6XP56gr2Xf/byiYRo6OXC4Omul/QkAH1JsRsCLr/aSGlxDX2Z+wZsLUcu5NXbrTwOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyooq043mUqzA2vmxjrv91EHX4+OFQD2FHVN9f+wSXSMzhSvh4e
 s3UnQioRn2z/UMLWhXf7ye/AQ7+PPQKBFPZepUZmEtc6zQx6YWbfRuXJkiOP3xcl0A==
X-Gm-Gg: ATEYQzxfEaRGayPSJGSjQg2tycXijUXBoNBWSEcD7YucTgreV9+w3b4qNOO/uAqNbxx
 qkHfxcCWyLf7155sHJEYriyjHq+xuWPPYR2v1D/mjhy1M8Fs3xZd4gdBZedK6W+Npw55UBbFfhy
 Ny4B0pKsmGB46RAxylxxq5hQZYIaae/rzki2kas0x9vFqnaG2OffVUj5vPMDN5rzq3A5w0QPLqT
 p588lk3ooBA0hRAF3ZRoxhDTSl6gSdFj1rq/CXFY8FOHCpn7Xwe8qA8T0AiLh1PKqCebeuMbdHj
 GoEINTdtT/FHquvVDiyu/BL59VGz0WFx1bAQOtqac/7ZwY+bp+6Px9EV/D06Rgyk1PKsazXHtrJ
 +DHj8LSPu42OSX8IpIS97stvc3Fssonfr1FRquBhMGQvuGt8Kow64WSLztL6i+ZOMmTByuQyGrI
 5Pgeof5CIrnKR3VWXe+IuoW2kEa5S14uTKkT2lXsQt40t+97LNI/WxjS4m/X0E3R13W5Jqh4+kP
 v8OqbHo
X-Received: by 2002:a17:903:28e:b0:2b0:b3bd:1de3 with SMTP id
 d9443c01a7336-2b0c483ad89mr10070645ad.7.1774519385036; 
 Thu, 26 Mar 2026 03:03:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7c2942sm23339435ad.36.2026.03.26.03.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:03:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v3 1/3] drm: Introduce DRM_MODE_DUMB_KERNEL_MAP flag
Date: Thu, 26 Mar 2026 18:01:43 +0800
Message-ID: <20260326100248.1171828-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326100248.1171828-1-wenst@chromium.org>
References: <20260326100248.1171828-1-wenst@chromium.org>
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

From: Rob Herring <robh@kernel.org>

Introduce a new flag, DRM_MODE_DUMB_KERNEL_MAP, for struct
drm_mode_create_dumb. This flag is for internal kernel use to indicate
if dumb buffer allocation needs a kernel mapping. This is needed only for
GEM DMA where creating a kernel mapping or not has to be decided at
allocation time because creating a mapping on demand (with vmap()) is not
guaranteed to work.

Several drivers are using reimplementing the GEM DMA helpers because
they distinguish between kernel and userspace allocations to create a
kernel mapping or not. Adding a flag allows migrating these drivers
to the helpers while preserving their existing behavior. These include
exynos, rockchip, and previously mediatek.

Update the callers of drm_mode_dumb_create() to set
drm_mode_dumb_create.flags to appropriate defaults. Currently, flags can
be set to anything by userspace, but is unused within the kernel. Let's
force flags to zero (no kernel mapping) for userspace callers by default.
For in kernel clients, set DRM_MODE_DUMB_KERNEL_MAP by default. Drivers
can override this as needed.

Signed-off-by: Rob Herring <robh@kernel.org>
[wenst@chromium.org: Emit warning (once) if args->flags is not zero]
[wenst@chromium.org: Moved flag def. to include/drm/drm_dumb_buffers.h]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v2:
- Switched to drm_warn_once()
- Moved flag definition from include/uapi/ to include/drm/drm_dumb_buffers.h
- Reworded commit message

Changes since v1:
- Emit warning if args->flags is not zero
---
 drivers/gpu/drm/drm_client.c       | 2 ++
 drivers/gpu/drm/drm_dumb_buffers.c | 4 ++++
 include/drm/drm_dumb_buffers.h     | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index 46c465bce98c..3d3e61823cc1 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -14,6 +14,7 @@
 #include <drm/drm_client_event.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_dumb_buffers.h>
 #include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -404,6 +405,7 @@ drm_client_buffer_create_dumb(struct drm_client_dev *client, u32 width, u32 heig
 	dumb_args.width = width;
 	dumb_args.height = height;
 	dumb_args.bpp = drm_format_info_bpp(info, 0);
+	dumb_args.flags = DRM_MODE_DUMB_KERNEL_MAP;
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index e2b62e5fb891..60f4c2d08641 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -233,6 +233,10 @@ int drm_mode_create_dumb_ioctl(struct drm_device *dev,
 	struct drm_mode_create_dumb *args = data;
 	int err;
 
+	if (args->flags)
+		drm_warn_once(dev, "drm_mode_create_dumb.flags is not zero.\n");
+	args->flags = 0;
+
 	err = drm_mode_create_dumb(dev, args, file_priv);
 	if (err) {
 		args->handle = 0;
diff --git a/include/drm/drm_dumb_buffers.h b/include/drm/drm_dumb_buffers.h
index 1f3a8236fb3d..4657e44533f4 100644
--- a/include/drm/drm_dumb_buffers.h
+++ b/include/drm/drm_dumb_buffers.h
@@ -6,6 +6,9 @@
 struct drm_device;
 struct drm_mode_create_dumb;
 
+/* drm_mode_create_dumb flags for internal use */
+#define DRM_MODE_DUMB_KERNEL_MAP	(1<<0)
+
 int drm_mode_size_dumb(struct drm_device *dev,
 		       struct drm_mode_create_dumb *args,
 		       unsigned long hw_pitch_align,
-- 
2.53.0.1018.g2bb0e51243-goog

