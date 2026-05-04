Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4642FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F142010E3C8;
	Mon,  4 May 2026 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kv/8V07p";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4F910E3C8
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777903603;
 bh=LxVnVgK4AtpZlIDUuh+imTNb1rdt7jSOyvrqV8pONdE=;
 h=From:To:Cc:Subject:Date:From;
 b=Kv/8V07pWj3lVMcKgf/iKwsKDaRYfDPZryMFPpOJ9ucoKF00vLcgWnZ4CqR2OIMfQ
 9Y8r3JzB5My0xV/hyf1GWBg4JPUP/EQZ3RVOcv8ackKz7p/ME7XuklYB++abCjf67u
 WD9mMyxi7fR/d4ah0amgb6yX9sMvN1lHXXtnWhpB0OMiHexu1ulyN16ky/kq1odFn3
 waWwYvoWDbJBaTt+nmnimz0y8USYrpZvBxy1IGVhBvLqE1Pb8hWh+MHLrXoi+eggv+
 iW8E4qIrLawEHPFNXQQjxW4Ot6OFL/cE/Io+DIMflZxAvMx8V2B/J8FpO4CvEY5NdT
 fLLriaNZCXfwQ==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AD1D317E05FC;
 Mon,  4 May 2026 16:06:39 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/drm_blend: allow blend mode property without
 PREMULTI
Date: Mon,  4 May 2026 11:06:28 -0300
Message-ID: <20260504140630.68707-1-leandro.ribeiro@collabora.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
support entirely. DRM currently requires that PREMULTI is present when
creating a blend mode property, which prevents such drivers from being
properly upstreamed.

This series remove such restriction and allow drivers to create a blend
mode property without PREMULTI.

v2: force drivers to expose blend mode if plane supports alpha property
or pixel format with alpha.

Leandro Ribeiro (2):
  drm/drm_blend: allow blend mode property without PREMULTI
  drm: ensure blend mode supported if alpha exposed

 drivers/gpu/drm/drm_blend.c         | 21 ++++++++++-----
 drivers/gpu/drm/drm_crtc_internal.h |  1 +
 drivers/gpu/drm/drm_drv.c           |  7 ++++-
 drivers/gpu/drm/drm_mode_config.c   | 42 +++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 8 deletions(-)

-- 
2.54.0

