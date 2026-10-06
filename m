Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F913CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 20:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816A710E06D;
	Tue,  6 Oct 2026 20:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="pEDsvSLu";
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E236A10E06D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 20:25:42 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-6dd7070699eso2526992eaf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791318341; x=1791923141;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=emWWp9zQLotPqVu53IbNyTMqcxVh3ZiXLOMaxjjb42A=;
 b=pEDsvSLu12m2r13lSSRFrW7b3Nm0pmyMqsq6eft4Uv22k3oYV9CbaOvFg+BLkb+js9
 p2g9v0IaObgnzCnaIfKZq2I00HQoBAxB+dmDozys3uIKIUX9dL37szYB9XhbEFV7MSUR
 uiaPYfk6tGD68B1IpUvfeCu9TvVItdIJdS/eY00YJ0gjn/SXpR3gBS4H6YFNP0Obeaxn
 Oe2hpOCcN0KNBrHTkANsS1waRtoM+SUIe3OT50M4VDlEl7aUl6s0XPcDiUNT/s3fwr1r
 ptL3/SYj2P8T5N1AZwO5bWGo6Jl0R9pAHdFUPzcG5rR5QUYE43O9fz4uF1whxqTlXTMT
 M/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791318341; x=1791923141;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=emWWp9zQLotPqVu53IbNyTMqcxVh3ZiXLOMaxjjb42A=;
 b=mLWOAZViYssCPUk3a2XlwlrLru0kKIK4oBkUjQldChBiLS4D1qn2LLt2Sam1ZUwyR0
 Ht1sZJRBmK8v+yKLErGiJHYTbCzow8q5VWh7xdMxL+/aImIBBmWayHBexE4Rk++TkG0C
 E0TLjZzQ5gUDTjBGVXSmMv3lGh0L7IFDQ3NnuTI5REfPpb/MCLSydMrNgbLw8XeA6iIm
 vtsId6ez9onWfFPdTAhuyc7ks2OHOtkwtW55O/vm4hk3kpIQxK0cPEqVpZnRr9iGTmmH
 lj6KcXqw/qJfMja2+8Wga7GdenqQtNbTwn+I9dpVnPl9/QWpmdN+BHKLaconK29uKk7F
 lSpw==
X-Gm-Message-State: AFuF++k+wrVBILNh5XJSHfy8uQlkVmxapm4kix4xHriMLX7wCqFzUufk
 YNH3Tjo8GK2KbhbC0Aaghj2wX1rHph9o4NbuDknTLqKWSATRes3lA8I7viTdpcNqHoA=
X-Gm-Gg: AYBFou3hV5l01UKmMaOjPMdNC4gRDSFLgt5zyviqHvYArCgZ2BLeNORrEYWJ7k8PDoN
 awfFXA3UDU504IsAXI9wltk1f2Kh8Ua4QVon3Vt9Gr0pX/tsbwIhUpLUvrZMqByB+E0pR1VHf30
 XfjyZwL5uTu00NkYJXyOQGpnzYR5RHgxzttrtRrdrjPEKsYuRZxFvxZSBC/+xN/u0lcaefUvnoe
 ohkuMPUDSgiladVeENCbmgFCo+Hwivnv47WkN/vdAGOlZmPWGzM5dSO+AaVnnSDgdevAYgbtR/C
 5Ei2LnRpdV8IQx6YBL3sRffxAcCLt7fGy/zuwnOl8jgxLbkvewPLTpHLy9WeWOBvrb0jaZ4zKcv
 YotuMAk9aLRJZ5lg34zmtyDB6mJAq1Wy3ggg1AY4RS6ASsFxUzwuwxyVReLZ900L9D2o5DIApEd
 qkGW3PxYXJk0PtYJ6Q3ugt4DB+Lk0szWmwfODzjY7Hj+Vz3t3JNUbuNm8Ulz8l6qmokcreX/X/x
 w==
X-Received: by 2002:a05:6820:80c8:b0:6dd:696d:b245 with SMTP id
 006d021491bc7-6e7a7185793mr353926eaf.53.1791318341561; 
 Tue, 06 Oct 2026 13:25:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793f68bf6sm463442eaf.8.2026.10.06.13.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:25:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] drm/panel: himax-hx8279: add VDDP supply for Startek
 KD070FHFID078
Date: Tue, 06 Oct 2026 15:25:00 -0500
Message-Id: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrDIBBA4auEWXfACE1qrlK68GeMU1oj2gYh5
 O41zfJbvLdBocxUYOo2yLRy4SU29JcObNBxJmTXDFLIoRdiwKQjvTDwW1cM9SZHhatzCa9OGzL
 eS6sUtDpl8lz/5/vjdPmaJ9nPsYN9/wF2kTCEewAAAA==
X-Change-ID: 20261006-panel-himax-hx8279-vddp-5dabebff2c99
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=pzE7TBtHaXQdTUaCA18apuhFLo+Jj6/WeoKJzFQFzDo=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqxVkes7QQS6aQ71ndy4RUpYujm7OFMzt2sBzSY
 kEu4bXRqfeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVZHgAKCRDCzCAB/wGP
 wGuSB/44mamJHa1OYsjk/6qCu9iX+nj2K3lZ+OPUrj2F/Tu1EPxYNTztwaI0acbMEtPAOin2fWA
 A8UERPrClUfDtJtQXleqD4fA4k4PCtaUDej9JuJpGH0hwuJm7y/s8SLzyqYDDgx8vj+fMDE9xFQ
 C8DBJBTejRaGWQn6OSrJ+aTu4QkEVuoMCMsKtLs3rsvMgLVaPz0bfKummw3fPVfhnIuG1Wqf9CY
 BQAhcSUE7ntQRjbKr1VUnFFZ853aN+Zvq9RG4Yd/9n8KBIejxnfEwMHGgMxKOb/oI4bLK8v/o7E
 n5On7Txi/XfsGkgGSlQtP53KKDh5xDd6iYFUeK6QSIK21wJa
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

The Startek KD070FHFID078 panel has a VDDP power input, which feeds its
DC-DC converter in addition to VDD and IOVCC. On the MediaTek Genio 520
and 720 EVKs, VDDP is switched by its own regulator, and on the Genio
1200 EVK it comes from its own PMIC LDO, so it needs to be described and
enabled. The existing Genio 1200 EVK device tree also turned out to
describe the panel supplies incorrectly, so this series fixes that too.

Patch 1 adds vddp-supply to the binding, required for the Startek panel
only, since it is not known whether the Aoly panel has a VDDP input.
Patch 2 enables the new supply in the driver. Boards without a
vddp-supply in their device tree get a dummy regulator and keep working
so nothing breaks.

Patch 3 adds the property to the Genio 510 and 700 EVK device trees,
where VDDP and VDD share the same VSYS_LCM1 rail. Patch 4 fixes the
panel supplies on the Genio 1200 EVK: its device tree pointed vdd-supply
at the VDDP rail and used the backlight (VDD) switch as the IOVCC
regulator.

The Genio 520 and 720 EVK device trees are not upstream yet; U-Boot
support for them is being submitted separately and uses this property.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      dt-bindings: display: panel: himax,hx8279: add vddp-supply
      drm/panel: himax-hx8279: add the VDDP supply
      arm64: dts: mediatek: mt8390-genio-common: add the panel vddp-supply
      arm64: dts: mediatek: mt8395-genio-common: fix the panel supplies

 .../bindings/display/panel/himax,hx8279.yaml        | 13 +++++++++++++
 .../boot/dts/mediatek/mt8390-genio-common.dtsi      |  1 +
 .../boot/dts/mediatek/mt8395-genio-common.dtsi      | 21 ++++++++-------------
 drivers/gpu/drm/panel/panel-himax-hx8279.c          |  3 ++-
 4 files changed, 24 insertions(+), 14 deletions(-)
---
base-commit: 5d7b464a4f517d1db533b1b231f42ddcf4e1dff4
change-id: 20261006-panel-himax-hx8279-vddp-5dabebff2c99

Best regards,
--  
David Lechner <dlechner@baylibre.com>

