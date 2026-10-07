Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B29CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C917B10E5B9;
	Wed,  7 Oct 2026 13:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qjK2wWX2";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F5C10EFFB
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:50:36 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3a88d1d911dso832221a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791370236; x=1791975036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLBcFGOFinccADlrrF62WWwM4vFrExECPGKcB7WQaMA=;
 b=qjK2wWX2i/csbooxnVs/1nZhN4wJe+s59jTL1cdFj7y1ak+2ngdNCk+iuERVJVZOgK
 l2xz3ZwxSgCyQsLnD+883hrNDdrDsqk9lhGGJvCosk42TST8SpagvcD5N5YnLfulRfAq
 kukmFZC9iLqdTMFgl9zlM/KbgxqrH+jWWT1HUyNGgQx2exSncuvlWC37kbSIYGRtw2tG
 cFuXrAjKqhrkoKVCFiELehytxzYIpLXNIl2E1SCShMqRwr7j+GmwYwQ5QxMYRUnfRUpV
 es6wfjmBct1HcDLUwDsi/FH+X6u/7VqbVMgiINBnZdNZzfK8A+KSaS9fjFZYGCtBH6+L
 gNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791370236; x=1791975036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLBcFGOFinccADlrrF62WWwM4vFrExECPGKcB7WQaMA=;
 b=0JWzTkEW3xgdmajzqf4I1VSLXGZnK6ABKnCQadhJNGRtrUa1TJE5qMkAEYfVAtt4kS
 oWSC3J4L1o1y/K45HMSOBTwPKbq2S0mP8ZPdj36BOicWuPCnWB7An0ErwuqYVk/BucnO
 mN00m2vhsLliQNIu1p9VoNZFwYu3pu/YQQ3V6aW0QJMr+Odb7xMW/hmWkpnpW9WDDjVi
 yq6gC3srgPkUPYbhJHv7cJQ3oTDRUMuXNtEhmdPBt1InfCncnYf1xArRY5tRMpxo08l2
 rmE/2hTd0davq9iZc6E6eIKSJ7GveJgnz2Mc3u0y3HZNABWIpryBzQUshuYbu1jvaZfU
 QNDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkkiwa2FjEP+CiUhJKr9C8O1Ggew7nKaaDn4Bm6bj5hM8JQCC94z0LtkUI843LJP1EWUBNqNg4Yfs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJnS4svFj8PQmWhfSqxIT2wTcCKeoOtUXA36FU/fAvuuSSXYeex
 zhkbIxclGrhi33mVyFoQCWYcCH8I7DoU80W5im5k9Z3OiqoksxxccciO
X-Gm-Gg: AYBFou2SvbzNCvZOdygQaI7OZ73gWb9X5CCVk1o1R4rjJ7KfVRR8arFQMNjrjnuFYJF
 eeLuPuSY51KpreMxW2QDUE8ONxVcIIFZu/pf6iq0lGxzhMso9qCaQvU8TdMSWnKQTmBQSalidMk
 K8nxufgckfkrk5696cNrJp6JlC1HptU4L1QtO7lwgGLdWWZbY6oQ8oAxnrKpzekys1VXFjHT88X
 Ne/x86A541/GrbHsSsAC5evmJ25nh//NIQ0NsTe6WUq+GiBnEXSkTPZNazmwyLyLsQzTizoxSw+
 05w25IT98BpEnkhyWjJQcn681a2PoyJ6f+qJSymEscaqG1WzFT7Vd5/bQm4MfcY1Uau1iZx6Zey
 K6WYoxRgk4JDIQMpUTLgY8167kfRJ2SLO1z1+vBDUCUwZMW/RBx/j86tYyAqyjMdFJWpWwFkeZ9
 Kqw0Gndz09BVUDz9zlgst4NeO5+7QfJzEB2+YNSVmrb3bXZxpQkd5/x5B3L++nfcNFIuQwD9a5N
 7Bp8X1Ut90M71yGfX2MIVkGZovs+FoqdBdw8trwvGqhBwhOwP4AVAUJFt5rUsNKk2KOjgAZ5pXC
 gHoqWwq064S0bQ==
X-Received: by 2002:a17:90b:564e:b0:3a4:e234:111c with SMTP id
 98e67ed59e1d1-3a8a1d0d246mr1455895a91.66.1791370236016; 
 Wed, 07 Oct 2026 03:50:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8543ab76bsm9408706a91.13.2026.10.07.03.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 03:50:35 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Alex Lanzano <lanzano.alex@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Mehdi Djait <mehdi.djait@bootlin.com>, u.kleine-koenig@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] drm/tiny: sharp-memory: handle enable GPIO errors
Date: Wed,  7 Oct 2026 17:50:23 +0700
Message-ID: <20261007105023.507855-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

From: bui duc phuc <phucduc.bui@gmail.com>

devm_gpiod_get_optional() may return -EPROBE_DEFER or other errors,
but sharp_memory_probe() currently ignores them.

Check the return value and propagate errors from the enable GPIO lookup.

Fixes: b8f9f21716fe ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 7efd7b567f3b..35254a2136c9 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -552,6 +552,9 @@ static int sharp_memory_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
 
 	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(smd->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(smd->enable_gpio),
+				     "Failed to get enable gpio\n");
 	if (!smd->enable_gpio)
 		dev_warn(dev, "Enable gpio not defined\n");
 
-- 
2.43.0

