Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE4C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD07310F995;
	Fri,  4 Sep 2026 09:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NFHQ+vIc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB4AC10F991;
 Fri,  4 Sep 2026 09:07:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 931F7438B9;
 Fri,  4 Sep 2026 09:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB861F00A3D;
 Fri,  4 Sep 2026 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788512852;
 bh=Ak5pg2JYPWzF7EP+btUCOYF7Pqr/oHizTCmEZa5J6Lc=;
 h=From:Subject:Date:To:Cc;
 b=NFHQ+vIcDkIBavKoh+3qqxNnD40Q8v/gd7zlAc4v+vZs/07bJ56voIymsAWRViEYo
 uodn262iAfL45GFSHVWh9hfkKXySqa+FlWc5dmFOZf2iFCI49JeypJIxRWks1VpY5r
 H4sVAaDEZJ4dut+98ZPV0SDn0VfHTctGQX44biJ5+1Lt4YWjHT5abm/lW8M8MnCsyg
 lvA/NwUuFZ0IXT8tHlrl6+gYuGY35DEkuxEw8ojIr9wzZxRS9+0RXviuWoYNfwokeD
 Vmxu/0O2vx1TmeTYXq0KQn0RnvQWgj19ROmQ+VxzSmj8zwPpWuALf0+7IpNvAI7ISj
 0/uG3dNzAEysg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Date: Fri, 04 Sep 2026 11:07:18 +0200
Message-Id: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTW7DIBAF4KtYrDMVf67jrHKPqgsM4wQ1QDJQK
 1XkuxeTTbvI8o30vnkPlpE8ZnboHoxw8dmnWIPadcyeTTwheFczk1y+84GP4ChATBASIVgqFgg
 zFhDaaNdPdu+0YLV8JZz9vcEfn89MePuufnke2WRyFVIIvhy6TQ0+W4h4L7A9g/qLK7Z1zz6XR
 D9t4yJauc3ZS/FqziKAwzwNo9JDb3lvjl9IES9viU7NXOQfR712ZHV0z7nTo1FqmP8567r+Akv
 7q+xBAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1jAbLuNR6wqV2cwaiRKM0UVnvVD74u+3QS3oAylAxXU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmzurwTLWUd5bVss7ec92DeKXxh9Rp9PTkBy3ZDCwM9F
 7WLB5d2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIlcVmOsz7njLHBnhVP546y3
 RoUiCzX0S6w1c8qdzrZ2pAu6VXhOrqrkKgz6wXxBjdfK2WPb52mMtcI/djJ6l7i2qKz1yPbeXjf
 n6mKd90fndp9IypsmasY7u/HQhVkFiwq83isee1mgYKh+DwA=
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
Changes in v3:
- Test if crtc->helper_private is set before accessing it, and call the
  temp variable to store it helper_funcs
- Rework outdated commit logs
- Fix error path for amdgpu_dm_crtc_init
- Fix new amdgpu tests doc
- Rebased on drm-misc-next-2026-09-03
- Link to v2: https://lore.kernel.org/r/20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org

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
      drm/tilcdc: Move hardware reset to hw_reset hook
      drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/amdgpu: dm: Convert to atomic_create_state
      drm/loongson: Move hardware reset to hw_reset hook
      drm/loongson: Convert to atomic_create_state
      drm/mediatek: Convert to atomic_create_state
      drm/sitronix: st7920: Convert to atomic_create_state
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 31 ++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 23 ++++++-----
 drivers/gpu/drm/drm_atomic_state_helper.c          | 45 ----------------------
 drivers/gpu/drm/drm_mode_config.c                  | 17 ++++++--
 drivers/gpu/drm/logicvc/logicvc_crtc.c             |  2 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c               | 30 ++++++++-------
 drivers/gpu/drm/mediatek/mtk_crtc.c                | 18 ++++-----
 drivers/gpu/drm/sitronix/st7920.c                  | 12 +++---
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  7 ++--
 include/drm/drm_atomic_state_helper.h              |  3 --
 include/drm/drm_crtc.h                             | 12 ------
 include/drm/drm_modeset_helper_vtables.h           | 14 +++++++
 14 files changed, 96 insertions(+), 122 deletions(-)
---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

