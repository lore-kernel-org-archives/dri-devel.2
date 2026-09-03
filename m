Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D56C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C5810F656;
	Thu,  3 Sep 2026 16:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="kvPpxYWX";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E0710F648
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ZS6D3dNfXN/WHHhWf6mBfOo10yYBtRBlMynvNuuKjhk=; b=kvPpxYWXgdKBe382DNY/BvGN8x
 DNlFmCjcaldzhRskNDvW3lWW1aU63ogTZtKR7aFVNgvlIRe3QxCRG5LeWrHe2Lp4nqS0vUjA0gNRE
 oTtS5FKFJI+8bO3sMc/Yu/dP+ajod3lNcOUwNlpaSccHg0xpyOA3s4Rmr3mRnqzdaBvmpV6ZZi7Oe
 rdBaku5uZ1KfTLQf8lgKMd+yJpG1j+i2hCMriN4bZfmrTzJ9+iwPynAwBxKlOfQrtYUEkBgGvZUYP
 KQAKJn8u0wVXYO6S7s6xXDpE1nW2CFJwJTjbWRRZ2XsVER4vZiyzRhNIUmrpnHztm8ZW4YW+iJfHW
 eoC2voKg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/rockchip: Add missing DRM_BRIDGE_CONNECTOR selects
Date: Thu,  3 Sep 2026 18:34:00 +0200
Message-ID: <178845323373.2687836.517588125431937296.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813144019.12089-1-royalnet026@gmail.com>
References: <20260813144019.12089-1-royalnet026@gmail.com>
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


On Thu, 13 Aug 2026 16:40:17 +0200, Igor Paunovic wrote:
> While testing the dw-dp v11 series I noticed that ROCKCHIP_DW_DP does
> not select DRM_BRIDGE_CONNECTOR although dw_dp-rockchip.c calls
> drm_bridge_connector_init(), and Sebastian suggested handling this
> independently of that series [1].
> 
> The ROCKCHIP_DW_DP gap was in fact found before: Marius Dinu posted
> the same one-liner in March [2] and dropped it when the failure
> stopped reproducing in his build. The failure is
> configuration-dependent - any other enabled option that selects
> DRM_BRIDGE_CONNECTOR masks it - so it can come and go with unrelated
> config changes. It still reproduces on current drm-misc-next.
> 
> [...]

Applied, thanks!

[1/2] drm/rockchip: dw_dp: Select DRM_BRIDGE_CONNECTOR
      commit: c83e3e806d4c115f1dad9ef756db4cd91448a262
[2/2] drm/rockchip: rk3066_hdmi: Add missing Kconfig selects
      commit: d72aa5cf045a69d5fd433cde5dd4e113d9558fd1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
