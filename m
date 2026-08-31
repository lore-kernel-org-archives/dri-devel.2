Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B861CC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B791110E932;
	Mon, 31 Aug 2026 15:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SRKOOnMi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B0910E932;
 Mon, 31 Aug 2026 15:34:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A785E43370;
 Mon, 31 Aug 2026 15:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093881F000E9;
 Mon, 31 Aug 2026 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190469;
 bh=1ZkxY6NkxbhecryFfgzu/0MTmHpe1AzVtczIQ/W/g9s=;
 h=From:Subject:Date:To:Cc;
 b=SRKOOnMinCy8jLRzFzW2cgMl2X/vRuJPkuZy5ndDpSW/jrh37A1E704bEM/TDisIH
 +1lU1AJ8R+i8VgbzGcUMJFnGLfUWNwIrywrfPObjxPA/HJgBfTuLhLRplrj2VkmCm3
 QbBw8kxmfnm0AH7rbXF8g/3nbNoD7A76acMkQuQWlnByr7Icv6Vv8Uw4435AiwOTf5
 IkPQmBIAGl+QFiYWBk0diOWSARSBpWQaCkGJ3frn4WHl7RA8QlS4npe+sqs02yhAy9
 Jk4x1YAB7pTyXs+CIXVPpSyPjn/a19m2+CDKiQOzawmVC0oCuyES9BkNlT9WXnA4lj
 qOEkNlZuP/6MA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Date: Mon, 31 Aug 2026 17:34:13 +0200
Message-Id: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBAGX4Xs2TUtlh85+R6GA5QFGqXVbSUaw
 rtb4exxNvtNZgFPbMhDlSzANBtvnI2QHhLQY2MHQtNFhlSkuSjEGTue0DqcHBNqDhqZPAWUqlF
 d1uqyUxLi+MHUm/cmvtY7Mz1f0R/2I7SNjwY3TSZUiSh0nmuSlCsFv//R+OD4s3XNchtsCWUq/
 yXMEgX2bXE+qSLTImsuN2JL96PjAep1Xb+jMvC47QAAAA==
X-Change-ID: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Paul Kocialkowski <paulk@sys-base.io>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680; i=mripard@kernel.org;
 h=from:subject:message-id; bh=dPiqUL5/7dbfzEjEVwq4GnmXEbGSHIabl+HIVzRAoSw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlT5/1+xrnTREXr2vW49ScKDwmLpvF3T/NLDM9eyPe5Z
 dfy9VySHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiDSsYG74+6Nvkk7D2w5+z
 Z+e98jZRLpda86CbU/GUislL9pke/WKiH5+8+faLV3/d2liGdTnLrBnrTA5IvFrrcM3e9PRPf/Y
 MxgLeJc6TShODVcO/s3d+Zr33wL29ImAix5nfT0+FzTzWatwCAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

This is a follow-up to the plane reset removal series, and part of a
larger effort to remove the reset hook from all KMS objects.

The CRTC reset hook is overloaded: it is called both at probe time to
create the initial software state and during suspend/resume to reset
hardware and software state. These two roles have different
requirements, and the reset hook is not fallible, making error
handling difficult for the initial state allocation path.

While reset has the semantics to reset both the software and hardware
state, the vast majority of implementations and all the helpers only
reset the software state, making them equivalent to
atomic_create_state in practice. The atomic_create_state hook makes
this explicit: it only allocates and initializes a pristine state
without any side effect, and returns the state pointer or an ERR_PTR
on failure.

This series converts all CRTC drivers tree-wide from the reset hook to
atomic_create_state, then removes the reset hook from struct
drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
hardware reset logic mixed into their reset hook; those are moved to
CRTC creation instead. The conversions were done using a combination of
Coccinelle semantic patches and manual adjustments.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Fix indentation in logicvc
- Fix hardware reset at probe and suspend for loonsoon and tilcldc
- Fix state creation for amdgpu
- Rebase on current drm-misc-next
- Fix commit message for st7920
- Fix merge conflict for mediatek
- Link to v1: https://lore.kernel.org/r/20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org

---
Maxime Ripard (13):
      drm/crtc: Introduce hw_reset helper hook
      drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
      drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
      drm/tilcdc: Move hardware reset to CRTC creation
      drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/loongson: Move hardware reset to CRTC creation
      drm/loongson: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/sitronix: st7920: Convert to atomic_create_state
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 28 +++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 20 +++++-----
 drivers/gpu/drm/drm_atomic_state_helper.c          | 45 ----------------------
 drivers/gpu/drm/drm_mode_config.c                  | 17 ++++++--
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |  2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               | 30 ++++++++-------
 drivers/gpu/drm/mediatek/mtk_crtc.c                | 18 ++++-----
 drivers/gpu/drm/sitronix/st7920.c                  | 12 +++---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  7 ++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  2 +
 include/drm/drm_atomic_state_helper.h              |  3 --
 include/drm/drm_crtc.h                             | 12 ------
 include/drm/drm_modeset_helper_vtables.h           | 14 +++++++
 15 files changed, 94 insertions(+), 120 deletions(-)
---
base-commit: 07c66ce1e6446f5cc6a4ace99a8d46880f45c527
change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

