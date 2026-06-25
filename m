Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1AECDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217DF10F4BB;
	Fri, 26 Jun 2026 07:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7R6ulXE";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F3710F200
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-37de8c6a2b6so1025436a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380722; x=1782985522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58+0tcE1xtERmBsdwhzofL6yvn0GjZ9wff4i+1M3Fr4=;
 b=P7R6ulXESQSFCXFENR5xpPK+AOfVJyYmpXasNRSSD3L+mfiMG+sOVxVKj+6eWC+mOc
 ElDG3S91rVDrbjd/loX9pdK35pW9PYuS3Ko5C2rq0rJcMozCgdVy5Tliap5GHzTWO/Ps
 tEV4BkyfG/ihubP2+v9UCTIWWIJFJxREet/YgMH7mMO825pUgcp8LSZNEZJwku6AqAlA
 v/z+9KJN4i2JFgcw/0dsnn74dvKnFhEuKZDQ05Zjf0cMQsloEoRUc/mvHC0l/qXmHpCX
 HiCZ8SWMzYRUMsWbBP6Hyjd5z2c6qRytqsCYyRXwtrmo9ATnN+AaxG4VHdSIkCEee195
 NEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380722; x=1782985522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58+0tcE1xtERmBsdwhzofL6yvn0GjZ9wff4i+1M3Fr4=;
 b=LFfdt6tz0Gh5+sqy63A3BUCtb+KCh9w3CGJaFYRRIr790NV8WN9RhzmHgDRaGgNlC1
 G4ccZYCQ/By69YgHJOLfzFMit0DInldpkjmk52M+tKUB1lx56H8HpDlyKL0KMg9aKiaf
 4lPw110mYsLQQq7aHDcPz5Gwdt8Cg6syHmUpf7rvHsAohOgTUuzrTliF9VqgRQ1EiVHQ
 2UMlXA/y0dfQzQFAXm432n4tq5AXcRnFpyjcQeQD6tpUUnCLxYPy6BkobQ3K2fs1HwZQ
 AOKHmAD68VADEBc76TZBnvyr1RCg9+WT051VRpSGSKYk/F4ot7c+xdpdVZ8yrxt1lF04
 4izw==
X-Forwarded-Encrypted: i=1;
 AHgh+RojDLAyZv1mcjt9wF1+XAmGBaIoqZgljvDi7aYGSFEFZvbJUBPT35AdmE3J6qVY7jH2GZ0QcoWoSZ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiOHSmIJYAQO4oy2Xt9BHqMYZ+dbRtmvp8qA/kauj1WrR5rPeN
 JaLgrq/OB1DTkngKqKV83oX0n//2ikajvZcqMJUWq3Xoptm7qdhxfB/f
X-Gm-Gg: AfdE7cne9UzZweC5jaggtBb/cTME/9UalWl9fam7ZixMcEN5mMNfinIMdh+IysuLIFt
 S5UwebjQ69D8cUUOBgN2DnVofP4olX1PjKjuVGf03FRXt1TE7WeeyTxZV/lS6ro51lmwanUg7qZ
 SppEmEpE9IKiKuVMUMJ9D4wPWvMP210J0G7oyO/80gNrIWSV5/B0aDVIxROIfE2VTXCGnIxt7bG
 A4L/+oOD/R2HYWSKeJLv29ApxYflqhVXdNE/WV070S0tbXxxLqDmpeHQBTE8uG0JjmyRRP3jqpa
 P99ZRU2S/oy2fK/8ldg0u2jX/6GPu0mpyWpE6XHs08QtyXuK15lUO4E/D73ZdLsHOrno8SJH5h+
 oD4pYlfNwpD21pJFwQeRTpuKAVMLM2QIf79fjbA4FqNc5ryochJ5MdnvxcsJ7f/HgDD2HV7By2J
 8Fx2OvnaBLrvpTziLVnBai8NCmoxAvJK8g5LwcVPl38GWFOUHM0vnmJPTjmvH3o3sT9dVQFkpX1
 A==
X-Received: by 2002:a17:902:fc84:b0:2c6:afd8:5704 with SMTP id
 d9443c01a7336-2c7fc632ba3mr20484605ad.4.1782380722046; 
 Thu, 25 Jun 2026 02:45:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:45:21 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 7/7] drm/verisilicon: extend Kconfig to support ARCH_MA35
 platforms
Date: Thu, 25 Jun 2026 17:44:49 +0800
Message-ID: <20260625094449.708386-8-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Add ARCH_MA35 to the platform dependencies to allow the driver to be
built for Nuvoton MA35D1.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
index 7cce86ec8603..295d246eb4b4 100644
--- a/drivers/gpu/drm/verisilicon/Kconfig
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VERISILICON_DC
 	tristate "DRM Support for Verisilicon DC-series display controllers"
 	depends on DRM && COMMON_CLK
-	depends on RISCV || COMPILE_TEST
+	depends on RISCV || ARCH_MA35 || COMPILE_TEST
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
-- 
2.43.0

