Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B1ECD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 05:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7BA10E217;
	Tue, 26 May 2026 05:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pSmXAm3G";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7B010E217
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 05:54:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso32470295e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 22:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779774843; x=1780379643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RC98wb6cU36LgWLCbGo1vO3EVKMDW2tOzzElJwX+SY8=;
 b=pSmXAm3GLAyV80ypLLDL9rqI9kvCK5wpKgjLl+1qMq+sBUeesLZm24f3Omzg2DNqpB
 EeCsZaD9mYEHaEKPIcmBdtx1egrs0+1Pno3rd0BXro7//sZ9OdftjqrBpxvlVuWMCqpw
 ZWYQR/0eADFIuw034tAaASptjxghgGBV9mVkO2HZZABWO28wFcbxREKqFk2G9UXUXuu5
 HpIK+NueRg0NlXkfqgnKUGJk3AVOje+29muHBL6kDd4gRT5a+5T5CKrtSZN+vmd1hczm
 A+RiVSm2vJ8hm2S+DVTgfGRwDX4Wn6fwuhW53ezqLBSTCRUbtK+IgNQVC2I6u0aGkv46
 EGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779774843; x=1780379643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RC98wb6cU36LgWLCbGo1vO3EVKMDW2tOzzElJwX+SY8=;
 b=NKpOKcOwnXGuPtZVJoAhw9cmxHggABc5NqRYiMCAD1OASwSbbtuYGljsPa6N/NRCnG
 WIR3xAeImY3mmTUycGTHQ7UQ8qpHd/YbMF4wzgzzyJjz33WWG8kt9KjMwuPC2PmYinqV
 Pzfx+ugI9m9TAcFiqKmi6BxKiAuy5bpzqSrYalC4oB911tdpbmgIaK/0NhPJyQzM+uwP
 tpL65BFPqNR5sIXQMOxnU0WnoPvHcpKamtiE3i45+fVML3DGOegmehbQLa4B3u5t5zON
 b712kziSchYg8q/+29YUMdQ9I9v/W1or26nSiuEP3PbkWtPp3bUT7NcHtVbeVE9bIEyV
 biug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uCOGcgQIrf3NqYu5qxJjavYvgVHCQFFJQqoofk8kxk7fDOBIGgKjmBGBLoIn6vSuR5vtc2yP9bhc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEPmXoyZCg7etB+xMg4g3pJyY7B+ptz3S1UIHVBFY5NKVLjf8L
 aVbRLnDA5E/XDuHcMuKrt8ezKY4Eh7Aszy1uvYaIJsAI1izDQtSL8prL
X-Gm-Gg: Acq92OEbJtINmSKtZEu1bYPS9to/50An5z8hVxKGJFTVwZDMQMnhnT7K8QipGf7vkDr
 CNZgINx0hI76MEb9HeBvm/SZol7DY3IX5xnQWTIeKvf1Mg+qNl947t/9p2TA/OD9K1EsOhrAA07
 UvnkYWfSX7tvKQbB1PUx9XlzDvTRxZ9k3F0xCx4GsfC9MjqfhjJ5Rt0as84o2PRgXhG8moKNcdD
 tQ12XGP8q5lJc2unag4foT8o59SlzsUmUXRoBTVCyrTqMGa0Lwjo3qNn3pmy5YyObYPe3MlJ3fu
 475VrVufmGI5ylGCtcao/1eN3IkBgVwE/OO7zKkqsBlGB3Eskqto5DtUpoTsY6lfws+xKm/pdOC
 /ld8JGem4eiRYuGUFm7qOvA5DcKkeNPa/7Al75JwNHSiyp2VOS46Kz6xE3alZ7SkWRrONQ6ReNw
 zL/CYi0DCGRtJD1Q2RKgaZ0rlXFBXzKO6uTp0INoHur3eQcHG9mHqbOqIruEAaImeCcQObr8lp6
 585TB539LLbOnmxnd4kKQ==
X-Received: by 2002:a05:600c:1c0d:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490424b3927mr313992635e9.9.1779774843281; 
 Mon, 25 May 2026 22:54:03 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d48e23sm31544499f8f.20.2026.05.25.22.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 22:54:02 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
 syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com,
 David Carlier <devnexen@gmail.com>
Subject: [PATCH] drm/lease: cap object_count to avoid order > MAX_PAGE_ORDER
 warning
Date: Tue, 26 May 2026 06:53:59 +0100
Message-ID: <20260526055359.17392-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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

cl->object_count comes from userspace unbounded and reaches
kzalloc_objs() in fill_object_idr(); a large value trips
WARN_ON_ONCE_GFP in __alloc_frozen_pages_noprof(), letting a DRM
master produce a kernel splat.

Bound object_count at the ioctl entry so the page allocator is
never asked for an absurd order.

Reported-by: syzbot+5d32c8bd82427f9c77cc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d32c8bd82427f9c77cc
Fixes: 62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 5d2cf724cbd7..bdec759187d9 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -466,6 +466,13 @@ static int fill_object_idr(struct drm_device *dev,
 	return ret;
 }
 
+/*
+ * Upper bound on the number of objects a single lease can reference.
+ * Real workloads use a handful; this is set well above any plausible
+ * value to avoid kmalloc requests that would exceed MAX_PAGE_ORDER.
+ */
+#define DRM_MAX_LEASE_OBJECTS	4096
+
 /*
  * The master associated with the specified file will have a lease
  * created containing the objects specified in the ioctl structure.
@@ -505,6 +512,12 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	}
 
 	object_count = cl->object_count;
+	if (unlikely(object_count > DRM_MAX_LEASE_OBJECTS)) {
+		drm_dbg_lease(dev, "object_count %zu exceeds max %u\n",
+			      object_count, DRM_MAX_LEASE_OBJECTS);
+		ret = -EINVAL;
+		goto out_lessor;
+	}
 
 	/* Handle leased objects, if any */
 	idr_init(&leases);
-- 
2.53.0

