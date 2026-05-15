Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DD2CD4F41
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD22110F428;
	Fri, 15 May 2026 07:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YNTwCWLX";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349F810E0A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:22 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so4034818b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823742; x=1779428542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BD6jb0vjKtzgJh8F8xKpey20kEfF+Odim4ezk9P1XI=;
 b=YNTwCWLXPVVeN7Mg2MG7RvV2EXezWm9HBIJXO66r0IUhRENe/WdfpLL116A2UkxhKp
 iYRZ9WoNrmWHU0QUhAh2EE7LLUW5k72wJEUhp/SWijF1LpQ80aXcrgVBnA1lHiGI4fRx
 ERJ/PedJ8JVKNP5pNXsO0/y2mZ0O/fDFR9j982pgWLuGS5qCKPx7vx1I0/Tsk5oxfBVA
 15e1GOqa14sjL5c/6dSNRX07ApkmEfSpvPqPCj9EgIyD4BbYJMmFO0I98sn2TFzNJL8o
 6GLA1DgzPxlOLv3spA4qGDFGBOelaadTQ/KZ61KHEcGQ9VENDfKR0t5vZ7FVfi6USAI8
 ifxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823742; x=1779428542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BD6jb0vjKtzgJh8F8xKpey20kEfF+Odim4ezk9P1XI=;
 b=CLnwYHYIXtCkV1q6imanRfVTa8R3B5HtNEJo8PTs2jOG+quZv9t72y8aXQt17+12US
 z/B/Un/3Js3qXE0e3IrydEc7b/bjEBWH8n4QU0n7VbT9MJQCSmQ++WjbhTYXjeM70r91
 dIFLleE7+sO163c6C+V1uSNgHVwN3MxZSfwuoPpJNuIqu9UgUWNRJiliPb/9GvGiFW8J
 BiEAa7F32mVslZ6JcjRJ3iE/zV4CryQPLPJyArLDcVje2IKna21/pq7F3Gpsglxe6O61
 5ay5nf+VZICP/yQv2d4TlpAbUVtY2ugQgxI66bhAEKFVxA0Q8itOGOo46EkzsAXRt4A7
 LrfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NA+9KRJ3HmIbJXdDibWc4cWUIw1t1m1+T56MAgMEJS1eEbs0JcpOANQY5e2DBu4ZTWLNWk7hwK84=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrwE63Z1FsNlVWjVFZvObCfE6s57apNVakMawCKWSb2NAQRjbM
 Gi0+hPLxVQNGatjgsiRJO6ZISLKsCqiOhqmpPFoREorLHeIjMjScA5za
X-Gm-Gg: Acq92OFhkEh3tSEzTiFXHnTnh0nV/gBxi1YfQT4pN9aAzUvyDHvA1dbnaiSJCnxNxbq
 sJdo/tPYEkeQDeliUP0kW6VAFyXZtAtKr3nBKUAK0roH398eFtSpu81HChw1W93cKSQN3vbZb0g
 YJ89gaTDS2owCADYPmb2vHwsRtJCgxf4KCMgbI5XqVm8BM7KCy3P8spisjfKHWr9nDxagOW7Lav
 wtOh/h5eeIRUmGCz2j1q8CzBlrOZw+7uDXTtxraFZy+/n29Gxp0VKoCfdR2GkS9xIef60/4X+Sf
 zOqsIVwLJmCWDKuNnN//vMybURoIgZ77ChH0v80y6ETWFoXLcFUdkPimvLrm4ya2aQcCzAGtef/
 GNwd0ErLEruZhBmRQXesMcx+rUdurYY8jcr+XvbLs27750GGUmGhjUxs81AbPNOx1QqgLOPOeuy
 QdVr5OnWKlnSj2KhTiVKsUyzL7NQR8UMApbIoA+MJFQCr5KIczmgyFXz7Qrmn/J7A/iHIyNvJGu
 vET9oY4el+jfw4+xcNplU3ESbc=
X-Received: by 2002:a05:6a00:1954:b0:835:366f:5da2 with SMTP id
 d2e1a72fcca58-83f33d80937mr2828691b3a.37.1778823741521; 
 Thu, 14 May 2026 22:42:21 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:42:20 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/7] Add support for the Microsoft Surface Pro 12in 1st
 Edition (Snapdragon), 
Date: Fri, 15 May 2026 15:41:45 +1000
Message-ID: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
References: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Changes in v2:
Ice device tree: 
 - Updated to use 0x0 formatting

Panel: 
 - Add edid to commit message

Device tree:
 - Fixed formatting and ordering nits
 - Removed extra dmic audio declarations
 - Added suspected devices on i2c busses
 - Fixed incorrect usb regulator
 - Describe panel pin regulator
 - Added defaults for volume button GPIOs

QSEECOM patch (4/8 in v1):
  - Applied by Bjorn Andersson
  
Hid patch (5/8 in v1):
  - Acked by Jiri Kosina, but not applied yet.

Link to v1:
https://lore.kernel.org/all/cover.1778498477.git.harrison.vanderbyl@gmail.com/


Currently supported:
  - UFS (with inline crypto)
  - Touchscreen, pen, cover keyboard and touchpad (via SAM)
  - USB 3.2 x2 with DP Alt Mode
  - Audio, WiFi, Bluetooth
  - CDSP, ADSP, GPU
  - Display (BOE NE120DRM-N28 panel)

Not yet supported:
  - Accelerometer
  - Front, back, and IR cameras
  - IRIS video decoder

Note on the compatible string: unlike other Microsoft Surface devices
upstream (denali, arcata, romulus13, blackrock), this device does not
appear to carry an internal codename in firmware. The DSDT, SMBIOS, and
EFI variables only refer to it as "Surface Pro 12in 1st Ed with
Snapdragon" (SKU 2110). I have used `microsoft,surface-pro-12in` as the
compatible. Suggestions welcome.

Although the device is marketed as just a smaller version of the denali,
it has enough differences that it warranted a different compatible and
device tree.

Tested on Surface Pro 12in 1st Ed with Snapdragon (SKU 2110).

Harrison Vanderbyl (7):
  dt-bindings: arm: qcom: Add Microsoft Surface Pro 12in
  dt-bindings: crypto: Add x1e80100 inline crypto
  platform/surface: SAM: Add support for Surface Pro 12in
  hid: Pen battery quirk for Surface Pro 12in
  drm/panel-edp: Add panel for Surface Pro 12in
  arm64: dts: qcom: hamoa: Add inline crypto for UFS
  arm64: dts: qcom: Add Microsoft Surface Pro 12in

 .../devicetree/bindings/arm/qcom.yaml         |    4 +
 .../crypto/qcom,inline-crypto-engine.yaml     |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi           |   10 +
 .../dts/qcom/x1p42100-microsoft-sp12in.dts    | 1201 +++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             |    1 +
 drivers/hid/hid-ids.h                         |    1 +
 drivers/hid/hid-input.c                       |    2 +
 .../surface/surface_aggregator_registry.c     |   15 +
 9 files changed, 1237 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
prerequisite-patch-id: a34133ba03bd1d31c0ed08612c31131b62015654
-- 
2.53.0

