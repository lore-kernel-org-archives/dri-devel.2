Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7539C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AD710E054;
	Sat,  8 Aug 2026 13:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xd+qquPD";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F6710E054
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:52:43 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso4597775ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786197162; x=1786801962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LrFbJmkk2o/TaP9ZJimvbOk+XpiXXLx+TjQ8Tl79+nY=;
 b=Xd+qquPD3xcFVNw2yB8XHLAq1/3IS9/yWWZWNQa5YijhzPcDTTzvVj2AMhFb9JZ9CJ
 Sa4up7FlN2WfJ6lKYmUbpifjVGZ2+nulEBeWjHAmZIOTBIY1Q4uMqse5XCw3oewFeqZT
 bUdWan7XKHcU3445pEWqpJ0bpckdYrB7pq6O+scgO4GvyX8MzNcrvebgAPkLBIPbti7W
 0BYyrzrWYfGEewJFo76PQsK3bEjHMcEsXisTfU3BTXve1o51YJO+OcZaPu32PmHQBzs0
 SuUfE+aEruMyjiya+k3+RSpVHeEFMjIGpp/yzx9T3ISEfyFITcYKPgsg0X2W932evZs7
 4LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786197162; x=1786801962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LrFbJmkk2o/TaP9ZJimvbOk+XpiXXLx+TjQ8Tl79+nY=;
 b=hFXT4Suim7pH+dNL0M21at8SK8GBFFuToJ35JXzFV5A1jyrzaUUBGIuWuJ4eN9RgVB
 qNVWenq8aH0RhZQon0Md6Mf0jrDaCjwvWmqq/ZsLJamgRd8uv+efsbMD1NX6kDC8tsAY
 pABNIWACHYNJ2suJGTNbBK8m7QIsPhAfXujycCYYaC6n93JQY/CPYfqiLYHDXpdMq3co
 8pv4/Wq3+ldgxF6s+JtLsfcxztvH31azjQChSRVpdsT0yN+sg5NNgdd24JLtK7zBYF4F
 ZP7p+6ZdAdYHLtJARdMOXhyQwVMJ4rl4v4SDO/vGrYb/Qf972jHuZZL2LfoXlBP8xi+B
 mnxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrgzdhfj8bLG6iK4A6nHdr8soOtCJncqd/Qm9Ns2baZxxaYsoIRjh0+fYwK+S9ho5n0GGlERtZhCbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTOwCc8JMCGDyw3EyDpJCaNYwAPruc9C1C2tR68VfUT2MWt+uZ
 AVhWaKpPTpgTu59RlVv7RtnIN6dCQ9QjlFgocZI1aVR8+wL2pA9/9iqg
X-Gm-Gg: AR+sD10zk0nBsQzfdXaEOL4fE5v5ZF6TOeqnzsrvaJzv7z9hkBXsSw6gTdzRM1Gd0xL
 gPg5KPMuyZCXOU3yqSINJ20HJRMcKMrRalafA2rLmhDAYTtQ8v0qZDzK/BibNhIHQxhq/qGq3yP
 /QhrWocs9lVtZeM2359tg11NNnN1gJKJZarv+1vGb5ALXfM2Z7s5Ke5XKSHKp3Gufv1IDSfl0uQ
 oWFGWzgSEGNYG9nGOAx9l2g8LnH5Js07oQswmgndh586aB2nVaM0BrCvv1Ut0Ja8qA1hMDLG1PR
 LiLrb6Sbyt3uXLOb1T74Em4IPpboyh+j5wTnUiDvbb7UL1jfohdhITysouHbejzueipWlgkFLGQ
 zx2aW+hlPeLKS1/DkF1+lS1lfw14kpzLAxPlyLQTBXEMPuhH9NxI400yl3zFOAP0d84QrIE2NnA
 yS5GFveUiMbL1xigdgPIPgf+HBi3zYEUCU7VsSaKZ1e4g=
X-Received: by 2002:a17:902:c40e:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d106a1a2f4mr165599635ad.3.1786197162537; 
 Sat, 08 Aug 2026 06:52:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d16c4fc743sm18861815ad.80.2026.08.08.06.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:52:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Eric Anholt <eric@anholt.net>, "Marty E. Plummer" <hanetzer@startmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:50:24 +0800
Message-ID: <20260808135025.2872956-1-lgs201920130244@gmail.com>
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

panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
probe error path nor panfrost_remove() calls the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and device removal paths.

This issue was found by manual code inspection.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 784e36d72c2b..007dcba62e62 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device *pdev)
 err_out2:
 	drm_dev_unregister(&pfdev->base);
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_device *pdev)
 	drm_dev_unregister(&pfdev->base);
 	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-- 
2.43.0

