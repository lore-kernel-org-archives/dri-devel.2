Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8049EC5DF6E
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13DD110F4B2;
	Thu, 13 Aug 2026 17:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dx++UnHv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4DD10F4A4
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786643079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a17nsuStiS7IsQuNSpzGOKtORn1O8u7fu4ZIRonx//w=;
 b=dx++UnHvpr5PhgKqksxEBWeo2xvcWV050pVwtNDIyh/5PVmhpR4K7HGpJo2yyitmG1jsyX
 GVl9Hv8/jjbY3b+q+T6XM+99siO5h9EJw85glEmoMXbbXMftkmuUUvOrLoM/S0IuXEOznb
 nS+VQ4qEL3LBVNkhafb9s+J4fFLi0+o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-se-oAB3mOCq_R7iWyeTgUA-1; Thu,
 13 Aug 2026 13:44:36 -0400
X-MC-Unique: se-oAB3mOCq_R7iWyeTgUA-1
X-Mimecast-MFC-AGG-ID: se-oAB3mOCq_R7iWyeTgUA_1786643074
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58AD019560B2; Thu, 13 Aug 2026 17:44:34 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C9D8195DF9A; Thu, 13 Aug 2026 17:44:32 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v6 4/5] drm/nouveau/kms: Only allow enabling atomic
 modesetting on nv50+
Date: Thu, 13 Aug 2026 13:42:55 -0400
Message-ID: <20260813174416.1812656-5-lyude@redhat.com>
In-Reply-To: <20260813174416.1812656-1-lyude@redhat.com>
References: <20260813174416.1812656-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: FRBa4XfmyfCwitevEI0n9yA31vaMYJ3a43Iz2iPoyJM_1786643074
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

Atomic modesetting support was never added for pre-nv50 chipsets, so make
sure we don't allow it to be forced on. Additionally, print a small warning
when it's not supported.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Check against info.family, not info.chipset
V6:
* Check against device->card_type so we can perform the check before
  setting up nvif

 drivers/gpu/drm/nouveau/nouveau_drm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index d021a3049be1a..82a8061e6d3e2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -739,10 +739,17 @@ nouveau_drm_device_new(struct device *parent, struct nvkm_device *device)
 	struct nouveau_drm *drm;
 	int ret;
 
-	if (nouveau_atomic)
-		driver = &driver_atomic_kms;
-	else
+	if (device->card_type >= NV_50) {
+		if (nouveau_atomic)
+			driver = &driver_atomic_kms;
+		else
+			driver = &driver_legacy_kms;
+	} else {
+		if (nouveau_atomic)
+			dev_warn(parent, "Atomic modesetting not supported (needs nv50+)\n");
+
 		driver = &driver_legacy_kms;
+	}
 
 	drm = kzalloc_obj(*drm);
 	if (!drm)
-- 
2.55.0

