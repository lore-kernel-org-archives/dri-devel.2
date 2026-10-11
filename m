Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9991CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E711D10E151;
	Sun, 11 Oct 2026 16:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i08LKoZX";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE4410E151
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 16:44:26 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2dd76b1361dso6698235ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791737066; x=1792341866; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wGHkGbWaY1GHrAj+q2ZWx0R3E1TtNOA2ScwMHNrb9/4=;
 b=i08LKoZX9hpQX+ZdjRjlJOT/KPA+ET1n+dZZqBCMWMHC+AHVrZtr+jQO/96DqE2/yy
 F+6DambHHE7rICDi+Oc+E/y86HqxU4ckM4yKxoiLwwCsRHRvPS+b8jxFOtcT9NiIOKY+
 CUFCt7fCi5HkysJ+p9YBLcJqNUB23SpETdxJ8rovcnoUA66ZqgEQYUFjJo85u2Tj5CFn
 tA94i6aCn0oVBM0tPQCdgNM487NP8R4LCoYXoLDIZ7IAstZxtXQCnvVkntWEzLGzntwm
 T469iFzwJK4I8sQ7idyUjVsKnRloW/EDfKeAWDSo7Zdly7YJxFeRpZ/4uh8gPHF8wIOn
 Fpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791737066; x=1792341866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wGHkGbWaY1GHrAj+q2ZWx0R3E1TtNOA2ScwMHNrb9/4=;
 b=HOedS996NWtxTphgdQ4uYMavwaFhX2kiLyax8xnD3hhi7x8DsAzCpY4tjGLprRVHmb
 vOuFrqyUwYkXGAe6NzFYCbBNLeHDn5ky2fkxmvGRUxKVY2G/qtLbXqw9rPyk1IKeTwZe
 BaSzqjFmoo4XL0UlWFa7TgqXMQj+C+5nFpvmmnwzyLAwHjNISHy49C2i5VItM1vuOua1
 /lpN2AJOTMtHJMsKvVKbvYvV51tzjrcymvPFWAfXx4lHT/2/KtLtq4paB7/WPgS8ZPIw
 L/pYX1zlWiD7jCxERIj2pLK72a7GVMTMlT6G101p3HKnsR3wrJWkrB1KH4kav74G1zsP
 L5bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRa0PGJGxevwM/xn+at3xh/qDIXGUm5w0mQaVz18M5JFhKCrQgHpojf4cviq9dbZ4gluqRAL/hb98=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwod8XBtDMdPnbJADluvvHMHHRtKBbuKjUwoBXnFGsbl3lTo6Z
 eVT6fMeLflNVaRAWTGPgoUw2deUkRmcHan2c1zhCIN+EqDTyMQTKIf+V
X-Gm-Gg: AYBFou1GYzm8S8p05Nvrt5XrAFH0IVwljZUZetkR5uSerIbUuc21ZmIYqkUEj1tDX6z
 Ye9aBXjQWy2SlpnTTiR+IvrdPyRnvYpM0hUCPEYAlo7ci3sZsq+OfTQovU9ecJqb3X1kLmxo6iE
 YMPOTmYPruUEYJh8IaAMoGM+wroFZ+0EfoYef3dDji4W7fghH1gEArzjUG3jvU0FqNDM6IpHDNs
 dShzpiDaZ/H3einh0ubiul3R2Wf095MjiBrNyRF5UFbJBerp+xC29lrHpNWA2CwnWWjPvDgF6sW
 eK2YAkSQ2rwjNH5hUBjk0yZXASQbciOVzRITZaOAjhtWaAQYbr1QxvSGX8/Ni/qVkrogHk4/T1y
 5t5uFuYz3xW/UJtbwyGHbpzIiiKvui3FPABTUWv4fVNDnPPIilGQzqS0x/WA2HjlnJRZRL5Byg4
 YGZM32eF8nU3sl1634Haq9PC2oqBoPU5UX1wy7WCerONhU2ZUg8Wv/FyQoIHw9FKojR5IoPlp9q
 CgFyTM=
X-Received: by 2002:a17:903:22ce:b0:2e6:18c4:89d0 with SMTP id
 d9443c01a7336-2e8427ee486mr63798685ad.5.1791737066088; 
 Sun, 11 Oct 2026 09:44:26 -0700 (PDT)
Received: from arch.localdomain ([161.33.202.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422fa91asm32769435ad.81.2026.10.11.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:44:25 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jun Yan <jerrysteve1101@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add BOE NV140FHD-N43 panel
Date: Mon, 12 Oct 2026 00:44:16 +0800
Message-ID: <20261011164417.151770-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Add the BOE NV140FHD-N43 14.0" 1920x1080 eDP panel found in the
Sunniwell Z96A.

raw EDID:

00 ff ff ff ff ff ff 00 09 e5 f4 03 00 00 00 00
13 1c 01 04 a5 1f 11 78 02 3f 62 94 5e 56 94 28
21 4f 58 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 c8 36 80 cc 70 38 14 40 30 20
36 00 35 ae 10 00 00 1a 86 24 80 cc 70 38 14 40
64 64 44 05 35 ad 10 00 00 1a 00 00 00 fe 00 53
54 41 52 52 59 0a 20 20 20 20 20 20 00 00 00 fe
00 4e 56 31 34 30 46 48 44 2d 4e 34 33 0a 00 97

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index ac815729aa83..ba981581f3b4 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1972,6 +1972,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x03f4, &delay_200_500_e50, "NV140FHD-N43"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116WHM-N11"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200, "NT116WHM-N21 V4.1"),
-- 
2.56.0

