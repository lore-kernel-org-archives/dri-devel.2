Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA97C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E03F310E5F1;
	Mon, 28 Sep 2026 13:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HXqIJC4R";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CE010E5F1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:05:18 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-880483985aeso1182179b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790600718; x=1791205518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k2Kcx8g6kY/kQqDl0Mqqux8bu7JzTOoQQ3nn8/Jqdrk=;
 b=HXqIJC4RZehBplp9NKxBXep7stPI4XKzquYkbCNIt22I1KKGo1I1tjp9Ii1VQwPcfi
 X0UIagajFxc03Nx9u0qauCjNEHWkmNNTnF9kkoN6TM2ozX9mQUfp1WY+qKaq2OkVRPPT
 OmvNCByCSGbPG1GwFjROvIXQQ0fIaWBNRFbtgr0NuGK/0PbfQVcRE9cOacLBd99GFzun
 gSC0VpZSfAsI39NEELjzTjr2+r34rHqgbICN/dQstroBYdJ1zwotU812YSSD3JLHI4Vz
 QFp17lcy4/9DNfYU1D//T1omeV6SxBd+ySo4iargRcw+VhqlFwV4+YSs0x3wKOg+0j6a
 rLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600718; x=1791205518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k2Kcx8g6kY/kQqDl0Mqqux8bu7JzTOoQQ3nn8/Jqdrk=;
 b=Vs4vOx46sqOogOHRo8LCoITJPLu2yDZIpjC2F+o+qWB4/vf7J+OBLvRNBDrFZzSTwm
 LepZJI24Ou68PZdIcsZj0aXBLJ7X40TzwYELx8c67/lv6JjmbVtiKE2LZWP2FjLn7hAA
 UVcPohAxS5XN6kXwv7WAzVbGe+5c2EIQmKB14hij8CuE6MOMZSLya2e4Cea/dVGbzIhQ
 W4IiP2XtMBGbobwUHNGzoyKIZXWnEf06DBpxMt22s5pIMvyt/s0M1EidgHa/K1KcR/pc
 fM0YvPCE2lGNp2e/VOPkZY5Dd9mgjwcZA4JyrkMBocFqHzF7fpN96feTi1fO3d2Bd1Fu
 T4+g==
X-Gm-Message-State: AFuF++mEnERBoZd25C4xcR4IaFlm6I6e8fRgPZ3Fjtqm+iZVANjqMHbx
 efOfl7SNT1P8a6P0W18jF/rT/nli/J+K4R518UmRUiqc1RTHJN8UsnRF
X-Gm-Gg: AYBFou0EnPefn66t3zD8+iRS+wJ8GxtieaEtY08tCf9MtjuVUc0qn6/RRXdYSXNHzM1
 XGdR7klwFxBlbXqeQjQzz2oQXWNcqQ1KFvhVseF0BuhYonQ0BnPTYqQ8ZZ4w7fPpxL8AF6J0bk4
 SOZMPWBb12hE9JtiCTpAFKS2tanRgaIS4/Lst66fvupMqIIsNRJdTIg8/WJTakLNT39elYpChAt
 7VlcY1sWgcuYv3nM5HnsO8DAzHANiUqcNQk9+5QNQy7RyAqDj9drB/FpeMZbYSWj+c4p4kr9ADw
 F86W/jwdgb2W03X1b4CaDQweSI1fMoWEOfk11FOLnleeffmQ4wkuwEwAaFuJ/hoUI+gO1Ey2KmU
 PhUVqE4LddHzmYTE6wGLfbHW7K1/mAIgivp1Ee6ZF6m8Iqqp/0dr6DrdTH4TGNeAkcB8OYVh9Wj
 sMmaHJmQoJIm1pUzSX3EJ7pUqdnKIhMS6n6afQAGbFtcVQ27kLUmzvJs80bAr0eu3LDFCcm0Vo1
 lX6I//QGCxQGwS8Mmjnw73/QQjMcwV4g6wJ7j/Fmbfl/NfWQjR1Hsgrj0x4dq/4t6yihl4oOIk7
 VViHe9wz
X-Received: by 2002:a05:6a00:138d:b0:881:7ff5:606f with SMTP id
 d2e1a72fcca58-8817ff56367mr4741460b3a.43.1790600718146; 
 Mon, 28 Sep 2026 06:05:18 -0700 (PDT)
Received: from daeinki-virtual-machine.localdomain ([58.124.60.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18f49csm4083555b3a.20.2026.09.28.06.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:05:17 -0700 (PDT)
From: Inki Dae <inki.dae@samsung.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org
Subject: [GIT PULL] exynos-drm-next
Date: Mon, 28 Sep 2026 22:05:14 +0900
Message-Id: <20260928130514.47167-1-inki.dae@samsung.com>
X-Mailer: git-send-email 2.34.1
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

Hi Dave and Daniel,

This PR brings three fixes and cleanups for Exynos DRM, addressing a
clock leak in FIMD, simplifying user memory handling in VIDI, and
fixing a Sparse warning in FIMD.

Major changes are:
- fix a clock leak in the FIMD resume error path by disabling
bus_clk when enabling lcd_clk fails,
- replace the open-coded kmalloc() and copy_from_user() sequence
in VIDI with memdup_user(),
- fix Sparse address space warnings in fimd_trigger() by adding
the missing __iomem annotation to timing_base.

Please kindly let me know if there is any problem.

Thanks,
Inki Dae

The following changes since commit 2abe8e7e33973dda5dd24b89aa3ee52470a78265:

  Merge tag 'amd-drm-next-7.4-2026-09-24' of https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-next (2026-09-26 08:13:22 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos tags/exynos-drm-next-for-v7.4

for you to fetch changes up to d04392ce52d33bce4d532bd8b965151ed4ce8670:

  drm/exynos: fimd: fix clock leak on resume error path (2026-09-28 21:44:02 +0900)

----------------------------------------------------------------
Exynos FIMD fixes
- Fix clock leak on resume error path.
- Fix Sparse warnings by adding missing __iomem annotation.

Exynos VIDI cleanup
- Replace kmalloc() and copy_from_user() with memdup_user().

----------------------------------------------------------------
Chen-Yu Tsai (1):
      drm/exynos/fimd: fix register offset type in fimd_trigger()

Mohammad Shahid (1):
      drm/exynos: vidi: use memdup_user() instead of kmalloc() and copy_from_user()

jiawen (1):
      drm/exynos: fimd: fix clock leak on resume error path

 drivers/gpu/drm/exynos/exynos_drm_fimd.c |  3 ++-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 12 ++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)
