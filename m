Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC5CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC6210E647;
	Tue,  5 May 2026 22:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Oc82tQ0j";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86E710E647
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778020305;
 bh=fg/sLnYHOzh6YaK+QYdUXNpKykuvb8anEC85IqiYw/w=;
 h=From:Date:Subject:To:Cc:From;
 b=Oc82tQ0jzjYAu2BqxNb0BtpXBfkTYm5BGAVvYBd/ZiQUg3HIlLK+DahwZv7GnVeOt
 4Fh2fRNxnjmb3Wl9T76EljYhjnI8ovTk7JPNoGLrnvyvDfDvEO7MD+Z7kQLOihwOJY
 nmquX5+ioRwzUJnPbfgRrEKAsBZNyBaAo/7FDmikMcS8Nr2XZ3CvHJZHKVBVktjL3F
 urBe4J2q84hDCugb/LvHtoCV2q15lY+1BtiJfUZUM3b+oCE88lAlXl8mM+102aVzyO
 wZwdNFaPODgPKF+K4XjI+2PRv0Ptmd3Kwjz73H75oMJwKwqAD0DxZMmS9Jf+q/S5Fa
 KFT65EQoPXo9w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2727B17E05B5;
 Wed,  6 May 2026 00:31:45 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 06 May 2026 01:31:15 +0300
Subject: [PATCH RFC] MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-maintainers-rk-drm-upd-v1-1-f67537b4bb29@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3dzEzLwSIE4tKtYtytZNKcrVLS1I0U02MTNOM0syMDE3s1QCai4
 oSk3LrAAbHK0U5OasFAsRLC5NykpNLgEZqVRbCwBVT4a0fwAAAA==
X-Change-ID: 20260506-maintainers-rk-drm-upd-c463f6b04769
To: Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 kernel@collabora.com
X-Mailer: b4 0.15.1
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

The DW HDMI QP TX library was developed for and is currently only used
by Rockchip platforms.  Add it to the Rockchip DRM drivers section to
ensure all relevant parties are kept in the loop on any changes.

As its file paths fall outside the generic wildcard patterns defined in
the ARM/Rockchip SoC support section, also add the
linux-rockchip@lists.infradead.org mailing list to avoid any
notification gaps.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dfad67f66c0..cb3c8e5fcb21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8754,11 +8754,14 @@ M:	Sandy Huang <hjc@rock-chips.com>
 M:	Heiko Stübner <heiko@sntech.de>
 M:	Andy Yan <andy.yan@rock-chips.com>
 L:	dri-devel@lists.freedesktop.org
+L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/rockchip/
+F:	drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.*
 F:	drivers/gpu/drm/ci/xfails/rockchip*
 F:	drivers/gpu/drm/rockchip/
+F:	include/drm/bridge/dw_hdmi_qp.h
 
 DRM DRIVERS FOR STI
 M:	Alain Volmat <alain.volmat@foss.st.com>

---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260506-maintainers-rk-drm-upd-c463f6b04769

