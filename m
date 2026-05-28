Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB42CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B63A10F5CF;
	Thu, 28 May 2026 19:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FGAIB3Is";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A46A10F5D0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 19:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779996542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=un0qT9UfflvdsJEC1BMIIMI+/6gVV+1+FOlpjGHGdnQ=;
 b=FGAIB3IsOvgZmH3djazdeIG5PP3s6cJI6cIIjSrHOQB1PMGn60UidaNwk0kOQMX7ZPrdr5
 zag+WEIBWJnwQGaGIyvaeTi/w74nstMYLl/g/+b9gAiZa5NHbS1U1tm3zZn4poeX0tqYhM
 qgcGUKibOx/4KNyGjF0pjgfN+xLKsxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-ZH_aRNPMMj-XE2tEH8i_UA-1; Thu,
 28 May 2026 15:28:58 -0400
X-MC-Unique: ZH_aRNPMMj-XE2tEH8i_UA-1
X-Mimecast-MFC-AGG-ID: ZH_aRNPMMj-XE2tEH8i_UA_1779996535
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD80F195609F; Thu, 28 May 2026 19:28:53 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.248])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ED2019560AD; Thu, 28 May 2026 19:28:50 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, Timur Tabi <ttabi@nvidia.com>,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: "Dave Airlie" <airlied@redhat.com>,
 "Qianfeng Rong" <rongqianfeng@vivo.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Danilo Krummrich" <dakr@kernel.org>, "Zhi Wang" <zhiw@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/5] Revert cleanups for IS_ERR_OR_NULL() usage
Date: Thu, 28 May 2026 15:27:14 -0400
Message-ID: <20260528192847.4077458-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: R3Utr2R9YfrRmMmPkLT9qfKCPP8PLDPCE146NzgLIGs_1779996535
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

Turns out there's many good reasons for this!

Lyude Paul (5):
  Revert "nouveau/gsp/rm: cleanup remaining IS_ERR_OR_NULL usage"
  Revert "nouveau/gsp/rm: cleanup IS_ERR_OR_NULL in core implementation"
  Revert "nouveau/gsp/rm: cleanup WARN_ON(IS_ERR_OR_NULL)"
  Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rpc_rd"
  Revert "nouveau/gsp: cleanup IS_ERR_OR_NULL in rm_alloc functions"

 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h      |  8 ++++----
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c    |  4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c  | 10 +++++-----
 5 files changed, 13 insertions(+), 13 deletions(-)


base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
-- 
2.54.0

