Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902FAFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6FF910EF2A;
	Wed, 29 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="BM64Uoia";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6191710E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:22:30 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so8740417f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777303349; x=1777908149; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9wUtrIXRTfOr+O6nQ8tmIzbVyTOQXWqkfNhpm00D0Vo=;
 b=BM64UoiaaoFHAnFTtD9kbIUZF6ERVdw7hAJRxC2xdNeyiF6/syG2Y4+xYV9DTBOMKx
 hYYksyx5HlIlgEyph5n6FAm3FgV/PcLa7RVLCxgPwtSsKBij3FiDaLSgC1XsL2xcXO7c
 r5L1eIbqBruGfTZJgvrSsJCczd2nzFNG+6yHtwSzlYADxeij3DonhR+G5shyWVeKCn4f
 pA0H/WjQkqYUuWO0RLrHGp4n+s9TdA/vR7v/HOpjxhtJqvJhvP/08BpddxN3TEUcnl4M
 afaafdwVa6G5tpOT1FlqHGlefqDtHhhfvW7jp2//cKNpuaDccKq+LrrOeUJKp3TaxzLi
 hO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777303349; x=1777908149;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wUtrIXRTfOr+O6nQ8tmIzbVyTOQXWqkfNhpm00D0Vo=;
 b=WnA8g0ZFsRkmyX4XcNEkaJOuZ/kaC+AN5lff70Pl/fu5Jx+FNXmZI2aPgflcltLBpJ
 M+psw/jFvyYgNzXrYwBILzs4BoTL/JN0zahsZih1MTSn4Dv5MKAn+h/rN+SnuXtSvdoB
 Is5Sg2Ja3cpsRzWnACGcxhGkUUdx8FdZ3k1mAPZ9HHXSCBAc7XibrFJ7hRby8JgnND2e
 h07+qONYY5fCbCC13h1VJcfS2djXa24VIXePwTM+QC3ktk7JXo8SXxCyzx+YMbF8FaXV
 wOsTb8BBmbQJ52wy8U+7TjB6tQLbgOU0vd8UDdDGTviHORO+qElzHrjeGY3JlPhNivrf
 xqfg==
X-Gm-Message-State: AOJu0YwLU5ninXc4+gNd9uSDwQSmyvwpl/Cb/mmv/VUPBOvWqN7F0Vl6
 +YuJtOzFCTNnvoo8T/+8n+2plOrviiQG14+UVdpbfz82Tcn291L9HfuSSDVSrxs8ZBo=
X-Gm-Gg: AeBDievIXJkIgO2zFcTrN823S9/9zI1q7GOEmcVbxSL+LxYsGU3UrOSSJeE905m2V6D
 hASFg8MIsD+yfLYBcugIUl2qisj6/BnNPPh/pMPCmTaU9s+rsSa2KY2ZLlpejNwswOes+1poeiX
 CoxWBA7H7nXdiacjF2VxwAojJw82oUxfZ6OtPRezwvHAbzKNua0z1sBSeqFmH7jMDZVZsuQsrEU
 x3WcMqxnqaFHz6KPNcWR03/3zB7CtBoGqQrnkjzDfeVHT3tiKLvEHN/wG/IIXt1U4u89aqEulOQ
 Iz0KxYMpfhYGOLVpmMdNWUShHfTgouio0A2ECkT/mD3j4iEWBMaLTYrH/Cb0im8ArrHJO62+zXA
 79i3vzkilzv4YCqFSAyFYS8v0zTnWSzhiIS9CshTLYh5bfW2wuG3SQmBXs57UxhV+lBhNE1y7Kq
 HS6EIaZJ3XlCdorPoMpq/n0nclVSNAPM9CdF6mKqOIDrkGBb6lqP0D3+ljo/AXzpHNJP8IVDy/O
 Nevt+6XGYYtp89kGpCC7J1/qLt3EkDYmI/CMkMx
X-Received: by 2002:a05:600d:8408:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-488fb73dc6fmr483448635e9.6.1777303348718; 
 Mon, 27 Apr 2026 08:22:28 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm861247695e9.2.2026.04.27.08.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:22:28 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Subject: [PATCH 0/2] drm/panel: Add support for TSD TST070WSBE-196C 8"
 MIPI-DSI panel
Date: Mon, 27 Apr 2026 16:21:08 +0100
Message-Id: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOR+72kC/yXMQQqDMBBA0avIrDugUwnBq0gXiZnqiFXJqFjEu
 5vW5Vv8f4ByFFaosgMib6IyjQnFI4Omc2PLKCEZKCeTl/RE+YQFgwoG0XlwXyTrvXHkTGEtpGy
 O/Jb9v6xft3X1PTfL7wPneQGibHNmdAAAAA==
X-Change-ID: 20260423-imdt-dsi-display-28bb6a2a6188
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

This series adds support for the TSD TST070WSBE-196C, a 7" 1024x600                                                                   
MIPI-DSI TFT LCD panel module based on the Fitipower EK79007AD                                                                        
controller. The panel is connected over a 4-lane MIPI-DSI video-mode                                                                  
interface and uses the RGB888 pixel format.                                                                                           
                                                                                                                                        
The driver is a simple non-configurable panel: the EK79007AD comes up                                                                 
with usable defaults after the power/reset sequence, so no                                                                 
DCS init sequence is required. It supports a single power supply, a                                                                   
reset GPIO and the standard backlight framework.

Note that in patch 2, link [2] has the incorrect DTSI name 
(TST070WSBE-165C.dtsi instead of TST070WSBE-196C.dtsi) even though 
its for the same panel as this patchset.
   
Patch 1 adds the dt-binding for the panel.                                                                                            
Patch 2 adds the panel driver, Kconfig/Makefile entries and a                                                                       
MAINTAINERS entry.                                                                                                                    
                                                                                                                                      

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
William Bright (2):
      dt-bindings: display: panel: Add TSD TST070WSBE-196C panel
      drm/panel: Add TSD TST070WSBE-196C 7" DSI panel driver

 .../display/panel/tsd,tst070wsbe-196c.yaml         |  64 ++++++++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |   9 ++
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-tsd-tst070wsbe-196c.c  | 168 +++++++++++++++++++++
 5 files changed, 248 insertions(+)
---
base-commit: f6c73e7156b54d8b9ddf1a27f4e93d3a1e49a73e
change-id: 20260423-imdt-dsi-display-28bb6a2a6188

Best regards,
--  
William Bright <william.bright@imd-tec.com>

