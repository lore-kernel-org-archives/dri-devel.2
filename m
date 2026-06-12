Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97588CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 10:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A5410E9BF;
	Fri, 12 Jun 2026 10:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Nxo8nx+s";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CA110E9BF
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 10:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781258499;
 bh=QWz/NnIpQ/tgJMgqCseSLhJn4QG66Z8YNoUhv7tJ5QM=;
 h=From:Date:Subject:To:Cc:From;
 b=Nxo8nx+spDC7UmghhkCZl8ZY3C7oc3KJfPG4xTDCYVKEYprVsqaXiObzNC+S+m15m
 SV8BzD3oyElpJQ6bA8p19cScZPEtlXZ/iG6j4Pi/n16IaYRrtwOoFCUE/c8/+XJDxk
 JRI9InulItPIEj8E7Plp7mSridItdSOaEXfYpeqWqMhyGOknBifxIXHOjIvtVA6SZ9
 38ewavdMix/Js4vQkXujL92F/dFEsYW3DQGnMWM1dnTcpKvnTb82zn4+Rr3iCDfXEM
 XoQ2hyilabflOyiyjI7i/7e6WE1XrySNxufaik7CuN44OK8pQt8Kfulj18E5Ji6z4M
 Thqsl4atsANxw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AD7EB17E00FE;
 Fri, 12 Jun 2026 12:01:39 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 12 Jun 2026 13:01:29 +0300
Subject: [PATCH v2] MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260612-maintainers-rk-drm-upd-v2-1-3ff65fc41a93@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhSoARX3sOwaMsgVaFkCkRDu
 LsFD+DiL17y/38rBGJHAS7JCkyLC84PEeQpAdvp4U7omsgghVSiEAp77YYphjggP7HhHuexQZu
 rrFVG5KWqII5Hpta9j+Nb/eMwmwfZaX/bG50Lk+fPYV7SvfdXsqSYYqvKIitNboysrta/Xtp41
 mfre6i3bfsCbVAimNIAAAA=
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
X-Mailer: b4 0.15.2
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

Acked-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Collected Acked-by from Andy
- Removed the RFC prefix
- Rebased onto next-20260611
- Link to v1: https://patch.msgid.link/20260506-maintainers-rk-drm-upd-v1-1-f67537b4bb29@collabora.com
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1caa6e5198b..ac68fdd9879e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8849,11 +8849,14 @@ M:	Sandy Huang <hjc@rock-chips.com>
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
base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
change-id: 20260506-maintainers-rk-drm-upd-c463f6b04769

