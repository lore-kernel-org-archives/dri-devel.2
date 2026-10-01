Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5432BCA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 896A910E316;
	Thu,  1 Oct 2026 08:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="D6fjaMcb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F9210E316
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790843129;
 bh=xj1dH1EQpKkGXXGlMtHjKJEtOVFI6kEk+gGhOxu6rqs=;
 h=From:Subject:Date:To:Cc:From;
 b=D6fjaMcbDPd57D/1W5bg6E9R2vYMKW8n/R6Sc1wSoQU4BBsiObGX8Fp5JHJ/iAprH
 MIH22dKqdoGCdUT7EJS8ee3IFyxuGVyiNmuHm82OrC3/vFpZ3L+WfVEJ2BGjXaYSpN
 qaaw5+BP3pKXnciksGnGaj7KZTvPyo2l2rmccvUpEQbg7llJLrmgg/ungrAYlFD7Or
 o32E03ElAMGf53DsQjq582im5olF8V7ED3avprtqwekY3mG9JKNxMSc02wqwYG0xQG
 6ICWm8ZqcsiIG02IvPr+Kkd0CRkV7FcRH3zWMyuFjxmwUZ4mC+u5wPE/GI+BTlIMD+
 C7BJPAzkc6Fhw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B9BD517E0371;
 Thu, 01 Oct 2026 10:25:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/2] drm: devm_drm_bridge_alloc() conversion and cleanup
Date: Thu, 01 Oct 2026 11:25:10 +0300
Message-Id: <20261001-bridge-alloc-conv-v1-0-f0a1fe040a86@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubbaWSFeRS5szjjSpg0peXfD5
 e+r739BpMAUockuCHRwZO8SMM/ATL0bSfCQDEqqEqVEoQMPae2XxRthvDuELbCytVaFQgvptwa
 yfH7Ntvsddz2T2d4Q3PcDibiebnUAAAA=
X-Change-ID: 20261001-bridge-alloc-conv-f517f9b2521f
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

Bridge drivers are expected to allocate their private data via
devm_drm_bridge_alloc(), which also initializes the embedded struct
drm_bridge, including its funcs pointer.  Most drivers were converted by
commit 9c399719cfb9 ("drm: convert many bridge drivers from
devm_kzalloc() to devm_drm_bridge_alloc() API"), but a couple of
leftovers remain.

The first patch converts the rk3066_hdmi driver, which still uses
devm_kzalloc().  The second one removes a redundant manual assignment of
the bridge funcs pointer in the lontium-lt8713sx driver, which already
uses devm_drm_bridge_alloc().

Both changes are trivial and have no functional impact.  The series is
based on the latest drm-misc-next.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (2):
      drm/rockchip: rk3066_hdmi: Convert to devm_drm_bridge_alloc() API
      drm/bridge: lontium-lt8713sx: Drop redundant bridge funcs assignment

 drivers/gpu/drm/bridge/lontium-lt8713sx.c | 1 -
 drivers/gpu/drm/rockchip/rk3066_hdmi.c    | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)
---
base-commit: 37b346eab23aead52d17a8fa687056bfc651a416
change-id: 20261001-bridge-alloc-conv-f517f9b2521f

