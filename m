Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AB0CA9EC1
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EE910EABF;
	Fri,  9 Oct 2026 17:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HAi1R6Vw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F3D10EAA8;
 Fri,  9 Oct 2026 17:44:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id ADF936020C;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A29C2BCF4;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791567878;
 bh=qFnpKLgFzGpj26HbsAUuI94pp4dsklj2mWHgmwxeK3k=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=HAi1R6VwFdZdDgMNDXY+jSa0hE1elP1TgR7VzarpmVmEXeAFBypu1FwYet+90mDd5
 3+FefKoxS6JB4hEK7RSshTde+5nW0vQttoNP46DBO7RhQyJYLfLwmI1gjvnNrFzBb7
 V7Xp4tSpDfJYBz012J/Lag952oYQ/NevKCvIE16v5trgtE1N1AJnyKkiTluuaV7jRs
 Itd+rEBSOZSa865E6sdFe4RsppkRyqoOKXNpTcjcEiBw/kV5QnURZCI8mQb2xAzoR+
 RJwil+Kyxsgk3Bc722vZ0WnU1ydFagTQvwYIWQB0A19G1Ni+yDINEEVr3Vu1fg59DX
 1ve5iyQxFlVQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 266FFCA601F;
 Fri,  9 Oct 2026 17:44:38 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH v2 0/3] nouveau: fix 3 null-ptr derefs
Date: Fri, 09 Oct 2026 11:44:23 -0600
Message-Id: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MQQ7CIBBFr9LM2jEwWKOueg/TBRZoJ5HSgBKbh
 ruLXbt8/7+8DZKNbBPcmg2izZw4zBXo0MAw6Xm0yKYykKCzFILQr+j4814SKjoZap16GNFC9Zd
 o67O37n3lidMrxHVPZ/lb/1WyRIH6ogwJdzXK2W70mp/HIXjoSylfYs7o76IAAAA=
X-Change-ID: 20261002-my-fixups-324d25f3bd05
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Daniel Campos Ramos <Capitain_Jack@yahoo.com>, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791567877; l=1161;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=qFnpKLgFzGpj26HbsAUuI94pp4dsklj2mWHgmwxeK3k=;
 b=OEhSJHp9zZcm8RTWFCmeE4sI2nqpOYo7auJz0s/ut5P7fLlcljs0MFsuz4wx0f1iMm/Qc967C
 +pW26iIYTamDg4NGjTSfFeMqshwHenCkouxE1zMqrcvqJEBI16Q8Zlo
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
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
Reply-To: jim.cromie@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

These 3 patches fix NULL ptr derefs I hit while booting kernels with
unrelated work (dynamic-debug) on a 2019 amdgpu+noueau laptop.  One of
them is possibly hard to reproduce, the others are "dependable".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v2:
- added check of gsp->rm into nvkm_gsp_rm(gsp)
- change if-then-else to if-early-fail, fallthru
- Link to v1: https://lore.kernel.org/r/20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com

---
Jim Cromie (3):
      nouveau: Fix NULL pointer dereferences in GETPARAM ioctl
      nouveau: Fix NULL pointer dereference in GET_ZCULL_INFO ioctl
      nouveau: Fix NULL dereference in nvkm_gsp_gcx_ready()

 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  2 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c           | 24 ++++++++++++++++++++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c    |  2 +-
 4 files changed, 24 insertions(+), 6 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261002-my-fixups-324d25f3bd05

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


