Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC543C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27F610EFC9;
	Thu, 23 Jul 2026 07:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="bwDHb+kT";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B9B10EE6F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 62E133D818C9;
 Wed, 22 Jul 2026 13:38:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CHUj8Fg0MHHH; Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 55EB63D818A3;
 Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 55EB63D818A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1784741921; bh=jQm77tJ5zqmG2YRbm0c34YcXtnsvIps8JiC+d/WYrhE=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=bwDHb+kT7J0k5fmgMVfeJZeLAzt5dbjR7uRON9GKUCaUu6pUWlPEl/jb+CX19Jfdp
 30HAP3GBxQvNMeZBJFS7XhwJ4GODZoZZDqJC2Y6YOTi4PXUc1MoxeQ/oHmDDYIdgMV
 6nEMIv2CjyUQhQY3OVwSg0qJysx4bkPpcUrmPFx1OP/K6fE9prrJ9k2E8yRFw0HaID
 wQZS2YCBbXh4mwuA2lqcL4QHgswKFwRDTwvLuvzxywixN6EsjtAkS+yhsG7nmWI5aZ
 qRrajpWVqKJFCGau2yAlvRL24cw16eSXKX2Ugxn+76u9HMEPx12N9vW7+a2/ukbvMt
 vESwuMFtt8FZQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id O2AVQfYIepuL; Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 02A043D81895;
 Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Jagan Teki <jagan@edgeble.ai>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH v2 1/4] drm: panel: jd9365da: Enable LPM mode
Date: Wed, 22 Jul 2026 13:38:37 -0400
Message-Id: <20260722173840.3576444-2-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722173840.3576444-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20260722173840.3576444-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

The JD9365DA-H3 uses DSI LPM for command transmissions, make sure
this is configured correctly in the DSI mode flags.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/g=
pu/drm/panel/panel-jadard-jd9365da-h3.c
index 67ef9e0fea03..a9183baa421a 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2950,7 +2950,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device =
*dsi)
 	else
 		dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
 				  MIPI_DSI_MODE_VIDEO_BURST |
-				  MIPI_DSI_MODE_NO_EOT_PACKET;
+				  MIPI_DSI_MODE_NO_EOT_PACKET |
+				  MIPI_DSI_MODE_LPM;
=20
 	dsi->format =3D desc->format;
 	dsi->lanes =3D desc->lanes;
--=20
2.34.1

