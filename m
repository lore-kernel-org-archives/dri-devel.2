Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B8C10AB802
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B5610EBF8;
	Thu, 26 Mar 2026 18:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a9J9CkT+";
	dkim-atps=neutral
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3422910EBF0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:52 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-67e02b821cfso804919eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551351; x=1775156151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=a9J9CkT+kUB+PG+4uyuxrBUUPB4aDXS4onJlaKHlmZKYYcCbEnbeGaO0ggHa/u0qOR
 5+V64ZG/9HDLNyB4Cc9OUCz2aKcbsyLcd0vuzvwXeXjC8TAQ8X2XQJtm3g2htadXH6g5
 PGMH0Xe+F5Em/8T1MI5EA4b4o7IwOrkAoinn3QSodX5I33qW6q3IrBPTSP19uLfyOrNl
 WQ/7nSNodYoasB0EkErai70C9+3Ff+/PmWM8Oq5IvHTG+LIhBNa3LV8GUoth7NBy9rfn
 +uCE4GfZrD643hhRz8gKJyBHyCzczFzCStOYsmcRVmV2kUEZHH18h8YpK7bp1vCYOKnI
 FEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551351; x=1775156151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=BlBbIFfkhAwzX+8PQX2xB3lHkbPOFSwOx3Vzw3iVvkzIi0Q2xfpulQ7dbcwTw/rwqN
 6KzM5S54cXA2cbEumlp5VA13ygvpKRhfaVrnrXfiNvPd8Wv/SHtWIsaXZfHjF8Rnl9hP
 zJQS/ElywKjNqU5wQq0Xwf7jKuEiZi1OVMLxbKap1+Dx58IoB18M8Y5OmucDs9uYl/c+
 Mw4O7Wy0cKsT8VF4UuEvLV2CQk1eeHF1WK4OLu+QcirOR/ZQeNG9JsGAz80Hpi479TLo
 /uKElLfyTyY9TUxxseDpSjB96hcU+IaFjbC31ukOODzY5WztWAYTUpPtol/DYuixkWx1
 7x9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMc0wRmORnrG4EExI5oVhlgHiePFFCtvdMxt0IW7tfoUcQSPPOBWV7qdZhkJVSnnaz1VBZzORp/5E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRTtYaQOiqJOcbHRlMRZZdPDugXRvSta/YxzK4Hz9CYkQxR1KR
 TvvkxRQwtGyJEd/amlD0bL16MJVjplxm6xAKZoKYJ1XmKVkhyME+qAG1
X-Gm-Gg: ATEYQzxRxRHWtS5kSgSwk3qgXxA4zYtK8j/jbwtGNHfgz1YcuK/yCi717ItC1hbV8W4
 W+0Y3Sx67ZWj/TtxCo0N7GmEw6et8gUHPDsQ/VzpXBT5tPmM9C65wtWyMiW8aJ7VXB92UQfCWUS
 4iTuozgTAngJ3LezvvEsA2iLG8brSYxP5MXB8584ioUXhWp4J1QROgguoEHj5xal2rx18U4DomW
 i3M7pBatVioqCyxk3kC8vvloYrbPl7MeR31nZ2lCJNizYw4EOaxPKytGNzqhTM3rEeiMupI3p4Z
 Na7bFuTtCiqhwZSH89IQyoBMgqOoZvTOk9pW8BjXpymqY360JRZHsVNAkS6P2NC8vI1RMg7iQc+
 z4hc6pVquKTjRwHbYDv1X3QF7d/kyZd8hBUb/7wao5YY1Gr8sUF42Qbm2GMnuB/o5YFjXUyRh9i
 QgwUTFJ7dL661rLFkqmpa39D68+oQYEn6Jab1z9h1Chn1p/gSd
X-Received: by 2002:a05:6820:152a:b0:67b:af3e:b1de with SMTP id
 006d021491bc7-67dff5a94a4mr3770147eaf.69.1774551351454; 
 Thu, 26 Mar 2026 11:55:51 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:51 -0700 (PDT)
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
Subject: [PATCH v12 52/69] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Thu, 26 Mar 2026 12:53:56 -0600
Message-ID: <20260326185413.1205870-53-jim.cromie@gmail.com>
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

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 7a95d2dacd9d..8958e115abc1 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -35,6 +35,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.53.0

