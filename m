Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DB3E99040
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2838210E89B;
	Fri, 10 Apr 2026 07:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mZK81Ln6";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B436510E04B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:21:31 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488ac04e13dso1589425e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775755290; x=1776360090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSjn24L98hphx3W4Kt1Sy+XjH05WXGXcx5CVk5R26MI=;
 b=mZK81Ln6CIbe8BmnKqEELdlJ3eVdLSOP112imfj8+Gd6E8b0cnSSfnlg5kd9BpI+KU
 Vmv0svjhsdgZay9bjNtMxyZtjTP0m7jEgjrUojcJtz2g6zEPV3xpKbtfZX+PfczyTDym
 gW+9Jpz1sxYOhh0bypsMM+8iOfImN9vMeQDz9+QeVVWd7+49UacJgtIr7QmzCtkVT06J
 vGLSNnumOJagp8TSD6tHcfygUmayGp9PFCxupnuMk2LAdPaP+LKXc9p/8eEuxGPcMwt1
 iwoaiVUU6cilWUeiukvJGbdIebothvuYQLa3788gYygBkQVPZ2VT9rGfctVZGUUpxOS6
 mxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755290; x=1776360090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uSjn24L98hphx3W4Kt1Sy+XjH05WXGXcx5CVk5R26MI=;
 b=iwdFEohcqO+df8GVmvZUUF6v6PuT96oQ2rRKJQQj+m/KPehNjgO68VAHj2fhUJhcJh
 2CFO8u2pLyJb9RE6ROEwKmzfh3JAxR7hsj6WID1DK4mX/XaJtwTYzQyyD8N9eRbBanUG
 FNuQ+ZROFQLMaIrEOQIYvcJJi9C/e+sGXha7Akm+rjFsFbjH5cZ9aNi7dShfKMTGkqGs
 mPqm308mnAHimPE8XAVksEVZTZ6iAwNjLciV++0m5su0HJX/lKfh1qAMuFpsZfbmarBM
 7tifnxJixV+fnrgTkJBnSiks0IMyuSbNvlnN9gzTEAe9sJrHoaivr80EQfreLzOPxXVt
 6M2A==
X-Gm-Message-State: AOJu0Yz2B/lFMQw2b2sZyMG4XZu9ZCk47G5cK1m2okMKEDMOu6/tXrPm
 7m0x0AnM9NNGc5+piaZmQjAk0X7Ai6IG9BudMdPcIVed+PIoxF3K421m
X-Gm-Gg: AeBDievc4F9IL8X7ngKngv7Sq7dJQlpj1w6+US57XWb+BIRvHfRsizHRx+PpOGxM87N
 hhND1AMN2n2Ls3LytCbScS96gVtg4F4NYGIb1JH5MPubU5uqgbNw/5iOL2QF/DgfXFTFXbjju5u
 zhNuE7K8+r22jvWI64qMQq3f0jDGkViEZoeddSOcTquOnytJnc3j5ShruXRDQAX/lYXQO2e2Jyn
 jNmKWbrtzRQ5a6qfA0fwO7H8cvstD/H503ucojawwrbVgKAq0blQg3rN9ICEToyEy8e01+bcUS1
 ILK6nMEq122YgZ8hmCENoze4ygn3rxBwl9oRgzJQIV0dVa6Cdu6RG24lRpOSWicRfYwzfURUF4t
 ChuYB2AQFGpUUXu3eOkj5+A3xamhsy05NlfKzjdY2L/vs8/5ueGlSd+PJrSg2dpxeN8Y8fjzLj5
 UYTXCPf8FJ/vGJ9YPRn3JDU7aSJocJHk2XAEbjFb2pSRxIAWbyw8U7qWBZnuSSwTdE2N28JqPex
 XuEeriI0n9afA==
X-Received: by 2002:a05:600c:4447:b0:486:f634:f2e with SMTP id
 5b1f17b1804b1-48899785fb2mr220242965e9.4.1775755290042; 
 Thu, 09 Apr 2026 10:21:30 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm367345f8f.12.2026.04.09.10.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:21:29 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 1/3] drm/nouveau/pci: use nv46 MSI rearm for G94 (NVAC/MCP79)
Date: Thu,  9 Apr 2026 19:21:24 +0200
Message-ID: <20260409172126.115441-2-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409172126.115441-1-marek@czernohous.de>
References: <20260409172126.115441-1-marek@czernohous.de>
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

