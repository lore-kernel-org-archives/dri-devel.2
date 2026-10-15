Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822A5CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E2810E216;
	Thu, 15 Oct 2026 03:14:00 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9162610E216
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:13:54 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-917a20e9efeso68213286d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792034033; x=1792638833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=153R+e1jrYKRH+HNspTdkqqncAprD2wZmZQfnSo2QmQ=;
 b=Ffw+7DjkIOnOVj2ZADvTcn3LYPFzPkvJ9FHVGBzo/XFJZM7CFHnGmSkzb43cM5df5p
 ixTl7uW3Pglgg9iiZ8q1caCXNP8ZdJKoGXPQYMknXLSbu4iKId5Q0zo2cSwnPUzSKuOH
 9EhSkVy0zsDpWI0JzAAsos2nS12oYsgEmNHe7M2PNQckfJ27OmV27VzMQ3RICAQnfqge
 +tLosaqt0QshUxZwk7KhbARqjRYkSSQLckMVmSM9Eiy4evh6NaIpXxRpQIwdUfftcCYZ
 /WTIYS53bGHs/QnwEiLUKKhXsuvhCdtUYl07l+pAo7J9NtZF3C1CeUqP0y9yS7dySOnk
 ottg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034033; x=1792638833;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=153R+e1jrYKRH+HNspTdkqqncAprD2wZmZQfnSo2QmQ=;
 b=ZgEkGUjwT1JjQmXpg940S2gbOF75J6XCp0utU8xsVTw2PEpvHAE8s4NgNc6V5N46g8
 0+iBNOyCCtY50gksaT0966TrI6dilQRJJvo5e/1QChFMk0w7H6Z5O8A+e6+bmnYFWpDE
 kjpNc9XhEJSoawRVOvPatsLZbYf1lB4y0HvjRE0MvRXsaYWBoiRMdJYztTWoB6aRspiI
 CSRN5E+oCcSaTOP7QLbUqRDDdmdn2vEneikX0Wj063QRaFPgLimrKbAUsZ8F2Z0SyO5z
 91c/dsc/pZpKk2ArExSGNk9cu0wOfVgHpG8tk46n5OWhVq8ak3RgKsrX92fOZHAAu/g/
 HppQ==
X-Gm-Message-State: AFq9FYLPLn621IZiXlTtSjiXfS98MmntJgOfs3wMgEb80SjqwBWgP2Fi
 WwD3bG9uRuc7uO/BboPonemAytdlyw4IdAUURzqh6sT2evpxjSRtIhQ=
X-Gm-Gg: AYBFou3VbLLv0onDsAAIRSUKWlMAhVedmqXAiH4rN6GtakXtQujpmkWcGQZuGYhywe8
 BGT/ar8HpC2uidIQu/uT4H5mEpqJdYhidm+jtnpLuR5dV1Tt9+fTsFceCbmGNHWhIQmK3iR+woO
 ey44yQekdgT6D8mUCqdZbYQXf4EAKdekEDsnNw5+9V/hyzt/ECX8tiQBcSmGAli2jEXUqkW8BEY
 dYKBRJwUftQrwhkFSbtSfTYw/Uq7VYJt8yhz/s1Kq8eACFIwnIXHN0qBBRWIm01NT5wGLNSACQG
 QOYvhGJfJ8fpJzUjJzRx54senH/bxAVmDa7yjg5iwtWtVeT/6FAxqYb+cUho4K+i3vPpvbqJY2S
 bUtY5yKezNCW9GRdOeFtiE34PwHKnYmfJMArbLyuAt9zvSP1AWXMhLEGxrnQdMvBS2NSzINh0pe
 1kGHCVlKKtfaG4TrcnyI6wTrduZKEPb6Amscre1tqVEphjNRamx97YXprcOa2KVlrvmOtx7g6p4
 FcIL6fKQGrJ5A6LnVbF/WuFfCmDAI6klxnnSx7s2EuYz7/9wWQYHcpsyFqx68ax1McZTr+4Ahxl
 UU1VTnlq3z6FSrbdOjNyRMOrZVdJ
X-Received: by 2002:a05:6214:1d28:b0:91b:87cc:6d52 with SMTP id
 6a1803df08f44-91b87cc7740mr169108536d6.0.1792034033319; 
 Wed, 14 Oct 2026 20:13:53 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97b387e0sm69717646d6.12.2026.10.14.20.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:13:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/logicvc: keep the IRQ within the display resource lifetime
Date: Wed, 14 Oct 2026 23:13:48 -0400
Message-ID: <179203400409.2736079.4502160101423826217.G31.logicvc-irq@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The interrupt handler accesses the CRTC and the register map. Its
device-managed release currently happens after remove has unprepared
the clocks, and the CRTC is allocated after the interrupt is requested.
Consequently a running handler can outlive the resources it uses, both
on removal and when probe unwinds.

Request the interrupt after initializing the display objects, and
release it explicitly before tearing down the mode state and clocks.
Keep it available through drm_atomic_helper_shutdown(), which may need
vblank completion. Also release it on drm_dev_register() failure before
unwinding the display resources.

This issue was identified as part of our ongoing research while
reviewing kernel code.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (arm64). No runtime testing.

 drivers/gpu/drm/logicvc/logicvc_drm.c | 21 +++++++++++++--------
 drivers/gpu/drm/logicvc/logicvc_drm.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4f..cf60bbb 100644
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
index e0f4787..f69538e 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.h
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.h
@@ -53,6 +53,7 @@ struct logicvc_drm {
 	struct drm_device drm_dev;
 	phys_addr_t reserved_mem_base;
 	struct regmap *regmap;
+	int irq;
 
 	struct clk *vclk;
 	struct clk *vclk2;
