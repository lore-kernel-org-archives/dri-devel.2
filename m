Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F093606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=tYBGQL9Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B796710E9A6;
	Sat, 21 Nov 2026 13:12:58 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E56B10E9A6
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:51 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266770; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:mw8/38fWulE679t7vQSeYlKE3kWx
 xV39qCgMiZdvRVoU3h7a0m/xWJY7jlKoD9jiI6Af57rUHP0iI8oIV++yYwQ5npCFdviW5NejPAi
 uaWktusHOiiERBZ/jZVYOQq1NEysQWd7LzhfZF1KsACzxgWooGViJ8htvFafUF0YajhUAzhk5N+
 PD3Wi+IyzpKTH/NhRs3DTY+TjIiCK51fmRdNCjUdmZ+xZq+5k/lqXB3T0aq6Vv4Qf3LpX1DtKX5
 wBt3ud7NeIMGdsaMYLQGmpbWhlcqudY8vuiQuYLTMfa0UGOOA3ymePrN71+ZaL36yVXoV5XMegF
 GSvjc4pnX7KSrA==;
Message-Instance: m=1; h=sha256: 1jZbLY78euY6QKZL5YFBE6ATcbWFDp60K4YQvdxWOMU=:
 DKfA7F1VU+V7lzQSpScTRDiCIsOepLNwxqWSV5CpBG4=, sha512:
 KEi2oP/N47mhW75RWtUDs36BbqJK2YXq4p8080Wt63p6a0cm9pC7emEf54JSnYC1yzpomwJv8kZChoRiEGFFOw==:
 s/S1tnTInFIAPXnPzsDz6NkELyPo0cVEQ9M52jTmuKDMqB0Da7+E/Se5MKwrFLzOkScu3lo3jsTBvRP9vBrdBw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266696; x=1795871496; i=jan.claussen10@web.de;
 bh=rxFVLEtbjWE7NR9/IStG1pbP4UVhJkkCxEYM7o8lQYw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tYBGQL9QyDe1o/p6RyHyo2/RadjB1veE9DvSZkyfbdBk0UJ4aUSNAWqQd6nC6K9o
 miZ67X3DCsb1eUsg+GQ0QTuFtdNlHPlNbxcpPWhQFZ/YYepMASUaM9HEmggGmAiR/
 Y3F/jDLiuDUE7bX1KGKBk7EnBatHKRtGyaH8W9F3Wiw6JNuuflagFA1pZ6vbPAm4x
 yvYDbeUN3Sm4rjv5ayY+2kK9KK43SHRu1O+kKm2J/ZHw2k/FmDAXCiN24CZQolFVF
 bFniJ4I+/jv4kqFkcZA1Tv3CQ67xqHV+KKzob8H4H1SAKDB88WVdD7athYya3k/58
 DtC+SS1oxiqNVIaRTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHmm4-1xjczh3OvW-002dZd; Sat, 21
 Nov 2026 14:11:35 +0100
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
Subject: [PATCH v5 0/8] drm: Add colorspace property support to the HDMI
 helpers
Date: Sat, 21 Nov 2026 14:10:54 +0100
Message-ID: <20261121131126.3358-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iE4EeG8q5FKizmjiNXQfT7fgAAVZCRUe86vXwnlh6RkYydXy8l7
 2ozuu9+5dbuWwWuk9FwicZo2DAtG7/3G3RMQX6Ji9csdXt0tzEZ5FEMHKCSsmkN3EO6v8p4
 JOjFGAPeUko8M257u5ULsPygE5YwyS1V2X+F+iQMTzuz3zYFI2C4M7iLzW+AM29AWCPsnpF
 +XGV3TedIAjHV5rjBHxmg==
UI-OutboundReport: notjunk:1;M01:P0:iEgrS72d8ug=;gU7msI8LGcTyVOBkoYfDvC3ZOu5
 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
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HDMI connectors set up through drmm_connector_hdmi_init() don't expose
the colorspace property, so userspace can't signal BT.2020 colorimetry
for HDR. KWin, for example, doesn't offer HDR without it.
                                                                          =
 =20
This series lets drivers declare which colorspaces they support and has
the HDMI helpers create the property and force a modeset when it
changes. dw-hdmi-qp on RK3588 is the first user.
                                                                          =
 =20
Tested on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC in KDE
Plasma 6.7.5. Only BT.2020 RGB is tested.
                                                                          =
 =20
Changes in v5:
- Convert VOP2 from V4L2 colorspace values to enum drm_colorspace, so the
  HDMI glue doesn't need a V4L2 translation (Cristian)
- dw_hdmi_qp: Pass conn_state->colorspace directly and set it before the
  early return, so a colorspace change alone is applied
                                                                          =
 =20
Changes in v4:
- Set the VOP2 color space from the connector colorspace, so YCbCr output
  is converted with the matching matrix (Sashiko)
                                                                          =
 =20
Changes in v3:
- Move colorspace handling into the HDMI helpers (Maxime)
- Let drivers declare supported colorspaces instead of exposing all
- Split into a series
                                                                          =
 =20
Changes in v2:
- Fix possible null pointer dereferencing requested by the Sashiko bot
                                                                          =
 =20
v4: https://lore.kernel.org/all/20261018143135.5745-1-jan.claussen10@web.d=
e/
v3: https://lore.kernel.org/all/20261018123037.19560-1-jan.claussen10@web.=
de
v2: https://lore.kernel.org/all/20261011142733.7806-1-jan.claussen10@web.d=
e
v1: https://lore.kernel.org/all/20261011132024.2833-1-jan.claussen10@web.d=
e

Jan Clau=C3=9Fen (8):
  drm/connector: Fix typo in colorspace error messages
  drm/display: hdmi-state-helper: Force modeset on colorspace change
  drm/connector: hdmi: Create the colorspace property
  drm/bridge-connector: Pass supported colorspaces to the HDMI helpers
  drm/bridge: dw-hdmi-qp: Forward supported colorspaces from platform
    data
  drm/rockchip: vop2: Select the CSC matrix from the DRM colorimetry
  drm/rockchip: dw_hdmi_qp: Set the VOP2 color space from the connector
  drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020 colorimetries

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c  |  3 ++
 .../gpu/drm/display/drm_bridge_connector.c    |  4 ++
 .../gpu/drm/display/drm_hdmi_state_helper.c   |  3 +-
 drivers/gpu/drm/drm_connector.c               | 17 +++++++--
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  3 --
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  2 -
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  6 +++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 37 +++++++------------
 include/drm/bridge/dw_hdmi_qp.h               |  2 +
 include/drm/drm_bridge.h                      |  7 ++++
 include/drm/drm_connector.h                   |  7 ++++
 12 files changed, 59 insertions(+), 34 deletions(-)

=2D-=20
2.56.0

