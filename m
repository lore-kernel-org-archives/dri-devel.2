Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FEFF327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60B710E805;
	Tue, 21 Apr 2026 07:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="quLWxoWR";
	dkim-atps=neutral
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D444410E0DC
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1776665808; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=joljCzzpQ3BWVjBWEzq/YmymQ3S+YGNeTfY7syNIJMk=;
 b=quLWxoWRwvPmXytI8ylnUE9j2FRkcmBEyrNHWzTa3sOmMP9r+NkgSDQdWPqIflOa2xBQxgXcoURP8td2fT9zkEWAZlDqG5TxJCQ/SqlSxKEJg1iwYkoh6+evt+pvou84EZ4MnWmfZpS4VxO8tddXa573xlR/Fqa5qdYX/SfTJwPirpK/cz2x7QHSOPWl6Q3V3mypHN8SC7PUI8ZwrUk04EULFxN+FJJxOcvuTXXzeIF2mBQungCM6q0CO0cJsWAv3OBbm5HnGMa/JLh20JbtSRlN886c7BNMfL+Tq0giw2pxDqVoR6Cxn/iVNZQuW5Ym2+zd/PgqO42qhP3vvnsWOw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08217578|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00760056-0.000148186-0.992251;
 FP=3247150432297668347|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033032053168;
 MF=syyang@lontium.com; NM=1; PH=DS; RN=19; RT=19; SR=0;
 TI=SMTPD_---.hFz0LsH_1776665805; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hFz0LsH_1776665805 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 20 Apr 2026 14:16:46 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v3 0/2] Add LT9611C(EX/UXD) DRM bridge driver and device tree
Date: Mon, 20 Apr 2026 14:16:42 +0800
Message-Id: <20260420061644.1251070-1-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

This series adds support for the Lontium LT9611C(EX/UXD) MIPI DSI to HDMI 
chip:

-dt-bindings: bridge: This patch adds new content to the lontium,lt9611.yaml
 binding file.
-drm/bridge: This patch add new DRM bridge driver for LT9611C(EX/UXD) chip.

Signed-off-by: Sunyun Yang<syyang@lontium.com>
---
Changes in v3:
-dt-binding:
 1. lt9611c(ex/uxd) content merged into lontium,lt9611.yaml
-drm/bridge:
 1. Drop the licence text, only use SPDX header
 2. Sort the headers
 3. Use library functions for crc8
 4. Drop i2c_read_byte and i2c_write_byte
 5. Lowercase all hex values
 6. Use paged writes as implemented for LT9611C(EX/UXD)
 7. Drop dev_info, use dev_dbg
 8. Modify lt9611c_get_edid_block, don't store EDID in the long-term structures
 9. Use HDMI audio helpers.
 10.Remove unnecessary flags,Implement proper cleanup path, unwinding resources 
    one by one.
 11.Replace devm_kzalloc with devm_drm_bridge_alloc.
 12.Remove extra kthread.
-Link to v1: https://lore.kernel.org/lkml/20250903123825.1721443-1-syyang@lontium.com/

Changes in v2:
 1. Forget modify code, operation error, Please disregard this submit.

Changes in v1:
-dt-binding:
 1. Submit the first version of the code.
-drm/bridge:
 1. Submit the first version of the code.

---
Sunyun Yang (2):
  dt-bindings: bridge: This patch adds new content to the
    lontium,lt9611.yaml binding file
  drm/bridge: This patch add new DRM bridge driver for LT9611C chip

 .../display/bridge/lontium,lt9611.yaml        |    8 +-
 drivers/gpu/drm/bridge/Kconfig                |   18 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1365 +++++++++++++++++
 4 files changed, 1390 insertions(+), 2 deletions(-)
 create mode 100755 drivers/gpu/drm/bridge/lontium-lt9611c.c

-- 
2.34.1

