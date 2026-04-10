Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B43E99048
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:07:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB5510E8A8;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fozFd+2E";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2622010E896
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:15:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4830b67aa6bso2433715e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775801754; x=1776406554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uSjn24L98hphx3W4Kt1Sy+XjH05WXGXcx5CVk5R26MI=;
 b=fozFd+2E440odaZC8PGgR90MUnHjGZrXc1cs82YEnbTaDJ/ewfvWdxkqlAi+w7tdI5
 SmrTII2ed4FY8bUa0vqO/WZmXNSlZGSZ05t2aOyXQJwU3Tv94v5FNUWfsVir4TF2WsN2
 X6RDX7TnLXRi05ZBWe1XUinDMhSgP+uWikNzQ/RqhJ0IIa2NyEO/RGiayX+Y9E0YV+iU
 75OYDSnttx8txK8u3hRGw7Fc0luvW3qecSQZo+OeKuBu/eNZR3Dr+i1GzsNTx+61AFuB
 DMeus2uqRAm2eWRlUQ7FsxK52+lN69+Nw61DQTfzm2XF9+RqhE5DQDGNn5mlJ0HxqlX3
 2G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775801754; x=1776406554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSjn24L98hphx3W4Kt1Sy+XjH05WXGXcx5CVk5R26MI=;
 b=c7rPRPCOzsqcZVnEiQebefL0dEsCAolryZECWlBNzH1UAYBpSctWOoN77YmVubgcjy
 qKb8AUgwVNGql/a1nEUhx0cTfIZ5F0yCU5JwwSxw2eI12wRnX5ANciTxIW8d1ju+A1Ji
 /kdR3gIMRqk+cihHBm/s9uoXzLi8L3yimYRwJE744xAKleHfDSZ3Fcp4epMnZ+BYVGx8
 ovmh8eZuipOtNixMMoxAEvISZ/DOKjWtGsMzJ4mKFBP8DIOyFg8twToCtjjIyqmLOw/U
 3Ddjmup14j8HDeZMA62iFIM05yAzKi4s7s4SEI3aLEqjRErdSG1QyG5yax4RN80sBVYN
 jP0Q==
X-Gm-Message-State: AOJu0YxnRX3Ml62ffRHImkCzPTEOxcFlKUQai0n/d6L5XI0O4bI/AATm
 AwntBPGBmlfMSPlblHOU2C+WLPy3EWarezpJlbiEWxsL4BCT2Sodv+/V
X-Gm-Gg: AeBDiesG2xes0KTDh8uFRgTzNd7/kkBtJJzS7BkQJU0ta21PlMhCcxeC0RWhv12RjIX
 ZeokoL6VSstyu/cuiiKpt/Vd+HcztOrWSuiojImBTNHZsCJat6hjum9VuiswCUQ2Rw8TJTZDEjZ
 WVyWKL4+D7o2w3P2O+1Bav74//Ylzx4K13BCBgmxMo8eBGL8x62fTvFWLZ2mptGO4KHTtKlifBQ
 W9CFnXdHH2QdIMRMuJB0dCiMLzx91yZDoMknpZEZJKSyN4WtnAVxID6Cp7mePQDL99sg+6akgfE
 PBvV7Uo0llcCCJtg0CbiACzy2jRRB/ezOTueW36kDRwY2JcinXPffjXizOXQkOUDY6dezbn0bX0
 NHvOV4NFS8SLLpA36F15bx32boX60ukh5ldCMI0BA6ELNkzLNwcTWeXRlaOKOMuiKuP2DZE8l09
 2hA7iXvi7TapLPExhO1rHwfLDoNvpksxbGHuA6cBksJRy2aBP75dDWaTDUIdhoWFtRq8C/7htRG
 mQ2aR3SF4p8qg==
X-Received: by 2002:a05:600c:b85:b0:486:fb8a:fed with SMTP id
 5b1f17b1804b1-488d68a0975mr10827815e9.8.1775801754397; 
 Thu, 09 Apr 2026 23:15:54 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm55473955e9.3.2026.04.09.23.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 23:15:53 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 1/3] drm/nouveau/pci: use nv46 MSI rearm for G94 (NVAC/MCP79)
Date: Fri, 10 Apr 2026 08:15:50 +0200
Message-ID: <20260410061552.19056-1-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

The G94 PCI function uses nv40_pci_msi_rearm(), which re-arms MSI
interrupts via memory-mapped register access. On NVAC (MCP79/MCP7A)
chipsets this method is unreliable, causing sporadic FIFO errors and
GPU hangs.

The closely related NVAA (MCP77/MCP73) chipset has MSI disabled
entirely in the driver (.msi_rearm is not set), with a comment marking
it as "reported broken". NVAC shares the same integrated GPU
architecture (both are NV50/Tesla family, memory-mapped through the
host bridge) but was not given the same treatment.

Switch to nv46_pci_msi_rearm(), which re-arms MSI via direct PCI
config space access (pci_write_config_byte at offset 0x68). This
method bypasses the memory-mapped register path that is problematic on
these integrated chipsets.

Tested on Apple Mac Mini (MCP79, NVAC 0xac080b1) with DisplayPort
output. System is stable with MSI enabled (no NvMSI=0 workaround
needed), zero FIFO errors observed over extended operation including
DPMS cycles.

Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c
index df745d069..9dc28a4bc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c
@@ -28,7 +28,7 @@ g94_pci_func = {
 	.cfg = { .addr = 0x088000, .size = 0x1000 },
 
 	.init = g84_pci_init,
-	.msi_rearm = nv40_pci_msi_rearm,
+	.msi_rearm = nv46_pci_msi_rearm,
 
 	.pcie.init = g84_pcie_init,
 	.pcie.set_link = g84_pcie_set_link,
-- 
2.52.0

