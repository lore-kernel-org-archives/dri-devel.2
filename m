Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9103105F7AD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CB910EC15;
	Fri, 13 Mar 2026 13:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="czQYIsQL";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8381410EC17
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:35 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-467161c4b7aso1095757b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408275; x=1774013075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=czQYIsQLuF0FbFYZUigIVCp87VtIq/aJP+Cs1Map0OEeb/Aqe+jrbZX5uynErI8zUn
 K4VVtESQDcdG4chFk7XYBSSeXrj/iO2vD6wMH4p2gC5K2+7dWLz7J/zMRIlR6L4VZGvf
 TEH5s9TlcbUDuzJxqMW+9vwV+USKQ85tOcE5BtehWHd4y71D19xRJFjrCL87wZBasuGL
 BDsJNo+p5PnOQJ4egT4dc1+rF15alaL/i3j4D7W82DuWlbN0ctsJOcYCrsX/wYGs6tGZ
 pNUapJoxm0chOOsjA87x4eEEHadfupZ9z6lao3aRu+doWBB4s9LwU04mTC8zac9if+Hv
 YKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408275; x=1774013075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Ts/LFRGubV+qE5nUbczy5fsPH9e9tt1w1L0GvmpB2A=;
 b=LLQhuSQRtaT9bUxMltuTfLNwBCDSzhPsOwzyoe5p2eBLunRa+tv4VAsRbW72lXvksW
 P9cIP16Gx10BycQzmDxDsY7T07v/k/LGw8OeM+wsQrRqiU9kEsTW4JCBClNNgyrTlM30
 GIhoSBM+ZO+q+xZvfEHTLZ6wlDjDFUUROId/3W0+Qr32fM7tBKecESnozNBuS9L7MK27
 O4hK0zy6SnD96wKENUKgMsrTen9PVi58hQkwdHK7HDHdV1H9vcIKY7l8BzyFDBh43aO/
 0c0H08nFF+72RUQ/YCv1FI5+a8RB5jHxsro1119AuTQtEgx3oxXGTHH46p8hb8IjNInn
 Dz1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjVfxQbWJVOsPG8ge4X2RX+m9uCMuKUA51BUd85ddOjLqOvaGItrrA9B8eaR5wysk6gPA7qByx6AI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+CoCbjQPd0L0gsyrAzpW/l92xLunAyg6l5Sr/xSej3boTBIQL
 FvO0DUNGXpRihMzIu2yR0NuuKdHeVyzQ453A+6pdHjl/Df5zb5c6Jkg7
X-Gm-Gg: ATEYQzx5t81ZXrmUTQIPppEymQ2bAeoepZC9HLVFbUqrfFnVE2z11Q4hv6BogB1XJyi
 lN6TKxTdQOmIAJYLTRwJqhLD9PJ5AL0CfzY88JK9YqhU9yoKg14OGsIQtUdL5Rj++FjAKIWBn8E
 PWIyxvyYtQQQryPnSfxRuwoROzaIZimsvuttxq2Sz7dWmATkDy6pmSCp6PdSeVvvuS1oXeF31Ds
 /TLi11ONAlCHYSnz9e/WJYldATmIRpQO2acYwlBlkdEEdGUO+QYvX0dMiGVfNFdiXBbwWPaoam7
 3aNHCn0tc2zXi3GaeGxoeSTenqllhcVyoo2xzDoztzfQTR69u4u2Dfi+5wYD5OTHhYkrjhFT+y1
 72CWz8vOUGN4H0389+51VyzAIeHHUgIlaUjVRbasmHBs+4eqOIjt1mKmhVKJpuRAKk4ZBn9Ocso
 7x7McMrGY8ueFqiShbmT1gWsG6QaHluke52TvPsT/CQK5SdWDk
X-Received: by 2002:a05:6808:c162:b0:463:ab56:9ed1 with SMTP id
 5614622812f47-467570952f1mr1501954b6e.6.1773408274705; 
 Fri, 13 Mar 2026 06:24:34 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:34 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 46/65] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Fri, 13 Mar 2026 07:20:11 -0600
Message-ID: <20260313132103.2529746-47-jim.cromie@gmail.com>
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

