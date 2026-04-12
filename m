Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA1E937E3
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 12:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B13E10E2BB;
	Sun, 12 Apr 2026 12:18:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVxwA6Le";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E90910E2BE
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 12:18:53 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2adbfab4501so14263645ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775996333; x=1776601133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vgcJT6YPrQrJvW780ISmc/kCiCj7OaF09LinK7ADVkQ=;
 b=bVxwA6LexfXI+OXF+A2DSpVjVy1ojE8moj0S6rq+Vz9Qnh9KxaS9XX+UFCQ/ui+CSf
 w5A6gUxrNmAl4DSa8DkIi+Pohxc/AMUVRfyjAtnTAxxM/bhKzKJM7jia/L33AXGXIpnk
 21Z8IhEE6tXQ6IiL6KgaZ+NirZ7J66bWqOLKL1vjedqAZ3Yn0vY7w1EbvDOJPahj0B2P
 QH6CqVcaiXvcjePxASAkUdVn67Tcup/SuunUV1UZq2cFF/+MmFPZcbi4+6xIPZ5CpAl4
 W5g2OaSG6r3H6yU7WuW9yOzUvnDeq3Uwe2LQfFVAT5qiTTKj0Hfe2PrNH4COLlDLL+Ec
 kotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775996333; x=1776601133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgcJT6YPrQrJvW780ISmc/kCiCj7OaF09LinK7ADVkQ=;
 b=tHvn+lmabAqFq4ZYOn7wrR5df0ocW1fk7hpL5a7iYP2Cm5XDmfS+UU0SWGPHsxuEWt
 szXfY0n5Z8gFAs/Of++eaVm/azlKTT1VlzxvIKcLDbF0rl49cUZreYh1GOZcT0VJSs3g
 gtxS3/AVJYWZinIEUnNQigP6bXvuMDCAv99v8HsTDrhpDD5RGhJvihRyKlefKOnZHMLP
 t4dl1VfzzTBybwqRMT+xOnPY8hj/sjQGcI8YHbClSd5NKzf3KGAtYs/Dfhsgq6lcncGh
 56Yt8gPcGv23vQrKlTu8/d1QMOR7OhWs9I/6h5mazlOi5rk6g894ep6DrY4JvS4VL1wX
 +jTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Hp3EaJBUHpZwKTX7vb/idvuOwaUNAfxRA2W2QT+QE/1NDaXLfET/dp85sgTtmDgapP9jM2Cf92aI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJe8n+u2eQt3nu4bqy2So6LTZHoiB8+lnpXpC+DAuO5dUh/Ee3
 XBrPpWppkm+MKiIYbsDaxftHgvjCJCWRtTlNIbhHEpGWtVjOhSMARKJP
X-Gm-Gg: AeBDievKPeij6wW/ANsVzryp3zdK5+r19ECWwyCr+r7w8dhJz9RJLHq5v8Y/LJRuFD1
 nU7C+lE0OS0gDRP0j59K/IAIhiImcWlaePxMyRpv2rK1AG8Oc+4Eu7NSjECWCIbM9ElzOozzmGs
 2erPDzqgmpbyHrTyGLHtQh6+bAoWZTXVOFEvzeVgjUJOqBJ2NrMgwJSCj4o8CSuEYP4slkqkKWS
 Go+4suAFr6I/b5TPcyPxtVdaunKFkheqDaevZzUd9X7V9v1CqMmkNbma/Z+yT6jbyBZGnDrImsv
 +GEoyoD/Aj6wKqWKdtrtcaEz6woWe1/m87t6OsP6cJiWpjOwkebnLBw59PhCOw9NdLBIahzVzpY
 YjUCm3Lr301JgeA9HB0/XSIeuq+gz4W7R9j0TT8Ye59EhAbpQ2LEqTJoQsnwce/euy76htj76bX
 CQbOBcBDoRyCaEcw==
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id
 d9443c01a7336-2b2d5a7773emr97707585ad.36.1775996332835; 
 Sun, 12 Apr 2026 05:18:52 -0700 (PDT)
Received: from lgs.. ([101.32.189.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2eae817fcsm28965705ad.44.2026.04.12.05.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 05:18:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vamsee Vardhan Thummala <vthummala@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: Fix device reference leak in device_add() error
 path
Date: Sun, 12 Apr 2026 20:18:36 +0800
Message-ID: <20260412121836.2461556-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), the empty-subdevice path calls
device_add(&device->dev), but if that fails it only logs the error and
continues without dropping the device reference. That leaks the
reference held on the embedded struct device.

Fix this by removing the device from host1x->devices and calling
put_device() when device_add() fails.

Fixes: fab823d82ee50 ("gpu: host1x: Allow loading tegra-drm without enabled engines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/host1x/bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f97567e6ae87..e3ac85848aec 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -477,8 +477,12 @@ static int host1x_device_add(struct host1x *host1x,
 	 */
 	if (list_empty(&device->subdevs)) {
 		err = device_add(&device->dev);
-		if (err < 0)
+		if (err < 0) {
 			dev_err(&device->dev, "failed to add device: %d\n", err);
+			list_del(&device->list);
+			put_device(&device->dev);
+			return err;
+		}
 		else
 			device->registered = true;
 	}
-- 
2.43.0

