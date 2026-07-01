Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627E7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CFC10F06E;
	Wed,  1 Jul 2026 17:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0AyW6O5s";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A74810F06E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:19:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 59386C4FECB;
 Wed,  1 Jul 2026 17:19:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 529555FD9D;
 Wed,  1 Jul 2026 17:19:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC56B104C9688; 
 Wed,  1 Jul 2026 19:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782926385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=jYw8Rmlz5BDw6Yw7doVXKZlh7sRJ/4pZqN/ZhMLruEs=;
 b=0AyW6O5sbig9nwgUu0AiJ6Jb0iqlUiDtZA5/ZM2NF2lIYCeRAic5evxbIXLUACrJG0fsO7
 t+AKsv0ZZXi/wj3SR+5GmZjxsjiiq+cBNYa+F/e/Boy5ILpc4V3IPPny+ZrwKuP5OvW+mx
 D9MEMzhFMy4TZSVfQtxLtwEuTP4zB9tTJUJtzllCiNTqwXUWCZ0HNMJ1Cvke0Vg5u+uPVx
 8ieKBleIPg+r1iox8WBGYgahC8OsRNVun5UWObOuO1TtrJNBpIiDvZ0Vmve9rHPFybHl7Q
 0a4jZ16lIehtLoBdfkkkahJiEezhjshsbB7r2iWWyvGRJTuxPf29XrCTkawe2A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm/bridge: fix wording in comment about graph
Date: Wed, 01 Jul 2026 19:19:37 +0200
Message-Id: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXcgKt76KsVFmoxxhEaZqC1I3
 r1Rlx+c8x8QSJgCPLMDhHYOPPuE/JGBGbV3hGyToVBFrRqVo5UPDvxDJ3oZ8TuLZe+wo25oqCp
 VpVtI30Uoja7uq78dtvdEZj1jEOMfhj4o6nkAAAA=
X-Change-ID: 20260701-drm-fix-graph-wording-9e9f7e5305a8
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

These patche fix the (almost) same grammar error in a comment, in all
places where this comment is duplicated.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm: of: fix wording in comment
      drm/bridge: samsung-dsim: fix wording in comment
      drm/bridge: fix wording in comment

 drivers/gpu/drm/bridge/samsung-dsim.c | 2 +-
 drivers/gpu/drm/drm_bridge.c          | 2 +-
 drivers/gpu/drm/drm_of.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 844e71ba7d7a50c5ffa29d147afaeaafb19b39e4
change-id: 20260701-drm-fix-graph-wording-9e9f7e5305a8

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

