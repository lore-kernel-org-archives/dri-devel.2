Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F7C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD3B10EAC3;
	Mon, 14 Sep 2026 01:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="ND65IVUk";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A0610EAC3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1789349627;
 bh=ghstWEaYrkLc9meAEd3pZEEcpwP/9Ch5TtSSwo4LDoE=;
 h=From:To:Subject:Date:Message-Id;
 b=ND65IVUkt0q2DnUcZAnrtzO1CdlvbFe5T6vaTALQ9cYTgYNDYiGkB/XpzaVIurNIC
 aN6am1MsKhW2j1Gwjf3ugicOh2MkgIT8ne7EChA4eLYezXdPIaUcGkUz1qc/nu+JoL
 qXXxJoJbLMzUbw1AHKJ0/pH5bfc8shMuCtZIIws8=
X-QQ-mid: esmtpsz11t1789349626t47bbf22a
X-QQ-Originating-IP: u1upnWTSMY6EsvZnsiIRSULieEWklQzdBeNIg2pbVbc=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 14 Sep 2026 09:33:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8813377110775097573
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
Subject: [PATCH v5 0/3] DSI Controller improvements for Rockchip platforms
Date: Mon, 14 Sep 2026 09:33:28 +0800
Message-Id: <20260914013331.108-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N3p64rE3gZ/YZpxGskmGngMMrgpj8BVnJpWNq4vvp58y0wBAn68/dkgf
 V7p1efZgjAIf63A6SuOQFWLFFKMbU+0ghR04XiGorjxuZMMeqtGG8s2ttCgSHsa6gt3Ry2B
 LbSsL28G2ENjU0PTU8mTA7DLsTGgp+xNKSk4AyhB3EWDxP4Kss2Ia6UUnLXmoD1Wyr/xvvZ
 CfWintxHjG8J6XiLNK8+tZE2mma0DbQR8romTIe8OzhXmu+PAS5CycgrDxT/nWV/nPoZMXD
 +X0AuAj8+KmrKAGInXdE8Mp6OT5f4f9O8jVn/abVD1/QzAzxtN2jVNbn5bBq/kDC9xRUabD
 yVPMMsed0A0A4Ehyy3rLNloX16oiw491LAW+hVRdzXuKVA2d+iCBTo+QOOY6p9gLvML0XvD
 Yd32j6tOT1mBi92tyZkAVvhQGZmvl7SCCm26GY71EG7UNfGIlk4eSSaJPcwqiMze5jSFyvq
 DbORMJ85ti1FrMKr0LFJDFo8QAE8kJVPbJPpi1plJ6HXZn7GTrmJd21EhML60kEH9UnbyyB
 YFE5OurAp+8xp4B3ad4mqmWs/k31fAnMBwxdc9rQfmVRU6rcYIH57QzA/zsxZVoGlNcIjxi
 hi4tz2qmSUF38ZWP/rEYPG3GlDrMluKHLbLV/s0Og/HgYMaTfbxvbUg3XPf87WhbbFFSSPG
 OaOROcM9RpU/DNjHQFZb8aH6ndH+mAUB0yXREkzzx4O+bdQuMyKzXbox9l174RcKQkDysKH
 w9k3Zf36Vt7h9RWZRtlwl7Q3aZHyLHNq+hpjMakDxT2UFlE0PP7gGDlfII7QwyYqQIbwvb/
 uuOZZEYea79xwakns9ottMptl8cjQ/Z0v3KqBBXXzlVzJjH3r25jFWQvuYt+/HKVLaN9QUx
 qYADKNsOeiw+GxjNlClGlM72MYoJh3LCba7tQbihXWk2w3s5HizG2IhFRLq+2Mg1lpC8Vek
 oMtlode338lXex34rCZdqAXcw5VRL9bI8NmVz/F18YMzkhEOXFzh0xG7uhjzO3VlJQjqtu/
 P2SzyL9FwDuZBavBnq7CJMmmSLPuw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

Changes in v5:
- Link to v4: https://lore.kernel.org/all/20260812073002.328-1-kernel@airkyi.com/
- Change the upper bound check for target_mbps from < to <= (sashiko).

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

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 72 +++++++++++++++++--
 1 file changed, 65 insertions(+), 7 deletions(-)

-- 
2.53.0

