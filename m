Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B142CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063DA10F80D;
	Wed,  3 Jun 2026 03:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="K3cQ0muO";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C2110F80D
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1780457742;
 bh=MuJLtYdtHWKaqd46ljA3SGhtc0u+suGv8rl/EcC4vg8=;
 h=From:To:Subject:Date:Message-Id;
 b=K3cQ0muORXeRzDUjJAklwiu/B/9TvmYbwjOxlOEK06KuSFgFob2m8aOTCvdZbdDPo
 pxBbb6BpaOS9nxGVUHltY3BRBVkwQeduOpc4VXOaChDMxto5/J7JofDMZySEirmoMp
 Srxw8/8n1HJnOwNjSXQ5h50eYcMVgMYGd6+Efg68=
X-QQ-mid: zesmtpsz3t1780457740t290e62f8
X-QQ-Originating-IP: CzBw4Y9AFqPGcBi+9pnSIOAZiI3fSc2fRqSUVrQ4w0Q=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 03 Jun 2026 11:35:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16903120165726575849
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Guochun Huang <hero.huang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v2 0/3] DSI Controller improvements for Rockchip platforms
Date: Wed,  3 Jun 2026 11:35:29 +0800
Message-Id: <20260603033532.164-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPXUn7REqwKFYd3so+pwkePaCYgrPWDg6vuu+MG6DV2r6R
 TEi0Vi8ilW7vrbmLAEIF5Z0MHaK841xPQHN8KBpV2XkhoizoAXezOY/eRF5oyZJD5Tq184j
 5L3sIdYgNR9Ie1Ov/t0ih0sVwanhvT4lrOFqilPL58RzlkPBjF/7lCJQldKp/OEoH5T/DDi
 bJPel0cq0fPwwXZFMhPqyukSUky5IoUTlOS0Dh4/0SNDVVKuIkHD0qAr9ZNELCe/VAr+898
 wnD18snZeoyCQiTVDcH7XFxd57MydlcpZ7Uqnsy6sMWq9qUDlBTJ6LDltnVsCmStD09gq54
 bg/fSJTLVhNv5NAvshPMAWL1o5MaISI6Q8LFi6D+P1QAgug0wVZEDZ7UCehEFB+hPqGl/Jw
 eDLe+S8370hkwNx+t+pJIwio3sL630yOIObenaRPAcJnBfyqiAJGts6FEHcntg68h4j5R4K
 Q6x+QrLKjBoTRxV9UFOtCShELZHNAzo8qAUvf8VTrpE37k7/Jb5kVsaJPZVD7PqHk+AleVP
 Hq1IexyvLARMq39/XoSy3F9Cr1Inu+bJ6kkpLsJFbh2rg8VBx4kJJlrf2DHML1mEF/0kEiS
 KIx7SG9E6DqHUe7zSoB2dyFBHPny5nM1whBwi4aJmnbtAUQsZQdahRabr7Wte842KxVN4Or
 P+oOb3WkD2r7RtXaLZebqJucsYXPwGR3LOsgV1WXdice/V0JsvNC6WQAd02yQ9T+hzUusw9
 TdNBfY9ZVKXrEMXx83tS0tMh60aJ149G4juXrT2pyid7q9/lR84EHMUV+dqx8LoNphLvIb9
 4Gr4BNEdHQrwUP1m9MLaPriizE0CFd+nLN13murEO5IHXYieeLM+OBUNoUy/+Tj9JVECz39
 yIYLk95jPp/vUON1tYxcYPn2qTwZyZRkj+WAbocGj96O3KZZObTK8ue5SLamJS0IjNpE0Xi
 ZT9SVparm1BqgiGD/rx0/HnjP5cQTYKax3lRoFfUX9uXMBTi0O3bvoTDM0IcKenAEuxlwIz
 s1w1mnEh2AHnxOdxqWHbp2DGFrPlQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

