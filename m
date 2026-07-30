Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF1C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB8C10F0A0;
	Thu, 30 Jul 2026 20:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JvVHsUVq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E13210F093
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785444379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzeCgaMnOsG+RV68upoUHtAiXUIkruVdtD9NVtgw7D4=;
 b=JvVHsUVqEpEqSWOgaNkweI/Ci2LPf8ZPYERczazUbIG1guNmAlhjZgEOtrE4ZNZTOqJhIF
 mJC9hq60JkFftmkx8w6vQ42XnMJXgisAwR7IB7uxgHZJPNJ+slDM8rHWfh7Zro7dPv3XE5
 LnFuJWeb0NZgVHU3C0p5BUbtZ4GbeXU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-zDpfwHC_MfOPTyF3KuY7fg-1; Thu,
 30 Jul 2026 16:46:16 -0400
X-MC-Unique: zDpfwHC_MfOPTyF3KuY7fg-1
X-Mimecast-MFC-AGG-ID: zDpfwHC_MfOPTyF3KuY7fg_1785444375
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10462195608A; Thu, 30 Jul 2026 20:46:15 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.88.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84E091956089; Thu, 30 Jul 2026 20:46:13 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 2/5] drm/nouveau: Print the nouveau.atomic parameter in
 nouveau_display_options()
Date: Thu, 30 Jul 2026 16:45:07 -0400
Message-ID: <20260730204604.1729505-3-lyude@redhat.com>
In-Reply-To: <20260730204604.1729505-1-lyude@redhat.com>
References: <20260730204604.1729505-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: OhDwObmQk_Q6Xf8cdjYh7XVVwbEjzb42E0OzKejv2ME_1785444375
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

Seems like we never remembered to start printing the value for this, so
let's start to aid in troubleshooting in case we run into any issues with
atomic.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index a348115518ec4..451009adee0de 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1417,6 +1417,7 @@ static void nouveau_display_options(void)
 	DRM_DEBUG_DRIVER("... debug        : %s\n", nouveau_debug);
 	DRM_DEBUG_DRIVER("... noaccel      : %d\n", nouveau_noaccel);
 	DRM_DEBUG_DRIVER("... modeset      : %d\n", nouveau_modeset);
+	DRM_DEBUG_DRIVER("... atomic       : %d\n", nouveau_atomic);
 	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
 	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
 	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
-- 
2.55.0

