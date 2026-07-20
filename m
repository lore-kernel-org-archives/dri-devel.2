Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B0C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3C610E1F0;
	Mon, 20 Jul 2026 21:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d+mmrMkT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A22F10E1DB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784584382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YSp2bjmUTFzp0IbxCyAWq1OLo28SH+leDwAT8SY17rQ=;
 b=d+mmrMkTW1snTZALI8lPrqXYB0aDb0buMdGub8VWVqiHXmSUN8rJ7uAh0SNODkcaxoqPjJ
 2E6zL+QoQmTGqb5OyrA8HjF9xK9kTjSdCLgP4/avgTKeZ1Hil4renvCCJbH3uFoOKnCu1C
 LO1qY4psFi4yzDnQUetKLJX/KOz3MBY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-ovSgWrIrMkaUmMkekNLOwA-1; Mon,
 20 Jul 2026 17:51:49 -0400
X-MC-Unique: ovSgWrIrMkaUmMkekNLOwA-1
X-Mimecast-MFC-AGG-ID: ovSgWrIrMkaUmMkekNLOwA_1784584307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75A2D1944D42; Mon, 20 Jul 2026 21:51:47 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.88.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAFBD1800765; Mon, 20 Jul 2026 21:51:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Leandro Ribeiro" <leandro.ribeiro@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Kees Cook" <kees@kernel.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Pekka Paalanen" <pekka.paalanen@collabora.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Stone" <daniels@collabora.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 0/3] drm/nouveau: Fix WARN_ON() from missing blend modes
Date: Mon, 20 Jul 2026 17:36:15 -0400
Message-ID: <20260720215058.398210-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: gh872Q-9DHyVzimZcRLOiRnHqjsf5bdet8FTQtu4U2w_1784584307
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Recently a change went into the kernel to ensure that drivers which
expose color formats which have alpha channels. This would cause nouveau
to hit a WARN_ON when setting up cursors, since they do support blending
- but we never bothered trying to hook up the controls for it to
nouveau.

This fixes the issue by ensuring that nouveau always exposes a blend
mode for any planes with alpha channels, regardless of whether or not we
have control of the blend mode hooked up. If someone wants to add
control for this in the future as well, it should be fairly easy to hook
up with this.

Previous version:
	https://patchwork.freedesktop.org/api/1.0/series/170773/revisions/1/mbox/

Lyude Paul (3):
  drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
  drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
  drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for
    wndws

 drivers/gpu/drm/nouveau/dispnv50/base.h     |  6 ++++
 drivers/gpu/drm/nouveau/dispnv50/base507c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/base827c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/base907c.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c |  3 ++
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 +++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 40 +++++++++++++++++----
 drivers/gpu/drm/nouveau/dispnv50/wndw.h     | 11 ++++++
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c |  1 +
 12 files changed, 64 insertions(+), 7 deletions(-)


base-commit: b0a652436b892eb9a036a031b33099dca036faaa
-- 
2.55.0

