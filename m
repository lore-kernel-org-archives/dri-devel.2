Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8DEC88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D477710E8DC;
	Sun, 13 Sep 2026 13:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kPC9A+9U";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB65510E8DC
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:11:26 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8693af0d7c4so1713332b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789305086; x=1789909886; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OvV6HGYmGnPtM6s9K0ynk2MdK/BwOFAfbX5o4RmVGAg=;
 b=kPC9A+9UHQSAEnbCtBIursJwDfiNZd8yZJ/yBJDHSHIKgGXrLa9Ka6siCiObMcv8oF
 gevpKAbPTSFH+I8hOtC3fPvEATJb2b8c7iS/CL2KHp+mi2Uc/8wE8MgjhBSLg4OMdOKA
 +cu3fXTDm8YOdbEC+xbeDca2j4ruSeWENWm3Rsr2Yjjil5z3xjA9K8eltNn8BTqT018E
 YJIb3NjmVxql0ca5wz0tPCpWHNMJr6B+Z7ktrlVjhAbwnyYRKltfnf/fzPq+WDiZbw2X
 3By6NtjXWSUZ4WNNQ4FcxZciI/8sQp3PHRBDCaefYjvtszVUARSSxN+5A7HL+UKgPhRJ
 hChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789305086; x=1789909886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OvV6HGYmGnPtM6s9K0ynk2MdK/BwOFAfbX5o4RmVGAg=;
 b=Df71F9zo+8mul70w+M6u+7Rt3CGHa4DQFTsnck1Jovl9SAIJxcWFGxW5wUINYu/TZA
 8lYD3Sjn031EipiN8xyjO0cAUW9Z2ISau02jOIcljjXHNp1UMixXK/yI3yxiYYv2MXJM
 jdRKtpIFHsvYwldwJfXST4Ue/3Sw/8NsAbBXD6esS/TbxazqvG5ixhZBffE/XcxwcNuP
 N6l/GlAaHgZpjXjxmxB/QkQdidmX3625UnQjqSlFnfG/8mA4h+WfRjYX0SaNJJl5ceNa
 oe9k33HwironHQfZQ/NzT6jVY0uu4YEzW2mxOAgarAI1a1pAi6DWUIhUlYVntzgAPoOz
 zE3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyLVGcal3S6k+Z/+vK2V0VAdOzCGBWv4+AazJvX8NL6pyRuTOyOm4lbrX57aGGQWtJ5mZmIbRKJU0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7V7LsgWhkUzwzqw27LnMYGhvsmb6xurApEgo+UcXF4c1F2fYd
 P9sA2jy3GgPWKzQKRZ3hKwORIzsZ98ElHiqAJ5kJw4nd6qFQN7GFLIz0
X-Gm-Gg: AYBFou2AGV+vrKZfLe/ND9vL8OIKeZElgNSp1FKXh4vAwdRJ78RKJKGXvbxxtPzp8qD
 +5XCTjSHp4zzJC6kNZ1WlmpDZDSzQImbVyMyzajzv7fnrPoZKGJ7SKlhvl3jQOshXFqngP440Bl
 7D+ddsja0lg8NDnNO9yK0Qa8QiS0zOkoy6eJvQ6jD5jlaX04knu7SDr2Ifr+gs6xWiDX9get+cQ
 Ixi5AzUqdHfOYE1BjnDISyQ50pHK47vRfPWLmo3U27UDBKHptnuHtqIEh1HKd+cgAUnir8XtPC2
 WND5PZY0nyJT3Ll5d16ds+I56FMKCXT+vtmZW4sV4E+SRqg+msAesml23SGz9PVeh6K6nq4Dk5W
 86bq/47NPtZQmMCaDb7OWHc2ZfEQ2yXN9A6Q6xC7ZTZG2N1erKjc9WlQaW18yR5CF5MaeVQBShz
 BuOBxLo0jwKv94mvh1smxtoBCuvJvbS+6pOoKUmnw5OKTnI4cs+KsT33nlGhpEAx9Y
X-Received: by 2002:a05:6a00:a254:b0:86a:9ddc:7ee5 with SMTP id
 d2e1a72fcca58-86b30413307mr23451242b3a.2.1789305086376; 
 Sun, 13 Sep 2026 06:11:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86c7b4922b2sm1891882b3a.2.2026.09.13.06.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:11:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lucas Stach <l.stach@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: prg: fix clock cleanup on remove
Date: Sun, 13 Sep 2026 21:11:17 +0800
Message-ID: <20260913131117.1561280-1-lgs201920130244@gmail.com>
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

ipu_prg_probe() enables the IPG and AXI clocks before enabling runtime
PM. The clocks are subsequently controlled by the runtime suspend and
resume callbacks.

However, ipu_prg_remove() only removes the PRG from the global list and
does not disable runtime PM or shut down the clocks when the device is
still runtime active. As a result, removing the driver while the device
is active leaves both clocks enabled.

Disable runtime PM during removal so that pending runtime PM operations
are completed and no new runtime PM callbacks can change the device
state. If the device is still runtime active afterwards, disable the
AXI and IPG clocks explicitly.

Check the runtime PM state before disabling the clocks because the
runtime suspend callback may already have disabled them. This avoids
unbalancing the clock enable counts when removing an already suspended
device.

This issue was found by manual code inspection.

Fixes: ea9c260514c1 ("gpu: ipu-v3: add driver for Prefetch Resolve Gasket")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index d38d3ba54d72..93033e847d0e 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -426,6 +426,13 @@ static void ipu_prg_remove(struct platform_device *pdev)
 	mutex_lock(&ipu_prg_list_mutex);
 	list_del(&prg->list);
 	mutex_unlock(&ipu_prg_list_mutex);
+
+	pm_runtime_disable(&pdev->dev);
+
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
+		clk_disable_unprepare(prg->clk_axi);
+		clk_disable_unprepare(prg->clk_ipg);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.43.0

