Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D92CCA466
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C516611244B;
	Thu, 15 Oct 2026 18:56:40 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7DF6112437
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:56:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4956869750eso37093935e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792090591; x=1792695391; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8DFjBs5Cy+cqLEmVTjSkVi2zwWGVHnAGbcDhQszah4=;
 b=PGxEfjmPStqAmnYA+WWUkIYs0lOKt5yu0nbLTPt1cpvIcJbhM1nT6hp5L9XuRDjFHZ
 rstQfCjELjRmz277Q2HSqdzg2nWdq4tLHzU7fOiPV2nsVVKU9xVedASjllviP9M2Z+E5
 TsZ+y5POVBGshS0N07q0iTwHZe5AUAxsAgy0jKaPABtPvcMlDzbzj4EISrxhhgjfNe6q
 LdgylZScXIXgZg94y5+GLafY+KnqXTN+yFuSq3jpYou+i1BT/Anqo9e7IXoIa4q4PQsh
 6IKq2KWLrKByHRCJYk6+XHRxsMS3pRoq/qKjUE+j84vzDRLc4GC+iANvFeu+wDArhtxA
 8RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792090591; x=1792695391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j8DFjBs5Cy+cqLEmVTjSkVi2zwWGVHnAGbcDhQszah4=;
 b=RqTNTcP6AmzBnS/ski4gLNnPJ9IAD5urXTgW9LGuYiYNQ6RelaNZNKZ8VsWUnn7CD0
 ygv02CAvAIX634IOu2dxtmdpkSeFneSfP9U8RZQR/aBvARGQiVIJVl99+dyH2MSsZJGv
 2HlCBpK6DzBbU3ghX0oGCqLBszk2XBhX8ym7YOBLhMmBA2e60zZVHruObBWpsnBMZrMA
 tieyXptfqB9wSPDcqMhJqeJ1vCDYMnrBc044SlooOyZbcqh6jfPtv+zwiPKYKLFCCkFf
 xIWDf4CQepgBsnoHK+AoC9RT/M5jSm/57oaHiPYgeWOz00GeKQ8s2rfT6redLdvE+vpq
 qYZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+YJSt6JUxbnPpcuQXQRLrrViTjHUEZJXxapMEXkdSEmpe+FDOo2CV8HqgCJnH+5VwloTe5WMYKRs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwyS8MnUjoxUVOYrjNZQ74Pyo2uZnWp9k0rZAXtINw+FxIlvu8
 KX29bAIgzvm+7K1Eooe5ZVJXxEcCGbZ4ZbipBS4mX7UHrBv9uMbDtqXS
X-Gm-Gg: AYBFou15BxyjFF2Pre8UrTaoy7LnRDulnawmmao5aiQPD2Fbwq9F9W4Oj4BchIVwDty
 de53H58FTLfU3U9p/SxessH6r9676KbEZIB/8kwiOpOdOKVDmU5d3ZfZz1QH6GQRKsCEJkFL2wo
 wI5L3BTcWD++zavf65V0Ejs3ISdz4o3RwDLWP72UB0rfqVzYq/FdZQN2lxNAFFjZgG8QM4/iz6t
 V2GbH5oWZxbVizcnLZ9w0uVc6pqB5EQcFZ9BDpI5JxTMJdshJnq8WMFJOKur8whG6+MrLbV3lXO
 wvw8ogvZr7DscNo4HPVsbRa3oHypQZss3d8f4awOHzMELjSwATf8xUJYZaFGsKtAxHlL5HkbxJS
 baZsGxE3gj8gJwEBgumVhlTOHGEnG540FeG7a8zoWjTieS0nYn64P07qw5O0wxbq12uTjNNsLe5
 fp2A5ojEsRlFFF9kNuQZIcumQtvWd7u6yUMLVkwI/5PlSCs8Ylhrqwy5CGTzosTFNYu8MJV5L8c
 BOXWVKhc8FYVmGQMCllyPreAjBjpuv8iEgmZHttdw==
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a18e49d65dmr398603945e9.5.1792090590951; 
 Thu, 15 Oct 2026 11:56:30 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdc036a4sm106148295e9.11.2026.10.15.11.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:56:30 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 15 Oct 2026 20:56:05 +0200
Subject: [PATCH RFC 1/2] riscv: dts: spacemit: k1: add PowerVR GPU device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-orangepi-gpu-v1-1-03566a615660@gmail.com>
References: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
In-Reply-To: <20261015-orangepi-gpu-v1-0-03566a615660@gmail.com>
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

Add device tree node for the Imagination Technologies PowerVR Rogue GPU
(BVNC 36.29.52.182 / BXE-2-32) found in the Spacemit K1 SoC.

The GPU is located at address 0xcac00000 and uses:
- CLK_GPU for core clock from APMU controller
- RESET_GPU for reset control from APMU controller
- K1_PMDOMAIN_GPU for power management from syscon_apmu provider
- IRQ 75 for interrupt handling

Disabled by default; boards enable it individually.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 3fabfd34114b..82cade2f76fe 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/power/spacemit,k1-power.h>
 
 #include "k1-pdma.h"
 
@@ -1119,6 +1120,17 @@ multimedia-bus {
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
+				status = "disabled";
+			};
 		};
 
 		network-bus {

-- 
2.56.0

