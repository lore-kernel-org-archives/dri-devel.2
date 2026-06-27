Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0BC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967F510E1F6;
	Sat, 27 Jun 2026 03:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZP02I8Z3";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFFD10E1F6
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:30:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 47CB3C5CD75;
 Sat, 27 Jun 2026 03:31:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0403260233;
 Sat, 27 Jun 2026 03:30:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5C5B106F1165; 
 Sat, 27 Jun 2026 05:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Ixf3Rgqs2n33S9RzFlI8yle31Fsg5QeXnIpnubx1BPY=;
 b=ZP02I8Z3UauEoxThvX1HeQtUflM5KsyL7N0WWXGC0npfWS6HP5RIF5EU7nQYGR5GW5QdjM
 Jiddwwl/9L4yYb0lhd1lOvj47He2ZeNL36aGbDnqD+/bAk0uK7IO/cVsSQsjX4LJEAqgL8
 V7ZkebhqM/nvS8qFFVgnwkUR5KF66KxLuCJP7ePpm1DPDFbwVshyk+TmdKNJXWzDe5kDZm
 /5vcpNWvurIs0tj/SNMdSNhYq5R2WNRm5pPcnMrrSp74E+lDC5AfvTIjkelKXyoCXyj/GV
 baYh6pnzhukvc0Tt8libikC+h94BACuOajTjvouf170kEY+KKcpt0E0L0dBbeA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v5 00/38] VKMS: Introduce multiple configFS attributes
Date: Sat, 27 Jun 2026 05:30:17 +0200
Message-Id: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMlDP2oC/23OzU4DIRQF4FeZsBaFO8xM6cr3MC74ubTE+amAp
 KaZd5dObdTgjkNyvnsuJGLwGMm+uZCA2Ue/zCV0Dw0xRzUfkHpbMgEGHWd8oPltilSNIzXL7Py
 BassMKMZ3onektE4BnT9v4svrLQd8/yhwun0SrSKW9jT5tG9smOjko3m6P+iM50SuzaOPaQmf2
 7TMt+r3il21InPKqBqGng1dZyXYZ70safTzYzm0aRl+CSBrAYqgEZiW2nHRYy20PwIA1EJ7FZQ
 Aa1qnpXO1IO5Cz8R/giiC1boDlEoV5q+wrusXkLkonLABAAA=
X-Change-ID: 20251017-vkms-all-config-bd0c2a01846f
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8984;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=SzIIelzgD8yRfpXj8312XPpa8sWfV5Gpyj2Qtjw6xB0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PcD/GdwpMbf3PE0mDOwmh0WTz6+TxxKgdvs
 u7jgnnvrFOJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLS2w//S1xvhz0NNO54YKS+3IAz8g7gySJGdeX
 nzM3prdTiOyLv+VsKvhtLRuDQyGp7FW5b3+auPmkW/BrtHQ8BsZi17T9k1f8gcRD2YCqHlZSReZ
 TjSV0O9l3GVoz7KpNC+PgnTtE2kGV3CHWxY0XK9oYfw+UxGW5p7M2oOJ615/yp2gUMVctvfgjRu
 frokVJDv6+ciItFhuuvpRI4LewHCPzSBQdj2mLVpjcGS59PjULmKa04vSO3hpWBp5Ih/70vjdMx
 WVXYv55JfEXxxAvyNLzGoS0Bes8jHyew7tucABpKFoSjNbgoZ/UM5S7q5TUfXz6QNTPYvxmFJE6
 23bsbXgtlCZnD20xMOxx2+UJRcCf6A8YgwLTt+IcAlHTj4AscJOLUvWoINb9lF5fZPNI01B7Yy9
 wSRA3e8qxPZ8LBGaWJ3p4+svaTc1wmJy/T0yuDbJvyIsMxqdhgv13u7m33DRd34hlytvbc3tMIn
 PHIW6Svm2KH8mroe3XwLpiSsaBxfJeNiBUi5//j1RVE5NVx5omjI204UVBshJO1oK+1bVPyJvO/
 6uVt/ptZZ1PWlP34Z0KG3veR6MDDrm3UKx3an+21LGu8fWWyROs5ES3HeSjumoxYc4eocIqpuMC
 WAufEFBP9rdx0bB4/T4ZCFnj++b6AdfM16w1/ol97pL7AG6OWewA=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

VKMS have a wide range of options. The aim of this series is to introduce
many configfs attribute so VKMS can be used to test a wide range of
configurations.

PATCH 1-5 are to expose human readable strings from drm core
PATCH 6 is a fix for rotation value
PATCH 7 is ABI documentation
PATCH 8 added some error checks in plane configuration
PATCH 9 cleanup in plane_release
PATCH 10-12 change the display in configfs to be more readable
PATCH 13,14 plane name
PATCH 15,16 plane rotation
PATCH 17,18 plane color encoding
PATCH 19,20 plane color range
PATCH 21,22 plane format
PATCH 23 properly use zpos
PATCH 24,25 plane zpos
PATCH 26,27 connector type
PATCH 28 preparation in connector initialization
PATCH 29,30 connector supported colorspace
PATCH 31,32 connector EDID
PATCH 33-35 dynamic connectors
PATCH 36-37 PATH property

PS: Each pair of config/configfs patch are independant. I could
technically create ≈10 different series, but there will be a lot of
(trivial) conflicts between them. I will be happy to reordoer, split and
partially apply this series to help the review process.

PS2: I am currently cleaning the IGT test series to validate all that,
it should come on Monday/Tuesday

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v5:
- Fixed missing property creation for PATH
- Use the folder name instead of a new attribute for plane
- Rebased on drm-misc-next
- Link to v4: https://patch.msgid.link/20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com

Changes in v4:
- Introduced a way to change the PATH property
- Reordered drm-only patches to the front of the series.
- Fixed a bug when dynamic connector are allocated/freed (drmm instead of
  kzalloc)
- Properly handle errors in vkms_connector_init
- Only parse formats one by one (no more complex algorithm, you will have
  to write multiple times for multiple formats)
- Use sysfs_emit instead of sprintf
- Fix rotate property default value
- Link to v3: https://lore.kernel.org/r/20251222-vkms-all-config-v3-0-ba42dc3fb9ff@bootlin.com

Changes in v3:
- Added Documentation/ABI (Thomas Petazzoni)
- PATCH 2: Clarify return value
- PATCH 6,7: Avoid passing null to printf
- PATCH 7: Restrict plane name to A-Za-z0-9
- PATCH 12: Fix missing s
- PATCH 13: Add macro to avoid repetition, fix missing s, make code
  consistent, remove wrong comment, properly check bit values
- PATCH 15: Fix missing s
- PATCH 16: Fix missing s, make code consistent, remove wrong comments,
  properly check value and fix default_color_range value
- PATCH 17: Create function to reduce code complexity, fix missing s
- PATCH 18: Fix parsing, rename data, reject strings > 4 chars
- PATCH 20: Remove duplicated lines, fix test comments simplify conditions,
  remove useless documentation, 
- PATCH 21: {Min,Max}imal -> {Min,Max}imum, simplify commit log
- PATCH 25: Fix wrong comment
- PATCH 26: Rename type to colorspaces
- PATCH 27: Improve comment, avoid useless iterations
- PATCH 28: Fix typo in commit log
- PATCH 29: Fix typo in commit log
- PATCH 30: Remove useless include and move it to proper commit
- PATCH 32: Clarify documentation
- PATCH 33: Simplify code and use better variable names
- PATCH *: Fix EINVAL/EBUSY
- Link to v2: https://lore.kernel.org/r/20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com

Changes in v2:
- PATCH 1: reorder includes (José)
- PATCH 2: use name property instead of folder name (José)
- PATCH 3: Fix default rotations (José)
- PATCH 3,5,7,12: Add tests and extract validation for planes (José)
- PATCH 3,5: Do not create color range/encoding properties if not set
- PATCH 5,6,7,8: Set plural form for vkms_config_plane fields (José)
- PATCH 4,6,8,13: Remove checking for default in supported (José)
- PATCH 9: Add break in vkms_config_plane_add_format (José)
- PATCH 12: fix zpos_enabled typo (José)
- PATCH 13: fix documentation (José)
- Add debug display (José)
- PATCH 20: use drmm_kzalloc instead of kzalloc (José)
- PATCH 22: simplify the code (José)
- Link to v1: https://lore.kernel.org/r/20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Louis Chauvet <louis.chauvet@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>
To: Melissa Wen <melissa.srw@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
To: Bill Wendling <morbo@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: thomas.petazzoni@bootlin.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: llvm@lists.linux.dev

---
Louis Chauvet (38):
      drm/drm_mode_config: Add helper to get plane type name
      drm/blend: Get a rotation name from it's bitfield
      drm/drm_color_mgmt: Expose drm_get_color_encoding_name
      drm/drm_color_mgmt: Expose drm_get_color_range_name
      drm/connector: Export drm_get_colorspace_name
      drm/drm_atomic_state_helper: Properly load default value for rotation
      Documentation: ABI: vkms: Add current VKMS ABI documentation
      drm/vkms: Add error handling in plane config creation
      drm/vkms: Simplify plane_release code
      drm/vkms: Explicitly display plane type
      drm/vkms: Use enabled/disabled instead of 1/0 for debug
      drm/vkms: Explicitly display connector status
      drm/vkms: Introduce config for plane name
      drm/vkms: Use plane folder name as plane name
      drm/vkms: Introduce config for plane rotation
      drm/vkms: Use DRM_ROTATION_FMT macros for rotation display
      drm/vkms: Introduce configfs for plane rotation
      drm/vkms: Introduce config for plane color encoding
      drm/vkms: Introduce configfs for plane color encoding
      drm/vkms: Introduce config for plane color range
      drm/vkms: Introduce configfs for plane color range
      drm/vkms: Introduce config for plane format
      drm/vkms: Introduce configfs for plane format
      drm/vkms: Properly render plane using their zpos
      drm/vkms: Introduce config for plane zpos property
      drm/vkms: Introduce configfs for plane zpos property
      drm/vkms: Introduce config for connector type
      drm/vkms: Introduce configfs for connector type
      drm/vkms: Rename vkms_connector_init to vkms_connector_init_static
      drm/vkms: Introduce config for connector supported colorspace
      drm/vkms: Introduce configfs for connector supported colorspace
      drm/vkms: Introduce config for connector EDID
      drm/vkms: Introduce configfs for connector EDID
      drm/vkms: Store the enabled/disabled status for connector
      drm/vkms: Allow to hot-add connectors
      drm/vkms: Introduce configfs for dynamic connector creation
      drm/vkms: Add connector parent configuration in vkms_config
      drm/vkms: Add ConfigFS interface for connector parent and port_id

 .clang-format                                   |    2 +
 Documentation/ABI/testing/configfs-vkms         |  250 ++++
 Documentation/gpu/vkms.rst                      |   44 +-
 drivers/gpu/drm/drm_atomic_state_helper.c       |    6 +
 drivers/gpu/drm/drm_blend.c                     |   35 +-
 drivers/gpu/drm/drm_color_mgmt.c                |    4 +-
 drivers/gpu/drm/drm_connector.c                 |    1 +
 drivers/gpu/drm/drm_crtc_internal.h             |    6 -
 drivers/gpu/drm/drm_mode_config.c               |   16 +
 drivers/gpu/drm/vkms/tests/Makefile             |    3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c   |  513 ++++++++-
 drivers/gpu/drm/vkms/tests/vkms_configfs_test.c |  102 ++
 drivers/gpu/drm/vkms/vkms_config.c              |  421 ++++++-
 drivers/gpu/drm/vkms/vkms_config.h              |  641 ++++++++++-
 drivers/gpu/drm/vkms/vkms_configfs.c            | 1402 +++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_configfs.h            |    4 +
 drivers/gpu/drm/vkms/vkms_connector.c           |  268 ++++-
 drivers/gpu/drm/vkms/vkms_connector.h           |   48 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                |   10 +-
 drivers/gpu/drm/vkms/vkms_output.c              |   15 +-
 drivers/gpu/drm/vkms/vkms_plane.c               |   73 +-
 include/drm/drm_blend.h                         |   17 +
 include/drm/drm_color_mgmt.h                    |    3 +
 include/drm/drm_mode_config.h                   |    3 +
 24 files changed, 3581 insertions(+), 306 deletions(-)
---
base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
change-id: 20251017-vkms-all-config-bd0c2a01846f

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>

