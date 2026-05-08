Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711CCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E1A10E31C;
	Fri,  8 May 2026 13:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="KFLcNgSe";
	dkim-atps=neutral
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com
 [115.124.28.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0784110E31C
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778248031; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=plRzfbW8Qws5ho7KRsBfti1sG4WFDyy3YZ+bQe0Yb2U=;
 b=KFLcNgSeA8yo+eumx7ifP6zvvlck2tSc4D2UcUPwihVh3lBXfesl3CH69m++Qj2SOa/MQHZf7MMavDQtt9POUmalTUZMDDev/mLmXuLG33OpJlBLNDChBH3rq8/6Bbh3toiCxbXpIcseOVvLfe7bcmFb+zvxUlfG3YresoWFYPXPjmsSj0fhxjgdqCTmv7d5WCvh28d4p21qME4bKwxkZ2V/qXYG3X3SCk5bANWagjzgH2V1XIs4FTh1Dg1tfJATZlUdvEKQdrv96tyt0EH6PqEqP/m+M6265jmTfVyFVx0NVoLBJKUDl0LkgTg2CDjTI/RKV22I91q8sKmGgJ+lVA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.100362|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00363759-8.50324e-05-0.996277;
 FP=7802761490420370552|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037006180;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=22; RT=22; SR=0;
 TI=SMTPD_---.hSic0zK_1778248029; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hSic0zK_1778248029 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 08 May 2026 21:47:10 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v6 0/2] Add Lontium LT7911EXC eDP to MIPI DSI bridge
Date: Fri,  8 May 2026 21:47:00 +0800
Message-Id: <20260508134702.4713-1-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
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

From: Sunyun Yang <syyang@lontium.com>

The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
and output signal/dual port mipi dsi. This series introduces:

- A device tree binding YAML file describing the hardware
- A new DRM bridge driver implementing the basic functionality

Signed-off-by: Sunyun Yang<syyang@lontium.com>
---
Change in v6:
- dt-binding:
- drm/bridge:
 1. use #define FW_FILE  "Lontium/lt7911exc_fw.bin" to match linux-firmware
- Link to v5: https://lore.kernel.org/lkml/20260506013153.2240-1-syyang@lontium.com/

Change in v5:
- dt-binding:
- drm/bridge:
 1. Change "mipi" to "mipi dsi" in the commit message.     [Dmitry]
 2. Change "eDP/MIPI" to "eDP/MIPI DSI" in Kconfig.
- Link to v4: https://lore.kernel.org/lkml/20260430094612.3408174-1-syyang@lontium.com/

Change in v4:
- dt-binding:
 1. Fix the missing spaces on the "subject".             [Krzysztof]
 2. Fix the error descriptions for port@0 and port@1.
- drm/bridge:
- Link to v3: https://lore.kernel.org/lkml/20260429040541.3404116-1-syyang@lontium.com/

Change in v3:
- dt-binding:
- drm/bridge:
 1. already submit lt7911exc_fw.bin to linux-firmware.  [Dmitry]
 2. remove lt7911exc_remove function.
 3. drop  the "lontium, "  in lt7911exc_i2c_table.
- Link to v2: https://lore.kernel.org/lkml/20260428063224.3316655-1-syyang@lontium.com/

Change in v2:
- dt-binding:
 1. reset pins use active low.                        [Dmitry]
- drm/bridge:
 1. use atomic_* callbacks.                           [Quentin]
 2. fix the incorrect formatting and spaces.
 3. add the required header files.                    [Dmitry]
 4. remove "enabled" flag.
 5. remove *fw from the lt7911exc struct.
 6. .max_register and .range_max use actual range.
 7. regulator use bulk interface.
 8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
 9. Replace GPL v2 with GPL.
- Link to v1: https://lore.kernel.org/lkml/20260420023354.1192642-1-syyang@lontium.com/
---
Sunyun Yang (2):
  dt-bindings: bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge
  drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI bridge

 .../display/bridge/lontium,lt7911exc.yaml     |  89 ++++
 drivers/gpu/drm/bridge/Kconfig                |  13 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 493 ++++++++++++++++++
 4 files changed, 596 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c

-- 
2.34.1

