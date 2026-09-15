Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D36C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C00C10F135;
	Tue, 15 Sep 2026 16:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="FqxOKnW4";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D948F10F135
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=+P/aelEmT5OmZhL5uaEKQ81rGaiX1if48juBRP3e/OU=; b=FqxOKnW4UAtlz/+j9rCK4PvGx4
 Q1oIU4etLxxljXppJ94pMP5Yr2dFkPBv7DH2Q23GAdMuV4/ZX05Gs4jv+tH/W2PHAw0VABoqTNZTQ
 T/ImrUc3hoC/laWHvX60W7bUD5QJPtq5zroPQWeiNWlHehdl/C4ZTL10ZcV1B8u11aMTG4OUJ0fjP
 1oQWN2A3dy7ZIOV1ffZc3u03gEYr9ajoc5O6BsJOQzL1t/HgGXjCuhG6RO2uBD70mhnwbVPwTct3L
 lhUKXEUD8raQCUfBk1eJ9F3aZg1QRhlPI8r57aorNhRkh7MXc/uU7iGAIsaiqwp/mWWSLxVS+giSN
 nAEmmHfA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chaoyi Chen <kernel@airkyi.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: (subset) [PATCH v5 0/3] DSI Controller improvements for Rockchip
 platforms
Date: Tue, 15 Sep 2026 18:39:17 +0200
Message-ID: <178949035407.582306.14026680120994991425.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914013331.108-1-kernel@airkyi.com>
References: <20260914013331.108-1-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 14 Sep 2026 09:33:28 +0800, Chaoyi Chen wrote:
> This series is dedicated to enhancing the DSI controller and PHY timing
> interaction, refining the lane rate calculation, and addressing the
> associated hardware limitations.
> 
> Changes in v5:
> - Link to v4: https://lore.kernel.org/all/20260812073002.328-1-kernel@airkyi.com/
> - Change the upper bound check for target_mbps from < to <= (sashiko).
> 
> [...]

Applied, thanks!

[1/3] drm/rockchip: dsi: Add maximum per lane bit rate calculation
      commit: 3c58af05953af5ab120e2c9061d7bdedde0d1bfd
[2/3] drm/rockchip: dsi: Add dphy_get_timing support for multiple PHY types
      commit: 5363e01e4ff03a204cab85292b89cf90c2d1b101

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
