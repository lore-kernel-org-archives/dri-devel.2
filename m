Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB9CC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A40C810F080;
	Thu, 30 Jul 2026 20:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N9e1H5wb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEEC810F093
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785443447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNTuaDjx3z1DUxuUacr72ReXO5T+NfTzTweEjVHjhKI=;
 b=N9e1H5wbaK9lXGq1CmEmBJjIBnyNH3BG28BU3/A1Hr3HYwjCtw2GoRseErVZDULb9+iqCn
 nAToR08w6V9HC2DN8RnvQSPt536Gq6ptfxXcO92YLSxwEviF3jPk8QmDyDk/7iwpGfBE69
 nLnobjjEH65KIiZHiphxuTt/qgy+DRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29--bNThpnNNzWO9-lF6nPqOg-1; Thu,
 30 Jul 2026 16:30:44 -0400
X-MC-Unique: -bNThpnNNzWO9-lF6nPqOg-1
X-Mimecast-MFC-AGG-ID: -bNThpnNNzWO9-lF6nPqOg_1785443443
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 116201800350; Thu, 30 Jul 2026 20:30:43 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 756EF423; Thu, 30 Jul 2026 20:30:41 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v3 5/5] drm/nouveau/kms/nv50-: Enable atomic modesetting by
 default
Date: Thu, 30 Jul 2026 16:28:08 -0400
Message-ID: <20260730203015.1572240-6-lyude@redhat.com>
In-Reply-To: <20260730203015.1572240-1-lyude@redhat.com>
References: <20260730203015.1572240-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: dcG_dfGwZtQKP-F4oUIondBTMlSvbtWHNhOjGnE-BVQ_1785443443
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

Now that we've protected against breaking things for chipsets where atomic
isn't supported (<nv50) - let's enable it by default on generations of
hardware that support it. We'll leave the module parameter around for the
time being, as turning it off may be helpful in the possibility that we hit
regressions.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 80fdedc27189f..b3b90d354b5ca 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -103,8 +103,9 @@ MODULE_PARM_DESC(modeset, "enable driver (default: auto, "
 int nouveau_modeset = -1;
 module_param_named(modeset, nouveau_modeset, int, 0400);
 
-MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: disabled)");
-static int nouveau_atomic = 0;
+MODULE_PARM_DESC(atomic, "Expose atomic ioctl (default: auto, "
+			 "0 = disabled, 1 = enabled)");
+static int nouveau_atomic = -1;
 module_param_named(atomic, nouveau_atomic, int, 0400);
 
 MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1)");
@@ -768,10 +769,10 @@ nouveau_drm_device_new(struct device *parent, struct nvkm_device *device)
 		goto err_device_del;
 	}
 
-	if (nouveau_atomic) {
+	if (nouveau_atomic != 0) {
 		if (drm->device.info.family >= NV_DEVICE_INFO_V0_TESLA)
 			drm->drm_driver.driver_features |= DRIVER_ATOMIC;
-		else
+		else if (nouveau_atomic == 1)
 			NV_WARN(drm, "Atomic modesetting not supported (needs nv50+)\n");
 	}
 
-- 
2.55.0

