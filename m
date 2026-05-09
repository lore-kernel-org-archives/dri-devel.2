Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E1CD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 12:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A270810E072;
	Sat,  9 May 2026 12:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=scd31.com header.i=@scd31.com header.b="bEHLk9f/";
	dkim-atps=neutral
Received: from scd31.com (scd31.com [205.209.125.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id AD79E10E072
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 12:20:54 +0000 (UTC)
Received: from localhost (unknown [146.70.165.171])
 by scd31.com (Postfix) with ESMTPSA id 1868C1402D5;
 Sat,  9 May 2026 09:20:54 -0300 (ADT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scd31.com; s=mail;
 t=1778329254; bh=o7Z4SCIyL5Kjw9Ej/SShgV8UZPvisiLqQF1vIjX4a2s=;
 h=From:To:Cc:Subject:Date:From;
 b=bEHLk9f/zXmBuDzKwhg2NN66nJRndawMRc7yv8nAjNrfQr/uBQtFUILcyzajKGxJZ
 A1ZcrwzatC9yBG4mGAHVwKMweyua6tSc9Ny0yKKmgnF6FXy+OcpTb8n7Bon5xrf7fr
 q2GyO9bR2/0S5kdNe5xG/voTgE7fafZAn6F3T028OTTM1JjD9gLD5u+cnrzHHpZOBv
 QLRGGoFIg344yq6VGhxTdsYVQg1aGPIVJkCd6uj1ppBXz9xjHfZkNCXS+XI6Jbweis
 DgGSzYC/KuNSS7hs/4C9wACFaAjJNYEhHLjMf+1mjKe0OKIJV79aKKY24yHCB7W0Xx
 ZCnU2OqGgVBiA==
From: Sophie D <patches@scd31.com>
To: dri-devel@lists.freedesktop.org
Cc: rubenru09@aol.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, Sophie D <patches@scd31.com>
Subject: [PATCH] drm/gud: Add RCade Display Adapter VID/PID pair
Date: Sat,  9 May 2026 08:20:37 -0400
Message-ID: <20260509122037.4189266-1-patches@scd31.com>
X-Mailer: git-send-email 2.53.0
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

The RCade Display Adapter is a hardware device that allows driving an
Arcade CRT display via the GUD protocol. Currently it spoofs an
existing GUD VID/PID pair. However, now that it has its own pair
assigned, it makes sense to add this to the list of pairs that GUD
supports natively.

More information can be found in the project repositories:
https://gitlab.scd31.com/stephen/stm32-usb-vga-adapter-hardware
https://gitlab.scd31.com/stephen/stm32-usb-vga-rcade-adapter

Link: https://pid.codes/1209/4FB3/
Signed-off-by: Sophie D <patches@scd31.com>
---
[Resending as previous submission did not make it to the list]

 drivers/gpu/drm/gud/gud_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 17c2dead2c13..89bd6ca36003 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -684,6 +684,7 @@ static int gud_resume(struct usb_interface *intf)
 static const struct usb_device_id gud_id_table[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x1d50, 0x614d, USB_CLASS_VENDOR_SPEC) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x16d0, 0x10a9, USB_CLASS_VENDOR_SPEC) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1209, 0x4fb3, USB_CLASS_VENDOR_SPEC) },
 	{ }
 };
 
-- 
2.53.0

