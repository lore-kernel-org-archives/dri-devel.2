Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC7606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOxoDlKl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA95B10FAF5;
	Wed, 28 Oct 2026 09:52:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933A910FAF5
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66BC640345;
 Wed, 28 Oct 2026 09:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEFA1F01828;
 Wed, 28 Oct 2026 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181128;
 bh=3oB04lBJ0+savoJSUnl0WM97DLv5mYQXQN1+NfFUXO4=;
 h=From:To:Cc:Subject:Date;
 b=YOxoDlKldFegB9lJ7Nzt/FwZ+4YPGaW+qW335q/MLVtUggiRTt2CMjxw2A8VneomM
 axW1gUO328kek6zU5pBM8tW3NSvznz2huLhyTMDih7HRjedCnUT5OwQA3M4FOGfOw8
 6WcyQXTImXZBxZ4lSCmVyAf3U40zCmrS4ho+zxfZLO97Jr6QWZrCE7GlaYXnnIT+ag
 S0hq5cxpbWp2zNxiPyZ8xdgp06/DOdnT2m0JhNSbQYTv9ZMs68haAIL9r5/ACsuFqb
 IyiO21motDv/r0evr81Qanxat1RcgFstsuqyuiMDR7qYCoKKWxQj5NWrpBXKYafEJ6
 UN/32LLveYu8A==
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
Subject: [PATCH 0/8] drm/panel: novatek-nt36672e: Add SM8450 HDK display card
Date: Wed, 28 Oct 2026 11:51:43 +0200
Message-ID: <20261028095151.1682096-1-vz@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The series extends the NT36672E binding and driver to support the panel
module, and adds a device tree overlay for the SM8450 HDK display card.

The display card for the Qualcomm SM8450 HDK board carries an LCD panel
module based on the Novatek NT36672E display driver IC. Unlike the panel
module, which is supported by the NT36672E panel driver on the QCM6490
IDP board, the display card panel is connected over 3 MIPI C-PHY trios,
has a resolution of 1080x2400, and it runs at 144Hz with Display Stream
Compression, therefore a new panel configuration sequence is needed.

Since MIPI PHY type of the DSI link is fixed by the panel module design,
the driver selects the panel description by the PHY type of the DSI link.

The initialization sequence, the display timings and the DSC parameters
of the display card panel are taken from the Qualcomm display device
tree source for the panel:

  https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-devicetree
  tag DISPLAY.LA.6.0.r12-02500-WAIPIO.QSSI17.0
  display/dsi-panel-nt36672e-fhd-plus-144hz-video-cphy.dtsi

The integrated touchscreen controller of the display card is not
described, since there is no binding or driver support for it yet.

Vladimir Zapolskiy (8):
  dt-bindings: display: panel: novatek,nt36672e: Document the reset GPIO polarity
  dt-bindings: display: panel: novatek,nt36672e: Add bias enable GPIO
  drm/panel: novatek-nt36672e: Make the AVDD and AVEE supplies optional
  drm/panel: novatek-nt36672e: Support the bias enable GPIO
  drm/panel: novatek-nt36672e: Verify the number of D-PHY data lanes
  drm/panel: novatek-nt36672e: Add support of the C-PHY panel module
  arm64: dts: qcom: sm8450-hdk: Add display card overlay
  arm64: dts: qcom: qcm6490-idp: Describe the panel bias enable GPIO

 .../display/panel/novatek,nt36672e.yaml       |  41 +-
 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts      |  17 +-
 .../dts/qcom/sm8450-hdk-display-card.dtso     | 144 +++++
 drivers/gpu/drm/panel/Kconfig                 |   8 +-
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 596 +++++++++++++++++-
 6 files changed, 762 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso


base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.51.0

