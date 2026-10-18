Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242F4CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD6610E22F;
	Sun, 18 Oct 2026 12:31:06 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E89D10E22F
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792326651; x=1792931451; i=jan.claussen10@web.de;
 bh=y1tUSwwH/SKXHQzEF0csfBj2cge0cQpzQICR3mM6fa4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gIkDPZCRMrOMEpbIRKXiVGHGAvfpY/hHp1HoSrXM9RRnzEdYsVAHNApGHHh0A0sD
 1+mapGTqvcGCyQr6XTdlCNM1B0PmZ1S1jM95SafJiuA2s49arz6wTFLVeNKJFteUC
 YWj3lwMbI2lzv+uN4NoKfFidWv7gW2OEUnIFWTJnRwyE1QYQPxAaxAIQ2qICoo9pj
 1EjrP32jOiGpAbjvfJK9ehaZvVmrAQ+knpnt0pKtA6sOo1okm/xZAbR5XuhJXqvu7
 tBlrrNfn919dXthDndjIphf/+ir67uhvcoOFSLkdfyogTKqoAZ7elcSD5duLlEoZv
 6de54wGhHQtHJZw+lA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1xE0BX2exs-004PDP; Sun, 18
 Oct 2026 14:30:51 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/6] drm: Add colorspace property support to the HDMI
 helpers
Date: Sun, 18 Oct 2026 14:30:10 +0200
Message-ID: <20261018123037.19560-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YUyEXDs33/WT2j9gHPpmoPWKWgQHLP7QdGKEjvJa3ntfhiFTe6z
 uqNKhmp8epS5DO/6d7Ko4rn1rWA6JLEfogarcAvKRN3EPasVQ8FXelfEgEn/AeuEi53En4B
 Z/eWqdWm2WuYvnAbwSo5354kzsj5AkXHZvh8RrrANmdIndKhlKUemkar/XQyTs0CnwPRTwY
 XdgVJFxWljnHbZJHxTukg==
UI-OutboundReport: notjunk:1;M01:P0:bWTwvbbIS3s=;M/ZgtQRVvmQkVCK9QyKM/vHRLea
 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
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

HDMI connectors set up through drmm_connector_hdmi_init() don't expose
the colorspace property, so userspace can't signal BT.2020 colorimetry
for HDR. KWin, for example, doesn't offer HDR without it.

This series lets drivers declare which colorspaces they support and has
the HDMI helpers create the property and force a modeset when it
changes. dw-hdmi-qp on RK3588 is the first user.

Tested on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC in KDE
Plasma 6.7.5. Only BT.2020 RGB is tested.

Does VOP2 use matching coefficients for BT.709/BT.2020 YCC
output?

Changes in v3:
- Move colorspace handling into the HDMI helpers (Maxime)
- Let drivers declare supported colorspaces instead of exposing all
- Split into a series

Changes in v2:
- Fix possible null pointer dereferencing requested by the Sashiko bot

v2: https://lore.kernel.org/all/20261011142733.7806-1-jan.claussen10@web.d=
e
v1: https://lore.kernel.org/all/20261011132024.2833-1-jan.claussen10@web.d=
e

Jan Clau=C3=9Fen (6):
  drm/connector: Fix typo in colorspace error messages
  drm/display: hdmi-state-helper: Force modeset on colorspace change
  drm/connector: hdmi: Create the colorspace property
  drm/bridge-connector: Pass supported colorspaces to the HDMI helpers
  drm/bridge: dw-hdmi-qp: Forward supported colorspaces from platform
    data
  drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020 colorimetries

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c    |  3 +++
 drivers/gpu/drm/display/drm_bridge_connector.c  |  4 ++++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  3 ++-
 drivers/gpu/drm/drm_connector.c                 | 17 +++++++++++++----
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  |  4 ++++
 include/drm/bridge/dw_hdmi_qp.h                 |  2 ++
 include/drm/drm_bridge.h                        |  7 +++++++
 include/drm/drm_connector.h                     |  7 +++++++
 8 files changed, 42 insertions(+), 5 deletions(-)

=2D-=20
2.56.0

