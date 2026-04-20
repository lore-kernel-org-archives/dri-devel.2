Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A77F327B7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4464010EB8D;
	Tue, 21 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="Ij6BttJg";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Mon, 20 Apr 2026 02:39:07 UTC
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC8410E10C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1776652745; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=TzUGLYacwsKCVW9G/6aJQu90u36lBCxZ6anY27Su7b8=;
 b=Ij6BttJgfROVuMEUWCfweN/gmO6SzGWMBW2vCSjfDXvl0y5+lrFhRiEYKXHlKWvJkkIUCc9pTBbzBXuFJvT6yfQPf/mB+EJ8ozMImuUi4a7oDE7bGdVM5ub9z8SdtfyKT7n5a9Q4iUdLrjYthXnsizAdUl+MfAKPCV/dhTQEwNnrcA+ti/kLQAwkeXjXOe5qfvu8GQkufXSqYo3ST1cDUXjJSuNmhb3l7OnXHohnpCtJQ00nwEGQO6sU9xET0yJfdgnNWNT+zlH98ku3MUHqzOt0E4EjIxj7GpMi9HUfBFsNuXmYldCITyAJNnbgm/5t2Txv5GDq0QgONLRylkY9xA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.185872|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0215629-0.00143445-0.977003;
 FP=12486424288784215529|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam011083013073; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=19; RT=19; SR=0; TI=SMTPD_---.hFmvE13_1776652440; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hFmvE13_1776652440 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 20 Apr 2026 10:34:01 +0800
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
Subject: [PATCH 0/2] Add LT7911EXC edp to mipi bridge driver
Date: Mon, 20 Apr 2026 10:33:52 +0800
Message-Id: <20260420023354.1192642-1-syyang@lontium.com>
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

This patch series adds support for the LT7911EXC edp to mipi
bidge chip.

The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
and output signal/dual port mipi. This series introduces:

- A device tree binding YAML file describing the hardware
- A new DRM bridge driver implementing the basic functionality 

Signed-off-by: Sunyun Yang<syyang@lontium.com>
---
Sunyun Yang (2):
  dt-bindings:bridge Add LT7911EXC binding
  drm/bridge: Add LT7911EXC edp to mipi bridge driver

 .../display/bridge/lontium,lt7911exc.yaml     |  91 +++
 drivers/gpu/drm/bridge/Kconfig                |  18 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 571 ++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c

-- 
2.34.1

