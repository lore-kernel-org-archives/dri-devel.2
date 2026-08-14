Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927DC5DF77
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2A210E2EE;
	Sun, 16 Aug 2026 14:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Di/RsI2K";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD5E10E142
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:27:56 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso934555b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786714076; x=1787318876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MWWnpnQHVUIEDdKadx6AJONzCNBQuep858a4rr+92VI=;
 b=Di/RsI2KqlRGH8WMp/MiZi0nxWYkxIfPKUjGengf081mxUSI//N717ibZ9w1OAbAvF
 +WxfatLBlWXBMMGlFIFBTdmxYyz0a74HPbz3Hy3xSnLvDMKVEH04XtFKruHV3nyQvtpl
 3c2PT8SsHzrHb2HJ4GXLuHCe/G53fVndJcIWPqeha7sCmibCuSII4pt8tYSH9Vj6SWIf
 JB9JtCUz7LrXH1u/Eksz0qDbJAWSWVxvZ2g+lXp0YBQkH9kG8PAkHgQxwhtgcWZXEqmz
 /UxMvkSoClDVumhXwTHm/X7hK6o0Y393o8RWTwjgtZc0KLRmGSnW76yVwlgI7tLnKobx
 apGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714076; x=1787318876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MWWnpnQHVUIEDdKadx6AJONzCNBQuep858a4rr+92VI=;
 b=Xaucm0QItkhWdmiCc+FJ79HoB65WxmlQJSziOVPirNaBOdjjIyzC9WX0Nno0iGEv8z
 57wiOcc2vCopn+VWzGZyqybih3h+xlYCEQlzLfD/NeKIq/Y80fH/LnFBdkqqOrHtuG4o
 tQqVRPcdaLPkLkJcsVBBtHteGXbe/w8z6EFsNYk/ws0MMhrzKS8sZFQcImIAjwgxW2fO
 i0hEfqLs/lhDIsGTOUrZ4EW5aymfrFYWRB29GFb1OEY9EK6ZTAqUnU4Z8oVs9/uJM9co
 I6frlQeD6WvxLcgLHiBYFoMb0U+jWc7Q2ROnloCakgVU5IjwO8STz6pnkGgo3w3Y6SgL
 r5GQ==
X-Gm-Message-State: AOJu0Yz0yFLUxZjDJGtzLcuDb5UmB7IlCqlKWYiqwXr+WvHniy8HrL8l
 ceYXglyNZwzyKcqOiumuEWq26fR5kgLDXG8gTqi2MGRT8IO8mB7vBnEUKasTBfdVgkIOBw==
X-Gm-Gg: AR+sD12Vs1RNHT1plWgj/aaPUwIBYA3oDa6CdZ96diYkUv7XjOdjvQP5oX3MrIj9tvY
 3ujXwFpqlJEQhirUjlGdldAZ7UBKf95fQPDnHbs+xDFoacXVHZ3rNSu9gsyDzc93NjJPGw5gf9L
 r6ZCjXQJFz/qL0ojg1eLZ0rVmWzAjB6rN8BItWNGvJCF9GqV2FTJjUnws9KaYMfBR2y3QfpLFwo
 cuJY7cdEDtNRBInkOxEm4An/DU66P8twUjVkTLlWOHkZ2K4jPlATZJJOsd6XNlfpVJPgLn0fenc
 lv1EedJPUo8MvLH5UWFTWzYleu7uxcEf0HaD6/wpU6f3vmeur6gKqfECYcll5yqJLc29YpVI2wL
 9UhpgDv/aTQT/3hcZkP0CisWGEzFsv7L82QrdjoUT0TtCnwhooEHEuujZvsT/q6a20AXhag3P/U
 rWO8X4B1yww4lK3vYkSmjs076vop3bqZjUhVfPdXNCeds6jN4K9Bp+5RthXCWXsbvsCz+zyT0dn
 HmKZOkIRyY97dmIzN4ORTQ=
X-Received: by 2002:a05:6a00:2da3:b0:845:cdc1:a803 with SMTP id
 d2e1a72fcca58-84fddfe09a8mr5708980b3a.11.1786714075908; 
 Fri, 14 Aug 2026 06:27:55 -0700 (PDT)
Received: from localhost ([219.70.128.183]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d267305sm463541b3a.52.2026.08.14.06.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:27:55 -0700 (PDT)
From: reza.jelveh@gmail.com
X-Google-Original-From: reza.jelveh+git@gmail.com
To: dri-devel@lists.freedesktop.org
Cc: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
 Reza Jelveh <reza.jelveh+git@gmail.com>
Subject: [PATCH] accel/amdxdna: Keep PCI power state in sync with runtime PM
Date: Fri, 14 Aug 2026 21:27:43 +0800
Message-ID: <20260814132744.516105-1-reza.jelveh+git@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

From: Reza Jelveh <reza.jelveh+git@gmail.com>

The platform powers the NPU down as soon as the driver stops its
firmware, but aie2_hw_stop() never recorded that transition. The PCI
core kept tracking the device as D0, so on the next system suspend the
noirq phase attempted a D0-to-D3hot transition on a device whose config
space returns 0xffffffff:

  Unable to change power state from D0 to D3hot, device inaccessible

The platform's power state was then out of sync with the kernel's, the
SMU idle condition was never met, and suspend-to-idle did not reach the
deepest state. On resume, aie2_hw_start() re-enabled the device without
requesting D0 first and failed reading the SMU mailbox (0xffffffff,
-EINVAL), leaving the NPU dead until reboot.

Record D3hot at the end of aie2_hw_stop(), while the device is still
reachable, and request D0 at the beginning of aie2_hw_start(), so the
kernel's PCI power state always matches the platform state. Skip the
firmware stop in aie2_hw_suspend() when runtime PM has already stopped
the device, and demote the "device is already stopped" message to debug
level.

Signed-off-by: Reza Jelveh <reza.jelveh+git@gmail.com>
---
 drivers/accel/amdxdna/aie2_pci.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index a7b923005..ad14e4fc6 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -288,7 +288,7 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 
 	if (ndev->dev_status <= AIE2_DEV_INIT) {
-		XDNA_ERR(xdna, "device is already stopped");
+		XDNA_DBG(xdna, "device is already stopped");
 		return;
 	}
 
@@ -301,6 +301,12 @@ static void aie2_hw_stop(struct amdxdna_dev *xdna)
 	aie2_smu_fini(ndev);
 	aie2_error_async_events_free(ndev);
 	pci_disable_device(pdev);
+	/*
+	 * The platform powers the NPU down once the firmware is stopped.
+	 * Record D3hot while the device is still reachable, so the noirq
+	 * suspend path does not attempt a stale D0 transition.
+	 */
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	ndev->dev_status = AIE2_DEV_INIT;
 }
@@ -318,6 +324,13 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 		return 0;
 	}
 
+	/* The platform powers the device down when the firmware is stopped. */
+	ret = pci_set_power_state(pdev, PCI_D0);
+	if (ret) {
+		XDNA_ERR(xdna, "failed to power up device, ret %d", ret);
+		return ret;
+	}
+
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		XDNA_ERR(xdna, "failed to enable device, ret %d", ret);
@@ -427,12 +440,15 @@ static int aie2_hw_start(struct amdxdna_dev *xdna)
 
 static int aie2_hw_suspend(struct amdxdna_dev *xdna)
 {
+	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
 	struct amdxdna_client *client;
 
 	list_for_each_entry(client, &xdna->client_list, node)
 		aie2_hwctx_suspend(client);
 
-	aie2_hw_stop(xdna);
+	/* Runtime PM may already have stopped the device. */
+	if (ndev->dev_status > AIE2_DEV_INIT)
+		aie2_hw_stop(xdna);
 
 	return 0;
 }
-- 
2.55.0

