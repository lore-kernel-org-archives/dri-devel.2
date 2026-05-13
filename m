Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C351CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EED10EE74;
	Wed, 13 May 2026 13:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FNemlzls";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A488610EE74
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:03 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 557722CFB;
 Wed, 13 May 2026 15:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678274;
 bh=7Kq5ctr2zF2W69THhXrq0QBJ23m1uyPy7zIOXMhkLEE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FNemlzlsknUs+qDdMnYLcETJohafmtBWDm/2QdFJEA9+K9DsWTHGyL0yWUONqbYUt
 VcDRD8Il1WooHulDS1tIfEapOuzPBJdhtDTZt5/7My3r8D67mKPVeKqsdDrsAEvgLo
 kc7bZRWRGlVIhDifmGO0PfXQNV+9WeJYUdrt8gHo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:28 +0300
Subject: [PATCH v2 06/16] drm/tidss: Remove extra pm_runtime_mark_last_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-6-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=754;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=7Kq5ctr2zF2W69THhXrq0QBJ23m1uyPy7zIOXMhkLEE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn+egwMDI1sBhvAo5l4eKjuQE8QH/7ZBim66
 3+X//kus9eJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/gAKCRD6PaqMvJYe
 9bQuD/4mDDxoW1AcxcDo/7qxJLvyE/T1uRl3v+CWVFCKXq7XjrW4RLAe2dMLzGnB7iU0Tsteu80
 rEqeWkfTdiHzk8jYL9il7qpIJKR9apTddjm3UgWzKaeDamsJVP2FdV0mU/fc+LxKWRPMCBl83Zd
 6A/uTQVBTTJozLDFH6LYgYnsc7qyZVcOrZd66HPzgQSj1AtxGBvCRpme9tg+oYFpNNFd16QfBse
 p3PbSm25Z/ltXM+lN017HAB9kTv3fjmHSJiyPbPJTQdZtdwhTOquK76LbbY5WFxVoeuHWf23xfX
 iAMFuXmUjMjDjavbXDGLOkScZSJME1NhgJhRp2yUfxJkc9l+l4C0bQLPYjVPeOz2hTdeg1AdZGW
 OZoff0L9iv/aEjAGdULChKXlfGcS6kUhMXq6eah2S79XqEvA8gVIEN9l+WRUaov8/ErHINvHAiv
 nlkwyuM9+pt/IxGea4Q81NvUA783f/2rqRr/i0sPmSzeADy4yS7R9fwmlDvTey/r1sXCRZNQYwH
 C7MvKSbsK1yt8LjWvAuUbdl+fdrUYKsAVPUc5YRgo5iFRM+5DZF68zGFHus7zv/nIztrRrTqU8t
 DboVSUwqAR4FY3nOt2XdSzJ8YnnS1WaTJkbLd7la740Vi9Isy6BOercW5mQVsQly3VAdB8jkvjb
 hdAC5Xsc+LCo8Ww==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

pm_runtime_put_autosuspend() calls pm_runtime_mark_last_busy(), so no
need to call pm_runtime_mark_last_busy() explicitly in the driver.

Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 1c8cc18bc53c..5cb3e746aeb3 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -42,8 +42,6 @@ void tidss_runtime_put(struct tidss_device *tidss)
 {
 	int r;
 
-	pm_runtime_mark_last_busy(tidss->dev);
-
 	r = pm_runtime_put_autosuspend(tidss->dev);
 	WARN_ON(r < 0);
 }

-- 
2.43.0

