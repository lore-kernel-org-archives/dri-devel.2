Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC27CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A3710E36D;
	Sun, 24 May 2026 16:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AA/Kt4pN";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502E610E36D
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:37:16 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so4532394a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779640636; x=1780245436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/frhfWE+TSE+p0T4y/HY1o3wIU0U0eWSs86N+bYmrTc=;
 b=AA/Kt4pNpuXjJ9e6NLb7T+8gOhdPedM6ul25HLrd2eDf3RzHGxeUlsNbAbNxlzrZYR
 qjGPHgMD5LZQoKDfR9xNyn4TnJ2oJZf8jXBkdI3CDHh+Y5nmovlb9GbOlkelPck/65lO
 1KYBJElAKASk7TSSgwhj7b9GW8nOMxFj3zC8IU1jHjtIcUjq+gJpStNeO66lIHIpK/b0
 MWocqsjJGsctg/LPZAhyA8iPwwRBsAeiA5kW5IsAcYcvXDT7uaoS9pcMdTC6ebLtJaRC
 Ic4a/U5ms3bCJLH8l2cycYwZa6ZfKsSDEKDlfbJspidemJ2NffAFhb8EEphubJ0BPadg
 XqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779640636; x=1780245436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/frhfWE+TSE+p0T4y/HY1o3wIU0U0eWSs86N+bYmrTc=;
 b=ZmSKep1sSwh/wZkENG1C7bgr/HI+H5mR86cRbM7PmRhkMNqsfQYxVLW/38vbsRmZHL
 D8yYzTfua29FIdHkzPwtbpQS0ymEIlKA1uwvAKK4SMh21PxFoIOj/gWy06aZ4iCO53C4
 +DxmtWli/1wwtcOCum/pgvQhouGlxE8K0lfGw/ZoVlkcdZVJpp5czS+fxdVhLOdbv5NY
 ++gkCWZqiyoU6PLoYcfiyGRo15oLcEvKFvX+Yyq8wrMWX2lSAZ78aoQivEJzzbD2ceJl
 CIvETEBgBTiBhwfDncp+HE+wlConaLoOihPLODrSsmG4iAwGpUveCQPmuPW0eBWAcAbu
 +7Aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MeUqe0iZRRAWdW34PH32ttC8VAny4g5pbZDBYBjUW5o10s6zNKoWmj4GeuAiiNbcTkNnsx95qn3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx85x4skvYRDIty3gLIDyxa3xNxbHZkNUMj/DXLuNJmOYm9nKwB
 c/5SYHW2BukgAionE/EGDTai4AmskT0ppE9Vuk7K2ISNk31rDd+/0jE=
X-Gm-Gg: Acq92OGHtMSRNR8agGFCcZd0+q5TlFcNQGd+9uLfjMbNfQ1g4hVh+CqsdF5Py4QErjK
 FAqvvNKJ6R9LJ/JtC1BnRHEKqRX4oA7wUM+b8oMH36N482/DNC76SPxnvs0kgLOujrmJz0Del5u
 Covl70jiXc3xFykeiaviIzDklCk2f8GRqWafham6y+RfWZ1tTDGDVYUFO9SCi+/0vSk/khEHLQh
 +BbrCgyatsnbx6FVLJ2kNmE6BAYUrHM34OufXfK/bs1p0IrWzF2LUIzrgxatkbKv05WrkTEToJn
 ZVvvSP80KVLjwI/rG7kKNOGYysjC4j+JpFd9asBOcs1PffDPAFpXVIxzKH2Tv+PECTwbuYqVO0J
 48/lEYgJY/rknfXJl37JBQsgJyBuHnGGi46Dp6oGcCE+/NxLDEw9Ht7UAAQV5UfrbymdaS4w89K
 NqCiYMWre+chcEoR0VnBgFBiTLPKxQ+5cj8WwyEQWEXnEh9OV5qYQjse+Wq8nVls8xN8NomC/Iy
 xXWTpxvZw==
X-Received: by 2002:a17:902:c410:b0:2ba:5e99:93e8 with SMTP id
 d9443c01a7336-2bea240f094mr141303195ad.29.1779640635695; 
 Sun, 24 May 2026 09:37:15 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b309bsm73017325ad.51.2026.05.24.09.37.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 24 May 2026 09:37:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH 0/2] drm/panel: use devm_drm_panel_add() in more drivers
Date: Mon, 25 May 2026 01:36:31 +0900
Message-ID: <cover.1779640137.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Convert two panel drivers to devm_drm_panel_add() so panel registration
is cleaned up by devres on later probe failures.

Both drivers currently call drm_panel_add() before attaching one or more
DSI devices. If an attach fails, probe returns with the panel still in
the global panel registry. drm-misc-next has devm_drm_panel_add(), which
wraps drm_panel_add() with devres-managed drm_panel_remove() cleanup.

Patch 1 updates boe-bf060y8m-aj0.
Patch 2 updates novatek-nt36523.

Myeonghun Pak (2):
  drm/panel: boe-bf060y8m-aj0: use devm_drm_panel_add()
  drm/panel: novatek-nt36523: use devm_drm_panel_add()

 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c |  6 +++---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c  | 12 +++---------
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.47.1
