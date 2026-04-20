Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABF7EA71B1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 00:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E0710E051;
	Mon, 20 Apr 2026 00:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GiMbMkI/";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDE610E051
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 00:25:32 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-50e63771d91so253401cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776644732; x=1777249532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pD01rqioldlYsrskZpVddZZVgvRR2M6kER/Afl9Dngk=;
 b=GiMbMkI/llRXrOUt0SfwhHIfGZ5ENsd2DH6J3IaG6wrlZGpUEHYSHVFU8vd8kZzS+a
 0qdx6cfJ7voQpS030raQSaGRnOuHc6OHulIw2b1eddKXU4FdwHbumbsxuTJzVPY1ICk8
 inCVAYpzSlj0TkzZG40HWzynm6BoBGtuKOVAzvzNw+5ynU+YfUsZA3wgwM72F8VUCETZ
 Br+tQeeka02VyHlMdNFeRNt7ih7VrMOO3aLBsDBuCXIJemml8FZDNxgqE0heR5HOy9Hh
 nw1MldZWtY8diuLuJGYz4RQqDWMy1YsV24wL+c+hn64nRKYjkuqg6IaXH37XLjdRK3Wd
 Aofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776644732; x=1777249532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pD01rqioldlYsrskZpVddZZVgvRR2M6kER/Afl9Dngk=;
 b=GQ/2jXflWlVzvM0xbZu27JHbAcTzw2UNKb428HuAPLjM2/AIXYTRv6fGyOGWAAJmCc
 Dn312+579Jy9YnWnToGb6A8bvpvbrQHeOmj3smI5gUyo/Yd8QBzNigHWna0+6PRJHWpE
 1wdhZnj5+pq38D7y2Nr8eWuodz8AF9LXY2h3sS6JEjpqczoh2tf6aFEHcULqm8rxKVZF
 US6vvjsjIIYNV3FObih7PhlDmwAC+NYrcVuiyy1971KCOa8Q6AFhtTYTgENjFrtsmZOC
 9W319KVCsNLDn5faBqbG4FFwVOyBUxcJALs85B/rNOugE9UBec9GFt/2lEBPwfdvWDd6
 PQsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vMSWFir4F6hvcPU/msVHpPnWrY13wQbiYgh3EP0Yrg7iwAD5lFFlPZIfDH5bojXD00YdqT7lkT10=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtRS8N3RitoItNdypeneJBahORTQl4d0N6uYds6jSSwYXJfy5e
 vi0lYpxeoc1LsFXrcgJE3VTsU5/p/uzIefgtxahBF2SzlM1y5hnR+r3L
X-Gm-Gg: AeBDieuWrCC9DGZ7jl4Igi5+N900l4DQc9McxySEkj9e9ll65uuD4e1i675M9zM+T3f
 DKxmcn10GBshM32l4pkXB2j6OtoMjXNlLwwG1ZwnRwBS9+A9nZsFCFxwOFAUCIvx+Lc26HIXPTF
 VWGvts1fHC/ArQ0kLiz2lybUpicF9zFk32ODqQiHt24hxJNb7VZy9U1aQwL036oIPwhogH4alPZ
 9kGif6iRc1qdYsiuzTXUMIPL69Y97E0K7sdPz3rqeubfllWlmazPyjbqxtgTsrzamerAgRuwRkp
 KXcMH6reZWOPqyXCSdt/hrGn51V8qy3akGvjwOnoYAi3hr6RegbSA0sbkNFta9iy35wujAX2Mz5
 datARoHFWP7qduzfxvkRVUgmC/uV4Dl82PHitkCxNCFpurhY7DSFfTHHz9KUubVyRt9RwacgRCs
 DdW/j7/gfyYYK+91lWqJ+NCiHCFhYHDNHK932zjZE2XaGKVR8gbwktXAF/5xaNZ1AMxXwOBQ==
X-Received: by 2002:ac8:7c56:0:b0:50d:9b07:9c2b with SMTP id
 d75a77b69052e-50e36c8da62mr179916521cf.56.1776644731742; 
 Sun, 19 Apr 2026 17:25:31 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e392c7994sm71923961cf.4.2026.04.19.17.25.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Apr 2026 17:25:30 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] drm/sysfb: ofdrm: fix PCI device reference leaks
Date: Sun, 19 Apr 2026 20:25:13 -0400
Message-ID: <20260420002513.216-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
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

display_get_pci_dev_of() gets a referenced PCI device via
pci_get_device(). Drop that reference when pci_enable_device() fails and
release it during the managed teardown path after pci_disable_device().

Without that, ofdrm leaks the pci_dev reference on both the error path
and the normal cleanup path.

Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/gpu/drm/sysfb/ofdrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index d38ba70f4e0d3..247cf13c80a05 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -350,6 +350,7 @@ static void ofdrm_pci_release(void *data)
 	struct pci_dev *pcidev = data;
 
 	pci_disable_device(pcidev);
+	pci_dev_put(pcidev);
 }
 
 static int ofdrm_device_init_pci(struct ofdrm_device *odev)
@@ -375,6 +376,7 @@ static int ofdrm_device_init_pci(struct ofdrm_device *odev)
 	if (ret) {
 		drm_err(dev, "pci_enable_device(%s) failed: %d\n",
 			dev_name(&pcidev->dev), ret);
+		pci_dev_put(pcidev);
 		return ret;
 	}
 	ret = devm_add_action_or_reset(&pdev->dev, ofdrm_pci_release, pcidev);
-- 
2.50.1 (Apple Git-155)

