Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52FBCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BCC10E5F2;
	Mon, 12 Oct 2026 16:05:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4ACE10E5F2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ZI1jrhehYU+RLKzgYORjc8QBBzD771a1CdXAHNaSzhg=; b=z6bRrKRKJWtCYbq8O15zAVKj2D
 bBzZr2i0KPOh74I4rQGdau7VTdAKbFhVeChAGUfakuuH16JYr91BIvvM2DR8J5GTsNfTmOADDDUxf
 gSoyRlC/x31Z4YlNZF5zkwo55heQMtbGri91zlsdtqFHHohb+H9DxwCDSKr6LDuUCTXSZfauun/tz
 NrO/lXE2WYRRkEAAhCYmJkoGjtPR5hOBGyZDTq5cfSZ+MeN5U9LIoWoSrQ37zsIatc5ItLcALCsSm
 JbN9AMSF08rKqA3DshjDy6cC4kBWFUfdh/eTx9n1MZZ2KPNuYZ72C+gPT77kQZbxoDI5Mp78yAqb9
 DNXK2IKQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>,
 =?UTF-8?q?Robin=20R=C3=A4ber?= <robin.raebi@gmail.com>,
 Igor Paunovic <royalnet026@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v12 00/16] Add HDMI 2.0 support to DW HDMI QP TX
Date: Mon, 12 Oct 2026 18:05:01 +0200
Message-ID: <179182109533.3793653.8971698569867906952.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005-dw-hdmi-qp-scramb-v12-0-195157ba0b40@collabora.com>
References: <20261005-dw-hdmi-qp-scramb-v12-0-195157ba0b40@collabora.com>
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


On Mon, 05 Oct 2026 03:38:01 +0300, Cristian Ciocaltea wrote:
> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
> TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by making use
> of the scrambler infrastructure introduced recently in the DRM core and
> HDMI display helpers.
> 
> The first group of patches wires up the SCDC scrambling feature itself
> in the DW HDMI QP bridge driver, while improving i2c fault handling,
> and providing enable/disable HPD PHY ops and a HPD notify helper.
> 
> [...]

Applied, thanks!

[01/16] drm/bridge: dw-hdmi-qp: Demote i2c bus error messages to debug level
        commit: 7de65917d29cc0747bdbd5f30ad2f8a3d0a236b9
[02/16] drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops
        commit: 23594060f8019e400c55abe4b982f4ddfbb06471
[03/16] drm/bridge: dw-hdmi-qp: Remove unused workqueue include and define
        commit: 994452efe9c7871d7a6de8c31ba6e5a2c9733e99
[04/16] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling support
        commit: 046dbe428a69e0e2a8d09ac7de75ebc9bd469a46
[05/16] drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
        commit: a58efc1aa0bb67abe1946be72a1c67d17d78aadf
[06/16] drm/rockchip: dw_hdmi_qp: Fix invalid drvdata access in PM ops
        commit: b6e19848c9db535d81d6db85c7cc1324e6611791
[07/16] drm/rockchip: dw_hdmi_qp: Cancel pending HPD work on suspend
        commit: 5d0aa771a5308f6a6c83eeaa89351a472ae580c3
[08/16] drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
        commit: 7554a1cb23148a3ab0b74c7edd47356c26b40ead
[09/16] drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
        commit: 1fe516676a1ca0678b27408f7b5f91b4e9f5bbc9
[10/16] drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
        commit: 8bba3185c107b6bb6d59a1fb0c516e24dd90dee4
[11/16] drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
        commit: 383fad9dac0c136334cf257fa1a1ce5180e08740
[12/16] drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops
        commit: 40e100d4af8f29df7ddc7e867412bf81836fb32c
[13/16] drm/rockchip: dw_hdmi_qp: Factor out HPD interrupt (un)mask helpers
        commit: b0d607d0c35b206b3ec0497dedbd0fa48f108144
[14/16] drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge HPD ops
        commit: 91f92a7487c4efef52b13bc864f5c16858791ba4
[15/16] drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD reports
        commit: bba9ac0a9047f3df5d5160140785c1d885debb06
[16/16] drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
        commit: fc9370d7b1c927f5a7f20e1251b8ee7bc0698954

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
