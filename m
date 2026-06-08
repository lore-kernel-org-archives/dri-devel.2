Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB23CD8CA7
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 22:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2B10E0AE;
	Mon,  8 Jun 2026 22:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="EUKb6AVD";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3B610E0AE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 22:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780958048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PK1mPO5vde6l1FvC5WVqO2Ta/fLDugSu0eId/GaU3H1kUi8QEPP42SGE3uUd27la+ODp/6kBJ2aY0WoX17Vw/DjkNE268JyMiOUP0m2f73ySYgJBeznTTu2UVtEUDcWQm4zMsp9f03rtQV/kwZXaJwEpWpnXfOZkFbNIleXzmww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780958048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9gFemFVrmoMvSMa4Ins8uwd1ZcaAF3uo054cZ58cGFQ=; 
 b=dKcXZb8HYEPMvpil7ocrLbEGtW+D5q2iDHNTC9SlO6RWl5FveqETMLivi7ST8dbS4SoUT5k641I773oilMyDYhyoTDrhhTfCFeU2wxNlPU5oJdXRlXn0RJwS467ZdYy+k5zZF4+MWVkXRaaH4lbpxEzrThlY74y7R7U33X04MNY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780958048; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=9gFemFVrmoMvSMa4Ins8uwd1ZcaAF3uo054cZ58cGFQ=;
 b=EUKb6AVDs45H0qQrHOpgv4gIhgsCv1txW28Ew2nnwi+sYoddIH0+Em2OmA5Waxks
 JidZ7BmyolUoy2+gI25aLXELngGXYJA1c31UfpAsHSEtJRbDZd3YVOEVLrvlRL9g9Wg
 wptp0+ulKqpGsWLCh7qLEBY1TdFoQn6KHX0qWVFs=
Received: by mx.zohomail.com with SMTPS id 1780958046551846.2999318823079;
 Mon, 8 Jun 2026 15:34:06 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v2 0/2] drm/gpuvm: Delete some dead code and fix a comment
Date: Mon, 08 Jun 2026 23:33:51 +0100
Message-Id: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBREr2JYFwOoFLvqPRoXX/xVGgEDatoY7
 17U5cvMvNlIxGAwkke2kYCrica7BOKWET2A65GaLjERTEgmmaL9tKyWWuN8oG/zxUglVkxBB7U
 ogKTdFPAM0uzVXByX9oN6PkRHYzBx9uF3nq786F3+5OFFpXiZF6KW6l5STqELBlw+Qlhsi0/tx
 xFaHyDX3pJm3/c/2ezS9MMAAAA=
X-Change-ID: 20260608-gpuvm-minor-fixes-6e508ada923a
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=NR/VdA5ta7BU4i+vmkMzBmN+rdsAORdS9m34a+5bdJQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqJ0NbU91aputjN8KOJ+tdkc5/BQTklaGF6TSsx
 M52U9T+KrCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaidDWwAKCRAOJn5M7lND
 PbKGC/94iVU9dOl1+iCpkCcrTfZc6E6i7Zx3QsMHINdmYmc2SO0PfY1+ST2ai9mGK6Zbl/9zilb
 idMV/iq1E7WYR1neTvIzCIugF0ZAXemx4SHOZc6m6klQyDZzWs5Lgelppc24A1mMsEMS421pZoG
 qPsIEPoofz95kz3hEWqwFHL9pK4u6p7gjhWG4J/XrEvaK+jkG/Kix7Sl8M+L40q3N4KI8pvHcPy
 fk6qT8WSZfyc97s6g5jZ3ff+IrFtGGrLm5an+7B4U7iicFxg/NoVhu9QO8cB/A77xdvpbGUpRR0
 aDu8C6KzhE2q87MQhfE5Bi2kgFVvmcW4ZBpPsJaXZvz7qWUi+ug78fw6/nLynu0Hv5ItMLhBFyU
 THQKFaBX3AVaDDX6K44MmImJu5pqsb3UMU4oirQNvO9xJt/cJqOm4rkEggJaTa9DHqmaVJvKioU
 WwtF8tBF1btxVRrW2h252EGQp5bVK88Id624x8+YQ763lli8Z3kuiCbcnKdNjyxnJGaWY=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Just some small fixes I made when reading drm_gpuvm.c.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Changes in v2:
- Deleted even more dead code.
- Link to v1: https://patch.msgid.link/20260508135814.3296874-1-adrian.larumbe@collabora.com

To: Danilo Krummrich <dakr@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
To: Thomas Hellström <thomas.hellstrom@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com

---
Adrián Larumbe (2):
      drm/gpuvm: Remove dead code
      drm/gpuvm: Fix comment to reflect remap operation operand status

 drivers/gpu/drm/drm_gpuvm.c | 44 --------------------------------------------
 include/drm/drm_gpuvm.h     |  4 ++--
 2 files changed, 2 insertions(+), 46 deletions(-)
---
base-commit: 6e7eb171ac96fefa32197afa658e7d9da238be89
change-id: 20260608-gpuvm-minor-fixes-6e508ada923a

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

