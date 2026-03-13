Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B111105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D3A10EC34;
	Fri, 13 Mar 2026 13:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M0onIEeZ";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790EE10EC2E
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:09 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-46704177508so1466350b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408309; x=1774013109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn6BBWYTc8CIB4CSHYkkNij4NNRuRZw5Ruqls3nbhKU=;
 b=M0onIEeZhjz0W/fGLMWCsS4Nj8KWPQVDt0w8YKlksHVdh10v5eCHMyeFwxJ6RRiJfw
 AKnhHayg6TUbV5suJcEfyUGtbNbVswCUp8UMqu72v/WQJBOMR/nNoG4DbMPPc35RrmIX
 JnkU8qRqM8itmkM0ppkmztfDknz5AyVuk/yX9DpoAoMNxG+LEdZ2mgvqFKsZj51rUIjj
 46EcJI/wPATI/1svVZ5Q9wx8pF2xPFMJcTMaOOFW8KjBEsqz6kiiV77/vsEaHPe7bYgK
 sLjjY2p35UZQ6JUvn228XVxDI3R5FTqdUoQq7/O55qLq3PN8gsXoX6o296LmY+Gh7uN9
 dgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408309; x=1774013109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vn6BBWYTc8CIB4CSHYkkNij4NNRuRZw5Ruqls3nbhKU=;
 b=CcoF3+EfMGh6bjM/lMuebi1J5aopfeI8IwDv2wQHrhl/4ySCcyWwaTODTHzh0KXiGX
 lBEzkXgOIBpWOxRnHilAJcyfcvghs3kNbhVz8yDmzB1bVv0YG/a2Ni9R+amJ7y8zFHU0
 dQaAMMzGx31ARXJOACaM52XREc5o47TgAUzUwk4lu2RvpVUh1f5L1vK2o8gyLrWN4hbz
 Ye5FRevX5xtvPsBWPuWVwpC0Q2RCIHiUmR4cIqlMqtKl9hb8Of30M3P+Snhd/roUBbK3
 MKRQBH1R2TLV5iR975O7/xgGk5v9dcmuCu/0/kcM8S2Ff+x8S6N8cMAmwvwRJpp+lIWy
 MNSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU778jp3qKnLqoQxq7jvgy1iv2ywfsEA/N44ZdKCMlf5MuLdOiqisLuNPfksSUPPMKza/a2EfumRE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSN9P/0JzkX7SqBPnUW9gUYGSlYQRPVM9+5GcKtGc/Ok4sOlI9
 m182Sg9tITdLMUBzTAFa43e4RnkJhEovkDJehUcTTj5Omlv1J74ZeYzX
X-Gm-Gg: ATEYQzyls/XpWgg2GQrzTgykHx0akxRo/nrKmuGSXf2Mm91o9NnO47Qgg9HooWWgINe
 p6vIYdWFFaDOJCqpfgRs8H36InK+q8aSSti02dcZ/EdqN18owN4MVef6nq1nABoPE73F+Ciqzsl
 AYic3rAzl1RsMhUq6c9qfCY3CWbL/1h/3NwhioYEvowRQe3iG/aXYhG5lyk48+rSprimds82Icq
 8yd/FMSNcJSIwQIYQ7eCRNmZ0s7voaORfonAomc7kEDnYqHoW06cs8bMm2JbamoU9dmARBtPpc6
 XGC87zmo0qSCrnCKQpd7IyChlIMUJzHHI3DBaFtpM7gn3UPOmIwnDjYcns+lZISU4d/Uj1eEoWP
 xbMd7a2ts/2OJigV9hdDPtxJPnO4Mz8ZiS9LupGHRDpQd/pPCdXF9zxD2HVLqYYzDG9tVNnaMRd
 aBTvpFbrn8F/DPnYdoDndyEm36vTwFwJr9H+ocpoO+MKM8aSsu
X-Received: by 2002:a05:6808:1302:b0:467:17f3:68bb with SMTP id
 5614622812f47-467576d3042mr1687190b6e.59.1773408308527; 
 Fri, 13 Mar 2026 06:25:08 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Luca Coelho <luciano.coelho@intel.com>,
 Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 64/65] drm_print: fix drm_printer dynamic debug bypass
Date: Fri, 13 Mar 2026 07:20:29 -0600
Message-ID: <20260313132103.2529746-65-jim.cromie@gmail.com>
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

drm_debug_enabled([1]) is the canonical bit-test for drm.debug.

Commit 6ce6fae84536 ("drm_print: optimize drm_debug_enabled for
jump-label") did several things:

A- renamed [1] to drm_debug_enabled_raw()

B- introduced __drm_debug_enabled(), which evald to either 'true' or
   _raw([A]), depending upon [2] CONFIG_DRM_USE_DYNAMIC_DEBUG=y/n.

C- altered *dev_dbg() to call __drm_debug_enabled().

D- redefined [1] to drm_debug_enabled_instrumented().  This called
   _raw(), but added a pr_debug() too.  This allowed us to see how
   where and often remaining callsites were called.

When [2]=y, [B] short-circuited the bit-test, since dyndbg's wrapper
macro had already set the callsite reachable/unreachable.

Later, commit 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm
device specific printer") added __drm_printfn_dbg(), but mistakenly
used the internal bypass __drm_debug_enabled() instead of the
canonical drm_debug_enabled(). This went unnoticed because at the
time, [2]=y was marked BROKEN.

Because __drm_printfn_dbg() is a shared callback where the callpath is
not directly guarded by dyndbg's static-key, checking the bypass macro
caused it to evaluate to 'true' and always print, ignoring the drm.debug
bit-mask entirely.

This results in a flood of messages in environments with slow serial
consoles, as seen in DRM-CI on i915 CML devices. When IGT causes a
mismatch in intel_pipe_config_compare(), the resulting UART storm
causes a hard timeout after 20 minutes (see below the snip).

To fix this, change __drm_printfn_dbg() to use the explicit
drm_debug_enabled_instrumented() instead. This ensures the bit-test is
performed at runtime for this unguarded helper, stopping the UART storm.

[1] drm_debug_enabled
[2] CONFIG_DRM_USE_DYNAMIC_DEBUG

Fixes: 9fd6f61a297e ("drm/print: add drm_dbg_printer() for drm device specific printer")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

some of the many:

 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:57:pipe A] fastset requirement not met in hw.adjusted_mode.crtc_vsync_start (expected 0, found 1083)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:57:pipe A] fastset requirement not met in hw.adjusted_mode.crtc_vsync_end (expected 0, found 1097)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:57:pipe A] fastset requirement not met in hw.adjusted_mode.crtc_vtotal (expected 0, found 1116)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:57:pipe A] fastset requirement not met in hw.adjusted_mode.crtc_vblank_end (expected 0, found 1116)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 112800)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 141000)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 141000)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 61040)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 76300)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in hw.adjusted_mode.crtc_clock (expected 0, found 76300)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in port_clock (expected 0, found 216000)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in port_clock (expected 0, found 216000)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in port_clock (expected 0, found 270000)
 i915 0000:00:02.0: [drm:intel_pipe_config_compare [i915]] [CRTC:82:pipe B] fastset requirement not met in port_clock (expected 0, found 270000)
---
 drivers/gpu/drm/drm_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ceede094ff13..b431881de2c1 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -214,7 +214,7 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
 
-	if (!__drm_debug_enabled(p->category))
+	if (!drm_debug_enabled_instrumented(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
-- 
2.53.0

