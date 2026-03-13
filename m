Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C48105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0153710EC2E;
	Fri, 13 Mar 2026 13:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xf6siehN";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAD510EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:10 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-467161c4b7aso1096049b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408310; x=1774013110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxHe4+DOmq20FSC3herHJvg5metbXtBJFuJ219tBZ0M=;
 b=Xf6siehNjFLZmeEgQQjXRyZVc6onqF1TTF0KANSL+iqu1ysJM/IcBVie0OhbepNZgD
 JIVWUUgJQ3u/d3nm4jFrBp9UcD6aA5PTkHPMbUTh//17JBrKPPWftJ8PKzNo3ZyUv7de
 Fd1VN3FR6n0Q1p6Az/4Oo9YCfm1ie7xFbsLaNtTr6MlxwRerxmfevrDwGEErEcfnSbtD
 y0DRjv8zS6+DgKKjzJ/ZrlJebW2YNHhGAhFo3e6HQrb/tzxhQdQ/r4MeQdjX6aDQVNkG
 Pw+/iz5idWPoJ3Y6+o5j3xedMJCycXyoikbhYygCvfU4UZoOWvmu3bWK6CYwUB8+LPV+
 WF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408310; x=1774013110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BxHe4+DOmq20FSC3herHJvg5metbXtBJFuJ219tBZ0M=;
 b=CI7UIDvk7YivDUm33uTnZw9khj4MDWxwWl+Pq5brDOXhmkuH60cHqAkdIFqheFAsB+
 GZyujeNwNTkViATJ8BF6FLT4/rOVHZt/OFhKZCovwi6HioYho67u/q5cntm5NW+shPAN
 1tfqBrrdR9tkdaq6zv6Y3xWcZ4u8ti9XCviJ2yTDSAhAMpt+a28WLRhx0c3CQwN0bkqT
 4LZsCBomsV7DGuXMin8eV+0ywkbMvZ3Rl0vNiV/+CPIB6nlPs99bVamwnQ2eNIMtkGkh
 Kj9Wb4tfmafen0KOqfIrQCGf0K8xnyDtRselJjjBslcGY6SQWKO8DhZy4lpvwyfJmATg
 j1SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjki7IRMge9+hP1utts3PXp2ALnPIXL2EyedojWlKdo98xk9ZhyqpggjMsxPiMbQ8lTO2D9b6x1uA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4TBw4VTSdRx8i5ZxT9mxfKkeqbQm+b4oqP/oDiCg9qA0xniwb
 rT3xXqyaif2gGW1CJINh72S0NDa64crDIKyltPgKijO6B96l4xbaxYx7
X-Gm-Gg: ATEYQzzGT8z+wjLijBpdnhbJYBxOlLh+lxc9NWadlMX55LQOSPBluib4sUnocghLOhZ
 DPd1c7FV3yQJwnY1EjBuWYngItNjc6voD9Yr+dIji06oe0X0jjCWFsLPCedesACybnWUsUS6dJq
 Al/PCEyOWKKg6RAu7+2S8AZzA44ckuMm/sybWAdXOyiHpCWDm3U5LYpCNEul5X5q2jtPvH9f4Uj
 aejQs91ZrkDovFMOez6B492vAR3PELt7z3XkycM7YRrIn9gCMZu0UZg4QFCch7n536XWIlrOEz+
 xx0sYScopod3UULjY28w+BSAFfTRrqyR1UwZpZmwN5wTVogBnuOJBt+lZe395LV/iNX+rIoc9Lx
 j2cgqix7KPjuWwYDFxMYs2chwx8rQoWcAbK2it9GJ1nTxZwzr0r4jOa2ikmeEEATJvUnitbNnHY
 Tc3/NWE4Wlo4xQseIiwP1tFZGvLqS4oSKhKAwsPUmA+Nhfo6eb
X-Received: by 2002:a05:6808:118e:b0:467:268d:31cc with SMTP id
 5614622812f47-46757144050mr1803892b6e.26.1773408310188; 
 Fri, 13 Mar 2026 06:25:10 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 65/65] drm_vblank: use dyndbg's static-key to avoid
 flag-check
Date: Fri, 13 Mar 2026 07:20:30 -0600
Message-ID: <20260313132103.2529746-66-jim.cromie@gmail.com>
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

drm_crtc_vblank_helper_get_vblank_timestamp_internal() is called about
~100 times per sec, on a single display. It currently calls
drm_debug_enabled(DRM_UT_VBL) to avoid doing ktime_to_timespec64()
conversions when the debug logging is disabled.

When CONFIG_DRM_USE_DYNAMIC_DEBUG=Y, the drm_debug_enabled() is
redundant, because the following drm_dbg_vbl() already carries a
static-key optimization.

So move the ktime conversions into the drm_dbg_vbl() argument list,
then they are guarded natively by the static key. This avoids the
double-check entirely.

TBD: if CONFIG_DRM_USE_DYNAMIC_DEBUG=N, this does the ktime
conversions unconditionally, so this might not be prudent (yet).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f78bf37f1e0a..0dac7eec2066 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -803,15 +803,11 @@ drm_crtc_vblank_helper_get_vblank_timestamp_internal(
 	 */
 	*vblank_time = ktime_sub_ns(etime, delta_ns);
 
-	if (!drm_debug_enabled(DRM_UT_VBL))
-		return true;
-
-	ts_etime = ktime_to_timespec64(etime);
-	ts_vblank_time = ktime_to_timespec64(*vblank_time);
-
 	drm_dbg_vbl(dev,
 		    "crtc %u : v p(%d,%d)@ %ptSp -> %ptSp [e %d us, %d rep]\n",
-		    pipe, hpos, vpos, &ts_etime, &ts_vblank_time,
+		    pipe, hpos, vpos,
+		    (ts_etime = ktime_to_timespec64(etime), &ts_etime),
+		    (ts_vblank_time = ktime_to_timespec64(*vblank_time), &ts_vblank_time),
 		    duration_ns / 1000, i);
 
 	return true;
-- 
2.53.0

