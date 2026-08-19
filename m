Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA38FC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F003910EE5E;
	Wed, 19 Aug 2026 16:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XR61NnVw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AEA310EE52
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787155199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3Iz/4jWyINOcI8ZACwTPuDHgHiq9U8jasCe3dns6TY8=;
 b=XR61NnVwCPTprCHILwZZKuVqiAkU29hFKCvk6qNr6r0xxMru3PvrSVli72LV/z5Z5WIX2W
 GoO6/Sfd/DsSyJPxuYLhDzTB2QtQDNm9gcVHnC4VbRU6Eap+duvZrpK4a7unM5R7+iV6Uu
 IIFchDFM6FXIlZvch0yJagjBgREff3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-axtJ9z8wNKiQactqz3rnBQ-1; Wed,
 19 Aug 2026 11:59:46 -0400
X-MC-Unique: axtJ9z8wNKiQactqz3rnBQ-1
X-Mimecast-MFC-AGG-ID: axtJ9z8wNKiQactqz3rnBQ_1787155182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 189DD1955F1D; Wed, 19 Aug 2026 15:59:41 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD8EE1800346; Wed, 19 Aug 2026 15:59:36 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: "Dave Airlie" <airlied@redhat.com>,
 "Marek Czernohous" <marek@czernohous.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Ben Skeggs" <bskeggs@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Jani Nikula" <jani.nikula@intel.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/6] Obliterate nouveau_encoder->crtc
Date: Wed, 19 Aug 2026 11:43:47 -0400
Message-ID: <20260819155934.154125-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: EsEe68a1WaY0VPrFT9T_NNmGfB9HvvXK_dec60n57y4_1787155182
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

This is mostly a leftover artifact from the pre-atomic days, and while
we've been using it for a while now - it isn't great. Mostly because having
redundant state tracking for things atomic already keeps track of is pretty
much always error prone, as anyone working on nouveau who isn't already
very well versed in atomic modesetting isn't going to realize this isn't
the right way to see what CRTC is assigned to an encoder.

Also - this patch series does fix an actual bug (patches 1-3).

Previous version of this patch series:

	https://patchwork.freedesktop.org/series/172417/

Lyude Paul (6):
  drm/nouveau/kms/nv50-: Move DPCD backlight disable into its own
    function
  drm/nouveau/kms/nv50-: Add nv50_outp_get_old_crtc()
  drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in
    nv50_sor_atomic_disable()
  drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in
    nv50_disp_atomic_commit_core()
  drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc
  drm/nouveau/kms/nv50-: Obliterate nouveau_encoder->crtc

 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 78 ++++++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_encoder.h |  4 +-
 2 files changed, 56 insertions(+), 26 deletions(-)


base-commit: 0e118b936dc5904cf0d9859882a40c96057b083d
-- 
2.55.0

