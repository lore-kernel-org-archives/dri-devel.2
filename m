Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE324CA6006
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 20:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2127B10F3CA;
	Tue,  6 Oct 2026 20:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="aOE7rXgB";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FEBC10F3C0
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 20:25:48 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-6e560e00a86so634213eaf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791318348; x=1791923148;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d7tY7hVtYcSGrMabWy9Irpy+9KqMZ8OzQ5ThjhxFTYM=;
 b=aOE7rXgB2br2OoW5ElmQqCK/MIDI/hJpXz2l6eFtrsM/HoK7H7YLeyIPLtTQoqnnA9
 Mp/cn4whcC8wJYhVM61fZOHejlqKt9bEjGQ07soQ8vxogs2uumJSj8s1HUx0/BkkEPH3
 kvxF6gGEJE8d70clvNv/oM6mOmqKjImg2vGn4DYuI7xlVgPBDCV9bW9AbJbSG1lVGhtD
 i0P2MUJtL3KE99GZMop+Fr0OEHhLPz5Bagld0HF9E9omCHSKZ6YpVMwE8cl0a+IUp2cu
 L1/SZreNR60cEqfeB+7NCjB6KLxKIgZFtKV20hmeiHXrg/BqpUIVGIh8WdnoSUyG9/2r
 V33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791318348; x=1791923148;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d7tY7hVtYcSGrMabWy9Irpy+9KqMZ8OzQ5ThjhxFTYM=;
 b=Oz4/Uo1ad/7W3Ep1LgDoP8U57ewHX+S0/jreCg+iv+aSuFEB9XWNJXJac3izCcNl7q
 bgTu7xum3qv8E6+JZNt6rxvvZnGhBl4LZM7Szly5yoS26TZcsXWw8vXnJ7DQxZudb8jD
 8s+zRvGPZbp63mMa/s+ZsAYDP5HV5Lw0mU/EIPO0FXr631ICqqmI83BMbOpYofQ/mpYt
 iDvpavI3thH2SK7BjEPIRPTbRrQCcuB0OS2S08VZS1vkSwdg1/Ogi2ABUIOu44TkCdwO
 D8+Ch7BQ+ao+c9tJpWCSgxONf6gv4iYvgODJhL22BvoBatp2ezNmoASuCxGwO4lPJEbv
 vg9A==
X-Gm-Message-State: AFuF++kF79i1kqse83dzwnTCgAH657OuBTN0BRJ5c+2cMyxG4hblTPk4
 9TRqwZuyy30DVU0qcdaF4mVq2EWAjaaf6FhYbUWWrxo9Rn542SBRUMDFQWuBMLFzey0=
X-Gm-Gg: AYBFou3lDoH7afxP1WmeV1VWbIF5dSaEasQ/XCl+PEL2ntC6B9J8MTpHcE53+5v3bc7
 8fGUMEuqv3QhuYoN1w1IvExZOHndh3tOro7Mo095LoVoPTwswZ1dfLe8zpeMBSOyzcTXmOQW9tu
 kQp8+RtufEuk2RwkgWlg/JXDiBwq938TA6Lg5XueSmVYQDc01bgeIo2vllRtpWDX1K8IkI2Lh++
 aCRFbE4mdkK7XvDV/R4sLkNv7qs4Lzs05+LQyQUz0PW8n0BFVlItzFCZgd+XgjbVnqhkCPMVCja
 wkZxpaJBeb74yN56YvBwF2hVZI7hJaDnqHFWNJzrKRCKXdn2ruwP/HJjz+JOPeuke6W+x91Xsm6
 B80BY8vcHE07xU99wFsD6X5hFBv+7e8M56ZS49gb+dYDP6IqfG4Hn271uNQh2WFtxYN9qnxP0Bj
 lDQxGUJnbAjTwUrrGOfUvt/3ZdLPlTRM3xLuAjJ0dfbgOhmrLmF583SbZ7NF+YuswEohineCZ2z
 g==
X-Received: by 2002:a05:6820:a28f:20b0:6da:82a6:3a13 with SMTP id
 006d021491bc7-6e7a7c16529mr202545eaf.28.1791318347829; 
 Tue, 06 Oct 2026 13:25:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793f68bf6sm463442eaf.8.2026.10.06.13.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:25:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 15:25:03 -0500
Subject: [PATCH 3/4] arm64: dts: mediatek: mt8390-genio-common: add the
 panel vddp-supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-panel-himax-hx8279-vddp-v1-3-50d884b42aae@baylibre.com>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=eCeuXuHqvmP/UFOQEKWmqU216/ZSkndN2WvM0HwWpA4=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqxVkzFqTYwMskBqktBAGaQIkw6mYPOB0k1bRHJ
 +8urKmt18yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVZMwAKCRDCzCAB/wGP
 wI7sB/0QM+uNZLoX1Jp8NLb2nJn7ClzLVCDOZXUqzT1od9Q9IR+Mai0hZvJJPbZyLWuWg+QKTGS
 NYg/wSz3bQw/6axBFVzO78Kh1bFlH+KP3j23zjsC9zt961U7k9ASdv0XJvU5UxSFoRHafe288eh
 yn68IMEfzt9Vm2sisR7roDYZpx6Aky7yIseJ/bRXhrXBhTQK+GY0OsZJnJUYrkmA08FBm58ZpFn
 lEEDS9l/yFPMFVQbVyrf1uNSe7s5UopCm0G94dDiFSohYZCxVZaohT81NiK3hOyVB9/fldAJvue
 uJUY7G7Yg3bPSW5541+85rKJzL/TEonFNaAps1j54drOKSST
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the vddp-supply of the Startek KD070FHFID078 panel, now required by
the himax,hx8279 binding.

On the Genio 510 and 700 EVKs, the panel's VDDP input is on the always-on
vsys_lcm1 rail, the regulator that vdd-supply already points at.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index 669eaec662f3..449af8014769 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -324,6 +324,7 @@ panel@0 {
 		reset-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
 		iovcc-supply = <&lcm1_iovcc>;
 		vdd-supply = <&lcm1_vddp>;
+		vddp-supply = <&lcm1_vddp>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&panel_default_pins>;
 

-- 
2.53.0

