Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D6CCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB3310E5F2;
	Mon, 18 May 2026 17:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HrBLMkR9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C9E10E5F2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779126903;
 bh=BpDz6FJ1VwY+vrpUbgW76LYygd+6fRBU6WVkze/iKOI=;
 h=From:To:Cc:Subject:Date:From;
 b=HrBLMkR97p/bIIWyL//tp84JIydq6HfAJ/73m7NpWucRB4zolccz40VLvWSNQxOG3
 qZrgQLHX6eU9KvS/kGYGG+0rr3MNSzEs5DA/i30VFKPO9nvVu4qx1ljXBVsyJkHpcj
 kDWNMmZrEoUwIPFO9toCQ8e5Fp3W+7CzXxEjjXHEQX6VOrJQaCSAq4/tQ8Ld4JIBFd
 e5FG4FNyZ4yD9YNWPqjG2JCdKIReWCvJuqrB2fO96ljmxs5g2DIxTG1t+1CZ66fJ/D
 8KJx0k3K2hNyVbuq5jOKZaZqo7px240VFNkg3sBXg4/U04Wv4S1QLHeB/hI+78LhXZ
 fEUa38AJnqKzg==
Received: from archlinux (unknown [100.64.1.80])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B2A217E05E5;
 Mon, 18 May 2026 19:54:59 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] drm/drm_blend: allow blend mode property without
 PREMULTI
Date: Mon, 18 May 2026 14:54:27 -0300
Message-ID: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
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

This series removes this restriction and allows drivers to create a blend
mode property without PREMULTI.

On Weston (userspace), we are working [1] towards adding support for
this kind of hardware.

[1] https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2046

v3:
- Changed where we enforce drivers to expose blend mode for planes that
  support the alpha property or pixel formats with alpha.
- Fixed missing check to forbid calling
  drm_plane_create_blend_mode_property() with a zero bitmask of
  supported modes.

v2:
- Force drivers to expose blend mode if plane supports alpha property
  or pixel format with alpha.

Leandro Ribeiro (2):
  drm/drm_blend: allow blend mode property without PREMULTI
  drm: ensure blend mode supported if alpha exposed

 drivers/gpu/drm/drm_blend.c         | 20 +++++++++++-----
 drivers/gpu/drm/drm_crtc_internal.h |  2 +-
 drivers/gpu/drm/drm_drv.c           |  7 ++++--
 drivers/gpu/drm/drm_mode_config.c   | 37 +++++++++++++++++++++++++++--
 4 files changed, 55 insertions(+), 11 deletions(-)

-- 
2.54.0

