Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73FDC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE2210E1B2;
	Mon, 20 Jul 2026 20:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TleDMyXQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571410E1B2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784581021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lCLvRbAHrPlYXHkE86DNtpFaHEAL8XnsKtuQKxI5YcE=;
 b=TleDMyXQOydUueO+bdKdOlatWMnRY+3j4c0nxG//+en9S7+dl6lRRy6mgSYU5jGd5Va8vC
 maQ2IuMFPcSf0gaIHyByyn3KgXbDpe8Ou1vLgLOw1y4qML9JymEc3i2yy4A6WWAKaaDMX4
 j/RxlfR8bZSJ4qXQhTo2L08hCXn9vvI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-vIWM6IfIOYGM-CXIYFmv-A-1; Mon,
 20 Jul 2026 16:55:51 -0400
X-MC-Unique: vIWM6IfIOYGM-CXIYFmv-A-1
X-Mimecast-MFC-AGG-ID: vIWM6IfIOYGM-CXIYFmv-A_1784580949
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953BD180061F; Mon, 20 Jul 2026 20:55:48 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.88.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 337EE1955F7A; Mon, 20 Jul 2026 20:55:46 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Leandro Ribeiro" <leandro.ribeiro@collabora.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Pekka Paalanen" <pekka.paalanen@collabora.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Stone" <daniels@collabora.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/3] drm/nouveau: Fix WARN_ON() from missing blend modes
Date: Mon, 20 Jul 2026 16:43:54 -0400
Message-ID: <20260720205541.257781-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: T1t7ZCJHSsr1d2gZZXitY4fm2zig49B4Y9f0FroTmLs_1784580949
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
	https://patchwork.freedesktop.org/patch/741031/

Lyude Paul (3):
  drm/nouveau/kms/nv50-: Add .blend_modes to nv50_wndw_func
  drm/nouveau/kms/nv50-: Introduce nv50_wndw_default_state()
  drm/nouveau/kms/nv50-: Unconditionally create blend_mode prop for
    wndws

 drivers/gpu/drm/nouveau/dispnv50/curs507a.c |  3 ++
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 +++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     | 40 +++++++++++++++++----
 drivers/gpu/drm/nouveau/dispnv50/wndw.h     | 11 ++++++
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/wndwca7e.c |  1 +
 8 files changed, 55 insertions(+), 7 deletions(-)


base-commit: b0a652436b892eb9a036a031b33099dca036faaa
-- 
2.55.0

