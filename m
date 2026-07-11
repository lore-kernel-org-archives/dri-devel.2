Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFE9C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 11:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A64B10E33D;
	Sat, 11 Jul 2026 11:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="bDXSh0Vz";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D0B10E342
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783770680; x=1784029880;
 bh=aPjFGdxXqrDxQp3pmk6w/9YzMYwpXG1eyHUj2kPsrNs=;
 h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=bDXSh0Vz3odsDAxIoGD1HEwMEdwL5XVNgUOvgGs1xY420XPse0UFQxMTFT0fHf2yB
 QNxewyz9e31MXaxEscFUOYbWFgfX3QriV9jctF8Ohj+gl8hGvEi3F2tLquF57u16nJ
 bScasbCa2+cb9oJOF5b0H0CUBXBbcuvGfOxda2N1omg9jyX1S7T0dHK18TEDwsmuuM
 /grTAPwRoD/1RR/ZDXwauq/+C1vGSF8EvXPEtbDVoYhnzcnh+0gUNNoKwVzqbXq5y3
 gvOOQ4baTWy7R1CcYZ3Rlven+n6t8GZX1wn4DH7FNghLN6010HXmmYYbvG2VVh7Z00
 if2jhR1a+GlTA==
X-Pm-Submission-Id: 4gy6VD6qtwz2Scqh
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/2] drm/bridge: ti-sn65dsi83: Various fixes
Date: Sat, 11 Jul 2026 13:51:13 +0200
Message-Id: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1hNIFat4FZmFtlHjokrjDIJ4d
 6suPx7/O0A5Cis02QGR/6KyhATzycBNXRgZxSdDTrmlyhBughps6VXqAgfZWdF4qpk6Z6u+gBS
 ukZ8hde33tf76md12P8F5Xh1QUlR2AAAA
X-Change-ID: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783770676; l=678;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=XW4pyjeE5O7DCq+Gr94TugZEL6NCgqvwBwlVU5+/rKk=;
 b=E6VgcFCjDhy4WSrtEsymGIbf4Eyj+6tdzEn7q+MUaIfy0gyGAVCltYuilkMA204nqG7vKq3f0
 UVmW5m1Rm7uCXnaVsMX2TSWIsYdCS9nmMn1rd079QEPUOEo7D6QSYzr
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

This small series adds support for using SN65DSI84 in single-link mode with
output to LVDS channel B, and provides a fix for a PLL locking issue.

Signed-off-by: Esben Haabendal <esben@geanix.com>

---
Esben Haabendal (2):
      drm/bridge: ti-sn65dsi83: Support LVDS Channel B on SN65DSI84
      drm/bridge: ti-sn65dsi83: Fix problem with premature PLL locking

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 66 +++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 27 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-ti-sn65dsi83-fixes-1d08e0ac67b3

Best regards,
--  
Esben Haabendal <esben@geanix.com>

