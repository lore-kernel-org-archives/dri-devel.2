Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C33C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BDC10E430;
	Mon, 27 Jul 2026 17:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DJ5OEu4k";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6860510E430
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785174810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lcVPYQIeblJtEP+34yE/x7AhxVwpjV45NCnPDgJycms=;
 b=DJ5OEu4ki8PFYt6tga9JLVwRFwFaC4iKMqQslZO0N2PAN+1gV/mxn5WqTlaZWSdXkiqP1l
 rHW6LKBZaFum5Kuz2DoSUgJWFCtV0la/nGQAiVLbR6nN2z9XOnr/sNbYoOrOAc79ZpA3kj
 yI0qLDb/7CEMN/u8ajjrOg0jhfTtNbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-G1hfIIenPT2FTAPYIrG6qg-1; Mon,
 27 Jul 2026 13:53:25 -0400
X-MC-Unique: G1hfIIenPT2FTAPYIrG6qg-1
X-Mimecast-MFC-AGG-ID: G1hfIIenPT2FTAPYIrG6qg_1785174803
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FE0919775FE; Mon, 27 Jul 2026 17:53:21 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.65.215])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F04541955F7B; Mon, 27 Jul 2026 17:53:17 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
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
Subject: [PATCH v4 0/3] drm/nouveau: GSP runtime PM fixes
Date: Mon, 27 Jul 2026 13:47:41 -0400
Message-ID: <20260727175246.642071-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: P9AvcOfXsfTKanST3M5bZZsIh6aYyOT6JHRbysprtQE_1785174803
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

Runtime suspend/resume has been notoriously flakey since we started
using the R570 GSP firmware, and possibly was also flakey for some time
when we introduced GSP support initially.

These fixes get runtime PM to be dramatically more stable then it was
before. Unfortunately even with this patch series, there are still some
remaining issues that need to be fixed. These likely stem from the
currently different code path that we need to take with these fixes in
order to get suspend/resume working.

While we're making progress in understanding what exactly we're doing
differently from OpenRM that makes this the case, it will likely take us
a while before we actually have things working well enough to copy what
OpenRM does. Taking precisely the same path that OpenRM takes however,
will require some additional work - and at the very least these fixes do
appear to get suspend/resume and runtime PM working the vast majority of
the time.

Thanks for nvidia for providing context into what all of these various
flags and settings do!

Previous version of this patch series:

	https://patchwork.freedesktop.org/series/169457/

Lyude Paul (3):
  Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"
  drm/nouveau/gsp/r570: Set GcOff = 1 in fbsr
  drm/nouveau/gsp/r570: Enable S/R Display workaround in GSP

 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c     | 2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c    | 8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h           | 2 +-
 6 files changed, 17 insertions(+), 8 deletions(-)


base-commit: df0311845915442ab75d03ee89fb443b444c1370
-- 
2.55.0

