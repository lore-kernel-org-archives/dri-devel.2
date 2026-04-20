Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E7F588C5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF3B10E59C;
	Mon, 20 Apr 2026 12:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hcX0kIze";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122DA10E59B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:42 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 414CC2B57;
 Mon, 20 Apr 2026 14:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689584;
 bh=pkHYfXpvclqEJ8daziW3Dv34yzf0Pm9I5IrucwaeY60=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hcX0kIzeHJPqq+bdxH6vuMZV/5Fqk0oaBjfvMvD11TFgqMTmWPP3D/Qni3wUvl8oh
 46KlH4DsRpVYQ4kgVr/T/tgLNkAMSDKRTEL3IzUQW+go1FnhrknJYg/ujt1kem4e14
 9dQX+IidMxqWdsaTcGa0v9jF55R0/YBtyXsFIKg8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:13 +0300
Subject: [PATCH 06/15] drm/tidss: Remove extra pm_runtime_mark_last_busy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-6-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=713;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=pkHYfXpvclqEJ8daziW3Dv34yzf0Pm9I5IrucwaeY60=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iIFk/3ZtYJiRZQy+gQj1AkKOh0XebZylKJX1
 kqy6mxF8tiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiBQAKCRD6PaqMvJYe
 9WJhD/9zKPK6I0cpMtb6xyjqzCbLCtxPLZsEvRbOwj8SIStgYripUBMf0Ib6O1EBb73bFWNvC3I
 gyR3PnKQsddT6j/+SW/SVd04FpqlrrXc1U8kPWA32E4lufTOPy/zBxAbEki2YScso1zqPiP0kp7
 YOdSlB+gq4E9RCUC27lEONeM7IL/jEXGrYUXBkLyDj566aHS7lNnJMf9FhCfS8bXbS92BPOcLRQ
 gO+xfAjxgOh9KQG/76LdTPcArSYTh7BgemefE4uEbvQs1AOK1ig5q3i9RXDgw1CeL5/Rtzl7dlC
 wiQBSqRZJ/9VpTA/cv2NQgh8C7fxJlb0AH52EjUra4VQd4qse6HHpZYj/pxxib5n0v+yZ1EiEhH
 z9wbH75pRKUD59t09QTdA4cgSNfci9jiwqfeQ+9RaSqm+h3Hl9SSE2wH20iCfuUkZuialzWf4ic
 SIOISc0iCSTbopyfqBm0vjAGsEPHGfZ4M0EYBo9pRv8VVxVXq5sohLFhxe86iXDDNoiFQb1ZyWQ
 VjSdilj94IzIS0L9aOHqTahVhiG656mDTTNSnmdFrQWJmK7hkSIVyKzQ91LtgQfqG6zdIizMIo8
 ranSO/QGUNJsQA8XNl4zDIFsYoV6trk8A8nAegrzMCTJlZhxUDkMgGzsdymF29nLmrNvjlEO74t
 xVd99F+UZo4fApw==
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

