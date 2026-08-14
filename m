Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22158C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A74E10E1BB;
	Fri, 14 Aug 2026 19:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fx3rxH2G";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700A10E1BB
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786736779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUl4OiIK4x+8eiq0MCPzDAWyD8Ge8fli2WbAll1g3Fc=;
 b=fx3rxH2Gs4AxiCf44UKjxn+XUWinSAwJlGN+Dda/zLia4fsnLC4Pr0aC0Jr9NQW4mdxh4N
 yPdqu+38cNOsYULYYKjKlSIX6NcNAbIrTaiKf6S2vnSfyp4+D8WwtOquyx6fXaL0hAj315
 V6mGbRTMApJCTwocWqdGnR+VnbmTkaM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-X4ulqH2_Oc-JPGz7V3G1sA-1; Fri,
 14 Aug 2026 15:46:06 -0400
X-MC-Unique: X4ulqH2_Oc-JPGz7V3G1sA-1
X-Mimecast-MFC-AGG-ID: X4ulqH2_Oc-JPGz7V3G1sA_1786736764
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20A721956089; Fri, 14 Aug 2026 19:46:04 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9981030001A2; Fri, 14 Aug 2026 19:46:01 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, "Timur Tabi" <ttabi@nvidia.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Ben Skeggs" <bskeggs@nvidia.com>, "Kees Cook" <kees@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Mel Henning" <mhenning@darkrefraction.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 2/4] drm/nouveau/gsp/r570: Set GcOff = 0 in fbsr
Date: Fri, 14 Aug 2026 15:43:49 -0400
Message-ID: <20260814194542.781955-3-lyude@redhat.com>
In-Reply-To: <20260814194542.781955-1-lyude@redhat.com>
References: <20260814194542.781955-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: eII6JTC0JJFuus4KLhiid-MV1g2yb3tmDcHbFKbmKv4_1786736764
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

Previously, it looked as if we were able to fix suspend/resume on some
desktops by setting Gcoff based on whether or not we were entering runtime
PM. This was a mistake though - the only time suspend/resume would end up
actually working was if Gcoff = 0.

It seems like it's likely the main reason for this is the FBSR GcOff
argument actually controls GSP's behavior with regards to which buffers it
decides to save across suspend/resume. When GcOff = 1, RM reserved regions
are saved unless they are marked as LOST_ON_SUSPEND, and RM channel-context
and kernel-client buffers are also saved -including- when they are
LOST_ON_SUSPEND. This means with GcOff = 1, we end up having GSP save and
restore buffers that actually need to be reinitialized on resume - causing
the failures we're setting.

Thanks to John Hubbard from Nvidia for providing some background on what
these options do in the GSP firmware do!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+

---
V5:
* Fix commit title, GcOff should be 0 not 1

 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
index 2945d5b4e5707..af5aa5065c3dd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
@@ -81,7 +81,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *sgt, u64 size)
 	ctrl->hClient = gsp->internal.client.object.handle;
 	ctrl->hSysMem = memlist.handle;
 	ctrl->sysmemAddrOfSuspendResumeData = gsp->sr.meta.addr;
-	ctrl->bEnteringGcoffState = 1;
+	ctrl->bEnteringGcoffState = 0;
 
 	ret = nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 	if (ret)
-- 
2.55.0

