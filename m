Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC45EA71B3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 01:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6DE10E07F;
	Mon, 20 Apr 2026 01:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S984cYUi";
	dkim-atps=neutral
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2676910E07F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 01:01:32 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-60fa5eb3ee1so786336137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776646891; x=1777251691; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cExEE0g/VkjWFezfORG8uwyZglaid4Bs+rAW28gYyow=;
 b=S984cYUiviV74cN3zwTkYnFL82e4FFgHD+vbM8q5jo0wdQgmlfvCSMVSrjlnXpN+D3
 4g1MJwN3/IaqgB/h+PR6HrskNAbPy6Zgsx1n7Cq3+Uyypj7xbpkyn4U31ptMN1Y1Cho/
 lt5GzXqa8DJW3obPpPegKcylljUH71C2LUKu8ccV//AnN2fE3gwi2ZyL22r5piwx7tdP
 8MvU8E+QRtGQMZPt8Qzn3mSjE2V6fbc2ko8wz7qudjqdwW3a94Kg7rHdaaOZw5RZz3WZ
 grIaQc3cJOnxNkBVDj+QXzAX+DVCaSGQSuIOQ1B2ZsO0VOyvi5AsgN/Cg8O6oKt/+37O
 S+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776646891; x=1777251691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cExEE0g/VkjWFezfORG8uwyZglaid4Bs+rAW28gYyow=;
 b=GnMdnQw/NCLtsUZHsGC4qgn218C4nkBTScxaGaidfReuTu6ftSqV00K3Tq2XiHAf2Y
 dIAYafvyCt1T/uvuveKatDnDWfxi3BlPCNCMBnNK8cyqLd63NypiLN2nCn6qxR8xeAn5
 qDNVuWrs92QDezg8BhIv9had8hFawQ9JgcRieT9ZXNy1PDNWhrELSuoDWPfxiqVP7Yb3
 fF2uWx2nYwFfiMkNKZjJ2CeHsR07xJTyMyk+orufLAL5ukGyxO5CBzI0uRGyyd2slAsD
 wfgruCjZ+6qwSx30tBURrplGzmMct9ySfIxsvmAC4xHzqKOG35XjDsHGgZ49oh1dLG5o
 bBhQ==
X-Gm-Message-State: AOJu0YxThBE5BScllrz68Xurjfbdwc8RZEJsQ3jYwnmU4sl+1QtrtMLL
 gLzi33W2PWK6E0y4LEPq0ZU4hsq1Jd7Y/+3Hv4+SGAVfNKfjmsA+p6IS
X-Gm-Gg: AeBDietcCL2dYFvuxhYxSyZyQZbitaMB/RtugV2VSzLKEgdgZhYhrCjAY1IGTuSJZTN
 yXkW7Zo/KIQjxnxMIXekkCTGSiUwSGpTRupV/S04V4ku9Iz3dmrc6h0knDSGdSnxuJjM+ic4G8E
 tc4KwcOBuJMEUeBq1GlzZK+eRXBfARMI090PRXqFWOYqYxvhmaBh8cG1S82uxubUfQlP36Rov8Y
 6P5mi2E6Jgb3fzhESbT7I5WibEInCFjukrlZ13rmM4fql9cBTgvsVxug8UIUIp5BslkRvf1eD1Q
 MP44xTBiM/PniaJ0Mqr8cDV8SfzaxvHIbEuG6k++DG+/GVlDZpd78KJrZCVCpaYgwf3h61rBXH+
 xeY03WCQvbCBAe6lkC5DO3G3dTIWTfT8GE/3IuGGBiVGBU/BLGvzeS5NLKE5T5yvMcKSIrmk4Vf
 8FFG5/AgZHy0W7/Y9dBl4yvTWgeIf4Acj34lm3gJmIInonQNhQs0Xb2bbREdw=
X-Received: by 2002:a05:6102:6c9:b0:607:f24a:1bef with SMTP id
 ada2fe7eead31-616f60b3913mr4269910137.13.1776646890798; 
 Sun, 19 Apr 2026 18:01:30 -0700 (PDT)
Received: from localhost.localdomain ([165.85.38.136])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8eb9becc6c3sm44376885a.39.2026.04.19.18.01.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Apr 2026 18:01:30 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Helge Deller <deller@gmx.de>, Jason Donenfeld <Jason@zx2c4.com>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>, Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe failure
Date: Sun, 19 Apr 2026 21:01:18 -0400
Message-ID: <20260420010118.17960-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
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

offb_init_nodriver() gets a referenced PCI device with
pci_get_device(). If pci_enable_device() fails, the function returns
without dropping that reference.

Release the PCI device reference before returning from the
pci_enable_device() failure path.

Fixes: 5bda8f7b5468 ("video: fbdev: offb: Call pci_enable_device() before using the PCI VGA device")
Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/video/fbdev/offb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index f85428e13996b..166b2dff36f59 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -640,8 +640,13 @@ static void offb_init_nodriver(struct platform_device *parent, struct device_nod
 			vid = be32_to_cpup(vidp);
 			did = be32_to_cpup(didp);
 			pdev = pci_get_device(vid, did, NULL);
-			if (!pdev || pci_enable_device(pdev))
+			if (!pdev)
 				return;
+
+			if (pci_enable_device(pdev)) {
+				pci_dev_put(pdev);
+				return;
+			}
 		}
 #endif
 		/* kludge for valkyrie */
-- 
2.50.1 (Apple Git-155)

