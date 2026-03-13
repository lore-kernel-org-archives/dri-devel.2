Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A1E105F7AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B2710EC1A;
	Fri, 13 Mar 2026 13:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cn4uBlPQ";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AE210EC13
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:48 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-46726528f1cso1546996b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408288; x=1774013088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkvDWdY7OmvSXSpjnEXWJTz2q+ynFgJjHoQA2h5Gn4E=;
 b=cn4uBlPQnD4xb1VX/FDyKIceMKu9O5wBmsuYpo4Qtb3i1C8Lek4JzAi220qGfDToiV
 MOJ3bOdvW0wk1g3jyRMd69Il7YzqgzmnxMKfEG8Ds4npK2eQTYwjJflPGozGr641A5cg
 MchZTSVm5EVy6VoyWl1tqYIYXNrM3h8+1c7C6nrqeU8TikVswAZX5As9XTvieVFZNSsc
 mRceTTOhq8Ck72m/CluU7T+qzmlTodkA/MkZepkOIDS2hZ0dZsK5ptIbtvrMSEqK1J5h
 7bjfNmaAgOfesqIRTReplPgl8PcTa1mjZo+uefIseyHAaob/iJpZoEfx4oA6rCitA6/s
 zviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408288; x=1774013088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkvDWdY7OmvSXSpjnEXWJTz2q+ynFgJjHoQA2h5Gn4E=;
 b=CRrZ9lXR68xivOyic9D8ld1l5QSc2fxYQSHO6PWGX63auvslImJw7uADUYXSC4Unrp
 7JKud4ZFFLIpCE+HWmrRhHoZqMxPd4DgeXqoIRNNniHgSMVUAvrs4qcgtVbBSYS1darl
 KDfCawHa/z5cFvkm9HYJ7sOVGqWNqj/4/B1d4bPOar407KfIwvLSLcLTLgQX8sD8GpaN
 5MEARLzm7qlTeS1n8XkZ4FETUv7qpJ7oTgUSr5uraZrvFI6JKnGe3sWnlhUZXy4I8dLD
 kr6ySZIhubZpL2dm8JxY4Gv5fzThlhtJb+vrUFugxLkzjbv075BEjuaYUMoYGr2TweK6
 ZOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUQSxOMTo4uWWtDA9eVvT71KPwJBCQfCwcy5jMOpPBTk8WgEMav2VMr7u9mM52bjmFKA/dviguLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGL2htiWwixHepK1uJRXe/NEO0bBuEAkZZG3qBOyHmDN0Y5zzk
 vCQFZZ0xoze8Hfhv3JYCISwCh79LSpP+mXGo7SAXdwLUc0NEbzFFMR6X
X-Gm-Gg: ATEYQzz0satcdPL8fRKco34Pqc9eop8ZR2L9RQFUVer62eNL/UUj0n/ilPc+yZ1YQyO
 K9aZ6PxrMl9rJHK88cUVDRq+eeAf11+EhbRKRfiK43JCZYay+pGcRAGm99ZaXnR2eilb7k71Cqy
 1YhpI/V7VkiAzA5QT4lxDwsfrNmypiER34/qh0FdVAOboo9Gw2C+I24ZOb9dCxIxloGaWPsu4T0
 ccvYxotMeY59Ip8vjtjwGK1i9Fmk3PKbvGd7sarCZPVQkYNTs8mg06iNtOne6FePqwLyQYB6G8J
 qjkgKs9FXNOZs5NUzrvGg7xwuz5v4+VoW3rj+xsN7FOO9/xtFf7XqXNp5ntr8ml74KDnMoS7vY5
 Ag2y+JEspbq1KcjqA9dxPxzoFlx2c2V9n2ggrFceEJKma4xLsjZnO5y+bHKA0vfb8VYQx34EaAV
 +Js9yAQoLpA6gPUkMfa0DUdrbnzusFY7f3XDoOLZNPyeIKJYefkGVfFV0JpM4=
X-Received: by 2002:a05:6808:6d84:b0:466:f57b:2ae5 with SMTP id
 5614622812f47-4675742c896mr1590777b6e.47.1773408287937; 
 Fri, 13 Mar 2026 06:24:47 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Dave Airlie <airlied@redhat.com>,
 Sean Paul <sean@poorly.run>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 53/65] drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
Date: Fri, 13 Mar 2026 07:20:18 -0600
Message-ID: <20260313132103.2529746-54-jim.cromie@gmail.com>
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

The udl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/udl/udl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 08a0e9480d70..58fea20a1e81 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -21,6 +21,8 @@
 
 #define NR_USB_REQUEST_CHANNEL 0x12
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
 #define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
-- 
2.53.0

