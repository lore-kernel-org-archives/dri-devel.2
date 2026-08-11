Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7575C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D56C10E3B3;
	Tue, 11 Aug 2026 21:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="A6mnGtya";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2AF10E3A2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484557; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QnYHyXaDzyFCcXnDONLKLdRgzOQp4Imz8eq9U+LOX2cb3dJTdPvu4AtSccnsm4aS4/bVP7bW1J4ZwLN7Fwvqfqv0y78qQJnLpEjFWoFWQtpiZm3KLn1CHyMAeGcQnTXqG+vJIB72BYguKgbrUT1h53zxSqXfu2g6xTZlWotPKFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484557;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gXWqn0PSzICWH5EslTMaIg4HCbPgNoAL5LmLrMrJfYk=; 
 b=g26XQPXIzzyyYzHg0N4x9I+phTSNEM7sypmDvFy5FiO3bKbxeaZ0A5xaLtZ8lO856y5txDuateMfxL9nOkh4nV4dQUDrqy+wJncRjXGW/thMpddyeFekGvjpsGJgFZj3o2ywBnB15+c36b/C8IW/qrAVRVMvFPHrcOsi+1zFtUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484557; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=gXWqn0PSzICWH5EslTMaIg4HCbPgNoAL5LmLrMrJfYk=;
 b=A6mnGtyapXKQueHoBcONjtWGxAc8fKTKlVwuoLRuvccj51Sz/hn9SR9oOjtbaaqU
 eE0FnLeltW2sn7W8q1biSknLEIyN0870QCGLSLx2qVtwdSbeGsboMzEZ6ATAJd0OgUh
 ZWqkijooEdvbbNK9wj1A6cz867dBRV/6nk5YYBnI=
Received: by mx.zohomail.com with SMTPS id 1786484554872304.6230937100481;
 Tue, 11 Aug 2026 14:42:34 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:12 +0100
Subject: [PATCH v5 03/11] drm/panfrost: Remove unnecessary header file include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-3-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=739;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=6nL0tsxwnvYrZa+4jvA0fd4D06LAvqIIkYS1wNcDSWs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5czHWcgZP8lEIZbxJi91DC5KWrNtzYTV2EK0
 pPkttayUtuJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PUBvC/9jKiFi93oDekxUxTTQtXsLAGT7gwlJxzC+S3O8b9QrC9mVr3716/R1Yo2hS4F78mZCsqR
 soLGIQ6QyTP6I8wOvWa6eYxcrovRsbbxwRfpDQYUEMSqvhhiEnz2vSkTBsT4m6PX/ZfSy8DZl9D
 7zEQlAnyU/hggaTMABd0xj51ag560Dric2TsDQzOVUy6GN0YhCDggQb2D6FJl47930HeeqBkqAc
 FSXJFmSd3IP8rKqbUodINCwUXEi6u2Z2x5zalRDwPxEDIX/E0rl8LZp0Af2oMaejNTMY5MycZ4r
 wJ3rQ3N5SNYWJ26aILar/1E3v+0afWNwNbvbsdeoKi3GE8397yd0xwENUIu1POh/ZQ57KVy1XwH
 9I0aZAmwdZpRjUDCYcohZLn+mgxuE9tdk2gMg8kmirwM6m5ZMLb4/IDIxSgu8QKx/rRsLAKJQId
 GMaOSRj7xE8MhGDi9KFMMYUxqvGEQolPH7nLP+24OOlDme2D/Si6dCvC3wkxSbwOdnI44=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

None of panfrost_features.h definitions are used in panfrost_device.c

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..d8421fd6a662 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -11,7 +11,6 @@
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
-#include "panfrost_features.h"
 #include "panfrost_gem.h"
 #include "panfrost_issues.h"
 #include "panfrost_gpu.h"

-- 
2.55.0

