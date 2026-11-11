Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB77606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lw06p23s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 359B810FB51;
	Wed, 11 Nov 2026 11:33:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E87C10FB58
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:33:02 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so31614865e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794396781; x=1795001581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iCl816dJjsFMtzXM34P9Bj/aT+Q38xCsbIh0P58fbE4=;
 b=Lw06p23s9OKjSI4gdsQt1eeY3341LLqXvVayS6vqDjCH6gPRvC89w0BrpZsO3+gRPt
 JoBI1ReCha2tjx14nxHDPS8gmYbTbRHXFNIzM4cS51l4/tCqvBVHNsCGTYQihjezGRn5
 GZnewasJ34EN12kKvoaQSn7T85PgCLLeeTbcNcdAeESqJab9RzF3P/fQLpSqZ+P2/oGu
 hShM3oFwOR1xvASm5SwV1cSsmQu52xEJzsf6C+1653kSoCVQmQVhSQCgQeYVw4eCJJ83
 /DUVjz1POnW6f0tUKGrLcNEMTEux9C7njaTdkd5iv0DG+0qtas/cT7QLwg8/oHuFf14e
 uv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794396781; x=1795001581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iCl816dJjsFMtzXM34P9Bj/aT+Q38xCsbIh0P58fbE4=;
 b=Sw8/ssNCVOk1Z0S8Ufm/41hXzlBNosIQsb488h1O3OShP6bS1TVrAlkGmAa63t0Z3o
 ZH6hCTLddzwCfj7ghPefPwIBynL5o9zkkjHX24VlToNqrSkXjz1a0YeUDhPBfM88lYiB
 illuuU3yXd1ZtUY9Htc0qTX5X4u6hWmfX0c+hEYnObGgFgCvP1aKPBbtN0oDq4hdwaS5
 l/U6jNhOQhYyNjB1YCNr0tkkcOK2C59/s3htg31YuZ0RqXxGys99l/1aa5b+f4YHmdYU
 jGdnhc2aDVYd2wz7oFYvfqCHmPdI9Lys3vo+M+ViivgDtVqM5h93W6W//PfB/5PmQ+f0
 6f0w==
X-Gm-Message-State: APuU4Z/qwKcj28Vpw4Y4mUtriIWoeVgPuDuzCF45bdjKhglcNE0Znjmn
 qJv2/yEzJntSWHdLwFI4qdViMVPPJbDSsPuKIKJzWQNgKGcTcUqyO3u/
X-Gm-Gg: AYBFou3glZWwX0GGhqUyDrfOW+6e74magf+2KC2JVGgFoB4+eeDmcanTfxalhH9ugeE
 2e4JgqfuXeL9zPrQmB7kRCtlaJYA5uCwQA97OY2j+Gxd02OsIcE8ecqzvwUmn36gprWX0HqwEG4
 /fspo3DQAmOe6ng4MSC64sBWuUaixFyuLK0L6tyME0KFZ+mIcpXv1plDRTOrfdeF6qrztvOPXob
 oqs7+2c7M+CHy63Fz76LRiE53dInj9Or/CcLQaD1ooKj0/iOfIZQxxUX/aNYYYynzAezDi6z0Qt
 oy+chn/iBM6AI9LfLCoamwOJ2ehFAEPA+ze0A74U8l7KTg38YmqTMtC42uWvB7h2IX42WfBxuIG
 bmDVD8RTgwRaMmDL1S92648QfkT+ffP4GKUcjfnS06FmBl5VCJ1lUy5UGX0tGgSnK1mAc3Taxax
 Sht+OKaGkX88T5/94i5Dcfwx1Dp5LIxl5YktUUqkmDW+b3hClQKyw5T0zh5hHm1AAcKokk8KecH
 a0aJXE8YGxbo9RCN/18I6ztE1yUgAJ5UkByLulmsSLU+KVos7+s995LZizuIyrhO7l1MMLp6EOg
 4GZaVTM9wFhx5wr9UlvQRPuzZ+voDfXT1Qrltdf+R1nsRC8NxtJJ5s73lIzT5Tgb4TN/V1P10VI
 ncdMSXVuD1topoo+HxKUhM6s8eo3TEW5y+3Ym66YtjVuxFAmjsv+aCm6gpKbgONnQgCdmJk4vfg
 uCqnSXVVWQ
X-Received: by 2002:a05:600c:83cf:b0:4a2:191f:7cbd with SMTP id
 5b1f17b1804b1-4ba0935cc7fmr37812795e9.11.1794396780617; 
 Wed, 11 Nov 2026 03:33:00 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe9357sm159274795e9.9.2026.11.11.03.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:33:00 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4] drm: renesas: rzg2l_mipi_dsi: Remove redundant driver data
 assignment
Date: Wed, 11 Nov 2026 11:32:59 +0000
Message-ID: <20261111113259.3334619-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: John Madieu <john.madieu.xa@bp.renesas.com>

rzg2l_mipi_dsi_probe() calls platform_set_drvdata() twice with the same
arguments: once immediately after devm_drm_bridge_alloc() succeeds and
again after the DCS buffer has been allocated.

Drop the first call and keep the second one, as it is closer to where the
platform data is actually used.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
 - Updated commit message
 - Dropped the first driver data assignment in rzg2l_mipi_dsi_probe()
 v3: https://lore.kernel.org/all/20261110114622.229608-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
 v2: https://lore.kernel.org/all/20260501080818.955914-1-john.madieu.xa@bp.renesas.com/
 v1: https://lore.kernel.org/all/20260425022857.2382603-1-john.madieu.xa@bp.renesas.com/
 ---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 5b257f5adf06..65f26f889a67 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1532,7 +1532,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi))
 		return PTR_ERR(dsi);
 
-	platform_set_drvdata(pdev, dsi);
 	dsi->dev = &pdev->dev;
 
 	dsi->info = of_device_get_match_data(&pdev->dev);
-- 
2.56.1

