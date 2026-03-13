Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11AB105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C02F10EC2B;
	Fri, 13 Mar 2026 13:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WdlIUNs8";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C9710EC20
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:04 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-464ba2bb3aeso1297463b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408303; x=1774013103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmHuo2gpKk+a4rM0v+S94FJooBnanLI4bt90pYFjtcE=;
 b=WdlIUNs8jVU09TTFtkAQFzt/PZG5qNnFsuuiRJ/khBU3BGmXcnCbsIcu8vfLV3fcgT
 apUX3jzndETlbFP1+3sIKYcSjCAEmZYSh6l1qlZ6tluzI5vmqMRavC0h/Eb9Gv29rpQ+
 fLnJCVCH6tuQWZkUc9HwIWzbwDScdvApQGdljvcugN5aWzqOPXNVoF1UNe9SbAfqjvHI
 CJVBZRUXPXny05aMX/zJu8wptnX0vM2v8L046QZfXYUY+OU3s4AESnIcN79Qkn49byZ7
 6oXusQ86GB2d/ktYEzZpQU0mHHWjvym6L64cm339HFCLL8wlh4KqeL1YkebgbO9TMmCr
 Z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408303; x=1774013103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZmHuo2gpKk+a4rM0v+S94FJooBnanLI4bt90pYFjtcE=;
 b=Nt+/kE91K+h55Pyz33FExTcyYMygUEW2SwKglswtsZCRy3X1gzs45KErSrceOCCfc3
 7Tha7Jy3LlhIfA+tLpVSFHtFSoFDnznz0I9MWaO6m/J2kBcQ5dlPZeX/LK+seKBrrRWA
 HOpoOilDWsCaCZYOFaPTtacS+rS81AV9IGjj8NMKT10F7+FavIH231687lv6zMaBVn1K
 vRpX5eM01sjB05K/8e19KZN4OvMvxwV67BeLKaaMbID7/A42IaHd9Gkh2auVtXKiBoGU
 H4vrd7FyyiuO0vdpGCs6O8vKWbQ6iv3dlmsadju53fq0UJTcgGRStzqL/Oa50Rr+Rxoj
 KV8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY3OAq1156AK7qFGZIAlxMk3Aer6Qc2MR3auNieSSoM/bbYx15J9jcvFyPyO45/eT8QiA2bsWJ7LA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ/WQM/n2mRtIpoIUD3vijbRGqGQaxNESlesd7OK/tEkW/FPAZ
 TYVWKgOuswUGrejJPEgneJ3YINN/uuRYECDmpznJJVD2kOe1dCn0s2XA
X-Gm-Gg: ATEYQzxNNHWjsqY6r7JbGAQjlq2DNxPqVaicPL8D9J3fRKZaCvuY36S1KCObEh3NBTT
 1B3OGZV8ZhjlMPbuuIKVEsGQzHNQFnlCLz0Br17HvArLry4WVLBfTfTF28GcZ4rInmmg9ONJYvq
 ZTREEeVSHiqYA8VvBqknw98UmDPbbP3nDfQTw96zUTvk0hCMI/ggJ3l3xdojbWK5oK0IV/q31HO
 3lGCuB0R0z55h5I+k5QVNPpX7qPiqCrZkz5QScl7J60TpdArOz0qgJ86X8UgV+bwryMgdme1ksR
 LFPApQMelhz3xEqbosueQkyBoQxLb2PFuW8bryN4Lk3LjZzekSbePYZhyurFoKU/PFG8syFJi/A
 iUxIki+t3XavN7OunnjSqR7ekhlXsbGANKqBoShg/9/UmNyvLpIKn3UvzHYhtsIi4zmPUPGwHex
 vLuLAzJxfq0wKmpo5wvt2b+P4ZYrhfJUga2XN45NnieJaBW6HN
X-Received: by 2002:a05:6808:190e:b0:467:2be4:9e33 with SMTP id
 5614622812f47-4675552dd65mr1929280b6e.6.1773408303348; 
 Fri, 13 Mar 2026 06:25:03 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:03 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 61/65] accel/ethosu: enable drm.debug control
Date: Fri, 13 Mar 2026 07:20:26 -0600
Message-ID: <20260313132103.2529746-62-jim.cromie@gmail.com>
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

ethosu.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
to tell dynamic-debug what classmap enables them.
Also include drm/drm_print.h explicitly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/ethosu/ethosu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 9992193d7338..a0b8cb81a359 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -17,12 +17,15 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_accel.h>
 #include <drm/ethosu_accel.h>
+#include <drm/drm_print.h>
 
 #include "ethosu_drv.h"
 #include "ethosu_device.h"
 #include "ethosu_gem.h"
 #include "ethosu_job.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static int ethosu_ioctl_dev_query(struct drm_device *ddev, void *data,
 				  struct drm_file *file)
 {
-- 
2.53.0

