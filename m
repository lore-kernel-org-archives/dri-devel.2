Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB7606A680
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HEnIo25Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDC210E061;
	Thu, 26 Nov 2026 06:24:26 +0000 (UTC)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801AD10F0D2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:24:20 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1a2af4c8d00so5976192c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795674260; x=1796279060;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1smrtCoKPSjZha/dsx0ELlDf7J6mje+6G+R+oE23Xnk=;
 b=HEnIo25YidlRuMEaIo3d7tzhtwtRQYS/3JESw5boVW1TNSxneL9lY1V0rua14pnnCZ
 dqh+dNc7R5mx90mV2HmcEFcNrl58tyrOod2DJUQRCsoqMGDSk3x6TQG19XRgCl9isW+0
 5xLpuyEbahTHMwAIp0xgZ6Bm+c36sD83fREiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674260; x=1796279060;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1smrtCoKPSjZha/dsx0ELlDf7J6mje+6G+R+oE23Xnk=;
 b=1SM1ALz23RSbzrdPOzIRdXX5sl8ti1mKvlTFHQASC4FnSvIYOXTBIrjmlACstNw/iS
 TnKN47Twdw6IQT96OxojSvB4vhqMeANmwjlO6Pd1+pEvSq3/7aQSJ59/wQfP+TnanC4J
 GGmFWwfJGfGOa5+kzAhmDfua2pMi9kiHjqy26DjA/Ar/rY84OebMtdkACkpAPsfw4+pL
 iIstUauoHPccIqNsM7HfTVc0duUiL2SnoUOJRb/oMkehOcp4Du9wdpqoosbdHonh04rD
 /LC+GUdPwINweC+kElzGxaQ0CUtA9KsdicBPvkz5N/Ve89CrGPVTP9S6blFnZNhg4TXC
 whYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGh4D6xGTFrEXDgPZbJbX42MPvNgjR2ZCk+ZDuyi337wlo2stLLID2u/7bscCYQznNrgsQDd0Rv4Fw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/EJQfUS1RizKdqeHIvp8Pn8m56rngsDCxNV5U2CUU0YC3QBZIP
 zDTV/GurGaQ8fEFaNBEgAt3Eh4eAd6RHrQjDobWL9ib66cWOtptno5Pp5zZZ3E3tPQ==
X-Gm-Gg: AZFdTZcqd789muOdYA7qmC95wyJs20j3o0RkjdSAxkFWn4l5hKsS58BG+4IYXxyRamu
 AupefdRZiluaBjp1aPXUhEDp9fi15vjZe17symOqNlkzLTpMEqiAdjq9f1lQv0Hf3nPKvL4/2nY
 NzijggjBUFUCN0hgoPNKbbhLPyDnCC1jP7f1IWDunkwY9bxkW5376vOY/L7MseU69YrodmWjQQl
 CEYp0ncLKGZ2lkqE4uxr4pDUAbXiVRz7zCglGWyk+XvfC16YQV8IXM+fvq+buGxRXEoYIA125Pf
 3nfOnyDt4gAa5hB8RU4uF0FiNpaaVl0ckWn/vXr3m1mHPPt6sknIQbw1ev43jT4fTJUItdSgFTN
 QddVdIiLWYC6M7DeHaz581DMwYZ6gEoXCc0y35hxZEi6M+MhntmzvY7qr8DFM5ntGGIdeAyC6c2
 D3jgXrwz+RIoCPX9Akk7KlUUqSZBj1/5QnABuuynP7StiQv08WymVXeL8v/9wKc1XI+pXPFf2wZ
 JyR6GasWrR3qCNXxDFVdoOIugpLX6Ee30rHOA4NOps6N5PENa3w5u4o9se2UvssIleqHDiBd63Q
 bXsFvfxhGbdP+6yOKXEv1AZXhlZUcaqWW7BNk/cUzcOz+xb0EBbZB6ijsTHJQuuC7QLAnugcwa9
 waOTQ+aPOnntzDAK9DDIa8w==
X-Received: by 2002:a05:7022:b902:b0:1a5:9abb:fdd7 with SMTP id
 a92af1059eb24-1b556877a2bmr18501590c88.9.1795674259793; 
 Wed, 25 Nov 2026 22:24:19 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com
 (123.142.199.104.bc.googleusercontent.com. [104.199.142.123])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm36793186c88.4.2026.11.25.22.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:24:19 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
Subject: [PATCH 0/8] drm: Attach drm_show_fdinfo() in default fops helpers
Date: Thu, 26 Nov 2026 14:23:42 +0800
Message-Id: <20261126-drm-fops-show-fdinfo-v1-0-7cb1d1a5d6ef@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG/QB2sC/yXMwQqDMAyA4VeRnBdYgzjxVWSH2SYzA1tptimI7
 27djt/h/zcwzsoGXbVB5q+apljgLhX48RGfjBqKga7UOEc1hjyhpNnQxrSgBI2SsGmlvnlyLUm
 Aks6ZRdfftr//bZ/hxf59vmDfDwYnpUF4AAAA
X-Change-ID: 20261124-drm-fops-show-fdinfo-68f47c2182fd
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Oded Gabbay <ogabbay@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Fei Shao <fshao@chromium.org>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DRM core's default DEFINE_DRM_*_FOPS() helpers currently don't expose
fdinfo, so any DRM driver that wants standard GEM memory stats or client
names must declare custom fops to attach drm_show_fdinfo().

This series consolidates that into the default fops helpers and migrates
existing drivers for consistency and simplicity.

- Patch 1: Guard drm_show_fdinfo() for !CONFIG_PROC_FS builds.
- Patch 2: Wire drm_show_fdinfo() into the default GEM, GEM-DMA, and
           accel fops helpers.
- Patch 3-7: Convert existing drivers to the default helpers.
- Patch 8: Enable GEM memory usage fdinfo in drm/mediatek.

Signed-off-by: Fei Shao <fshao@chromium.org>
---
Fei Shao (8):
      drm/file: Define drm_show_fdinfo as NULL when CONFIG_PROC_FS is disabled
      drm: Wire drm_show_fdinfo() into default fops helpers
      drm/etnaviv: Use DEFINE_DRM_GEM_FOPS()
      drm/msm: Use DEFINE_DRM_GEM_FOPS()
      drm/panfrost: Use DEFINE_DRM_GEM_FOPS()
      drm/v3d: Use DEFINE_DRM_GEM_FOPS()
      accel/ivpu: Use DEFINE_DRM_ACCEL_FOPS()
      drm/mediatek: Expose GEM memory usage stats via fdinfo

 drivers/accel/ivpu/ivpu_drv.c           | 8 +-------
 drivers/gpu/drm/drm_file.c              | 2 ++
 drivers/gpu/drm/etnaviv/etnaviv_drv.c   | 6 +-----
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 2 ++
 drivers/gpu/drm/msm/msm_drv.c           | 6 +-----
 drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +-----
 drivers/gpu/drm/v3d/v3d_drv.c           | 6 +-----
 include/drm/drm_accel.h                 | 1 +
 include/drm/drm_file.h                  | 4 ++++
 include/drm/drm_gem.h                   | 2 ++
 include/drm/drm_gem_dma_helper.h        | 1 +
 11 files changed, 17 insertions(+), 27 deletions(-)
---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261124-drm-fops-show-fdinfo-68f47c2182fd

