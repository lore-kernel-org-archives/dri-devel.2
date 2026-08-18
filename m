Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83423C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D6510E089;
	Tue, 18 Aug 2026 23:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Arg1rwWT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7E410E089
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787097411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EBdI45sl5vzkzgSUGZ8nG97oSK40+7Mn/qyNVVY6zbs=;
 b=Arg1rwWTehRCxafwlLEdXFfpu/T8CBCH2JnRyHdLSld2JjrO8ekXEP5z6bX1rrSDAnWjUa
 papwHO+PVnPt6tHiiQ/QmSKAP14mve8OgMgjywl5no9EwkoqR8kD4trZkIhX1WmyfrIf6L
 FHimwDs5ORBSP3ZG8e2N3i2G2UEufRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-u_5p8ACBOiiltTiNlBIbAg-1; Tue,
 18 Aug 2026 19:56:46 -0400
X-MC-Unique: u_5p8ACBOiiltTiNlBIbAg-1
X-Mimecast-MFC-AGG-ID: u_5p8ACBOiiltTiNlBIbAg_1787097404
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A2B218007EA; Tue, 18 Aug 2026 23:56:43 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA2F4180049F; Tue, 18 Aug 2026 23:56:39 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
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
Subject: [PATCH 0/6] drm/nouveau/kms/nv50-: Obliterate nv_encoder->crtc
Date: Tue, 18 Aug 2026 19:48:42 -0400
Message-ID: <20260818235637.1738055-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: MRf9yZZldrg5UPQF_j1Bxsjr7UMAol-ZW9IHv-J8y00_1787097404
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

 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 83 ++++++++++++++++-------
 drivers/gpu/drm/nouveau/nouveau_encoder.h |  4 +-
 2 files changed, 60 insertions(+), 27 deletions(-)


base-commit: 0e118b936dc5904cf0d9859882a40c96057b083d
-- 
2.55.0

