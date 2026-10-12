Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F95FCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C6910EBEF;
	Mon, 12 Oct 2026 18:11:19 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F32C10F28E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:11:14 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c262f1186f0so282293466b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791828672; x=1792433472; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bnEmVKkg5cFu8WsjlyBzfJa9upBux4p0W3hKHpQdaIg=;
 b=X9S+9fUBB4pPX5bMa/cxxBhhPb0zR9BV4Skinwsmz3KE1ircioQkxrT0BZOTBHiAAR
 JRRDVgkn/VbaaRdyU2pPdXtFQuXkyWPFRbceMqxSXuPerfhromV5Rl1Xo2jaUnpHe2mZ
 WEtuS7FwSXXwZwmC/CQ2QvgU/gavctGR50d0RCrq6PvEvjUzNGJohEKNr1s/r7ocDKDy
 t45FdvSaCg+SYHjWslPkGk0nquzYbcCEoqREwEcR0i+/hCYN4olM72yPfoN3i0AdkZpQ
 XrVj9cIE2iFy3q/lbJ+eRMKCKF87/bD3b7PCmmz/JSIspc5Txxdl5DKG56wcN4zDp9P6
 lq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828672; x=1792433472;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bnEmVKkg5cFu8WsjlyBzfJa9upBux4p0W3hKHpQdaIg=;
 b=I1HAZwGA9ZOKBX7VuQbIijNxJ4VY03XQ6MLjRAmuv0zgPz9QWkBX5MrcDWg1769QLb
 4beZhu7GnjOGeLNbvB2wVBEgl2H4LZx9gVC3suxe7wgPjcvLXgNW/PoNL+VzIiGbT0Kk
 xNKX21qByK+pbFWh8u3DXBekW+sQHdQkr8H/MaqCR19wVT3OJdo8yMtb4yf5J8WGAh6+
 wis+WOzUrz44OCe1TlmYZ+NBvGUlsM9oWUH0ll8NxoE8cn84tDOOh39IGkTBG90kuXax
 GywaCqL3Lbipn2TaacGmdWW3M1G68PrU3rW/qxtzHVMm+kJ7A0hIGvjeCHAQ5qIk3WP8
 j/Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw81+r2f+4tSSoXH17/zx9HsmVWIUbGsJpUiVDgNLyqUO+7pTCMm0eqsIr1X3dEJdlTlJk3JbDBMvk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKe2/d+FHhM5a6ob72HWEFHiQgaBQIAabdXDa2cJTaKJg5rPNpJ
 PnYE0523urX/oHDgZ9qVhi9VCWqtuPxqqTqh+ikqxeZp3UUuKIt2auPX3a8zYjjOr60=
X-Gm-Gg: AYBFou3SqKDDKm7QezOWJtbImNwaCsBGuYAzlaZTTniYMMN6eTGDg0ec6gO1Nm7F9LJ
 7rzXz2OLdg4H/eqYOm2+ljliskbjQbfl4r1dzgwB0HTxkA8L4T+fCrJagF+pWpGxyfWmPc7IWht
 HjEqGR2MO0/vr8z1KbcTR+z6t9DX3zIkTMnQRBM34opHSrwwEBaatX/JGToS995CiPW/NLoDxI9
 Q333jfCohyeY2sHqErfVDrvg0iiGkhm2lH2vNeTxpPGjHKNNik6WrTUqQ3Lt8dnRPSeK9UrCw79
 +9p95/x8AYzlyD5osGyGI9qL26s/S9ACkfACZ4hdk7pqC/JTxF/XWhPLw06GXlAu+KdDKbeBmZn
 lOG6bnMwkNLj6ooyx4SCo1HFnbbqh0LBUQ0s3l8EUMM6/gGkZb3FWrrFNUjEjUjVdKT7v62gnGt
 Rj3bx39lJyTeZvpqitsaJktjVQ8pNUgDbYLq7C7rsdIiG4ao6DTqNhyJPvg83RtFsVt/NfHUJT5
 e3pF90nCQrlwskKsCqY5gKQI8ACj0Vawo4NxzLbI+BH19j82v065hW0Ont/XbFVr8Ni7kgKr305
 eEUGuGwL2aOWw4DafqI=
X-Received: by 2002:a17:907:971a:b0:c2e:378c:8cee with SMTP id
 a640c23a62f3a-c31aa05bf43mr948779266b.34.1791828672451; 
 Mon, 12 Oct 2026 11:11:12 -0700 (PDT)
Received: from [192.168.101.179]
 (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl.
 [2001:1c04:504:7401:4b2e:1820:6d24:b264])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac924dsm498415466b.70.2026.10.12.11.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:11:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Support for the Samsung Galaxy Book2 Go (SC7280)
Date: Mon, 12 Oct 2026 20:11:02 +0200
Message-Id: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ND3aT8/Gyj9HzdJINUSxPTVFPjtJQkJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAHSvcVBrAAAA
X-Change-ID: 20261011-book2go-b0e945e53fdb
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, Jasper Korten <jja2000@gmail.com>, 
 Luca Weiss <luca@lucaweiss.eu>, Federico Amedeo Izzo <federico@izzo.pro>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791828669; l=872;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aTUa7IEtoyVwyYxpXeqEYAviexKN4tyKhS8parfMx7w=;
 b=DnBnnWdN69x/EgtwVUigFuygLAgoZ/D9erZU7A/iJC3vkzP0Nrd+22v1FASSvO/66n7Lf31Bk
 55R0Z3Ed//nCdn42fMg60F2hOzAV9xtQk4lKpZ2SZY9YQXp5BOgIr9f
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add basic support for the Samsung Galaxy Book2 Go laptop. Basic support
is just eDP panel support, devicetree bindings and a devicetree.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Jasper Korten (2):
      drm/panel-edp: Add AUO B140HAN04.0 panel entry
      arm64: dts: qcom: Add Samsung Galaxy Book2 Go

Luca Weiss (1):
      dt-bindings: arm: qcom: Add Samsung Galaxy Book2 Go

 Documentation/devicetree/bindings/arm/qcom.yaml    |   5 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/sc7280-samsung-galaxy-book2-go.dts    | 643 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c                  |   1 +
 4 files changed, 650 insertions(+)
---
base-commit: d970aefaa8160df2d536a71cee2d3df9ff65889c
change-id: 20261011-book2go-b0e945e53fdb

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

