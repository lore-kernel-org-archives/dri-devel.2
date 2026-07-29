Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0802EC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFD210ECCD;
	Wed, 29 Jul 2026 16:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="k2byokiX";
	dkim-atps=neutral
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB68510ECCD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:08:33 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785341311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q20EbqiUoUh++CZnYOPasINTNNTzimjQmZPWgue2as0=;
 b=k2byokiXDa6k6qo8BdZQcJhgAJFi+V27i2vLGjIysGB+PjEXSNrOTE4I1qJ+nSUmgbXEu5
 pcHavBb2jOixIJU5/A2jZSHo6H1hAFvsnG/kGz9oWuXwVOwoXGpaLci1NywFCVeBJLSS7S
 rqQHhJ1PsC0utD7rIx8uiaJGDEH0G4U=
From: Junjie Cao <junjie.cao@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Junjie Cao <junjie.cao@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/panel: Add support for Novatek NT36532 panel
Date: Wed, 29 Jul 2026 09:08:02 -0700
Message-ID: <20260729160804.912826-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

This series adds support for panels using the Novatek NT36532 Display
Driver IC, a dual-DSI, dual-DSC controller that requires DPU support
for MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT.

The first user is the CSOT PPC100HB1-1 panel found in the OnePlus Pad 2
(OnePlus Pad Pro in China) tablet: 3000x2120, dual-DSI in bonded mode,
DSC 1.2 with two slices per line.

This has been tested on the OnePlus Pad 2: the panel comes up in its
native 3000x2120 mode at 120Hz over dual-DSI in bonded mode with DSC,
and displays a stable image.

Changes in v2:
- Rebase onto next-20260727.
- Update to the new DRM APIs: devm_drm_panel_alloc(), devm_drm_panel_add().
- Drop the driver-private 'dsc_slice_per_pkt' plumbing and rely on
  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT instead.
- Send DCS commands through the second DSI link in dual-DSI mode.
- Change the refresh rate control register 0xb3 value from 0x41 to 0x40.
- Drop the of_node assignment when registering the secondary DSI device,
  matching panel-novatek-nt36523.
- Update author email to junjie.cao@linux.dev.
- Pick up Conor's Acked-by on the binding.
- Link to v1: https://lore.kernel.org/all/20251001135914.13754-1-caojunjie650@gmail.com

Junjie Cao (2):
  dt-bindings: display: panel: Add Novatek NT36532
  drm/panel: Add Novatek NT36532 panel driver

 .../display/panel/novatek,nt36532.yaml        |  83 ++++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36532.c | 430 ++++++++++++++++++
 5 files changed, 531 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c


base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
-- 
2.43.0

