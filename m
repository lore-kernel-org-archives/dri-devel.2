Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BA606A332
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UBI5n0bL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EA4F10FF76;
	Wed, 18 Nov 2026 18:59:50 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47110FF76
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:59:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so15637075e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795028382; x=1795633182; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZqKXVZqiOGdZEu0WGQ7on18pEUQ1o2hqL4+MiKX9BY=;
 b=UBI5n0bLkXbFP76OaUgWL/8LcCDJ4JmK/UcMJQD8WAkstZqiAGmruW6HhEdBUrk4d7
 gzKGog+xqLAzBmmfXjhkMzOizu4aPX2l7AqkK50LGrXpDvld6gxdbw4p0hjmXHF+iPnM
 la0aGcR9/FBSC3cWJgLvlq2uI/xytuaHkr7sprwA20axzsPNxEh+1mf5V8jVmWDQ7eQ8
 t3W+n+dOplbS2R/OSpj1W/CM1445KbvW946tZHfNEK4HFUU7cpOoU9btyGN9FjwF8WfF
 M8a3TlMnea+/rQDCVTwNwOZ6GuWno12kJ3QF+QQ59v4zbNLe9vjMZv4Sg0xhMftOR4nd
 p8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028382; x=1795633182;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BZqKXVZqiOGdZEu0WGQ7on18pEUQ1o2hqL4+MiKX9BY=;
 b=lSzUjZQFGULLyGvWYhtw0XwIO3q7hFRB07zLCQJkUkaKWJKm+eR5jL6t1lC8bPqGzQ
 RLF05+RtHBrtZbwGk4q+HgYbOVMaQdruBh4LJoPuCHXZcSCTZJrE5E7KfHu7FlEIZtF9
 R14+RNTgnOycBEtUqs/2INoOd/7ofQ62Lq6ubWBLeVdVZcjx57DREjo5eSr8I0BovpFZ
 0uOf8k2K+Dy5B4FMpyISTXtg2Vu3UNS4NQ+yiIdCP8tql6Y+qJNpTeIXMvG1mLGoNZLP
 4TGr+mHnUW4I1HNMkW4y21TFJH7dLmbHIyjbgrQig50srcZsvpDvJ/JmRIBH84r0IT+Z
 Sp3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHhip5b1P16xJ57KGUeNMkQHTKBvV5lunnmphCuna9lXcq+6nccJ1GBEZcGAr7D9B4G9a5ZDpj1C3o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+yGMjg9PoF6K4M5qtBNjGQx1HOG8jXas//7BFXKL8fHmRYUWYU
 U91YGGYdVSito3vqsQN4iPD5nEBOyrwy9G1xwoGSWi+98tw88dm1SHKb
X-Gm-Gg: AYBFou3sNyx33VRtyU7h5rPcBJCtzJQUiRkWrRuH1JFNNl9DU/yoohBZUEoAPMgzLbD
 xbtrGIFWrLiNj8n16zXRwfnYzCup6Ikn7G5dxVfw7Ifj7x072kPkJbpyv1l5003pgUiCj5/nhCE
 i4xWJD6a7XPKvv1hfZqSSCNC/DB/qhtuIadRLRhKcDulPy2SF4IMWC84loB5/uGd6W6bfX9XX0B
 cLlT3Xt/gq8mvd5PAYrTVb01NeaJu3H0V/d6AJuWBpLxedP4YK3uDjCZUeuWRk8ZUlrVLQsK4in
 KsRVFLfw7y2+ON5Ob802hxVlLcI1r2nZH9Rjbh75TUA2GfS5kRGOxgJZzz3uOVIIgiTfNy6IbMR
 Q9WS9sEMNrP3ULNmWt95WcF015RYbnZDM2dNdG1ag34oM1smg616ecgIC61nDdc7i+aBqPhuNWp
 oyIjyOeMyNNVX+kq+3ATjfR/yuDrD85nkRkR4qcvXByEfAL1JOHlpBP0BUEYgKzo17HhcEB8S+F
 zHJMHENkJVOaJ3vgorqz0wWX18b5MK94m8KySvkbNt5WS6TE/EKOlrHkaf2KJuByZ8DmwryYvFp
 9SC89E9+hYD4tjmdS6ksuKLVqRVmhgDnOE15LVydFLLwv3hpUh8kaaZNwZTsSXB6HQtsqJg=
X-Received: by 2002:a05:600c:46c7:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb7da45409mr75914615e9.21.1795028381836; 
 Wed, 18 Nov 2026 10:59:41 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d4e670dsm95966965e9.1.2026.11.18.10.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 10:59:41 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 18 Nov 2026 19:59:01 +0100
Subject: [PATCH v2] riscv: dts: spacemit: k1: add PowerVR GPU device node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-orangepi-gpu-v2-1-f68676f844eb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMwQrDIBAFfyXsuZZVq7Q95T9KDhKNWWhi0FZag
 v9e462XBzPwZofkIrkE926H6DIlCmsFcepgnM3qHSNbGQQKjRcuWYiH3Yj57c1Q2Ku8Wa1QT1A
 vW3QTfVruMVSeKb1C/LZ65odtIY5c/YcyZ8hQKq2N5nWx94uh53kMCwyllB/fEJ7+qAAAAA==
X-Change-ID: 20260413-orangepi-gpu-02d839d6506f
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add PowerVR Rogue GPU device node for SpacemiT K1 SoC.

The GPU is integrated within the SoC and enabled by default.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Add PowerVR Rogue GPU (BXE-2-32) device tree node for SpacemiT K1 SoC.

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
[3] https://gitlab.freedesktop.org/imagination/linux-firmware/-/blob/powervr/powervr/rogue_36.29.52.182_v1.fw
---
Changes in v2:
- Removed board-specific enablement (GPU now enabled by default in SoC)
- Simplified commit message as per maintainer feedback
- Dropped redundant status = "disabled" from GPU node
- Link to v1: https://lore.kernel.org/r/20261015-orangepi-gpu-v1-0-03566a615660@gmail.com
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 3fabfd34114b..7f2573d869ca 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/spacemit,k1-power.h>
 
 #include "k1-pdma.h"
 
@@ -1119,6 +1120,16 @@ multimedia-bus {
 			#size-cells = <2>;
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x0 0x80000000 0x1 0x00000000 0x3 0x80000000>;
+
+			gpu: gpu@cac00000 {
+				compatible = "spacemit,k1-gpu", "img,img-bxe-2-32", "img,img-rogue";
+				reg = <0x0 0xcac00000 0x0 0x80000>;
+				interrupts = <75>;
+				clocks = <&syscon_apmu CLK_GPU>;
+				clock-names = "core";
+				resets = <&syscon_apmu RESET_GPU>;
+				power-domains = <&syscon_apmu K1_PMDOMAIN_GPU>;
+			};
 		};
 
 		network-bus {

---
base-commit: be95fa81c04dd67616faaa2872babb9ac39d4251
change-id: 20260413-orangepi-gpu-02d839d6506f

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

