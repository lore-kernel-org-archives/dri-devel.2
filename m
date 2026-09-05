Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E5C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4210D10E4C3;
	Sat,  5 Sep 2026 15:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMp1aREb";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D400E10E27B
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 08:04:31 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so24060435e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 01:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788595470; x=1789200270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3aAKAsF8AwsDem/eK9L5mJ4rLY5jdRGrl/F/Zd/H9PA=;
 b=IMp1aREbBEaZyT6i/m8jOkl7XUIElqU4wk4pjjk17X8rG5Ewhko2j1VsrN0vc6zUeE
 /M0RBl9ur9+bPJJ+NcM7TBeZlT25Uc2EU8W+VtKYaJ4aVeIKzVuoSMIvS+7Hf1N46PRM
 7X/359yGi8Dmk9TlA1Qwtan2K67aZxk1kTD4bmcTuyQPv1F2DjHEoVCDYRxM+eVqpTnW
 Ulses/BYmqOxYjlAoD7kxBgna2e7YPPtbjE7nQRs5H8ekzobkRr5WcLdl4Sz1QTqn4tt
 7kUHaDsAec/k5rzfauVStpBtOxmzpMgWuz9RiWnAh16X+dcwNXwGLNYZ1uLlkAL1DxsS
 grtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788595470; x=1789200270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aAKAsF8AwsDem/eK9L5mJ4rLY5jdRGrl/F/Zd/H9PA=;
 b=a6qpetoWheIhOdB/XFozCxq/Qy37iGzt9jsxRRZxQcXwUo7z6RjlenPK4iPRyyCliu
 +qTSxgSlDCVDNo3X7FcpB4BoOMf7HMTPOugQRNujhe2oCCm8XMFfW47zw/YGCNLm5YpN
 y5WDZ4I43VyI85MHx6nWWJrd5ijVx+2W1FLjNnDzin0QoSF1dO2XMCsGdJQJkP55ZBqZ
 ffihOtJ8q533Y7Rizp730P8qsC5GESQdNntPKYZXTmX1ilsy6jG5fCHM5SuRvUkbA1EQ
 3LocBa+Ln4maYaZqf4pR2pf1CICfkydLszSDOi6UlWVkEZHK+QWPkS3ELtzwn61RjH2o
 g2fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkT5nL96vDgeDBUPjdGPa48WUeoGopl7SjW7QkiySFprTumHmmNPDGR8470tfZhr285Piv6KBRroM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUQeF7azjtXT5LXOiqcz/wifIa1w0TBM16GmbPvnCXqyTecVu7
 c0SON5RKISc251SJApaQ4ImnOEFt4he/9OUCnwa4I7AbZg6vvBMv0zNcvYME1SXu
X-Gm-Gg: AYBFou1Y+f8HKnElpok9KBj9VrtcOnhysb7oZiaoTNYhaRj9oFklagL5r6wWg25dok/
 L95rM3hHoq4NDoHPo18MlKuqv7bq0TtT7pKLzCp3v5/9tH8ZGmhVhgyDoyo7+VJl5ZFsKCzwFvP
 balcQLCPP60OOTeSJ9x/k6gf32KT6yY0Z1KKkHravac60WL+NRgjBhzNcnSSyb4vl2yK9Wb4dUG
 wQtQZHjTUuRtJv57igJWn9nHxyW7J7b7rspbXZSIYC5pUWqKPwPnIr+aLkMVXPw6O+yo86A/X0S
 S2kifeEJv+XuE3Fghj/g9R/Sp/nN+Cg5ZCde/EUQsvn5zAeprLxa+wGt0i+KGDcQnJuGQWkrACv
 1+zltZ5aRfnU6TCS61QgntxFrer+8cMpojSzVX8jlyLcvuUTwdalCeLYIj3YspyLb08CUw0/yqJ
 9wumO4GPkyn4dHXDFuKoCLWtwM3GL8VTgMgW4YFMOZHt9oIZBbeZajTpc9GQVNwq/CIV54RlmVE
 w1UtlyBxrSUFQz8kaVqyNM6McJSaCScCHlkLzhKpuhgbiJGQO8hNxkwpjMSwGX8qkuYzVaXeZeq
 57pYvSg6yKCdmh+ayvHBAm7WFjQh6XHULgvnCISskn3KyTBE3l5mTmYXh9oweG2xYlk=
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49cfa211d5fmr91911335e9.30.1788595470025; 
 Sat, 05 Sep 2026 01:04:30 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de.
 [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm96770125e9.3.2026.09.05.01.04.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Sep 2026 01:04:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Janne Grunau <j@jannau.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 asahi@lists.linux.dev
Subject: [PATCH] drm/adp: Drop the select of the nonexistent
 CONFIG_DRM_KMS_DMA_HELPER
Date: Sat,  5 Sep 2026 10:04:26 +0200
Message-Id: <20260905080426.34224-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

There is no Kconfig symbol CONFIG_DRM_KMS_DMA_HELPER. The former
CONFIG_DRM_KMS_CMA_HELPER was removed by commit 09717af7d13d ("drm:
Remove CONFIG_DRM_KMS_CMA_HELPER option") before this driver was added,
so the select does nothing. The driver already selects
CONFIG_DRM_GEM_DMA_HELPER, which is what it needs.

Remove the dead line.

Fixes: 332122eba628 ("drm: adp: Add Apple Display Pipe driver")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/adp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/adp/Kconfig b/drivers/gpu/drm/adp/Kconfig
index 9fcc27eb200d..acfa21ee06d2 100644
--- a/drivers/gpu/drm/adp/Kconfig
+++ b/drivers/gpu/drm/adp/Kconfig
@@ -6,7 +6,6 @@ config DRM_ADP
 	select DRM_KMS_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_DISPLAY_HELPER
-	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
-- 
2.53.0

