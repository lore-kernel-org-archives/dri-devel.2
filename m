Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F68CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093AE10E1C7;
	Fri,  1 May 2026 13:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="adUiKSVP";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A7F10E1C7
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:52:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so18757845e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777643572; x=1778248372; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TMVLpLTQG5lZWLeJYW9UDuD2JHkqbhObk5hZ9L9zJnY=;
 b=adUiKSVPqWabFUk+wpkxTtyLJRcU54RBznDpLseagaUrc+d3yDE79MLMCFdO99Mskv
 eAR8l13nyGdi2NEfRfIyCQZICxjaKrdJolFHt7q2IHhhrWNtFJCYnrajSG4Zx/LwFPa3
 V63sEcHefOIvymqiXyA/8Omta4eI8t37lfaukhu4fzUmgbPDtG1GF9NWZZdszLgsdwkC
 E12rvh6GriI4WxGW0qEArhxuPawkl2aQJP0hHS8BjeHTerTG2a3cKwuxF6f1GT1Bj5E0
 pNSGa5bAiUMkg3PNYGdLPmnIsBi24hqIxVPSDuy2lK+sqj1+tPQN+u8kSDd/M8a1jebr
 NUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777643572; x=1778248372;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMVLpLTQG5lZWLeJYW9UDuD2JHkqbhObk5hZ9L9zJnY=;
 b=MHLQv+b8OeqlBBSGmE5ljDNGdMNskY9EqB5KF2BHJlUdVeyOLuNIyjDnPpYxxUe5h2
 HkgTJ2w3VnmPhNgdpDooTBBrspbJ+sS+6W+HHdr43HGURQiIYk9npGwmq8oDVT9QcHl/
 y30KvArfwAdQirJEueFBDpd0G3VVhJO+2hbiZNh2NlvV6SVskzeREyMEaAkucoL2CRfc
 BeHfdcp47MORfglCR7uJ12mGv7fgyZkofUaYeeLH4maU6HuQqY1dJpo0v1wl5410w/u2
 W65HeSKw+JXVT7GgJ5LE/exRKBgEB/WwYxGIiecuArzLLRRHiZJVThxQK2SUBHHgnMX/
 xlJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+2llOHM3lo508SmNslTpVT1r3LlH/celUkjI+SGk8iId6MHVYXkjW9/wiquE35CviZAMym5KyKL4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgu8K/x9khzNcI4VqRMwZxIUP5emRmhCZFVCyjz9nyzhXt/Yge
 UgmTWwSXbtdkBdls0lxgyEirc25PpiZl2p8L5CjmxirbFHmaWGGUW3fqSyQ0VIk920k=
X-Gm-Gg: AeBDieviQsCessbut6ayk1Ibn3swdvsWTEsxeVOqhdWq4pteE2DZ4YpDnI1KWjCbH+8
 qwgPyw8UqHYeH0sy01TClROpfWVUdmMOaukEo37vb1ygrHjoVM1BZDWF8LDPTTLXRI9DQhxVEwO
 XFjkDAxEzqrohqGwkt7EuEwhN0tk8g/oGH/00o5f32/KbFFPCRHPFW+uSkMJtx0mxRxSEA/MjQQ
 ztccmlRTtaY77hN/vpw2EOWPMjV0Y9FdxzzIv1/s15BDvOqDZTxWsxUWQ2nset55QkiSaoWH9p9
 MDb78AkqqIQ3CVZiPn+b4PA7aEEMkgijh2elDOAW6SdzwSpKbR2c0ch868aVabuyP/IQQ27CIxh
 s+z7yu3EHOlzAL9Wf7PtTfhAEdUrZ6gg0UhyzfTCXJe2GbDshOWRva2ghJ1FQjj8kyuVYqaF75r
 tyZ16sQdz29TG486CG8uAQY2LLcyra5O/5989S6btPslgKBV0P5ATeN7DU8slukacaIqqRmu5SF
 S/OqFoTMbaLKABhdGw=
X-Received: by 2002:a05:600c:8710:b0:48a:581c:ead with SMTP id
 5b1f17b1804b1-48a844448f9mr125569545e9.10.1777643572137; 
 Fri, 01 May 2026 06:52:52 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm143934275e9.7.2026.05.01.06.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 06:52:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/4] Add Novatek NT37705 panel driver for Fairphone (Gen.
 6)
Date: Fri, 01 May 2026 15:52:44 +0200
Message-Id: <20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02OQQ6DIBREr2L+uj9BES1cpXGh8G1pKlpAY2K8e
 6l20eWbvMzMBoG8pQAq28DTYoMdXYL8koF+tO5OaE1iKFhRMcFy7KcKp9bRC7nhQkspzVWWkPz
 JU2/Xo+vWnBzm7kk6fgt+hqf3nEbiqUHXBkI9DoONKnO0RjyGSs7g/4HKUizyIpc42NcYcDAhY
 N+yuuKV5HUt1MKh2fcPHwAhw9AAAAA=
X-Change-ID: 20260501-fp6-panel-3d35c999d894
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777643570; l=2402;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=5wJwm3SRvPPjAsEZfsMPDSlwXnO9rGALWap21GZU/AA=;
 b=oO9i1utf63UeB88XuI8j/Bc6pIM1KoMtHA460w5jA6oDGjhMDkGrKiY23k3DZIIF/WdIg//D4
 ewpe+gE/8MmB0auPCGXZK5kiReXAvIiaEnBFxQ952KhQqiy+1G0RoTE
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

Add bindings and a panel driver for the NT37705, and then enable display
on the Fairphone (Gen. 6).

Note: Patch 1-3 do not depend on the Milos MDSS bringup series, they can
be applied independently.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (4):
      dt-bindings: display: panel: Add Novatek NT37705
      drm/panel: Add driver for Novatek NT37705 panel
      arm64: defconfig: Enable Novatek NT37705 panel
      arm64: dts: qcom: milos-fairphone-fp6: Enable display

 .../bindings/display/panel/novatek,nt37705.yaml    |  72 ++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  64 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37705.c      | 413 +++++++++++++++++++++
 6 files changed, 562 insertions(+)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20260501-fp6-panel-3d35c999d894
prerequisite-change-id: 20251219-milos-mdss-fa0763693775:v3
prerequisite-patch-id: eb0d468b35da2b234b281b1223ce3299e49c3146
prerequisite-patch-id: d8de96cf1d5868289b93dd890e1a67868b66ebce
prerequisite-patch-id: 23f8e2e01ae265fe8962a43c788868bc1967640a
prerequisite-patch-id: 34b01b7beea2893cc4dbc3d917b478f334dcef74
prerequisite-patch-id: a1876564bdf2964d4674235559087a2a2a78be30
prerequisite-patch-id: 7e866ca016d2197cc568a9e4a59d2d268d7c67e1
prerequisite-patch-id: 9ec10047940f6136c5728a823446f48ffa4dcf1a
prerequisite-patch-id: 51cb44ac4224d487d435e79e6f7f194b3e631ece
prerequisite-patch-id: cd2b2599074549ef6290b344e4e45b1bf585f815
prerequisite-patch-id: 9bfe20dedf9aca64108de67061f1c92c4010219c
prerequisite-patch-id: e7c15f6889fc82f0f98cfa729cf12ea818c5d733
prerequisite-patch-id: a386fbb74b890e46769d55e8a7ebd85c5f58b165
prerequisite-patch-id: 6e80149f6e03ccfca3050e7dd4c34413921b1218
prerequisite-patch-id: 86a95fa80e3d50962f62c3aed59e4be8d109eb5e
prerequisite-patch-id: 17dbc2de61f51cb511c25bdf5662fd7757c954d4
prerequisite-patch-id: f3b59bd165455ca2f49f7d21711186b47ffb0539
prerequisite-patch-id: 4322a9b6586785464b5b70fe21b23e62f06ca364
prerequisite-patch-id: 37dd052963130e7e2b535aecbe7bdcbd69e54012
prerequisite-patch-id: 1f4c7495a492902dff20d285e2a67c1dabb9d96b

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

