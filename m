Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458CDC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBAB10E4D5;
	Mon, 20 Jul 2026 14:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JMBeSe+Z";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8302110E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:24:46 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-69e08ad526cso6892694a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784557485; x=1785162285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PmBvn+AX3Qnuwr/pMW67QihkJ9ghecGIp8Ygs9aw8VI=;
 b=JMBeSe+ZASBQz7MCykF/jU2U3k1HHAawuPWh9aTDKVnqcDYvOirRkoGaFiHlvo2ikN
 oXJVYL9HwszpyJzhhHK4lX7JtZKkdmgeIJleh0K4YuAsM1YaWEPpcY09lJsjI+qKc9z7
 z/ZQQIUyHHcQVl58APqW4WYzHhjAacIIxTWA2SxjCZegZfrv/2dWxeNO1Z42VfFPJPCr
 31x84ruHFyKtmPVWJOGcW1z9i3IeiM1a/vPhnrHfxBUdRx+7eocjyeMdAY1u6/UfkDA+
 rJvM7Z8zQn5x+1e37mViKrHsw5WUoRdQ5vuBO4RC5AFdf9/mOb1Ys5aBp2FDg1Pm0Zpb
 VMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557485; x=1785162285;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PmBvn+AX3Qnuwr/pMW67QihkJ9ghecGIp8Ygs9aw8VI=;
 b=S+knpg8aaX5wsVAASK8Dbko3V5AUrFOPLw1BCug/iYH6LIeOqrcdy20tPfg/8xmsIQ
 3CLzKZ1uSBwj/XDL2siVKl0WAnisRJJClNGtA2mIcYgwxq+1jdVw/wFSUafoWQoW4xUb
 2FhuYC0Rf8SFO58uMlxP+7ERr2KeUqBQwAXkMe8e6is+qvVoJI8KfhGeyjd2Iw63Q8TK
 L0I3QOf9dp1cIalHs8gxD3khCyeizbfAuyHI+371LrCf0nAQ4f76CAHfjrqEXhdoh4h9
 qYYNRb9Cfx9zzIcC9Hu6/pI0Brj9zPFUlTggW02CiaEtI3NGnqBSYImoLmunRnZFRkPn
 Vynw==
X-Forwarded-Encrypted: i=1;
 AHgh+RptqgWV0Wa6FzlBzYYMIFspsxYM5DiypYniAH+o/MFsC+CF1nxFZjQUh7LtfS0EdTzszDxg4ntJlSo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/Gng5cDje3n9OX9D2gfhCj1va6bvUVD6Pd25ehAB/Y2Fg0Nfq
 7cO0OBfCOesmaWxvxNPRLcgZwnfCtjshnIYo8oYn0Y7YtU+a2gLGfrzu
X-Gm-Gg: AfdE7cm5l5JHg3BfCE5driOAL4oOjjltkexiJCfQxoU72VFiFPG+rj/4dw/jS8Zaf+Z
 ZW1q23/yu3TnvLzmrRX1b/r5lh12W9EMdVgKzlEswybyHPL2COJgZkMmlPuRdnyx1NKckDbO9Vc
 wK4Z/WR3dFjFNl5KdXaXhGnp1vQPzpeTfx01CMtmHiJeU7e53QyTJMNpm4OMO7QExORHBMI9r7D
 jeg9Iyouxa42ogoAkgnSUr9McrP3j2CRb/8ovWS79D70vWvww31D+k3w+VJ0qMKeR6P0Naln5BH
 Q1vsHIU26zR3IdICYmEqLkxVhatxuPbbfvKMSJOXAF2pdTvdmex7N9327vSezIKRirCLaYcOJYs
 0fbGnZWuQtWIeeiVGQJNGJNfTTdLzO5tKBF9yCTzMDslqP/v3bHa4M18HgoIqA0xQzuqr4os11R
 KsMqJheHN1f4NFeLK57usokn73ySmNucqs8gTlOMwpWx4=
X-Received: by 2002:a05:6402:455a:b0:699:39c5:204b with SMTP id
 4fb4d7f45d1cf-69e6528aa2cmr4079154a12.18.1784557484524; 
 Mon, 20 Jul 2026 07:24:44 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69e6fff5efasm4999534a12.26.2026.07.20.07.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:24:43 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Link Mauve <linkmauve@linkmauve.fr>,
 =?UTF-8?q?Nikola=20Medi=C4=87?= <nmedic89@gmail.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Daniel Stone <daniels@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Dieter=20N=C3=BCtzel?= <Dieter@nuetzel-hh.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/4] drm/amdgpu: Support DRM format modifiers on GFX6-8 (v3)
Date: Mon, 20 Jul 2026 16:24:36 +0200
Message-ID: <20260720142440.22076-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. The new modifiers encode all the details
needed for tiling on these GPUs.

For the exact details, see the commit message of:
"drm/fourcc: Add modifiers for AMD GFX6-8"

For a userspace implementation, see this Mesa MR:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41557
And for libdrm:
https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/481

Supporting DRM format modifiers on GFX6-8 will
unblock many things in the Linux graphics ecosystem
that previously either didn't work on these GPUs
or had to implement fallbacks.
For example, compositors written in Vulkan or
compositors running on Zink, interop between
different APIs (eg. VAAPI / OpenGL / Vulkan) etc.

Changes from v1 to v2:

* Fix checking DRM_FORMAT_MOD_INVALID

Changes from v2 to v3:

* Return -EINVAL when pipe_config is invalid
* Log unsupported array mode with drm_dbg_kms()
* Fix block size calculation in amdgpu_display_verify_sizes()
* Add NULL check to amdgpu_dm_plane_add_modifier_dedup()
* Fix tile size calculation to bits not bytes

Timur Kristóf (4):
  drm/fourcc: Add modifiers for AMD GFX6-8
  drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
  drm/amd/display: Support DRM format modifiers on GFX6-8
  drm/amd/display: Don't use tiling flags anymore

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 144 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 343 ++++++++++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   3 -
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    |  84 -----
 include/uapi/drm/drm_fourcc.h                 | 209 ++++++++++-
 6 files changed, 641 insertions(+), 171 deletions(-)

-- 
2.55.0

