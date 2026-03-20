Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A8810987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D1410EB90;
	Fri, 20 Mar 2026 16:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzOHYvP/";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FF510EB85
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:04 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so1770387f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774024923; x=1774629723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rtUTy7c+JMXpO6EpoYVOPqOA1jyBKbjjOPg7/yERVQ=;
 b=QzOHYvP/UYU4qzyGBMO8LOQRkvBge7BIaRsDMF4jPS6zWOt3ey4j7x5nQ6DHQKkRmV
 AqzEabbDHBzWiX3xR//4C7+/ohMrwRD1i0MU3yyPXUUxCXwqvTbN60NHTZKoyQilcbmS
 uaAG2qkbQEAK1T3GN2eBBDIK1CfvGzjNd3mvBbDlXhcEFHzjoJ3OZgsHz5zngWIsXCW/
 h0IWzRNjCTI6AuE3wm3Ktejr63xA2Q42Ir4590M5acQpCPL/+734JoXmlq0P03DluqIW
 KZCZFOcn3fULZLUioOKMN2ebz6vVP5XTZayPd9XZAS2en+Qyh5NDyioKdZ9NRk+CkSUc
 +yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774024923; x=1774629723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rtUTy7c+JMXpO6EpoYVOPqOA1jyBKbjjOPg7/yERVQ=;
 b=pvEyKc9XWlsGSrdivv7lhF1soGjlyqkI8dBhodJL9rWUiktpFfujgtRYJ8fbCpvj/v
 gl3wte01uD970eA/GXzFCRR786ET90iPsokSOlxr5q+3vCz7s00Cbqkluekgpv+5q/0k
 kfUSp6mUK4OIKmiAg0RuL0IOkoNxAHMiudc23S/69f04dR8Tjlj9jfsMNV2t0JWznZTb
 3H0YKWnOgcuNoHarvF+boijVLOyS82/pWEyJghKa/zNQEMZPleuvlMwSAtu4GdVVY9Z1
 F2aNuldApLpg1QVqAfhAoy0y2XSQU1hgM7bt0SxG3eKMlpNGdFkh07ebBBCYWZ/Rh92w
 UvRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLPD8JEqgCasGcZLa1NEk9eKcjPPDTin1fEbVD/c31pAlStPnLuLHnCXbTudiT90WCzMjUlYI3haQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygdpiNXAPIVdh9ckgAVDWFP+zwzD5grK3YW6Sn+r53qnhFwWqi
 4ewmjwEOs1ufWJEJvjEzfp1Mi38rlC1aOKiY3UV6uD3ZoOgiRIBpu8W0
X-Gm-Gg: ATEYQzzZgHXQ6+MIjMr6YNgm/zJ5ta2fDeylrpmjwfvm0AqG19ZPc9/LbXlT18kpqmM
 wXosVfN9RsC2mapwovgxbW2H48czgBzOw2prdIW0oNkANudRZbv6O4sK05FJakkYDbnIvizFIKU
 lfWmSmTF6abKugKKCEfEFQZTK6XwB5R+SACZczfi256JJQYjtyGI8dbZNUq4G3yOwyuWSbJp1aW
 ntAk0p8C8av/ejU6ptvijW2HFBGzvX2/JhEZX3AEDQYVCgxsBp7gbMJJWofOxkNWUs1HZA5ezfi
 54y/jFTXZXYUzHU+9vghaGfeFWHs55xreUokn2yhJbwLy4oLo0+HJMXx/tzvZPvIKAho6SnCZhO
 CsU0f2rErfjk7xxEXAhLsVnLWALilVbxXD8/4qbCNTe/ziYnHdN8JvNlowCPHoj9TRNBs5MAcyl
 vkNvtRt4S0wphuaQBnVOfo4wnrHbexWNQ=
X-Received: by 2002:a05:6000:310d:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-43b64262ebbmr6599087f8f.30.1774024922785; 
 Fri, 20 Mar 2026 09:42:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:5b93:d2b1:bc5c:9231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm7016575f8f.20.2026.03.20.09.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 09:42:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock checks in
 runtime PM
Date: Fri, 20 Mar 2026 16:41:48 +0000
Message-ID: <20260320164158.487406-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The clk_enable() and clk_disable() APIs already handle NULL clock pointers
gracefully — clk_enable() returns 0 and clk_disable() returns immediately
when passed a NULL or optional clock. The explicit if (pfdev->bus_clock)
guards around these calls in the runtime suspend/resume paths are
therefore unnecessary. Remove them to simplify the code.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index dedc13e56631..01e702a0b2f0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -429,11 +429,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
 		if (ret)
 			goto err_clk;
 
-		if (pfdev->bus_clock) {
-			ret = clk_enable(pfdev->bus_clock);
-			if (ret)
-				goto err_bus_clk;
-		}
+		ret = clk_enable(pfdev->bus_clock);
+		if (ret)
+			goto err_bus_clk;
 	}
 
 	panfrost_device_reset(pfdev, true);
@@ -464,9 +462,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
 	panfrost_gpu_power_off(pfdev);
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
-		if (pfdev->bus_clock)
-			clk_disable(pfdev->bus_clock);
-
+		clk_disable(pfdev->bus_clock);
 		clk_disable(pfdev->clock);
 		reset_control_assert(pfdev->rstc);
 	}
-- 
2.43.0

