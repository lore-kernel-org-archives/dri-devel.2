Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDA2C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD27810F1F5;
	Thu, 16 Jul 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZuGth4dS";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB8F10EF17
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:42:13 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso3632309a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784101333; x=1784706133; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v/9XWaR3xNGls/DnkUkxuqsc1d9ZqSJqTwvyT8BBonI=;
 b=ZuGth4dSbBcP/27rgoNu9eqMPrGcvdmLLuMNO1ctX7HvgqeqwvSDcGZLDHB0yqcsW/
 IyQkgZA4wxmwNtkgtHsAiWM0OSyrqAYs8VYFKxBZsqju6+UHnpEQnlftTG1afJrR2kQU
 PsLU7kUDOPvNphOfJXuJjJRwqQ3aSrf6oT6UJLDHL0Etn3V0NmreGTlJBig/buFbxNFW
 E1d3igM9+eKbo8RqOSpCMgnV4/REilJfBBkcb06uYlU1LU5JEZldUlhLNza+jUiXRYPn
 eOiyHZXezC8mqgLknWsmVDGTLYncaP6XTUM8OXw1sFEuhOz8D8dyyxa8SHMCy1ylJ23j
 LG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784101333; x=1784706133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v/9XWaR3xNGls/DnkUkxuqsc1d9ZqSJqTwvyT8BBonI=;
 b=j4TWTumyvVXkpf5EmqXxi6sPTNvJuKSvam2XtRkdcz0wsWe3T3Q6moPmMbYAtTJp6c
 AwWdhjzmrEww95cIcQ4E2uNQy6rnQ/r/jAd22ZWyHY0grYWFUk6vIhCgjk5bnmI8L2D6
 UV6upJQ7c5CBujvfiDxS/CHNKrOrDhJq6gxVgFaIGzATl8TIDZF7ljtqp7wN56Vc3jNO
 Au7kURxHvJi8VPIwYG5cAmgW0N+HsJVeD07xl1ynWzm2wTdGJ5GeK9cqfDyrlPHidAqw
 /biAPxGxxLrQMYZ8X533XlQCYgDG9gOOiZL9oPRZN0nw81Mok0AAw0HSgkmiQLejDn4w
 wLww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7sCFrJ9xDB9cBQxesVv1XvlfKHExvdrhyU3t6v7HX8JJYKeVq8/rjvSG13l3Pve3aYh0FHzm/qrQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6cr99EVVomgOkYshSDXstPEu0H3InlKvdZ6kH+SIgbf2p/id7
 tOGZEskeSPA+yspwNDlyZrIUNvwryOIcBbQJQnVTxt2dr6tQqZI9x7LM
X-Gm-Gg: AfdE7ckUra13mqqawj2i1BbZELnZyAdDdPIl+SgWolWNDgCvVqpdbk5jI17xuCzIB6V
 Aws6yHnNqdDoSi1+Hnp6602KpTaMoF+C8mNiCEyqQ4FryZaL8uVMAAnIDXJQX4gXZ4S0PQvvznm
 /4zyWwNoICqaqq6MFC0xqCwW/XiPWdvAXsB68dP5XSAjIle5pbl43U5sjTcLzouKcsJx6TH9igg
 GGhXpjXF/rsvgJx48lP6mSzEtLhkOdR2kbYMtqdKD63e5GyAy06QAkSbhfbwP9w1KjLhuhoKpkn
 N6RudtoT+UN6atJy/m46rXbwQ5boIW3Nqz2n+6GzcTM+DuROYZd5vBNeNaPrsCfCYJeSVnW70xO
 FxogIXsS62XZ/+NxIaa++emVB/px1kp/rRT0QS2pNBvb3ShfbhflhZVvCH+yrgdf3bp0fkxvvky
 Mfa2YBGOpNkVJ5gpacti4=
X-Received: by 2002:a05:6300:2208:b0:3a0:b781:4c78 with SMTP id
 adf61e73a8af0-3c36c0f6ea9mr2095219637.15.1784101333320; 
 Wed, 15 Jul 2026 00:42:13 -0700 (PDT)
Received: from lenovo-thinkbook ([1.22.231.74])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd22ec3cbsm829255c88.15.2026.07.15.00.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 00:42:12 -0700 (PDT)
From: Jhonraushan <raushan.jhon@gmail.com>
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jhonraushan <raushan.jhon@gmail.com>
Subject: [PATCH] accel/ivpu: Reject firmware log with size smaller than header
Date: Wed, 15 Jul 2026 13:12:06 +0530
Message-ID: <20260715074206.867712-1-raushan.jhon@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

fw_log_from_bo() validates the tracing buffer header_size and that the
log fits within the BO, but never checks that log->size is at least
log->header_size. fw_log_print_buffer() then computes:

  u32 data_size = log->size - log->header_size;

which underflows to a near-U32_MAX value when firmware reports a log whose
size is smaller than its header. That huge data_size defeats the
log_start/log_end bounds clamps added by commit dd1311bcf0e6 ("accel/ivpu:
Add bounds checks for firmware log indices"), so fw_log_print_lines() reads
far past the small real data region of the BO. A size of 0 also makes
fw_log_from_bo() advance the offset by 0, causing the callers to loop
forever on the same header.

Reject logs whose size is smaller than the header (which also rejects
size == 0).

Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Cc: stable@vger.kernel.org
Signed-off-by: Jhonraushan <raushan.jhon@gmail.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 275baf844b56..716467aa3156 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -43,6 +43,10 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
 		ivpu_dbg(vdev, FW_BOOT, "Invalid header size 0x%x\n", log->header_size);
 		return -EINVAL;
 	}
+	if (log->size < log->header_size) {
+		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
+		return -EINVAL;
+	}
 	if ((char *)log + log->size > (char *)ivpu_bo_vaddr(bo) + ivpu_bo_size(bo)) {
 		ivpu_dbg(vdev, FW_BOOT, "Invalid log size 0x%x\n", log->size);
 		return -EINVAL;
-- 
2.53.0

