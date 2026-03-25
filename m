Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53879FEA831
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F72F10E7FD;
	Wed, 25 Mar 2026 07:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Soua7AER";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BA810E7FD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:58:38 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2b05761bec1so3013985ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774425518; x=1775030318;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJ34ULO+4B4J6OCPldF/OE/E1yD2HcPakHHg6DI67Ho=;
 b=Soua7AERkakCc1aU9SQQUt2Rdxw6L11AqYM6Z5rSknrwEYoIFNrn7QQxshX4qMZCSw
 Ba3+08uiz6TbOHskdXcs0JurJVGUXDAIoTiRIQMC5/mEQRnhl3Rm6irnv/XcYwFTmnLt
 ZbTS6Eefzz+bFZqE2FMZD1Zq/QyOWpiqpC0zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774425518; x=1775030318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJ34ULO+4B4J6OCPldF/OE/E1yD2HcPakHHg6DI67Ho=;
 b=C0P6NGbQrnspI2SJe8R0qK948h9nwJM1yWe7ylw7NxEV2kBDvLP4vVikz15Ak/qY40
 E74M5E4m4OjYmQWVXikx6pC5Mn89Lo+EQkx7uMLrEf40i5ZDt0Q1ATbpjDpSTyUkNC41
 t9LnQyc3KL62Tnj9HCx6g4FnRbGlY0QxxSXvf/Ncve372nlQapwksXNCryafVGPZrmFi
 5AQdM9AMUfhwxKdptknEJGAlZjACUUFfCU6wjSu2+LKMf+m4flPPOJfFSOpG22fE58YC
 eUtSieXjNIRFVRHIVoEhx/5gZOVvjJ9VCWtcRxB/oObl+1FtIBi5C5bIL5yvY4WRl9Kw
 TKfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Z2XVmhO6BJ8MJxxaurEpg3t2uPUOuRo2rzhZpE6tYkDGsvenZ7+umgw8SYj4GyB4ndQPu+5OWkQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxikZGxJXMjY2brTK3g87hNgpBddUW7RumPAgWsJ8t6V9GEblFE
 C3RMlKFZGDvVTMFJrk27YA1WLyvEEKzLKxYtmo6vbXP2nNW9v5ZE4faDemN2F5TTow==
X-Gm-Gg: ATEYQzw3bTYrfXAxMm+AAvpvMMgVPAfbgMvnyiGYIHPGfzLPHhyxytehpOkQWl7UybW
 jAvj94nj0LNSfmEFL6DMt4v35+klO5Q6ehzVfK7/bKfzeCKJFHY9cd2yCxg2zTdVb2lpV0s5bWD
 EB47qHm+nwmUh4rrT364zHMQDrDiUkf4ltERcSKBA0A9HahQi1C5FbaSMZY4V1IBma9lpNXyVcz
 b0gR7NO7ET+xbdjUjMX3ttC/4IPZceUbwnQZUYURKW6yzesIJb0IQlMBCPjTaMgxKHvzbEiuDNP
 nXZJ5Z4mhv8qZueA2n/7CmumHAKb2CsZoyd/Zwn6sTedqbcff11jn7ZNh54eIh1ZpBNo0JFD+ZR
 y6umburALtoqyY1aJQ0RmmsserOHJWJD7xKmhltB+4wRrARDK2kRRtuUR33gkbwnWjfnSdvZpLI
 t3QeaJH0CLHJ6l8DMlA7jbDEQUjFhl/rzjnUFYGHGm9IDrwRLGvsfPirjchgPzJExvge+GZTnYF
 BslZJHFKYR3qNz5Kg==
X-Received: by 2002:a17:902:ec8a:b0:2ae:4ef0:168e with SMTP id
 d9443c01a7336-2b0a4dc9efbmr60505455ad.13.1774425518163; 
 Wed, 25 Mar 2026 00:58:38 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:7ff0:bee3:7d45:eab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c3f7sm219682465ad.60.2026.03.25.00.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:58:37 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Icenowy Zheng <icenowy@aosc.io>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: mediatek: mt8173: Fix MFG_ASYNC power
 domain clock
Date: Wed, 25 Mar 2026 15:19:48 +0800
Message-ID: <20260325071951.544031-5-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325071951.544031-1-wenst@chromium.org>
References: <20260325071951.544031-1-wenst@chromium.org>
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

The MFG_ASYNC domain, which is likely associated to the whole MFG block,
currently specifies clk26m as its domain clock. This is bogus, since the
clock is an external crystal with no controls. Also, the MFG block has
a independent CLK_TOP_AXI_MFG_IN_SEL clock, which according to the block
diagram, gates access to the hardware registers. Having this one as the
domain clock makes much more sense. This also fixes access to the MFGTOP
registers.

Change the MFG_ASYNC domain clock to CLK_TOP_AXI_MFG_IN_SEL.

Fixes: 8b6562644df9 ("arm64: dts: mediatek: Add mt8173 power domain controller")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78c2ccd5be13..556e806b7787 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -505,7 +505,7 @@ power-domain@MT8173_POWER_DOMAIN_USB {
 				};
 				mfg_async: power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
 					reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
-					clocks = <&clk26m>;
+					clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>;
 					clock-names = "mfg";
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.53.0.1018.g2bb0e51243-goog

