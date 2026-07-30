Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C3C53200
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A0B10E0CE;
	Thu, 30 Jul 2026 01:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="o83+M00J";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B431310E0CE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1785375257;
 bh=npvKufDrxCamAC0XxJBTsSoLK/Np4E9Y3fZVXvjDxtI=;
 h=From:To:Subject:Date:Message-Id;
 b=o83+M00J3uvQhdLB6dqcF/TPFjUtN5FlxqHWNVzw7vsUaIXnKPKJcuznXtMfGUCnh
 4PH9VZts66qmM4nriHkPK3M+YK+JhZ81ZjRoHhTvquF8b+ov8b0aY0To3fiP8b/eLu
 OpLZfM9uVHthgxWZlUguPyV07j97u0r8TapNSyps=
X-QQ-mid: esmtpgz16t1785375255t1b5f5b3e
X-QQ-Originating-IP: pEB+rak0qFIvtoH5ex0k9x33XVmBeGbaXJ7neXht+5c=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 30 Jul 2026 09:34:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14627087560788875138
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v5 2/6] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
Date: Thu, 30 Jul 2026 09:33:45 +0800
Message-Id: <20260730013349.51-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260730013349.51-1-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjA5tsjrlPcvo/9ZOREPP3pvjBCGzJCCX27w6ex4OyK4RDbEmCqTKIHl
 6itxEmueeqMuJtckT03Hl6uwHKJ8ErZ1BTRX2NJcpPTBrZnVAx3ex/GH/R9l3hSgO+/z4oI
 D7ediTBLaPELIYlHFRWiuEArlVHPC4yQcAfVKznJb6N5ZwQNpaIqJygm9R4PubJswDBTYmg
 ag3wIVKsFRtPJrZE4wLq9fiu7Lh6eErm+m6ASq5cV0aRY/+rWgzaJbicwr4XYYboVByzTKn
 LZIBKNoUQawfwWDz7MpkQ53BU4ynUIzyQU+LzSSyYzZ4pdQyOrDsuh/vtjxm5zTJLFZhKe9
 gs5iuBEX3GVQyOzw6vb2Q7E0WYPI5DY93eiNaJTfW3qlZDMAOF0TvFyz0C57I7B0lAdTw86
 eQVTMy5dmasZ1NoVDsVGGdCgu/eIyj1nmawP5U7GQxekcPLP33Ld0HsyTdFPV5o5auHoFtl
 qDyYWoF7racwC63xPCpdkO80koQa4pUcbmaDT9JCyZLUTJse8hewPKJSKMchrqN5EdRZV0d
 sUPM0GJw/iwcuoSD0yD6TbDW3FBaQn93I4kT1SprfsOdzClnO8D3/g+iEcPPcdS0xQqnlEL
 vEiSUq5THYOzWBMylJiv/fYZqtaUIgb3l6eDPV/LYn8niYGTnUsjIEnTY/dwlEFshY5qBhJ
 PsE6wJWTmJOnFfcgyvE/89xqZ6IXBldyCvg1s02BuJxmmmVmN43qIA3kWc0j+rjkO9DgT+A
 92EyTK7qmMK8ToVqpXocyOp2ssCxZ8kwHjR4P1fulu5UhIypp+2wkY+xgrBrnDLvWNVkVMt
 x/li6sL/Cmt9oJQW4CHiaVcsICWsyhVCDyxgR+dTT535oSedpg3MP/WccuB3d5vZ3fj3dBP
 6vVNyyPPS8iqMzxQpo5oUdklFLgy9mH2XG08pDRU3Te9V16+BxdVpR7tlnIXIjLTudetLU6
 ycFzf9b0vUqbgBxSaNOMZpgK2m3fqvdlO/aTMGUE6Vj4e0t47XcZS9ODxy69p+udqzU+LhE
 317egh0A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The aux-hpd-typec-dp-bridge module serves as a generic TypeC
DisplayPort HPD bridge and is not required by any other
module. Therefore, it will not be auto-loaded.

Given that the drm_display_helper module houses DisplayPort-related
helper code, add a MODULE_SOFTDEP() within it to suggest loading the
aux-hpd-typec-dp-bridge module beforehand.

Suggeted-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/display/drm_display_helper_mod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/gpu/drm/display/drm_display_helper_mod.c
index d8a6e6228773..f0152d6b0b2d 100644
--- a/drivers/gpu/drm/display/drm_display_helper_mod.c
+++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
@@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
 	drm_dp_aux_dev_exit();
 }
 
+MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");
 module_init(drm_display_helper_module_init);
 module_exit(drm_display_helper_module_exit);
-- 
2.53.0

