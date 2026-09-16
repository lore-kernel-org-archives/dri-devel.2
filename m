Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F1EC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029E010E11D;
	Wed, 16 Sep 2026 08:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nKlVHyxH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBEA10E11D
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:55:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E2BBA43C5D;
 Wed, 16 Sep 2026 08:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390691F000FF;
 Wed, 16 Sep 2026 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548955;
 bh=ncjKj7fR9z+9q5UO/HoeGDg4uUgsfBDZI7Lv9S9mQCU=;
 h=From:Subject:Date:To:Cc;
 b=nKlVHyxHCW2ERJ9o2l3S/Yz8ue/nltTZovUnoY6Bp1D0Y/4bUnisHDW4j8TjNRQtT
 BpILpTANTIVb8yGoUCifcAuoGHM0yUnZnrFTBPpQrvacBcOGKDSyUY0Lws/QeqvWZX
 ybsqHoAID1tHWpwZuolurR0GJQo6zqjzk3CbLhUTMd9b4huMSMa0oASmX3uuvM5gu3
 dhINJMms/WYSWRhvVAuF9OT38FgxH+DHEOpvllYIbdt7enXhMBxupLr6JazVE/4zwH
 AWn6dO2QueRJx1PgKQz4j7X59duaXfom7CNG6yfSw3ut5fgilDUQHwJOgiSWiBlBea
 c3oR+UgKk/A8A==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 0/9] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
Date: Wed, 16 Sep 2026 10:55:43 +0200
Message-Id: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRTW7DIBAF4KtErDsVfzaQVe9RdYFhSFBjSMG1U
 kW5e3G8SKvIyzfSfCO9uZKKJWIl+92VFJxjjTm10L3siDvadECIvmXCKe9pzw34MkLKMOaCcD7
 ZhFCw4gRUmo4GyZGqQNr2uWCIl7v8/tHyMdYpl5/7oZkt09VUdNucGVAQlHuj+4BdoG+fWBKeX
 nM5kAWd+QPSTG5DvEGae2564T0T8gkSfyDBtiHRIKaVcsraTg3iCZIPyFC9DckGWcEGEVxwRpt
 /0G0tsODXd/vItLZIBlsRXB7HOO13CzzG6iDhZYLlHrQmqWjLt1/Y60Br1gEAAA==
X-Change-ID: 20260629-drm-no-more-plane-reset-04950f42e07f
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3521; i=mripard@kernel.org;
 h=from:subject:message-id; bh=p/PxgkWdJUyQjexMpEPExuXlrANKPPTFnbtlyreS4AE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIicLrReecZ5RMlj8J2/xIb7AV59Mvl8+OHeL/Pprk
 zu7PA//6JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWfWAsVa+umJ2hiLj07lP
 +RdNPf9rxuFHVj8tdRuqlPLvOm86H/eUdZap+Zo5hmlihxWfPY5e6cxYpxJQ42B9JvV2Wu0d7tb
 rHFnK7keP1xc1lNfeuc0p+/eS09uVD0I9FVf9UHBUDbxbYuoGAA==
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

This is a follow-up to the bridge reset removal series, and part of a
larger effort to remove the reset hook from all KMS objects.

The plane reset hook is overloaded: it is called both at probe time
to create the initial software state and during suspend/resume to
reset hardware and software state. These two roles have different
requirements, and the reset hook is not fallible, making error
handling difficult for the initial state allocation path.

While reset has the semantics to reset both the software and hardware
state, the vast majority of implementations and all the helpers only
reset the software state, making them equivalent to
atomic_create_state in practice. The atomic_create_state hook makes
this explicit: it only allocates and initializes a pristine state
without any side effect, and returns the state pointer or an ERR_PTR
on failure.

This series first adds the necessary infrastructure in the simple-kms
and GEM atomic helpers, then converts all 51 plane drivers tree-wide
from the reset hook to atomic_create_state. The conversions were done
using a combination of Coccinelle semantic patches and manual
adjustments. Once all drivers are converted, the old helpers and the
reset hook itself are removed from struct drm_plane_funcs.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v5:
- Convert former simple-display drivers that were recently merged
- Link to v4: https://lore.kernel.org/r/20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org

Changes in v4:
- Fix a NULL pointer dereference with vkms
- Rebase on drm-misc-next-2026-09-03
- Link to v3: https://lore.kernel.org/r/20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org

Changes in v3:
- Drop leftover state destruction in sun4i
- Rebase on current drm-misc-next
- Link to v2: https://lore.kernel.org/r/20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org

Changes in v2:
- Rebase on latest drm-misc-next tag
- Fix sashiko reviews
- Fix atmel-hlcdc breakage
- Link to v1: https://lore.kernel.org/r/20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org

---
Maxime Ripard (9):
      drm/arcgpu: Switch to drm_atomic_helper_plane_create_state
      drm/aspeed: Switch to drm_atomic_helper_plane_create_state
      drm/mcde: Switch to drm_atomic_helper_plane_create_state
      drm/pl111: Switch to drm_atomic_helper_plane_create_state
      drm/tve200: Switch to drm_atomic_helper_plane_create_state
      drm/xen: Switch to drm_atomic_helper_plane_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      drm/plane: Remove reset

 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  |  2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c | 41 -------------------------------
 drivers/gpu/drm/drm_mode_config.c         |  4 +--
 drivers/gpu/drm/mcde/mcde_display.c       |  2 +-
 drivers/gpu/drm/pl111/pl111_display.c     |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c             |  2 +-
 drivers/gpu/drm/tve200/tve200_display.c   |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c   |  2 +-
 include/drm/drm_atomic_state_helper.h     |  3 ---
 include/drm/drm_plane.h                   | 12 ---------
 10 files changed, 7 insertions(+), 65 deletions(-)
---
base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
change-id: 20260629-drm-no-more-plane-reset-04950f42e07f

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

