Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09039C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6115610EA6D;
	Mon, 29 Jun 2026 22:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Vb/X6F5z";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169D610EA81
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782773081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zw+yxHJkPLDJzuuhT36OrRKDnTGX+7WWEu0wvYE6r6k=;
 b=Vb/X6F5zmoG74M2Pr/yNSB1p2Ac2puI17mX7anlzsZ13zmi/MndpZcaRuhl0Wmugb3zlCg
 FeJvFNB7MpneWHtIv8eq5yO7nfbOxTKzfyneAbu0c+7/GikqDbnGLr+Ff0KcDYkNxor9RO
 npzY6QDrLWkAPjnWbiCvG5nWtG54TeE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-EHJCy_UwPQWrQd0ZkjdVWA-1; Mon,
 29 Jun 2026 18:44:36 -0400
X-MC-Unique: EHJCy_UwPQWrQd0ZkjdVWA-1
X-Mimecast-MFC-AGG-ID: EHJCy_UwPQWrQd0ZkjdVWA_1782773074
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 516A619344BA; Mon, 29 Jun 2026 22:44:34 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.59])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14E6E36918; Mon, 29 Jun 2026 22:44:31 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
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
Subject: [PATCH v2 2/4] drm/nouveau/gsp/r570: Never enter Gcoff state
Date: Mon, 29 Jun 2026 18:42:34 -0400
Message-ID: <20260629224350.2870201-3-lyude@redhat.com>
In-Reply-To: <20260629224350.2870201-1-lyude@redhat.com>
References: <20260629224350.2870201-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: zqMQF6Bort7rM5p5e4DlfPvjxivfnbH0DfJezgx2sm0_1782773074
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

It turns out that the only reason our previous fixes looked like they
worked for this was because we would occasionally set the Gcoff state to 0
in the normal S3 path, which fixed suspend/resume on desktops - but not on
machines using runtime suspend.

The proper fix is to just never set this flag. Our current guess for the
reasoning behind this is that Gcoff likely coincides with GC6, and not
literally power off.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
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
2.54.0

