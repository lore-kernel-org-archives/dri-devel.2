Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18124C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6237810F560;
	Thu,  3 Sep 2026 12:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EZkkM3wB";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347C210F55A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B81CC4C2D;
 Thu,  3 Sep 2026 14:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437336;
 bh=MyFzBf3tjtdNgV/vWPpfQ99bdCRM8Kj6IUXp9pYogAY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EZkkM3wBBkD9CRGcmAbtJk3iGceghnxi051K2QlCwqDiwTCxfN26JAtEO6cOabwlv
 dir7vSC/ZGPU0pSsyK+SDUPfr6FqaTIFCHGicNNVqvASmnhWGNgiYnM2ve5szruWdj
 gPgyKw8CeG304BgWgfwQ/EaW/mVjvXvQ1KXMkLoM=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:59 +0300
Subject: [PATCH 09/10] drm/tidss: Drop WARN_ON() from tidss_runtime_put()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-9-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=MyFzBf3tjtdNgV/vWPpfQ99bdCRM8Kj6IUXp9pYogAY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOpVyaa2zgD6W512xRZVHqDdcPqc9R+5PFvW
 PPz0lJ0lzOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljqQAKCRD6PaqMvJYe
 9aY7EACx/+vvDDUtn3IoXJJFNivHmmQZb3aCgDu/KZRwp1BTrPV1vRKZqVDV59dCW3MkxUUoc1y
 4HHSq8JK+E/qs8RgkpkBpxROh88Es83CQBHHXbornDUMwcu7ekGGkzy8Rj+nBGqI2Uib3qU9Dn5
 UFMgHL4qkLqIl5goqagU8epmckldHfY8HwjOewN5D/YodCM4zqYAmjscBy5OQ5jPu+aUREWNPFc
 5ITwr/Os2zwZo+huwaXMR9e+Hd0sx2oN+VNPFkUvPlWSSU/Mpsa8XO6HwU8dCzd3xiJMg2up9LK
 V+rTZBWCxPaeZYbP3DIoHx9zt3smntSdw3JH0BNVOh2R0XxBMo5pS2vbsQ2LmsdeHGACQEXEns5
 ejB6+0jqt3eCaz9OlrX+HVUWpkME7tFKxwVWMGVMoU6QlNV6zL0S5MEAswoLuRjwWEYLoWKmMZR
 gWpIpoWCNP6up5+ahsoXN2q2nsFe4s+O3YixzyY7xF53shvswoowH7Jjd9I8oTG4+zvNbbN52r7
 SL0SEj29WQQxIZ9ajKJV8BQLAdsdzl+Z3QT29uLqkvXJn4HF/ECQCj5GLOzQYVKqfwE8tyt2Ml4
 jFWcQqOt/7Wl9B2hnqpKPJScdwHWzZLAvqpaDIzcA4Pin7YPBw43kfQ93s3/OtRqMQcJDPEzMmB
 Z2qlbH02qgjIwkA==
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

At the moment tidss driver has a WARN_ON(r < 0) for the
pm_runtime_put_autosuspend() return value, to catch unexpected
situations, and at the moment we never hit that warn. However, with the
upcoming change in tidss_oldi.c to change the OLDI to an auxiliary
device, we will get a child-parent relationship between tidss and OLDI.

The OLDI aux devices are children of the DSS device, so when an OLDI is
active, the DSS's child_count is non-zero, and
pm_runtime_put_autosuspend() on the DSS device returns -EBUSY. Which
then triggers the WARN_ON().

To avoid that, drop the WARN_ON. The -EBUSY is not an error, and it's a
normal situation with parent-child devices. Also, with a quick grep, it
looks like almost no driver in the kernel checks
pm_runtime_put_autosuspend()'s return value.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 5cb3e746aeb3..44b0b009c29a 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -40,10 +40,7 @@ int tidss_runtime_get(struct tidss_device *tidss)
 
 void tidss_runtime_put(struct tidss_device *tidss)
 {
-	int r;
-
-	r = pm_runtime_put_autosuspend(tidss->dev);
-	WARN_ON(r < 0);
+	pm_runtime_put_autosuspend(tidss->dev);
 }
 
 static int __maybe_unused tidss_pm_runtime_suspend(struct device *dev)

-- 
2.43.0

