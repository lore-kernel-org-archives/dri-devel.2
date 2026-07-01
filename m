Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9C0C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6856510F0B0;
	Wed,  1 Jul 2026 18:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UZWu8X0H";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8C310F0B2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782930547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a7e1k4RF0Xm/tkfPnX0cO2BLntyNgnQLBQqB6vQqdO0=;
 b=UZWu8X0HRlD2tw2mcctrB6Y2vS6CTkJ6+4YrGmB07o+14TQ5WyGVY0EzL9saTQly/8/aYb
 T7/EKTm8kTPzl9J28lDwvaHRjbW4LCZP4fX9XtHR2wCwdqPpZub0nxy03brOO9yX77PiTN
 jnM0injCI0bhVlzHRVn5EEQkcc1a1Ks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-ZdBUyLAoMcSrEgAVTtFZ_Q-1; Wed,
 01 Jul 2026 14:29:03 -0400
X-MC-Unique: ZdBUyLAoMcSrEgAVTtFZ_Q-1
X-Mimecast-MFC-AGG-ID: ZdBUyLAoMcSrEgAVTtFZ_Q_1782930541
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63CCE193336E; Wed,  1 Jul 2026 18:29:01 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.89.127])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E1B01800592; Wed,  1 Jul 2026 18:28:58 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Ben Skeggs" <bskeggs@nvidia.com>, "Kees Cook" <kees@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 0/3] drm/nouveau/gsp/r570: Fix runtime PM
Date: Wed,  1 Jul 2026 14:17:32 -0400
Message-ID: <20260701182857.190713-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: EsF9ibhofqWL1kDubZ4SldHMlsVHwAVU-g6PNmXTZcA_1782930541
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

Runtime PM has been kind of unreliable with GSP for a while. It works
well enough to shut the GPU off and turn it back on, but more often then
not it ends up leaving the GPU in a broken state on resume - which makes
it impossible to really do anything else with it.

Recently however, I discovered that it's been failing much harder on
some ampere systems. This lead me down a rabbit hole that lead me to
figure out one of our previous fixes for runtime PM wasn't correct.
After fixing that and combining it with some fixes we had tried in the
past without success, I finally managed to get nouveau to handle runtime
PM with the GSP perfectly. These are those fixes.

Patch-series wide changes since V2:
* Drop the patch for switching oldLevel from LEVEL_3 to LEVEL_4. If I'm
  understanding OpenRM correctly, LEVEL_3 corresponds to PCI D3 power
  state and is intended for use on systems with ACPI. To be clear, I
  mean ACPI support generally - it doesn't appear to specifically refer to
  laptop-specific ACPI handles like _DSM or the like.

  In an unexpected twist, it appears LEVEL_4 actually corresponds to APM
  (as in "Advanced Power Management", e.g. pre-ACPI)! After re-testing
  my local setups I wasn't able to find any significant behavior
  difference between LEVEL_3 and LEVEL_4, so let's be conservative and
  leave this be for now.

  It still may be worth looking into the future why I've seen OpenRM
  specifically call-out APM suspend being requested in debug builds
  instead of S3. I wouldn't expect APM to actually work with modern
  Nvidia hardware, but it's always possible there's some other reason
  they still use this

Tested on a Lenovo P16 G1 (100 runtime PM cycles!), and RTX4000.

Previous version of the patch series:

  https://patchwork.freedesktop.org/series/169457/

Lyude Paul (3):
  Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
  drm/nouveau/gsp/r570: Never enter Gcoff state
  drm/nouveau/gsp/r570: Add missing state flags to GSP resume arguments

 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c     | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h           | 2 +-
 6 files changed, 17 insertions(+), 8 deletions(-)


base-commit: cff96362794a5c1f3adb013b4a46c7233149a629
-- 
2.54.0

