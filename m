Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14838C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607C410E830;
	Mon, 29 Jun 2026 11:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/hT9soz";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6284810E092
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:21:41 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5aeb2df5cc1so984464e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782728499; x=1783333299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+caonJAAiE2inmJFUDedx+R6t5Q7baaAhhwhNNIaaPg=;
 b=C/hT9sozPt9U+vnV9AbJO0T+GJUGHteFfXRA2SfNNf1V4cmVaRDA8cMWkOLxAzJXr+
 imgTwFlHEUN9ivrAjwzF/72Y37FnyvubrqcU17Do5qmqwHVF0v0W72mFNpwPUrHM0CNW
 oB4I7MgR10q/OL4/vxJW/JJvNTS1FO9xtDLexRuZLWDFbuxr5uXiXWHMd4pGHUx0Lj4Q
 4CoavWLI5AuD+//ZC2E3/xvd5XJSTU5ojcmvJelRnn/1fLsbDjEywrAITTyiZJICV/3U
 auJ+qTrjyoMkJftaIC/MiaFH2Soh/9hwO6R3zwuS5ebbMpUxtnv3n3Uix82S0tydxouI
 WhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782728499; x=1783333299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+caonJAAiE2inmJFUDedx+R6t5Q7baaAhhwhNNIaaPg=;
 b=BtRUFvTnQI4CsrVzN9zVJphaMY46P/EANtqKSXd9+CZR82NPcrpmeofgGl+s5+PSiK
 KQiEqMjZf1OF9Pc6v6TE3AnPY5H/OCnHfQIMNPpYFHU9KtIFcBZUtMqOrM5rRZZdas+6
 4uvLHf1N07zMwm93pM4TpvrjJenbwevk3kjHPoGP2FIs0gNAcrS9cvjsPrn+KT3le4Ym
 PXroKtZbi6qE6XKTia4WIhgs9CZ7qlGrp2ieNFbKkVeNG17GM9WiPoxOc/sji5WkRxZT
 cNYLYLfiBDleem9BB/v9Tj7KZB/T+0Qx/ycUTHLjsxiPewVOs1QKkJ4utJYRndtgIYjf
 VYAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpydd056cH46VL9dnQ2WrT6EUNW8kcOvZLa/kuCHjQ+P09gkU+E/iDT/hYSyel7PmvxHEaLHL/BJxI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTiyv3cjwbixMWrBJFYhAKhvL0U68LhfWhbpOJy42sPlxeOPvY
 g7ZKmxurnf6uHTso9fn0D3CGuowjPyU5HbFsoK8aF1szusb1dPbLwiVR
X-Gm-Gg: AfdE7clzzWrKVIgQKU+DL9KhZhrurbEI9Xe9F9lTaNLAMYVxv27v0t3io+ojlU0fkPq
 6jFd9e37OvfDbp7AcYI6nR3cYrG0EbXCAUPhGeHNrZhQJK28VGvretFlzQc1MScDw8Gdtlx9ICy
 Cuxm9Ofw03zdHgmPA5KWbgEC/LDXC7WXAhOgQiVYJMFI0gz87cpKmw+rI4aNRwN+MlWwSvORIL9
 +2b5YC7ibib6HS9qvC6+SDWZRuW6au2zUTygQHelBiiXNFOTEOTf4tNGkZKoUlj83QqunxY77iL
 IPB0sX7NC95cdmf6kqAec6/N6tM7o8B0GnVpK+ImyHpjohcv+BqbPjhbrDzePp/IJDo4PrXkqFG
 t/4fWnRfmKuTZRoDfJre+jNSmxkPRRKgrPm0jxobLR/VXQLrkwg+D5JSs8yAdaN4t/KU0bdnD7M
 3dm7vAaAZuFjtOKEcrKPmTKGY80nrWsw==
X-Received: by 2002:a05:6512:350d:b0:5ae:bae2:f0df with SMTP id
 2adb3069b0e04-5aebae2f1e2mr427697e87.10.1782728498823; 
 Mon, 29 Jun 2026 03:21:38 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aea2cffc04sm3560539e87.17.2026.06.29.03.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:21:37 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
 David Airlie <airlied@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12] agp/amd64: Fix broken error
 propagation in agp_amd64_probe()
Date: Mon, 29 Jun 2026 13:21:23 +0300
Message-ID: <20260629102124.252403-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 11:23:45 +0000
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

commit b08472db93b1ccff84a7adec5779d47f0e9d3a30 upstream.

A NULL pointer dereference was observed in the AMD64 AGP driver when
running in a virtualized environment (e.g. qemu/kvm) without a physical
AMD northbridge. The crash occurs in amd64_fetch_size() when attempting
to dereference the pointer returned by node_to_amd_nb(0).

The root cause of this crash is broken error propagation in
agp_amd64_probe(): When no AMD northbridges are found, cache_nbs()
correctly returns -ENODEV. However, the probe function erroneously
checks the return value against exactly -1, rather than < 0.

As a result, the hardware absence error is masked, allowing the driver
to improperly proceed with initialization. It eventually calls
agp_add_bridge(), which invokes amd64_fetch_size(). Since the hardware
does not exist, node_to_amd_nb(0) returns NULL, leading to a General
Protection Fault (GPF) when accessing its ->misc member.

Fix the issue by correcting the error check in agp_amd64_probe() to
abort properly when cache_nbs() returns any negative error code. This
prevents the driver from erroneously proceeding without hardware, thereby
avoiding the subsequent NULL pointer dereference at its source.

Fixes: a32073bffc65 ("[PATCH] x86_64: Clean and enhance up K8 northbridge access code")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.18+
Link: https://patch.msgid.link/20260504074823.99377-1-w15303746062@163.com
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 8e41731d3642..c9d7cefa5192 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -546,7 +546,7 @@ static int agp_amd64_probe(struct pci_dev *pdev,
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev, bridge->capndx+PCI_AGP_STATUS, &bridge->mode);
 
-	if (cache_nbs(pdev, cap_ptr) == -1) {
+	if (cache_nbs(pdev, cap_ptr) < 0) {
 		agp_put_bridge(bridge);
 		return -ENODEV;
 	}
-- 
2.43.0

