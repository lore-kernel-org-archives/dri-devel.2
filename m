Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD7DFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BED710E82A;
	Mon, 27 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dEaI6f4g";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B20D10E82A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:11:43 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-479e7e88fb5so4598208b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777309902; x=1777914702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DWxnwwnK1m7QIiM+kHUhFi9CGYBGNw3PT7/C0xFv7DM=;
 b=dEaI6f4gwtHjJ0LzhH7iwwk2ujEFSXVrTZR0vbZnMYdCEj6QfZpPC+CR1XrcdhCgfN
 ayjCJKrpaVZ6inVQevfnOPALgp3RgtnpZkZZvLHRMWT/yVWYJ0z+0IFr/qYdtzZAuHYt
 d589doLDq8beDJRM3xZS3CFY8W/juS5qOmss7RUJ+yt9yQEDyCKDpLKK2aSQediUDGkq
 /JFsRIx5SkRoT40zyj7bFqezL3mInEnQqZ1s+7sFEAlVQbEaqrQNfSZtq9Fvs8eXYdor
 HJaYiW6bTbE156wCnGyFOgOvPLvljtkGDpbSK1yPMSkZGIfiNGzoFtPS3gEBPTA/50w3
 T6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309902; x=1777914702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWxnwwnK1m7QIiM+kHUhFi9CGYBGNw3PT7/C0xFv7DM=;
 b=nhkTmZZlcVBnM/AwNfH+ug7+uRLLwz7qDu9WWb+la0J+1PdMeP7/MCbknLKrq1jAhn
 bIDSFOr7/4hkAyWfuK2vBO+GuYDN8rOjL68lJmCPFEDWi9WHwymH8ci5vN/fsWFFqkFl
 czyK0fw7m4GL3Y21bgWQe4wfObTu9KLo0wQVDTpBnP2G6gXVwLC5y2QSMVTuLEA6Zmix
 KOHDS8zT86ZIVYFW6GjGY9Hc+kPBC8XNOVZDH2hNt1iq7bDimh5050okXQBFBeQOnC84
 OUuKLl1LcrLhjoVflOs3IhrH4QEZtluajBXQ2tH9qL9czRKLIFoFyitxFtFo2S8pDIhc
 cBfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ITmnH9nOLiGX2gJYMmYnanrtj68jOn4cpPaOkdkqA+U8y6LgsNuPIwnLYKOdjTi+e1BXlyYntGO0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7h6ITlAIe3b+f91mR0+RIlOQ3cXfzQuctMVSTeve0iZq+lkwX
 KzJ7IKo4u2pxLdgnlY+M14XawY+JGQAvwd1XSmHaeqgXp3nBZBkbWbhf
X-Gm-Gg: AeBDies+5DDMNuR2x4Oqg0ZtUWXkk1gP+/lw4O658iAQak2NMK1/dphCvqAXfaDNXWk
 8qbki+T1iKl7PTIagpr2Z7UqT/IfdAlDZf/UYwE4aSErF/pG/hJLBPKnH9xOZ4YxgZP5+2CvvQJ
 SjVQwgxo6WBCAAwHgUKNDxmxWMGD1CsGVJRUSXVj67/k4ekBLd3+QIEfGUGGcjHVPOEwECYS6a7
 vnua3awhyd7rcPo3AcsGqXPYNuKolmPUhdHLSejITuB4nKJeOTdQvRRRDP1S+aYy/90CFyS7LBo
 tY+SvbGrT8cZ1HCAC4wRXg/rc3r0Yv0VijMCElRHw17P5bX37we8/AsVNcbDlvJo2dNbKzFmQ5u
 jeGKpDhBGe2FkSO9H60qiPhMXftgsI8BUaj+/5OKSz48cCqFbXUfOCVUK/U+Mj8KmOnu+Csmn1L
 +jrzYq1Ldz80niQY0mAN7eRtJ4qD+TniA=
X-Received: by 2002:a05:6820:150b:b0:67e:160c:36c3 with SMTP id
 006d021491bc7-69462ef3455mr23999976eaf.48.1777309902045; 
 Mon, 27 Apr 2026 10:11:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:11:41 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org,
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/6] Add Anbernic RG Vita-Pro
Date: Mon, 27 Apr 2026 12:09:08 -0500
Message-ID: <20260427170914.5062-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG Vita-Pro, based on the Rockchip RK3576 SoC.

Chris Morgan (6):
  dt-bindings: power: supply: sgm41542: document sgm41542
  power: supply: sgm41542: Add SG Micro sgm41542 charger
  dt-bindings: display: panel: document Anbernic TD4310 panel
  drm/panel: anbernic-td4310: Add RG Vita Pro panel
  dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
  arm64: dts: rockchip: Add Anbernic RG Vita-Pro

 .../devicetree/bindings/arm/rockchip.yaml     |    6 +
 .../display/panel/anbernic,td4310.yaml        |   63 +
 .../supply/sgmicro,sgm41542-charger.yaml      |   99 ++
 arch/arm64/boot/dts/rockchip/Makefile         |    3 +
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 1317 +++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |   10 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-anbernic-td4310.c |  291 ++++
 drivers/power/supply/Kconfig                  |    8 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/sgm41542_charger.c       | 1045 +++++++++++++
 11 files changed, 2844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
 create mode 100644 drivers/gpu/drm/panel/panel-anbernic-td4310.c
 create mode 100644 drivers/power/supply/sgm41542_charger.c

-- 
2.43.0

