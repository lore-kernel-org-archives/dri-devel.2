Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A109C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC6910F6AE;
	Fri, 14 Aug 2026 19:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AJ5txdR3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001CF10E1BB
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786736781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXRw5HgFBqtMjibe0Tg/q0W0/UG6cgg62YzMlj2W/cQ=;
 b=AJ5txdR3PifUsILAldYJOzugYvNUk77OpEQCr9qaCKvAoqsysTZVq3vXvFiSpid2+LsYSF
 BhGH37iq/D5FDYEhBaP//v553NgXgx+ow6shDnoqw7uMKGCQe0jV1LDGu/xEPqi5uRxq8J
 8tN+XJM0PHZiEgSoRiVP9YSl10vTSfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-vaXtKV4FOU-vVFxX8yzNtg-1; Fri,
 14 Aug 2026 15:46:15 -0400
X-MC-Unique: vaXtKV4FOU-vVFxX8yzNtg-1
X-Mimecast-MFC-AGG-ID: vaXtKV4FOU-vVFxX8yzNtg_1786736771
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 360F518001DE; Fri, 14 Aug 2026 19:46:11 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.233])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C11430001A2; Fri, 14 Aug 2026 19:46:08 +0000 (UTC)
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
Subject: [PATCH v5 3/4] drm/nouveau/gsp/r570: Enable S/R Display workaround in
 GSP
Date: Fri, 14 Aug 2026 15:43:50 -0400
Message-ID: <20260814194542.781955-4-lyude@redhat.com>
In-Reply-To: <20260814194542.781955-1-lyude@redhat.com>
References: <20260814194542.781955-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sr5iqj45G__XAKY0NAw9QQnPAqmi4646KVV6lgIQ52U_1786736771
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

There's two flags that we've never been setting when asking GSP to suspend
the GPU, which OpenRM does set:

  GPU_STATE_FLAGS_PRESERVING
  GPU_STATE_FLAGS_PM_TRANSITION

These flags aren't -supposed- to do much in GSP, they're mostly used by
OpenRM itself for state tracking. The only thing they do from GSP's side is
control whether or not a single display related workaround is applied
during suspend.

But as it turns out, that single workaround is actually quite crucial for
getting runtime PM working with nouveau - and without it set we end up
seeing a lot more failures with runtime PM resume. So, let's start setting
it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 53dac0623853 ("drm/nouveau/gsp: add support for 570.144")
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c     | 3 ++-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h    | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba9..3e391646d8f7d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -198,7 +198,8 @@ r570_gsp_set_rmargs(struct nvkm_gsp *gsp, bool resume)
 		args->srInitArguments.bInPMTransition = 0;
 	} else {
 		args->srInitArguments.oldLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3;
-		args->srInitArguments.flags = 0;
+		args->srInitArguments.flags =
+			GPU_STATE_FLAGS_PRESERVING | GPU_STATE_FLAGS_PM_TRANSITION;
 		args->srInitArguments.bInPMTransition = 1;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index b6075021e74f5..c458569af9d72 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -523,6 +523,14 @@ typedef struct
 
 #define NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3            (0x00000003U)
 
+#define GPU_STATE_FLAGS_PRESERVING         BIT(0)  // GPU state is preserved
+#define GPU_STATE_FLAGS_VGA_TRANSITION     BIT(1)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_TRANSITION      BIT(2)   // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_PM_SUSPEND         BIT(3)
+#define GPU_STATE_FLAGS_PM_HIBERNATE       BIT(4)
+#define GPU_STATE_FLAGS_GC6_TRANSITION     BIT(5)  // To be used with GPU_STATE_FLAGS_PRESERVING.
+#define GPU_STATE_FLAGS_FAST_UNLOAD        BIT(6)  // Used during windows restart, skips stateDestroy steps
+
 typedef struct
 {
     // Magic for verification by secure ucode
-- 
2.55.0

