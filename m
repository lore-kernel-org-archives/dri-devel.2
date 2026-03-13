Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AD9105F7AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E25610EC29;
	Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="miC9CbxZ";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E70310EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:52 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-4671cbce465so1104545b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408291; x=1774013091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTjuYz8WFf0eQNRg6nVDQpGTB8XKqFnwBf6Q0eE+UZs=;
 b=miC9CbxZA3Q2OVb7/3qLrlGvVdfoLr0E9PEeQcJfx5QYJTRR3/RQNUCoKee6T3a0qZ
 qAmjKIMk6XVo264IMUjBdn1NDFI1DlyUMK9fgPQCW3YlS0md4ZQIo+DqiQBowZL9CVKc
 jxopzN9BGdKhGevF5YZ0jOaXbfo90qQqGm1VpaxpsSR6IpCGiG/84PJt7vwlZaqHX8yZ
 KMpLU5hPOSaj13+1sk+9Tq6pZhGIU9vV52Tndh7oUL2/lWTdpNe5C/GsO1YPlmCA6dpD
 ZUnyGLyYJN7rop6lgwdg9K7qzGvdLs6zrEpd78WEndLO2dEDtzw5OIgJFSAI23XxnHKu
 QkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408291; x=1774013091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hTjuYz8WFf0eQNRg6nVDQpGTB8XKqFnwBf6Q0eE+UZs=;
 b=tYSEixlCoOgOs+XziwJSnzDTZ3jXP69w7P6HsEXhS91Swutl2mdzkpna6fUpyEbsd8
 DD/AfwlX0VJIj4aOHODheXf6G3vRWY4C7u01mOZnCfGSPwnrXZ5V2clISBw/UBjgeEPG
 MUY+7Na0yCYtHjlM8xSsDDPN5uHVWV9Em0iEK8rxapGLgwS4Fzt620wsL5kWFAoNob5C
 fLicwuVdAhRDT9TwqeAHPIQUzYrCogO8kcBPwoXBbld60ahDgYHP8m2wZX/sIeBmOYJt
 imTP3FAsZ6M/UX8roPHW0P6C/6oNCsaKYEzdeV/A1snE1aejopNezqwa4lgrvC4io4ae
 aI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlHkWUWz6Y9jTUZJjMwCSe5aNMjhMx/TxEn96k9bJMvSQKLS1SxDed76f6wRB15+WADgcAnALZDCA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrguZSzlzHXqS5YUG/fTOLs6xnoeZSOjVqlqjxk7IhR6LaY4bW
 9IXiRrPUxg3FOmqoQtKhxTwUnENuiXMM8ur+RAhC6cawHijf/NtgrC+N
X-Gm-Gg: ATEYQzyZMPlWqoj8mJm9viM1gsEi6Gsf0dpYTuS5mdQcuh3qk6qWYIF9Dj7AMpXmsL9
 F8GdcFklKmKAIwK8sLabSI+yk70YjbI2nkI1ZbszD25qmqBacCmzYGIO4E8j3/30jbbUzGlhXl0
 0KFEWn0KwU8T3yiTF8iHq7KwKvA+zMNJwKowSCbK6Xl1LuEh0GLkIzaDu5QubAOz4FixLGU4p7V
 bQjUPnb7ZvpxEDx1FJDjc5aEk9OdazotEmpn8O6mkRUbfE1o7HaYCApd6l6mbZsz5pjD33aVfo6
 +r6F2NkXp+No+UponZY9/ETk/XfVZnUxO1Ig45kFr6rQMjCVf6jJIRDtJMBF0t8jqiS1vgcBo00
 1IxkJSjoK35mIG+MZ+KvIkDMwmz0fZYal8cJAWscuvOTiaLdc+IGyeBPFrOthrA8ky2qqhpJmC9
 dk9A7ejsZBzTMR6cWpuH7Ya/ky/8Fg4YTimgPMdxD1r8ndt/ZzvbFoGO5H9yU=
X-Received: by 2002:a05:6808:3447:b0:466:f6ee:5bce with SMTP id
 5614622812f47-4675763031bmr1507247b6e.56.1773408291458; 
 Fri, 13 Mar 2026 06:24:51 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Ruben Wauters <rubenru09@aol.com>,
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
Subject: [PATCH v11 55/65] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Fri, 13 Mar 2026 07:20:20 -0600
Message-ID: <20260313132103.2529746-56-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index d0122d477610..cf2692d89bc5 100644
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

