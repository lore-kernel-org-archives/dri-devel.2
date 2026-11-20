Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CB60A262E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=C5/qSiDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECD2112AC1;
	Fri, 20 Nov 2026 18:02:05 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F166010E24D
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:01:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 24B4A4E4168A;
 Fri, 20 Nov 2026 18:01:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DF7EC601B9;
 Fri, 20 Nov 2026 18:01:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01A0711BC0990; Fri, 20 Nov 2026 19:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=I7nrvlWZ9rvUUTmD+gtwmdv37sNDZT+3fdZRVXqibGs=;
 b=C5/qSiDusohVtuPBRYEbsGHzPUGhlhXqSQ6TPjvZI1NlCLDJ+8tJoosysXbWGqVZr2LbMt
 klHdw4b7+ffNf4Kc6HZW0fSqd3QQKNTfohrgBemzaRgo4hI/OXAlUgjktygGKWGiYpLe5c
 0Z2WRRUrlEf+jYpbBO+JpEoRkuNfpHIiqTDBQlLTu07tVbVFzWBTDZyX4B2guJPxxXCAIm
 ctwIMQrQUzXkmYLQl4MpSqKtUs32p6Lji/7nMToTa+F32zs+R/5PwyCV7VDohpqSg2xfbW
 +Ysb3qjyBMwYv3/KhBJ1xeebhmma9cNp7WhyyunsR5Vflj2D0Uenlic9Lp89Xw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v6 00/43] VKMS: Introduce multiple configFS attributes
Date: Fri, 20 Nov 2026 18:58:42 +0100
Message-Id: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHiKAGsC/23R0U7DIBgF4FdpuBaFv0DLrnwP4wWUn424tgqVz
 Cx9d1nnMg3ecUjOx0k4k4QxYCK75kwi5pDCPJWgHhoyHMy0RxpcyQQYSM54R/PbmKg5HukwTz7
 sqXVsAMN4L5QnpfUe0YfTJr68XnPEj88CL9dLYk3C0h7HsOwaF0c6hjQ83Q50wtNCLs1DSMscv
 7ZpmW/VnxV9tSJzyqjpOsU6KZ0G92zneTmG6bE8tGkZfgmgawGKYBGY1dZzobAW2rsAALXQXgQ
 jwA2tt9r7WhA3QTHxnyCK4KyVgNqYwtSCvAsK6t/Isgi9FMawXjAN6q+wrus3yCBhZvIBAAA=
X-Change-ID: 20251017-vkms-all-config-bd0c2a01846f
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito@redhat.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10381;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ork8e0nS7ORlthJa0leER1qFqEZ3DyCvLHrBmoDTApk=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr9aJDgt8ebmSYnhAvhMtnlYXyJbscKYoDtk
 XoYW5Y+aXSJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLZIw//beTpP4qGVpZDtmHWzhgUo1h/h9HQs6Z
 Yv4TX/ZO9iIDraBnCKEscZ2672kCq0JMhl/ryyHGSAz6/mAJa9w4n3uknh8dPxSFec/vSx2uE01
 Ipj1EqQ1cCZWlc7mzL+tMYKWgAq4B+ZkDl1mi/5rFrO/soFRVzjMcJWC2Xr1uNrGxoT811YVg5T
 WZGoNeXvsp6mNOdonIx0AkxRkKCJQ6ilKP+rGCI+sT7HQorz1WKX1/PJ7UYj6n4KyHc8JgHUHtV
 NiWw/aXg7Squse5BjpcPnDOL5RGWD9GMj3x4TXniHtil7kZpOMEAH6ztiz2oJujMTYdg026uO9e
 2nJDT6ehTX+0Bh5pG6q4SDv3bAtD9qaGik2RlyKjOv80mV8l7gfZoyrxAhQQ9a/zhDwBseQUGTc
 iGLSqwI0LIZI8vBZCP0AdoADPWNvgNvPTCAbbXWWi4unrpePJOSGO2xPMUCOchnAl0QflGBVEUe
 nN3IdhUogSScaNCf4hBeY7UHht5fPl84nyZMkEyS+UzLjnZFev2dl7o3qvB6tI4JC5PAG61pTAf
 GfvDZOJ4ulFAG+2GORWSQqamEDM2Et4vSjf5G6+FKFUokOTv+OTWHWMzZgAML48vr8j1zu6VRsj
 U4oXybgEENEu1TIFFfl5MLvvNN6DsoHKVV4RBRtZipW/M7d/Y8GI=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS have a wide range of options. The aim of this series is to introduce
many configfs attribute so VKMS can be used to test a wide range of
configurations.

PATCH 1-3 fix display and locking of the configfs attributes
PATCH 4-9 expose human readable strings from drm core
PATCH 10 is a fix for the default rotation value
PATCH 11 is ABI documentation
PATCH 12 introduce reference counting for vkms_config
PATCH 13 add a KUnit test for the device lifecycle
PATCH 14 added some error checks in plane configuration
PATCH 15 cleanup in plane_release
PATCH 16-17 change the display in configfs to be more readable
PATCH 18,19 plane name
PATCH 20,21 plane rotation
PATCH 22,23 plane color encoding
PATCH 24,25 plane color range
PATCH 26,27 plane format
PATCH 28 properly use zpos
PATCH 29,30 plane zpos
PATCH 31 back pointer to connector
PATCH 32,33 connector type
PATCH 34 preparation in connector initialization
PATCH 35,36 connector supported colorspace
PATCH 37,38 connector EDID
PATCH 39-41 dynamic connectors
PATCH 42,43 PATH property

PS: Each pair of config/configfs patch are independant. I could
technically create ≈10 different series, but there will be a lot of
(trivial) conflicts between them. I will be happy to reordoer, split and
partially apply this series to help the review process.

PS2: I am currently cleaning the IGT test series to validate all that,
it will be submitted separately.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v6:
- disable cfi check for show_bitfield
- Rebased on drm-misc-next
- The ABI documentation is now distributed: each patch introducing an
  attribute adds its own documentation section
- vkms_config and vkms_config_connector are now reference counted,
  fixing use-after-free and races when destroying connectors
- Lock the config dump against concurrent configfs changes
- Add a KUnit test for the device lifecycle
- Link to v5: https://lore.kernel.org/r/20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com

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
Louis Chauvet (43):
      drm/vkms: Explicitly display connector status
      drm/vkms: Lock the config dump against concurrent configfs changes
      drm/vkms: Add new lines for configfs attributes
      drm/drm_mode_config: Add helper to get plane type name
      drm/blend: Get a rotation name from its bitfield
      drm/tests: Add test cases for DRM rotation name
      drm/drm_color_mgmt: Expose drm_get_color_encoding_name
      drm/drm_color_mgmt: Expose drm_get_color_range_name
      drm/connector: Export drm_get_colorspace_name
      drm/drm_atomic_state_helper: Properly load default value for rotation
      Documentation: ABI: vkms: Add current VKMS ABI documentation
      drm/vkms: Reference-count vkms_config and vkms_config_connector
      drm/vkms: Add KUnit test for device lifecycle
      drm/vkms: Add error handling in plane config creation
      drm/vkms: Simplify plane_release code
      drm/vkms: Explicitly display plane type
      drm/vkms: Use enabled/disabled instead of 1/0 for debug
      drm/vkms: Introduce config for plane name
      drm/vkms: Use plane folder name as plane name
      drm/vkms: Introduce config for plane rotation
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
      drm/vkms: Introduce back pointer to connector
      drm/vkms: Introduce connector type
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

 .clang-format                                    |    2 +
 Documentation/ABI/testing/configfs-vkms          |  326 +++++++
 Documentation/gpu/vkms.rst                       |   44 +-
 drivers/gpu/drm/drm_atomic_state_helper.c        |    6 +
 drivers/gpu/drm/drm_blend.c                      |   19 +-
 drivers/gpu/drm/drm_color_mgmt.c                 |    4 +-
 drivers/gpu/drm/drm_connector.c                  |    1 +
 drivers/gpu/drm/drm_crtc_internal.h              |    6 -
 drivers/gpu/drm/drm_mode_config.c                |   16 +
 drivers/gpu/drm/tests/Makefile                   |    1 +
 drivers/gpu/drm/tests/drm_rotation_test.c        |   76 ++
 drivers/gpu/drm/vkms/tests/.kunitconfig          |   12 +
 drivers/gpu/drm/vkms/tests/Makefile              |    3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c    |  520 ++++++++++-
 drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c |  259 ++++++
 drivers/gpu/drm/vkms/vkms_composer.c             |    3 +-
 drivers/gpu/drm/vkms/vkms_config.c               |  664 +++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.h               |  703 ++++++++++++++-
 drivers/gpu/drm/vkms/vkms_configfs.c             | 1046 +++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_connector.c            |  340 ++++++-
 drivers/gpu/drm/vkms/vkms_connector.h            |   49 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                 |   16 +-
 drivers/gpu/drm/vkms/vkms_drv.c                  |   12 +-
 drivers/gpu/drm/vkms/vkms_output.c               |   21 +-
 drivers/gpu/drm/vkms/vkms_plane.c                |   80 +-
 include/drm/drm_blend.h                          |   34 +
 include/drm/drm_color_mgmt.h                     |    3 +
 include/drm/drm_mode_config.h                    |    3 +
 28 files changed, 4112 insertions(+), 157 deletions(-)
---
base-commit: 55f54b0dc193f4c9a78ae3390e3b0da6b228b4a4
base-tree: https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
change-id: 20251017-vkms-all-config-bd0c2a01846f

Best regards,
--  
Louis Chauvet <louis.chauvet@bootlin.com>

