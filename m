Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8448606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QloqBOm9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C575010E2E0;
	Fri, 27 Nov 2026 16:19:13 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3891810E2E0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:07 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261127161905euoutp01fa790ed213678f6942f47a3178aa0ae5~r80MAeXUv2495924959euoutp010
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261127161905euoutp01fa790ed213678f6942f47a3178aa0ae5~r80MAeXUv2495924959euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795796345;
 bh=+mS3OhBAT0MmLa4pJtM+GnResywpHJ0OX4QBbJjZfXA=;
 h=From:Subject:Date:To:Cc:References:From;
 b=QloqBOm9P7uB01dfZ4H3oOeUI9Ug+A0RZhVJR3R6ewNj+VS8q7qtnSTDYv2ELXyxa
 0MmgDLvrPfa5x+vHidZcGLgnLt9oEukX1gMMad+CLURcQziLeufj+7bmyV5ZncSaUm
 Ut62SsgYOG8Iqv4dRyrkGlySwznsJPdb/qYVKmJw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261127161904eucas1p1e35356631d4599bbf6b2d02373d3b5b7~r80LfNzmj2630926309eucas1p1i;
 Fri, 27 Nov 2026 16:19:04 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261127161903eusmtip2351707b3cde8dece22823c2c0be40197~r80KlDCGg2969229692eusmtip25;
 Fri, 27 Nov 2026 16:19:03 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH 0/3] drm/bridge: inno-hdmi: Fix sync polarity, hotplug and
 DDC adapter
Date: Fri, 27 Nov 2026 17:18:58 +0100
Message-Id: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKtCWsC/x3MPQqAMAxA4atIZgO24O9VxKE2qWYwlRZEEO9uc
 fyG9x7InIQzTNUDiS/JErXA1BX43enGKFQMtrGdMbZHUY240yFI5DEG1EiMXe/86IYhcLtCac/
 EQe7/Oy/v+wFilVK0ZwAAAA==
X-Change-ID: 20261127-inno-hdmi-ddc-of-node-67ac9a88fe5b
To: Andy Yan <andyshrk@163.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,  Heiko Stuebner
 <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Byron Stanoszek <gandalf@winds.org>, Dominique
 Belhachemi <db@domibel.de>,  Owen O'Hehir <oo.hehir@gmail.com>,  Michal
 Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=eiDFzxOVwdZeVSC+PuwyPjEfgixdlKun5pUbOuX8rII=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWRzri3fduqRyUfT7e8/7V/Kkyu/hl1nghf3+7z591XFf
 ryoEXnv0VHKwiDGwSArpshydmO0keQ/hqflxx//gpnDygQyhIGLUwAmsoCZkeG5byxjv3v1a8Xi
 7kKvcL0tFldbygyyr1jm9PVIns9NncHwz1j85SUl/WfJQZNeyNoXH28/WHQpop/7+gt19tpZ5vM
 NWAA=
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261127161904eucas1p1e35356631d4599bbf6b2d02373d3b5b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127161904eucas1p1e35356631d4599bbf6b2d02373d3b5b7
X-EPHeader: CA
X-CMS-RootMailID: 20261127161904eucas1p1e35356631d4599bbf6b2d02373d3b5b7
References: <CGME20261127161904eucas1p1e35356631d4599bbf6b2d02373d3b5b7@eucas1p1.samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three fixes for the Innosilicon HDMI bridge, which the Rockchip RK3036
and RK3128 use and, with the series in [1], the StarFive JH7110.

Patch 1 fixes the HSYNC and VSYNC polarity bits, which are swapped.

Patch 2 fixes a NULL pointer dereference when a hotplug interrupt
arrives before the bridge is attached, by reporting hotplug through
drm_bridge_hpd_notify(). That also keeps it safe against
drm_bridge_detach() once the interrupt is requested in probe, as the
JH7110 series does.

Patch 3 stops the I2C core from trying to create an I2C client for the
OF graph 'ports' node on every boot.

Patches 1 and 2 were part of the JH7110 display series up to v8 [1],
and are split out so they can land on their own.

Patch 2 changed approach in v8 of that series, after a Sashiko finding
on v7 patch 8, "Split probe out of bind" [2], showed that once the
interrupt is requested in probe, checking bridge.dev races with
drm_bridge_detach(). Heiko's Reviewed-by was dropped because of that.
Testing on an RK3036 or RK3128 would be welcome; all three were tested
on a StarFive VisionFive 2 with the JH7110 display series applied.

[1] https://lore.kernel.org/all/20261124-jh7110-clean-send-v8-0-de92635dd857@samsung.com/
[2] https://lore.kernel.org/all/sashiko-outbox-201623@kernel.org/

---
Michal Wilczynski (3):
      drm/bridge: inno-hdmi: fix swapped HSYNC and VSYNC polarity
      drm/bridge: inno-hdmi: Report hotplug through drm_bridge_hpd_notify()
      drm/bridge: inno-hdmi: Don't give the DDC adapter an OF node

 drivers/gpu/drm/bridge/inno-hdmi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)
---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261127-inno-hdmi-ddc-of-node-67ac9a88fe5b

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

