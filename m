Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37420C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87ED110E278;
	Tue, 15 Sep 2026 14:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsWkms5o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140DD10E278
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:24:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D273843F1E;
 Tue, 15 Sep 2026 14:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BABA1F000FF;
 Tue, 15 Sep 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482293;
 bh=u4z9ICU3bOpoc1/B1eQYXcAn0LuMTUTGKhSXvpccggU=;
 h=From:Subject:Date:To:Cc;
 b=DsWkms5oiCzwYo71Q9+gTQZFEdlrkC+pdZ1sYTvS3jieyss8Kh5u6javpEtvXY61L
 UkHJNEGy7YVcX0Wb86HEvlO+NgpI5v65K/zBnOiML0P2YYMoBq565hxKe33Rc015Yk
 c5g7wyPE4tbVlVnOVz610wc55j+BoScORt/J4SnjmgIADjoqNBN5uNlntkhZKnt/1M
 5hB3lmPPo4Rtgo5nRs2EJuHya7B1F+eif4bc/hBKT21ozjPQSaDfTEsJ6FMOx+dYGk
 B64/3RViOYWdmB1jTUZxEhfSKmqgMm+havBmaxorlHRFNSs6nBNydr0R0WtkHf0fuC
 w0rHGxisIcjJw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 00/11] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Date: Tue, 15 Sep 2026 16:24:41 +0200
Message-Id: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTW6DMBAF4KsgrzuVfwFn1XtUWYA9JFYLbscOS
 hVx9xqyaKqI5RvpffNuLCEFTOxQ3RjhHFKIUwnmpWLu3E0nhOBLZpLLmjfcgqcRpghjJARH2QF
 hwgxCd9qb3rVeC1bKX4RDuG7w+/GeCb8vxc/3I+u7VIQ4jiEfqlUdQ3Iw4TXD+gzKL67Y2j2Hl
 CP9bBtnsZW3Oa0Ue3NmARyGvrFKN8Zx0719IE34+RrptJmzfHDUviOLow3nXttOqWZ4ctSfY7n
 edVRxZONta4UR0uGTox8csb9HF6euJXLnfCuM++csy/ILDEZrrtEBAAA=
X-Change-ID: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3959; i=mripard@kernel.org;
 h=from:subject:message-id; bh=43PxzAp7M4MuOXBNjLgNIXFR8fETzRN92LNXX8qD//A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ3Wmz/rfdWBVwrGudZ8EH6kVbXvF0B9TfXKCrrNxn
 Vt6nZhpx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjItoOMDQuuLg9l04rvvzlp
 0pJnDRNaItri5mz/FfZz4cdaTQ228qvbdqWrM1/4KPSh8m9gNfOmm4wNB+0nXXdIE7JuWLjryC5
 3YYcZPE9N7ky9I/4ypYxla5G+5XuOVMP387euy2Q4uMhj45u5AA==
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
Changes in v5:
- Convert more drivers recently posted
- Link to v4: https://lore.kernel.org/r/20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org

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
Maxime Ripard (11):
      drm/arcgpu: Switch to drm_atomic_helper_crtc_create_state
      drm/aspeed: Switch to drm_atomic_helper_crtc_create_state
      drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
      drm/mcde: Switch to drm_atomic_helper_crtc_create_state
      drm/pl111: Switch to drm_atomic_helper_crtc_create_state
      drm/repaper: Switch to drm_atomic_helper_crtc_create_state
      drm/tve200: Switch to drm_atomic_helper_crtc_create_state
      drm/xen: Switch to drm_atomic_helper_crtc_create_state
      drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
      drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
      drm/crtc: Remove reset

 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  |  2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c | 45 -------------------------------
 drivers/gpu/drm/drm_mode_config.c         |  4 +--
 drivers/gpu/drm/mcde/mcde_display.c       |  2 +-
 drivers/gpu/drm/pl111/pl111_display.c     |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c             |  2 +-
 drivers/gpu/drm/tiny/gm12u320.c           |  2 +-
 drivers/gpu/drm/tiny/repaper.c            |  2 +-
 drivers/gpu/drm/tve200/tve200_display.c   |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c   |  2 +-
 include/drm/drm_atomic_state_helper.h     |  3 ---
 include/drm/drm_crtc.h                    | 12 ---------
 12 files changed, 9 insertions(+), 71 deletions(-)
---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

