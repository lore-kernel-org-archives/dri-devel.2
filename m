Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63ADC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA10610F5F9;
	Fri, 11 Sep 2026 13:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SKYaTAGb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921FC10E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:21:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C205F6020C;
 Fri, 11 Sep 2026 13:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9A1F00893;
 Fri, 11 Sep 2026 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789132877;
 bh=vNwKUUvvCNVfx2ouPGqKKP8gf8WjOn3BQLDwezeaVH8=;
 h=From:Subject:Date:To:Cc;
 b=SKYaTAGbonMQn+l2Q0GyRsGqsfp27154Yoy7MQzJuZ55mfr5LMwc+Z/Fz9QQC3Dt6
 mLXNrCRrCu1L1wy9TtHaatfuK6xqTrj9KLIXc87aXLPAt5llk0T5gzrrAPScbpp2IH
 WNc8dtKHZAOhhqE/k8HStBh60bw0ewM/DR9qOkWPbwqd9jQMGXP3qqxaFpGtCYKPxH
 EnCQoQj45dqVcTBYXcjY0oEm+WhbxXV1sDs4VscdTKZVwHyzBkvmEYZYuqtqmbX9V6
 LRDEttOUPEyl/Cem3MuAEbVTr4FUFtrr/KFnjht5mo15yt65fW8j197Zs4pnPynoUV
 PjemJrDkBxwmg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 0/4] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Date: Fri, 11 Sep 2026 15:21:07 +0200
Message-Id: <20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTU7DMBAF4KtEXjPIf8FxV9yjYpHYk9YCx2XsR
 kVV7o6TLgChLN9I75t3ZxkpYGaH5s4I55BDmmrQTw1z5346IQRfM5NcvnDDLXiKMCWIiRAcFQe
 EGQsI3WvfDq7zWrBavhCO4bbBx7dHJvy8Vr88jmzocxVSjKEcmlWNITuY8FZgfQb1F1ds7Z5DL
 om+to2z2MrbnE6KvTmzAA7jYKzSpnW87V/fkSb8eE502sxZ/nLUviOro1vOvba9Umb856gfx3K
 966jqSONtZ0UrpMM/zrIs3xfasgqJAQAA
X-Change-ID: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2983; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aYGeAfEop7F56R+ERIliDCq49Xa6XHpodcXkMUCtCNI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlLGNyVdR+/zwntc+s31FMqCTa77yejsEw+X2/67ML0n
 9ZLJk3pmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNZ84ux4W2ayc8YC71nbj/0
 C7i6P+b+Pj6x+4/wDq3m5E3fDCS+pV1pV6yY9GFaTpOh9sN8VzFJxhq+RT+jeQ8mvt/GrVoS6Bf
 gFHfbNo5h6V/hVcWcnFVOlxIesr5na3IW/eGcbHzvfYpuBwA=
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
Changes in v4:
- Convert gm12u320 too
- Link to v3: https://lore.kernel.org/r/20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org

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
Maxime Ripard (4):
      drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset

 drivers/gpu/drm/drm_atomic_state_helper.c | 45 -------------------------------
 drivers/gpu/drm/drm_mode_config.c         |  4 +--
 drivers/gpu/drm/tiny/gm12u320.c           |  2 +-
 include/drm/drm_atomic_state_helper.h     |  3 ---
 include/drm/drm_crtc.h                    | 12 ---------
 5 files changed, 2 insertions(+), 64 deletions(-)
---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

