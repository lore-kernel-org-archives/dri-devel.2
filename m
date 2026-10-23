Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED39606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d26CcLDT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D1E11298B;
	Fri, 23 Oct 2026 06:40:47 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2EB10E592
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:23 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so268319f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737621; x=1793342421; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJFWHzliBTc3+ANTD4MSj5zAkBWI2RhH31jFlttP6lk=;
 b=d26CcLDTX5zmg3qVl8ca7ugKDM2eoxmSL4wDyj8kcwCT+fRvhG5FoWyNR5+RgRxT0V
 j/OClnLALdpqCYOjfOsgd2WNN+P2XVla4fgzOFIvZwcAY6J1DJvBCp1GLlHjX07z4KsJ
 s8jDKALFSCDeLWvVLPoRmpqSgLXq+eE9xgt06lhKDRfw2v7LfX1UD2dCPmm49rigW913
 f1d7HsrSJCNxnamWAFaQP+Jr0kBju9h+2MdyKIcPP6KLiJ7ebLPLCDXteQg62yNz9T/X
 E16JLT1f4ISBEkniWF98FmfGx450k+7tJ/8qMeg213TZ0XkMIj+LCKOLq3ChKmBp4mdH
 CHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737621; x=1793342421;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZJFWHzliBTc3+ANTD4MSj5zAkBWI2RhH31jFlttP6lk=;
 b=aNHuGz3QubPwf9Nco1xfq+0Fqeg7pKRNCvH8+zPorzjUTET+NCmMEBZhvFg0eCFxEh
 48cuVLvu7lTMViK6g1UV7BzxBKCogVgXGiQYRhH69U0nZsT0elNG5BLzy5RCiCKWdgK0
 C0GeAZvrZHCT4qW+IiUISgKdZGSyqv68PK0YrLU2a94ZSFOkgbMwiyO8kPdJWLlvYij9
 pob2CFmTFK0F84f/2/SiZvf32Erg+4QNkBiW4gedawRKhYJ1qoh1n15qfBYWYd8HXhPH
 BBwjQPyWXn9ZYFFaPCvgwk9ELMNcVu+b7o7z5KAerw+mO8Osf9BpZs+UQ7d3itNRadyY
 pA6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXd+HkjhcuoBOIS+FH0umkMITJMfsXhASH7LGcCemaLI3CrY6M3c4NNjUxClchs2ZVEUdtQb89pLM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9beJeRd0uiiP9e4qkVt/AFN3HtpGJp28pVmYhSRDPuocmn7Lb
 9NYca02v+w90X5H5Lo4tMYwOYJz+1kfj+UhMHAkKFnfMolQ63x1ROoCW
X-Gm-Gg: AYBFou20egwhiUGXcJxTxtEsg47mOFtGyF8DgzTR430/YlaCZabJ21/NqBX4cpVj/jK
 6PkX1vihp1ArgxODyzCH0dCC7SGxbKYg41+oPU+xPKXqIoe8E7YaAae663iKeDU5RlwXHNKbKTh
 kvyxGYbtOIAgZf5ts0SI6aG77QhwG+tzKT+18yyZZxvs2hnD5RkE/M4mXhBgJlgw7IYBucmyU13
 FdTv2YvCarCCiZ7QkgTmIujxBsE+/VWw6GphhLbZi445fCWizGqFXIllE+uyqacHF4tmqVm35nl
 TgNvXRUFdh3Hc+XFHlJBvy0vLhMkT7wMVBQhpAXU+xua5zj3w/t6XuoGEeHwCuwzBfQRdfCNfFQ
 S0v+CEOHo7hX38GLdS3pX1PiySr9cQkxXaSwgVZgvvSVpeRFCTPe68aFGNEO8tvsH8tYjFxWXGU
 FBK53E6uQO9/Oju0fWH/YuCWIdkTBIJS8cL3cEIllp6CJ5NkzZDHApGAhitiSUCV2s7BgHd5MNo
 j/5vbWDUjCDrgtvsjE864vRlbTUm9F2FSc+VpTfzxqcrEDOZnOD4d3XiswD7NbWEqNpVrTta4mB
 GeMOqFObXwLq3GbqrQ5hrycZmHvfPwtodP0pf1G9/aqydOtowA9hNyVQRXch3PQCTA3OAqRIvCw
 BYeE=
X-Received: by 2002:a05:6000:310e:b0:48e:f14:61bd with SMTP id
 ffacd0b85a97d-48e38588967mr1965340f8f.14.1792737621324; 
 Thu, 22 Oct 2026 23:40:21 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:20 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:39 +0200
Subject: [PATCH v3 14/16] arm64: dts: ti: k3-j722s: Add the AUX L2 SRAM and
 DRU regions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-14-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM accel Thames driver maps each core's auxiliary L2 SRAM and the
DRU's channel registers into the Contexts it creates, so the DSP nodes
carry these two regions besides the L2 SRAM, and the bus gains ranges
for them. The auxiliary L2 is 256 KiB of SRAM in a 512 KiB aperture; a
read past it faults, so the reg entry covers the SRAM only.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 16 ++++++++++++----
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      |  4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 5a5b9a1bfd9e..b6c951a1dd74 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -385,10 +385,16 @@ main_r5fss0_core0: r5f@78400000 {
 		};
 	};
 
+	/*
+	 * The auxiliary L2 is 256 KiB of SRAM in a 512 KiB aperture; a read
+	 * past it faults.
+	 */
 	c7x_0: dsp@7e000000 {
 		compatible = "ti,am62a-c7xv-dsp";
-		reg = <0x00 0x7e000000 0x00 0x00200000>;
-		reg-names = "l2sram";
+		reg = <0x00 0x7e000000 0x00 0x00200000>,
+		      <0x00 0x7f000000 0x00 0x00040000>,
+		      <0x00 0x7c460000 0x00 0x00020000>;
+		reg-names = "l2sram", "l2aux", "dru";
 		resets = <&k3_reset 208 1>;
 		firmware-name = "j722s-c71_0-fw";
 		ti,sci = <&dmsc>;
@@ -399,8 +405,10 @@ c7x_0: dsp@7e000000 {
 
 	c7x_1: dsp@7e200000 {
 		compatible = "ti,am62a-c7xv-dsp";
-		reg = <0x00 0x7e200000 0x00 0x00200000>;
-		reg-names = "l2sram";
+		reg = <0x00 0x7e200000 0x00 0x00200000>,
+		      <0x00 0x7f800000 0x00 0x00040000>,
+		      <0x00 0x7d460000 0x00 0x00020000>;
+		reg-names = "l2sram", "l2aux", "dru";
 		resets = <&k3_reset 268 1>;
 		firmware-name = "j722s-c71_1-fw";
 		ti,sci = <&dmsc>;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index ca10c6904b69..6c0d2ee94290 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -185,6 +185,10 @@ cbass_main: bus@f0000 {
 			 <0x00 0x78500000 0x00 0x78500000 0x00 0x00008000>, /* MAIN R5FSS0 BTCM */
 			 <0x00 0x7e000000 0x00 0x7e000000 0x00 0x00200000>, /* C7X_0 L2SRAM */
 			 <0x00 0x7e200000 0x00 0x7e200000 0x00 0x00200000>, /* C7X_1 L2SRAM */
+			 <0x00 0x7f000000 0x00 0x7f000000 0x00 0x00080000>, /* C7X_0 L2 aux */
+			 <0x00 0x7f800000 0x00 0x7f800000 0x00 0x00080000>, /* C7X_1 L2 aux */
+			 <0x00 0x7c460000 0x00 0x7c460000 0x00 0x00020000>, /* C7X_0 DRU */
+			 <0x00 0x7d460000 0x00 0x7d460000 0x00 0x00020000>, /* C7X_1 DRU */
 			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
 			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
 			 <0x06 0x00000000 0x06 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */

-- 
2.54.0

