Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C26CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 18:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1915810E1D8;
	Tue, 26 May 2026 18:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k9TXB0vF";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5071010E1D8
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779819433;
 bh=LK27PYsAGH3dhnn4TnO1UlfZ2j3tL+/sLGsPaiCJaco=;
 h=From:To:Cc:Subject:Date:From;
 b=k9TXB0vFtfuFnnr/ml8GLn0rFIMigpvVAkk7dEM4OT/O2P4HCvNkYAtP5zixf21KF
 f4fmvb0XqRRxQeWlOVbg31Ulg8/s+KnwYm5g7+cEU0BLBcvCy1Tba8lZ0UiSpsvBSs
 ML4hCppqqSnlylz+pYIRhyJ3vdOF+HDPpxemQx3VSTp+6GjzJlfafZYuJVb+vU/PHi
 17Du8Gybpz5ZmhXaVGbW7higrOUQPljUPB+48Fod06cNAxTDNJ7J1JQjdVKdFpoIyn
 9usFhEOVnzp0KN0FOosLmaW0SCFU/QFvL50QUYOigO/owpChmeKHLtpqoLJX4E4k/V
 rrmGmfvz419pg==
Received: from archlinux (unknown [100.64.0.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: leandrohrb)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 57AB417E0CF3;
 Tue, 26 May 2026 20:17:09 +0200 (CEST)
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] drm/drm_blend: allow blend mode property without
 PREMULTI
Date: Tue, 26 May 2026 15:16:58 -0300
Message-ID: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
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

v4:
- Trigger warnings instead of errors when pixel format with alpha is
  exposed but blend mode is not setup.
- Require blend mode only when plane exposes pixel formats with alpha, not
  when it supports the alpha property.

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
  drm: ensure blend mode supported if pixel format with alpha exposed

 drivers/gpu/drm/drm_blend.c       | 20 ++++++++++++++------
 drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.54.0

