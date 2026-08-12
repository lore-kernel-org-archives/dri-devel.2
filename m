Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B82C5B567
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C7F10EE9B;
	Wed, 12 Aug 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="chMLgGF5";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB3810EE9B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786519985;
 bh=0RC7xRrCg2fRyRdaPN4OfoMhKYrQhs7hQgPg17BL6Ko=;
 h=From:To:Subject:Date:Message-Id;
 b=chMLgGF5VPbaa6/ylYfa7/QjJIs6NxmWuT1E4sTUr+WEORdP1kpYKLLuP1hv0125K
 uVKOlCVk92BXQoMcHhIu3wWlVjZxHxJCGIvslASuadkD/fZwNllu1Z8D2GcnJOyPvz
 rQydlCHyiv9wdIkEXadTrSllIivcddskEFdbiHb8=
X-QQ-mid: esmtpsz11t1786519808t4eb45b90
X-QQ-Originating-IP: DgtAwOy9jdG0k6Bs+ZsEkTWYn6YpyP6FVOvGZ4eBsiw=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Aug 2026 15:30:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8909177870970302575
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
Subject: [PATCH v4 0/3] DSI Controller improvements for Rockchip platforms
Date: Wed, 12 Aug 2026 15:29:59 +0800
Message-Id: <20260812073002.328-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OKpRv/MUM8f1AcXuAY/hd7SH4fMdz0zNlrca3Hbr/rs2A43/K/Os1YT+
 qUmSLUK40G9TGR+L5Aalk8QBvT1K7PaI4bAasPfP4LFlCCfladsyI0v6aUJhOQfqBwO1G9X
 KQ5Ifr8aMgVTu4rY2tFf6b8yvUhZ0W7SUjs8d/asNdMbfIvayu7tqRCr/atxCugwoDR6iRN
 TBXor/5qeSFrYbJvCjKYn1AiOw2x6a9s5Qb4RNo0Xf3lxAOVIVpZMdoDW0XhpdVCxhJcq3a
 2OzvbkT49NrXQC47TE4Q8bd+8o/sjmqpWglmNcIthI7R9qS5GWkMtj/Re69sjh4TkeA3hVZ
 Jl2dEWWrcnQaX45imk7d/JaND90HDieKZzFLg82GB+BWiYbRLljbD6ZhcnSBxZW3JlYysI2
 6UcvP1zMqqmMixgk9y8nz7t8ZtDcifbMdiv6qVXA08IYFFrxnZ0HfTbJq4V58MbZfKU/s8t
 gK+e+fI8Rw5sh+Ls98uG3it3ubv+IuQcMTMG/fQnPY1CNQPV9+AFtDUAxtGWmScPo326AUd
 o8gv2DKzg72nXMbZiskuzYTb6id4+8PmZXBEZpdE+GPJ8JEGG+Ltw4qIkj5kiSLFQ3enefJ
 7BeVxBR888Vs02pI3eyyqhACZZH11JJKrUK7PTXzkKY07AAtuPJkVMQNEvgJuLzmT1Bphbu
 maBQZfEDYzl5zPAt9kFVUGFiMVE/+72pqVeh8RxHV7F9vicMzz6hR2L231ho9IOvJEXio49
 EroZo8f5WmZ9vrcdI+wKbZPNROOp4r2ZMc7ApzwGbNOUPRKWxYaVmPh5IcSzhpT25155tqG
 pg2lXgTc+D8UGRksR7IlciobxQOEBtPLn4nNLDQFAh6Uh421mrQ2nK4O5kYYDU1HwtZQcNM
 GAOrv+0JM5rs46ZbK3cj+UyWip9uCVj7h6rA+XDKfbwGr3SdAEQ83HdCLIkPwOGAINvjrIG
 xowzLb5zuBk+ZHK3dZaVPRNhg9Z9EKP4bZQrYVOlOAWm4hedk5TJGbxx6hvpyWkb8UV81k0
 BICJJQTeJhhYuEuJBOveddGDXuEUDkhZJglJWj+94OJOGcODP6
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

Changes in v4:
- Link to v3: https://lore.kernel.org/all/20260810034139.148-1-kernel@airkyi.com/
- Add missing RK3506 timing and the fallback path for get_timing
  (sashiko).
- Fix potential overflow and underflow issues in bandwidth
  calculation(sashiko).

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

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 70 +++++++++++++++++--
 1 file changed, 64 insertions(+), 6 deletions(-)

-- 
2.53.0

