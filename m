Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26685CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAE510F971;
	Fri, 29 May 2026 06:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="OnifGIbM";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E8910F978;
 Fri, 29 May 2026 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780036495; x=1780641295; i=natalie.vock@gmx.de;
 bh=d4ariP1DzscyQuvtTdMQYU8O5GHKl8B6jQLJlrwRsOQ=;
 h=X-UI-Sender-Class:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:To:Cc:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=OnifGIbMpcsBo8Yo0rdsSoxDX4j1nlCvLSIwXnL20MEnbL1yQ9XlwmkJ5jGSi5j2
 t2GncetMmvHQ7+GsBkG2PIM2GwDSp8jGYtfMJDWdZ2fjHJ8+I4KZZTXRtOyWrGBms
 la+LXeJM7we7lYVWzkJdZkpl72bRRC9Vp60qznSzeTyfDsQ+kgGUTTwI46ziuvfYN
 86LwakD3Bmxcn622L7b7/oi940wUHHt/eyTL9sqYbxZJf7lD9a5mvRt7d+o+yU1Zx
 kTquzzjto34UjcrcxV9SGcU3ReHvp6xoFCR01/3qgOEbqYBFhB0v++EfZTChuw6DY
 N3azyp0g6bhC1HU9Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1xStG02dt5-00yhs1; Fri, 29
 May 2026 08:34:55 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Subject: [PATCH 0/3] drm/amdgpu: Explicit sync for PRT unmaps
Date: Fri, 29 May 2026 08:34:37 +0200
Message-Id: <20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJLSDBqxgWMB1ljKlNpxAI4
 e5UXL7F/xsoR2GFe7FB5FlUvj7jeimAxt6/GMVlgzX2ZmrbYogJeQkfIUmoqycsXVMNrXOVNQS
 5C5GfspzPR/e3TsObKf1GsO8HvnPK33UAAAA=
X-Change-ID: 20260529-prt-explicit-sync-3d74b9dd420c
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Provags-ID: V03:K1:3JsAMaM+Y+zdjE4xU0/AsqvftdBbG3AsrWIW+Q5Q4R2ZAqarurM
 Kn5Nu1HAWuMkFSST80xPjLRzJ0TDlpe2VHli7fG5XCO7Wxuqu2LAMA045sNL3RSyYJKejOa
 H4UjHnyq8ivHybkSXB03Q+MhzSDG7U6zOE7R+x0Ph4RaV0siXmFiODkEa3yTuBDO2STUbxV
 C3KeP3Nso9aXNBi2vtboQ==
UI-OutboundReport: notjunk:1;M01:P0:+PA/wRB7RvQ=;QsLnqvc25U+/MpPhlKL8LdbDqIt
 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
 +XwySy2x1liHjrYPpXSImhItWwo=
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

Hi,

here's another attempt at getting unmaps (especially PRT ones) to be
synced explicitly, i.e. without the implicit sync to every other
submission in the VM.

The motivator is that many games have come to heavily use sparse
bindings, and they often rely on being able to overlap frame work on
gfx/compute queues with sparse binding work on sdma. If we sync to every
other submission, heavy sparse binding load can stall the gfx/compute
submissions for quite a long while, leading to very noticeable stutters
and hitches.

Currently, we have one free-list per VM, but random unrelated mappings
might stick around in the free-list in addition to the unmaps performed
in the current VM update. It is obviously invalid to clear those
unrelated mappings with the same explicit sync semantics, so we need a
way to separate out the mappings that can be cleared with explicit sync
from those that can't.

To introduce that separation, patch 1 wraps all VM update operations in
a "VM update context". This context encapsulates some state that is
carried around different VM update functions, most importantly the
mappings that were freed along the way. amdgpu_vm_clear_freed then only
clears the mappings that were actually freed in the update operation.

Patch 2 builds on the update context to add some additional bookkeeping
and track if every mapping from the context's free-list actually
supports being cleared with explicit sync. If userspace requests it and
all conditions are met, explicit sync is then enabled for the PT
clearing operations.

In the UAPI, a new VA IOCTL flag is added to request explicit sync, and
the minor driver version is bumped to inform userspace of support for
the explicit sync flag.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
Natalie Vock (3):
      drm/amdgpu: Add and use vm_update_ctx struct
      drm/amdgpu: Implement explicit sync for PRT unmaps
      drm/amdgpu: Bump minor version

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  42 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  30 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c          |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  61 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c          |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c        |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 262 +++++++++++++++---=
=2D----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           |  93 +++++++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c           |  15 +-
 include/uapi/drm/amdgpu_drm.h                    |   2 +
 13 files changed, 396 insertions(+), 167 deletions(-)
=2D--
base-commit: 0b5b03275d8e8961706e5f61903e41e44e8ebfaa
change-id: 20260529-prt-explicit-sync-3d74b9dd420c

Best regards,
=2D- =20
Natalie Vock <natalie.vock@gmx.de>

