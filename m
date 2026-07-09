Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB24C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6210F4DB;
	Thu,  9 Jul 2026 10:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F/D+BISY";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE2210F4D0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:53:47 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso917705f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783594425; x=1784199225; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YPjUMqEmR24+93sJKKscz/hlX989oAE7Njr6XMslinI=;
 b=F/D+BISYC0opOdwOrn0VsyBC+htEKevYBlYNrhcw2RhXYtzdDUj8Y0bvFZkqyo9qpN
 FGDN6fDMsvTgcTDcWI5UFKGMmlYHLdkkPvQDqNM/cL/9iUljGX60xn/5js/Z8QmItvjH
 XII5WVcSsKlCiUxjYiNZOM4ODKzJ43aiTIPTtaDO7twfqDunLhnxLK2ZcV9m/Jd/n4C+
 XxDcBY+gPYxtj2NuBAiTOB4PUJOJqUDmL09ATl9W5CaQZG4Zp6NEKtMae1qRnXmWv/0e
 vWtT+YIRhZbpgcFy//adO+L0rDZSld5O5rxWPzZzDY0uJWqOyf/DTsuRnvBLGgn2voyd
 ds0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594425; x=1784199225;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YPjUMqEmR24+93sJKKscz/hlX989oAE7Njr6XMslinI=;
 b=S4FrclUusWXAVpMQPP0CivEMX05C22S2gLXL0L/S6iXcRsK4g78a4F9oMdU6A9Dma+
 ctpSEltLs2bUHaYpJGjl/xhjS+INTCsjLgyyJ0yeQZ3lGFmperqWoHJhA5fTjHfCci7N
 Y06G1ZKbdf7ECJj68XPdyG3g3sqaXcEsVIFrU85CgKnF721d8XkeyuD1NuBL8Rr/mWOO
 Vkqn4Q4pAHnSFmNFFTfFSi2gKtsPI0zkp0G2dkKx9af0XbdYKPydQh96MEZudjNFCf4D
 8wj7fjNl+biaVR8e/7U0r4uSAtYuP/Q4l3eRQYncEih02zeLLZQ7KnuKyrtYOrY4PKSn
 J9vw==
X-Gm-Message-State: AOJu0Ywhsv+WnbP8sTYbuFg4BNh+HhbijO+l2CL1Pi9Mo54LIXEct18h
 XwH3S+8CoaC+0+zaNR6gird0Rx0ciDm6vDcnencTfm7d5pB99AU7UzcbuoioQQ==
X-Gm-Gg: AfdE7ck+FR5HUaXsIzoq3zc2F3dDZaXxleDLZRh6zCLTqpDRUsp9uUn8pgihTKpJSV4
 vwI4sgZjAYyPBXeJtT1zc3qbTI2JoorA7RJwHfT9OwYQz3ARFyFGAgG6g0UXhWZTyWt3+7rtJdu
 7IJUjbNbVlDUkryIiymAy7uctP7iNn4gXJ1Djd43rX+mV5HdSc9Vp9Kyv6d4qX0N6BMOcupf2ld
 Lj4Stkudg5Q1H/gp/orp42hqo7LXCHFj7VJC4H9oQqe5xZsmnEbE2MbSWDIW35lkMcYRT4z12vU
 iw1NTzBYvcNB/SXvfvI/id10YJocqKvVfWCBYNUvAhIxANXGf7BBYmlEJjGCxC/HJKcqNGHar0S
 CyiIlOmXL/IMj7LOs1AdvZHS2kKWAzMCRtLSMNgjlLakAakLKLX/dERY82C+mb8GMWTFBkFTXQp
 tM2If9kc3MEUiY6mgU9o/tKwk/4AxUCjHbo73PjoV9Nd+1oyRzFiB7
X-Received: by 2002:a5d:5f51:0:b0:474:57f0:49f8 with SMTP id
 ffacd0b85a97d-47df07a988fmr6552629f8f.4.1783594425382; 
 Thu, 09 Jul 2026 03:53:45 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.233.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm55275558f8f.4.2026.07.09.03.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:53:45 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 09 Jul 2026 12:53:24 +0200
Subject: [PATCH] drm/solomon: remove unneeded variables in blit functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix-ssd130x-v1-1-1272cb3dc85e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W+h0OPQr4kHWqr2orCCC+HeLx
 xCSB0yKisFQPVDkUtNjdwh1BXmb91VQ2RkaajpK1OOiN5pxaOlGTpxjH+aFUgQvziKu/9s4ve8
 H95WCKF0AAAA=
X-Change-ID: 20260709-fix-ssd130x-d7dc491af074
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
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

Remove unneeded 'ret' variables in ssd130x_fb_blit_rect(),
ssd132x_fb_blit_rect(), and ssd133x_fb_blit_rect() functions.
These functions initialize ret to 0 and return it unchanged,
so return 0 directly instead.

Fixes: 2258f03989af ("drm/solomon: Move calls to drm_gem_fb_end_cpu*()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606301409.I0ctsf41-lkp@intel.com/
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Fix unneeded variable warnings reported by kernel test robot in the Solomon
SSD130x driver. Three blit functions were initializing 'ret' variables to 0,
never modifying them, and then returning the unchanged value.

The fix simplifies the code by returning 0 directly, addressing the static
analysis warnings while maintaining the same functionality.
---
 drivers/gpu/drm/solomon/ssd130x.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 4907be694aec..0940eae7a2e4 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -897,7 +897,6 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
 	struct iosys_map dst;
 	unsigned int dst_pitch;
-	int ret = 0;
 
 	/* Align y to display page boundaries */
 	rect->y1 = round_down(rect->y1, SSD130X_PAGE_HEIGHT);
@@ -910,7 +909,7 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	ssd130x_update_rect(ssd130x, rect, buf, data_array);
 
-	return ret;
+	return 0;
 }
 
 static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
@@ -922,7 +921,6 @@ static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
 	unsigned int dst_pitch;
 	struct iosys_map dst;
-	int ret = 0;
 
 	/* Align x to display segment boundaries */
 	rect->x1 = round_down(rect->x1, SSD132X_SEGMENT_WIDTH);
@@ -936,7 +934,7 @@ static int ssd132x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	ssd132x_update_rect(ssd130x, rect, buf, data_array);
 
-	return ret;
+	return 0;
 }
 
 static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
@@ -948,7 +946,6 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
 	unsigned int dst_pitch;
 	struct iosys_map dst;
-	int ret = 0;
 
 	if (!fi)
 		return -EINVAL;
@@ -960,7 +957,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
-	return ret;
+	return 0;
 }
 
 static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,

---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20260709-fix-ssd130x-d7dc491af074

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

