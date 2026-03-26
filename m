Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805F010AB804
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E9C10EBF1;
	Thu, 26 Mar 2026 18:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AceqeUAA";
	dkim-atps=neutral
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D341810EBF2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:04 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d7e565c877so677809a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551364; x=1775156164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUW+eTRlaAbHOLDd6X1oNyvzhDfkwQ9M9VIyPQZn2Pc=;
 b=AceqeUAASmYrB+Yn6vZD4ll2gGiHJ5CYXL0iGLMhrGLcPDLVtxeXnf26V+x1DR90de
 VShXFkgux1UEott3lKTJgyt4S6J2kHP24YDHzDEKgnoEZ7pKNvb1EueBxIZJ7uE6GNbu
 WrNSxTORF8dNRsraijWZrTJjOsA5/zD1KDngeOdpb7mxDxZqDW6gMfxejYnNa0UawRVr
 fx8el25nqspEj9LccL6PWA3IW682vxLTQ9zgFX1sY+iPYTvFZXRiRUOHhltzWOgL5dBq
 fqjYSPDI8dAbBKLYe9kl+P3TKteEY1Px2vnq2VCLoppi8t3ZIbWnLRIkJvwM7oTna2he
 49VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551364; x=1775156164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jUW+eTRlaAbHOLDd6X1oNyvzhDfkwQ9M9VIyPQZn2Pc=;
 b=FAq55/y6gzMatHiyRU9TwSDMMpmcFX0c7a24RvB3gpnwOBH4YNL27UQZvuUF3f1TBN
 TPsJURxEqmE47wZHT4VSZsygvrIp8TYVykAczoRSjE0GutVJ84m3Ma2YBBJMagp94i9l
 Cb4IPKVSr7IXWIlTgBZyFrpfHfgNEKKwOv2d3j1bOlGrdFoS+iT7i9Y2VzJked9g1H3t
 Q8itAh+ugfDBkc+jwaW6vsiRECfGTvdAgKxRZn2Ej3lKUedvPgcQdGKhwL0t0f+0p10j
 iC/sDf104uEKk+tojGln3xYcWbRP1++HuVy/jaWly+HYVrUeVxb9ZIozST3yhE9ga/hj
 cloQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW75BBXYHCDImqqwv7Z4a4oOAaDmcofcNLlnNBikJCE6fNHWmgjiy4D/HSGIlwVf+w27ZVlowptyDo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQH8KQX+lZorwPYY6I5PwsmYr+ujYaC8arVW9jTOkwJK0XWfXU
 uyV4QZKfOTV4+wRUQf1MVCantCk4sAYqqzwoolvuMWhQynDVqpqSiwJ7
X-Gm-Gg: ATEYQzxN7fxI7dr4H4qMZvGwypXkdj3oTOlSNMEAkF/SHgWNZd+FioXx42bjpqJVvOg
 J/9QSt/XtAZ4q8oweheH7Sg1h4NUq6/56iu3KnL74Nm5/3TVziys2H6Akz4FQ+N4i/inZIz3knC
 OAVFn5DTgW0X+5YPO4gt1X0AIYBLnelaibbHpAyURJEImWqHLIFKpJoi8rIR0YxN+7PRqcseDLF
 q//WhYfuqWDEm90hSGfijOMX0pHGAOtpSxmlFxcob8TjsDq6q9vG1+U/aHR9Uz4kBol/eBOvryN
 qojgliSrdLFMKPiPwDbSMogVeHCAm9QVUorEIw05Sqs85yxMYKLpHcMVaFPAKvEptuikM91D8ku
 8LC2tNLNcXFEhwX7bs/42C4g0pjAFQ4Fi4gLs60Frdl8bdkOyUCdXPr6bxr+hd0B3N0VPOYCT3I
 1Nn6Y7aw73wxaAUTju4dVeaGT0xPof8SWkZvtuUz+Hc67Rq6g/
X-Received: by 2002:a05:6820:1909:b0:67b:be3b:ec49 with SMTP id
 006d021491bc7-67dff4039b0mr4290155eaf.21.1774551364004; 
 Thu, 26 Mar 2026 11:56:04 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:03 -0700 (PDT)
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
 Ruben Wauters <rubenru09@aol.com>
Subject: [PATCH v12 61/69] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Thu, 26 Mar 2026 12:54:05 -0600
Message-ID: <20260326185413.1205870-62-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Acked-by: Ruben Wauters <rubenru09@aol.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 17c2dead2c13..c49f9135dc7a 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -32,6 +32,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
-- 
2.53.0

