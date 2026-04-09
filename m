Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5089E99049
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F6210E8A7;
	Fri, 10 Apr 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLMbyOxD";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7BE10E849
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:21:30 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4832c8f9d87so1845285e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775755289; x=1776360089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VouOEuCnHvjyu2RFuR8oBB76e+Jzifx7Gza9ra+kGWE=;
 b=DLMbyOxD8QPzq1n1V1m+xswI+8ssq69vQWm9zzfrnppoLGs1SsssYU4KD+U3taOz6Y
 pKRoRYcU7IuHK1HwXhlmXelCzSNoTnwZM1hn9lLABous54Lj5nfE9yj7W3+L+/TlMQrJ
 Te4sPw16v1zBMjhnYiCPEhXoObKHeyM9isNfCpeDowHPOdBH7ipliqquT28Dmme10l05
 FSF08K9wdffMAc/mV87IYOy6r+T5CUfNc0h8mT0yRh832AvQPm4YVEI8KTwAV8A+4JHe
 WqKNsL86idm5Oz/OoBDn9vX7bFjcDglT6VaHqiodWmxfUU913Nq9O6Bgb+40kj2EtMLC
 8MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755289; x=1776360089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VouOEuCnHvjyu2RFuR8oBB76e+Jzifx7Gza9ra+kGWE=;
 b=O+1NmUKZHlTvPTRylSFy3qcZ5FMewnUVUbvI23GFfmfOFgYgWyNq0Y/CxJfm0x/4T4
 IVmwh6KB4UosJoZE8cZBpZCtpXnrYG4OxiMeU9QJq4P5BQ7jsQaqcvTMMHoe2XQeH5E7
 9LSIHm7Jg7+OSxl0sOMbWoTWnU+TQ2+tZnjFToGFZPoG4J2m7Ygh6aTYiPFRz7IUzHlC
 kS8/9zWMC2bPSjO+p08TtkBiv12Ech9rQyDaVXVqHzpQNFLPvlSHtuKsBkg36DSac2ff
 QUY6sr3IGSoP/IQtK1Av8VbwHwdD+kCtu3JETd+n3cGriWlJSgihEgHkyrIBg7rM7dMh
 LOvQ==
X-Gm-Message-State: AOJu0Yyh/gfCtscHNab8BVGv+Sf2GqoXI4c24KT/MxSrgvvqu7rBv83G
 NeUo07sYH/jz5A3Wnqe7yuI+eXlIohUiNZq/NXrAg0y4XwydnQP3KdDu
X-Gm-Gg: AeBDieu2bT0DY5fkiTps/83CBE9iPkt2U7R1kt2y6NqiCMWWH5ShtbsGjs6LSOQ0+mT
 MVp/wMJXSZLrrHPNVCgTrCuhoEx1CAEyQmxg+c5xlUIpDsXKZOVKt6s5qrWBX36XNNzuo8Vyf/A
 ccSTck21Tj2NBsN9oEe+V6K8Z0Cm3lI0KTH25rMW3pDF9HIyTLaK+DurXNV6ir/EDFPSrbk8mB7
 CtdriY82VEB2uNJsSEd9QwL+lBljYiDlNi4l3BlAFnYnngfhifmet5SlaVMxJ2icknigeqd/CD0
 JnfHGzmGSHcuhChG1XaDi+UJROJWWRLs/8xD4pXyPdaUu4Zr9+UkFpdbpV6XbG8/jwUe1Cyawwe
 W1N5KPpZGt2DMPScQU9LCL8VRaq5EJwHfYsAxP8b9nNP19pqdwAAqwxxoT4lwJ8phUjBQ8g+XqU
 PS/H3BXGH0O5SujHRCeUu/aRoxq4rW/brBWJvVaEtwemFUoAxwSpZ8fgX0AXmVBXxD+SlzIooLJ
 YGrzho41iNH+oo3XVpuT/CI
X-Received: by 2002:a05:600c:524d:b0:485:c456:5e4f with SMTP id
 5b1f17b1804b1-488c52b42a8mr64500175e9.0.1775755288741; 
 Thu, 09 Apr 2026 10:21:28 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm367345f8f.12.2026.04.09.10.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:21:27 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 0/3] drm/nouveau: stability fixes for NVAC (MCP79/MCP7A)
Date: Thu,  9 Apr 2026 19:21:23 +0200
Message-ID: <20260409172126.115441-1-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi,

this is my first patch series for the kernel. I'm running an Apple Mac
Mini with an NVAC (MCP79) chipset and DisplayPort output, and hit three
separate stability issues with the nouveau driver on kernel 6.18.

The patches are independent but together they bring the NVAC from
"needs NvMSI=0 workaround and can't run Wayland" to fully stable
operation with MSI enabled, working DPMS, and functional Wayland
(tested with Weston).

Patch 1: The MSI re-arm function for G94 uses memory-mapped register
access (nv40), which is unreliable on NVAC — the sister chipset NVAA
already has MSI disabled entirely for this reason. Switching to the
PCI config space method (nv46) fixes sporadic FIFO errors and hangs.

Patch 2: nv50_sor_atomic_disable() dereferences nv_encoder->crtc
unconditionally via container_of(). Under Wayland atomic modesetting,
the CRTC can become NULL between check and commit, causing a kernel
crash. Adding a NULL guard fixes Wayland session teardown.

Patch 3: Transient DisplayPort link glitches on NVAC cause unnecessary
disconnect/reconnect cycles. A single 100ms retry in the HPD IRQ
handler catches these without affecting real unplug detection.

All three patches were tested on the same machine (NVAC 0xac080b1,
DP output) over multiple days with DPMS cycling, VT switching, and
Wayland sessions.

Thanks,
Marek

Marek Czernohous (3):
  drm/nouveau/pci: use nv46 MSI rearm for G94 (NVAC/MCP79)
  drm/nouveau/kms: add NULL check for CRTC in nv50_sor_atomic_disable
  drm/nouveau/dp: retry link check once on HPD IRQ before disconnect

 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 8 +++++++-
 drivers/gpu/drm/nouveau/nouveau_display.c     | 4 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c | 2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.52.0

