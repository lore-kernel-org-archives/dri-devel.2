Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE63F588C3
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BCE10E5D3;
	Mon, 20 Apr 2026 13:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XE8LHdpw";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A9D10E5C6
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:13:53 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37AFF2686;
 Mon, 20 Apr 2026 15:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776690735;
 bh=DZXYfp6QWN12JK94UAf//z4aI9iwSEdefEzlBrAbNmo=;
 h=From:Subject:Date:To:Cc:From;
 b=XE8LHdpwFObG6QmBuHrYTuq/d2lL+ZkMRaeBSTBnG89btQbDDR4C3Q0FODZOoly1k
 oJeTB3epcfUyhXYVGgLUvTRJldyW47jRPCRTbZlV1ZlJ8H9sbEsd3lSUuP45cNmRRv
 5C1lY4oJPgbT9VxKtAn7C84Dt+W2gecPggiBF3iA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] drm/panel: Add Raspberry Pi 7" panel
Date: Mon, 20 Apr 2026 16:13:34 +0300
Message-Id: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4m5mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMD3aKCTF3zzLzkDN1kwxQL47RUQ+MkQ3MloPqCotS0zAqwWdGxtbU
 Asb1zEVsAAAA=
X-Change-ID: 20260420-rpi-7inch-c1d83fe13b17
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=879;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DZXYfp6QWN12JK94UAf//z4aI9iwSEdefEzlBrAbNmo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iaKtqsd6loxDQk6zOG+Wg5LO6SMLk3XWIW+x
 dAl9riU++CJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYmigAKCRD6PaqMvJYe
 9RxKEACHcTicuEftUlOP7S5RqAGYku8xLrKWTdYX8VXO8XuLnq86myTA7imJMyZeM/ymOEvaPL6
 ZrSUT1fuzl0H5OhJ7vNCH77HidYPPTaqYnJ/AfLaFqO5BPREjBcyUil833qcbHQnMixrZsxB8S1
 MkjBcULGIBEOg7Y/bm0TQMTgr0uXh2lKf+GnB+CzO8zdj6UQdCaCCJf9sgJH715TiQBt7IWhY2d
 qKBwdbj/xbDp7oKi/e5Cetx+pbEPC1DLQ9mT4EEBxI/uuvOcqTDpmgMpZGAz6ZrPOsVIKE8XZpt
 76PMGBw2m00hEUNHu3ANeGrms70H2rMLn+HYuXiMfMfxBuVtzdwx8nRVBmSROasrPT2fbSoaJeI
 5SF4MAvgdmw7mlTW2kemUj5G0Ae+y1irHJesn3FlUSUBso1sjcT9HMl4DOk3hgl2JcL4kNn8Is6
 fkeSmKpIkM2zyxuwIfZNBFDu293oH5Df6hRxzYdnM+sDHNPPVD3fGxlz5zemdDGuNqLBXy1UXLJ
 487O0ZfmGQlpC056nk3eEPiv6ss5EcioI7nx4CrfG85GWlG3qA1fQ9DzL22aI0XmtXiWLnzTL9m
 qNHG4Fn1cPi41w8zK5zLkG86eKEDSlV9JNsKXed06YWfTLZT0B1SbA4ltdjfXeX8spXLqEt+c1a
 t+VCXN6mtKOcg7g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

This series adds Raspberry Pi 7" display module's panel to panel-simple.

Tested with BeagleY-AI and v1.1 of the display module.

This series, with
https://lore.kernel.org/all/20260327-tc358762-fixes-v2-0-3589d3c45f4a%40ideasonboard.com/
gives me a perfectly centered display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      dt-bindings: display: simple: Add Raspberry Pi 7" DSI Display module panel
      drm/panel: simple: Add timings for Raspberry Pi 7" panel

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 32 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260420-rpi-7inch-c1d83fe13b17

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

