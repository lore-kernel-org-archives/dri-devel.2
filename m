Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6046E10AB80A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C75610EC0F;
	Thu, 26 Mar 2026 18:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZMkGPyal";
	dkim-atps=neutral
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7297210EBF1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:49 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so936065fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551349; x=1775156149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=ZMkGPyalke32jfwoc3i7uNz2Gb4x03y5A0A/4NUvd4qEd/w+Xcs/lw2QiPsBaHEZRU
 PiMFJ757QHujz2cHiVEf0fi2GwZ0pb4DgULx2fG8snpGk62w1R+GLy6oWm2yPiWgy4b7
 eyM3H8fND1ubd9uZmjDiwGEHpR4WdhPXQzJp7X4oAkV2Kyh2J4LfuE4eCcOALxh42Lcd
 6IBQj90k0/TObRrz/b22rs4xTHG+9NUb8tM7s0XI0vOqurdaBrxY9+Zj0Rm5s+RG6Ldq
 OQewAhcQgPYSpvjo1xc2NPtqL3/u+k07pKLWN3Dq19qm21kbpbeRulikonSVppnA4Ug6
 5IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551349; x=1775156149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=JCiPSsgq0UA3FOt3dU5dD040Shpf63jOCy4YIRwjKD/Oyjt8ZfTaDQB4VsoEEKdte7
 yFOayPKzp1FyVAWIex1kHJddZDk3EO0HqKkpba46PQtGt9DQsv6QhIPzEUIcVyx64aHo
 y7TPYEhI2KDwLLUTt3+wWV4L0IjK5rFhFJPFwoaXGlZ1xJmcBthF809SKPHDPqNGZAji
 Njn7F42iTc4LYQ6qoeP9er/CQLwGyR+lrhy/AHE4MqMVrhdlb8xJgwi1yvM7/FUxxjHF
 NAWlc198VQJZZkvc5urUizMzzP/fjwFe5JTYoYd7LZB41SQSqswXC+KnliKpGCRskIWn
 9suA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF5nDKuVWyCcJ6eKZGyxa8Q4rDdj+DzeVLc1o+nfgd9qT5UycJNXrMARihKfBGAeEHx05exPxxWXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/Nri7RFJs0IJo1dqryh1bONKJHD4YPNs4Yr4ZE7NFSMM7QX9W
 3oCZj1foi2zvxnbaYKGk0+faIIbhPM106UwMMvAUugvcLauXKcEE5W25
X-Gm-Gg: ATEYQzy6TmO9I7ZGthnzUErYhmHCdBHODCVwe7q9y8VIaKxYKn3nS97erOQ5ck7Blfg
 KwLWfeB1h5R0ic93DMVbIbelYfETKpzI+c6wlBPOawh+Qo2By13WmLUT3cnCdnAf6BfuKXTtzVe
 JWAjsQR2EyW6w+SWTRT1GiMLMkJeJqoJxW3mzdghVLd1+nVB9oeJHGdWKemhxA2RoqTRuGk8yaS
 l2X++QLukhwV24VXR0Oi30EGd4GCKHmyhwTru5Q8NEL/9Tb8+sdwQUkdjcehehzQKWH3GNqn6QV
 pt35wlDj5ZHZCrHdUltCqrEGATQZDBnfEjAed1ghoNpev126YvcNLHIvqx69TPIHMTSXEe+y1+X
 1b81AykMe7wtvpSYOTmnEoG/i6eWSkaZDCWyGfk6D2cvTZs6UKVQ78YVelREFHoVl6v/cj8khuA
 JIJNPn1uKip9zjKWllyOGA1jHRX+z1Rwr5wc41pIEj6MbeZdyfUZ4zpcqj3Kk=
X-Received: by 2002:a05:6870:2f12:b0:417:a36a:6074 with SMTP id
 586e51a60fabf-41ca71894d8mr4456214fac.51.1774551348686; 
 Thu, 26 Mar 2026 11:55:48 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:48 -0700 (PDT)
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
Subject: [PATCH v12 50/69] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Thu, 26 Mar 2026 12:53:54 -0600
Message-ID: <20260326185413.1205870-51-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe has
drm.debug callsites.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 84b66147bf49..3af476f0449f 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -21,6 +21,8 @@
 #include "xe_pm.h"
 #include "xe_trace.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /**
  * DOC: DRM Client usage stats
  *
-- 
2.53.0

