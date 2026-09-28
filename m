Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C650FCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BD710E8A2;
	Mon, 28 Sep 2026 08:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="x30xCUB/";
	dkim-atps=neutral
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D55410E4B9
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:04:47 +0000 (UTC)
Received: from LAPTOP-R01LEAQM.localdomain (unknown [189.112.40.71])
 by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 83B38121114;
 Sun, 27 Sep 2026 21:54:46 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
 s=dkim2026; t=1790556888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ZJeyHj2hMUdTyP8McbMGBxqp5b+zG+SJIKnSqTY1Gk=;
 b=x30xCUB/TsAVSWbJkrUN+02MViAp1wgNvpOgh33HR41QX8K3QOhVTuSKcrFo96TDW3oJbZ
 up/yyMYre1/hA14fcAwYVE+YKs5KsDm1gDRi9Fekd2yQDxWVVndjjihvzAU+fUELLRQReQ
 OHcnKmtah/inWfrXrcsQYh/M5u8mTtuFbXIXwXjTI5geYVCuUODHwk2lsVt2D0lHE1N1Ro
 1hGTazjnWuAl52Krh1GvE1QMeXopLwmu18qPBUCwmpXTpuuw5uVEojN0nvqM6ED16u6LQo
 geyx8wgGN4SpoPcQWluHPq0pvgmHS2Dd4m2juxBqhc/u22+nE4bDX/IZml5X1w==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH 0/5] drm/vkms: support more formats and fix RGB565 regression
Date: Sun, 27 Sep 2026 21:52:56 -0300
Message-ID: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:45 +0000
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

Hi,

This series adds support for RGB332, BGR233 and BGR565 writeback. This
is done with new helpers added to make conversion easier. It also fixes
a regression in the RGB565 write conversion.

The argb_u16_to_RGB565() code currently truncates the resulting
channels. This behavior was originally fixed by commit
ab87f558dcfb ("drm/vkms: Fix RGB565 pixel conversion"),
but the fix was lost during a refactor in commit
cc4fd2934d41 ("drm/vkms: Isolate writeback pixel conversion functions").
The rounding behavior has been restored using the new 
argb_u16_to_channels() helper.

Matheus Alves de Almeida (5):
  drm/vkms: make argb_u16_to_RGB565 round resulting values
  drm/vkms: support BGR565 writeback
  drm/vkms: add a helper for channel to argb_u16 conversion
  drm/vkms: add support for RGB332
  drm/vkms: add support for BGR233

 drivers/gpu/drm/vkms/vkms_formats.c   | 136 ++++++++++++++++++++------
 drivers/gpu/drm/vkms/vkms_plane.c     |   2 +
 drivers/gpu/drm/vkms/vkms_writeback.c |   5 +-
 3 files changed, 112 insertions(+), 31 deletions(-)

-- 
2.43.0

