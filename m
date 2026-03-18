Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC25B103E160
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1806710E0F4;
	Wed, 18 Mar 2026 10:51:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2wDFCb8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4012710E0F4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:51:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A8C46600C4;
 Wed, 18 Mar 2026 10:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811D7C19421;
 Wed, 18 Mar 2026 10:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773831097;
 bh=kiXzaIlOIf91vlJwO905mbx+Wk9O8TitUJnvCHfU5wg=;
 h=From:To:Cc:Subject:Date:From;
 b=U2wDFCb8CJyltvYq7etXZX2JG++z8ff6A3MG05mr/K+R2V0jhBcwUyCKlhKN2mevL
 UmbNtVxfnzru5b9NI3N0XizdQtVYSJ5NtU5ngbhfF4HU284anPcn7GcFEvQpiH/zC6
 wcTXlpzhd6uaCsLHqzlY3WVVFj0ny97sW5kGUR5syUMN6B245h2R1kzqMakcYpIzCb
 kHHiTutVDmS4j2Co2HFYkG6TEpHxFmO+e6Uq1wrKCo7DJ5us7tyhPR2Rm5rWZyiFlg
 yxRnftZhe+eF7CWAyqEgJA/tWQcUXP4FrDpZ4aUFZFrOQvjaMLsYwZW7ztfpUwA94Q
 J1ABra+W7HC8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Eric Biggers <ebiggers@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: lt8713sx select CONFIG_CRC8
Date: Wed, 18 Mar 2026 11:51:15 +0100
Message-Id: <20260318105130.1969966-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

CRC8 needs to be enabled for lt8713sx to build:

ld.lld-22: error: undefined symbol: crc8_populate_msb
>>> referenced by lontium-lt8713sx.c
>>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_probe) in archive vmlinux.a

Fixes: 4037c6adc1f9 ("drm/bridge: add support for lontium lt8713sx bridge driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 81e5f719e403..6ad71686ea96 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -195,6 +195,7 @@ config DRM_LONTIUM_LT9611UXC
 config DRM_LONTIUM_LT8713SX
 	tristate "Lontium LT8713SX DP MST bridge"
 	depends on OF
+	select CRC8
 	select REGMAP_I2C
 	help
 	  Driver for Lontium LT8713SX DP MST bridge
-- 
2.39.5

