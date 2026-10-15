Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D87ACCA466
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49F7112443;
	Thu, 15 Oct 2026 18:56:37 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDED112425
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:56:31 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso27495515e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792090589; x=1792695389; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WFz+OPWq9luKuBDqe0uuJVjFv3DbmqRC69UJmoS/3w4=;
 b=ddMgjg5tLxqJr+TmmIGrCGwCQtUIE2DDPr7S+riPHzy1093A4ZfZdVVBc/Hf5nwgZ+
 gXt6CT273cT8Wv93bJ0K/O3K19rQz7LI2JuyOcegFeErmT+aTE8YiK6f7AeQo9UGG5Fb
 cbdrD8+LnFXB4MfRaEhoqdWjMm3KrSm05KyhyL0OSq0g//u70/meRxct16ApX4+YfscO
 emu8e6WHpsHOQ9qSBpP3OTSc8cwPRJ9sYunO43gpap/Em+bDbbdYgxtMnIDoJmeghnNK
 IN9IIRYo5pl6fLcCubQejhjijXjyGL7r0Nd4b4b25+xHmbz657wb+61tuRLNtneivij4
 96RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792090589; x=1792695389;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WFz+OPWq9luKuBDqe0uuJVjFv3DbmqRC69UJmoS/3w4=;
 b=UnX/l0izPNv0MFGo/jydejDn0AWKsCr08u6h382AJghaL3YwPTptFSGGnPvGiz8SJT
 w3djXHgE3dEV2JvgRlPOWsAY5sUoPvMnWWGzdNpUrsfpdZqVz8MoBiMy0Yeib0/8VnMY
 G68uOBWX8Xb6C3v8tQQmEUQE7b/A1eMEr7rpXC55m/JXE2kAa+jo9PAmNp8YCEV0ADI7
 2JqJn5DiS2XWL80Zzuf+cua0MEUToPT9m/mG1UoNtoL+c6w6K7VJ2z6S06izerPYGP8N
 eRnSMqYgkJatb66jRPuhdx+s3cMQmNNpd3dxa4BzOoxq4hH4FldzgNnlsjJPMvy0tShx
 0QmA==
X-Forwarded-Encrypted: i=1;
 AKwUvByr8ywsc3n+mVwUkNJ30upJo/GwFPU/GB59rQUQ5kwAAlGa4wztg6l8mjJ1jrnP+0e2yR7Hsdmtu4Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJFbDCgcbWQaRytGBBi2kRxZtidvGEzL9bJTttso08mkBZI4ubO
 qkTnsvuhlqlIQdXxj1R4Qio7/d1/ukCohQUsg4XzV0hbWq43Y+5BlshA
X-Gm-Gg: AYBFou1vkgRzy/oETvq4BrQuqa72VAqqV1HtaMi4sf4EZQjIKB74ScEYRNKf7Ith/Jn
 5Va9FNhbtntS0kMNv/KMNTp9do+X1QHui26efcurIG3RhtFGscoRMBN4tRDlBPspb8doUe5xCwH
 NYAbp8OZ9ynbVIn9KRenuclxLeiM2kSXwpF2dUBY/GjZOqQhtk4oWwZRVjLpElkAL6Aw8ve6V3N
 Q49FoqCjU8EnYcHj3UMaibMlgKiLQk7eM0mx2fZZ4CK54nNOZioVCfysW/dgIxe60fpyz5YCXfo
 y4FaKFNQeLUon21Q3qHd6DAD1lBdTYEvEiAZ32qKkDxCb5Mj4g08cbp9O18rDxHBS78pod2U1dm
 rO0Jm9GCufSDpK2uzGnUZwg7drRtFy2iXr4t9d1VpCfSviiBPfYudHrVyjMZZSIE54zWMQg8Dk4
 os6JIR6irM+Upe6EUZBcgwzKJmmG3sgetlzQg0hip9LkKjJER4wxPAc5+UKBuw49oYRmkcFv6bO
 zuB7/lXeBzSIhZAVIqM1fS1uL5veqn0EQrlhAeFnA==
X-Received: by 2002:a05:600c:3144:b0:4a0:2423:946 with SMTP id
 5b1f17b1804b1-4a18e48d362mr400641705e9.15.1792090589045; 
 Thu, 15 Oct 2026 11:56:29 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdc036a4sm106148295e9.11.2026.10.15.11.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:56:28 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH RFC 0/2] riscv: dts: spacemit: Enable PowerVR GPU on
 OrangePi RV2
Date: Thu, 15 Oct 2026 20:56:04 +0200
Message-Id: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nj3fwikGhBpm56QamugVGKhbFlipmpgVmaElBLQVFqWmYF2LhopSA
 3Z6XY2loAe3MpI2MAAAA=
X-Change-ID: 20260413-orangepi-gpu-02d839d6506f
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
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

Enable the Imagination PowerVR Rogue GPU (BXE-2-32) on the SpacemiT K1
SoC for the OrangePi RV2 board.

This series depends on:
- Yixun Lan's power domain series [1], which provides the genpd-based
  GPU power domain driver required for proper power sequencing.
- Baihui Liang's dt-bindings patch [2], which adds the spacemit,k1-gpu
  compatible string to the img,powervr-rogue binding.

The GPU firmware is not yet available upstream. A copy can be found
at [3].

With this series applied on top of [1] and [2], the full GPU bring-up
path works end-to-end on hardware:
- Power domain: GPU power island on/off via APMU
- Clock: GPU clock enabled/gated through CCU
- Reset: GPU reset line deasserted
- Firmware: PowerVR RISC-V firmware loads and signals ready
- DMA: dma-ranges correctly maps CPU-to-GPU physical addresses
- DRM: kernel exposes /dev/dri/card0 and /dev/dri/renderD128
- IRQ: GPU interrupt registered, firmware watchdog running

Userspace rendering requires Mesa's PowerVR Vulkan driver
(imagination-experimental).

[1] https://lore.kernel.org/linux-riscv/20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org/
[2] https://lore.kernel.org/linux-riscv/20261015-spacemit-gpu-binding-v1-1-a7a23c7e7788@linux.spacemit.com/
[2] https://gitlab.freedesktop.org/imagination/linux-firmware/-/blob/powervr/powervr/rogue_36.29.52.182_v1.fw

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Iker Pedrosa (2):
      riscv: dts: spacemit: k1: add PowerVR GPU device node
      riscv: dts: spacemit: k1-orangepi-rv2: enable GPU

 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts |  4 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi             | 12 ++++++++++++
 2 files changed, 16 insertions(+)
---
base-commit: 7e986b457d43edf8dd3eb3f6c34e55e92cd545f3
change-id: 20260413-orangepi-gpu-02d839d6506f

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

