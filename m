Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D0ECCA469
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB32112425;
	Thu, 15 Oct 2026 18:56:46 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B273112425
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:56:37 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso23173005e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792090596; x=1792695396; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ni61b90g9iD83/OZasQVP93JejUptEHkbkJ81F72Nc=;
 b=FHL30l3f1Selv5zwS/ibnC/xzElZ8R0tbjfvCBRNtijL4CRphLy4EXC+mYkoFeBg2+
 JueeS7RhEWsAK18X2TpVGbIzeh3BvjCCE0P10O6L3tL4o4t9nIbluAEw/sJbc2S4GuRb
 I+/aTmQS2JVBWodUJVxz3UgjBj2JWKnUJb/xBCBD6m5Y/L5LrOXQjlZIDAdePO7/fvLy
 //WtyxukMj2VRERWZ4YHgduDSDg8fr840EPfItt+2ucQTECiyPQ3BHTbREPD7uLpowTK
 kNG7ZK82lGtcO/vU+zn8dBxrQBy9QM7M5VWPk+UeBSe0yvgF2SnE+pTJQsxdlfoU2KUR
 p3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792090596; x=1792695396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ni61b90g9iD83/OZasQVP93JejUptEHkbkJ81F72Nc=;
 b=xisqypDtt5tvDQbRm0scwgrRDkqjCcgPniz0ni1qOiG4YDD13zImpAYEJgVEK/CCxm
 iEp51n3+N9XZgaDUfsR/FWnvpsidS4FTJ30UUnIadhXWnDlLag1j/E4WSibWP1F9sSrS
 5NW5q85NN3wFT+KqjnhLpETlVh0VfcT4NKrCtzPZf0MntOFh5qfKiFiPeK7dPjDzhEU5
 VGSCz+tur89AXTJG9USCpU4f/i0gZOc9SevGFmgIOeeJWhuYrucdBnSirV9Ma+cd7pFq
 Bol3DZbJdEPqxnG8Mf+wUyLLXuy51ec5UXeeNStGAWGnE5iNIWLAwvLKI0cX6oAA8RNW
 LxCg==
X-Forwarded-Encrypted: i=1;
 AKwUvByH/iPDKQP6USVnZo85Tfl/8dV3P3TZsuCCnKR7he9idD2GjjeQYj2crwcLm3D40SzKuvkGfWTqOI0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKEZ83N7aZZMM3eehrJOWevIdL5N2llfDIR8NaLQy5JDYGrj2Rk
 NY1KSWgp6H23Rk2LRyLRZKTwRvZRto1elqJawuFgVI/yfSbgvmlGouyB
X-Gm-Gg: AYBFou18K8ygMGv870bYF4UZeT7uyAbup1+M8NGQrEqnbmlmzG4Q4O4EwA3RhWbifUT
 qoME2oGBx7pnUDtDEyQbQQb2aRNK/P/fEmvaaUoFnY+mkBk7WXfqk5ypZd7ykMt5Fs/WHE7nuI2
 YYMV4zIe3QUGQx+PCBpBSNuUhp0+yUkeotJlN3/UfnrEaDENE5tPiMI/Gjh9ZoMalL3W29MU53d
 puhp0Nb/uwwfzB9paCxOT2SOOpWw4Gjm9XC4ZCaXnHMw5UbSkQrtR4MIywNzba52/9RjBtHiWax
 jw6HFwanisc9tco6ooOI5R0KsXPCylNToT+uUbBFIed5DbfHs7XRkeQaodEvFCbFGXj25QQtP9Q
 WP+1hMCfup7GkuSCB5uWFcRXjXFMG8NqTbLNHEPNFk+53/lMLd38Dcf5oa4FuB+OLJZmnHFZGFd
 nF5EsR2HBg085ma/gpXTmzy6UchNOsmREEG7jZRIKopb9jH/7fJQHWaKHpoly2Yjr79WsYsn0AA
 hCnbMGgLmOoSgiEQnyZQsd4/bU2oPIleEFssxudQg==
X-Received: by 2002:a05:600c:3f16:b0:4a0:2150:55fb with SMTP id
 5b1f17b1804b1-4a18e44395bmr399234465e9.4.1792090595555; 
 Thu, 15 Oct 2026 11:56:35 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdc036a4sm106148295e9.11.2026.10.15.11.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:56:32 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 15 Oct 2026 20:56:06 +0200
Subject: [PATCH RFC 2/2] riscv: dts: spacemit: k1-orangepi-rv2: enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-orangepi-gpu-v1-2-03566a615660@gmail.com>
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

Enable the PowerVR Rogue GPU on the OrangePi RV2 board by setting the
GPU device node status to "okay".

The GPU will use the clock, reset, and power management resources
defined in the k1.dtsi SoC device tree.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index b907a1396b21..cc375dd1a77d 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -384,3 +384,7 @@ &sdhci0 {
 	sd-uhs-sdr104;
 	status = "okay";
 };
+
+&gpu {
+	status = "okay";
+};

-- 
2.56.0

