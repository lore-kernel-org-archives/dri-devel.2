Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB46606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=tr+/S78R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38388112138;
	Thu, 26 Nov 2026 08:11:17 +0000 (UTC)
X-Greylist: delayed 466 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 17:11:30 UTC
Received: from forwardcorp2d.mail.yandex.net (forwardcorp2d.mail.yandex.net
 [178.154.239.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A66E10FDCD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:11:30 +0000 (UTC)
Received: from mail-nwsmtp-smtp-corp-main-80
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id 7884F80CDF;
 Wed, 25 Nov 2026 20:03:42 +0300 (MSK)
Received: from [127.0.1.1]
 by mail-nwsmtp-smtp-corp-main-80 with ESMTPSA id a3lrP22Zo8c0-dbNcXmfJ;
 Wed, 25 Nov 2026 20:03:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1795626221;
 bh=4GN2NjoUctxblUXPoG785/QR7v7He6l/la/VsAFii1g=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=tr+/S78R89GjelvqFKXJtvE39HfzS258I7qbcE+SIz9fkWHuD6ChISJm4o+nh/it1
 7fIP7xpIoaVM1U7VNt3l/UsvhSFH+VnjnMYnkKY0mo0FWLf3QXXPSZ/N9LcJYkwDp1
 Wz2bkhoF/3mRjabxVywEThlQ0M7/2jsaqyRX/5vM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80;
 dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Date: Wed, 25 Nov 2026 20:03:26 +0300
Subject: [PATCH 2/3] video: acquire firmware framebuffer apertures before
 mapping
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-efi-earlycon-v1-2-49ac2c0a430b@yandex-team.ru>
References: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
In-Reply-To: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Jones <pjones@redhat.com>, 
 Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

efifb and simplefb acquire their framebuffer apertures after mapping the
framebuffer. Move acquisition ahead of mapping, so each driver claims
the range before accessing it.

Also check the framebuffer size against the memory resource before
simpledrm acquires the aperture.

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 28 ++++++++++++++--------------
 drivers/video/fbdev/efifb.c       | 12 +++++++-----
 drivers/video/fbdev/simplefb.c    | 11 ++++++-----
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 21ddf4502ecc8..af4ce286fd6c8 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -747,6 +747,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (mem) {
 		void *screen_base;
 
+		if (size > resource_size(mem)) {
+			drm_err(dev,
+				"framebuffer size of %llu exceeds memory range %pr\n",
+				size, mem);
+			return ERR_PTR(-EINVAL);
+		}
+
 		ret = devm_aperture_acquire_for_platform_device(pdev, mem->start,
 								resource_size(mem));
 		if (ret) {
@@ -756,13 +763,6 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 
 		drm_dbg(dev, "using system memory framebuffer at %pr\n", mem);
 
-		if (size > resource_size(mem)) {
-			drm_err(dev,
-				"framebuffer size of %llu exceeds memory range %pr\n",
-				size, mem);
-			return ERR_PTR(-EINVAL);
-		}
-
 		screen_base = devm_memremap(dev->dev, mem->start, resource_size(mem), MEMREMAP_WC);
 		if (IS_ERR(screen_base))
 			return screen_base;
@@ -775,6 +775,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		if (!res)
 			return ERR_PTR(-EINVAL);
 
+		if (size > resource_size(res)) {
+			drm_err(dev,
+				"framebuffer size of %llu exceeds memory range %pr\n",
+				size, res);
+			return ERR_PTR(-EINVAL);
+		}
+
 		ret = devm_aperture_acquire_for_platform_device(pdev, res->start,
 								resource_size(res));
 		if (ret) {
@@ -796,13 +803,6 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			mem = res;
 		}
 
-		if (size > resource_size(mem)) {
-			drm_err(dev,
-				"framebuffer size of %llu exceeds memory range %pr\n",
-				size, mem);
-			return ERR_PTR(-EINVAL);
-		}
-
 		screen_base = devm_ioremap_wc(&pdev->dev, mem->start, resource_size(mem));
 		if (!screen_base)
 			return ERR_PTR(-ENOMEM);
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 6361861b3ccf3..28295829932b1 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -478,6 +478,13 @@ static int efifb_probe(struct platform_device *dev)
 			mem_flags &= md.attribute;
 		}
 	}
+
+	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
+	if (err) {
+		pr_err("efifb: cannot acquire aperture\n");
+		goto err_release_fb;
+	}
+
 	if (mem_flags & EFI_MEMORY_WC)
 		info->screen_base = ioremap_wc(efifb_fix.smem_start,
 					       efifb_fix.smem_len);
@@ -569,11 +576,6 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_unmap;
 	}
 
-	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
-	if (err) {
-		pr_err("efifb: cannot acquire aperture\n");
-		goto err_fb_dealloc_cmap;
-	}
 	err = devm_register_framebuffer(&dev->dev, info);
 	if (err < 0) {
 		pr_err("efifb: cannot register framebuffer\n");
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 60e5dcec201ff..f682ead384bf6 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -599,6 +599,12 @@ static int simplefb_probe(struct platform_device *pdev)
 	par->size = info->fix.smem_len;
 
 	info->fbops = &simplefb_ops;
+	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
+		goto error_fb_release;
+	}
+
 	info->screen_base = ioremap_wc(info->fix.smem_start,
 				       info->fix.smem_len);
 	if (!info->screen_base) {
@@ -632,11 +638,6 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (mem != res)
 		par->mem = mem; /* release in clean-up handler */
 
-	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
-		goto error_genpds;
-	}
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);

-- 
2.56.1

