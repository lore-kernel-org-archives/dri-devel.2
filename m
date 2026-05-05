Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB1ACD3441
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 21:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631F910E68B;
	Tue,  5 May 2026 21:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OIKcU8wZ";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4CD10E68B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 21:46:34 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso55234955e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778017593; x=1778622393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJBvhYuyv/JdwansPLGJPjqYXoVeTZUEnpdVBNEj1Pw=;
 b=OIKcU8wZCdkx4ta5kvELFKJvW5vDxEJ6GY/KyFjL3vD67520ujLppR88MzXE4ReEr9
 kn2cL6DASQhaZrbsmYoOaIDWvp3+0i1hyYNwZ4S8z6W7W5pRgpjDpMrTU778jtiNkDhI
 IytUKCmOugO4iaxo/OmbmU0XDpyxKxI1rPJgpn1o70dbr/z5ev2oUlZ7dhrUD+xCyonL
 nCt5Id3kN8k57qwDJeyHHcE5lS8ZUShAYJzJ8+tGG8fjOL+goIcpOodPQJIF+olOAW2+
 F+DNidSW55M2D5NixkmUi6iOUly/jrPSLtGX1T1ui8Fxcei1cpt9TysBKEhAQjdzVyiI
 p40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778017593; x=1778622393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJBvhYuyv/JdwansPLGJPjqYXoVeTZUEnpdVBNEj1Pw=;
 b=FpLv9nqXa9XZV0rsqgcL71cFSilWiyLB3nkrWI3ZnBQiyrvi+yizaayjivgiYorjLY
 Gb/Vow1CTRtg6aLIfhA6n/zexNuzd3aEuxtlX1ZHyHGnwI5zWjccjFkd27jHjI+HR9h3
 IywYAhxeKnZIJ5ge4J8x+GsK/HBrkjV9Mre+b4iMfOVU7s49Bd+URonxeqIkdMivtxLJ
 /TCMQpNJeo3rngCAiJD9T9uEUjpp8WFDBgwWccO7I4UF5ZauRgVc+PhQiQ7KUun9Wmyp
 U7FHIc/SeiYeb48zGFo9cWTpcm6yDozfH32jRr6+NB9v+RSDKnAWDJKZzDox9BjR0T+9
 a4kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+baIv60cTMuR2uCAJNVzQrlX31NwWDLo2caFqSPPzYghD/1NID0rLGAZsLSWcym0zkNHNBL8zzT+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCQgVRG/ICVgT1i8TRDvyXeQXaK6WS3OXh0pz4PpQlGrjFqUN6
 W/J78Fne+XVaw3lNBsQFtps8NdP7U8tVPoKhP+4/wfA9nODwIaJ6uVUX
X-Gm-Gg: AeBDiesidcIl+lVbCePr7/MVmQcOrWFE91QZr4Ok7+ngeVPohxCI5YEu+cUQLhAn0BR
 QtLVQY3+Aea7caOiZsMGh09wvk+s+8SSF+FGerlXMShi4UZsG3mAR4BuJfA5BzDWkBygliqdhH7
 UWBHQagGyC7tm58AXC0HOXo0o7g37BtyuldWzh0HoDx0tfCFee/DBYt0XHYLWDKJfIbDYv/H0JI
 4Cw9P7HZWFcomwTRxgSO/VuUqyG2d+FYcvVNrcCPaZs/BEMVahjYNdSOckn14mpqDIuSe+T5drn
 6LRQa4jfePQlkZ2mqw/PCj6dSsISfm1eLMGdr1uAfZ2RgZMTKH4S0CKWy1Qtw9RDukpKQcER917
 q4vyxkFw/qtqoGI6Sxz+myHlKa7/b5x/sR+MQjt5YfCs/RnNLEE0YCQRINJdkGx1u8tM71x6fBy
 vLlWu6vnH6nDt34lu2721KoRTws3PHSg==
X-Received: by 2002:a05:600c:45c6:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-48e521e6090mr12630715e9.14.1778017593036; 
 Tue, 05 May 2026 14:46:33 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a824f9f0dsm411556165e9.15.2026.05.05.14.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 14:46:32 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/2] drm/mediatek: dsi: Add compatible for mt8167-dsi
Date: Tue,  5 May 2026 22:45:00 +0100
Message-ID: <20260505214541.333657-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505214541.333657-1-l.scorcia@gmail.com>
References: <20260505214541.333657-1-l.scorcia@gmail.com>
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

The mt8167 DSI controller is fully compatible with the one found in
mt2701. Unfortunately the device tree has a dedicated compatible for
mt8167 since 2022 and it cannot be changed with a fallback nor removed at
this point. The only way to get the device to work is to add the
compatible to the driver.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5aa71fcdcfab..167e33fef025 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1305,6 +1305,7 @@ static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
 
 static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt2701-dsi", .data = &mt2701_dsi_driver_data },
+	{ .compatible = "mediatek,mt8167-dsi", .data = &mt2701_dsi_driver_data },
 	{ .compatible = "mediatek,mt8173-dsi", .data = &mt8173_dsi_driver_data },
 	{ .compatible = "mediatek,mt8183-dsi", .data = &mt8183_dsi_driver_data },
 	{ .compatible = "mediatek,mt8186-dsi", .data = &mt8186_dsi_driver_data },
-- 
2.43.0

