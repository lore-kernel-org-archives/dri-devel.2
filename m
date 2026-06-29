Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DBBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4742D10E120;
	Mon, 29 Jun 2026 22:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JkL2oi+3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A42F10E120
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782773066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ev+eZIVZSyaCdYull75busCd4hGRRpJg1XtF6MPERrI=;
 b=JkL2oi+3HnxE17SltniMKaKxUua/D41RxtfNptcJ/ByJegMaaKubtWc3uRw3CJAIxxd818
 RYT5DnwY/5kN1wfIcMKo7f862h6RVghfcCbcLoYXcF+FudsTCJp3XlSiZ5pURxdJuvM5gB
 4Fm+191OfKMxRjCfQVeLB6SiN03207c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-npEv8sj_NhquFKVgPVF8VQ-1; Mon,
 29 Jun 2026 18:44:22 -0400
X-MC-Unique: npEv8sj_NhquFKVgPVF8VQ-1
X-Mimecast-MFC-AGG-ID: npEv8sj_NhquFKVgPVF8VQ_1782773060
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C15B319775F9; Mon, 29 Jun 2026 22:44:19 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.59])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53A573691B; Mon, 29 Jun 2026 22:44:17 +0000 (UTC)
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
Subject: [PATCH v2 0/4] drm/nouveau/gsp/r570: Fix runtime PM
Date: Mon, 29 Jun 2026 18:42:32 -0400
Message-ID: <20260629224350.2870201-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: x2qhSNKiRbxaHRQy2w0AS2S5e4rKmqSxdWWQ4Da-bTg_1782773060
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

Tested on a Lenovo P16 G1 (100 runtime PM cycles!), and RTX4000.

Lyude Paul (4):
  Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
  drm/nouveau/gsp/r570: Never enter Gcoff state
  drm/nouveau/gsp/r570: Set oldLevel correctly in GSP resume arguments
  drm/nouveau/gsp/r570: Add missing state flags to GSP resume arguments

 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c |  8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c  |  5 +++--
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h | 10 +++++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h        |  2 +-
 6 files changed, 19 insertions(+), 10 deletions(-)


base-commit: 8fca3d8dbebf8d960dad7b10db3cb4a61139454b
-- 
2.54.0

