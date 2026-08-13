Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0692C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06ED10F53F;
	Thu, 13 Aug 2026 20:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JesRnFOr";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8936010F530
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786653461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9JC+g0Maoo410UDO/ewvAWhlpWmYHQJSQQ2FmZGNDs=;
 b=JesRnFOrrWN7TQAaLK/CpXHeOtvkkKTsitPNlnsRQwoxGaVY4U6IvCVQBYfPntFspy9Q/s
 yKZh1M1kGlvAOoz2tQmGjJAn+XyslF40UIzm0pEyXB5wKBdq6r8oy7wWJpHNZmFK7c0GW2
 X2jDoUi8vcqAFdn04VhCksuvgdZeCGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-BLFkP55LMwq_BQPD2_IlLQ-1; Thu,
 13 Aug 2026 16:37:37 -0400
X-MC-Unique: BLFkP55LMwq_BQPD2_IlLQ-1
X-Mimecast-MFC-AGG-ID: BLFkP55LMwq_BQPD2_IlLQ_1786653456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B42321800365; Thu, 13 Aug 2026 20:37:35 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 364BA195DF9A; Thu, 13 Aug 2026 20:37:34 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Simona Vetter" <simona@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v7 2/5] drm/nouveau: Print the nouveau.atomic parameter in
 nouveau_display_options()
Date: Thu, 13 Aug 2026 16:27:06 -0400
Message-ID: <20260813202833.2051778-3-lyude@redhat.com>
In-Reply-To: <20260813202833.2051778-1-lyude@redhat.com>
References: <20260813202833.2051778-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: BS8nQUGCkLQeSj6r26vKorZkHLSclaUz9oNpb6lGJzk_1786653456
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

