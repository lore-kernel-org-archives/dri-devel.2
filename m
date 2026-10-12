Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3065ACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFB510EC84;
	Mon, 12 Oct 2026 04:54:37 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A0C10EB8E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 04:54:31 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-93e51d8d400so106079485a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791780870; x=1792385670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PuHBSXV7yW2x9o5OulJKxyEwHsRVBDck1C3zxeqGePA=;
 b=VbgYyjpgl4/bG1Yg8DqdTVJh3k1XUk3CjThSKk+GUhhdopqA48WXATgA5y2RQJga/V
 hYhA3TsjBRINP52DPE21o1JB6skqxra8/NuQtmVS3UucRMo3AuTSiR3mx4TInvDxFHXZ
 untBpB9+Pj3STaPquZHJp2ELZM0UvTWoya/q5kpfkIyqsXeL23PtefJwG87SAc1tAPt+
 BtrJ2+tpHuhHZjp8RI2+FYE7o5xeTEM18DRLV9m/x5hqi44DkvQovQA/w4Ur7mNHaE/6
 bcYwWEZCVUOSSpuiQEi8xme3vr/tTK5DIQ7vPn9dzGYkFOIgQnrju4I7AdiImnRl9fAk
 GQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791780870; x=1792385670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PuHBSXV7yW2x9o5OulJKxyEwHsRVBDck1C3zxeqGePA=;
 b=ZRK1SiF60d5oyEjY+zEmR8Q0lqpQYPl8+SOMwE29cl7z5p6ZICEbyTswqrMCih3TIx
 L+sM4HyBMvN1jmQ4+OoxGQFwysrPoWbRWb/hZuwn6hNIM2kHabA9SRUOGIxVT3X+SvuA
 RiWXT4C7yGFvD+LLeAt/6oXfDiLrjQoGVmJMLEuK39rx26Kbi1I04QDhsKq9+Jj54IDN
 CApvfhfG9U/OreUVpKUHLVE/vK6TAPKpOnAYg4MiVkmtl4NbY5M+nZltj+YJn3VNnyC5
 o68yLTyuNKwg5nPgylGu30h/wakW4/UK1zLfN9fvcs4nHHxAyGihnwFcPRW+DmM6Bom7
 am/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGgoQZYar0QXghU9T73FhPWbM/k5AQjMtv52IzFl8cBnxLjZzLbjPc4frhhdtRznnu7/VUohKQgGk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLfq/mnx+hHkuqToMxksJ50tZilHaw87738sfKNu6zAIHYx7t/
 MbvO4R/9LiyRUh1UTFjG5e4qrRLEwLaO1LusLEOi44Mb9/fk4SiPC3g=
X-Gm-Gg: AYBFou21wLn8lWs0Nj3UeLRW3K0tiz1Me2bNJXVjpTJd4TWGLCfuIXlhWb2il6nYsm9
 CHqQFriuEzA9PBpcF7vuSP1xo+5OmxSO3VQHFQyyeCSuivXGL1pYL3Z2jG/QrfW+h+0t2Kif/IA
 m1maw7Nxwo4o6OlvnptKH14m9aHFCTmkJV8IXrpS7rbQTWkJFifRq+kADBaltZUMMZnGNluOgbh
 1QHgFLXe4p+VzFjDJbFndiyo18P2amFN1xs36MXQZUnr1AXlWVR7+/7CFH0dApUwnuRWfE/k0vJ
 ObyXUVtC/SIm7i5WGQVDtVw9ZBCu5nuLuiFIiJy+45PNYqdrjx0dAMUwZ0MLkcD1fqH74619T9O
 zV6yWL67PCrZNCKfRHL/ZUpDK0rFBOrLSkterwNrFf0bfr87t5LJrT/1labT73TlrVZWAXy//pw
 rms8RjD6zt+q8c6jfR0MSND0S+IFgPHdjBWp62yFo7lPk9K4p2/Kd5xW8UBtFDZxhm7cQFsACbX
 SdhJR+7jbtMq7ah2ftUmW0SdtJ8pnG7Gm1mknsBJXIRKsNJK5+iCXGrcZvFHfn3iLTbWuoIY87r
 E+oJcUeuWxDdWreeH09qZb9sEvKC
X-Received: by 2002:a05:620a:2993:b0:93e:5870:12c5 with SMTP id
 af79cd13be357-93ebd1ddbc6mr1383552585a.16.1791780870545; 
 Sun, 11 Oct 2026 21:54:30 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98c6b4bsm768589785a.34.2026.10.11.21.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:54:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/logicvc: keep the IRQ within the display resource lifetime
Date: Mon, 12 Oct 2026 00:54:23 -0400
Message-ID: <20261012045423.166389-1-mhun512@gmail.com>
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

The managed IRQ is requested before the managed CRTC allocation. Probe
unwind can therefore free the CRTC while the handler remains installed.
Probe errors and remove also disable clocks before devres frees the IRQ.

Request the IRQ after display and vblank initialization. Release it on
registration failure and removal before disabling the clocks. Keep it
installed through atomic shutdown so pending commits can still receive
vblank completion.

This issue was found by static analysis.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with Clang, W=1 (x86_64): logicvc_drm.o and
logicvc_crtc.o. No runtime or hardware testing.

 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 +++++++++++++--------
 drivers/gpu/drm/logicvc/logicvc_drm.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..cf60bbb9800c 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -366,6 +366,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 	drm_dev = &logicvc->drm_dev;
 
 	logicvc->regmap = regmap;
+	logicvc->irq = irq;
 	INIT_LIST_HEAD(&logicvc->layers_list);
 
 	caps = logicvc_drm_caps_match(logicvc);
@@ -385,13 +386,6 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		goto error_reserved_mem;
 	}
 
-	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
-			       dev_name(dev), logicvc);
-	if (ret) {
-		drm_err(drm_dev, "Failed to request IRQ\n");
-		goto error_clocks;
-	}
-
 	ret = logicvc_drm_config_parse(logicvc);
 	if (ret && ret != -ENODEV) {
 		drm_err(drm_dev, "Failed to parse config\n");
@@ -434,16 +428,26 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		goto error_clocks;
 	}
 
+	ret = devm_request_irq(dev, irq, logicvc_drm_irq_handler, 0,
+			       dev_name(dev), logicvc);
+	if (ret) {
+		drm_err(drm_dev, "Failed to request IRQ\n");
+		goto error_mode;
+	}
+
 	ret = drm_dev_register(drm_dev, 0);
 	if (ret) {
 		drm_err(drm_dev, "Failed to register DRM device\n");
-		goto error_mode;
+		goto error_irq;
 	}
 
 	drm_client_setup(drm_dev, NULL);
 
 	return 0;
 
+error_irq:
+	devm_free_irq(dev, irq, logicvc);
+
 error_mode:
 	logicvc_mode_fini(logicvc);
 
@@ -466,6 +470,7 @@ static void logicvc_drm_remove(struct platform_device *pdev)
 	drm_dev_unregister(drm_dev);
 	drm_atomic_helper_shutdown(drm_dev);
 
+	devm_free_irq(dev, logicvc->irq, logicvc);
 	logicvc_mode_fini(logicvc);
 
 	logicvc_clocks_unprepare(logicvc);
diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.h b/drivers/gpu/drm/logicvc/logicvc_drm.h
index e0f4787c69f9..f69538e6c0e9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.h
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.h
@@ -53,6 +53,7 @@ struct logicvc_drm {
 	struct drm_device drm_dev;
 	phys_addr_t reserved_mem_base;
 	struct regmap *regmap;
+	int irq;
 
 	struct clk *vclk;
 	struct clk *vclk2;
