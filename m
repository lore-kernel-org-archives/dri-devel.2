Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072B6C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD0210E5F0;
	Mon, 10 Aug 2026 03:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="eezR/5CX";
	dkim-atps=neutral
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4445410E5F0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786333308;
 bh=Z8AUauJqA+r3pT/B0qrPy70O7l5e8ImJzUTG647LH5c=;
 h=From:To:Subject:Date:Message-Id;
 b=eezR/5CXrl/olfuipUMB1TrDY2J/ryA2zSnXrl92wvmknnonmk224Jep6aCnYEwuz
 LH1tjyv2YYKOWYCAXsqNMlfNCx/9eQTLMFP2pwWQdEB4pDwikaYmbe/LYADo2YrQGF
 eDkgsbwUdwdPMuhvWMWUn1lorIBODXeixyG2r74g=
X-QQ-mid: esmtpgz11t1786333305t01702f6b
X-QQ-Originating-IP: PgJMsdmQ2ZvNvkE+yrtkeVW07WCleVAPDiFefrOZEaU=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 10 Aug 2026 11:41:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3484612477660433064
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v3 0/3] DSI Controller improvements for Rockchip platforms
Date: Mon, 10 Aug 2026 11:41:36 +0800
Message-Id: <20260810034139.148-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ND42uzdxTIzrFGecMR8iHevg5r7qdZi0GrkFF5q/942MN1ALdOxRn22K
 wbd34LlALqR3saLn7pAB8iH48/EB75w2gKZ5piLBRqz3EfYbO8kDPqts3WyDaujBTFm7EF+
 J1jPP7uL8V0icOHjMWQa2OIncBTQjGetjtK4GbslxXAo+yZNKShBt1bUjy9pqbs4cd5IKIG
 g0zyesWYW9H41JnjPkmiFgByYyxnjMRSp1jSUmfhK9qtmiwG2ER+sAAaucDUkw6k/hUpf28
 d0dBhA4oJzMncaUVn4DwcJAsv4qyxBTAsTrcAZlkh6RY+bMh6u1I3/kP4N04BoI4zKTsrEo
 S5dQnBOD1HKR57sAX0OQONL6NHbLqBZmf1ChroELG6Do/n0VxDqRmID6bb57fZJmBKU/U30
 C+wUIisKZ8Uqkos29eviAn62+lzXKirJVAJBlk2TRNW7xXIdRMecn/sjM2h19b2FxmtZz6K
 Su5p6AmGRg9bjICioB9lZMsroDkoTBejKFndsVlZYh28TPlR10fjfZCGKasB79UwFijjLZr
 dhSfy4Cd8S9Yg8l05uNu38NIw1iiAjK/nvZZbiiX3FaqNkMTL3n6NbNPikTLVQTIEUJ3oWF
 ri0jS+FCuJuw8DDWCWX0cuGTpnTXcP98/FdFfilMDOvKRx04YMPOYN4On/9xcmZ397f4Ras
 jgW/g6hvxC+QfptMbxI1x4Ftu9j6noFFjzpyPNfbl3ArypBpZ5znbOUxSm682UBybViR9Sl
 lfi6uHZJ+RTvnlAk6eHboQaIyfpDJLhA7FTPmYfmseHEByvTE8wlJ4491CdqkopPHdyKMga
 mwd61pUYclLuMGNyIEJ+PJSsT65I8dG8a3LMIBUCv63okvP1XsMIlqbjEecNN/JvUEdioHi
 dfrfdpydlzqT+3jINGyPV6bOSgW3HeCZMi+yN2bpqjt1QAtjUVt9fEx3xcp3EFh+dQI+6W+
 k2bkcLid/3iVC/9vhzKSYQpwChJON9ev5MCSFoWvf/7Do+wQ+17HEWcdW2H5S6v1NtrhqAp
 g3mny8RKub4/vuvayn
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This series is dedicated to enhancing the DSI controller and PHY timing
interaction, refining the lane rate calculation, and addressing the
associated hardware limitations.

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20260603033532.164-1-kernel@airkyi.com/
- Rebase to Linux v7.2

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20260324085838.90-1-kernel@airkyi.com/
- Fix the unit conversion for max_mbps.
- Split the lane rate calculation into a separate patch.
- Add more comment about timing config.

Chaoyi Chen (3):
  drm/rockchip: dsi: Add maximum per lane bit rate calculation
  drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types
  drm/rockchip: dsi: Relax the lane rate margin requirements

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 66 +++++++++++++++++--
 1 file changed, 60 insertions(+), 6 deletions(-)

--
2.53.0

