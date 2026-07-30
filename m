Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F5C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6084D10F031;
	Thu, 30 Jul 2026 20:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LptW1p26";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AC910E121
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785443861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHo1fNYCfA2pUUad8d3A7yhR0sK0qRAEvCx1qYV41lo=;
 b=LptW1p26Ps5ND7Fp2H/6TXz34LrDAkb4eHfVEP7Utge2cghkduGJ08DhYO1zLY+EEFsnfm
 6tafqaS174ZDU1qxDdGwrEEIbRFWwiaejE7+ws+Mhs5WVQupppz17sUVGGloHzQIZRf8+Q
 k4utWOzFiF9q4BOskShHGQ0X29O10mc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-hBIIakE8NRWWlgVShU2ANA-1; Thu,
 30 Jul 2026 16:37:38 -0400
X-MC-Unique: hBIIakE8NRWWlgVShU2ANA-1
X-Mimecast-MFC-AGG-ID: hBIIakE8NRWWlgVShU2ANA_1785443856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 705B019560A1; Thu, 30 Jul 2026 20:37:36 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F25B71956089; Thu, 30 Jul 2026 20:37:34 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v4 4/5] drm/nouveau/kms: Only allow enabling atomic
 modesetting on nv50+
Date: Thu, 30 Jul 2026 16:36:12 -0400
Message-ID: <20260730203723.1649433-5-lyude@redhat.com>
In-Reply-To: <20260730203723.1649433-1-lyude@redhat.com>
References: <20260730203723.1649433-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: __vhIfODpuHMgxQ8h6rYMGJcMmF_irX0xwKvRCoS1r8_1785443856
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

 drivers/gpu/drm/nouveau/nouveau_drm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 9cd12ebc7e449..bfe9d6fe450a5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -769,8 +769,12 @@ nouveau_drm_device_new(struct device *parent, struct nvkm_device *device)
 		goto done;
 	}
 
-	if (nouveau_atomic)
-		drm->drm_driver.driver_features |= DRIVER_ATOMIC;
+	if (nouveau_atomic) {
+		if (drm->device.info.family >= NV_DEVICE_INFO_V0_TESLA)
+			drm->drm_driver.driver_features |= DRIVER_ATOMIC;
+		else
+			NV_WARN(drm, "Atomic modesetting not supported (needs nv50+)\n");
+	}
 
 	ret = nvif_device_map(&drm->device);
 	if (ret) {
-- 
2.55.0

