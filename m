Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1AFC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B04010F49A;
	Thu, 13 Aug 2026 17:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XuuNiMtg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE06610F47D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786643075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HNL9MxOcgXtKn/CgeE8GD+Gg+Jz9lAaQVCw5G3gPN0M=;
 b=XuuNiMtgZfMRMJaT1w7VNfXDTReiHqXArDgtYpreBs1fPVnUdnjPVm/GUr6hOiKCuo6oa6
 cixAHsht1uLCST14aPmMQdDUHH6dJEmrMGpJI+tioQpDgo/wx3KqhI/CAv/tAB1EZw3yIt
 nsCYS0tXpzanOMLw72HJnFj6CS2W3I8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-OEzlf_-jP1avzbP05vUuTw-1; Thu,
 13 Aug 2026 13:44:26 -0400
X-MC-Unique: OEzlf_-jP1avzbP05vUuTw-1
X-Mimecast-MFC-AGG-ID: OEzlf_-jP1avzbP05vUuTw_1786643065
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EA381956071; Thu, 13 Aug 2026 17:44:24 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B9BF195608A; Thu, 13 Aug 2026 17:44:22 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v6 0/5] drm/nouveau: Enable atomic modesetting by default
Date: Thu, 13 Aug 2026 13:42:51 -0400
Message-ID: <20260813174416.1812656-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: zPM8Gfn41LYPOgqEpipLLs31oNigZWMCFp7wmtFog3M_1786643065
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

Nouveau is one of the very few modern hardware drivers in the kernel that
doesn't have atomic modesetting enabled by default, in part because when it
was originally written by Ben there wasn't much in the way of good atomic
modesetting clients to actually test things out with.

Nowadays however, atomic modesetting is very much the norm - and support in
userspace for non-atomic drivers is starting to bitrot a bit - leading to
its own set of issues. At the same time, many of those issues are fixed by
just turning on atomic in nouveau. Plus, I've been running nouveau with
atomic modesetting on by default for most of the machines I work on, and
I've already fixed quite a number of issues to the point where things seem
quite stable (excluding a single screen flashing bug on my desktop, which I
am not particularly convinced has anything to do with atomic modesetting).

This patch series enables atomic modesetting by default, at least for
NV50 and newer. NV04 is left unchanged, as atomic modesetting was never
implemented for it. This series also enforces leaving atomic modesetting
disabled on <NV50, and adds the value of nouveau.atomic to our kernel
debug output.

Previous version of this patch series:
	https://patchwork.freedesktop.org/series/171310/

Lyude Paul (5):
  drm/nouveau: Fix cleanup bug in nouveau_drm_device_new()
  drm/nouveau: Print the nouveau.atomic parameter in
    nouveau_display_options()
  drm/nouveau: Fix drm_driver struct/nouveau.atomic parameter handling
  drm/nouveau/kms: Only allow enabling atomic modesetting on nv50+
  drm/nouveau/kms/nv50-: Enable atomic modesetting by default

 drivers/gpu/drm/nouveau/nouveau_drm.c | 111 ++++++++++++++++----------
 1 file changed, 68 insertions(+), 43 deletions(-)


base-commit: 9b388fc3d0e63a4f5b022d326151e176e8d82e25
-- 
2.55.0

