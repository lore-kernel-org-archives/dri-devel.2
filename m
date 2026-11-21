Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D2606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=fk+TC3PW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0864810E3C7;
	Sat, 21 Nov 2026 16:07:41 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B63D10E3C7
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:07:34 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277252; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:X65IAW1yi6m+I5SIGi9fyKXX/Tk7
 PNAgmC1UbfHSXFUrO9B14704dclWs/XRU7CRKAOzfbVdd0aoXGSnf/lMqjETTNEUgIuAi8OKSCZ
 uUHHyMtkVj+Pi8KX2Bz+lovB6eEPCaDmcuzw2VEEGqqcri1fl4794uP9xD8pAP45Yd5FSNWCBJu
 c85AO8YHPZHXQaLDoBz01kOoK7oO3+TWTS5LjB/c58xTbfdFH0BaNU1R0wpy+NCcQ0sXYRoJ2IX
 jKDk2n1/EdxdkJO2+td7UkVmirGFSLhpCXZmUwxnbgH6Q0nWkElc+t/zCmSEyRscjjHwt2Zcabj
 7iiM17r4xccWkA==;
Message-Instance: m=1; h=sha256: 2vwQxENCCvvaoNUVgIK1pSjuKcMPUUEr9FmHVdQBs6I=:
 SrKq1AVUeR8tXN7oEMlGrENvvCesxJJOwn6jHWUO8bc=, sha512:
 POI8iEI4WXUiDuuaDPWqF7TbYof4cxVhLK86YErMCTttiTXDmoeqrrJATPGh55ipLe9unbSrEXm0kj5o9+e1CQ==:
 LFAaS5xzmiaGVVXjqprZlmdefEK4BP8Gh3PsZlsIanIsn4pie5tYang8LPunZr35m3gLc9uKm3roiGzKuutUpA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277251; x=1795882051; i=jan.claussen10@web.de;
 bh=gdRFgZq93ce0OMtSt+2s2NX7CxgDUr6XYee8t8HRuYw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fk+TC3PWRDu1XIXwazkcbyBJyi1ParM1rCHujDlMelGiyTKix1v3K33UPsR2imUF
 tHKLZFiH5KM8xKAL9lbSk7S4tHjC9MziXpbWYaH7RVruxqw1XEsGmRaYq/f4G9bXS
 Sfmdx4kLoMEGq63+eg+526/jMn6oYemC6IbEFNAK4B4tZwEfH5WkkQN5Z+aE5IGi+
 w3PQIEU5PJfoBx5G0SPYdmP4H7JMpFmYnsiUT3roFnX4lGjTXCCyR8uePQ3Tmh9TY
 ezbQUsuE8EC/qnczVOEHw9/CLvcdKK1bqVCdrkLzFYf8qDPCAFu6Gc0wZtqUgzfrp
 KuvtElNNK7f3wWLewQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1y9ekv42dz-00kEhZ; Sat, 21
 Nov 2026 17:07:31 +0100
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
Subject: [PATCH v6 0/8] drm: Add colorspace property support to the HDMI
 helpers
Date: Sat, 21 Nov 2026 17:06:52 +0100
Message-ID: <20261121160725.6344-1-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/fmkgac1nzvp/3BKmHzxcsx2PT/VVR1CT8bt3JkAYDdAtl1KjBv
 +rHKK4QRjyPyGNhZj/r8Zttot31IT+OV+H/59/KRELLB93IF5vODhe2mCts3LB617YiQQ+Z
 DaNDmdyyULw0/PWCuFIWr4KkqpWrtEkvUyRjKLcOl1zmWjFONVgl7ageaxBQOgS7p4CZK5R
 IbwoEhO9dr3ioAmwLRHrA==
UI-OutboundReport: notjunk:1;M01:P0:yuWMBkfQeO0=;FUT2bx2eBTHCRkcAR3SBxgmrSKf
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HDMI connectors set up through drmm_connector_hdmi_init() don't expose
the colorspace property, so userspace can't signal BT.2020 colorimetry
for HDR. KWin, for example, doesn't offer HDR without it.

This series lets drivers declare which colorspaces they support and has
the HDMI helpers create the property and force a modeset when it
changes. dw-hdmi-qp on RK3588 is the first user.

Tested on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC in KDE
Plasma 6.7.5. Only BT.2020 RGB is tested.

Changes in v6:
- vop2: Keep mapping the BT.601 colorimetries to the BT.601 matrix (Sashik=
o)

Changes in v5:
- Convert VOP2 from V4L2 colorspace values to enum drm_colorspace, so the
  HDMI glue doesn't need a V4L2 translation (Cristian)
- dw_hdmi_qp: Pass conn_state->colorspace directly and set it before the
  early return, so a colorspace change alone is applied

Changes in v4:
- Set the VOP2 color space from the connector colorspace, so YCbCr output
  is converted with the matching matrix (Sashiko)

Changes in v3:
- Move colorspace handling into the HDMI helpers (Maxime)
- Let drivers declare supported colorspaces instead of exposing all
- Split into a series

Changes in v2:
- Fix possible null pointer dereferencing requested by the Sashiko bot

v5: https://lore.kernel.org/all/20261121131126.3358-1-jan.claussen10@web.d=
e/
v4: https://lore.kernel.org/all/20261018143135.5745-1-jan.claussen10@web.d=
e
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
 drivers/gpu/drm/drm_connector.c               | 17 ++++++--
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  3 --
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  2 -
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  6 +++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c  | 41 +++++++++----------
 include/drm/bridge/dw_hdmi_qp.h               |  2 +
 include/drm/drm_bridge.h                      |  7 ++++
 include/drm/drm_connector.h                   |  7 ++++
 12 files changed, 64 insertions(+), 33 deletions(-)

=2D-
2.56.0

