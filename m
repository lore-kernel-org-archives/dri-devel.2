Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB6C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DEA10F1E0;
	Fri, 18 Sep 2026 07:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lp+alh3u";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA49B10F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:58 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso2370885ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700518; x=1790305318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f70EL2u57AlsQGuy6taCWBcjNOQfxHMXhBaDu9pSD1s=;
 b=lp+alh3ueIKSPlLjfA6M7Ux8pnByjmFrqBScm0SmN1oQN1DkTLHaBnyuOOXfumObBk
 QlK4a4AOQ6wIkX9VFPecKkVzylIfHXuOezrgQPe7ogwE92EXVJMdMw9t5LnD/j9QJHdL
 CSE7CUfpsLyQ1saQeS34imaUe2NTWOuoEBk+tP7U39d6KcTfR/Dom08hJLzieziXqKJ1
 KyRMHzQpRzQf2AMesIJntK8DRe7MgV3jDxy35Vsw3qRvAX7U74ssF2tnwZiVGYWDHNtM
 vE/qdBL+CwLbd0+oZjTXgQIK06bD7SfQo+kjtSe2KMv1P61X5VBlg2ux1iJoXUN24kNG
 ssBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700518; x=1790305318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f70EL2u57AlsQGuy6taCWBcjNOQfxHMXhBaDu9pSD1s=;
 b=Wk1BMSTOC7ToCC8mNQcZpj4kk5YympF36qFecHmdOpaW6PRgdW7AeqXRZ5fApC1+kO
 V95ePKwWqRP54JCYIhB2ugip88YCKB7z2TDslJD+4EXKyKwU18UrhEq4U0CyRCgDPUCG
 lhTJprAjF8sgAZnNpqHiwAU7qq1X4Rof1/6D5VqlsU74snN2Q9BOJCncSc8Xtt8KgH38
 hWZnm9gO0vKwALgF2uIBQaYLPPOHXFwNW3piY/4WEhWQc8UIaX2+LsW7YKQaM/DNEMEX
 O5+SRFKEo/RbWRpumWtDt6m9ze1Rnd5b8DEe7HtLX70yJ7L2BVhTjEKSdSJF40aRP6Vz
 tCpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzqnaNVFEJMWfgKLJSqciBUjnEOjsR+bGpF7+2FE8CGAzwud/fh1GnnHx66QSwwA5y3M7TnCe/ykw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kIiMyxedALOQ0Dt8wC80iq/MIEzBHm1RbqNf9FphC58iNvvBXX
 sqg14S1cPTzip+Zwdmkr4WQtH408UuqNZvC1olPhdQeVRHRbXK5BeshA
X-Gm-Gg: AYBFou2mCkLHXGw9eOVozj3pCCUWyfA4QeKjq9sWG7fDm6IKtschV7Rppd9bfWckI2p
 557EKwFNZNkSzhGjBcQJGY/wSS1IW66/SzQcig5XnxA8UOOEXiEArAWeqDvRH6v7Pp3fJgsRI6a
 B0jm+ZHeKu8AoiloRljUyBYXG2LJ0E+VPfEwvhPAY5ceui4I6BjSukKEc8oq4vpaiIan0dUXljp
 JWLWjA8muIxpgfaFCwulkqzvy04Kx2nlJZljTBVvd5kBwDidhgeBTnm+7glvgqMUH3pjXzf3G42
 9w1qcoyxz3Nmy5mVjhrTHIenSXKUQJGWpsSbXc0TfEfCh22m+BeSE134SPWHzEvpVsR84Mqn/Zm
 k4ybIIhQzGyCm7jt2oCuYLHzJph90YFm6Noc3Oqk6OELNCCi1AdoXgdFkipqXFmwKp+O17RcZN3
 OKvcJsgAWExhtqNrhp+HYh16HUI038lJI5s0ZP3mZaeyulvcuPkZRY/AdfBFjdm74d1izvz3TTh
 387w7P0NxMmUAU2vS6InBrW0t6OBje3O+LOYnQR5RLIfIrtQ69feP05H7owVLw=
X-Received: by 2002:a17:90b:1644:b0:39e:2ea1:e2a9 with SMTP id
 98e67ed59e1d1-39e54d8b0ecmr2306119a91.8.1789700518239; 
 Thu, 17 Sep 2026 20:01:58 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:57 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v7 7/7] drm/verisilicon: fix DC8200 primary plane disable
 clearing FB_EN
Date: Fri, 18 Sep 2026 11:01:25 +0800
Message-ID: <20260918030125.315978-8-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918030125.315978-1-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

vs_dc8200_primary_plane_disable_ex() calls regmap_set_bits() on
VSDC_FB_CONFIG_EX_FB_EN instead of regmap_clear_bits(), so disabling
the primary plane on DC8200-family hardware actually leaves the
framebuffer enable bit instead of clearing it.

This bug predates this series: it was carried over unchanged from
vs_primary_plane_atomic_disable() when patch "drm/verisilicon:
introduce per-variant hardware ops table" split the DC8200-specific
implementation out into vs_dc8200.c.

Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon display controllers")
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_dc8200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c b/drivers/gpu/drm/verisilicon/vs_dc8200.c
index f72da10295e1b..25b5906a1c5fc 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc8200.c
+++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
@@ -70,8 +70,8 @@ static void vs_dc8200_primary_plane_enable_ex(struct vs_dc *dc, unsigned int out
 
 static void vs_dc8200_primary_plane_disable_ex(struct vs_dc *dc, unsigned int output)
 {
-	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
-			VSDC_FB_CONFIG_EX_FB_EN);
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
+			  VSDC_FB_CONFIG_EX_FB_EN);
 
 	vs_dc8200_plane_commit(dc, output);
 }
-- 
2.43.0

