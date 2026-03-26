Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E731A10AB808
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A4510EC08;
	Thu, 26 Mar 2026 18:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjHGcEFO";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3814010EBEC
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:45 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so592058eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551344; x=1775156144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=fjHGcEFOgLVsNaraPwck5y7Jp9PvsX8kFcuyCRrjSl4fGtB91AnzfOaP254y1rXMSC
 waKm6Dr+FC+G7mJwuCdo1ZwXumMDvZIxY9C4H8boWCbstVBwCoy9Klx7OmFFe7nlEDZI
 vLUCL8NpcRKQeqYaGYXN5KVFhR93M5plKF330v2fLNf1+xr708WWv1QehbIodALPCToI
 ovSdwup/S7hUKbNR6ZXXHTs+yy0JTDM2cLj5mgLOzNOk5+YV5/CjQjmvKaBksuiJ+Naw
 7rMm2zx0kQY5me8qbN/nOvqEoG4JlVnTmjS7JLSXv+8ZgA9utrzQZNXF1bRd9YscSUvi
 ezcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551344; x=1775156144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=YijTsFTcOjFzwd59lNfB6a3/dIhJ4/p/b4LqB9tkoIOKVxBbMFr+ONMDHW7ceRtG3Y
 FMEs2bxwwG4mptBSymlUPumTv/xK51mkGhAlU0EgFF6ejCWbAENwE/kDkME7Y8ZgPDEm
 ZYoARtt9m6BdMemiozBKKF+/0NMtgy+ip0H0vXn4xdgckmUwfYQDANA2kz0qOZ9cL7/0
 vpszM+h6y9B7wm+nPzGUi5KFW8DMltgI5cJPtjLwJrRwE4wdGMFjB2QNpC79TsJ5hdop
 M4EAYhiP3sq7WES6plcafNHNAB2KZu9u0DodLJogf5gDvxPVNQbtOKTlbP/3g46AOrmQ
 07oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrGarNyUAQo/dWF5LhtWVs2nk5IqnK6o03wCbwzym3xDZ+ORDLWo7b1RTdQeqnsitEQYZLh0GitP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfAOtqnsIUrkntD2qgOqpFjimiUwtDA3lc3puUs9iAi01uXj3S
 wj19OXtdfQ9fWbPjntl3iaN5rAUXCtKozzaCUvuimvO1id0HrxMa3GtI
X-Gm-Gg: ATEYQzxhvhpYbMdc9+g+DMhF7jVGj57ShhteVgyy6ljO5UiNRcXycFN5UZpzIeDmpsu
 PRobGtrppHAHjwt4zScQGEQZ5FPTHSPsB1HfqI4V542pW+AvSIkZcOXAw8VaaQBGxUJppvBlSbC
 LHdy4019Adk3gOJxL3ajSl2uGOpqzIapTe9uIl9HL9JlHu74TjZd4Ahot0Pl6/dMeKRcW/RI0JX
 z/jhHnq5UjYsIHpS6vqHrryUCJs+MOE9WoRAQkqEl0dezCeIlzNGdwFc7ud0zyzgfxfoayT0djX
 e9/KwHioaCNxucCNSteXEvu8eK/TPefpe+J1kKnV6Ry+Q0g4v3y9euOXCLyRStpSpvaUZ/IJTBp
 Imym02r/tTfFzsgebxY2ZaifL1BWbeV1kj9KUirieCYdQGGkePXPNenAG4kzdkdvwU/yirpMbJu
 W9s6JcGwKkRrwPGWxQ4kZEmulL5Wu+pkioHehfw5ygpatoemaF
X-Received: by 2002:a05:6820:2223:b0:67d:e140:3451 with SMTP id
 006d021491bc7-67dff3d219emr4887862eaf.11.1774551344312; 
 Thu, 26 Mar 2026 11:55:44 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:43 -0700 (PDT)
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
Subject: [PATCH v12 47/69] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Thu, 26 Mar 2026 12:53:51 -0600
Message-ID: <20260326185413.1205870-48-jim.cromie@gmail.com>
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 5de9aaa5ba04..31c5294b252c 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,17 +50,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
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
 
 /**
  * DOC: overview
-- 
2.53.0

