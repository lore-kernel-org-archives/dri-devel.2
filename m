Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49902606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlOzYjzI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551A610E2C9;
	Thu, 26 Nov 2026 13:45:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D37E10E332
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:45:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 552F663365;
 Thu, 26 Nov 2026 13:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8A51F000E1;
 Thu, 26 Nov 2026 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700739;
 bh=TLZ4d9dW8ftPcSnmX1XbcRcgRVW38uBL8vxAl2/zy7E=;
 h=From:To:Cc:Subject:Date;
 b=GlOzYjzIERLYvGQNL7hNqMhT85HT1Gj1cu9vrTZV/lz7xTj0DbZAMHOMTQBFfhVyY
 wueN8CYlwNy2FDq6/zFGDPWG9X/D6xgl7Q8+0JVO///4dzUdc90knaaak88ki0wadF
 J0BsYxzLgm0J47i878fsCN1EYUVdEmOFz2Ox4yrOc//dIXjexdOgf769X6MIUIskwJ
 5WZvDCMg4PirD5LQzSfrlnWZeyXOzeDu6yvBd+4/QcJj7cwkw4O/i267JpzE5NzbBx
 +zn5BzvwQmXCCPWWIJaxZj/d+HMhyiKgLs0LjlYCXvnK8MdbWhrPGgquQ6oowMsfCB
 qRurhISInW6zQ==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 00/10] drm/panel: novatek-nt36672e: Add SM8450 HDK display
 card
Date: Thu, 26 Nov 2026 15:44:58 +0200
Message-ID: <20261126134508.320700-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The series extends the NT36672E binding and driver to support the panel
module, and adds a device tree overlay for the SM8450 HDK display card.

The display card for the Qualcomm SM8450 HDK board carries an LCD panel
module based on the Novatek NT36672E display driver IC. Unlike the panel
module, which is supported by the NT36672E panel driver on the QCM6490
IDP board, the display card panel is connected over 3 MIPI C-PHY lanes,
has a resolution of 1080x2400, and it runs at 144Hz with Display Stream
Compression, therefore a new panel configuration sequence is needed.

The initialization sequence, the display timings and the DSC parameters
of the display card panel are taken from the Qualcomm display device
tree source for the panel:

  https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-devicetree
  tag DISPLAY.LA.6.0.r12-02500-WAIPIO.QSSI17.0
  display/dsi-panel-nt36672e-fhd-plus-144hz-video-cphy.dtsi

The integrated touchscreen controller of the display card is not
described, since there is no binding or driver support for it yet.

Changes from v1 to v2:
- updated the dt example instead of adding reset-gpios documentation,
  and the GPIO polarity is now corrected by added gpiolib-of quirk,
- moved allOf to the end of the binding (Krzysztof),
- reworded the C-PHY link description in the overlay commit (Konrad),
- rebased on next-20261125, and collected the gained tags.

Link to v1:
- https://lore.kernel.org/all/20261028095151.1682096-1-vz@kernel.org/

Vladimir Zapolskiy (10):
  dt-bindings: display: panel: novatek,nt36672e: Describe the reset GPIO as active low
  dt-bindings: display: panel: novatek,nt36672e: Add bias enable GPIO
  drm/panel: novatek-nt36672e: Fix the reset GPIO polarity
  drm/panel: novatek-nt36672e: Make the AVDD and AVEE supplies optional
  drm/panel: novatek-nt36672e: Support the bias enable GPIO
  drm/panel: novatek-nt36672e: Verify the number of D-PHY data lanes
  drm/panel: novatek-nt36672e: Add support of the C-PHY panel module
  arm64: dts: qcom: sm8450-hdk: Add display card overlay
  arm64: dts: qcom: qcm6490-idp: Fix the panel reset GPIO polarity
  arm64: dts: qcom: qcm6490-idp: Describe the panel bias enable GPIO

 .../display/panel/novatek,nt36672e.yaml       |  40 +-
 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  19 +-
 .../dts/qcom/sm8450-hdk-display-card.dtso     | 144 +++++
 drivers/gpio/gpiolib-of.c                     |   9 +
 drivers/gpu/drm/panel/Kconfig                 |   8 +-
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 604 +++++++++++++++++-
 7 files changed, 772 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso

-- 
2.51.0

