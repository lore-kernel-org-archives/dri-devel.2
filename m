Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F778F3D5FE
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 10:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689D610E324;
	Sun, 29 Mar 2026 10:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7czHKNi";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE3C10E324
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 10:18:28 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso2464061a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774779507; x=1775384307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d7b45bpAQ57JsmUViAz4jU5XnEGPo0qF7/rcaW71MRg=;
 b=j7czHKNiVNY93S/lN5QpvPCla/hscur4KLDsfgnHwNXvIjObnCOfX8f+mc7YtMOtdf
 NicQJTIudFc8YTklA65jSfBsb81sVLW7tdFRu5MDgk8N1yWPd7nJJspDk4Ibu/VnHI+f
 MV9yNzi0YX58ujKAJxl5uGi9O5cCUwuObc/6AOTIkkiqf0BJBMuqTRfeKbcHHUC/erRw
 gfxTg+xUUnOQhHpq+YIYzaPvt7aKIr5WJoLRVtCsdOOgYGu81Hb+Ib2BeChw9zbkqnn1
 cj6qhGoTyX1ARvC+LV2UOSztNSUoWrsXJf0yTyUsexA5ub+CO2khywenfaPXb3tI6kvV
 qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774779507; x=1775384307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7b45bpAQ57JsmUViAz4jU5XnEGPo0qF7/rcaW71MRg=;
 b=IEUF2VzGhnmEnbMHJlR3IF2lW7iGLyMxD13+kEuytzWIM1MQ44KiVvMJwuyAkU3ZOl
 trq+VdlCE9wnknh2ar0DgLyEUkZi5R5e4aIMjN617LN2oUdIKKCgdTBXNHDjJEw9DIbu
 RfP9t43YXZUHivWN6q8ljweV2QIfwDY0iPYusQUgWsIKBdnkDjE+qIEw7sv2wfs2QDTt
 Kf32T1TVsyrO+q1JgrXdH9lY/TrU+A+Jx8JOUCCDXgrs96nscXHcwgKv+T1YJht77Ksa
 QPqKXKb351m9vyovRnAgjxL4qCwA2bACFXIzNvqssEpw7xwov/Dr0Y9GgtHeUknaGhIY
 fESQ==
X-Gm-Message-State: AOJu0Yzgt7aIb2nnDTAGKcWxJywbSQ4XjMN8TnuIMwz8VEIZgj5n2fh5
 Y/Pp1dLECW+aeeR/TkWWw+dHnH5c/XlfTY50F/9rvUxCPHV2SdgIClWA
X-Gm-Gg: ATEYQzyXEC+alU8sSGLr9UJeRA48RFf19cQ1V9fxPlXgE4StHmk5VES9mSiD7ngfH74
 +W5jIeGRy5MOjXz+Oso7rqUewm/mRLhOrut9RLr2EsSljGqUL6QRLUCV9CaVB3Geq2fY7t/IT2n
 UT7igL0UKtydBVTEKBPKWcMAROVtp3XfC6H1UOTW1AWczYlVw5sfOHcLaIUUI4YJDTTsE9Plx59
 Ipc1gWBP5XXXDZbnTvzhaAe4jLOAe+xu8Erp+Jjx9CfFWx/WYIIhgjBUPnn3AmyHQ7E507zbxB8
 UvfKZTDcersAk2jbPln1SD/Ng/ylYuEqpcPKPi+k6eLoGpmph44jFefwxJ4jxUKdciq4f2kJaLy
 CYBQVWx5RqQKlMOqwj5W28u5ULxrpAHd0dOlXC1R8+qwsq35WO12BC4YAobS8C2frGmh0duduY6
 HkyWURofTqdFQ61jqau2jjz333HQK4Hm+DgSO2mUOoWdoMQWopWUpyN5xtCAQCQL2dC/9yNw==
X-Received: by 2002:a05:6a20:7489:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-39c878aa3e3mr9089040637.16.1774779507464; 
 Sun, 29 Mar 2026 03:18:27 -0700 (PDT)
Received: from dileep-HP-Pavilion-Laptop-15-eg2xxx..
 ([2405:201:5c1b:7001:f5c0:728b:57dd:4e75])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76917d843esm3876218a12.29.2026.03.29.03.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 03:18:26 -0700 (PDT)
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dileep Sankhla <dileepsankhla.ds@gmail.com>
Subject: [PATCH] drm/panic: Fix panic logo alignment
Date: Sun, 29 Mar 2026 15:54:54 +0530
Message-ID: <20260329102454.11357-1-dileepsankhla.ds@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Display the panic logo at the top center of the screen when
drm_panic_type is set to DRM_PANIC_TYPE_USER to keep the layout
properly aligned.

Signed-off-by: Dileep Sankhla <dileepsankhla.ds@gmail.com>
---
 drivers/gpu/drm/drm_panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index d6d3b8d85dea..c7fecc5e857a 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -491,6 +491,8 @@ static void draw_panic_screen_user(struct drm_scanout_buffer *sb)
 
 	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	drm_panic_logo_rect(&r_logo, font);
+	/* Center the panic logo */
+	drm_rect_translate(&r_logo, (sb->width - r_logo.x2) / 2, 0);
 
 	msg_width = min(get_max_line_len(panic_msg, panic_msg_lines) * font->width, sb->width);
 	msg_height = min(panic_msg_lines * font->height, sb->height);
-- 
2.43.0

