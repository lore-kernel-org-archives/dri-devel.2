Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84626C44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B5F10E6D8;
	Mon, 20 Jul 2026 07:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kanardia.eu header.i=@kanardia.eu header.b="NXKA3jgR";
	dkim-atps=neutral
Received: from th8-a.mail-neoserv.si (th8-a.mail-neoserv.si [152.89.234.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317D110E46B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:24:15 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=th8.neoserv.si; s=default;
 b=KnzdM5OTAdp2nblLegGWLGxOeK+ZLESK6NboOb3ZY4KbGoXemHbCigwccuZB5aZuYi4gUBV+9H
 jcNHrcVnbohby/GRSmzx1hdqAnP+FSEVXAdOtOrEf42hAEmSV5XpO7WijGCW2vhP0Hac4wpldt
 en682BVAA6N4ueUcZ3ZCHNleXjlvBgUqp1qDc89HS7qLmMD+HEJxeOuR4M1OzBbLP4g63qYK7c
 L8V15y4hxAlixbDMbdphOIOjEpIaZGE7xvGLb/06fRQs9iwqyugcYZCTJ4UFWniWKOmw/OCWTY
 uVJUL4XdWeY0+m7wUVJScDZfwRmZpWBiJ3KMLM5DU4dpnQ==;
ARC-Authentication-Results: i=1; th8.neoserv.si; smtp.remote-ip=193.77.36.193; 
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=th8.neoserv.si;
 s=default; 
 bh=cywopztlmsH3bzb+KTbHm/bcWFeOvPEllhWETG5l2RU=;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
 DKIM-Signature;
 b=hM0v7yzTvqgbPJwwA7eb/y7/aRysNqC/dHl3n/nIx/yo2PwkC5IyBPoYubh5m6S1C1b/KN0vDt
 C1IFMbjXj9uG2Y0VnIjIfVC1wgqIbIgmDDsS3CPzfTynFkNiHN8tmOgtFgPyMAkDv9aXPABFn+
 RveLXqX4ji8tYl9C9er5w2gHh4h0Q5dgDU9Qzm/QpsiC04j93I8ehwCAvlAmuqpY+Gice2yTtK
 44nY7FyVHaOwdHoHWSAOFiBety5lHNQ7+tPyv899EWAgQJafZR5pk9Q95Xs1DJnm6nbeKwUt17
 YKGeowVHkHEe7N//Mq59u827suqveVaY/wHBFi/+79sW8g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kanardia.eu
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
 :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/OdiQBG0eSiBQF/w1VtyCXmttmza1oadKodigBgFYN8=; b=NXKA3jgR2nIE8Xb1UC/yjfa/3J
 Iir5+W/Bu6CCdb0hqHF4PsTL6H7CfloIMa61O2ZHzUrfIa/bKFYWi/j8GZ/Aa0swmMX1rkQttrkmT
 fvH3B2RAZrXQDkkstlQEtN/OLZIuTFXVkn9Z0fSr6ian/rkMElfbljuAQyhO4oofDSLcsrHmhVuU/
 1mrYLYeo7WDAmEfctQZokz18ihN9mdzhVmjx05hGL42mz5RmTbV9SQLj1WW4s5EuFtyf+sxnP0xUC
 ItMbgjq0ZxiFJWSUhuMPz+xPwa/OzXcztO9nTDlWOc7yHovyDKeFu3wEA5iOk30+DswUuA585KWQr
 a057v8nA==;
Received: from [193.77.36.193] (port=54788 helo=rok-trip.kanardia.eu)
 by th8.neoserv.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <rok@kanardia.eu>)
 id 1wkhGi-00000001fP1-1J7i; Fri, 17 Jul 2026 14:02:16 +0200
From: Rok Markovic <rok@kanardia.eu>
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>,
 Rok Markovic <rok@kanardia.eu>
Subject: [PATCH 0/4] drm/rockchip: add RK3568 LVDS support
Date: Fri, 17 Jul 2026 14:00:01 +0200
Message-ID: <20260717120005.2087386-1-rok@kanardia.eu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: th8.neoserv.si;
 auth=pass (PLAIN) smtp.auth=rok@kanardia.eu
X-NEOSERV-MailScanner-Information: Please contact the ISP for more information
X-NEOSERV-MailScanner-ID: 1wkhGi-00000001fP1-1J7i
X-NEOSERV-MailScanner: Found to be clean
X-NEOSERV-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=1.31, required 7, ALL_TRUSTED -1.00, BAYES_50 0.80,
 KAM_DMARC_QUARANTINE 1.50, KAM_DMARC_STATUS 0.01)
X-NEOSERV-MailScanner-SpamScore: s
X-NEOSERV-MailScanner-From: rok@kanardia.eu
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - th8.neoserv.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanardia.eu
X-Get-Message-Sender-Via: th8.neoserv.si: authenticated_id: rok@kanardia.eu
X-Authenticated-Sender: th8.neoserv.si: rok@kanardia.eu
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

RK3568 has a native LVDS transmitter that mainline does not support:
rockchip_lvds.c only binds rk3288 and px30. This series adds it.

The transmitter has no register block of its own. It is programmed
entirely through the GRF and re-uses the MIPI DSI0 D-PHY in
PHY_MODE_LVDS, which phy-rockchip-inno-dsidphy already supports. So the
DT node is reg-less and carries a phy reference, like px30, but unlike
px30 it also takes a pclk (PCLK_DSITX_0, borrowed from the DSI
controller the D-PHY belongs to).

Patch 1 is an independent fix: rockchip_lvds_encoder_atomic_check()
never copied the connector's bus_flags into the CRTC state, so a panel's
pixelclk-active could not reach the hardware at all. It is a no-op for
the SoCs supported today - rk3288 and px30 pair with the VOP1 driver,
which never reads bus_flags; only VOP2 consumes it - and becomes live
with patch 3.

Patches 2-4 add the binding, the driver and the SoC DT node. No existing
code paths are modified: patch 3 only adds rk3568 functions, and every
rk3288/px30 function is left byte-identical.

The driver work is based on Alibek Omarov's 2023 posting [1], which was
never merged. The changes on top of it are described in patch 3's
changelog. The important one: phy_power_on() must be called from the
encoder enable path, not from probe. Called at probe it runs the phy's
LVDS bring-up - PLL power-on, settle, mode select, serializer reset
pulse, lane enables - while the GRF has not yet switched the block to
LVDS mode and the VOP is not driving dclk. The serializer is clocked
from dclk and latches dead coming out of that reset. The failure mode is
nasty: every register in the phy, the GRF and the VOP reads back
byte-identical to a working system while the lanes sit at common mode
and never toggle.

[1] https://lore.kernel.org/all/20230119184807.171132-1-a1ba.omarov@gmail.com/

Not covered: LVDS1 / dual-channel. The GRF bits exist (VO_CON3) but I
have no hardware for it, so only LVDS0 is wired up.

One integration note for anyone using this: VOP2 spreads its windows
only over video ports that have a connected endpoint, and writes
cumulative layer boundaries into OVL_PORT_SEL. If LVDS is put on vp2
while vp1 has no endpoint, the boundaries come out non-monotonic
(PORT0=2, PORT1=8, PORT2=5) and no window ever reaches vp2. Putting LVDS
on vp1 avoids it. That looks like a separate VOP2 bug and is not
addressed here.

Testing
-------

Tested on two RK3568 boards:

  - MYIR MYD-LR3568X eval board, 1024x600 LVDS panel at 59.4 MHz
  - Kanardia Nesis V (custom board, MYIR MY3568 SOM), 1280x800 at 72 MHz

Both light up and scan out correctly; VOP2 reports the programmed mode
with real_clk matching the requested pixel clock.

What has *not* been tested:

  - The boot testing above was done on 6.19.5, and with an earlier
    revision of patch 3 that used regmap_update_bits() and powered the
    phy from a shared helper. This series is rebased onto 7.1.3 and the
    GRF accesses were reworked to regmap_write() after review; it is
    compile-tested and the DTB builds, but this exact code has not been
    booted. The register writes are equivalent by inspection.
  - Patch 1 has not been tested on rk3288 or px30 hardware. The argument
    that it cannot regress them is by inspection - VOP1 has no reader of
    bus_flags - not by measurement. Review of that claim is welcome.
  - Dual-channel/LVDS1 is untested (not implemented).
  - Suspend/resume and DPMS cycling are untested. The P2S_EN re-assert
    in patch 3 is what should make a second enable work; it is reasoned
    from the poweroff path clearing it, not from a measured DPMS cycle.

dt_binding_check passes on patch 2. dtbs_check on the board DTB reports
no issues against the new lvds schema.

Tooling disclosure
------------------

Per Documentation/process/coding-assistants.rst and
generated-content.rst: this series was produced with the help of Claude
(claude-opus-4-8), used interactively across a long debugging session
rather than from a single prompt. The assistant read the vendor BSP
driver and the phy/VOP2 sources, identified the phy-ordering bug that
patch 3 fixes, and wrote the patch text and changelogs. All hardware
testing, every oscilloscope measurement and register dump, and the two
decisive debugging ideas - diffing register state against a working
vendor board, and using MIPI DSI on the shared D-PHY to prove the lanes
were good - were mine. I have reviewed every line and can defend it.
The Signed-off-by is mine alone.

No coccinelle/sparse/smatch runs were involved.

Rok Markovic (4):
  drm/rockchip: lvds: propagate bus_flags to the CRTC state
  dt-bindings: display: rockchip,lvds: add RK3568
  drm/rockchip: lvds: add RK3568 support
  arm64: dts: rockchip: rk356x: add LVDS node

 .../display/rockchip/rockchip,lvds.yaml       |  22 +++
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi |  25 +++
 drivers/gpu/drm/rockchip/rockchip_lvds.c      | 171 +++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_lvds.h      |  10 +
 4 files changed, 227 insertions(+), 1 deletion(-)

-- 
2.43.0

