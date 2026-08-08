Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA9EC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A7D10E1D1;
	Sat,  8 Aug 2026 12:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QfyDQDZ/";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573CD10E1D1
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:24:42 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so387271a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191882; x=1786796682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5h/jAHWXWXDOWdVoAFfHtjsJVJE0oZMUnASj9to5Sqc=;
 b=QfyDQDZ/tR+4f6oa7Lyf7PLtAMetIOjeBBNSVUCe5adcvF0Y3GdeppprlJvBSFDL+W
 Ap9RMjSR7G4x2UogiQ3ngD+YaQck1fbo5HtnXPNKmLR2ijK6BjRwo1rRCKLZwCLORXr3
 Yaz9hzeI3S5vCp4AMjwK1OJUOx1Xw3IJ8hzqDAZvDWScxy/dbdHGKjXCxdj6/aHxNahY
 0ztEhUlj3gMbZxb8bTepcQVUn78OjDpwk2aJrqXm40sGkC4R/TUUbOm3k0zPsurbp6u2
 B/fvS1fYxHoOXxFm/hidCheJg5ZHnZtNEMdBaBG88ExKjf8eSEOC4LjMRkT4OS0QsL1L
 KWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191882; x=1786796682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5h/jAHWXWXDOWdVoAFfHtjsJVJE0oZMUnASj9to5Sqc=;
 b=POXod/xpIcTEEGuoTrogUxflzCzPaWoP3uw5VSe+lbPPxxq5T5Y5vKVnFrBw8V+AoZ
 tNSELRhjwPt8Yj3+pFL0zPDmLYZ0RW/QrT7ZQmg6I68ZAuVLACDGaLZFSgVfAWmPlDvw
 dKiYLaNvywi1brK8Qsk3z20Y6C/Y+xA65OSXfj4QXKVcyOF58QkEUHTj4vgc/nbuv9sS
 x+KIU5S+jBNb3q3zdvTYWR6RSLmP7ZOvcWPRtQFr5F+seoljfyRwEF9rH3unlcisFGHl
 IomfpzA3RULYbvCY+93ZG7QIdnu377Nt5LuaiwpoPlnv+RrKINe10juDKDdtWH9RVYbj
 2pgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqF/d53amlmvpT/5Z+r4KO0k4wHUukpe1245BzL886uDLOmEok0TpKuWbCAG1Odw37q+R9za/5AbFk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIcN86au41azgEoyHBE8keai5uLPcKSN+UYvIoag1e7+ilUMGy
 k/68P0cMtCf5rypHKsJMd7H35hgoDh7/C5DZUFQjVA5U7mAJFCRNTpAJ
X-Gm-Gg: AR+sD10HnmBgLBciWiomqxPaDhs+5OjFgeCa2xfc5IMc2DRLgN8RenvgpAaTGQl5qL/
 WOst9kzS+LnfN0zNhZcGJ3ZU8FYo4l3w9JsxnwOFS5XY/AgXLfFWhH0y1+gZYOwdNIi+YMUkeNF
 Y9zN7CE6MUuwek6YdSOh0T7SivkHG6GycSK2w/cKwZj1W7/pDshKTLxrxSiACzFKEtejdOEOnqD
 EW/7WhTy6NWMzFhVGwmIGSZ7WMF/RlViW1wPR5QwpbSv5vuGhNzuGFgfpI9cbgQR6kIStLqaWP9
 43OBE9TZ95ZBFzPnWywZevEuFZQfoy+3aExuP4Fop7nowLamd+jmmr821voEbncyDKt2H95ntoZ
 aEH7T30eJRvlM0Nl9M4A67hPIVxqjsogDCODsaUNQNGELuDkWuC/YiyEGH8QUdXopg/ztT7ABA3
 qzKMagZq9Wb16IlB4r4dxLA42o/yyzVZ/PfMfMP8s+BfASv6FTG6Dh/3vFJQ==
X-Received: by 2002:a05:6a00:c1ca:10b0:84e:915:d7eb with SMTP id
 d2e1a72fcca58-84f2e0dbfb7mr27063894b3a.37.1786191881768; 
 Sat, 08 Aug 2026 05:24:41 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a5528adsm2145040b3a.45.2026.08.08.05.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:24:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/imx: dcss: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 20:23:54 +0800
Message-ID: <20260808122354.2825209-1-lgs201920130244@gmail.com>
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

dcss_dev_create() calls pm_runtime_use_autosuspend(), but
dcss_dev_destroy() does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call before
disabling runtime PM during device teardown.

This issue was found by manual code inspection.

Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 7fd0c4c14205..51398852cdc2 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -240,6 +240,7 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
 
 	of_node_put(dcss->of_port);
 
+	pm_runtime_dont_use_autosuspend(dcss->dev);
 	pm_runtime_disable(dcss->dev);
 
 	dcss_submodules_stop(dcss);
-- 
2.43.0

