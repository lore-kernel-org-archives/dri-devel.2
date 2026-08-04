Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49736C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC3D10E65E;
	Tue,  4 Aug 2026 07:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="IGEX/we1";
	dkim-atps=neutral
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1CCA10E65E
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:34:59 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785828897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DWMTuq9NkCnrgokFcLH3C7+v8FiIoP6xFMC71YOuo3Y=;
 b=IGEX/we1QDJAsgCIQRHFTugI6JeEnyAKDp6+LNwa6ghbmAFdvduUPZL3I/3lhcGFlwJufh
 5CD8OSL2wmoekN11h15y1hViiMEuh/vieEU87mSvn1zzC2MzII3lVtLCvpcT+fjND/AvOI
 u/ryaZ/YyiBWo35SAqtXEqjTfsvisQQ=
From: Junjie Cao <junjie.cao@linux.dev>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm/panel: Add support for Novatek NT36532 panel
Date: Tue,  4 Aug 2026 00:34:17 -0700
Message-ID: <20260804073419.84727-1-junjie.cao@linux.dev>
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

v2 has been tested on the OnePlus Pad 2: the panel comes up in its
native 3000x2120 mode at 120Hz over dual-DSI in bonded mode with DSC,
and displays a stable image. The only wire-level change in v3 is the
page 0x23 0x51 write going from two bytes to one, matching the stock
firmware DT.

Changes in v3:
- Kconfig: select DRM_DISPLAY_DSC_HELPER, DRM_DISPLAY_HELPER and
  DRM_KMS_HELPER, depend on BACKLIGHT_CLASS_DEVICE.
- Write the page 0x23 dimming table entry 0x51 as a plain one-byte
  write instead of the two-byte DCS brightness helper.
- Spell the page 0x10 brightness write as MIPI_DCS_SET_DISPLAY_BRIGHTNESS
  with an explicit 07 ff payload instead of the byte-swapped 0xff07.
- Drop accidental MIPI_DCS_* macro names from vendor-page register
  writes.
- Make the DSC config const and copy it into the panel instance at
  probe time.
- Support an external backlight via drm_panel_of_backlight().
- Report the panel physical size via the display mode.
- Link to v2: https://lore.kernel.org/all/20260729160804.912826-1-junjie.cao@linux.dev
- Link to v1: https://lore.kernel.org/all/20251001135914.13754-1-caojunjie650@gmail.com

Junjie Cao (2):
  dt-bindings: display: panel: Add Novatek NT36532
  drm/panel: Add Novatek NT36532 panel driver

 .../display/panel/novatek,nt36532.yaml        |  83 ++++
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/panel/Kconfig                 |  14 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36532.c | 431 ++++++++++++++++++
 5 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36532.c


base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
-- 
2.43.0

