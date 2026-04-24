Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C80FED3F7
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E0210F66F;
	Fri, 24 Apr 2026 17:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JuvpjmaG";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE5910F548
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:35:12 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso49380205ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777034112; x=1777638912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ru7oTacAH1AHj/CyXoHHypjd6b0Mk6YIUe6NpkAx0hI=;
 b=JuvpjmaG5TIlsXFB9B/ciaWb4v/jyNKPqQeZkFBFE5WojYA+TqtuVLN99okcEtYl5y
 owFyOE6A3uTtp5mj9LuFFF8eH/4Xxmmfz2wBYIr1pn8m3w/p2fMQDSt2yZc9dEILDjgB
 kxn79tIdSfF+SQzIrW2I5FTK3at/UfgkwaM5NIV8fKqkGMCYFpK0tlGbASrBjIgGauoo
 OCNVmERWOvsne1NaSH2pmsnl20t0j5faeKJDXOF4+UADBcTqu9E3HG8lKT45ysc62D70
 VOBYND9TdhCSo1RR37AS7MMpO4A9GRSv/npLimfbo12e041erEpHkxp9T0pQIP4KNtC5
 6AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777034112; x=1777638912;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru7oTacAH1AHj/CyXoHHypjd6b0Mk6YIUe6NpkAx0hI=;
 b=sIAXEPAmLHBeErvqnZf0jKhS5V2b8z6TgCIusZk3NpYO1/XhKyhj2kR7AfBz27HFBo
 QqNTMCqsn+kT+kB6AfPF/EpmRgvBsjEvI3NDzhAFI/C9HQeD4Mvj7hhXHnVmV3A4Ocf7
 sxwvH8Xw8DHCz+N4Xm8eftXi7QxR8yLYVojSnJvzKNxuHql/ma6Ntn7zmNGc8wnDMWrT
 g++2bh/ap3RwHnwnBPT7SELHSodOJdXv/6feHHDAlaQvtbtu6kShgKUPKKKfVLyRZqdR
 2NIWlGow1RrD6y694WpGlOVfBAE5wjlUxfzM+zVg1mi3BKuADjAniUGLQRIaQDkEtOU1
 FIJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tsvFSwI31rOEnfCzF+yCxtH7EzPQl230n9uW3oQ/xUMf6ndIMqb43hOqzUMEqV+O2zWIk1J3ePvA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/z/HClAvnFet1s65WgccMcLpDAAVSmSCaGVF5lWg07J1/Di1X
 YdeMOIvYN9k1zDigm6EklXpOoONw7eNz5BSiEMWsjSOIYbbaVrbbyfQ=
X-Gm-Gg: AeBDiet9CKrKiClwqeRCD4OFMoER6r3ujWVe8XGFF3Kq0+FvYkIGan7zV0GY6B5IZv6
 4p/HjOsdotv0Q8pvvsQ+ESuRIbZxhvhVfyzkHqCv5qPnUbnNprMChs3D484zeVwSzq48AdEF7DJ
 PD/Q1iE1EQmmBHwnILR+XxZ9Pp2h2lVbhjogT0pjk2deDT4TYYs22HxaJ6jdLaidEb2LUNH1Ucv
 bEOSkiEek3eWvrILPiJNju7H1DkdLiF42icksiLi//jFX1dW+ZLmmYsHS3EtVzVZDQjtsmlY9u0
 ox7HkuTAVRRM1t5jcz0stMPyDtd7mLGf5AC9hafd2byXtnlkoUhVm7osjRAO21xrcYP5yztYDQY
 cO2VYBWiS461nTgTp5ltrZNCejx4QnoROiTWtJ2J+K6Kjn6Va15WyB7x50kRk56mTvjXdjOl9Va
 NVaTEUTE6aEBktjpynf4oJNIz3VF/ezZMyrKFXn1aryb1Om4TLmKBNh/VSeCd3rEmTp37rcOfYH
 BWefqkCXw==
X-Received: by 2002:a17:902:bf4a:b0:2b2:4e5c:69a9 with SMTP id
 d9443c01a7336-2b5f9e79fa8mr242778605ad.5.1777034112041; 
 Fri, 24 Apr 2026 05:35:12 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cdbbsm224428665ad.48.2026.04.24.05.35.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 05:35:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Drop manual put on probe error path
Date: Fri, 24 Apr 2026 21:34:28 +0900
Message-ID: <20260424123506.32275-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
which registers a devres action to drop the initial DRM device reference
on driver detach or probe failure.

The error path currently calls drm_dev_put() manually. If probe then
returns an error, devres will run the registered release action and put
the same device again, after the first put may already have released it.

Return the probe error directly and let devres own the final put.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1ab..5d8dc5efec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(bochs);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	drm_client_setup(dev, NULL);
 
 	return ret;
-
-err_free_dev:
-	drm_dev_put(dev);
-	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
-- 
2.39.5

