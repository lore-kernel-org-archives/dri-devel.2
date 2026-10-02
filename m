Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E31CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A984510E5B8;
	Fri,  2 Oct 2026 18:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FH6x0DJL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD91610E64B;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 80AE4440BA;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AAD7C4AF12;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790964560;
 bh=l1OzNkOrsT4f5QBYOcpWrv54bWAYIeRE0abj+dKKwBA=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=FH6x0DJLjZ2LgrZL7UKwW2tiMLbMO2JJxqmK9LYxUb1qgZcn2cI4A5au3NcD/TIpV
 HMLgztaxU3u24+tlLnyvqBG+tuffWfR0QAs4crZ8cOQ/cRWjsFPrJyn+ywKSFDuESC
 6Y2KzeAwJjR9+yCkP4fpCl9dnPRAmE2dofzRAyoiBA8Pf8LheXafRW9/oEdkJqUAja
 /fn+6xJCTGO1d0B8vIGR96kPCJ6eMTiZ1u26It09iTqjzCsdQGWeAd4X+0BBeSdOZE
 jHzurvSJnLJIAAPTy0DbG70IOBTnP12jT9YW9KlgPhICe35OePRNucAZysvWNoXkIj
 lV4W7OaMpGW7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 36DB8CA5FD4;
 Fri,  2 Oct 2026 18:09:20 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Subject: [PATCH 0/3] nouveau: fix 3 null-ptr derefs
Date: Fri, 02 Oct 2026 12:09:11 -0600
Message-Id: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwMj3dxK3bTMitKCYl1jI5MUI9M046QUA1MloPqColSgDNis6NjaWgD
 ve9JlWwAAAA==
X-Change-ID: 20261002-my-fixups-324d25f3bd05
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790964559; l=908;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=l1OzNkOrsT4f5QBYOcpWrv54bWAYIeRE0abj+dKKwBA=;
 b=bXg0YQm+JVFbyAzzrzbNaZnEeFWLW14SND0qnTb+OO0T8mgIoGF83EMcWZVbPeVO4LtzhBBXM
 i9k/xEtCNBvA4mTBQOfIKjqqsxuQj6i1jUC56re/dmmCcj4oQxXrNOq
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
Jim Cromie (3):
      drm/nouveau: Fix NULL pointer dereferences in GETPARAM ioctl
      drm/nouveau: Fix NULL pointer dereference in GET_ZCULL_INFO ioctl
      drm/nouveau/gsp: Fix NULL dereference in nvkm_gsp_gcx_ready()

 drivers/gpu/drm/nouveau/nouveau_abi16.c           | 27 ++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c    |  2 +-
 3 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261002-my-fixups-324d25f3bd05

Best regards,
-- 
Jim Cromie <jim.cromie@gmail.com>


